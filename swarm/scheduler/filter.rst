.. https://docs.docker.com/swarm/scheduler/filter/
.. doc version: 1.9
.. check date: 2015/12/16

.. Filters

==============================
フィルタ
==============================

.. The Docker Swarm scheduler comes with multiple filters.

``Docker Swarm``  スケジューラは複数のフィルタを持っています。

.. The following filters are currently used to schedule containers on a subset of nodes:

ノードの一部（サブセット）にコンテナをスケジュールする時、次のフィルタが利用できます。

..  Constraint
    Affinity
    Port
    Dependency
    Health

* :ref:`Constraint（コンストレイント） <constraint_filter>`
* :ref:`Affinity（アフィニティ） <affinity_filter>`
* :ref:`Port（ポート） <port_filter>`
* :ref:`Dependency（依存関係） <dependency_filter>`
* :ref:`Health（ヘルス状態） <health_filter>`

.. You can choose the filter(s) you want to use with the --filter flag of swarm manage

利用可能なフィルタを指定するには、 ``swarm manage`` の実行時に ``--filter`` フラグを使って指定します。

.. _constraint_filter:

.. Constraint Filter

Constraint （コンストレイント）フィルタ
========================================

.. Constraints are key/value pairs associated to particular nodes. You can see them as node tags.

Constraint（訳者注：制約や制限の意味）は、特定のノードをキー・バリューの組で結び付けます。これらの情報は *node* のタグとして確認できます。

.. When creating a container, the user can select a subset of nodes that should be considered for scheduling by specifying one or more sets of matching key/value pairs. This approach has several practical use cases such as:

コンテナを作成時、ノードを配置するグループ（サブセット）を選べます。グループとは、コンテナのスケジューリングにあたり、１つまたは複数のキー・バリューの組が一致すると考えられるものです。この方法には、複数の指定方法があります。

..    Selecting specific host properties (such as storage=ssd, in order to schedule containers on specific hardware).
    Tagging nodes based on their physical location (region=us-east, to force containers to run on a given location).
    Logical cluster partitioning (environment=production, to split a cluster into sub-clusters with different properties).


* ホスト・プロパティを指定した選択（ ``storage=ssd`` のように、特定のハードウェアにコンテナをスケジュールするため）
* ノードの基盤に、物理的な場所をタグ付けする（ ``region=us-ease`` のように、指定した場所でコンテナを強制的に実行）
* 論理的なクラスタの分割（ ``environment=production`` のように、プロパティの違いによりクラスタを複数のサブクラスタに分割）

.. To tag a node with a specific set of key/value pairs, one must pass a list of --label options at docker startup time.

ノードに対して特定のキー・バリューの組み合わせをタグ付けするには、docker 起動時のオプションで、少なくとも１つの ``--label`` 指定が必要です。

.. For instance, let’s start node-1 with the storage=ssd label:

例えば、 ``node-1`` を起動するとき ``storage=ssd`` ラベルを付けてみましょう。

.. code-block:: bash

   $ docker -d --label storage=ssd
   $ swarm join --advertise=192.168.0.42:2375 token://XXXXXXXXXXXXXXXXXX

.. Again, but this time node-2 with storage=disk:

ただし次は ``node-2`` を ``storage=disk`` で起動します：

.. code-block:: bash

   $ docker -d --label storage=disk
   $ swarm join --advertise=192.168.0.43:2375 token://XXXXXXXXXXXXXXXXXX

.. Once the nodes are registered with the cluster, the master pulls their respective tags and will take them into account when scheduling new containers.

ノードがクラスタに登録されると、マスタは各々のタグを取得し、新しいコンテナをスケジューリングするときにそれらを反映します。

.. Let’s start a MySQL server and make sure it gets good I/O performance by selecting nodes with flash drives:

それでは MySQL サーバを起動し、良い I/O 性能を持つフラッシュ・ドライブ上で利用できるようにしましょう：

.. code-block:: bash

   $ docker run -d -P -e constraint:storage==ssd --name db mysql
   f8b693db9cd6
   
   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NODE        NAMES
   f8b693db9cd6        mysql:latest        "mysqld"            Less than a second ago   running             192.168.0.42:49178->3306/tcp    node-1      db

.. In this case, the master selected all nodes that met the storage=ssd constraint and applied resource management on top of them, as discussed earlier. node-1 was selected in this example since it’s the only host running flash.

この例では、マスタは選択された全てのノードから、事前に指定された ``storage=ssd`` を強制したリソース管理を適用します。 ``node-1`` は フラッシュ・ドライブ上で動いているホストが選ばれています。

.. Now we want to run an Nginx frontend in our cluster. However, we don’t want flash drives since we’ll mostly write logs to disk.

次はクラスタ上に Nginx フロントエンドを走らせてみます。ですが、ログをディスクに沢山書き込むのでフラッシュ・ドライブを使いたくありません。

.. code-block:: bash

   $ docker run -d -P -e constraint:storage==disk --name frontend nginx
   963841b138d8
   
   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NODE        NAMES
   963841b138d8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.43:49177->80/tcp      node-2      frontend
   f8b693db9cd6        mysql:latest        "mysqld"            Up About a minute        running             192.168.0.42:49178->3306/tcp    node-1      db

.. The scheduler selected node-2 since it was started with the storage=disk label.

スケジューラは ``storage=disk`` ラベルを付けて起動済みの ``node-2`` で起動します。

.. Standard Constraints

標準制約（Standard Constraint）
========================================

.. Additionally, a standard set of constraints can be used when scheduling containers without specifying them when starting the node. Those tags are sourced from docker info and currently include:

さらに、ノードを開始するときに特に指定していなくても、コンテナのスケジュールに使う標準 constraint セットを使えます。これらのタグは docker info で確認できるものです。現在利用できるのは次の通りです。

..     node ID or node Name (using key “node”)
    storagedriver
    executiondriver
    kernelversion
    operatingsystem

* ノード ID またはノード名（"node" をキーに用いる）
* storagedriver（ストレージ・ドライバ）
* executiondriver（実行ドライバ）
* kernelversion（カーネルバージョン）
* operatingsystem（オペレーティング・システム）


.. _affinity_filter:

.. Affinity filter

Affinity（アフィニティ）フィルタ
========================================

.. You use an --affinity:<filter> to create “attractions” between containers. For example, you can run a container and instruct it to locate and run next to another container based on an identifier, an image, or a label. These attractions ensure that containers run on the same network node — without you having to know what each node is running.

コンテナ間を"引き寄せて" を作成するのに、--affinity:<フィルタ> を使うことができます（訳者注：affinity とは親密さの意味）。例えば、あるコンテナを実行したとします。別のコンテナを実行するとき、特定のイメージやラベルを持つコンテナのある場所で実行できます。この引き寄せ機能によって、コンテナを同じネットワーク・ノード上で確実に動かせます。そのとき、どのノードで実行しているかを知る必要はありません。

.. Container affinity

コンテナの親密さ（affinity）
------------------------------

.. You can schedule a new container to run next to another based on a container name or ID. For example, you can start a container called frontend running nginx:

新しいコンテナを、既存のコンテナ名や ID を基にしてスケジューリングできます。例えば、 ``frontend`` という名前で ``nginx``  を実行します。

.. code-block:: bash

   $ docker run -d -p 80:80 --name frontend nginx
    87c4376856a8
   
   
   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NODE        NAMES
   87c4376856a8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:80->80/tcp         node-1      frontend

.. Then, using -e affinity:container==frontend flag schedule a second container to locate and run next to frontend.

それから、 ``-e affinity:container==frontend`` フラグを使い、２つめのコンテナを ``frontend`` の隣にスケジュールします。

.. code-block:: bash

   $ docker run -d --name logger -e affinity:container==frontend logger
    87c4376856a8
   
   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NODE        NAMES
   87c4376856a8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:80->80/tcp         node-1      frontend
   963841b138d8        logger:latest       "logger"            Less than a second ago   running                                             node-1      logger

.. Because of name affinity, the logger container ends up on node-1 along with the frontend container. Instead of the frontend name you could have supplied its ID as follows:

963841b138d8        logger:latest       "logger"            Less than a second ago   running                                             node-1      logge

コンテナ名のアフィニティ指定によって、 ``logger`` コンテナは ``frontend`` コンテナと同じ ``node-1`` コンテナで実行されることになります。``frontend`` という名前だけでなく、次のように ID を使った指定もできます

.. code-block:: bash

   docker run -d --name logger -e affinity:container==87c4376856a8`

.. Image affinity

イメージ・アフィニティ
------------------------------

.. You can schedule a container to run only on nodes where a specific image is already pulled.

コンテナを起動するとき、特定のイメージをダウンロード済みのノードのみにスケジュールすることができます。

.. code-block:: bash

   $ docker -H node-1:2375 pull redis
   $ docker -H node-2:2375 pull mysql
   $ docker -H node-3:2375 pull redis

.. Only node-1 and node-3 have the redis image. Specify a -e affinity:image==redis filter to schedule several additional containers to run on these nodes.

``node-1`` と ``node-3`` のみが `` redis`` イメージを持っています。 ``-e affinity:image==redis`` フィルタを使い、これらのノード上でスケジュールします。

.. code-block:: bash

   $ docker run -d --name redis1 -e affinity:image==redis redis
   $ docker run -d --name redis2 -e affinity:image==redis redis
   $ docker run -d --name redis3 -e affinity:image==redis redis
   $ docker run -d --name redis4 -e affinity:image==redis redis
   $ docker run -d --name redis5 -e affinity:image==redis redis
   $ docker run -d --name redis6 -e affinity:image==redis redis
   $ docker run -d --name redis7 -e affinity:image==redis redis
   $ docker run -d --name redis8 -e affinity:image==redis redis
   
   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NODE        NAMES
   87c4376856a8        redis:latest        "redis"             Less than a second ago   running                                             node-1      redis1
   1212386856a8        redis:latest        "redis"             Less than a second ago   running                                             node-1      redis2
   87c4376639a8        redis:latest        "redis"             Less than a second ago   running                                             node-3      redis3
   1234376856a8        redis:latest        "redis"             Less than a second ago   running                                             node-1      redis4
   86c2136253a8        redis:latest        "redis"             Less than a second ago   running                                             node-3      redis5
   87c3236856a8        redis:latest        "redis"             Less than a second ago   running                                             node-3      redis6
   87c4376856a8        redis:latest        "redis"             Less than a second ago   running                                             node-3      redis7
   963841b138d8        redis:latest        "redis"             Less than a second ago   running                                             node-1      redis8

.. As you can see here, the containers were only scheduled on nodes that had the redis image. Instead of the image name, you could have specified the image ID.

ここで見えるように、コンテナがスケジュールされるのは ``redis`` イメージを持っているノードのみです。イメージ名に加えて、特定のイメージ ID も指定できます。

.. code-block:: bash

   $ docker images
   REPOSITORY                         TAG                       IMAGE ID            CREATED             VIRTUAL SIZE
   redis                              latest                    06a1f75304ba        2 days ago          111.1 MB
   
   $ docker run -d --name redis1 -e affinity:image==06a1f75304ba redis

.. Label affinity

ラベル・アフィニティ
--------------------

.. Label affinity allows you to set up an attraction based on a container’s label. For example, you can run a nginx container with the com.example.type=frontend label.

ラベル・アフィニティによって、コンテナのラベルで引き寄せてセットアップできます。例えば、 ``nginx`` コンテナを ``com.example.type=frontend`` ラベルをつけて起動します。

.. code-block:: bash

   $ docker run -d -p 80:80 --label com.example.type=frontend nginx
    87c4376856a8
   
   $ docker ps  --filter "label=com.example.type=frontend"
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NODE        NAMES
   87c4376856a8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:80->80/tcp         node-1      trusting_yonath

.. Then, use -e affinity:com.example.type==frontend to schedule a container next to the container with the com.example.type==frontend label.

それから、 ``-e affinity:com.example.type==frontend`` を使って、 ``com.example.type==fronten`` ラベルを持つコンテナの隣にスケジュールします。

.. code-block:: bash

   $ docker run -d -e affinity:com.example.type==frontend logger
    87c4376856a8
   
   $ docker ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NODE        NAMES
   87c4376856a8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:80->80/tcp         node-1      trusting_yonath
   963841b138d8        logger:latest       "logger"            Less than a second ago   running                                             node-1      happy_hawking

.. The logger container ends up on node-1 because its affinity with the com.example.type==frontend label.

``logger`` コンテナは、最終的に ``node-1`` に置かれます。これはアフィニティに  ``com.example.type==frontend`` ラベルを指定しているからです。

.. Expression Syntax

文法表現
----------

.. An affinity or a constraint expression consists of a key and a value. A key must conform the alpha-numeric pattern, with the leading alphabet or underscore. The value must be one of the following:

アフィニティや制約は、 `` key`` と ``value`` の組み合わせで表現します。 ``key`` は英数字のパターンに従います。ただし、先頭はアルファベットかアンダースコアです。 ``value`` は次のようなものです。

..    An alpha-numeric string, dots, hyphens, and underscores.
    A globbing pattern, i.e., abc*.
    A regular expression in the form of /regexp/. We support the Go’s regular expression syntax.

* 英数字の文字列、ドット、ハイフン、アンダースコア。
* 部分一致、例えば ``abc*``。
* ``/regexp/`` 形式の正規表現。Go 言語の正規表現構文をサポート。

.. Currently Swarm supports the following affinity/constraint operators: == and !=. For example:

現時点の Swarm は、アフィニティ・constraint で演算子 ``==`` と ``!=`` をサポートしています。

..    constraint:node==node1 matches node node1
    constraint:node!=node1 matches all nodes, except node1.
    constraint:region!=us* matches all nodes outside the regions prefixed with us.
    constraint:node==/node[12]/ matches nodes node1 and node2.
    constraint:node==/node\d/ matches all nodes with node + 1 digit.
    constraint:node!=/node-[01]/ matches all nodes, except node-0 and node-1.
    constraint:node!=/foo\[bar\]/ matches all nodes, except foo[bar]. You can see the use of escape characters here.
    constraint:node==/(?i)node1/ matches node node1 case-insensitive. So NoDe1 or NODE1 also match.

* ``constraint:node==node1`` は、ノード ``node1`` に一致。
* ``constraint:node!=node1`` は、``node1`` をのぞく全てのノードに一致。
* ``constraint:region!=us*`` は、 ``us`` が付いているリージョン以外のノードに一致。
* ``constraint:node==/node[12]/`` は、 ``node1`` と ``node2`` に一致。
* ``constraint:node==/node\d/`` は、 ``node`` + 10進数の１文字に一致。
* ``constraint:node!=/node-[01]/`` は、 ``node-0`` と ``node-1`` 以外の全てのノードに一致。
* ``constraint:node!=/foo\[bar\]/`` は、 ``foo[var]`` 以外の全てのノードに一致。
* ``constraint:node==/(?i)node1/`` は、大文字・小文字を区別しない ``node1`` に一致。そのため、 ``NoDe1`` や ``NODE1`` も一致する。

.. Soft Affinities/Constraints

Soft アフィニティ・制約の設定
------------------------------

.. By default, affinities and constraints are hard enforced. If an affinity or constraint is not met, the container won’t be scheduled. With soft affinities/constraints the scheduler will try to meet the rule. If it is not met, the scheduler will discard the filter and schedule the container according to the scheduler’s strategy.

デフォルトでは、アフィニティと制約は厳密（ハード）に強制されるものです。アフィニティや制約で指定した条件に対応するノードがなければ、コンテナはスケジュールされません。Soft affinities/constrains （ソフト設定）があれば、スケジュールが一致するルールを探そうとします。もし一致しなければ、スケジューラはフィルタを廃棄し、コンテナはスケジューラのストラテジに従ってスケジュールします

.. Soft affinities/constraints are expressed with a ~ in the expression, for example:

アフィニティと制約のソフト設定は ``~`` で指定します。例えば、次のように指定します。

.. code-block:: bash

   $ docker run -d --name redis1 -e affinity:image==~redis redis

.. If none of the nodes in the cluster has the image redis, the scheduler will discard the affinity and schedule according to the strategy.

もし、クラスタにイメージ ``redis`` を持つノードが無ければ、スケジューラはアフィニティを破棄し、ストラテジに従ってスケジュールします。

.. code-block:: bash

   $ docker run -d --name redis2 -e constraint:region==~us* redis

.. If none of the nodes in the cluster belongs to the us region, the scheduler will discard the constraint and schedule according to the strategy.

もし、 ``us`` リージョンに属すノードがクラスタに無ければ、スケジューラは制約を破棄し、ストラテジに従ってスケジュールします。

.. code-block:: bash

   $ docker run -d --name redis5 -e affinity:container!=~redis* redis

.. The affinity filter will be used to schedule a new redis5 container to a different node that doesn’t have a container with the name that satisfies redis*. If each node in the cluster has a redis* container, the scheduler will discard the affinity rule and schedule according to the strategy.

アフィニティ・フィルタは新しい ``redis5`` コンテナを、指定した ``redis*`` の名前を含むコンテナが無いノードにスケジュールします。もしクラスタの各々のノードが ``redis*`` コンテナを持っている場合、スケジューラはアフィニティのルールを破棄し、ストラテジに従ってスケジュールします。

.. _port_filter:

.. Port Filter

ポート・フィルタ
====================

.. With this filter, ports are considered unique resources.

``ports`` フィルタは、ユニーク（未使用）なリソースを探し出します。

.. code-block:: bash

   $ docker run -d -p 80:80 nginx
   87c4376856a8
   
   $ docker ps
   CONTAINER ID    IMAGE               COMMAND         PORTS                       NODE        NAMES
   87c4376856a8    nginx:latest        "nginx"         192.168.0.42:80->80/tcp     node-1      prickly_engelbart

.. Docker cluster selects a node where the public 80 port is available and schedules a container on it, in this case node-1.

Docker クラスタから、パブリックのポート ``80`` が利用可能なノードを選択し、コンテナの実行をスケジュールします。この例では ``node-1`` が該当します。

.. Attempting to run another container with the public 80 port will result in the cluster selecting a different node, since that port is already occupied on node-1:

他のコンテナでパブリックのポート ``80`` で起動しようとするなら、既に ``node-1`` は使用中のため、別のノードが選ばれることになります。

.. code-block:: bash

   $ docker run -d -p 80:80 nginx
   963841b138d8
   
   $ docker ps
   CONTAINER ID        IMAGE          COMMAND        PORTS                           NODE        NAMES
   963841b138d8        nginx:latest   "nginx"        192.168.0.43:80->80/tcp         node-2      dreamy_turing
   87c4376856a8        nginx:latest   "nginx"        192.168.0.42:80->80/tcp         node-1      prickly_engelbart

.. Again, repeating the same command will result in the selection of node-3, since port 80 is neither available on node-1 nor node-2:

再び同じコマンドを実行すると、ポート ``80`` が使えない ``node-1`` や ``node-2`` ではなく、 ``node-3`` が選ばれます。

.. code-block:: bash

   $ docker run -d -p 80:80 nginx
   963841b138d8
   
   $ docker ps
   CONTAINER ID   IMAGE               COMMAND        PORTS                           NODE        NAMES
   f8b693db9cd6   nginx:latest        "nginx"        192.168.0.44:80->80/tcp         node-3      stoic_albattani
   963841b138d8   nginx:latest        "nginx"        192.168.0.43:80->80/tcp         node-2      dreamy_turing
   87c4376856a8   nginx:latest        "nginx"        192.168.0.42:80->80/tcp         node-1      prickly_engelbart

.. Finally, Docker Swarm will refuse to run another container that requires port 80 since not a single node in the cluster has it available:

最終的に、クラスタ上でポート ``80`` が利用可能なノードが無くなると、Docker Swam はコンテナの実行を拒否します。

.. code-block:: bash

   $ docker run -d -p 80:80 nginx
   2014/10/29 00:33:20 Error response from daemon: no resources available to schedule container

.. Port filter in Host Mode

ホスト・モードでのポートフィルタ
----------------------------------------

.. Docker in the host mode, running with --net=host, differs from the default bridge mode as the host mode does not perform any port binding. So, it require that you explicitly expose one or more port numbers (using EXPOSE in the Dockerfile or --expose on the command line). Swarm makes use of this information in conjunction with the host mode to choose an available node for a new container.

Docker を ``--net=host`` を使ったホスト・モードで実行すると、デフォルトの ``bridge`` モードとは異なり、ポートのバインディングができない ``host`` モードになります。そのため、１つ以上のポート番号を明示する必要があります（ Dockerfile で ``EXPOSE`` を使うか、コマンドラインで ``--expose`` を使います ）。Swarm がこの情報を使うのは、 ``host`` モードで新しいコンテナが利用可能なノードを選ぶときです。

.. For example, the following commands start nginx on 3-node cluster.

例えば、以下のコマンドは nginx を３つのノード・クラスタで起動します。

.. code-block:: bash

   $ docker run -d --expose=80 --net=host nginx
   640297cb29a7
   $ docker run -d --expose=80 --net=host nginx
   7ecf562b1b3f
   $ docker run -d --expose=80 --net=host nginx
   09a92f582bc2

.. Port binding information will not be available through the docker ps command because all the nodes are started in the host mode.

ポートの利用情報は、 ``docker ps`` コマンドを通して利用可能です。これは全てのノードが host モードで起動されているためです。

.. code-block:: bash

   $ docker ps
   CONTAINER ID        IMAGE               COMMAND                CREATED                  STATUS              PORTS               NAMES
   640297cb29a7        nginx:1             "nginx -g 'daemon of   Less than a second ago   Up 30 seconds                           box3/furious_heisenberg
   7ecf562b1b3f        nginx:1             "nginx -g 'daemon of   Less than a second ago   Up 28 seconds                           box2/ecstatic_meitner
   09a92f582bc2        nginx:1             "nginx -g 'daemon of   46 seconds ago           Up 27 seconds                           box1/mad_goldstine

.. The swarm will refuse the operation when trying to instantiate the 4th container.

４つめのコンテナを準備しようとしても、Swarm は拒否するでしょう。

.. code-block:: bash

   $  docker run -d --expose=80 --net=host nginx
   FATA[0000] Error response from daemon: unable to find a node with port 80/tcp available in the Host mode

.. However port binding to the different value, e.g. 81, is still allowed.

そのかわり、ポート ``81`` のような、異なったポートをバインドすることはできます。

.. code-block:: bash

   $  docker run -d -p 81:80 nginx:latest
   832f42819adc
   $  docker ps
   CONTAINER ID        IMAGE               COMMAND                CREATED                  STATUS                  PORTS                                 NAMES
   832f42819adc        nginx:1             "nginx -g 'daemon of   Less than a second ago   Up Less than a second   443/tcp, 192.168.136.136:81->80/tcp   box3/thirsty_hawking
   640297cb29a7        nginx:1             "nginx -g 'daemon of   8 seconds ago            Up About a minute                                             box3/furious_heisenberg
   7ecf562b1b3f        nginx:1             "nginx -g 'daemon of   13 seconds ago           Up About a minute                                             box2/ecstatic_meitner
   09a92f582bc2        nginx:1             "nginx -g 'daemon of   About a minute ago       Up About a minute                                             box1/mad_gol

.. Dependency Filter

.. _dependency_filter:

依存関係フィルタ
====================

.. This filter co-schedules dependent containers on the same node.

このフィルタは、コンテナの依存関係により、同じノード上にスケジュールするものです。

.. Currently, dependencies are declared as follows:

現時点では、次の依存関係を宣言できます。

..    Shared volumes: --volumes-from=dependency
    Links: --link=dependency:alias
    Shared network stack: --net=container:dependency

* ボリューム共有： ``--volumes-from=dependency``
* リンク：  ``--link=dependency:alias``
* 共有ネットワーク層： ``--net=container:dependency``

.. Swarm will attempt to co-locate the dependent container on the same node. If it cannot be done (because the dependent container doesn’t exist, or because the node doesn’t have enough resources), it will prevent the container creation.

Swarm は依存関係のある同じノード上にコンテナを設置しようとします。もし実行できなそうであれば（依存関係のコンテナが存在しなかったり、ノードに十分なリソースが無い場合）、コンテナは作成されません。

.. The combination of multiple dependencies will be honored if possible. For instance, --volumes-from=A --net=container:B will attempt to co-locate the container on the same node as A and B. If those containers are running on different nodes, Swarm will prevent you from scheduling the container.

必要であれば、複数の依存関係を組み合わせることもできます。例えば、 ``--volumes-from=A --net=container:B`` は、コンテナ ``A`` と ``B`` を同じノード上に置こうとします。しかし、これらのコンテナが別々のノードで動いているなら、Swarm はコンテナのスケジューリングを行いません。

.. _health_filter:

.. Health Filter

ヘルス・フィルタ
====================

.. This filter will prevent scheduling containers on unhealthy nodes.

ヘルスフィルタは、障害が発生しているノードへのスケジューリングを阻止します。

Docker Swarm ドキュメンテーション目次
========================================

* :doc:`ユーザ・ガイド </swarm/index>`
* :doc:`スケジュール・ストラテジ </swarm/scheduler/strategy>`
* :doc:`スケジューラ・フィルタ </swarm/scheduler/filter>`
* :doc:`Swarm API </swarm/api/swarm-api>`

