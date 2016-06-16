.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/ps/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/ps.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/ps.md
.. check date: 2016/06/16
.. Commits on Jun 7, 2016 7c46ba02e694ae540866b29ebf0dab76e556cc13
.. -------------------------------------------------------------------

.. ps

=======================================
ps
=======================================

.. code-block:: bash

   使い方: docker ps [オプション]
   
   コンテナの一覧
   
     -a, --all             全てのコンテナを表示 (デフォルトは実行中コンテナのみ表示)
     -f, --filter=[]       以下の状況に応じて出力をフィルタ:
                           - exited=<整数> 終了コードを <整数> で指定
                           - label=<key> または label=<key>=<value>
                           - status=(created|restarting|running|paused|exited)
                           - name=<文字列> コンテナ名
                           - id=<ID> コンテナ ID
                           - before=(<コンテナ名>|<コンテナID>)
                           - since=(<コンテナ名>|<コンテナID>)
                           - ancestor=(<イメージ名>[:タグ]|<イメージID>|<イメージ@ダイジェスト値>) - 特定のイメージや子孫から作成されたコンテナ
                           - volume=(<ボリューム名>|<マウント・ポイント>)
     --format=[]           Go テンプレートを使いコンテナの表示を整形
     --help                使い方の表示
     -l, --latest          最後に作成したコンテナを表示 (どのような状態でも)
     -n=-1                 直近で作成した n コンテナを表示 (どのような状態でも)
     --no-trunc            トランケート (truncate) を出力しない
     -q, --quiet           整数値の ID のみ表示
     -s, --size            合計ファイルサイズを表示

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. Running docker ps --no-trunc showing 2 linked containers.

``docker ps --no-trunc`` を実行すると、リンクされた２つのコンテナを表示します。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE                        COMMAND                CREATED              STATUS              PORTS               NAMES
   4c01db0b339c        ubuntu:12.04                 bash                   17 seconds ago       Up 16 seconds       3300-3310/tcp       webapp
   d7886598dbe2        crosbymichael/redis:latest   /redis-server --dir    33 minutes ago       Up 33 minutes       6379/tcp            redis,webapp/db

.. docker ps will show only running containers by default. To see all containers: docker ps -a

デフォルトの ``docker ps`` は実行中のコンテナだけ表示します。全てのコンテナを表示するには ``docker ps -a`` を使います。

.. docker ps will group exposed ports into a single range if possible. E.g., a container that exposes TCP ports 100, 101, 102 will display 100-102/tcp in the PORTS column.

``docker ps`` は、可能であれば公開ポートのグループを範囲で表示します。例えば、コンテナが ``100、101、102`` を公開している場合、 ``PORT`` 列に ``100-102/tcp`` と表示します。

.. Filtering

.. _ps-filtering:

フィルタリング
====================

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz")

フィルタリング・フラグ（ ``-f`` と ``--filter`` ）の形式は ``key=value`` の組です。複数のフィルタを指定するには、複数のフラグを使います（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現在、以下のフィルタをサポートします。

..    id (container’s id)
    label (label=<key> or label=<key>=<value>)
    name (container’s name)
    exited (int - the code of exited containers. Only useful with --all)
    status (created|restarting|running|paused|exited|dead)
    ancestor (<image-name>[:<tag>], <image id> or <image@digest>) - filters containers that were created from the given image or a descendant.
   before (container's id or name) - filters containers created before given id or name
   since (container's id or name) - filters containers created since given id or name
   isolation (default|process|hyperv) (Windows daemon only)
   volume (volume name or mount point) - filters containers that mount volumes.
   network (network id name) - filters containers connected to the provided network

* id（コンテナの ID）
* label（ ``label=<key>`` か ``label=<key>=<value>`` ）
* name（コンテナの名前）
* exited（整数値 - コンテナの終了コード。実用的なのは ``--all``）
* status（created|restarting|running|paused|exited|dead）
* ancestor（ ``<イメージ名>[:<タグ>]`` 、 ``<イメージID>`` 、 ``<イメージ@digest>`` ） - 特定のイメージから作られた子コンテナを作成します。
* before（コンテナ ID か名前） - 指定した ID か名前よりも前に作成したコンテナでフィルタ
* since（コンテナ ID か名前） - 指定した ID か名前よりも後に作成したコンテナでフィルタ
* isolation （default|process|hyperv）（Windows デーモンのみ）
* volume（ボリューム名かマウントポイント） - コンテナがマウントしているボリュームでフィルタ
* network（ネットワーク ID か名前）- コンテナが接続しているネットワークでフィルタ

.. Label

.. _ps-label:

label
----------

.. The label filter matches containers based on the presence of a label alone or a label and a value.

``label`` フィルタに一致する条件は、コンテナ自身に割り当てられている ``label`` か、その ``label`` と値です。

.. The following filter matches containers with the color label regardless of its value.

次のフィルタは、 ``color`` ラベルがどのような値を持っているかに拘わらず、一致するものを表示します。

.. code-block:: bash

   $ docker ps --filter "label=color"
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
   673394ef1d4c        busybox             "top"               47 seconds ago      Up 45 seconds                           nostalgic_shockley
   d85756f57265        busybox             "top"               52 seconds ago      Up 51 seconds                           high_albattani

.. The following filter matches containers with the color label with the blue value.

次のフィルタは ``color`` ラベルの値が ``blue`` に一致するコンテナを表示します。

.. code-block:: bash

   $ docker ps --filter "label=color=blue"
   CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
   d85756f57265        busybox             "top"               About a minute ago   Up About a minute                       high_albattani

.. Name

.. _ps-name:

name
----------

.. The name filter matches on all or part of a container’s name.

``name`` フィルタはコンテナ名の全て、または一部に一致するコンテナを表示します。

.. The following filter matches all containers with a name containing the nostalgic_stallman string.

次のフィルタは ``nostalgic_stallman`` 文字列を含む名前のコンテナを表示します。

.. code-block:: bash

   $ docker ps --filter "name=nostalgic_stallman"
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
   9b6247364a03        busybox             "top"               2 minutes ago       Up 2 minutes                            nostalgic_stallman

.. You can also filter for a substring in a name as this shows:

あるいは、一部が一致する場合でも、次のようにフィルタできます。

.. code-block:: bash

   $ docker ps --filter "name=nostalgic"
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
   715ebfcee040        busybox             "top"               3 seconds ago       Up 1 seconds                            i_am_nostalgic
   9b6247364a03        busybox             "top"               7 minutes ago       Up 7 minutes                            nostalgic_stallman
   673394ef1d4c        busybox             "top"               38 minutes ago      Up 38 minutes                           nostalgic_shockley

.. Exited

exited
----------

.. The exited filter matches containers by exist status code. For example, to filter for containers that have exited successfully:

``exited`` は、コンテナの終了コードに一致するものでフィルタします。例えば、正常終了したコンテナでフィルタをするには、次のようにします。

.. code-block:: bash

   $ docker ps -a --filter 'exited=0'
   CONTAINER ID        IMAGE             COMMAND                CREATED             STATUS                   PORTS                      NAMES
   ea09c3c82f6e        registry:latest   /srv/run.sh            2 weeks ago         Exited (0) 2 weeks ago   127.0.0.1:5000->5000/tcp   desperate_leakey
   106ea823fe4e        fedora:latest     /bin/sh -c 'bash -l'   2 weeks ago         Exited (0) 2 weeks ago                              determined_albattani
   48ee228c9464        fedora:20         bash                   2 weeks ago         Exited (0) 2 weeks ago                              tender_torvalds


.. Status

status
----------

.. The status filter matches containers by status. You can filter using created, restarting, running, paused and exited. For example, to filter for running containers:

.. The status filter matches containers by status. You can filter using created, restarting, running, paused, exited and dead. For example, to filter for running containers:

``status`` はコンテナの状態が一致するものでフィルタします。フィルタとして使えるのは ``created`` 、 ``restarting`` 、 ``running`` 、 ``paused`` 、 ``exited`` 、 ``dead`` です。例えば、 ``running`` （実行中）のコンテナでフィルタするには、次のようにします。

.. code-block:: bash

   $ docker ps --filter status=running
   CONTAINER ID        IMAGE                  COMMAND             CREATED             STATUS              PORTS               NAMES
   715ebfcee040        busybox                "top"               16 minutes ago      Up 16 minutes                           i_am_nostalgic
   d5c976d3c462        busybox                "top"               23 minutes ago      Up 23 minutes                           top
   9b6247364a03        busybox                "top"               24 minutes ago      Up 24 minutes                           nostalgic_stallman

.. To filter for paused containers:

``paused`` コンテナでフィルタをするには：

.. code-block:: bash

   $ docker ps --filter status=paused
   CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                      PORTS               NAMES
   673394ef1d4c        busybox             "top"               About an hour ago   Up About an hour (Paused)                       nostalgic_shockley

.. Ancestor

ancestor
----------

.. The ancestor filter matches containers based on its image or a descendant of it. The filter supports the following image representation:

``ancestor`` （先祖）フィルタはコンテナのベースとなったイメージや、その派生に一致するものです。フィルタは以下の形式で指定できます。

..    image
    image:tag
    image:tag@digest
    short-id
    full-id

* イメージ
* イメージ:タグ
* イメージ:タグ@digest
* ショート ID
* フル ID

.. If you don’t specify a tag, the latest tag is used. For example, to filter for containers that use the latest ubuntu image:

``タグ`` を指定しなければ、 ``latest`` タグが使われます。例えば、最新（latest）の ``ubuntu`` イメージでフィルタするには：

.. code-block:: bash

   $ docker ps --filter ancestor=ubuntu
   CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
   919e1179bdb8        ubuntu-c1           "top"               About a minute ago   Up About a minute                       admiring_lovelace
   5d1e4a540723        ubuntu-c2           "top"               About a minute ago   Up About a minute                       admiring_sammet
   82a598284012        ubuntu              "top"               3 minutes ago        Up 3 minutes                            sleepy_bose
   bab2a34ba363        ubuntu              "top"               3 minutes ago        Up 3 minutes                            focused_yonath

.. Match containers based on the ubuntu-c1 image which, in this case, is a child of ubuntu:

``ubuntu-c1`` イメージをベースにするコンテナ、この例では ``ubuntu``  の子供に一致するものを表示：

.. code-block:: bash

   $ docker ps --filter ancestor=ubuntu-c1
   CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
   919e1179bdb8        ubuntu-c1           "top"               About a minute ago   Up About a minute                       admiring_lovelace

.. Match containers based on the ubuntu version 12.04.5 image:

``ubuntu`` バージョン ``12.04.5``  のイメージをベースとするコンテナをフィルタ：

.. code-block:: bash

   $ docker ps --filter ancestor=ubuntu:12.04.5
   CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
   82a598284012        ubuntu:12.04.5      "top"               3 minutes ago        Up 3 minutes                            sleepy_bose

.. The following matches containers based on the layer d0e008c6cf02 or an image that have this layer in it’s layer stack.

レイヤ ``d0e008c6cf02`` あるいはイメージをベースにしたコンテナでフィルタします。

.. code-block:: bash

    $ docker ps --filter ancestor=d0e008c6cf02
   CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
   82a598284012        ubuntu:12.04.5      "top"               3 minutes ago        Up 3 minutes                            sleepy_bose

.. Before

before
----------

.. The before filter shows only containers created before the container with given id or name. For example, having these containers created:

``before`` フィルタは、指定したコンテナ ID か名前よりも前に作成したコンテナのみ表示します。たとえば、３つのコンテナを作成しているとします。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE       COMMAND       CREATED              STATUS              PORTS              NAMES
   9c3527ed70ce        busybox     "top"         14 seconds ago       Up 15 seconds                          desperate_dubinsky
   4aace5031105        busybox     "top"         48 seconds ago       Up 49 seconds                          focused_hamilton
   6e63f6ff38b0        busybox     "top"         About a minute ago   Up About a minute                      distracted_fermat

.. Filtering with before would give:

``before`` を指定してフィルタリングします。

.. code-block:: bash

   $ docker ps -f before=9c3527ed70ce
   CONTAINER ID        IMAGE       COMMAND       CREATED              STATUS              PORTS              NAMES
   4aace5031105        busybox     "top"         About a minute ago   Up About a minute                      focused_hamilton
   6e63f6ff38b0        busybox     "top"         About a minute ago   Up About a minute                      distracted_fermat

.. Since

since
----------

.. The since filter shows only containers created since the container with given id or name. For example, with the same containers as in before filter:

``since`` フィルタは、指定したコンテナ ID か名前よりも後に作成したコンテナのみ表示します。次の例は、 ``before`` フィルタの時と同じコンテナを表示します。

.. code-block:: bash

   $ docker ps -f since=6e63f6ff38b0
   CONTAINER ID        IMAGE       COMMAND       CREATED             STATUS              PORTS               NAMES
   9c3527ed70ce        busybox     "top"         10 minutes ago      Up 10 minutes                           desperate_dubinsky
   4aace5031105        busybox     "top"         10 minutes ago      Up 10 minutes                           focused_hamilton

.. Volume

volume
----------

.. The volume filter shows only containers that mount a specific volume or have a volume mounted in a specific path:

``volume`` フィルタは特定のボリュームをマウントしているコンテナか、特定のパスをマウントしているコンテナを表示します。

.. code-block:: bash

   $ docker ps --filter volume=remote-volume --format "table {{.ID}}\t{{.Mounts}}"
   CONTAINER ID        MOUNTS
   9c3527ed70ce        remote-volume
   
   $ docker ps --filter volume=/data --format "table {{.ID}}\t{{.Mounts}}"
   CONTAINER ID        MOUNTS
   9c3527ed70ce        remote-volume

.. Network

network
----------

.. The network filter shows only containers that has endpoints on the provided network name or id

``network`` フィルタは、指定したネットワーク名か id をエンドポイントとして持っているコンテナのみ表示します。

.. The following filter matches all containers that are connected to a network with a name containing net1.

以下のフィルタは接続しているネットワーク名に ``net1`` を含む、全てのコンテナを表示します。

.. code-block:: bash

   $ docker run -d --net=net1 --name=test1 ubuntu top
   $ docker run -d --net=net2 --name=test2 ubuntu top
   
   $ docker ps --filter network=net1
   CONTAINER ID        IMAGE       COMMAND       CREATED             STATUS              PORTS               NAMES
   9d4893ed80fe        ubuntu      "top"         10 minutes ago      Up 10 minutes                           test1

.. The network filter matches on both the network's name and id. The following example shows all containers that are attached to the net1 network, using the network id as a filter;

ネットワーク・フィルタはネットワーク名または ID にマッチします。次の例は ``net1`` ネットワークにアタッチしている全てのコンテナを表示します。ここではネットワーク ID でフィルタします。

.. code-block:: bash

   $ docker network inspect --format "{{.ID}}" net1
   8c0b4110ae930dbe26b258de9bc34a03f98056ed6f27f991d32919bfe401d7c5
   
   $ docker ps --filter network=8c0b4110ae930dbe26b258de9bc34a03f98056ed6f27f991d32919bfe401d7c5
   CONTAINER ID        IMAGE       COMMAND       CREATED             STATUS              PORTS               NAMES
   9d4893ed80fe        ubuntu      "top"         10 minutes ago      Up 10 minutes                           test1

.. Formatting

.. _ps-formatting:

フォーマット
====================

.. The formatting option (--format) will pretty-print container output using a Go template.

フォーマットのオプション（ ``--format`` ）は Go テンプレートを使いコンテナの出力を整形します。

.. Valid placeholders for the Go template are listed below:

Go テンプレートで置き換え可能な一覧は、次の通りです：

.. Placeholder 	Description
   .ID 	Container ID
   .Image 	Image ID
   .Command 	Quoted command
   .CreatedAt 	Time when the container was created.
   .RunningFor 	Elapsed time since the container was started.
   .Ports 	Exposed ports.
   .Status 	Container status.
   .Size 	Container disk size.
   .Names 	Container names.
   .Labels 	All labels assigned to the container.
   .Label 	Value of a specific label for this container. For example {{.Label "com.docker.swarm.cpu"}}

.. list-table::
   
   * - ``.ID``
     - コンテナ ID
   * - ``.Image``
     - イメージ ID
   * - ``.Command``
     - クォートされたコマンド
   * - ``.CreatedAt``
     - コンテナが作成された時間
   * - ``.RunningFor``
     - コンテナが起動してからの時間
   * - ``.Ports``
     - 公開しているポート
   * - ``.Status``
     - コンテナのステータス
   * - ``.Size``
     - コンテナのディスク容量
   * - ``.Names``
     - コンテナ名
   * - ``.Labels``
     - コンテナに割り当てられている全てのラベル
   * - ``.Label``
     - コンテナに割り当てられた特定のラベル。例： ``{{.Label "com.docker.swarm.cpu"}}``

.. When using the --format option, the ps command will either output the data exactly as the template declares or, when using the table directive, will include column headers as well.

``ps`` コマンドに ``--format`` オプションを使えば、テンプレートで指定したデータを出力するだけでなく、 ``table`` 命令を使うとカラム（例）ヘッダも同様に表示します。

.. The following example uses a template without headers and outputs the ID and Command entries separated by a colon for all running containers:

次の例はヘッダを除くテンプレートを使い、実行中の全てのコンテナに対して、 ``ID`` と ``Command`` エントリを句切って出力します。

.. code-block:: bash

   $ docker ps --format "{{.ID}}: {{.Command}}"
   a87ecb4f327c: /bin/sh -c #(nop) MA
   01946d9d34d8: /bin/sh -c #(nop) MA
   c1d3b0166030: /bin/sh -c yum -y up
   41d50ecd2f57: /bin/sh -c #(nop) MA

.. To list all running containers with their labels in a table format you can use:

実行中のコンテナのラベルを表形式で出力するには、次のようにします。

.. code-block:: bash

   $ docker ps --format "table {{.ID}}\t{{.Labels}}"
   CONTAINER ID        LABELS
   a87ecb4f327c        com.docker.swarm.node=ubuntu,com.docker.swarm.storage=ssd
   01946d9d34d8
   c1d3b0166030        com.docker.swarm.node=debian,com.docker.swarm.cpu=6
   41d50ecd2f57        com.docker.swarm.node=fedora,com.docker.swarm.cpu=3,com.docker.swarm.storage=ssd

.. seealso:: 

   ps
      https://docs.docker.com/engine/reference/commandline/ps/
