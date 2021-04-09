.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/runmetrics/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/runmetrics.md
   doc version: 19.03
.. check date: 2020/06/28
.. Commits on May 2, 2020 4169b468f4a742ce6f60daba0613b9dfda267b3d
.. ---------------------------------------------------------------------------

.. title: Runtime metrics

.. _runtime-metrics:

=======================================
ランタイム・メトリクス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. ## Docker stats

.. _docker-stats:

docker stats
==============================

.. You can use the `docker stats` command to live stream a container's
   runtime metrics. The command supports CPU, memory usage, memory limit,
   and network IO metrics.

``docker stats`` コマンドを使うと、コンテナの実行メトリクスからの出力を順次得ることができます。
このコマンドは、CPU、メモリ使用量、メモリ上限、ネットワーク I/O に対するメトリクスをサポートしています。

.. The following is a sample output from the docker stats command

以下は ``docker stats`` コマンドを実行した例です。

.. code-block:: bash

   $ docker stats redis1 redis2
   CONTAINER           CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O
   redis1              0.07%               796 KB / 64 MB        1.21%               788 B / 648 B       3.568 MB / 512 KB
   redis2              0.07%               2.746 MB / 64 MB      4.29%               1.266 KB / 648 B    12.4 MB / 0 B

.. The docker stats reference page has more details about the docker stats command.

``docker stats`` コマンドのより詳細な情報は、 :doc:`docker stats リファレンス・ページ </engine/reference/commandline/stats>` をご覧ください。

.. Control groups

コントロール・グループ
==============================

.. Linux Containers rely on [control groups](
   https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt)
   which not only track groups of processes, but also expose metrics about
   CPU, memory, and block I/O usage. You can access those metrics and
   obtain network usage metrics as well. This is relevant for "pure" LXC
   containers, as well as for Docker containers.

Linux のコンテナは `コントロール・グループ <https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt>`_ に依存しています。
コントロール・グループは、単に複数のプロセスを追跡するだけでなく、CPU、メモリ、ブロック I/O 使用量に関するメトリクスを提供します。
そういったメトリクスがアクセス可能であり、同様にネットワーク使用量のメトリクスも得ることができます。
これは「純粋な」LXC コンテナに関連しており、Docker のコンテナにも関連します。

.. Control groups are exposed through a pseudo-filesystem. In recent
   distros, you should find this filesystem under `/sys/fs/cgroup`. Under
   that directory, you see multiple sub-directories, called devices,
   freezer, blkio, etc.; each sub-directory actually corresponds to a different
   cgroup hierarchy.

コントロール・グループは擬似ファイルシステムを通じて提供されます。
最近のディストリビューションでは、このファイルシステムは ``/sys/fs/cgroup`` にあります。
このディレクトリの下には devices、freezer、blkio などのサブディレクトリが複数あります。
これらのサブディレクトリが、独特の cgroup 階層を構成しています。

.. On older systems, the control groups might be mounted on `/cgroup`, without
   distinct hierarchies. In that case, instead of seeing the sub-directories,
   you see a bunch of files in that directory, and possibly some directories
   corresponding to existing containers.

かつてのシステムでは、コントロール・グループが ``/cgroup`` にマウントされていて、わかりやすい階層構造にはなっていませんでした。
その場合、サブディレクトリそのものを確認していくのではなく、サブディレクトリ内にある数多くのファイルを見渡して、そのディレクトリが既存のコンテナーに対応するものであろう、と確認していくしかありません。

.. To figure out where your control groups are mounted, you can run:

どこにコントロール・グループがマウントされているかを調べるには、次のように実行します。

.. code-block:: bash

   $ grep cgroup /proc/mounts

.. ### Enumerate cgroups

.. _enumerating-cgroups:

cgroups の確認
========================================

.. You can look into `/proc/cgroups` to see the different control group subsystems
   known to the system, the hierarchy they belong to, and how many groups they contain.

``/proc/cgroups`` を覗いてみるとわかりますが、システムが利用するコントロール・グループのサブシステムには実にさまざまなものがあり、それが階層化されていて、数多くのグループが含まれているのがわかります。

.. You can also look at `/proc/<pid>/cgroup` to see which control groups a process
   belongs to. The control group is shown as a path relative to the root of
   the hierarchy mountpoint. `/` means the process has not been assigned to a
   group, while `/lxc/pumpkin` indicates that the process is a member of a
   container named `pumpkin`.

また ``/proc/<pid>/cgroup`` を確認してみれば、1 つのプロセスがどのコントロール・グループに属しているかがわかります。
そのときのコントロール・グループは、階層構造のルートとなるマウント・ポイントからの相対パスで表わされます。
``/`` が表示されていれば、そのプロセスにはグループが割り当てられていません。
一方 ``/lxc/pumpkin`` といった表示になっていれば、そのプロセスは ``pumpkin`` という名のコンテナのメンバであることがわかります。

.. Finding the cgroup for a given container

特定のコンテナに割り当てられた cgroup の確認
============================================

.. For each container, one cgroup is created in each hierarchy. On
   older systems with older versions of the LXC userland tools, the name of
   the cgroup is the name of the container. With more recent versions
   of the LXC tools, the cgroup is `lxc/<container_name>.`

各コンテナでは、各階層内に 1 つの cgroup が生成されます。
かつてのシステムにおいて、ユーザーランド・ツール LXC の古い版を利用している場合、cgroup 名はそのままコンテナ名になっています。
より新しい LXC ツールでの cgroup 名は ``lxc/<コンテナー名>`` となります。

.. For Docker containers using cgroups, the container name will be the full ID or long ID of the container. If a container shows up as ae836c95b4c3 in docker ps, its long ID might be something like ae836c95b4c3c9e9179e0e91015512da89fdec91612f63cebae57df9a5444c79. You can look it up with docker inspect or docker ps --no-trunc.

Docker コンテナは cgroups を使うため、コンテナ名はフル ID か、コンテナのロング ID になります。 ``docker ps`` コマンドでコンテナが ae836c95b4c3 のように見えるのであれば、ロング ID は ``ae836c95b4c3c9e9179e0e91015512da89fdec91612f63cebae57df9a5444c79`` のようなものです。この情報を調べるには、 ``docker inspect`` か ``docker ps --no-trunc`` を使います。

.. Putting everything together to look at the memory metrics for a Docker container, take a look at /sys/fs/cgroup/memory/docker/<longid>/.

Docker コンテナが利用するメモリのメトリクスは、 ``/sys/fs/cgroup/memory/docker/<ロング ID>/`` から全て参照できます。

.. Metrics from cgroups: memory, CPU, block I/O

cgroups からのメトリクス：メモリ、CPU、ブロックI/O
==================================================

.. For each subsystem (memory, CPU, and block I/O), one or more pseudo-files exist and contain statistics.

各サブシステム（メモリ、CPU、ブロック I/O）ごとに、１つまたは複数の疑似ファイル（pseudo-files）に統計情報が含まれます。

.. Memory metrics: memory.stat

メモリ・メトリクス： ``memory.stat``
----------------------------------------

.. Memory metrics are found in the “memory” cgroup. The memory control group adds a little overhead, because it does very fine-grained accounting of the memory usage on your host. Therefore, many distros chose to not enable it by default. Generally, to enable it, all you have to do is to add some kernel command-line parameters: cgroup_enable=memory swapaccount=1.

メモリ・メトリクスは「memory」cgroups にあります。メモリのコントロール・グループは少々のオーバーヘッドが増えます。これはホスト上における詳細なメモリ使用情報を計算するためです。そのため、多くのディストリビューションではデフォルトでは無効です。一般的に、有効にするためには、カーネルのコマンドライン・パラメータに ``cgroup_enable=memory swapaccount=1`` を追加します。

.. The metrics are in the pseudo-file memory.stat. Here is what it will look like:

メトリクスは疑似ファイル ``memory.stat`` にあります。次のように表示されます。

.. code-block:: bash

   cache 11492564992
   rss 1930993664
   mapped_file 306728960
   pgpgin 406632648
   pgpgout 403355412
   swap 0
   pgfault 728281223
   pgmajfault 1724
   inactive_anon 46608384
   active_anon 1884520448
   inactive_file 7003344896
   active_file 4489052160
   unevictable 32768
   hierarchical_memory_limit 9223372036854775807
   hierarchical_memsw_limit 9223372036854775807
   total_cache 11492564992
   total_rss 1930993664
   total_mapped_file 306728960
   total_pgpgin 406632648
   total_pgpgout 403355412
   total_swap 0
   total_pgfault 728281223
   total_pgmajfault 1724
   total_inactive_anon 46608384
   total_active_anon 1884520448
   total_inactive_file 7003344896
   total_active_file 4489052160
   total_unevictable 32768

.. The first half (without the total_ prefix) contains statistics relevant to the processes within the cgroup, excluding sub-cgroups. The second half (with the total_ prefix) includes sub-cgroups as well.

前半（ ``total_`` が先頭に無い ）は、cgroup 中にあるプロセス関連の統計情報を表示します。サブグループは除外しています。後半（  先頭に ``total_`` がある  ）は、サブグループも含めたものです。

.. Some metrics are "gauges", or values that can increase or decrease. For instance,
   `swap` is the amount of swap space used by the members of the cgroup.
   Some others are "counters", or values that can only go up, because
   they represent occurrences of a specific event. For instance, `pgfault`
   indicates the number of page faults since the creation of the cgroup.

メトリクスの中には「メータ」つまり増減を繰り返す表記になるものがあります。
たとえば ``swap`` は、cgroup のメンバによって利用されるスワップ容量の合計です。
この他に「カウンタ」となっているもの、つまり数値がカウントアップされていくものがあります。
これは特定のイベントがどれだけ発生したかを表わします。
たとえば ``pgfault`` は cgroup の生成以降に、どれだけページ・フォルトが発生したかを表わします。

..    **cache**
      The amount of memory used by the processes of this control group that can be associated precisely with a block on a block device. When you read from and write to files on disk, this amount increases. This is the case if you use "conventional" I/O (`open`, `read`, `write` syscalls) as well as mapped files (with `mmap`). It also accounts for the memory used by `tmpfs` mounts, though the reasons are unclear.

* **cache**: このコントロール・グループのプロセスによるメモリ使用量です。ブロック・デバイス上の各ブロックに細かく関連づけられるものです。ディスク上のファイルと読み書きを行うと、この値が増加します。ふだん利用する I/O（システムコールの ``open`` 、``read`` 、``write`` ）利用時に発生し、（``mmap`` を用いた）マップ・ファイルの場合も同様です。``tmpfs`` によるメモリ使用もここに含まれますが、理由は明らかではありません。

..     rss:
..    the amount of memory that doesn’t correspond to anything on disk: stacks, heaps, and anonymous memory maps.

* **rss**: ディスクに関連 *しない* メモリ使用量です。例えば、stacks、heaps、アノニマスなメモリマップです。

..    **mapped_file**
      Indicates the amount of memory mapped by the processes in the control group. It doesn't give you information about *how much* memory is used; it rather tells you *how* it is used.

* **mapped_file**: このコントロール・グループのプロセスによって割り当てられるメモリの使用量です。メモリを **どれだけ** 利用しているかの情報は得られません。ここからわかるのは **どのように** 利用されているかです。

..    **pgfault**, **pgmajfault**
      Indicate the number of times that a process of the cgroup triggered a "page fault" and a "major fault", respectively. A page fault happens when a process accesses a part of its virtual memory space which is nonexistent or protected. The former can happen if the process is buggy and tries to access an invalid address (it is sent a `SIGSEGV` signal, typically killing it with the famous `Segmentation fault` message). The latter can happen when the process reads from a memory zone which has been swapped out, or which corresponds to a mapped file: in that case, the kernel loads the page from disk, and let the CPU complete the memory access. It can also happen when the process writes to a copy-on-write memory zone: likewise, the kernel preempts the process, duplicate the memory page, and resume the write operation on the process's own copy of the page. "Major" faults happen when the kernel actually needs to read the data from disk. When it just  duplicates an existing page, or allocate an empty page, it's a regular (or "minor") fault.

* **pgfault**, **pgmajfault**: cgroup のプロセスにおいて発生した「ページ・フォルト」、「メジャー・フォルト」の回数を表わします。ページ・フォルトは、プロセスがアクセスした仮想メモリ・スペースの一部が、存在していないかアクセス拒否された場合に発生します。存在しないというのは、そのプロセスにバグがあり、不正なアドレスにアクセスしようとしたことを表わします（``SIGSEGV`` シグナルが送信され、``Segmentation fault`` といういつものメッセージを受けたとたんに、プロセスが停止されます）。アクセス拒否されるのは、スワップしたメモリ領域、あるいはマップ・ファイルに対応するメモリ領域を読み込もうとしたときに発生します。この場合、カーネルがディスクからページを読み込み、CPU のメモリ・アクセスを成功させます。またコピー・オン・ライト・メモリ領域へプロセスが書き込みを行う場合にも発生することがあります。同様にカーネルがプロセスの切り替え（preemption）を行ってからメモリ・ページを複製し、ページ内のプロセス自体のコピーに対して書き込み処理を復元します。「メジャー・フォルト」はカーネルがディスクからデータを読み込む必要がある際に発生します。既存ページを複製する場合や空のページを割り当てる場合は、通常の（つまり「マイナー」の）フォルトになります。

..    swap:
..    the amount of swap currently used by the processes in this cgroup.

* **swap**: 対象の cgroup にあるプロセスが、現在どれだけ swap を使っているかの量です。

..    active_anon and inactive_anon:
..    the amount of anonymous memory that has been identified has respectively active and inactive by the kernel. “Anonymous” memory is the memory that is not linked to disk pages. In other words, that’s the equivalent of the rss counter described above. In fact, the very definition of the rss counter is active_anon + inactive_anon - tmpfs (where tmpfs is the amount of memory used up by tmpfs filesystems mounted by this control group). Now, what’s the difference between “active” and “inactive”? Pages are initially “active”; and at regular intervals, the kernel sweeps over the memory, and tags some pages as “inactive”. Whenever they are accessed again, they are immediately retagged “active”. When the kernel is almost out of memory, and time comes to swap out to disk, the kernel will swap “inactive” pages.

* **active_anon と inactive_anon**: カーネルによって *active* と *inactive* に区分される *anonymous* メモリ容量です。 *anonymous* メモリとは、ディスク・ページにリンクされないメモリです。言い換えれば、先ほど説明した rss カウンタと同等なものです。実際、rss カウンタの厳密な定義は、 **active_anon** + **inactive_anon** - **tmpfs** です（ tmpfs のメモリ容量とは、このコントロール・グループの ``tmpfs`` ファイルシステムがマウントして使っている容量です ）。では次に、「active」と「inactive」の違いは何でしょうか？ ページは「active」として始まりますが、一定の時間が経てば、カーネルがメモリを整理（sweep）して、いくつかのページを「inactive」にタグ付けします。再度アクセスがあれば、直ちに「active」に再度タグ付けされます。カーネルがメモリ不足に近づくか、ディスクへのスワップアウト回数により、カーネルは「inactive」なページをスワップします。

..    active_file and inactive_file:
..    cache memory, with active and inactive similar to the anon memory above. The exact formula is cache = active_file + inactive_file + tmpfs. The exact rules used by the kernel to move memory pages between active and inactive sets are different from the ones used for anonymous memory, but the general principle is the same. Note that when the kernel needs to reclaim memory, it is cheaper to reclaim a clean (=non modified) page from this pool, since it can be reclaimed immediately (while anonymous pages and dirty/modified pages have to be written to disk first).

* **active_file と inactive_file**: キャッシュメモリの *active* と *inactive* は、先ほどの *anonymou* メモリの説明にあるものと似ています。正確な計算式は、キャッシュ = **active_file** + **inactive_file** + **tmpfs** です。この正確なルールが使われるのは、カーネルがメモリページを active から inactive にセットする時です。これは anonymous メモリとして使うのとは違って、一般的な基本原理によるものと同じです。注意点としては、カーネルがメモリを再要求（reclaim）するとき、直ちに再要求（anonymous ページや汚れた/変更されたページをディスクに書き込む）よりも、プール上のクリーンな（＝変更されていない）ページを再要求するほうが簡単だからです。

..    **unevictable**
..    The amount of memory that cannot be reclaimed; generally, it accounts for memory that has been "locked" with `mlock`. It is often used by crypto frameworks to make sure that secret keys and other sensitive material never gets swapped out to disk.

* **unevictable**:
  取り出し要求ができないメモリ容量のことです。一般には ``mlock`` によって「ロックされた」メモリとされます。暗号フレームワークにおいて利用されることがあり、秘密鍵や機密情報がディスクにスワップされないようにするものです。

..    **memory_limit**, **memsw_limit**
..    These are not really metrics, but a reminder of the limits applied to this cgroup. The first one indicates the maximum amount of physical memory that can be used by the processes of this control group; the second one indicates the maximum amount of RAM+swap.

* **memory_limit**, **memsw_limit**:
  これは実際のメトリクスではありません。この cgroup に適用される上限を確認するためのものです。**memory_limit** は、このコントロール・グループのプロセスが利用可能な物理メモリの最大容量を示します。**memsw_limit** は RAM＋スワップの最大容量を示します。

.. Accounting for memory in the page cache is very complex. If two
   processes in different control groups both read the same file
   (ultimately relying on the same blocks on disk), the corresponding
   memory charge is split between the control groups. It's nice, but
   it also means that when a cgroup is terminated, it could increase the
   memory usage of another cgroup, because they are not splitting the cost
   anymore for those memory pages.

ページキャッシュ内のメモリの計算は非常に複雑です。
コントロール・グループが異なるプロセスが 2 つあって、それが同一のファイル（最終的にディスク上の同一ブロックに存在）を読み込むとします。
その際のメモリの負担は、それぞれのコントロール・グループに分割されます。
これは一見すると良いことのように思えます。
しかし一方の cgroup が停止したとします。
そうすると他方の cgroup におけるメモリ使用量が増大してしまうことになります。
両者のメモリ・ページに対する使用コストは、もう共有されていないからです。


.. CPU metrics: cpuacct.stat

CPU メトリクス： ``cpuacct.stat``
----------------------------------------

.. Now that we’ve covered memory metrics, everything else is simple in comparison. CPU metrics are in the cpuacct controller.

これまではメモリのメトリクスを見てきました。メモリに比べると他のものは非常に簡単に見えるでしょう。CPU メトリクスは ``cpuacct`` コントローラにあります。

.. For each container, a pseudo-file cpuacct.stat contains the CPU usage accumulated by the processes of the container, broken down into user and system time. The distinction is:
    user time is the amount of time a process has direct control of the CPU, executing process code.
    system time is the time the kernel is executing system calls on behalf of the process.

コンテナごとに疑似ファイル ``cpuacct.stat`` があり、ここにコンテナにあるプロセスの CPU 使用率を、 ``user`` 時間と ``system`` 時間に分割して記録されます。それぞれの違いは：

* ``user`` とはプロセスが CPU を直接制御する時間のことであり、CPU によるプロセス・コードの実行
* ``system`` とはプロセスに代わり CPU のシステムコールを実行する時間

.. Those times are expressed in ticks of 1/100th of a second, also called “user jiffies”. There are USER_HZ “jiffies” per second, and on x86 systems, USER_HZ is 100. Historically, this mapped exactly to the number of scheduler “ticks” per second, but higher frequency scheduling and tickless kernels have made the number of ticks irrelevant.

これらの時間は 100 分の 1 秒の周期（tick）で表示されます。実際にはこれらは「user jiffies」として表示されます。 ``USER_HZ`` 「jillies」が毎秒かつ x86 システムであれば、 ``USER_HZ`` は 100 です。これは１秒の「周期」で、スケジューラが実際に割り当てる時に使いますが、 `tickless kernels <http://lwn.net/Articles/549580/>`_  にあるように、多くのカーネルで ticks は適切ではありません。まだ残っているのは、主に遺産（レガシー）と互換性のためです。

.. Block I/O metrics

Block I/O メトリクス
--------------------

.. Block I/O is accounted in the `blkio` controller.
   Different metrics are scattered across different files. While you can
   find in-depth details in the [blkio-controller](
   https://www.kernel.org/doc/Documentation/cgroup-v1/blkio-controller.txt)
   file in the kernel documentation, here is a short list of the most
   relevant ones:

ブロック I/O は ``blkio`` コントローラにおいて計算されます。
さまざまなメトリクスが、さまざまなファイルにわたって保持されています。
より詳細は、カーネル・ドキュメント内にある `blkio-controller <https://www.kernel.org/doc/Documentation/cgroup-v1/blkio-controller.txt>`_ ファイルに記述されていますが、以下では最も関連のあるものを簡潔に示します。

..     blkio.sectors:
..     contain the number of 512-bytes sectors read and written by the processes member of the cgroup, device by device. Reads and writes are merged in a single counter.

* **blkio.sectors**: cgroups のプロセスのメンバが、512 バイトのセクタをデバイスごとに読み書きするものです。読み書きは単一のカウンタに合算されます。

..     blkio.io_service_bytes:
..    indicates the number of bytes read and written by the cgroup. It has 4 counters per device, because for each device, it differentiates between synchronous vs. asynchronous I/O, and reads vs. writes.

* **blkio.io_service_bytes**: cgroup で読み書きしたバイト数を表示します。デバイスごとに４つのカウンタがあります。これは、デバイスごとに同期・非同期 I/O と、読み込み・書き込みがあるからです。

..    blkio.io_serviced:
..    the number of I/O operations performed, regardless of their size. It also has 4 counters per device.

* **blkio.io_serviced**: サイズに関わらず I/O 操作の実行回数です。こちらもデバイスごとに４つのカウンタがあります。

..    blkio.io_queued:
..    indicates the number of I/O operations currently queued for this cgroup. In other words, if the cgroup isn’t doing any I/O, this will be zero. Note that the opposite is not true. In other words, if there is no I/O queued, it does not mean that the cgroup is idle (I/O-wise). It could be doing purely synchronous reads on an otherwise quiescent device, which is therefore able to handle them immediately, without queuing. Also, while it is helpful to figure out which cgroup is putting stress on the I/O subsystem, keep in mind that is is a relative quantity. Even if a process group does not perform more I/O, its queue size can increase just because the device load increases because of other devices.

* **blkio.io_queued**: このグループ上で I/O 動作がキュー（保留）されている数を表示します。言い換えれば、cgroup が何ら I/O を処理しなければ、この値は０になります。ただし、その逆の場合は違うので気を付けてください。つまり、 I/O キューが発生していなくても、cgroup がアイドルだとは言えません。これは、キューが無くても、純粋に停止しているデバイスからの同期読み込みを行い、直ちに処理することができるためです。また、cgroup は I/O サブシステムに対するプレッシャーを、相対的な量に保とうとする手助けになります。プロセスのグループが更に I/O が必要になれば、キューサイズが増えることにより、他のデバイスとの負荷が増えるでしょう。

.. Network metrics

ネットワーク・メトリクス
==============================

.. Network metrics are not exposed directly by control groups. There is a good explanation for that: network interfaces exist within the context of network namespaces. The kernel could probably accumulate metrics about packets and bytes sent and received by a group of processes, but those metrics wouldn’t be very useful. You want per-interface metrics (because traffic happening on the local lo interface doesn’t really count). But since processes in a single cgroup can belong to multiple network namespaces, those metrics would be harder to interpret: multiple network namespaces means multiple lo interfaces, potentially multiple eth0 interfaces, etc.; so this is why there is no easy way to gather network metrics with control groups.

ネットワークのメトリクスは、コントロール・グループから直接表示されません。ここに良いたとえがあります。ネットワーク・インターフェースとは *ネットワーク名前空間* (network namespaces) 内のコンテクスト（内容）として存在します。カーネルは、プロセスのグループが送受信したパケットとバイト数を大まかに計算できます。しかし、これらのメトリックスは使いづらいものです。インターフェースごとのメトリクスが欲しいでしょう（なぜなら、ローカルの ``lo`` インターフェスに発生するトラフィックが実際に計測できないためです ）。ですが、単一の cgroup 内のプロセスは、複数のネットワーク名前空間に所属するようになりました。これらのメトリクスの解釈は大変です。複数のネットワーク名前空間が意味するのは、複数の ``lo``  インターフェース、複数の ``eth0``  インターフェース等を持ちます。つまり、コントロール・グループからネットワーク・メトリクスを簡単に取得する方法はありません。

.. Instead we can gather network metrics from other sources:

そのかわり、他のソースからネットワークのメトリクスを集められます。

.. IPtables

IPtables
--------------------

.. IPtables (or rather, the netfilter framework for which iptables is just an interface) can do some serious accounting.

IPtables を使えば（というよりも、インターフェースに対する iptables の netfilter フレームワークを使うことにより）、ある程度正しく計測できます。

.. For instance, you can setup a rule to account for the outbound HTTP traffic on a web server:

例えば、ウェブサーバの外側に対する(outbound) HTTP トラフィックの計算のために、次のようなルールを作成できます。

.. code-block:: bash

   $ iptables -I OUTPUT -p tcp --sport 80

.. There is no -j or -g flag, so the rule will just count matched packets and go to the following rule.

ここには何ら ``-j`` や ``-g`` フラグはありませんが、ルールがあることにより、一致するパケットは次のルールに渡されます。

.. Later, you can check the values of the counters, with:

それから、次のようにしてカウンタの値を確認できます。

.. code-block:: bash

   $ iptables -nxvL OUTPUT

.. Technically, `-n` is not required, but it
   prevents iptables from doing DNS reverse lookups, which are probably
   useless in this scenario.

技術的なことだけで言えば ``-n`` は必要ありません。
DNS の逆引きを避けるためのものですが、ここでの作業ではおそらく不要です。

.. Counters include packets and bytes. If you want to setup metrics for container traffic like this, you could execute a for loop to add two iptables rules per container IP address (one in each direction), in the FORWARD chain. This will only meter traffic going through the NAT layer; you will also have to add traffic going through the userland proxy.

カウンタにはパケットとバイト数が含まれます。これを使ってコンテナのトラフィック用のメトリクスをセットアップしたければ、 コンテナの IP アドレスごとに（内外の方向に対する）２つの ``iptables`` ルールの ``for`` ループを ``FORWARD`` チェーンに追加します。これにより、NAT レイヤを追加するトラフィックのみ計測します。つまり、ユーザランド・プロキシを通過しているトラフィックも加えなくてはいけません。

.. Then, you will need to check those counters on a regular basis. If you happen to use collectd, there is a nice plugin to automate iptables counters collection.

後は通常の方法で計測します。 ``collectd`` を使ったことがあるのなら、自動的に iptables のカウンタを収集する `便利なプラグイン <https://collectd.org/wiki/index.php/Table_of_Plugins>`_ があります。

.. Interface-level counters

インターフェース・レベルのカウンタ
----------------------------------------

.. Since each container has a virtual Ethernet interface, you might want to check directly the TX and RX counters of this interface. Each container is associated to a virtual Ethernet interface in your host, with a name like vethKk8Zqi. Figuring out which interface corresponds to which container is, unfortunately, difficult.

各コンテナは仮想イーサネット・インターフェースを持つため、そのインターフェースから直接 TX・RX カウンタを取得したくなるでしょう。各コンテナが ``vethKk8Zqi`` のような仮想イーサネット・インターフェースに割り当てられているのに気を付けてください。コンテナに対応している適切なインターフェースを見つけることは、残念ながら大変です。

.. But for now, the best way is to check the metrics *from within the
   containers*. To accomplish this, you can run an executable from the host
   environment within the network namespace of a container using **ip-netns
   magic**.

今のところ、メトリクスを確認する一番の方法は、**そのコンテナ内部から** 確認することです。
これを実現する方法は、**ip netns を巧みに** 利用します。
これを使えば、コンテナのネットワーク名前空間内に、ホスト環境からモジュールを実行させることができます。

.. The `ip-netns exec` command allows you to execute any
   program (present in the host system) within any network namespace
   visible to the current process. This means that your host can
    enter the network namespace of your containers, but your containers
   can't access the host or other peer containers.
   Containers can interact with their sub-containers, though.

``ip-netns exec`` コマンドはどのようなネットワーク名前空間内においても、（ホスト内に存在する）プログラムなら何でも実行することができ、プロセスからその状況を確認することができます。
つまりコンテナのネットワーク名前空間内に、ホストから入ることができるということです。
ただしコンテナからは、ホストや別のコンテナにはアクセスできません。
サブコンテナであれば、互いに通信することができます。

.. The exact format of the command is:

正確なコマンドの形式は、次の通りです。

.. code-block:: bash

   $ ip netns exec <nsname> <command...>

.. For example:

例：

.. code-block:: bash

   $ ip netns exec mycontainer netstat -i

.. ip netns finds the “mycontainer” container by using namespaces pseudo-files. Each process belongs to one network namespace, one PID namespace, one mnt namespace, etc., and those namespaces are materialized under /proc/<pid>/ns/. For example, the network namespace of PID 42 is materialized by the pseudo-file /proc/42/ns/net.

``ip netns`` は「mycontainer」コンテナを名前空間の疑似ファイルから探します。各プロセスは１つのネットワーク名前空間、PID の名前空間、 ``mnt`` 名前空間等に属しています。これらの名前空間は ``/proc/<pid>/ns/`` 以下にあります。例えば、PID 42 のネットワーク名前空間に関する情報は、疑似ファイル ``/proc/42/ns/net`` です。

.. When you run ip netns exec mycontainer ..., it expects /var/run/netns/mycontainer to be one of those pseudo-files. (Symlinks are accepted.)

``ip netns exec mycontainer ...`` を実行したら、 ``/var/run/netns/mycontainer`` が疑似ファイルの１つとなるでしょう（シンボリック・リンクが使えます）。

.. In other words, to execute a command within the network namespace of a
   container, we need to:

言い換えると、コンテナのネットワーク名前空間内にてコマンドを実行するためには、以下のことが必要になります。

.. - Find out the PID of any process within the container that we want to investigate;
   - Create a symlink from `/var/run/netns/<somename>` to `/proc/<thepid>/ns/net`
   - Execute `ip netns exec <somename> ....`

- 調査したい対象のコンテナ内部に動作している、いずれかのプロセスの PID を調べます。
- ``/var/run/netns/<somename>`` から ``/proc/<pid>/ns/net`` へのシンボリック・リンクを生成します。
- ``ip netns exec <somename> ....`` を実行します。

.. Review [Enumerate Cgroups](#enumerate-cgroups) for how to find
   the cgroup of an in-container process whose network usage you want to measure.
   From there, you can examine the pseudo-file named
   `tasks`, which contains all the PIDs in the
   cgroup (and thus, in the container). Pick any one of the PIDs.

ネットワーク使用量の計測を行おうとしているコンテナ内部において、実行されているプロセスがどの cgroup に属しているかを探し出すには :ref:`enumerating-cgroups` を参照してください。
その方法に従って、``tasks`` という名前の擬似ファイルを調べます。
その擬似ファイル内には cgroup 内の（つまりコンテナ内の） PID がすべて示されています。
そのうちの 1 つを取り出して扱います。

.. Putting everything together, if the "short ID" of a container is held in
   the environment variable `$CID`, then you can do this:

環境変数 ``$CID`` にはコンテナの「短めの ID」が設定されているとします。
これまで説明してきたことをすべてまとめて、以下のコマンドとして実行します。

.. code-block:: bash

   $ TASKS=/sys/fs/cgroup/devices/docker/$CID*/tasks
   $ PID=$(head -n 1 $TASKS)
   $ mkdir -p /var/run/netns
   $ ln -sf /proc/$PID/ns/net /var/run/netns/$CID
   $ ip netns exec $CID netstat -i

.. ## Tips for high-performance metric collection

.. _tips-for-high-performance-metric-collection:

詳細なメトリクスを収集するためのヒント
=========================================

.. Running a new process each time you want to update metrics is
   (relatively) expensive. If you want to collect metrics at high
   resolutions, and/or over a large number of containers (think 1000
   containers on a single host), you do not want to fork a new process each
   time.

新しいプロセスを起動するたびに、メトリクスを最新のものにすることは（比較的）面倒なことです。
高解像度のメトリクスが必要な場合、しかもそれが非常に多くのコンテナ（1 ホスト上に 1000 個くらいのコンテナ）を扱わなければならないとしたら、毎回の新規プロセス起動は行う気になれません。

.. Here is how to collect metrics from a single process. You need to
   write your metric collector in C (or any language that lets you do
   low-level system calls). You need to use a special system call,
   `setns()`, which lets the current process enter any
   arbitrary namespace. It requires, however, an open file descriptor to
   the namespace pseudo-file (remember: that's the pseudo-file in
   `/proc/<pid>/ns/net`).

1 つのプロセスを作り出してメトリクスを収集する方法をここに示します。
メトリクスを収集するプログラムを C 言語（あるいは低レベルのシステムコールを実行できる言語）で記述する必要があります。
利用するのは特別なシステムコール ``setns()`` です。
これはその時点でのプロセスを、任意の名前空間に参加させることができます。
そこでは、その名前空間に応じた擬似ファイルへのファイル・ディスクリプターをオープンしておくことが必要とされます。
（擬似ファイルは ``/proc/<pid>/ns/net`` にあることを思い出してください。）

.. However, there is a catch: you must not keep this file descriptor open.
   If you do, when the last process of the control group exits, the
   namespace is not destroyed, and its network resources (like the
   virtual interface of the container) stays around forever (or until
   you close that file descriptor).

ただしこれは本当のことではありません。
ファイル・ディスクリプターはオープンのままにしないでください。
オープンにしたままであると、コントロール・グループの最後の 1 つとなるプロセスがある場合に、名前空間は削除されず、そのネットワーク・リソース（コンテナの仮想インターフェースなど）がずっと残り続けてしまいます。
（あるいはそれは、ファイル・ディスクリプターを閉じるまで続きます。）

.. The right approach would be to keep track of the first PID of each container, and re-open the namespace pseudo-file each time.

適切なアプローチで、コンテナごとの最初の PID と、都度、名前空間の疑似ファイルが開かれるたびに、追跡し続ける必要があります。

.. Collecting metrics when a container exits

終了したコンテナのメトリクスを収集
========================================

.. Sometimes, you do not care about real time metric collection, but when a container exits, you want to know how much CPU, memory, etc. it has used.

時々、リアルタイムなメトリクス収集に気を配っていなくても、コンテナ終了時に、どれだけ CPU やメモリ等を使用したか知りたい時があるでしょう。

.. Docker makes this difficult because it relies on `lxc-start`, which carefully
   cleans up after itself. It is usually easier to collect metrics at regular
   intervals, and this is the way the `collectd` LXC plugin works.

Docker は ``lxc-start`` によって処理を行うため、リアルタイムなメトリクス収集は困難です。
``lxc-start`` が自身の処理の後に、まわりをきれいにしてしまうためです。
メトリクスの収集は、一定間隔をおいて取得するのが、より簡単な方法と言えます。
``collectd`` にある LXC プラグインは、この方法により動作しています。

.. But, if you’d still like to gather the stats when a container stops, here is how:

しかし、停止したコンテナに関する情報を集めたい時もあるでしょう。次のようにします。

.. For each container, start a collection process, and move it to the
   control groups that you want to monitor by writing its PID to the tasks
   file of the cgroup. The collection process should periodically re-read
   the tasks file to check if it's the last process of the control group.
   (If you also want to collect network statistics as explained in the
   previous section, you should also move the process to the appropriate
   network namespace.)

各コンテナにおいて情報収集用のプロセスを実行し、コントロール・グループに移動させます。
このコントロール・グループは監視対象としたいものであり、cgroup のタスクファイル内に PID を記述しておきます。
情報収集のプロセスは、定期的にそのタスクファイルを読み込み、そのプロセス自体が、コントロールグループ内で残っている最後のプロセスであるかどうかを確認します。
（前節に示したように、ネットワーク統計情報も収集したい場合は、そのプロセスを適切なネットワーク名前空間に移動することも必要になります。）

.. When the container exits, lxc-start attempts to delete the control groups. It fails, since the control group is still in use; but that’s fine. Your process should now detect that it is the only one remaining in the group. Now is the right time to collect all the metrics you need!

コンテナが終了すると、 ``lxc-start`` はコントロール・グループを削除しようとします。コントロール・グループが使用中のため、処理は失敗しますが問題ありません。自分で作ったプロセスは、対象のグループ内に自分しかいないことが分かります。それが必要なメトリックスを取得する適切なタイミングです。

.. Finally, your process should move itself back to the root control group, and remove the container control group. To remove a control group, just rmdir its directory. It’s counter-intuitive to rmdir a directory as it still contains files; but remember that this is a pseudo-filesystem, so usual rules don’t apply. After the cleanup is done, the collection process can exit safely.

最後に、自分のプロセスをルート・コントロール・グループに移動し、コンテナのコントロール・グループを削除します。コントロール・グループの削除は、ディレクトリを ``rmdir`` するだけです。感覚的にディレクトリに対する ``rmdir`` は、まだ中にファイルのではと思うかもしれませんが、これは疑似ファイルシステムのため、通常のルールは適用されません。クリーンアップが完了したら、これで収集プロセスを安全に終了できます。

.. seealso:: 

   Runtime metrics
      https://docs.docker.com/config/containers/runmetrics/
