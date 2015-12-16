.. https://docs.docker.com/swarm/discovery/
.. doc version: 1.9
.. check date: 2015/12/16

.. Discovery

==============================
ディスカバリ
==============================

.. Docker Swarm comes with multiple Discovery backends.


.. Backends

バックエンド
====================

Docker Swarm は複数のディスカバリ・バックエンドと連携します。

.. You use a hosted discovery service with Docker Swarm. The service maintains a list of IPs in your swam. There are several available services, such as etcd, consul and zookeeper depending on what is best suited for your environment. You can even use a static file. Docker Hub also provides a hosted discovery service which you can use.

Docker Swarm はホステッド・ディスカバリ・サービスを利用できます。このサービスは、自分の Swarm クラスタの IP アドレス一覧を保持します。 ``etcd`` 、 ``consul`` 、 ``zookeeper`` のような複数のサービスが利用可能です。自分の環境にあわせて何がベストかによって選べます。静的なファイルも利用できます。Docker Hub もホステッド・ディスカバリ・サービスを提供しており、こちらも利用可能です。

.. Hosted Discovery with Docker Hub

Docker Hub のホステッド・ディスカバリ
----------------------------------------

.. This example uses the hosted discovery service on Docker Hub. Using Docker Hub’s hosted discovery service requires that each node in the swarm is connected to the internet. To create your swarm:

この例は Docker Hub のホステッド・ディスカバリ・サービスを使います。Docker Hub のホステッド・ディスカバリ・サービスを使うには、インターネットに接続している必要があります。次のようにして Swarm クラスタを作成します。

.. First we create a cluster.

まずクラスタを作成します。

   # クラスタを作成
   $ swarm create
   6856663cdefdec325839a4b7e1de38e8 # <- this is your unique <cluster_id>

.. Then we create each node and join them to the cluster.

次に、各ノードを作成し、クラスタに追加します。

.. code-block:: bash

   # 各ノードで Swam エージェントを起動します。
   # Swam Manager がアクセス可能であれば、
   # <node_ip> はパブリックである必要はありません（例：192.168.0.x）。
   $ swarm join --advertise=<node_ip:2375> token://<cluster_id>

.. Finally, we start the Swarm manager. This can be on any machine or even your laptop.

最後に、Swarm マネージャ（manager）を起動します。これはあらゆるマシンだけでなく、自分のノート PC 上でも実行できます。

.. code-block:: bash

   $ swarm manage -H tcp://<swarm_ip:swarm_port> token://<cluster_id>

.. You can then use regular Docker commands to interact with your swarm.

通常の Docker コマンドを使い、Swarm と通信できます。

.. code-block:: bash

   docker -H tcp://<swarm_ip:swarm_port> info
   docker -H tcp://<swarm_ip:swarm_port> run ...
   docker -H tcp://<swarm_ip:swarm_port> ps
   docker -H tcp://<swarm_ip:swarm_port> logs ...
   ...

.. You can also list the nodes in your cluster.

クラスタのノード情報一覧も表示できます。

.. code-block:: bash

   swarm list token://<cluster_id>
   <node_ip:2375>

.. Using a static file describing the cluster

静的なファイルでクラスタを指定
------------------------------

.. For each of your nodes, add a line to a file. The node IP address doesn’t need to be public as long the Swarm manager can access it.

ファイルに各ノードの情報を追加します。ノードの IP アドレスは、Swarm マネージャがアクセス可能であればパブリックである必要はありません。

.. code-block:: bash

   echo <node_ip1:2375> >> /tmp/my_cluster
   echo <node_ip2:2375> >> /tmp/my_cluster
   echo <node_ip3:2375> >> /tmp/my_cluster

.. Then start the Swarm manager on any machine.

それから、いずれかのマシン上で Swarm マネージャを起動します。

.. code-block:: bash

   swarm manage -H tcp://<swarm_ip:swarm_port> file:///tmp/my_cluster

.. And then use the regular Docker commands.

あとは、通常の Docker コマンドを使います。

.. code-block:: bash

   docker -H tcp://<swarm_ip:swarm_port> info
   docker -H tcp://<swarm_ip:swarm_port> run ...
   docker -H tcp://<swarm_ip:swarm_port> ps
   docker -H tcp://<swarm_ip:swarm_port> logs ...
   ...

.. You can list the nodes in your cluster.

クラスタのノード情報一覧も表示できます。

.. code-block:: bash

   $ swarm list file:///tmp/my_cluster
   <node_ip1:2375>
   <node_ip2:2375>
   <node_ip3:2375>

.. Using etcd

etcd の使用
--------------------

.. On each of your nodes, start the Swarm agent. The node IP address doesn’t have to be public as long as the swarm manager can access it.

各ノードで Swarm エージェントを起動します。ノードの IP アドレスは、Swarm マネージャがアクセス可能であればパブリックである必要はありません。

.. code-block:: bash

   swarm join --advertise=<node_ip:2375> etcd://<etcd_addr1>,<etcd_addr2>/<optional path prefix>

.. Start the manager on any machine or your laptop.

いずれかのマシン上かノート PC 上で Swarm マネージャを起動します。

.. code-block:: bash

   swarm manage -H tcp://<swarm_ip:swarm_port> etcd://<etcd_addr1>,<etcd_addr2>/<optional path prefix>

.. And then use the regular Docker commands.

あとは、通常の Docker コマンドを使います。

.. code-block:: bash

   docker -H tcp://<swarm_ip:swarm_port> info
   docker -H tcp://<swarm_ip:swarm_port> run ...
   docker -H tcp://<swarm_ip:swarm_port> ps
   docker -H tcp://<swarm_ip:swarm_port> logs ...
   ...

.. You can list the nodes in your cluster.

クラスタのノード情報一覧も表示できます。

.. code-block:: bash

   swarm list etcd://<etcd_addr1>,<etcd_addr2>/<optional path prefix>
<node_ip:2375>

.. Using consul

consul の使用
--------------------

.. On each of your nodes, start the Swarm agent. The node IP address doesn’t need to be public as long as the Swarm manager can access it.

各ノードで Swarm エージェントを起動します。ノードの IP アドレスは、Swarm マネージャがアクセス可能であればパブリックである必要はありません。

.. code-block:: bash

   swarm join --advertise=<node_ip:2375> consul://<consul_addr>/<optional path prefix>

.. Start the manager on any machine or your laptop.

いずれかのマシン上かノート PC 上で Swarm マネージャを起動します。

.. code-block:: bash

   swarm manage -H tcp://<swarm_ip:swarm_port> consul://<consul_addr>/<optional path prefix>

.. And then use the regular Docker commands.

あとは、通常の Docker コマンドを使います。

.. code-block:: bash

   docker -H tcp://<swarm_ip:swarm_port> info
   docker -H tcp://<swarm_ip:swarm_port> run ...
   docker -H tcp://<swarm_ip:swarm_port> ps
   docker -H tcp://<swarm_ip:swarm_port> logs ...
   ...

.. You can list the nodes in your cluster.

クラスタのノード情報一覧も表示できます。

.. code-block:: bash

   swarm list consul://<consul_addr>/<optional path prefix>
   <node_ip:2375>

.. Using zookeeper

zookeeper の使用
--------------------

.. On each of your nodes, start the Swarm agent. The node IP doesn’t have to be public as long as the swarm manager can access it.

各ノードで Swarm エージェントを起動します。ノードの IP アドレスは、Swarm マネージャがアクセス可能であればパブリックである必要はありません。

.. code-block:: bash

   swarm join --advertise=<node_ip:2375> zk://<zookeeper_addr1>,<zookeeper_addr2>/<optional path prefix>

.. Start the manager on any machine or your laptop.

いずれかのマシン上かノート PC 上で Swarm マネージャを起動します。

.. code-block:: bash

   swarm manage -H tcp://<swarm_ip:swarm_port> zk://<zookeeper_addr1>,<zookeeper_addr2>/<optional path prefix>

.. You can then use the regular Docker commands.

あとは、通常の Docker コマンドを使えます。

.. code-block:: bash

   docker -H tcp://<swarm_ip:swarm_port> info
   docker -H tcp://<swarm_ip:swarm_port> run ...
   docker -H tcp://<swarm_ip:swarm_port> ps
   docker -H tcp://<swarm_ip:swarm_port> logs ...
   ...

.. You can list the nodes in the cluster.

クラスタのノード情報一覧も表示できます。

.. code-block:: bash

   swarm list zk://<zookeeper_addr1>,<zookeeper_addr2>/<optional path prefix>
   <node_ip:2375>

.. Using a static list of IP address

固定した IP アドレスのリストを使用
----------------------------------------

いずれかのマシン上かノート PC 上で Swarm マネージャを起動します。

.. code-block:: bash

   swarm manage -H <swarm_ip:swarm_port> nodes://<node_ip1:2375>,<node_ip2:2375>

.. Or

または

.. code-block:: bash

   swarm manage -H <swarm_ip:swarm_port> <node_ip1:2375>,<node_ip2:2375

.. Then use the regular Docker commands.

あとは、通常の Docker コマンドを使えます。

.. code-block:: bash

   docker -H <swarm_ip:swarm_port> info
   docker -H <swarm_ip:swarm_port> run ...
   docker -H <swarm_ip:swarm_port> ps
   docker -H <swarm_ip:swarm_port> logs ...

.. Range pattern for IP addresses

IP アドレスの範囲をパターンで指定

.. The file and nodes discoveries support a range pattern to specify IP addresses, i.e., 10.0.0.[10:200] will be a list of nodes starting from 10.0.0.10 to 10.0.0.200.

``file`` と ``node`` あ、特定の IP アドレスの範囲をパターンで指定することで、ディスカバリをサポートします。例えば ``10.0.0.[10:200]`` は ``10.0.0.10`` から ``10.0.0.200`` の範囲にあるノードを使います。

.. For example for the file discovery method.

次の例は、 ``file`` ディスカバリ・メソッドを使います。

.. code-block:: bash

   $ echo "10.0.0.[11:100]:2375"   >> /tmp/my_cluster
   $ echo "10.0.1.[15:20]:2375"    >> /tmp/my_cluster
   $ echo "192.168.1.2:[2:20]375"  >> /tmp/my_cluster

.. Then start the manager.

それからマネージャを起動します。

.. code-block:: bash

   swarm manage -H tcp://<swarm_ip:swarm_port> file:///tmp/my_cluster

.. And for the nodes discovery method.

そして、 ``node`` ディスカバリ・メソッドを使います。

.. code-block:: bash

   swarm manage -H <swarm_ip:swarm_port> "nodes://10.0.0.[10:200]:2375,10.0.1.[2:250]:2375"

.. Contributing a new discovery backend

新しいディスカバリ・バックエンドに貢献
========================================

.. You can contribute a new discovery backend to Swarm. For information on how to do this, see our discovery README in the Docker Swarm repository.

あなたは Swam 向けに新しいディスカバリ・バックエンドに貢献できます。どのようにするかは、 `Docker Swarm レポジトリにある discovery README <https://github.com/docker/swarm/blob/master/discovery/README.md>`_ をお読みください。



