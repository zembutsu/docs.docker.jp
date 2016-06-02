.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/scheduler/strategy/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/scheduler/strategy.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/scheduler/strategy.md
.. check date: 2016/04/29
.. Commits on Feb 2, 2016 4b8ed91226a9a49c2acb7cb6fb07228b3fe10007
.. -------------------------------------------------------------------

.. Docker Swarm strategies

.. _docker-swarm-strategies:

==============================
Docker Swarm ストラテジ
==============================

.. The Docker Swarm scheduler features multiple strategies for ranking nodes. The strategy you choose determines how Swarm computes ranking. When you run a new container, Swarm chooses to place it on the node with the highest computed ranking for your chosen strategy.

Docker Swarm スケジューラは、複数のストラテジ（strategy；方針）機能でノードを順位付けします。選択したストラテジによって、 Swarm が順位を算出します。Swarm で新しいコンテナを作成するときは、選択したストラテジに従って、コンテナを置くために最も順位の高いノードを算出します。

.. To choose a ranking strategy, pass the --strategy flag and a strategy value to the swarm manage command. Swarm currently supports these values:

順位付けのストラテジを選択するには、 ``swarm manage`` コマンドに ``--strategy`` フラグを使い、ストラテジ値を指定します。現時点でサポートしている値は次の通りです。

* `spread`
* `binpack`
* `random`

.. The spread and binpack strategies compute rank according to a node’s available CPU, its RAM, and the number of containers it is running. The random strategy uses no computation. It selects a node at random and is primarily intended for debugging.

``spread`` と ``binpack`` ストラテジは、ノードで利用可能な CPU 、RAM 、実行中のコンテナ数から順位を算出します。 ``random`` ストラテジは計算をしません。ノードをランダムに選択するもので、主にデバッグ用に使います。

.. Your goal in choosing a strategy is to best optimize your cluster according to your company’s needs.

あなたの会社の必要性に従ってクラスタを最適化するのが、ストラテジを選択する目的（ゴール）です。

.. Under the spread strategy, Swarm optimizes for the node with the least number of running containers. The binpack strategy causes Swarm to optimize for the node which is most packed. The random strategy, like it sounds, chooses nodes at random regardless of their available CPU or RAM.

``spread`` ストラテジの下では、Swarm はノードで実行中のコンテナ数に応じて最適化します。 ``pinback`` ストラテジは利用するノードが最も少なくなるよう最適化します。 ``random`` ストラテジでは、利用可能な CPU やメモリに関わらずランダムにノードを選びます。

.. Using the spread strategy results in containers spread thinly over many machines. The advantage of this strategy is that if a node goes down you only lose a few containers.

``spread`` ストラテジを使えば、結果として多くのマシンに幅広く展開します。このストラテジの利点は、ノードがダウンしても、失われるのは小数のコンテナだけです。

.. The binpack strategy avoids fragmentation because it leaves room for bigger containers on unused machines. The strategic advantage of binpack is that you use fewer machines as Swarm tries to pack as many containers as it can on a node.

``binpack`` は分散しないストラテジです。これは、使っていないマシンに大きなコンテナを動かす余地を残すためです。この ``binpack`` ストラテジの利点は、できるだけ少ないマシンしか使わないよう、Swarm はノードに多くのコンテナを詰め込みます。

.. If you do not specify a --strategy Swarm uses spread by default.

もし ``--strategy`` を指定しなければ、Swarm はデフォルトで ``spread`` を使います

.. Spread strategy example

Spread ストラテジの例
==============================

.. In this example, your cluster is using the spread strategy which optimizes for nodes that have the fewest containers. In this cluster, both node-1 and node-2 have 2G of RAM, 2 CPUs, and neither node is running a container. Under this strategy node-1 and node-2 have the same ranking.

この例では、Swarm は ``spread`` ストラテジでノードを最適化し、多くのコンテナを起動してみます。このクラスタは、 ``node-1`` と ``node-2`` は 2GB のメモリ、2 CPUであり、他のノードではコンテナは動いていません。このストラテジでは ``node-1`` と ``node-2`` は同じ順位です。

.. When you run a new container, the system chooses node-1 at random from the Swarm cluster of two equally ranked nodes:

新しいコンテナを実行するときは、クラスタ上で同じランキングのノードが存在しますので、そこからランダムに ``node-1`` をシステムが選びます。

.. code-block:: bash

   $ docker tcp://<manager_ip:manager_port> run -d -P -m 1G --name db mysql
   f8b693db9cd6
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   f8b693db9cd6        mysql:latest        "mysqld"            Less than a second ago   running             192.168.0.42:49178->3306/tcp    node-1/db

.. Now, we start another container and ask for 1G of RAM again.

次は別のコンテナで 1GB のメモリを使います。

.. code-block:: bash

   $ docker run tcp://<manager_ip:manager_port> -d -P -m 1G --name frontend nginx
   963841b138d8
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   963841b138d8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:49177->80/tcp      node-2/frontend
   f8b693db9cd6        mysql:latest        "mysqld"            Up About a minute        running             192.168.0.42:49178->3306/tcp    node-1/db

.. The container frontend was started on node-2 because it was the node the least loaded already. If two nodes have the same amount of available RAM and CPUs, the spread strategy prefers the node with least containers running.

コンテナ ``frontend`` は ``node-2`` で起動します。これは直前に実行したノードだからです。もし２つのノードがあって、同じメモリや CPU であれば、 ``spread`` ストラテジは最後にコンテナを実行したノードを選びます。

.. BinPack strategy example

BinPack ストラテジの例
==============================

.. In this example, let’s says that both node-1 and node-2 have 2G of RAM and neither is running a container. Again, the nodes are equal. When you run a new container, the system chooses node-1 at random from the cluster:

この例では、 ``node-1`` と ``node-2`` いずれも 2GB のメモリを持ち、コンテナを実行していないとします。ノードが同じとき、コンテナの実行は、今回はクラスタから ``node-1`` が選ばれたとします

.. code-block:: bash

   $ docker run tcp://<manager_ip:manager_port> -d -P -m 1G --name db mysql
   f8b693db9cd6
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   f8b693db9cd6        mysql:latest        "mysqld"            Less than a second ago   running             192.168.0.42:49178->3306/tcp    node-1/db   

.. Now, you start another container, asking for 1G of RAM again.

これで再び、1GB のメモリを使う別のコンテナを起動してみましょう。

.. code-block:: bash

   $ docker run tcp://<manager_ip:manager_port> -d -P -m 1G --name frontend nginx
   963841b138d8
   
   $ docker tcp://<manager_ip:manager_port> ps
   CONTAINER ID        IMAGE               COMMAND             CREATED                  STATUS              PORTS                           NAMES
   963841b138d8        nginx:latest        "nginx"             Less than a second ago   running             192.168.0.42:49177->80/tcp      node-1/frontend
   f8b693db9cd6        mysql:latest        "mysqld"            Up About a minute        running             192.168.0.42:49178->3306/tcp    node-1/db

.. The system starts the new frontend container on node-1 because it was the node the most packed already. This allows us to start a container requiring 2G of RAM on node-2.

システムは ``node-1`` 上で新しい ``frontend`` コンテナを起動します。これはノードは既に集約するようになっているためです。これにより、2GB のメモリが必要なコンテナは ``node-2`` で動きます。

.. If two nodes have the same amount of available RAM and CPUs, the binpack strategy prefers the node with most containers running.

もし２つのノードが同じメモリと CPU であれば、 ``binpack`` ストラテジは最もコンテナが実行しているノードを選択します。

Docker Swarm ドキュメント目次
==============================

.. 
    User guide
    Scheduler strategies
    Scheduler filters
    Swarm API

* :doc:`ユーザ・ガイド </swarm/index>`
* :doc:`スケジュール・ストラテジ </swarm/scheduler/strategy>`
* :doc:`スケジューラ・フィルタ </swarm/scheduler/filter>`
* :doc:`Swarm API </swarm/swarm-api>`


.. seealso:: 

   Docker Swarm strategies
      https://docs.docker.com/swarm/scheduler/strategy/

