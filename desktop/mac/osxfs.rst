.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/osxfs/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/osxfs.md
.. check date: 2020/06/10
.. Commits on May 20, 2020 a7806de7c56672370ec17c35cf9811f61a800a42
.. -----------------------------------------------------------------------------

.. File system sharing (osxfs)

.. _file-system-sharing-osxfs:

==================================================
ファイルシステム共有 [osxfs]
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. osxfs is a new shared file system solution, exclusive to Docker Desktop for Mac. osxfs provides a close-to-native user experience for bind mounting macOS file system trees into Docker containers. To this end, osxfs features a number of unique capabilities as well as differences from a classical Linux file system.

:code:`osxfs`  は Docker Desktop for Mac 限定の、新しい共有ファイルシステムのソリューションです。 :code:`osxfs` は macOS ファイルシステム・ツリーを Docker コンテナ内にバインド・マウントするにあたり、ネイティブに近いユーザ体験を提供します。この目的のため、 `osxfs` の機能には、古典的な Linux ファイルシステムとは異なる数々のユニークな機能があります。

.. Case sensitivity

.. _osxfs-case-sensitivity:

大文字と小文字の区別（case sensitivity）
========================================

.. With Docker Desktop for Mac, file systems operate in containers in the same way as they operate in macOS. If a file system on macOS is case-insensitive, that behavior is shared by any bind mount from macOS into a container.

Docker Desktop for Mac では、コンテナ内のファイルシステム操作が、 macOS で操作するのと同じように行えます。macOS 上のファイルシステムが大文字小文字を区別するなら、その挙動は macOS からコンテナ内にバインド・マウントする場合も同じです。

.. On macOS Sierra and lower, the default file system is HFS+. On macOS High Sierra, the default file system is APFS. Both are case-insensitive by default but available in case-sensitive and case-insensitive variants.

macOS Sierra と以前では、デフォルトのファイルシステムは **HFS+**  です。 macOS Hight Sierra では、デフォルトのファイルシステムは **APFS** です。いずれもデフォルトで大文字小文字を区別しますが、バージョンによって大文字小文字を区別するものとしないものがあります。

.. To get case-sensitive behavior, format the volume used in your bind mount as HFS+ or APFS with case-sensitivity. See the APFS FAQ.

大文字小文字の挙動がどうなるかは、バインド・マウントに用いるフォーマット形式が HFS+ か APFS かに依存します。 `APFS FAQ <https://developer.apple.com/library/content/documentation/FileManagement/Conceptual/APFS_Guide/FAQ/FAQ.html>`_ をご覧ください。

.. Reformatting your root partition is not recommended as some Mac software relies on case-insensitivity to function.

同じ Mac 上のソフトウェアは大文字小文字の機能に依存していますので、root パーティションの再フォーマットは推奨しません。

.. Access control

.. _osxfs-access-control:

----------------------------------------

.. osxfs, and therefore Docker, can access only those file system resources that the Docker Desktop for Mac user has access to. osxfs does not run as root. If the macOS user is an administrator, osxfs inherits those administrator privileges. We are still evaluating which privileges to drop in the file system process to balance security and ease-of-use. osxfs performs no additional permissions checks and enforces no extra access control on accesses made through it. All processes in containers can access the same objects in the same way as the Docker user who started the containers.

:code:`osxfs` では、 Dockerはファイスシステムリソースに対してアクセス可能です。つまり、 Docker Desktop for Mac ユーザは :code:`osxfs` にアクセスしますが、 :code:`root`  としては実行できません。もしも macOS ユーザが administrator であれば、 :code:`osxfs` は administrator 権限を継承します。私たちはセキュリティと使いやすさのバランスをとるために、ファイルシステム処理から権限を落とせるように取り組んでいます。 :code:`osxfs`  の動作は、追加の権限チェックがなく、追加のアクセス制御もありません。コンテナ内の全てのプロセスは、コンテナを起動した Docker ユーザによって同じ方法で同じオブジェクトに対してアクセスできます。

.. Namespaces

.. _osxfs-namespaces:

名前空間（namespaces）
----------------------------------------

.. Much of the macOS file system that is accessible to the user is also available to containers using the -v bind mount syntax. The following command runs a container from an image called r-base and shares the macOS user’s ~/Desktop/ directory as /Desktop in the container.

macOS ファイルシステムの大部分は、 :code:`-v` バインド・マウント構文をコンテナで用いてユーザによってアクセス可能です。以下のコマンドを実行すると、 :code:`r-base` という名称のイメージからコンテナを実行し、macOS ユーザの :code:`~/Desktop/` ディレクトリをコンテナ内の :code:`/Desktop` としてマウントします。

.. code-block:: bash

   $ docker run -it -v ~/Desktop:/Desktop r-base bash

.. The user’s ~/Desktop/ directory is now visible in the container as a directory under /.

ユーザの :code:`~/Desktop/`  ディレクトリは、コンテナ内の `/` ディレクトリ以下に見えるようになります。

.. code-block:: bash

   root@2h30fa0c600e:/# ls
   Desktop	boot	etc	lib	lib64	media	opt	root	sbin	sys	usr
   bin	dev	home	lib32	libx32	mnt	proc	run	srv	tmp	var

.. By default, you can share files in /Users/, /Volumes/, /private/, and /tmp directly. To add or remove directory trees that are exported to Docker, use the File sharing tab in Docker preferences whale menu -> Preferences -> File sharing. (See Preferences.)

デフォルトでは、 :code:`/Users/` 、 :code:`/private/` 、 :code:`/tmp` ディレクトリにあるファイルを共有可能です。ディレクトリツリーの追加や削除を Docker に反映するには、 Docker の設定、 **鯨アイコン -> Preferences -> File sharing** にある **Fire sharing** のタブを使います（ :ref:`設定のページ <mac-preferences-file-sharing>` をご覧ください）。

.. All other paths used in -v bind mounts are sourced from the Moby Linux VM running the Docker containers, so arguments such as -v /var/run/docker.sock:/var/run/docker.sock should work as expected. If a macOS path is not shared and does not exist in the VM, an attempt to bind mount it fails rather than create it in the VM. Paths that already exist in the VM and contain files are reserved by Docker and cannot be exported from macOS.

:code:`-v` バインドマウントで使う他のすべてのパスは、Docker コンテナが稼働する Moby Linux 仮想マシンをソースとしますので、引数では :code:`-v /var/run/docker.sock:/var/run/docker.sock` のような指定が動作します。もしも macOS のパスが共有されたおらず、仮想マシン上に存在しなければ、仮想マシンを生成せずにバインド・マウントは失敗します。パスは既に仮想マシン上に存在するものであり、含まれるファイルは Docker に予約済みであり、macOS 側には露出（export）できません。

..    See Performance tuning for volume mounts (shared filesystems) to learn about new configuration options available with the Docker 17.04 CE Edge release.

.. information:

   Docker 17.04 CE Edge リリースで利用可能になった新しい設定オプションについて学ぶには :doc:`osxfs-caching` をご覧ください。


.. Ownership

.. _osxfs-ownership:

所有権（Ownership）
----------------------------------------

.. Initially, any containerized process that requests ownership metadata of an object is told that its uid and gid own the object. When any containerized process changes the ownership of a shared file system object, such as by using the chown command, the new ownership information is persisted in the com.docker.owner extended attribute of the object. Subsequent requests for ownership metadata return the previously set values. Ownership-based permissions are only enforced at the macOS file system level with all accessing processes behaving as the user running Docker. If the user does not have permission to read extended attributes on an object (such as when that object’s permissions are 0000), osxfs attempts to add an access control list (ACL) entry that allows the user to read and write extended attributes. If this attempt fails, the object appears to be owned by the process accessing it until the extended attribute is readable again.

初期化時、あらゆるコンテナ化したプロセスは、自身のオブジェクトに対して :code:`uid` と :code:`gid` といったオブジェクトのメタデータ所有者をリクエストします。あらゆるコンテナ化したプロセスにおいて、 :code:`chown` コマンドなどを用いて共有ファイルシステムオブジェクト上の所有権を変更すると、新しい所有者情報はオブジェクトの拡張属性 `com.docker.owner`内に存在します。所有者メタデータの変更に伴い、それに続く処理では以前にセットした値を返します。所有者を元にした権限（ownership-based permissions）は、macOS ファイルシステムレベル上のみ強制されるもので、Docker を実行しているユーザによるプロセスであればすべてアクセス可能です。もしもユーザがオブジェクトに対する拡張属性を読み込む権限が無ければ（オブジェクトのパーミッションが :code:`0000` のような場合）、 :code:`osxfs`  はユーザが読み書きできるような拡張属性を得られるよう、アクセスコントロールリスト（ACL）のエントリを追加しようとします。割り当てに失敗すると、オブジェクトはプロセスの所有者のものとして表示され、拡張属性は再び読み込み可能なものとして表示します。

.. File system events

.. _osxfs-file-system-events:

ファイルシステムイベント（File system events）
--------------------------------------------------

.. Most inotify events are supported in bind mounts, and likely dnotify and fanotify (though they have not been tested) are also supported. This means that file system events from macOS are sent into containers and trigger any listening processes there.

大部分の :code:`inotify` イベントはバインド・マウントでサポートしています。また、 :code:`dnotify` と :code:`fanotify` （あまりよくテストされていません）もサポートしています。つまり、macOS からのファイルシステムイベントは、コンテナ内のプロセスに対しても送信され、あらゆるリッスンしているプロセスがトリガとなります。

.. The following are supported file system events:

以下は **サポートしているファイルシステムイベントです** ：

..    Creation
    Modification
    Attribute changes
    Deletion
    Directory changes

* 作成
* 変更
* 属性変更
* 削除
* ディレクトリ変更

.. The following are partially supported file system events:

以下は **一部サポートしているファイルシステムイベントです** ：

..    Move events trigger IN_DELETE on the source of the rename and IN_MODIFY on the destination of the rename

* ソース上で `IN_DELETE` をトリガとする移動イベントによる名前変更と、名前変更先の `IN_MODIFY`

.. The following are unsupported file system events:

以下は **サポートしていないファイルシステムイベントです**：

..    Open
    Access
    Close events
    Unmount events (see Mounts)

* オープン
* アクセス
* クローズイベント
* アンマウント・イベント（マウントをご覧ください）

.. Some events may be delivered multiple times. These limitations do not apply to events between containers, only to those events originating in macOS.

いくつかのイベントは何度も送られます。コンテナ間のイベントは反映しないという制約があります。各イベントは macOS を起点としているものだけです。

.. Mounts

.. _osxfs-mounts:

マウント（Mounts）
----------------------------------------

.. The macOS mount structure is not visible in the shared volume, but volume contents are visible. Volume contents appear in the same file system as the rest of the shared file system. Mounting/unmounting macOS volumes that are also bind mounted into containers may result in unexpected behavior in those containers. Unmount events are not supported. Mount export support is planned but is still under development.

共有ボリューム上では macOS マウント構造は見えませんが、ボリュームの内容は見えます。ボリュームの中身として表示されるのは、共有ファイルシステム上の場所にあるものと同一のファイルシステムです。macOS ボリュームのマウントおよびアンアウントとは、コンテナの中に対するバインド・マウントでもあるので、コンテナ内においては予期しない挙動が発生する場合もあります。アンマウントイベントはサポートされていません。マウント・エクスポートのサポートは計画中ですが、まだ開発中です。


.. Symlinks

.. _osxfs_symlinks:

シンボリックリンク（Symlinks）
----------------------------------------

.. Symlinks are shared unmodified. This may cause issues when symlinks contain paths that rely on the default case-insensitivity of the default macOS file system.

シンボリックリンクは共有され、変更できません。そのため、シンボリックリンクにパスを含む場合は、デフォルトの　macOS ファイルシステムはデフォルトで大文字小文字を区別するかどうかによって、問題を引き起こす可能性があります。

.. File types

.. _osxfs-file-types:

ファイルタイプ
----------------------------------------

.. Symlinks, hardlinks, socket files, named pipes, regular files, and directories are supported. Socket files and named pipes only transmit between containers and between macOS processes -- no transmission across the hypervisor is supported, yet. Character and block device files are not supported.

シンボリックリンク、ハードリンク、ソケットファイル、名前付きパイプ、通常のファイル、ディレクトリをサポートしています。ソケットファイルと名前付きパイプは、コンテナと macOS プロセス間のみで送信（transmit）するだけです。つまりハイパーバイザを横断する送信は、まだサポートしていません。キャラクタおよびブロックデバイスファイルはサポート外です。

.. Extended attributes

.. _osxfs-extend-attributes:

拡張属性（Extended attributes）
----------------------------------------

.. Extended attributes are not yet supported.

拡張属性はまだサポートしていません。

.. Technology

.. _osxfs-technology:

技術
----------------------------------------

.. osxfs does not use OSXFUSE. osxfs does not run under, inside, or between macOS userspace processes and the macOS kernel.

:code:`osxfs` は OSXUFSE を使いません。 :code:`osxfs` は macOS ユーザー空間プロセスと macOS カーネル間で、あるいは、その配下、内部では動作しません。


.. SSH agent forwarding

.. _osxfs-ssh-agent-forwarding:

SSH エージェント転送（SSH agent forwarding）
--------------------------------------------------

.. Docker Desktop for Mac allows you to use the host’s SSH agent inside a container. To do this:

Docker Desktop for Mac はホスト側の SSH エージェントをコンテナ内で利用できます。そのためには、

..    Bind mount the SSH agent socket by adding the following parameter to your docker run command:

1. SSH エージェントの助っ人をバインド・マウントするため、 :doc:`docker run` コマンドで以下のパラメータを追加： :doc:`--mount type=bind,src=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-au`

.. code-block:: bash

    --mount type=bind,src=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-auth.sock

..    Add the SSH_AUTH_SOCK environment variable in your container:

2. :code:`SSH_AUTH_SOCK` 環境変数をコンテナに追加： :code:`-e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock"`

.. code-block:: bash

    -e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock"

.. To enable the SSH agent in Docker Compose, add the following flags to your service:

Docker Compose で SSH エージェントを有効化するには、サービスに以下のフラグを追加します：

.. code-block:: bash

   services:
     web:
       image: nginx:alpine
       volumes:
         - type: bind
           source: /run/host-services/ssh-auth.sock
           target: /run/host-services/ssh-auth.sock
       environment:
         - SSH_AUTH_SOCK=/run/host-services/ssh-auth.sock


.. Performance issues, solutions, and roadmap

.. _osxfs-performance-issues-solutions-and-roadmap:

パフォーマンス問題、ソリューション、ロードマップ
-------------------------------------------------------

..    See Performance tuning for volume mounts (shared filesystems) to learn about new configuration options available with the Docker 17.04 CE Edge release.

.. hint::

   Docker 17.04 CE Edge リリースで利用可能になった新しい設定オプションについて学ぶには :doc:`osxfs-caching` をご覧ください。

(TBD、将来的に変更する可能性があるため。また、マニュアル本編とは直接関係がないため)


.. With regard to reported performance issues (GitHub issue 77: File access in mounted volumes extremely slow), and a similar thread on Docker Desktop for Mac forums on topic: File access in mounted volumes extremely slow, this topic provides an explanation of the issues, recent progress in addressing them, how the community can help us, and what you can expect in the future. This explanation derives from a post about understanding performance by David Sheets (@dsheets) on the Docker development team to the forum topic just mentioned. We want to surface it in the documentation for wider reach.

.. Understanding performance

.. _osxfs-understanding-performance:

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Perhaps the most important thing to understand is that shared file system performance is multi-dimensional. This means that, depending on your workload, you may experience exceptional, adequate, or poor performance with osxfs, the file system server in Docker Desktop for Mac. File system APIs are very wide (20-40 message types) with many intricate semantics involving on-disk state, in-memory cache state, and concurrent access by multiple processes. Additionally, osxfs integrates a mapping between macOS’s FSEvents API and Linux’s inotify API which is implemented inside of the file system itself, complicating matters further (cache behavior in particular).

.. At the highest level, there are two dimensions to file system performance: throughput (read/write IO) and latency (roundtrip time). In a traditional file system on a modern SSD, applications can generally expect throughput of a few GB/s. With large sequential IO operations, osxfs can achieve throughput of around 250 MB/s which, while not native speed, is not likely to be the bottleneck for most applications which perform acceptably on HDDs.

.. Latency is the time it takes for a file system call to complete. For instance, the time between a thread issuing write in a container and resuming with the number of bytes written. With a classical block-based file system, this latency is typically under 10μs (microseconds). With osxfs, latency is presently around 130μs for most operations or 13× slower. For workloads which demand many sequential roundtrips, this results in significant observable slowdown. Reducing the latency requires shortening the data path from a Linux system call to macOS and back again. This requires tuning each component in the data path in turn -- some of which require significant engineering effort. Even if we achieve a huge latency reduction of 65μs/roundtrip, we still “only” see a doubling of performance. This is typical of performance engineering, which requires significant effort to analyze slowdowns and develop optimized components. We know a number of approaches that may reduce the roundtrip time but we haven’t implemented all those improvements yet (more on this below in What you can do).

.. A second approach to improving performance is to reduce the number of roundtrips by caching data. Recent versions of Docker Desktop for Mac (17.04 onwards) include caching support that brings significant (2-4×) improvements to many applications. Much of the overhead of osxfs arises from the requirement to keep the container’s and the host’s view of the file system consistent, but full consistency is not necessary for all applications and relaxing the constraint opens up a number of opportunities for improved performance.

.. At present there is support for read caching, with which the container’s view of the file system can temporarily drift apart from the authoritative view on the host. Further caching developments, including support for write caching, are planned. A detailed description of the behavior in various caching configurations is available.


.. What we are doing

.. _osxfs-what-we-are-doing:

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


.. We continue to actively work on increasing caching and on reducing the file system data path latency. This requires significant analysis of file system traces and speculative development of system improvements to try to address specific performance issues. Perhaps surprisingly, application workload can have a huge effect on performance. As an example, here are two different use cases contributed on the forum topic and how their performance differs and suffers due to latency, caching, and coherence:

..    A rake example (see below) appears to attempt to access 37000+ different files that don’t exist on the shared volume. Even with a 2× speedup via latency reduction this use case still seems “slow”. With caching enabled the performance increases around 3.5×, as described in the user-guided caching post. We expect to see further performance improvements for rake with a “negative dcache” that keeps track of, in the Linux kernel itself, the files that do not exist. However, even this is not sufficient for the first time rake is run on a shared directory. To handle that case, we actually need to develop a Linux kernel patch which negatively caches all directory entries not in a specified set -- and this cache must be kept up-to-date in real-time with the macOS file system state even in the presence of missing macOS FSEvents messages and so must be invalidated if macOS ever reports an event delivery failure.

..    Running ember build in a shared file system results in ember creating many different temporary directories and performing lots of intermediate activity within them. An empty ember project is over 300MB. This usage pattern does not require coherence between Linux and macOS, and is significantly improved by write caching.

.. These two examples come from performance use cases contributed by users and they are incredibly helpful in prioritizing aspects of file system performance to improve. We are developing statistical file system trace analysis tools to characterize slow-performing workloads more easily to decide what to work on next.

.. Under development, we have:

..    A growing performance test suite of real world use cases (more on this below in What you can do)

..    Further caching improvements, including negative, structural, and write-back caching, and lazy cache invalidation.

..    A Linux kernel patch to reduce data path latency by 2/7 copies and 2/5 context switches

..    Increased macOS integration to reduce the latency between the hypervisor and the file system server

.. What you can do

.. _osxfs-what-you-can-do:

^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


.. When you report shared file system performance issues, it is most helpful to include a minimal Real World reproduction test case that demonstrates poor performance.

.. Without a reproduction, it is very difficult for us to analyze your use case and determine what improvements would speed it up. When you don’t provide a reproduction, one of us needs to figure out the specific software you are using and guess and hope that we have configured it in a typical way or a way that has poor performance. That usually takes 1-4 hours depending on your use case and once it is done, we must then determine what regular performance is like and what kind of slow-down your use case is experiencing. In some cases, it is not obvious what operation is even slow in your specific development workflow. The additional set-up to reproduce the problem means we have less time to fix bugs, develop analysis tools, or improve performance. So, include simple, immediate performance issue reproduction test cases. The rake reproduction case by @hirowatari shown in the forums thread is a great example.

.. This example originally provided:

..    A version-controlled repository so any changes/improvements to the test case can be easily tracked.

..    A Dockerfile which constructs the exact image to run

..    A command-line invocation of how to start the container

..    A straight-forward way to measure the performance of the use case

..    A clear explanation (README) of how to run the test case

.. What you can expect

.. _osxfs-what-you-can-expect:

.. We continue to work toward an optimized shared file system implementation on the Edge channel of Docker Desktop for Mac.

.. You can expect some of the performance improvement work mentioned above to reach the Edge channel in the coming release cycles.

.. We plan to eventually open source all of our shared file system components. At that time, we would be very happy to collaborate with you on improving the implementation of osxfs and related software.

.. We also plan to write up and publish further details of shared file system performance analysis and improvement on the Docker blog. Look for or nudge @dsheets about those articles, which should serve as a jumping off point for understanding the system, measuring it, or contributing to it.

.. Wrapping Up

.. _wrapping-up:

.. We hope this gives you a rough idea of where osxfs performance is and where it’s going. We are treating good performance as a top priority feature of the file system sharing component and we are actively working on improving it through a number of different avenues. The osxfs project started in December

..    Since the first integration into Docker Desktop for Mac in February 2016, we’ve improved performance by 50x or more for many workloads while achieving nearly complete POSIX compliance and without compromising coherence (it is shared and not simply synced). Of course, in the beginning there was lots of low-hanging fruit and now many of the remaining performance improvements require significant engineering work on custom low-level components.

.. We appreciate your understanding as we continue development of the product and work on all dimensions of performance. We want to continue to work with the community on this, so continue to report issues as you find them. We look forward to collaborating with you on ideas and on the source code itself.


.. seealso:: 

   File system sharing (osxfs)
      https://docs.docker.com/docker-for-mac/osxfs/
