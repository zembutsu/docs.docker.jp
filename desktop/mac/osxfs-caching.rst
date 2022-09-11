.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/osxfs-caching/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/osxfs-caching.md
.. check date: 2020/06/10
.. Commits on Apr 23, 2020 087e391397a825aa21d9f81755d4b201ff5c4c06
.. -----------------------------------------------------------------------------

.. Performance tuning for volume mounts (shared filesystems)

.. _performance-tuning-for-volume-mounts

================================================================================
ボリューム・マウント（共有ファイルシステム）のためのパフォーマンス・チューニング
================================================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker 17.04 CE Edge adds support for two new flags to the docker run -v, --volume option, cached and delegated, that can significantly improve the performance of mounted volume access on Docker Desktop for Mac. These options begin to solve some of the challenges discussed in Performance issues, solutions, and roadmap.

`Docker 17.03 CE Edge <https://github.com/docker/docker.github.io/blob/v17.03/edge/index.md#docker-ce-edge-new-features>`_ は docker run :code:`-v` 、 :code:`--volume` オプションに、新しい２つのフラグ :code:`cached` と :code:`delegated`  のサポートを追加しました。これは Docker Desktop for Mac がマウントしたボリュームに対し、アクセス性能を著しく改善する可能性があります。これらオプションは :ref:`osxfs-performance-issues-solutions-and-roadmap` における課題の議論と同じくして始まったものです。

..    Tip: Release notes for Docker CE Edge 17.04 are here, and the associated pull request for the additional docker run -v flags is here.

.. tip::

   Docker CE Edge 17.04 のリリースノートは `こちら <https://github.com/moby/moby/releases/tag/v17.04.0-ce>`_ です。それと、 :code:`docker run -v` フラグの追加に関連するプルリクエストは `こちら <https://github.com/moby/moby/pull/31047>`__ です。


.. The following topics describe the challenges of bind-mounted volumes on osxfs, and the caching options provided to optimize performance.

以下のトピックで説明するのは、 `osxfs` 上のバインド・マウント・ボリュームの変更に対するものと、パフォーマンス最適化をもたらすオプションについてです。

.. This blog post on Docker on Mac Performance gives a nice, quick summary.

こちらの`[Docker on Mac Performance <https://stories.amazee.io/docker-on-mac-performance-docker-machine-vs-docker-for-mac-4c64c0afdf99>`_ ブログ記事に、簡単な要約があります。

.. For information on how to configure these options in a Compose file, see Caching options for volume mounts the Docker Compose topics.

Compose ファイル中における各オプション調整に関する情報は、Docker Compose トピックにある :ref:`Caching options for volume mounts <caching-options-for-volume-mounts-docker-desktop-for-mac>` をご覧ください。

.. Performance implications of host-container file system consistency

.. _performance-implicaitons-of-host-container-file-system-consistency:

ホストコンテナのファイルシステム一貫性とパフォーマンスの密接な関係
======================================================================

.. With Docker distributions now available for an increasing number of platforms, including macOS and Windows, generalizing mount semantics during container run is a necessity to enable workload optimizations.

macOS や Windows を含む、数々のプラットフォーム上で Docker が利用できるようになり、コンテナ実行時にマウントに関連するワークロード（作業負荷）を最適化する必要性が一般化しました。

.. The current implementations of mounts on Linux provide a consistent view of a host directory tree inside a container: reads and writes performed either on the host or in the container are immediately reflected in the other environment, and file system events (inotify, FSEvents) are consistently propagated in both directions.

現時点で Linux 上のマウントに関する実装とは、コンテナ内にホスト側と一貫性したディレクトリツリーを提供するものです。つまり、読み書き処理とは、ホスト上だけでなくコンテナ内でも行われますので、他の環境の影響を直ちに受けます。また、ファイルシステムイベント（ :code:`inotify` 、 :code:`FSEvents` ）は、両方（ホスト上およびコンテナ）のディレクトリで直ちに反映します。

.. On Linux, these guarantees carry no overhead, since the underlying VFS is shared directly between host and container. However, on macOS (and other non-Linux platforms) there are significant overheads to guaranteeing perfect consistency, since messages describing file system actions must be passed synchronously between container and host. The current implementation is sufficiently efficient for most tasks, but with certain types of workloads the overhead of maintaining perfect consistency can result in significantly worse performance than a native (non-Docker) environment. For example,

Linux 上ではホストとコンテナ間で VFS を基盤に共有しているので、オーバーヘッドのない反映を保証します。しかしながら、 macOS （および他の Linux 以外のプラットフォーム）では、完全な一貫性を保つために著しいオーバーヘッドがあります。これは message describing  ファイルシステムが動作するために、ホストとコンテナ間を同期的に通過（passed synchronously）する必要があるためです。現時点の実装は多くのタスクに対して十分なものですが、ある種のワークロードでは完全な一貫性を確保するためにオーバーヘッドが発生し、ネイティブな環境（Docker 以外）でなければ、著しいパフォーマンス悪化をもたらします。たとえば、

..    running go list ./... in the bind-mounted docker/docker source tree takes around 26 seconds

*  :code:`docker/docker` ソースツリーに :code:`go list ./...` をバインド・マウントして実行すると、約 26 秒かかる

..    writing 100MB in 1k blocks into a bind-mounted directory takes around 23 seconds

* バインド・マウントしたディレクトリに、100MB を 1k ブロックで書き込むと、約 23 秒かかる

..    running ember build on a freshly created (empty) application involves around 70000 sequential syscalls, each of which translates into a request and response passed between container and host.

* 新しく作成した（空っぽの）アプリケーションで `ember build` を実行すると、コンテナとホスト間でリクエストと応答があるたびに、連続して 70000 syscall を引き起こす

.. Optimizations to reduce latency throughout the stack have brought significant improvements to these workloads, and a few further optimization opportunities remain. However, even when latency is minimized, the constraints of maintaining consistency mean that these workloads remain unacceptably slow for some use cases.

スタックの遅延（latench）を減らすための最適化により、これらのワークロードを著しく改善しました。そして、さらにいくつかの最適化も施しています。しかしながら、それでも一貫性を維持するための制約によって、遅延は最小限あります。つまり、ある種の使い方によっては受け入れがたいワークロードの遅さがあるでしょう。

.. Tuning with consistent, cached, and delegated configurations

.. _tuning-with-consistent

consistent、cached、delegated 設定のチューニング
==================================================

.. Fortunately, in many cases where the performance degradation is most severe, perfect consistency between container and host is unnecessary. In particular, in many cases there is no need for writes performed in a container to be immediately reflected on the host. For example, while interactive development requires that writes to a bind-mounted directory on the host immediately generate file system events within a container, there is no need for writes to build artifacts within the container to be immediately reflected on the host file system. Distinguishing between these two cases makes it possible to significantly improve performance.

**幸いにも、多くの場合においてパフォーマンス劣化が最も深刻な問題であり、また、コンテナとホスト間における一貫性が完全である必要はありません** 。特に多くのケースでは、コンテナ内に書き込んだファイルを、即時ホスト上に反映する必要がありません。たとえば、双方向（インタラクティブ）の開発を行っていると、コンテナ内でのファイルシステムイベントの発生が、ホスト上のバインド・マウントしたディレクトリに書き込む必要がある場合、コンテナ内で構築した成果物（build artifacts）を即座にホスト上のファイルシステムに反映する必要はありません。これら特徴的な２つのケースでは、著しいパフォーマンス改善が可能です。

.. There are three broad scenarios to consider, based on which you can dial in the level of consistency you need. In each case, the container has an internally-consistent view of bind-mounted directories, but in two cases temporary discrepancies are allowed between container and host.

ここでは必要となる一貫性のレベルに応じ、３つのシナリオを検討しました。各ケースは、いずれもコンテナ内にバインド・マウントしたディレクトリを持っていますが、２つのケースではコンテナとホスト間で一時的な矛盾の発生を許容しています。

..    consistent: perfect consistency (host and container have an identical view of the mount at all times)

* :code:`consistent` ：完全な一貫性（常にホストとコンテナが完全に同じ表示）

..    cached: the host’s view is authoritative (permit delays before updates on the host appear in the container)

* :code:`cached` ：ホストの表示が信頼できる（ホスト上の更新がコンテナ上に反映するまで、遅延が発生するのを許容）

..    delegated: the container’s view is authoritative (permit delays before updates on the container appear in the host)

* :code:`delegated` ：コンテナの表示が信頼できる（コンテナ上の更新がホスト上に反映するまで、遅延が発生するのを許容）


.. Examples

.. _osxfs-caching-examples:

例
==================================================

.. Each of these configurations (consistent, cached, delegated) can be specified as a suffix to the -v option of docker run. For example, to bind-mount /Users/yallop/project in a container under the path /project, you might run the following command:

これら各設定（ :code:`consistent` 、 :code:`cached` 、 :code:`delegated` ）は :code:`docker run` の :code:`-v` オプションで指定できます。たとえば、 :code:`/Users/yallop/project` をコンテナ内の :code:`/project`  パス以下にバインド・マウントするとき、次のようなコマンドを実行します。

.. code-block:: bash

   docker run -v /Users/yallop/project:/project:cached alpine command

.. The caching configuration can be varied independently for each bind mount, so you can mount each directory in a different mode:

キャッシュ設定はバインド・マウントごとに独立しているため、マウントするディレクトリごとに異なるモードでマウントできます。

.. code-block:: bash

   docker run -v /Users/yallop/project:/project:cached \
    -v /host/another-path:/mount/another-point:consistent
    alpine command



.. Semantics

.. _osxfs-caching-semantics:

挙動の解説
==================================================

.. The semantics of each configuration is described as a set of guarantees relating to the observable effects of file system operations. In this specification, “host” refers to the file system of the user’s Docker client.

以下にある各設定で説明が保証しているのは、ファイルシステム操作が効率的になるかどうかに関連しています。ここでは前提として、 *host* が指し示すのは、ユーザの Docker クライアント上にあるファイルシステムです。

.. delegated

.. _osxfs-caching-delegated:

delegated
------------------------------

.. The delegated configuration provides the weakest set of guarantees. For directories mounted with delegated the container’s view of the file system is authoritative, and writes performed by containers may not be immediately reflected on the host file system. In situations such as NFS asynchronous mode, if a running container with a delegated bind mount crashes, then writes may be lost.

:code:`delegated`  設定では、一連の（一貫性に対する）保証が最も弱いものです。 :code:`delegated`  でディレクトリをマウントすると、コンテナのファイルシステム上の表示が信頼できるものとなり、コンテナ内での書き込み処理が、ホスト上のファイルシステムに即時反映しない場合があります。NFS非同期モードのような状況であれば、もしも :code:`delegated` バインドマウントしたコンテナがクラッシュすると、書き込みが失われる可能性があります。

.. However, by relinquishing consistency, delegated mounts offer significantly better performance than the other configurations. Where the data written is ephemeral or readily reproducible, such as from scratch space or build artifacts, delegated may be the right choice.

しかしながら、一貫性の放棄により、 :code:`delegated`  マウントは他の設定に比べて著しいパフォーマンスをもたらします。空っぽのスペースやビルド成果物のような、データの書き込みが一時的（ephemeral）または直ぐに再生成可能であれば、 :code:`delegated` は正しい選択になるでしょう。

.. A delegated mount offers the following guarantees, which are presented as constraints on the container run-time:

:code:`delegated` マウントを担保するため、コンテナ実行中に以下の制約があります。

..    If the implementation offers file system events, the container state as it relates to a specific event must reflect the host file system state at the time the event was generated if no container modifications pertain to related file system state.

1. もしもファイルシステムイベントに通知する実装であれば、イベントが生成されたとき、関連するファイルシステム状態に関連するコンテナの変更がなければ、コンテナの状態に関連する特定のイベントは、ホストファイルシステム状態にその時点で反映する **必要があります** 。

..    If flush or sync operations are performed, relevant data must be written back to the host file system.Between flush or sync operations containers may cache data written, metadata modifications, and directory structure changes.

2. flush や sync 処理が行われると、関連するデータはホストファイルシステム上に反映（write back）する **必要があります** 。flush から sync 処理をするまで、コンテナは データの書き込み、メタデータの変更、ディレクトリ階層の変更をキャッシュする **可能性があります** 。

..    All containers hosted by the same runtime must share a consistent cache of the mount.

3. 同じランタイムによってホストされている全てのコンテナは、マウントしているキャッシュの一貫性を共有する **必要があります** 。

..    When any container sharing a delegated mount terminates, changes to the mount must be written back to the host file system. If this writeback fails, the container’s execution must fail via exit code and/or Docker event channels.

4. :code:`delegated` マウントで共有しているコンテナが終了すると、マウントに対する変更はホストファイルシステム上に反映する **必要があります** 。反映が失敗すると、コンテナの処理が失敗 **しなくてはならず** 、終了コードや Docker event channel で通知します。

..    If a delegated mount is shared with a cached or a consistent mount, those portions that overlap must obey cached or consistent mount semantics, respectively.
..    Besides these constraints, the delegated configuration offers the container runtime a degree of flexibility:

5. :code:`delegated` マウントしている場所を :code:`cached` や :code:`consistent`  マウントで共有すると、それぞれの場所は :code:`cached` や :code:`consistent` マウント指定に従う **必要があります** 。
   これらの制約はありますが、 :code:`delegated`  設定はコンテナ実行時に自由度をもたらします。

..    Containers may retain file data and metadata (including directory structure, existence of nodes, etc) indefinitely and this cache may desynchronize from the file system state of the host. Implementors should expire caches when host file system changes occur, but this may be difficult to do on a guaranteed timeframe due to platform limitations.

6. コンテナはファイルデータとメタデータ（ディレクトリ構造、ノードの存在、等）を無期限に保持する **可能性があり** 、このキャッシュによってホスト上のファイルシステム状態と同期しない **可能性があり** ます。ホストファイルシステムで変更が発生すると、開発者はキャッシュを無効化すべきですが、プラットフォームの制約による時間枠（timeframe）の保証は難しいでしょう。

..    If changes to the mount source directory are present on the host file system, those changes may be lost when the delegated mount synchronizes with the host source directory.

7. もしもホストファイルシステム上でマウントしているソースディレクトリに変更を加えても、 :code:`delegated` マウントしているホスト側ソース・ディレクトリの同期によって、それぞれの変更が失われる **可能性があります** 。

..    Behaviors 6-7 do not apply to the file types of socket, pipe, or device.

8. 挙動 6～7 はソケット、パイプ、デバイスに対しては **適用外** です。


.. cached

.. _osxfs-caching-cached:

cached
------------------------------

.. The cached configuration provides all the guarantees of the delegated configuration, and some additional guarantees around the visibility of writes performed by containers. As such, cached typically improves the performance of read-heavy workloads, at the cost of some temporary inconsistency between the host and the container.

:code:`cached` 設定は :code:`delegated`  設定の全てを保証し、コンテナ内で書き込み処理の見え方に関連し、追加の保証をします。 :code:`cached` は読み込みが重たいワークロードの性能を著しく改善しますが、ホストとコンテナ間で一時的に一貫性を失う犠牲を伴います。

.. For directories mounted with cached, the host’s view of the file system is authoritative; writes performed by containers are immediately visible to the host, but there may be a delay before writes performed on the host are visible within containers.

:code:`cached`  としてマウントしたディレクトリは、ホスト側ファイルシステムが信頼できます。つまり、コンテナでの書き込み処理は即時ホスト側でも見えるようになりますが、ホスト上での書き込み処理がコンテナ内で見えるようになるには遅延が発生しうるでしょう。


..    Tip: To learn more about cached, see the article on User-guided caching in Docker Desktop for Mac.

.. tip::

   `cached` について更に学ぶには、 `User-guided caching in Docker Desktop for Mac <https://blog.docker.com/2017/05/user-guided-caching-in-docker-for-mac/>`_ をご覧ください。

..    Implementations must obey delegated Semantics 1-5.

1. 実装は :code:`delegated` 挙動の 1～5 に従う **必要があります** 。

..    If the implementation offers file system events, the container state as it relates to a specific event must reflect the host file system state at the time the event was generated.

2. 実装がファイスシステムイベントの提供時、イベントが生成された時点で、コンテナ状態をホストファイルシステムの状態に反映する **必要があります** 。

..    Container mounts must perform metadata modifications, directory structure changes, and data writes consistently with the host file system, and must not cache data written, metadata modifications, or directory structure changes.

3. コンテナはホストファイルシステムのメタデータ変更、ディレクトリ階層の変更、データ書き込みの一貫性を処理する **必要があります** が、データ書き込み、メタデータ変更、ディレクトリ階層の変更をキャッシュ **する必要はありません**  。

..    If a cached mount is shared with a consistent mount, those portions that overlap must obey consistent mount semantics.
..    Some of the flexibility of the delegated configuration is retained, namely:

4. :code:`cached` マウントが :code:`consistent` マウントとして共有される場合、重複する場所は :code:`consistent`  マウントの挙動で上書きする **必要があります** 。 :code:`delegeted` 設定の柔軟さにより、状態を保ち続ける場合があります。つまり、

..    Implementations may permit delegated Semantics 6.

5. 実装は `delegated`  の挙動 6 を許容する **可能性があります** 。


.. consistent

.. _osxfs-caching-consistent:

consistent
------------------------------

.. The consistent configuration places the most severe restrictions on the container run-time. For directories mounted with consistent the container and host views are always synchronized: writes performed within the container are immediately visible on the host, and writes performed on the host are immediately visible within the container.

:code:`consistent` 設定した場所は、コンテナ実行中に最も制約をうけます。コンテナとホストを :code:`consistent`  でマウントしたディレクトリは、常に同期します。つまり、コンテナ内での書き込み処理は即時ホスト上でも見えるようになり、ホスト上での書き込み処理は即時コンテナ内でも見えるようになります。

.. The consistent configuration most closely reflects the behavior of bind mounts on Linux. However, the overheads of providing strong consistency guarantees make it unsuitable for a few use cases, where performance is a priority and maintaining perfect consistency has low priority.

:code:`consistent`  設定は最も Linux のバインド・マウントの挙動を反映しているものです。しかしながら、パフォーマンスの優先度が高く完全な一貫性の維持に対する優先度が低いような、いくつかの利用例にあたっては、強力な一貫性を確保するためにオーバーヘッドをもたらします。

..    Implementations must obey cached Semantics 1-4.

1. 実装は :code:`cached` 挙動 1～4 に従う **必要があります** 。

..    Container mounts must reflect metadata modifications, directory structure changes, and data writes on the host file system immediately.

2. コンテナのマウントは、ホストファイルシステム上のメタデータ変更、ディレクトリ階層の変更、データ書き込みを即時に反映する **必要があります** 。


.. default

.. _osxfs-caching-default:

default
------------------------------

.. The default configuration is identical to the consistent configuration except for its name. Crucially, this means that cached Semantics 4 and delegated Semantics 5 that require strengthening overlapping directories do not apply to default mounts. This is the default configuration if no state flags are supplied.

:code:`default` 設定は、指定が無ければデフォルトで適用されるもので、 :code:`consistent` 設定と同一です。重要なのは、重複したディレクトリを強化するのに必要な :code:`cached` 挙動 4 と :code:`delegated` 挙動 5 が、 :code:`default` マウントには適用されません。もしも :code:`state` フラグの指定が無ければ、これがデフォルト設定になります。

.. seealso:: 

   Performance tuning for volume mounts (shared filesystems)
      https://docs.docker.com/docker-for-mac/osxfs-caching/
