.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stats/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/stats.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_stats.yaml
.. check date: 2022/03/27
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker stats

=======================================
docker stats
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_save-description:

説明
==========

.. Display a live stream of container(s) resource usage statistics

コンテナのリソース使用統計情報をライブストリームで表示します。

.. _docker_stats-usage:

使い方
==========

.. code-block:: bash

   $ docker stats [OPTIONS] [CONTAINER...]

.. Extended description
.. _docker_stats-extended-description:

補足説明
==========

.. The docker stats command returns a live data stream for running containers. To limit data to one or more specific containers, specify a list of container names or ids separated by a space. You can specify a stopped container but stopped containers do not return any data.

``docker stats`` コマンドは実行中のコンテナからライブ・データ・ストリームを返します。特定コンテナの情報のみを取得するには、コンテナ名またはコンテナ ID をスペース区切りで追加します。ここでは停止しているコンテナも指定できますが、停止中のコンテナは何も返しません。

.. If you want more detailed information about a container’s resource usage, use the /containers/(id)/stats API endpoint.

コンテナのリソース使用詳細を知りたい場合は、 ``/containers/(id)/stats`` API エンドポイントを使います。

..    Note
    On Linux, the Docker CLI reports memory usage by subtracting cache usage from the total memory usage. The API does not perform such a calculation but rather provides the total memory usage and the amount from the cache so that clients can use the data as needed. The cache usage is defined as the value of total_inactive_file field in the memory.stat file on cgroup v1 hosts.
    On Docker 19.03 and older, the cache usage was defined as the value of cache field. On cgroup v2 hosts, the cache usage is defined as the value of inactive_file field.

.. note::

   Linux では、 Docker CLI は合計メモリ使用量から、キャッシュを差し引いた容量を表示します。このような計算処理を API は行いませんが、合計メモリ使用量とキャッシュ使用量を表示しますので、必要に応じてクライアントがデータを使えます。キャッシュ使用量が定義されているのは、 cgroup v1 ホスト上の ``memory.stat`` ファイルにある ``total_inactive_file`` フィールドです。
   
   Docker 19.03 より以前では、キャッシュ使用量は ``cache`` フィールドで定義されていました。cgroup v2 ホストでは、キャッシュ使用率は ``inactive_file`` フィールドの値で定義されています。

..    Note
    The PIDS column contains the number of processes and kernel threads created by that container. Threads is the term used by Linux kernel. Other equivalent terms are “lightweight process” or “kernel task”, etc. A large number in the PIDS column combined with a small number of processes (as reported by ps or top) may indicate that something in the container is creating many threads.

.. note::

   ``PIDS`` 列には、対象コンテナによって作成されたプロセス数とカーネルスレッド数を含みます。スレッドとは Linux カーネルによって使われている用語です。他の同等の用語は「 :ruby:`軽量なプロセス <lightweight process>` 」や「 :ruby:`カーネル タスク <kernel task>`」等です。 ``PIDS`` 列の大きな数値は、小さなプロセス数（ ``ps`` や ``top`` で表示 ）の連結のため、コンテナによって多くのスレッドが作成されているのが分かります。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_stats-examples>` をご覧ください。

.. _docker_start-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--all`` , ``-a``
     - 
     - 全てのコンテナを表示（デフォルトは実行中のみ表示）
   * - ``--format``
     - 
     - Go テンプレートを使って表示を形成
   * - ``--no-stream``
     - 
     - 情報表示のストリーミングを無効化し、1つめの結果のみ表示
   * - ``--no-trunc``
     - 
     - 表示を :ruby:`省略しない <truncate>`

.. Examples
.. _docker_stats-examples:

使用例
==========

.. Running docker stats on all running containers against a Linux daemon.

``docker stats`` を実行すると、 Linux デーモンで実行中のコンテナ全てを表示します。

.. code-block:: bash

   $ docker stats
   CONTAINER ID        NAME                                    CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O           PIDS
   b95a83497c91        awesome_brattain                        0.28%               5.629MiB / 1.952GiB   0.28%               916B / 0B           147kB / 0B          9
   67b2525d8ad1        foobar                                  0.00%               1.727MiB / 1.952GiB   0.09%               2.48kB / 0B         4.11MB / 0B         2
   e5c383697914        test-1951.1.kay7x1lh1twk9c0oig50sd5tr   0.00%               196KiB / 1.952GiB     0.01%               71.2kB / 0B         770kB / 0B          1
   4bda148efbc0        random.1.vnc8on831idyr42slu578u3cr      0.00%               1.672MiB / 1.952GiB   0.08%               110kB / 0B          578kB / 0B          2

.. If you don’t specify a format string using --format, the following columns are shown.

:ref:`--format を使ってフォーマット文字を指定 <docker_stats-formatting>` しない場合、以下の列を表示します。

.. list-table::
   :header-rows: 1

   * - 列の名前
     - 説明
   * - ``CONTAINER ID`` と ``Name``
     - コンテナの ID と名前
   * - ``CPU %`` と ``MEM %``
     - ホスト上の CPU とメモリを、コンテナがどれだけ使っているかパーセントで表示
   * - ``MEM USAGE / LIMIT``
     - コンテナが使っている合計メモリ容量と、利用が許可されている合計メモリ容量
   * - ``NET I/O``
     - コンテナが自身のネットワークインターフェースを通して送受信したデータ容量
   * - ``BLOCK I/O``
     - コンテナがホスト上のブロックデバイスから読み書きしたデータ容量
   * - ``PIDs``
     - コンテナが作成したプロセス数またはスレッド数

.. Running docker stats on multiple containers by name and id against a Linux daemon.

Linux デーモンに対し、複数のコンテナ名か ID で ``docker stats`` を実行します。

.. code-block:: bash

   $ docker stats awesome_brattain 67b2525d8ad1
   
   CONTAINER ID        NAME                CPU %               MEM USAGE / LIMIT     MEM %               NET I/O             BLOCK I/O           PIDS
   b95a83497c91        awesome_brattain    0.28%               5.629MiB / 1.952GiB   0.28%               916B / 0B           147kB / 0B          9
   67b2525d8ad1        foobar              0.00%               1.727MiB / 1.952GiB   0.09%               2.48kB / 0B         4.11MB / 0B         2

.. Running docker stats with customized format on all (Running and Stopped) containers.

全ての（実行中および停止中の）コンテナを、任意の表示形式になるよう ``docker stats`` を実行します。

.. code-block:: bash

   $ docker stats --all --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}" fervent_panini 5acfcb1b4fd1 drunk_visvesvaraya big_heisenberg
   
   CONTAINER                CPU %               MEM USAGE / LIMIT
   fervent_panini           0.00%               56KiB / 15.57GiB
   5acfcb1b4fd1             0.07%               32.86MiB / 15.57GiB
   drunk_visvesvaraya       0.00%               0B / 0B
   big_heisenberg           0.00%               0B / 0B

.. drunk_visvesvaraya and big_heisenberg are stopped containers in the above example.

上の例では ``drunk_visvesvaraya`` と ``big_heisenberg`` が停止済みのコンテナです。

.. Running docker stats on all running containers against a Windows daemon.

Windows デーモンに対し、 ``docker stats`` を全ての実行中のコンテナを表示します。

.. code-block:: bash

   PS E:\> docker stats
   CONTAINER ID        CPU %               PRIV WORKING SET    NET I/O             BLOCK I/O
   09d3bb5b1604        6.61%               38.21 MiB           17.1 kB / 7.73 kB   10.7 MB / 3.57 MB
   9db7aa4d986d        9.19%               38.26 MiB           15.2 kB / 7.65 kB   10.6 MB / 3.3 MB
  3 f214c61ad1d        0.00%               28.64 MiB           64 kB / 6.84 kB     4.42 MB / 6.93 MB

.. Running docker stats on multiple containers by name and id against a Windows daemon.

Windows デーモンに対し、複数のコンテナ名か ID で ``docker stats`` を実行します。

.. code-block:: bash

   PS E:\> docker ps -a
   CONTAINER ID        NAME                IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
   3f214c61ad1d        awesome_brattain    nanoserver          "cmd"               2 minutes ago       Up 2 minutes                            big_minsky
   9db7aa4d986d        mad_wilson          windowsservercore   "cmd"               2 minutes ago       Up 2 minutes                            mad_wilson
   09d3bb5b1604        fervent_panini      windowsservercore   "cmd"               2 minutes ago       Up 2 minutes                            affectionate_easley
   
   PS E:\> docker stats 3f214c61ad1d mad_wilson
   CONTAINER ID        NAME                CPU %               PRIV WORKING SET    NET I/O             BLOCK I/O
   3f214c61ad1d        awesome_brattain    0.00%               46.25 MiB           76.3 kB / 7.92 kB   10.3 MB / 14.7 MB
   9db7aa4d986d        mad_wilson          9.59%               40.09 MiB           27.6 kB / 8.81 kB   17 MB / 20.1 MB

.. Formatting
.. _docker_stats-formatting:

フォーマット（表示形式）
------------------------------

.. The formatting option (--format) pretty prints container output using a Go template.

表示形式のオプション（ ``--format`` ）は Go テンプレートを使ってコンテナの出力を整えます。

.. Valid placeholders for the Go template are listed below:

有効な Go テンプレート用のプレースホルダは以下の通りです。

.. list-table::
   :header-rows: 1

   * - プレースホルダ
     - 説明
   * - ``.Container``
     - コンテナ名か ID（ユーザ入力）
   * - ``.Name``
     - コンテナ名
   * - ``.ID``
     - コンテナ ID
   * - ``.CPUPerc``
     - CPU パーセンテージ
   * - ``.MemUsage``
     - メモリ利用量
   * - ``.NetIO``
     - ネットワーク IO
   * - ``.BlockIO``
     - ブロック IO
   * - ``.MemPerc``
     - メモリのパーセンテージ（Windows 上では利用できない）
   * - ``.PIDs``
     - PID数（Windows 上では利用できない）

.. When using the --format option, the stats command either outputs the data exactly as the template declares or, when using the table directive, includes column headers as well.

``--format`` オプションを使うと、 ``stats`` コマンドはテンプレートで宣言した通りにデータを確実に出力するか、 ``table`` 命令を使って列ヘッダも含みながら同様に表示するかのいずれかです。

.. The following example uses a template without headers and outputs the Container and CPUPerc entries separated by a colon (:) for all images:

以下の例は、テンプレートを使いますがヘッダを表示せず、全てのイメージを ``Container`` と ``CPUPerc`` エントリをコロン（ ``:`` ）で区切り表示します。

.. code-block:: bash

   $ docker stats --format "{{.Container}}: {{.CPUPerc}}"
   
   09d3bb5b1604: 6.61%
   9db7aa4d986d: 9.19%
   3f214c61ad1d: 0.00%

.. To list all containers statistics with their name, CPU percentage and memory usage in a table format you can use:

全てのコンテナの名前、CPU パーセンテージ、メモリ使用量といった統計情報を、表形式で表示するには次のようにします。

.. code-block:: bash

   $ docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"
   
   CONTAINER           CPU %               PRIV WORKING SET
   1285939c1fd3        0.07%               796 KiB / 64 MiB
   9c76f7834ae2        0.07%               2.746 MiB / 64 MiB
   d1ea048f04e4        0.03%               4.583 MiB / 64 MiB

.. The default format is as follows:

デフォルトの表示形式は、以下の通りです。

.. On Linux:

Linux：

::

   "table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}\t{{.PIDs}}"

.. On Windows:

Windows：

::

   "table {{.ID}}\t{{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker stats
      https://docs.docker.com/engine/reference/commandline/stats/
