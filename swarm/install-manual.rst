.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/install-manual/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/install-manual.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/install-manual.md
.. check date: 2016/04/29
.. Commits on Apr 14, 2016 70a180cb30ea4593b8f69d14c544cf278bf54ddd
.. -------------------------------------------------------------------

.. Build a Swarm cluster for production

========================================
プロダクション用の Swarm クラスタ構築
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This page teaches you to deploy a high-availability Docker Swarm cluster. Although the example installation uses the Amazon Web Services (AWS) platform, you can deploy an equivalent Docker Swarm cluster on many other platforms. In this example, you do the following:

高い可用性を持つ Docker Swarm クラスタのデプロイ方法を紹介します。この例では Amazon Web Services (AWS) をプラットフォームとして使いますが、他のプラットフォーム上でも Docker Swarm クラスタを同じようにデプロイできます。この例では、以下の手順で進めます。

.. The Swarm cluster will contain three types of nodes: - Swarm manager - Swarm node (aka Swarm agent) - Discovery backend node running consul

* :ref:`動作条件の確認 <swarm-prequisites>`
* :ref:`基本的なネットワーク・セキュリティの確保 <step-1-add-network-security-rules>`
* :ref:`ノードの作成 <step-2-create-your-instances>`
* :ref:`各ノードに Engine をインストール <step-3-install-engine-on-each-node>`
* :ref:`ディスカバリ・バックエンドの設定 <step-4-set-up-a-discovery-backend>`
* :ref:`Swarm クラスタの作成 <step-5-create-swarm-cluster>`
* :ref:`Swarm との通信 <step-6-communicate-with-the-swarm>`
* :ref:`Swarm マネージャの高可用性試験 <step-7-test-swarm-failover>`
* :ref:`追加情報 <warm-additional-resources>`

.. For a gentler introduction to Swarm, try the Evaluate Swarm in a sandbox page.

一般的な Swarm の導入方法については :doc:`install-w-machine` をご覧ください。

.. Prerequisites

.. _swarm-prequisites:

動作条件
==========

..    An Amazon Web Services (AWS) account
    Familiarity with AWS features and tools, such as:
        Elastic Cloud (EC2) Dashboard
        Virtual Private Cloud (VPC) Dashboard
        VPC Security groups
        Connecting to an EC2 instance using SSH

* Amazon Web Services (AWS) アカウント
* 以下の AWS 機能やツールに慣れている：

  * エラスティック・クラウド（EC2）ダッシュボード
  * バーチャル・プライベート・クラウド（VPC）ダッシュボード
  * VPC セキュリティ・グループ
  * EC2 インスタンスに SSH で接続

.. Step 1. Add network security rules

.. _step-1-add-network-security-rules:

ステップ１：ネットワーク・セキュリティのルールを追加
============================================================

.. AWS uses a “security group” to allow specific types of network traffic on your VPC network. The default security group’s initial set of rules deny all inbound traffic, allow all outbound traffic, and allow all traffic between instances.

AWS は VPC ネットワークに対して許可するネットワーク通信を「セキュリティ・グループ」で指定します。初期状態の **default** セキュリティ・グループは、インバウンドの通信を全て拒否し、アウトバンドの通信を全て許可し、インスタンス間の通信を許可するルール群です。

.. You’re going to add a couple of rules to allow inbound SSH connections and inbound container images. This set of rules somewhat protects the Engine, Swarm, and Consul ports. For a production environment, you would apply more restrictive security measures. Do not leave Docker Engine ports unprotected.

ここに SSH 接続とコンテナのイメージを取得（インバウンド）する２つのルールを追加します。このルール設定は Engine 、Swarm 、 Consul のポートを少々は守ります。プロダクション環境においては、セキュリティ度合いによって更に制限するでしょう。Docker Engine のポートを無防備にしないでください。

.. From your AWS home console, do the following:

AWS のホーム・コンソール画面から、以下の作業を進めます：

.. Click VPC - Isolated Cloud Resources.

1. **VPC - 独立したクラウドリソース** をクリックします。

.. The VPC Dashboard opens.

VPC ダッシュボードが開きます。

.. Navigate to Security Groups.

2.  **セキュリティグループ** をクリックします。 

.. Select the default security group that’s associated with your default VPC.

3. **default** セキュリティ・グループを選び、 default VPC にセキュリティ・グループを関連付けます。

.. Add the following two rules.

4. 以下の２つのルールを追加します。

.. Type     Protocol    Port Range  Source  Allows
.. SSH  TCP     22  0.0.0.0/0   SSH connection
.. HTTP     TCP     80  0.0.0.0/0   Container images

.. list-table::
   :header-rows: 1
   
   * - タイプ
     - プロトコル
     - ポート範囲
     - 送信元
   * - SSH
     - TCP
     - 22
     - 0.0.0.0/0
   * - HTTP
     - TCP
     - 80
     - 0.0.0.0/0

.. The SSH connection allows you to connect to the host while the HTTP is for container images.

SSH 接続はホストに接続するためです。HTTP はコンテナ・イメージをホストにダウンロードするためです。

.. Step 2. Create your instances

.. _step-2-create-your-instances:

ステップ２：インスタンス作成
==============================

.. In this step, you create five Linux hosts that are part of your default security group. When complete, the example deployment contains three types of nodes:

このステップではデフォルトのセキュリティ・グループで５つの Linux ホストを作成します。作業は３種類のノードをデプロイする例です


.. list-table::
   :header-rows: 1
   
   * - ノードの説明
     - 名前
   * - Swarm のプライマリとセカンダリ・マネージャ
     - ``manager0`` , ``manager1``
   * - Swarm ノード
     - ``node0`` , ``node1``
   * - ディスカバリ・バックエンド
     - ``consul0``

.. To create the instances do the following:

インスタンスの作成は、以下の手順で進めます。


.. Open the EC2 Dashboard and launch four EC2 instances, one at a time.

1. EC2 ダッシュボードを開き、各 EC2 インスタンスを同時に起動します。

..    During Step 1: Choose an Amazon Machine Image (AMI), pick the Amazon Linux AMI.
..    During Step 5: Tag Instance, under Value, give each instance one of these names:
        manager0 & consul0
        manager1
        node0
        node1
..    During Step 6: Configure Security Group, choose Select an existing security group and pick the “default” security group.

* **ステップ１** では ： **Amazon マシン・イメージ (AMI)を選択** します。 *Amazon Linux AMI* を探します。 
* **ステップ５** では： **インスタンスにタグ** を付けます。各インスタンスの **Value** に名前を付けます。

  * ``manager0``
  * ``manager1``
  * ``consul0``
  * ``node0``
  * ``node1``

* **ステップ６** では： **セキュリティ・グループを設定** します。 **既存のセキュリティグループ** から「default」を探します。

.. Review and launch your instances.

2. インスタンスの起動を確認します。

.. Step 3. Install Engine on each node

.. _step-3-install-engine-on-each-node:

ステップ３：各ノードに Engine をインストール
==================================================

.. In this step, you install Docker Engine on each node. By installing Engine, you enable the Swarm manager to address the nodes via the Engine CLI and API.

このステップでは、各ノードに Docker Engine をインストールします。Engine をインストールすることで、Swarm マネージャは Engine CLI と API を経由してノードを割り当てます。

.. SSH to each node in turn and do the following.

SSH で各ノードに接続し、以下の手順を進めます。

.. Update the yum packages.

1. yum パッケージを更新します。

.. Keep an eye out for the “y/n/abort” prompt:

「y/n/abort」プロンプトに注意します。

.. code-block:: bash

   $ sudo yum update

.. Run the installation script:

2. インストール用スクリプトを実行します。

.. code-block:: bash

   $ curl -sSL https://get.docker.com/ | sh

.. Configure and start Docker Engine so it listens for Swarm nodes on port 2375 :

3. Docker Engine が Swarm ノードのポート 2375 で通信可能な指定で起動します。

.. code-block:: bash

   $ sudo docker daemon -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock

.. Verify that Docker Engine is installed correctly:

4. Docker Engine が正常にインストールされたことを確認します。

.. code-block:: bash

   $ sudo docker run hello-world

.. The output should display a “Hello World” message and other text without any error messages.

「Hello World」メッセージが画面に表示され、エラーではない文字列が表示されます。

.. Give the ec2-user root privileges:

5. ``ec2-user`` に root 権限を与えます。

.. code-block:: bash

   $ sudo usermod -aG docker ec2-user

.. Enter logout.

6. ``logout`` を実行します。

トラブルシューティング
------------------------------

..    If entering a docker command produces a message asking whether docker is available on this host, it may be because the user doesn’t have root privileges. If so, use sudo or give the user root privileges.

*  ``docker`` コマンドを実行してもホスト上で docker が動作しているかどうか訊ねる表示が出るのは、ユーザが root 権限を持っていない可能性があります。そうであれば、 ``sudo`` を使うか、ユーザに対して root 権限を付与します。

..    For this example, don’t create an AMI image from one of your instances running Docker Engine and then re-use it to create the other instances. Doing so will produce errors.

* この例では、Docker Engine が動作するインスタンスを元にし、他のインスタンス用に使う AMI イメージを作成しません。作成したとしても問題になるでしょう。

..    If your host cannot reach Docker Hub, the docker run commands that pull container images may fail. In that case, check that your VPC is associated with a security group with a rule that allows inbound traffic (e.g., HTTP/TCP/80/0.0.0.0/0). Also Check the Docker Hub status page for service availability.

*  ホスト上で ``docker run`` コマンドを実行しても Docker Hub に接続できない場合は、コンテナ・イメージの取得に失敗するでしょう。そのような場合、VPC に関連付けられているセキュリティ・グループのルールを参照し、インバウンドの通信（例： HTTP/TCP/80/0.0.0.0.0/0）が許可されているか確認します。また、 `Docker Hub ステータス・ページ <http://status.docker.com/>`_ でサービスが利用可能かどうか確認します。

.. Step 4. Set up a discovery backend

.. _step-4-set-up-a-discovery-backend:

ステップ４：ディスカバリ・バックエンドのセットアップ
============================================================

.. Here, you’re going to create a minimalist discovery backend. The Swarm managers and nodes use this backend to authenticate themselves as members of the cluster. The Swarm managers also use this information to identify which nodes are available to run containers.

ここでは最小のディスカバリ・バックエンドを作成します。Swarm マネージャとノードは、このバックエンドをクラスタ上のメンバを認識するために使います。また、Swarm マネージャはコンテナを実行可能なノードがどれかを識別するためにも使います。

.. To keep things simple, you are going to run a single consul daemon on the same host as one of the Swarm managers.

簡単さを保つために、Swarm マネージャが動いているホストのうちどれか１つで consul デーモンを起動します。

.. To start, copy the following launch command to a text file.

1. 始めるにあたり、以下のコマンドをテキスト・ファイルにコピーしておきます。

.. code-block:: bash

   $ docker run -d -p 8500:8500 --name=consul progrium/consul -server -bootstrap

..    Use SSH to connect to the manager0 and consul0 instance.

2. SSH で ``manager0`` と ``consul0`` インスタンスに接続します。

.. code-block:: bash

   $ ifconfig

..    From the output, copy the eth0 IP address from inet addr.

3. 出力結果から ``inet addr`` の ``eth0`` にある IP アドレスをコピーします。

..    Using SSH, connect to the manager0 and consul0 instance.

4. SSH で ``manager0`` と ``consul0`` インスタンスに接続します。

..    Paste the launch command you created in step 1. into the command line.

5. 手順１で実行したコマンドを、コマンドラインに貼り付けます。

.. code-block:: bash

   $ docker run -d -p 8500:8500 --name=consul progrium/consul -server -bootstrap

.. Your consul node is up and running, providing your cluster with a discovery backend. To increase its reliability, you can create a high-availability cluster using a trio of consul nodes using the link mentioned at the end of this page. (Before creating a cluster of console nodes, update the VPC security group with rules to allow inbound traffic on the required port numbers.)

consul ノードを立ち上げて実行することで、クラスタ用のディスカバリ・バックエンドを提供します。このバックエンドの信頼性を高めるには、３つの consul ノードを使った高可用性クラスタを作成する方法があります。詳細情報へリンクを、このページの一番下をご覧ください（consul ノードのクラスタを作成する前に、VPC セキュリティ・グループに対し、必要なポートに対するインバウンド通信を許可する必要があります）。

.. Step 5. Create Swarm cluster

.. _step-5-create-swarm-cluster:

ステップ５：Swarm クラスタの作成
========================================

.. After creating the discovery backend, you can create the Swarm managers. In this step, you are going to create two Swarm managers in a high-availability configuration. The first manager you run becomes the Swarm’s primary manager. Some documentation still refers to a primary manager as a “master”, but that term has been superseded. The second manager you run serves as a replica. If the primary manager becomes unavailable, the cluster elects the replica as the primary manager.

ディスカバリ・バックエンドを作った後は、Swarm マネージャを作成できます。このステップでは高い可用性を持つ設定のため、２つの Swarm マネージャを作成します。１つめのマネージャを Swarm の *プライマリ・マネージャ (primary manager)* とします。ドキュメントのいくつかはプライマリを「マスタ」と表現していますが、置き換えてください。２つめのマネージャは *レプリカ（replica）* を提供します。もしもプライマリ・マネージャが利用できなくなれば、クラスタはレプリカからプライマリ・マネージャを選出します。

.. To create the primary manager in a high-availability Swarm cluster, use the following syntax:

1. 高可用性 Swarm クラスタのプライマリ・マネージャを作成するには、次の構文を使います。

.. code-block:: bash

   $ docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise <manager0_ip>:4000  consul://<consul_ip>:8500

.. Because this is particular manager is on the same “manager0 & consul0” instance as the consul node, replace both <manager0_ip> and <consul_ip> with the same IP address. For example:

特定のマネージャは「manager0 & consul0」インスタンスの consul ノードでもあるので、 ``<manager0_ip>`` と ``<consul_ip>`` を同じ IP アドレスに書き換えます。例：

.. code-block:: bash

   $ docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise 172.30.0.161:4000  consul://172.30.0.161:8500

.. Enter docker ps. 

2. ``docker ps`` を入力します。

.. From the output, verify that both a Swarm cluster and a consul container are running. Then, disconnect from the manager0 and consul0 instance.

出力結果から Swarm クラスタと consul コンテナが動いているのを確認します。それから ``manager0`` と ``consul0`` インスタンスから切断します。

..   Connect to the manager1 node and use ifconfig to get its IP addre

3. ``manager1`` インスタンスに接続し、 ``ifconfig`` で IP アドレスを取得します。

.. code-block:: bash

   $ ifconfig

.. Start the secondary Swarm manager using following command.

4. 以下のコマンドを実行し、セカンダリ Swarm マネージャを起動します。

.. Replacing <manager1_ip> with the IP address from the previous command, for example

コマンドを実行前に ``<manager1_ip>`` の部分は書き換えてください。実行例：

.. code-block:: bash

   $ docker run -d swarm manage -H :4000 --replication --advertise <manager1_ip>:4000  consul://172.30.0.161:8500

.. Enter docker psto verify that a Swarm container is running.

5. ``docker ps`` を実行し、 swarm コンテナの実行を確認します。

.. Connect to node0 and node1 in turn and join them to the cluster.

6. ``node0`` と ``node1`` に接続し、それぞれをクラスタに追加（join）します。

.. Get the node IP addresses with the ifconfig command.

a. ``ifconfig`` コマンドでノードの IP アドレスを確認します。

.. Start a Swarm container each using the following syntax:

b. 各コンテナで、次の構文を使って Swarm コンテナを起動します。

.. code-block:: bash

   $ docker run -d swarm join --advertise=<node_ip>:2375 consul://<consul_ip>:8500

.. For example:

実行例：

.. code-block:: bash

   $ docker run -d swarm join --advertise=172.30.0.69:2375 consul://172.30.0.161:8500

.. Your small Swarm cluster is up and running on multiple hosts, providing you with a high-availability virtual Docker Engine. To increase its reliability and capacity, you can add more Swarm managers, nodes, and a high-availability discovery backend.


あなたの小さな Swarm クラスタが起動し、複数のホスト上で実行中になりました。信頼性や収容能力を高めるには、Swarm マネージャやノードを更に追加し、ディレクトリ・バックエンドの可用性を高めることも可能です。

.. Step 6. Communicate with the Swarm

.. _step-6-communicate-with-the-swarm:

ステップ６：Swarm と通信
==============================

.. You can communicate with the Swarm to get information about the managers and nodes using the Swarm API, which is nearly the same as the standard Docker API. In this example, you use SSL to connect to manager0 and consul0 host again. Then, you address commands to the Swarm manager.

Swarm API を使って Swarm と通信し、マネージャとノードに関する情報を取得できます。Swarm API はスタンダード Docker API とよく似ています。この例では SSL を使って ``manager0`` と ``consul0`` ホストに再び接続します。そしてコマンドを Swarm マネージャに対して割り当てます。

.. Get information about the master and nodes in the cluster:

1. クラスタ内のマスタとノードの情報を取得します。

.. code-block:: bash

   $ docker -H :4000 info

.. The output gives the manager’s role as primary (Role: primary) and information about each of the nodes.

出力結果から、マスタの役割がプライマリ（ ``Role: primary`` ）であることと、各ノードの情報が分かります。

.. Run an application on the Swarm:

2.  Swarm 上でアプリケーションを実行します。

.. code-block:: bash

   $ docker -H :4000 run hello-world

.. Check which Swarm node ran the application:

3. Swarm ノード上でアプリケーションが動いているのを確認します。

.. code-block:: bash

   $ docker -H :4000 ps

.. Step 7. Test Swarm failover

.. _step-7-test-swarm-failover:

ステップ７：Swarm のフェイルオーバをテスト
==================================================

.. To see the replica instance take over, you’re going to shut down the primary manager. Doing so kicks off an election, and the replica becomes the primary manager. When you start the manager you shut down earlier, it becomes the replica.

レプリカ・インスタンスへの継承を確認するために、プライマリ・マネージャをシャットダウンします。これが選出のきっかけとなり、レプリカがプライマリ・マネージャになります。停止したマネージャを再び起動したら、今度はこちらがレプリカになります。

.. SSH connection to the manager0 instance.

1. ``manage0`` インスタンスに SSH 接続します。

.. Get the container id or name of the swarm container:

2. ``swarm`` コンテナのコンテナ ID もしくはコンテナ名を取得します。

.. code-block:: bash

   $ docker ps

.. Shut down the primary master, replacing <id_name> with the container id or name (e.g., “8862717fe6d3” or “trusting_lamarr”).

3. プライマリ・マスタをシャットダウンするため、 ``<id_name>`` の部分をコンテナ ID あるいはコンテナ名に置き換えます（例： 「8862717fe6d3」または「trusting_lamarr」）。

.. code-block:: bash

   $ docker rm -f <id_name>

.. Start the swarm master. For example:

4. swarm マスタを起動します。例：

.. code-block:: bash

   $ docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise 172.30.0.161:4000  consul://172.30.0.161:237

.. Review the Engine’s daemon logs the logs, replacing <id_name> with the new container’s id or name:

5. Engine デーモンのログを確認します。 ``<id_name>`` は新しいコンテナ ID かコンテナ名に置き換えます。

.. code-block:: bash

   $ sudo docker logs <id_name>

.. The output shows will show two entries like these ones:

出力から次のような２つのエントリが確認できます。

.. code-block:: bash

   time="2016-02-02T02:12:32Z" level=info msg="Leader Election: Cluster leadership lost"
   time="2016-02-02T02:12:32Z" level=info msg="New leader elected: 172.30.0.160:4000"

.. To get information about the master and nodes in the cluster, enter:

6. クラスタのマスタとノードに関する情報を取得するには、次のように実行します。

.. code-block:: bash

   $ docker -H :4000 info

.. You can connect to the manager1 node and run the info and logs commands. They will display corresponding entries for the change in leadership.

``master1`` ノードに接続し、 ``info`` や ``logs`` コマンドを実行できます。そうすると、新しいリーダーが適切なエントリを返します。

.. Additional Resources

.. _warm-additional-resources:

追加情報
==========

..    Installing Docker Engine
        Example: Manual install on a cloud provider
    Docker Swarm
        Docker Swarm 1.0 with Multi-host Networking: Manual Setup
        High availability in Docker Swarm
        Discovery
    consul Discovery Backend
        high-availability cluster using a trio of consul nodes
    Networking
        Networking


* Docker Engine のインストール

  * :doc:`/engine/installation/cloud/cloud-ex-aws`

* Docker swarm

  * `Docker Swarm 1.0 with Multi-host Networking Manual setup <http://goelzer.com/blog/2015/12/29/docker-swarmoverlay-networks-manual-method/>`_
  * :doc:`/swarm/multi-manager-setup`
  * :doc:`discovery`

* consul ディスカバリ・バックエンド

  * `３つの consul ノードを使った高可用性クラスタ（英語） <https://hub.docker.com/r/progrium/consul/>`_

* ネットワーク

  * :doc:`networking`

.. seealso:: 

   Build a Swarm cluster for production
      https://docs.docker.com/swarm/install-manual/
