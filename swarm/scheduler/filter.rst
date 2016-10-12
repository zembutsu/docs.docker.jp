.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/scheduler/filter/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/scheduler/filter.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/scheduler/filter.md
.. check date: 2016/04/29
.. Commits on Apr 6, 2016 2a778b36009db0c495f65c3e7aabfaf3b0cd3044
.. -------------------------------------------------------------------


.. Swarm filters

.. _swarm-filters:

==============================
Swarm フィルタ
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Filters tell Docker Swarm scheduler which nodes to use when creating and running a container.

フィルタとは Docker Swarm スケジューラに対して、ノードを使ってコンテナの作成・実行をするか伝えます。

.. Configure the available filters

.. _configure-the-available-filters:

設定可能なフィルタ
====================

.. Filters are divided into two categories, node filters and container configuration filters. Node filters operate on characteristics of the Docker host or on the configuration of the Docker daemon. Container configuration filters operate on characteristics of containers, or on the availability of images on a host.

フィルタはノード・フィルタ（node filter）とコンテナ設定フィルタ（container configuration filter）の２種類に分けられます。ノード・フィルタは Docker ホストの特徴、あるいは Docker デーモンの設定によって処理します。コンテナ設定フィルタはコンテナの特徴、あるいはホスト上で利用可能なイメージによって処理します。

.. Each filter has a name that identifies it. The node filters are:

各フィルタには名前があります。ノード・フィルタは、以下の２つです。

* ``constraint`` （ノードの制限）
* ``health`` （ノードが正常かどうか）
* ``containerslots`` （ノードでの最大実行コンテナ数）

.. The container configuration filters are:

コンテナ設定フィルタは以下の通りです。


* ``affinity`` （親密さ）
* ``dependency`` （依存関係）
* ``port`` （ポート）

.. When you start a Swarm manager with the swarm manage command, all the filters are enabled. If you want to limit the filters available to your Swarm, specify a subset of filters by passing the --filter flag and the name:

``swarm manage`` コマンドで Swarm マネージャの起動する時、全てのフィルタが指定可能です。もしも Swarm に対して利用可能なフィルタを制限したい場合は、 ``--filter`` フラグと名前のサブセットを指定します。

.. code-block:: bash

   $ swarm manage --filter=health --filter=dependency

..    Note: Container configuration filters match all containers, including stopped containers, when applying the filter. To release a node used by a container, you must remove the container from the node.

.. note::

   コンテナ設定フィルタに一致するのは全てのコンテナが対象です。フィルタが適用されるのは停止しているコンテナも含みます。コンテナによって使用されているノードを解放するには、ノード上からコンテナを削除する必要があります。

.. Node filters:

.. _node-filters:

ノード・フィルタ
====================

.. When creating a container or building an image, you use a constraint or health filter to select a subset of nodes to consider for scheduling. If a node in Swarm cluster has a label with key containerslots and a number-value, Swarm will not launch more containers than the given number.

コンテナ作成時とイメージ構築時に、 ``constraint`` か ``health`` フィルタを使い、コンテナをスケジューリングするノード群を選択できます。もし、Swarmクラスタ内のノードが``containerslots``キーと数値をラベルに持っている場合、Swarmは指定された数以上のコンテナを起動しません。

.. Use a constraint Filter

.. _user-a-constraint-filter:

constraint （制限）フィルタを使う
----------------------------------------

.. Node constraints can refer to Docker's default tags or to custom labels. Default tags are sourced from docker info. Often, they relate to properties of the Docker host. Currently, the default tags include:

ノード制限（constraint；コンストレイント＝制限・制約の意味）は Docker のデフォルトのタグやカスタム・ラベルを参照します。デフォルトのタグとは ``docker info`` の情報を元にします。しばし Docker ホストの設定状態に関連付けられます。現在以下の項目をデフォルト・タグとして利用できます。

* ``node`` ノードを参照するための ID もしくは名前
* ``storagedriver``
* ``executiondriver``
* ``kernelversion``
* ``operatingsystem``

.. Custom node labels you apply when you start the docker daemon, for example:

カスタム・ノード・ラベルは ``docker daemon`` 起動時に追加できます。実行例：

.. code-block:: bash

   $ docker daemon --label com.example.environment="production" --label
   com.example.storage="ssd"

.. Then, when you start a container on the cluster, you can set constraints using these default tags or custom labels. The Swarm scheduler looks for matching node on the cluster and starts the container there. This approach has several practical applications:

そして、クラスタ上でコンテナの起動時に、これらのデフォルト・タグかカスタム・ラベルを使って制限（constraint）を指定可能です。Swarm スケジューラはクラスタ上に条件が一致するノードを探し、そこでコンテナを起動します。この手法は、いくつもの実践的な機能になります。

..    Schedule based on specific host properties, for example,storage=ssd schedules containers on specific hardware.
..    Force containers to run in a given location, for example region=us-east`.
..    Create logical cluster partitions by splitting a cluster into sub-clusters with different properties, for example environment=production.

* ホスト・プロパティを指定した選択（ ``storage=ssd`` のように、特定のハードウェアにコンテナをスケジュールするため）
* ノードの基盤に、物理的な場所をタグ付けする（ ``region=us-east`` のように、指定した場所でコンテナを強制的に実行）
* 論理的なクラスタの分割（ ``environment=production`` のように、プロパティの違いによりクラスタを複数のサブクラスタに分割）

.. Example node constraints

.. _example-node-constraints:

ノード制限の例
--------------------

.. To specify custom label for a node, pass a list of --label options at docker startup time. For instance, to start node-1 with the storage=ssd label:

ノードに対してカスタム・ラベルを指定するには、 ``docker`` 起動時に ``--label`` オプションのリストを指定します。例として、 ``node-1`` に ``storage=ssd`` ラベルを付けて起動します。

.. code-block:: bash

   $ docker -d --label storage=ssd
   $ swarm join --advertise=192.168.0.42:2375 token://XXXXXXXXXXXXXXXXXX

.. You might start a different node-2 with storage=disk:

``node-2`` を ``storage=disk`` としても起動できます。

.. code-block:: bash

   $ docker -d --label storage=disk
   $ swarm join --advertise=192.168.0.43:2375 token://XXXXXXXXXXXXXXXXXX

.. Once the nodes are joined to a cluster, the Swarm manager pulls their respective tags. Moving forward, the manager takes the tags into account when scheduling new containers.

ノードがクラスタに登録されたら、Swarm マネージャは個々のタグを取得します。マネージャは新しいコンテナをスケジューリングする時に、ここで取得したタグの情報を使って処理します。

.. Once the nodes are registered with the cluster, the manager pulls their respective tags and will take them into account when scheduling new containers.

.. ノードがクラスタに登録されたら、マネージャは各々のタグを取得し、新しいコンテナをスケジューリングするときにそれらを反映します。

.. Continuing the previous example, assuming your cluster with node-1 and node-2, you can run a MySQL server container on the cluster. When you run the container, you can use a constraint to ensure the database gets good I/O performance. You do this by filtering for nodes with flash drives:

先ほどのサンプルを例に進めましょう。クラスタには ``node-1`` と ``node-2`` があります。このクラスタ上に MySQL サーバ・コンテナを実行できます。コンテナの実行時、 ``constraint`` （制限） を使い、データベースが良い I/O 性能を得られるようにできます。そのためには、フラッシュ・ドライブを持つノードをフィルタします。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port>  run -d -P -e constraint:storage==ssd --name db mysql
   f8b693db9cd6
   
   $ docker tcp://<manager_ip:manager_port>  ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   f8b693db9cd6        mysql:latest        "mysqld"            Less than a second ago   running             192.168.0.42:49178->3306/tcp    node-1/db

.. In this example, the manager selected all nodes that met the storage=ssd constraint and applied resource management on top of them. Only node-1 was selected because it's the only host running flash.

この例では、マネージャは全てのノードの中から ``storage-ssd`` 制限に一致するノードを探し、そこに対してリソース管理を適用します。ここではホストがフラッシュ上で動いている ``node-1`` のみが選ばれました。

.. Suppose you want to run an Nginx frontend in a cluster. In this case, you wouldn't want flash drives because the frontend mostly writes logs to disk.

クラスタのフロントエンドとして Nginx の実行をお考えでしょうか。この例では、フロントエンドはディスクのログを記録するだけですので、フラッシュ・ドライブを使いたくないでしょう。


.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d -P -e constraint:storage==disk --name frontend nginx
   963841b138d8
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   963841b138d8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.43:49177->80/tcp      node-2/frontend
   f8b693db9cd6        mysql:latest        "mysqld"            Up About a minute        running             192.168.0.42:49178->3306/tcp    node-1/db

.. The scheduler selected node-2 since it was started with the storage=disk label.

スケジューラは ``storage=disk`` ラベルを付けて起動済みの ``node-2`` で起動します。

.. Finally, build args can be used to apply node constraints to a docker build. Again, you'll avoid flash drives.

最後に、 ``docker build`` の構築時の引数としてもノード制限を利用できます。今度もフラッシュ・ドライブを避けてみましょう。

.. code-block:: bash

   $ mkdir sinatra
   $ cd sinatra
   $ echo "FROM ubuntu:14.04" > Dockerfile
   $ echo "MAINTAINER Kate Smith <ksmith@example.com>" >> Dockerfile
   $ echo "RUN apt-get update && apt-get install -y ruby ruby-dev" >> Dockerfile
   $ echo "RUN gem install sinatra" >> Dockerfile
   $ docker build --build-arg=constraint:storage==disk -t ouruser/sinatra:v2 .
   Sending build context to Docker daemon 2.048 kB
   Step 1 : FROM ubuntu:14.04
    ---> a5a467fddcb8
   Step 2 : MAINTAINER Kate Smith <ksmith@example.com>
    ---> Running in 49e97019dcb8
    ---> de8670dcf80e
   Removing intermediate container 49e97019dcb8
   Step 3 : RUN apt-get update && apt-get install -y ruby ruby-dev
    ---> Running in 26c9fbc55aeb
    ---> 30681ef95fff
   Removing intermediate container 26c9fbc55aeb
   Step 4 : RUN gem install sinatra
    ---> Running in 68671d4a17b0
    ---> cd70495a1514
   Removing intermediate container 68671d4a17b0
   Successfully built cd70495a1514
   
   $ docker images
   REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
   dockerswarm/swarm   manager             8c2c56438951        2 days ago          795.7 MB
   ouruser/sinatra     v2                  cd70495a1514        35 seconds ago      318.7 MB
   ubuntu              14.04               a5a467fddcb8        11 days ago         187.9 MB

.. Use the health filter

.. _use-the-health-filter:

health フィルタを使う
------------------------------

.. The node health filter prevents the scheduler form running containers on unhealthy nodes. A node is considered unhealthy if the node is down or it can't communicate with the cluster store.

ノード ``health`` フィルタは障害の発生したノードにコンテナをスケジュールするのを防ぎます。対象のノードはダウンしているか、クラスタ・ストアとの通信ができないことが考えられます。

.. Use the containerslots filter

.. _use-the-containerslots-filter:

containerslots フィルタを使う
-------------------------------

.. You may give your Docker nodes the containerslots label

Dockerノードに``containerslots``ラベルを与えることができます。

.. code-block:: bash

   $ docker daemon --label containerslots=3

.. Swarm will run up to 3 containers at this node, if all nodes are “full”, an error is thrown indicating no suitable node can be found. If the value is not castable to an integer number or is not present, there will be no limit on container number.

Swarmはノードで3つのコンテナまで実行しますが、全てのノードが「満載（コンテナ数が最大）」であれば適切なノードが無い事を示すエラーがスローされます。もし、値が整数にキャストできないか、存在しなければコンテナ数に制限は存在しません。

.. Container filters

.. _container-filters:

コンテナ・フィルタ
====================

.. When creating a container, you can use three types of container filters:

コンテナの作成時、３種類のコンテナ・フィルタを使えます。

* ``affinity``
* ``dependency``
* ``port``

.. Use an affinity filter

.. _use-an-affinity-filter:

アフィニティ（親密さ）フィルタを使う
----------------------------------------

.. Use an affinity filter to create "attractions" between containers. For example, you can run a container and instruct Swarm to schedule it next to another container based on these affinities:

アフィニティ（親密さ）フィルタを使えば、コンテナ間を「集めて」作成できます。例えばコンテナを実行する時に、次の３つの親密さを元にして Swarm に対してスケジュールできます。

..    container name or id
    an image on the host
    a custom label applied to the container

* コンテナ名か ID
* イメージのあるホスト
* コンテナに適用したカスタム・ラベル

.. These affinities ensure that containers run on the same network node — without you having to know what each node is running.

これらのアフィニティ（親密さ）とは、コンテナを同じネットワーク・ノード上で実行することです。それぞれどのノード上で実行しているかどうか、知る必要がありません。

.. Example name affinity

.. _example-name-affinity:

名前アフィニティの例
--------------------

.. You can schedule a new container to run next to another based on a container name or ID. For example, you can start a container called frontend running nginx:

新しいコンテナを、既存のコンテナ名や ID を元にしてスケジューリングできます。例えば、 ``frontend`` という名前のノードで ``nginx``  を実行します。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port>  run -d -p 80:80 --name frontend nginx
   87c4376856a8
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   87c4376856a8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:80->80/tcp         node-1/frontend

.. Then, using -e affinity:container==frontend flag schedule a second container to locate and run next to frontend.

それから、 ``-e affinity:container==frontend`` フラグを使い、２つめのコンテナを ``frontend`` の隣にスケジュールします。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d --name logger -e affinity:container==frontend logger
   87c4376856a8
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   87c4376856a8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:80->80/tcp         node-1/frontend
    963841b138d8        logger:latest       "logger"            Less than a second ago   running                                             node-1/logger

.. Because of name affinity, the logger container ends up on node-1 along with the frontend container. Instead of the frontend name you could have supplied its ID as follows:

コンテナ名のアフィニティ指定によって、 ``logger`` コンテナは ``frontend`` コンテナと同じ ``node-1`` コンテナで実行されることになります。 ``frontend`` という名前だけでなく、次のように ID を使った指定もできます

.. code-block:: bash

   docker run -d --name logger -e affinity:container==87c4376856a8

.. Example Image affinity

イメージ・アフィニティの例
------------------------------

.. You can schedule a container to run only on nodes where a specific image is already pulled. For example, suppose you pull a redis image to two hosts and a mysql image to a third.

.. You can schedule a container to run only on nodes where a specific image is already pulled.

コンテナを起動する時、特定のイメージをダウンロード済みのノードのみにスケジュールすることができます。例えば、２つのホストに ``redis`` イメージをダウンロードし、３つめのホストに ``mysql`` イメージをダウンロードしたい場合があるでしょう。

.. code-block:: bash

   $ docker -H node-1:2375 pull redis
   $ docker -H node-2:2375 pull mysql
   $ docker -H node-3:2375 pull redis

.. Only node-1 and node-3 have the redis image. Specify a -e affinity:image==redis filter to schedule several additional containers to run on these nodes.

``node-1`` と ``node-3`` のみが ``redis`` イメージを持っています。 ``-e affinity:image==redis`` フィルタを使い、これらのノード上でスケジュールします。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d --name redis1 -e affinity:image==redis redis
   $ docker tcp://<manager_ip:manager_port> run -d --name redis2 -e affinity:image==redis redis
   $ docker tcp://<manager_ip:manager_port> run -d --name redis3 -e affinity:image==redis redis
   $ docker tcp://<manager_ip:manager_port> run -d --name redis4 -e affinity:image==redis redis
   $ docker tcp://<manager_ip:manager_port> run -d --name redis5 -e affinity:image==redis redis
   $ docker tcp://<manager_ip:manager_port> run -d --name redis6 -e affinity:image==redis redis
   $ docker tcp://<manager_ip:manager_port> run -d --name redis7 -e affinity:image==redis redis
   $ docker tcp://<manager_ip:manager_port> run -d --name redis8 -e affinity:image==redis redis
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   87c4376856a8        redis:latest        "redis"             Less than a second ago   running                                             node-1/redis1
   1212386856a8        redis:latest        "redis"             Less than a second ago   running                                             node-1/redis2
   87c4376639a8        redis:latest        "redis"             Less than a second ago   running                                             node-3/redis3
   1234376856a8        redis:latest        "redis"             Less than a second ago   running                                             node-1/redis4
   86c2136253a8        redis:latest        "redis"             Less than a second ago   running                                             node-3/redis5
   87c3236856a8        redis:latest        "redis"             Less than a second ago   running                                             node-3/redis6
   87c4376856a8        redis:latest        "redis"             Less than a second ago   running                                             node-3/redis7
   963841b138d8        redis:latest        "redis"             Less than a second ago   running                                             node-1/redis8

.. As you can see here, the containers were only scheduled on nodes that had the redis image. Instead of the image name, you could have specified the image ID.

ここで見えるように、コンテナがスケジュールされるのは ``redis`` イメージを持っているノードのみです。イメージ名に加えて、特定のイメージ ID も指定できます。

.. code-block:: bash

   $ docker images
   REPOSITORY                         TAG                       IMAGE ID            CREATED             VIRTUAL SIZE
   redis                              latest                    06a1f75304ba        2 days ago          111.1 MB
   
   $ docker tcp://<manager_ip:manager_port> run -d --name redis1 -e affinity:image==06a1f75304ba redis

.. Example Label affinity

ラベル・アフィニティの例
------------------------------

.. Label affinity allows you to set up an attraction based on a container’s label. For example, you can run a nginx container with the com.example.type=frontend label.

ラベル・アフィニティによって、コンテナのラベルで引き寄せてたセットアップが可能です。例えば、 ``nginx`` コンテナに ``com.example.type=frontend`` ラベルを付けて起動します。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d -p 80:80 --label com.example.type=frontend nginx
   87c4376856a8
   
   $ docker tcp://<manager_ip:manager_port> ps  --filter "label=com.example.type=frontend"
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   87c4376856a8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:80->80/tcp         node-1/trusting_yonath

.. Then, use -e affinity:com.example.type==frontend to schedule a container next to the container with the com.example.type==frontend label.

それから、 ``-e affinity:com.example.type==frontend`` を使って、 ``com.example.type==frontend`` ラベルを持つコンテナの隣にスケジュールします。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d -e affinity:com.example.type==frontend logger
   87c4376856a8
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   87c4376856a8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:80->80/tcp         node-1/trusting_yonath
   963841b138d8        logger:latest       "logger"            Less than a second ago   running                                             node-1/happy_hawking

.. The logger container ends up on node-1 because its affinity with the com.example.type==frontend label.

``logger`` コンテナは、最終的に ``node-1`` に置かれます。これはアフィニティに  ``com.example.type==frontend`` ラベルを指定しているからです。

.. Use a dependency filter

.. _use-a-dependency-filter:

dependency フィルタを使う
------------------------------

.. A container dependency filter co-schedules dependent containers on the same node. Currently, dependencies are declared as follows:

コンテナの依存関係（dependency）フィルタは、既にスケジューリング済みのコンテナと同じ場所でスケジューリングするという依存関係をもたらします。現時点では、以下の依存関係を宣言できます。

* ``--volumes-from=dependency`` (共有ボリューム)
* ``--link=dependency:alias`` (リンク機能)
* ``--net=container:dependency`` (共有ネットワーク)

.. Swarm attempts to co-locate the dependent container on the same node. If it cannot be done (because the dependent container doesn't exist, or because the node doesn't have enough resources), it will prevent the container creation.

Swarm は依存関係のあるコンテナを同じノード上に置こうとします。もしそれができない場合（依存関係のあるコンテナが存在しない場合や、ノードが十分なリソースを持っていない場合）、コンテナの作成を拒否します。

.. The combination of multiple dependencies are honored if possible. For instance, if you specify --volumes-from=A --net=container:B, the scheduler attempts to co-locate the container on the same node as A and B. If those containers are running on different nodes, Swarm does not schedule the container.

必要であれば、複数の依存関係を組み合わせることもできます。例えば、 ``--volumes-from=A --net=container:B`` は、コンテナ ``A`` と ``B`` を同じノード上に置こうとします。しかし、これらのコンテナが別々のノードで動いているなら、Swarm はコンテナのスケジューリングを行いません。

.. Use a port filter

.. _use-a-port-filter:

port フィルタを使う
--------------------

.. When the port filter is enabled, a container's port configuration is used as a unique constraint. Docker Swarm selects a node where a particular port is available and unoccupied by another container or process. Required ports may be specified by mapping a host port, or using the host networking and exposing a port using the container configuration.

``port`` フィルタが有効であれば、コンテナのポート利用がユニークになるよう設定します。Docker Swarm は対象のポートが利用可能であり、他のコンテナのプロセスにポートが専有されていないノードを選びます。ホスト側にポート番号を割り当てたい場合や、ホスト・ネットワーキング機能を使っている場合は、対象ポートの明示が必要になるかもしれません。

.. Example in bridge mode

.. _example-in-bridge-mode:

ブリッジ・モードでの例
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. By default, containers run on Docker's bridge network. To use the port filter with the bridge network, you run a container as follows.

デフォルトでは、コンテナは Docker のブリッジ・ネットワーク上で動作します。ブリッジ・ネットワーク上で ``port`` フィルタを使うには、コンテナを次のように実行します。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d -p 80:80 nginx
   87c4376856a8
  
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID    IMAGE               COMMAND         PORTS                       NAMES
   87c4376856a8    nginx:latest        "nginx"         192.168.0.42:80->80/tcp     node-1/prickly_engelbart

..  Docker Swarm selects a node where port 80 is available and unoccupied by another container or process, in this case node-1. Attempting to run another container that uses the host port 80 results in Swarm selecting a different node, because port 80 is already occupied on node-1:

Docker Swarm はポート ``80`` が利用可能であり他のコンテナ・プロセスに専有されていないノードを探します。この例では ``node-1``  にあたります。ポート ``80`` を使用する他のコンテナを起動しようとしても、Swarm は他のノードを選択します。理由は ``node-1``  では既にポート ``80`` が使われているからです。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d -p 80:80 nginx
   963841b138d8
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE          COMMAND        PORTS                           NAMES
   963841b138d8        nginx:latest   "nginx"        192.168.0.43:80->80/tcp         node-2/dreamy_turing
   87c4376856a8        nginx:latest   "nginx"        192.168.0.42:80->80/tcp         node-1/prickly_engelbart

.. Again, repeating the same command will result in the selection of node-3, since port 80 is neither available on node-1 nor node-2:

同じコマンドを繰り返しますと ``node-3`` が選ばれます。これは ``node-1`` と ``node-2`` の両方でポート ``80`` が使用済みのためです。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d -p 80:80 nginx
   963841b138d8
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID   IMAGE               COMMAND        PORTS                           NAMES
   f8b693db9cd6   nginx:latest        "nginx"        192.168.0.44:80->80/tcp         node-3/stoic_albattani
   963841b138d8   nginx:latest        "nginx"        192.168.0.43:80->80/tcp         node-2/dreamy_turing
   87c4376856a8   nginx:latest        "nginx"        192.168.0.42:80->80/tcp         node-1/prickly_engelbart

.. Finally, Docker Swarm will refuse to run another container that requires port 80, because it is not available on any node in the cluster:

最終的に、Docker Swarm は他のコンテナがポート ``80`` を要求しても拒否するでしょう。クラスタ上の全てのノードでポートが使えないためです。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d -p 80:80 nginx
   2014/10/29 00:33:20 Error response from daemon: no resources available to schedule container

.. Each container occupies port 80 on its residing node when the container is created and releases the port when the container is deleted. A container in exited state still owns the port. If prickly_engelbart on node-1 is stopped but not deleted, trying to start another container on node-1 that requires port 80 would fail because port 80 is associated with prickly_engelbart. To increase running instances of nginx, you can either restart prickly_engelbart, or start another container after deleting prickly_englbart.

各ノード中のポート ``80`` は、各コンテナによって専有されています。これはコンテナ作成時からのものであり、コンテナを削除するとポートは解放されます。コンテナが ``exited`` （終了）の状態であれば、まだポートを持っている状態です。もし ``node-1`` の ``prickly_engelbart`` が停止したとしても、ポートの情報は削除されないため、 ``node-1`` 上でポート ``80`` を必要とする他のコンテナの起動を試みても失敗します。nginx インスタンスを起動するには、 ``prickly_engelbart`` コンテナを再起動するか、あるいは ``prickly_engelbart`` コンテナを削除後に別のコンテナを起動します。

.. Note port filter with host networking

.. _node-port-filter-with-host-networking:

ホスト・ネットワーキング機能とノード・ポート・フィルタを使う
-------------------------------------------------------------

.. A container running with --net=host differs from the default bridge mode as the host mode does not perform any port binding. Instead, host mode requires that you explicitly expose one or more port numbers. You expose a port using EXPOSE in the Dockerfile or --expose on the command line. Swarm makes use of this information in conjunction with the host mode to choose an available node for a new container.

コンテナ実行時に ``--net=host`` を指定したら、デフォルトの ``bridge`` モードとは違い、 ``host`` モードはどのポートも拘束しません。そのため、 host モードでは公開したいポート番号を明示する必要があります。このポート公開には ``Dockerfile`` で ``EXPOSE``  命令を使うか、コマンドラインで ``--expose`` を指定します。Swarm は ``host`` モードで新しいコンテナを作成しようとする時にも、これらの情報を利用します。

.. For example, the following commands start nginx on 3-node cluster.

例えば、以下のコマンドは３つのノードのクラスタで ``nginx`` を起動します。 

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d --expose=80 --net=host nginx
   640297cb29a7
   $ docker tcp://<manager_ip:manager_port> run -d --expose=80 --net=host nginx
   7ecf562b1b3f
   $ docker tcp://<manager_ip:manager_port> run -d --expose=80 --net=host nginx
   09a92f582bc2

.. Port binding information is not available through the docker ps command because all the nodes were started with the host network.

``docker ps`` コマンドを実行してもポートをバインド（拘束）している情報が表示されないのは、全てのノードで ``host`` ネットワークを利用しているためです。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND                CREATED                  STATUS              PORTS               NAMES
   640297cb29a7        nginx:1             "nginx -g 'daemon of   Less than a second ago   Up 30 seconds                           box3/furious_heisenberg
   7ecf562b1b3f        nginx:1             "nginx -g 'daemon of   Less than a second ago   Up 28 seconds                           box2/ecstatic_meitner
   09a92f582bc2        nginx:1             "nginx -g 'daemon of   46 seconds ago           Up 27 seconds                           box1/mad_goldstine

.. Swarm refuses the operation when trying to instantiate the 4th container.

４つめのコンテナを起動しようとしても、Swarm は処理を拒否します。

.. code-block:: bash

   $  docker tcp://<manager_ip:manager_port> run -d --expose=80 --net=host nginx
   FATA[0000] Error response from daemon: unable to find a node with port 80/tcp available in the Host mode

.. However, port binding to the different value, for example 81, is still allowed.

しかしながら、例えばポート ``81`` のように、異なった値のポートをバインドするのであれば、コマンドを実行できます。

.. code-block:: bash

   $  docker tcp://<manager_ip:manager_port> run -d -p 81:80 nginx:latest
   832f42819adc
   $  docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND                CREATED                  STATUS                  PORTS                                 NAMES
   832f42819adc        nginx:1             "nginx -g 'daemon of   Less than a second ago   Up Less than a second   443/tcp, 192.168.136.136:81->80/tcp   box3/thirsty_hawking
   640297cb29a7        nginx:1             "nginx -g 'daemon of   8 seconds ago            Up About a minute                                             box3/furious_heisenberg
   7ecf562b1b3f        nginx:1             "nginx -g 'daemon of   13 seconds ago           Up About a minute                                             box2/ecstatic_meitner
   09a92f582bc2        nginx:1             "nginx -g 'daemon of   About a minute ago       Up About a minute                                             box1/mad_goldstine

.. How to write filter expressions

.. _how-to-write-filter-expressions:

フィルタ表現の書き方
====================

.. To apply a node constraint or container affinity filters you must set environment variables on the container using filter expressions, for example:

ノード ``constraint`` やコンテナ ``affinity`` フィルタをノードに適用するには、コンテナがフィルタ表現を使うため環境変数の指定が必要です。例：

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d --name redis1 -e affinity:image==~redis redis

.. Each expression must be in the form:

表現は次のような記述方式です。

.. code-block:: bash

   <フィルタ・タイプ>:<キー><演算子><値>

.. The <filter-type> is either the affinity or the constraint keyword. It identifies the type filter you intend to use.

``<フィルタ・タイプ>`` は ``affinity`` か ``constraint``  のキーワードのどちらかです。使いたいフィルタのタイプによって異なります。

.. The <key> is an alpha-numeric and must start with a letter or underscore. The <key> corresponds to one of the following:

``<キー>`` は英数字のパターンであり、先頭はアルファベットかアンダースコアです。 ``<キー>`` に相当するのは以下の条件です。

..     the container keyword
    the node keyword
    a default tag (node constraints)
    a custom metadata label (nodes or containers).

* ``container`` キーワード
* ``node`` キーワード
* デフォルト・タグ（node 制限）
* カスタム・メタデータ・ラベル（node あるいは containers）

.. The <operator>is either == or !=. By default, expression operators are hard enforced. If an expression is not met exactly , the manager does not schedule the container. You can use a ~(tilde) to create a "soft" expression. The scheduler tries to match a soft expression. If the expression is not met, the scheduler discards the filter and schedules the container according to the scheduler's strategy.

``<オペレータ>`` （演算子）は ``==`` か ``!=`` のどちらかです。デフォルトではフィルタ処理はハード・エンフォース（hard enforced:強制）です。指定した表現に一致しなければ、マネージャはコンテナをスケジュールしません。 ``~`` （チルダ）を使い 「ソフト」表現を作成できます。こちらはフィルタ条件に一致しなくても、スケジューラ自身のストラテジに従ってコンテナを実行します。

.. The <value> is an alpha-numeric string, dots, hyphens, and underscores making up one of the following:

``<値>`` は英数時、ドット、ハイフン、アンダースコアと、以下を組み合わせた文字列です。

..    A globbing pattern, for example, abc*.
    A regular expression in the form of /regexp/. See re2 syntax for the supported regex syntax.

* 部分一致、例えば ``abc*``。
* ``/regexp/`` 形式の正規表現。Go 言語の正規表現構文をサポート。

.. Currently Swarm supports the following affinity/constraint operators: == and !=. For example:

現時点の Swarm は、以下のような命令をサポートしています。

..    constraint:node==node1 matches node node1
    constraint:node!=node1 matches all nodes, except node1.
    constraint:region!=us* matches all nodes outside the regions prefixed with us.
    constraint:node==/node[12]/ matches nodes node1 and node2.
    constraint:node==/node\d/ matches all nodes with node + 1 digit.
    constraint:node!=/node-[01]/ matches all nodes, except node-0 and node-1.
    constraint:node!=/foo\[bar\]/ matches all nodes, except foo[bar]. You can see the use of escape characters here.
    constraint:node==/(?i)node1/ matches node node1 case-insensitive. So NoDe1 or NODE1 also match.
   affinity:image==~redis tries to match for nodes running container with a redis image
   constraint:region==~us* searches for nodes in the cluster belongs to the us region
   affinity:container!=~redis* schedule a new redis5 container to a node without a container that satisfies redis*

* ``constraint:node==node1`` は、ノード ``node1`` に一致。
* ``constraint:node!=node1`` は、``node1`` をのぞく全てのノードに一致。
* ``constraint:region!=us*`` は、 ``us`` が付いているリージョン以外のノードに一致。
* ``constraint:node==/node[12]/`` は、 ``node1`` と ``node2`` に一致。
* ``constraint:node==/node\d/`` は、 ``node`` + 10進数の１文字に一致。
* ``constraint:node!=/node-[01]/`` は、 ``node-0`` と ``node-1`` 以外の全てのノードに一致。
* ``constraint:node!=/foo\[bar\]/`` は、 ``foo[var]`` 以外の全てのノードに一致。
* ``constraint:node==/(?i)node1/`` は、大文字・小文字を区別しない ``node1`` に一致。そのため、 ``NoDe1`` や ``NODE1`` も一致する。

* ``affinity:image==~redis`` は、``redis`` に一致する名前のイメージがあるノード上でコンテナを実行。
* ``constraint:region==~us*`` は、``*us`` に一致するリージョンのノードを探す。
* ``affinity:container!=~redis*`` は、 ``redis*`` という名前を持つコンテナが動いていないノードで ``node5`` コンテナをスケジュール。

.. Soft Affinities/Constraints

.. warning::

   以下 v1.9 用のドキュメント、削除予定

Soft アフィニティ・制約の設定
--------------------------------------------------

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


関連情報
========================================

* :doc:`Docker Swarm ユーザ・ガイド </swarm/index>`
* :doc:`/swarm/discovery`
* :doc:`スケジュール・ストラテジ </swarm/scheduler/strategy>`
* :doc:`Swarm API </swarm/swarm-api>`

.. seealso:: 

   Swarm filters
      https://docs.docker.com/swarm/scheduler/filter/
