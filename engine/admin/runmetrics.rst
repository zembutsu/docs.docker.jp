.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/runmetrics/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/runmetrics.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/runmetrics.md
.. check date: 2016/06/13
.. Commits on May 27, 2016 ee7696312580f14ce7b8fe70e9e4cbdc9f83919f
.. ---------------------------------------------------------------------------

.. Runtime metrics

=======================================
ランタイム・メトリクス（監視）
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can use the docker stats command to live stream a container’s runtime metrics. The command supports CPU, memory usage, memory limit, and network IO metrics.

コンテナのラインタイム・メトリクス（訳注；コンテナ実行時の、様々なリソース指標や数値データ）をライブ（生）で表示するには、 ``docker stats`` コマンドを使います。コマンドがサポートしているのは、CPU 、メモリ使用率、メモリ上限、ネットワーク I/O のメトリクスです。

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

.. Linux Containers rely on control groups which not only track groups of processes, but also expose metrics about CPU, memory, and block I/O usage. You can access those metrics and obtain network usage metrics as well. This is relevant for “pure” LXC containers, as well as for Docker containers.

Linux はプロセス・グループの追跡だけでなく、CPU・メモリ・ブロック I/O のメトリクス表示は、 `コントロール・グループ <https://www.kernel.org/doc/Documentation/cgroup-v1/cgroups.txt>`_ に依存しています。これらのメトリクスやネットワーク使用量のメトリクスも同様に取得できます。これらは「純粋な」 LXC コンテナ用であり、Docker コンテナ用でもあります。

.. Control groups are exposed through a pseudo-filesystem. In recent distros, you should find this filesystem under /sys/fs/cgroup. Under that directory, you will see multiple sub-directories, called devices, freezer, blkio, etc.; each sub-directory actually corresponds to a different cgroup hierarchy.

コントロール・グループは疑似ファイルシステム（pseudo-filesystem）を通して公開されています。最近のディストリビューションでは、 ``/sys/fs/cgroup`` 以下で見つかるでしょう。このディレクトリの下に、device・freezer・blkio 等の複数のサブディレクトリがあります。各サブディレクトリは、それぞれ異なった cgroup 階層に相当します。

.. On older systems, the control groups might be mounted on /cgroup, without distinct hierarchies. In that case, instead of seeing the sub-directories, you will see a bunch of files in that directory, and possibly some directories corresponding to existing containers.

古いシステムでは、コントロール・グループが ``/cgroup`` にマウントされており、その下に明確な階層が無いかもしれません。そのような場合、サブディレクトリが見える代わりに、たくさんのファイルがあるでしょう。あるいは、存在しているコンテナに相当するディレクトリがあるかもしれません。

.. To figure out where your control groups are mounted, you can run:

どこにコントロール・グループがマウントされているかを調べるには、次のように実行します。

.. code-block:: bash

   $ grep cgroup /proc/mounts

.. Enumerating cgroups

.. _enumerating-cgroups:

コントロール・グループの列挙
========================================

.. You can look into /proc/cgroups to see the different control group subsystems known to the system, the hierarchy they belong to, and how many groups they contain.

``/proc/cgroups`` を調べれば、システム上の様々に異なるコントロール・グループのサブシステムが見えます。それぞれに階層がサブシステムに相当しており、多くのグループが見えるでしょう。

.. You can also look at /proc/<pid>/cgroup to see which control groups a process belongs to. The control group will be shown as a path relative to the root of the hierarchy mountpoint; e.g., / means “this process has not been assigned into a particular group”, while /lxc/pumpkin means that the process is likely to be a member of a container named pumpkin.

コントロール・グループのプロセスに属する情報は、 ``/proc/<pic>/cgroup`` からも確認できます。コントロール・グループは階層のマウントポイントからの相対パス上に表示されます。例えば、 ``/`` が意味するのは「対象のプロセスは特定のグループに割り当てられていない」であり、 ``/lxc/pumpkin`` が意味するのはプロセスが ``pumpkin`` と呼ばれるコンテナのメンバであると考えられます。

.. Finding the cgroup for a given container

特定のコンテナに割り当てられた cgroup の確認
============================================

.. For each container, one cgroup will be created in each hierarchy. On older systems with older versions of the LXC userland tools, the name of the cgroup will be the name of the container. With more recent versions of the LXC tools, the cgroup will be lxc/<container_name>.

コンテナごとに、それぞれの階層に cgroup が作成されます。古いシステム上のバージョンが古い LXC userland tools の場合、cgroups の名前はコンテナ名になっています。より最近のバージョンの LXC ツールであれば、cgroup は ``lxc/<コンテナ名>`` になります。

.. For Docker containers using cgroups, the container name will be the full ID or long ID of the container. If a container shows up as ae836c95b4c3 in docker ps, its long ID might be something like ae836c95b4c3c9e9179e0e91015512da89fdec91612f63cebae57df9a5444c79. You can look it up with docker inspect or docker ps --no-trunc.

Docker コンテナは cgroups を使うため、コンテナ名はフル ID か、コンテナのロング ID になります。 ``docker ps`` コマンドでコンテナが ae836c95b4c3 のように見えるのであれば、ロング ID は ``ae836c95b4c3c9e9179e0e91015512da89fdec91612f63cebae57df9a5444c79`` のようなものです。この情報を調べるには、 ``docker inspect`` か ``docker ps --no-trunc`` を使います。

.. Putting everything together to look at the memory metrics for a Docker container, take a look at /sys/fs/cgroup/memory/docker/<longid>/.

Docker コンテナが利用するメモリのメトリクスは、 ``/sys/fs/cgroup/memory/docker/<ロング ID>/`` から全て参照できます。

.. Metrics from cgroups: memory, CPU, block I/O

cgroups からのメトリクス：メモリ、CPU、ブロックI/O
==================================================

.. For each subsystem (memory, CPU, and block I/O), you will find one or more pseudo-files containing statistics.

各サブシステム（メモリ、CPU、ブロック I/O）ごとに、１つまたは複数の疑似ファイル（pseudo-files）に統計情報が含まれます。

.. Memory metrics: memory.stat

メモリ・メトリクス： ``memory.stat``
----------------------------------------

.. Memory metrics are found in the “memory” cgroup. Note that the memory control group adds a little overhead, because it does very fine-grained accounting of the memory usage on your host. Therefore, many distros chose to not enable it by default. Generally, to enable it, all you have to do is to add some kernel command-line parameters: cgroup_enable=memory swapaccount=1.

メモリ・メトリクスは「memory」cgroups にあります。メモリのコントロール・グループは少々のオーバーヘッドが増えるのを覚えておいてください。これはホスト上における詳細なメモリ使用情報を計算するためです。そのため、多くのディストリビューションではデフォルトでは無効です。一般的に、有効にするためには、カーネルのコマンドライン・パラメータに ``cgroup_enable=memory swapaccount=1`` を追加します。

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

.. Some metrics are “gauges”, i.e., values that can increase or decrease (e.g., swap, the amount of swap space used by the members of the cgroup). Some others are “counters”, i.e., values that can only go up, because they represent occurrences of a specific event (e.g., pgfault, which indicates the number of page faults which happened since the creation of the cgroup; this number can never decrease).

いくつかのメトリクスは「gauges」（ゲージ；計測した値そのものの意味）であり、例えば、値が増減するものです（例：swap は cgroup のメンバによって使われている swap 領域の容量です）。あるいは「counter」（カウンタ）は、特定のイベント発生後に増えた値のみ表示します（例：pgfault はページ・フォルトの回数を表しますが、cgroup が作成された後の値です。この値は決して減少しません。）。

..    cache:
..    the amount of memory used by the processes of this control group that can be associated precisely with a block on a block device. When you read from and write to files on disk, this amount will increase. This will be the case if you use “conventional” I/O (open, read, write syscalls) as well as mapped files (with mmap). It also accounts for the memory used by tmpfs mounts, though the reasons are unclear.

* **cache**: コントロール・グループのプロセスによって使用されるメモリ容量であり、ブロック・デバイス上のブロックと密接に関わりがあります。ディスクからファイルを読み書きしたら、この値が増えます。値が増えるのは「通常」の I/O （ ``open`` 、 ``read`` 、 ``write`` システムコール）だけでなく、ファイルのマップ（ ``mmap`` を使用 ）でも同様です。あるいは ``tmpfs`` マウントでメモリを使う場合も、理由が明確でなくともカウントされます。

..     rss:
..    the amount of memory that doesn’t correspond to anything on disk: stacks, heaps, and anonymous memory maps.

* **rss**: ディスクに関連 *しない* メモリ使用量です。例えば、stacks、heaps、アノニマスなメモリマップです。

..    mapped_file:
..    indicates the amount of memory mapped by the processes in the control group. It doesn’t give you information about how much memory is used; it rather tells you how it is used.

* **mapped_file**: コントロール・グループ上のプロセスに割り当てられるファイル容量です。 メモリを **どのように** 使用しているかの情報は得られません。どれだけ使っているかを表示します。

..    pgfault and pgmajfault:
..    indicate the number of times that a process of the cgroup triggered a “page fault” and a “major fault”, respectively. A page fault happens when a process accesses a part of its virtual memory space which is nonexistent or protected. The former can happen if the process is buggy and tries to access an invalid address (it will then be sent a SIGSEGV signal, typically killing it with the famous Segmentation fault message). The latter can happen when the process reads from a memory zone which has been swapped out, or which corresponds to a mapped file: in that case, the kernel will load the page from disk, and let the CPU complete the memory access. It can also happen when the process writes to a copy-on-write memory zone: likewise, the kernel will preempt the process, duplicate the memory page, and resume the write operation on the process` own copy of the page. “Major” faults happen when the kernel actually has to read the data from disk. When it just has to duplicate an existing page, or allocate an empty page, it’s a regular (or “minor”) fault.

* **pgfault と pgmajfault**: cgroup のプロセスが「page fault」と「major fault」の回数を個々に表示します。page fault とは、存在しないかプロテクトされた仮想メモリスペースにプロセスがアクセスした時に発生します。かつては、プロセスにバグがあり、無効なアドレスにアクセスしようとした時に発生しました（ ``SIGSEGV`` シグナルが送信されます。典型的なのは ``Segmentation fault`` メッセージを表示して kill される場合です  ）。最近であれば、プロセスがスワップ・アウトされたメモリ領域を読み込みに行くか、あるいはマップされたファイルに相当する時に発生します。そのような場合、カーネルはページをディスクから読み込み、CPU がメモリへのアクセスを処理します。これはまた、プロセスがコピー・オン・ライト（copy-on-write）のメモリ領域に書き込んだ時にも発生します。これはカーネルがプロセスの実行を阻止するのと同じであり、メモリページを複製し、プロセスが自身のページをコピーして書き込み作業を再開しようとします。「メジャー」な失敗がおこるのは、カーネルが実際にディスクからデータを読み込む時点です。読み込みによって、既存のページと重複するか、空のページが割り当てられると一般的な（あるいは「マイナー」な）エラーが発生します。

..    swap:
..    the amount of swap currently used by the processes in this cgroup.

* **swap**: 対象の cgroup にあるプロセスが、現在どれだけ swap を使っているかの量です。

..    active_anon and inactive_anon:
..    the amount of anonymous memory that has been identified has respectively active and inactive by the kernel. “Anonymous” memory is the memory that is not linked to disk pages. In other words, that’s the equivalent of the rss counter described above. In fact, the very definition of the rss counter is active_anon + inactive_anon - tmpfs (where tmpfs is the amount of memory used up by tmpfs filesystems mounted by this control group). Now, what’s the difference between “active” and “inactive”? Pages are initially “active”; and at regular intervals, the kernel sweeps over the memory, and tags some pages as “inactive”. Whenever they are accessed again, they are immediately retagged “active”. When the kernel is almost out of memory, and time comes to swap out to disk, the kernel will swap “inactive” pages.

* **active_anon と inactive_anon**: カーネルによって *active* と *inactive* に区分される *anonymous* メモリ容量です。 *anonymous* メモリとは、ディスク・ページにリンクされないメモリです。言い換えれば、先ほど説明した rss カウンタと同等なものです。実際、rss カウンタの厳密な定義は、 **active_anon** + **inactive_anon** - **tmpfs** です（ tmpfs のメモリ容量とは、このコントロール・グループの ``tmpfs`` ファイルシステムがマウントして使っている容量です ）。では次に、「active」と「inactive」の違いは何でしょうか？ ページは「active」として始まりますが、一定の時間が経てば、カーネルがメモリを整理（sweep）して、いくつかのページを「inactive」にタグ付けします。再度アクセスがあれば、直ちに「active」に再度タグ付けされます。カーネルがメモリ不足に近づくか、ディスクへのスワップアウト回数により、カーネルは「inactive」なページをスワップします。

..    active_file and inactive_file:
..    cache memory, with active and inactive similar to the anon memory above. The exact formula is cache = active_file + inactive_file + tmpfs. The exact rules used by the kernel to move memory pages between active and inactive sets are different from the ones used for anonymous memory, but the general principle is the same. Note that when the kernel needs to reclaim memory, it is cheaper to reclaim a clean (=non modified) page from this pool, since it can be reclaimed immediately (while anonymous pages and dirty/modified pages have to be written to disk first).

* **active_file と inactive_file**: キャッシュメモリの *active* と *inactive* は、先ほどの *anonymou* メモリの説明にあるものと似ています。正確な計算式は、キャッシュ = **active_file** + **inactive_file** + **tmpfs** です。この正確なルールが使われるのは、カーネルがメモリページを active から inactive にセットする時です。これは anonymous メモリとして使うのとは違って、一般的な基本原理によるものと同じです。注意点としては、カーネルがメモリを再要求（reclaim）するするとき、直ちに再要求（anonymous ページや汚れた/変更されたページをディスクに書き込む）よりも、プール上のクリーンな（＝変更されていない）ページを再要求するほうが簡単だからです。

..    unevictable:
..    the amount of memory that cannot be reclaimed; generally, it will account for memory that has been “locked” with mlock. It is often used by crypto frameworks to make sure that secret keys and other sensitive material never gets swapped out to disk.

* **unevictable**: 再要求されないメモリの容量です。一般的に ``mlock``  で「ロックされた」メモリ容量です。暗号化フレームワークによる秘密鍵の作成や、ディスクにスワップさせたくないような繊細な素材に使われます。

..    memory and memsw limits:
..    These are not really metrics, but a reminder of the limits applied to this cgroup. The first one indicates the maximum amount of physical memory that can be used by the processes of this control group; the second one indicates the maximum amount of RAM+swap.

* **memory と memsw の limits**: これらは実際のメトリクスではありませんが、対象の cgroup に適用される上限の確認に使います。「memory」はこのコントロール・グループのプロセスによって使われる最大の物理メモリを示します。「memsw」 は RAM+swap の最大容量を示します。

.. Accounting for memory in the page cache is very complex. If two processes in different control groups both read the same file (ultimately relying on the same blocks on disk), the corresponding memory charge will be split between the control groups. It’s nice, but it also means that when a cgroup is terminated, it could increase the memory usage of another cgroup, because they are not splitting the cost anymore for those memory pages.

ページキャッシュ中のメモリ計算は非常に複雑です。もし２つのプロセスが異なったコントロール・グループ上にあるなら、それぞれの同じファイル（結局はディスク上の同じブロックに依存しますが）を読み込む必要があります。割り当てられたメモリは、コントロール・グループごとの容量に依存します。これは良さそうですが、cgroup を削除したら、メモリページとして消費していた領域は使わなくなり、他の cgroup のメモリ容量を増加させることをも意味します。


.. CPU metrics: cpuacct.stat

CPU メトリクス： ``cpuacct.stat``
----------------------------------------

.. Now that we’ve covered memory metrics, everything else will look very simple in comparison. CPU metrics will be found in the cpuacct controller.

これまではメモリのメトリクスを見てきました。メモリに比べると他のものは非常に簡単に見えるでしょう。CPU メトリクスは ``cpuacct`` コントローラにあります。

.. For each container, you will find a pseudo-file cpuacct.stat, containing the CPU usage accumulated by the processes of the container, broken down between user and system time. If you’re not familiar with the distinction, user is the time during which the processes were in direct control of the CPU (i.e., executing process code), and system is the time during which the CPU was executing system calls on behalf of those processes.

コンテナごとに疑似ファイル ``cpuacct.stat`` があり、ここにコンテナにあるプロセスの CPU 使用率を、 ``user`` 時間と ``system`` 時間に分割して記録されます。いずれも慣れていなければ、 ``user`` とはプロセスが CPU を直接制御する時間のこと（例：プロセス・コードの実行）であり、 ``system`` とはプロセスに代わり CPU のシステムコールを実行する時間です。

.. Those times are expressed in ticks of 1/100th of a second. Actually, they are expressed in “user jiffies”. There are USER_HZ “jiffies” per second, and on x86 systems, USER_HZ is 100. This used to map exactly to the number of scheduler “ticks” per second; but with the advent of higher frequency scheduling, as well as tickless kernels, the number of kernel ticks wasn’t relevant anymore. It stuck around anyway, mainly for legacy and compatibility reasons.

これらの時間は 100 分の 1 秒の周期（tick）で表示されます。実際にはこれらは「user jiffies」として表示されます。 ``USER_HZ`` 「jillies」が毎秒かつ x86 システムであれば、 ``USER_HZ`` は 100 です。これは１秒の「周期」で、スケジューラが実際に割り当てる時に使いますが、 `tickless kernels <http://lwn.net/Articles/549580/>`_  にあるように、多くのカーネルで ticks は適切ではありません。まだ残っているのは、主に遺産（レガシー）と互換性のためです。

.. Block I/O metrics

Block I/O メトリクス
--------------------

.. Block I/O is accounted in the blkio controller. Different metrics are scattered across different files. While you can find in-depth details in the blkio-controller file in the kernel documentation, here is a short list of the most relevant ones:

Block I/O は ``blkio`` コントローラを算出します。異なったメトリックスが別々のファイルに散在しています。より詳細な情報を知りたい場合は、カーネル・ドキュメントの `blkio-controller <https://www.kernel.org/doc/Documentation/cgroup-v1/blkio-controller.txt>`_ をご覧ください。ここでは最も関係が深いものをいくつか扱います。

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

.. Technically, -n is not required, but it will prevent iptables from doing DNS reverse lookups, which are probably useless in this scenario.

技術的には ``-n`` は不要なのですが、今回の例では、不要な DNS 逆引きの名前解決をしないために付けています。

.. Counters include packets and bytes. If you want to setup metrics for container traffic like this, you could execute a for loop to add two iptables rules per container IP address (one in each direction), in the FORWARD chain. This will only meter traffic going through the NAT layer; you will also have to add traffic going through the userland proxy.

カウンタにはパケットとバイト数が含まれます。これを使ってコンテナのトラフィック用のメトリクスをセットアップしたければ、 コンテナの IP アドレスごとに（内外の方向に対する）２つの ``iptables`` ルールの ``for`` ループを ``FORWARD`` チェーンに追加します。これにより、NAT レイヤを追加するトラフィックのみ計測します。つまり、ユーザランド・プロキシを通過しているトラフィックも加えなくてはいけません。

.. Then, you will need to check those counters on a regular basis. If you happen to use collectd, there is a nice plugin to automate iptables counters collection.

後は通常の方法で計測します。 ``collectd`` を使ったことがあるのなら、自動的に iptables のカウンタを収集する `便利なプラグイン <https://collectd.org/wiki/index.php/Table_of_Plugins>`_ があります。

.. Interface-level counters

インターフェース・レベルのカウンタ
----------------------------------------

.. Since each container has a virtual Ethernet interface, you might want to check directly the TX and RX counters of this interface. You will notice that each container is associated to a virtual Ethernet interface in your host, with a name like vethKk8Zqi. Figuring out which interface corresponds to which container is, unfortunately, difficult.

各コンテナは仮想イーサネット・インターフェースを持つため、そのインターフェースから直接 TX・RX カウンタを取得したくなるでしょう。各コンテナが ``vethKk8Zqi`` のような仮想イーサネット・インターフェースに割り当てられているのに気を付けてください。コンテナに対応している適切なインターフェースを見つけることは、残念ながら大変です。

.. But for now, the best way is to check the metrics from within the containers. To accomplish this, you can run an executable from the host environment within the network namespace of a container using ip-netns magic.

しかし今は、 *コンテナを通さなくても* 数値を確認できる良い方法があります、ホスト環境上で **ip netns の魔力** を使い、ネットワーク名前空間内のコンテナの情報を確認します。

.. The ip-netns exec command will let you execute any program (present in the host system) within any network namespace visible to the current process. This means that your host will be able to enter the network namespace of your containers, but your containers won’t be able to access the host, nor their sibling containers. Containers will be able to “see” and affect their sub-containers, though.

``ip netns exec`` コマンドは、あらゆるネットワーク名前空間内で、あらゆるプログラムを実行し（対象のホスト上の）、現在のプロセス状況を表示します。つまり、ホストがコンテナのネットワーク名前空間に入れますが、コンテナはホスト側にアクセスできないだけでなく、他のコンテナにもアクセスできません。次のサブコマンドを通すことで、コンテナが「見える」用になります。

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

.. In other words, to execute a command within the network namespace of a container, we need to:

言い換えれば、私たちが必要であれば、ネットワーク名前空間の中でコマンドを実行できるのです。

..    Find out the PID of any process within the container that we want to investigate;
    Create a symlink from /var/run/netns/<somename> to /proc/<thepid>/ns/net
    Execute ip netns exec <somename> ....

* 調査したいコンテナに入っている、あらゆる PID を探し出します
* ``/var/run/netns/<何らかの名前>`` から ``/proc/<thepid>/ns/net`` へのシンボリック・リンクを作成します。
* ``ip netns exec <何らかの名前> ....`` を実行します。

.. Please review Enumerating Cgroups to learn how to find the cgroup of a process running in the container of which you want to measure network usage. From there, you can examine the pseudo-file named tasks, which contains the PIDs that are in the control group (i.e., in the container). Pick any one of them.

ネットワーク使用状況を調査したいコンテナがあり、そこで実行しているプロセスを見つける方法を学ぶには、 :ref:`enumerating-cgroups` を読み直してください。ここからは ``tasks`` と呼ばれる疑似ファイルを例に、コントロール・グループ（つまり、コンテナ）の中にどのような PID があるかを調べましょう。

.. Putting everything together, if the “short ID” of a container is held in the environment variable $CID, then you can do this:

これらを一度に実行したら、取得したコンテナの「ショートID」は変数 ``$CID`` に入れて処理されます。

.. code-block:: bash

   $ TASKS=/sys/fs/cgroup/devices/docker/$CID*/tasks
   $ PID=$(head -n 1 $TASKS)
   $ mkdir -p /var/run/netns
   $ ln -sf /proc/$PID/ns/net /var/run/netns/$CID
   $ ip netns exec $CID netstat -i

.. Tips for high-performance metric collection

高性能なメトリクス収集用の Tip
========================================

.. Note that running a new process each time you want to update metrics is (relatively) expensive. If you want to collect metrics at high resolutions, and/or over a large number of containers (think 1000 containers on a single host), you do not want to fork a new process each time.

新しいプロセスごとに毎回メトリクスを更新するのは、（比較的）コストがかかるので注意してください。メトリクスを高い解像度で収集したい場合、そして／または、大量のコンテナを扱う場合（１ホスト上に 1,000 コンテナと考えます）、毎回新しいプロセスをフォークしようとは思わないでしょう。

.. Here is how to collect metrics from a single process. You will have to write your metric collector in C (or any language that lets you do low-level system calls). You need to use a special system call, setns(), which lets the current process enter any arbitrary namespace. It requires, however, an open file descriptor to the namespace pseudo-file (remember: that’s the pseudo-file in /proc/<pid>/ns/net).

ここでは１つのプロセスでメトリクスを収集する方法を紹介します。メトリクス・コレクションをC言語で書く必要があります（あるいは、ローレベルなシステムコールが可能な言語を使います）。 ``setns()`` という特別なシステムコールを使えば、任意の名前空間上にある現在のプロセスを返します。必要があれば、他にも名前空間疑似ファイルのファイル・ディスクリプタ（file descriptor）を開けます（思い出してください：疑似ファイルは ``/proc/<pid>/ns/net`` です）。

.. However, there is a catch: you must not keep this file descriptor open. If you do, when the last process of the control group exits, the namespace will not be destroyed, and its network resources (like the virtual interface of the container) will stay around for ever (or until you close that file descriptor).

しかしながら、これはキャッチするだけです。ファイルをオープンのままにできません。つまり、そのままにしておけば、コントロール・グループが終了しても名前空間を破棄できず、ネットワーク・リソース（コンテナの仮想インターフェース等）が残り続けるでしょう（あるいはファイル・ディスクリプタを閉じるまで）。

.. The right approach would be to keep track of the first PID of each container, and re-open the namespace pseudo-file each time.

適切なアプローチで、コンテナごとの最初の PID と、都度、名前空間の疑似ファイルが開かれるたびに、追跡し続ける必要があります。

.. Collecting metrics when a container exits

終了したコンテナのメトリクスを収集
========================================

.. Sometimes, you do not care about real time metric collection, but when a container exits, you want to know how much CPU, memory, etc. it has used.

時々、リアルタイムなメトリクス収集に気を配っていなくても、コンテナ終了時に、どれだけ CPU やメモリ等を使用したか知りたい時があるでしょう。

.. Docker makes this difficult because it relies on lxc-start, which carefully cleans up after itself, but it is still possible. It is usually easier to collect metrics at regular intervals (e.g., every minute, with the collectd LXC plugin) and rely on that instead.

Docker は ``lxc-start`` に依存しており、終了時は丁寧に自分自身をクリーンアップするため困難です。しかし、他にも方法があります。定期的にメトリクスを集める方法（例：毎分 collectd LXC プラグインを実行）が簡単です。

.. But, if you’d still like to gather the stats when a container stops, here is how:

しかし、停止したコンテナに関する情報を集めたい時もあるでしょう。次のようにします。

.. For each container, start a collection process, and move it to the control groups that you want to monitor by writing its PID to the tasks file of the cgroup. The collection process should periodically re-read the tasks file to check if it’s the last process of the control group. (If you also want to collect network statistics as explained in the previous section, you should also move the process to the appropriate network namespace.)

各コンテナで収集プロセスを開始し、コントロール・グループに移動します。これは対象の cgroup のタスクファイルに PID が書かれている場所を監視します。収集プロセスは定期的にタスクファイルを監視し、コントロール・グループの最新プロセスを確認します（先ほどのセクションで暑かったネットワーク統計情報も取得したい場合は、プロセスを適切なネットワーク名前空間にも移動します）。

.. When the container exits, lxc-start will try to delete the control groups. It will fail, since the control group is still in use; but that’s fine. You process should now detect that it is the only one remaining in the group. Now is the right time to collect all the metrics you need!

コンテナが終了すると、 ``lxc-start`` はコントロール・グループを削除しようとします。コントロール・グループが使用中のため、処理は失敗しますが問題ありません。自分で作ったプロセスは、対象のグループ内に自分しかいないことが分かります。それが必要なメトリックスを取得する適切なタイミングです。

.. Finally, your process should move itself back to the root control group, and remove the container control group. To remove a control group, just rmdir its directory. It’s counter-intuitive to rmdir a directory as it still contains files; but remember that this is a pseudo-filesystem, so usual rules don’t apply. After the cleanup is done, the collection process can exit safely.

最後に、自分のプロセスをルート・コントロール・グループに移動し、コンテナのコントロール・グループを削除します。コントロール・グループの削除は、ディレクトリを ``rmdir`` するだけです。感覚的にディレクトリに対する ``rmdir`` は、まだ中にファイルのではと思うかもしれませんが、これは疑似ファイルシステムのため、通常のルールは適用されません。クリーンアップが完了したら、これで収集プロセスを安全に終了できます。

.. seealso:: 

   Runtime metrics
      https://docs.docker.com/engine/admin/runmetrics/
