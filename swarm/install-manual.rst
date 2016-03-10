.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/install-manual/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/install-manual.md
   doc version: 1.10
      https://github.com/docker/swarm/commits/master/docs/install-manual.md
.. check date: 2016/02/27
.. Commits on Feb 23, 2016 744a8112068fbe4ebc155e6a1fef6fb17c1d8dca
.. -------------------------------------------------------------------

.. Build a Swarm cluster for production

========================================
プロダクション用の Swarm クラスタ構築
========================================

.. This example shows you how to deploy a high-availability Docker Swarm cluster. Although this example uses the Amazon Web Services (AWS) platform, you can deploy an equivalent Docker Swarm cluster on many other platforms.

高い可用性を持つ Docker Swarm クラスタのデプロイ方法を紹介します。この例では Amazon Web Services (AWS) をプラットフォームとして使いますが、他のプラットフォーム上でも Docker Swarm クラスタを同じようにデプロイできます。

.. The Swarm cluster will contain three types of nodes: - Swarm manager - Swarm node (aka Swarm agent) - Discovery backend node running consul

Swarm クラスタは３種類のノードで構成されます。

* Swarm マネージャ
* Swarm ノード（別名 Swarm エージェント）
* consul が動くディスカバリ・バックエンド・ノード

.. This example will take you through the following steps: You establish basic network security by creating a security group that restricts inbound traffic by port number, type, and origin. Then, you create four hosts on your network by launching Elastic Cloud (EC2) instances, applying the appropriate security group to each one, and installing Docker Engine on each one. You create a discovery backend by running an consul container on one of the hosts. You create the Swarm cluster by running two Swarm managers in a high-availability configuration. One of the Swarm managers shares a host with consul. Then you run two Swarm nodes. You communicate with the Swarm via the primary manager, running a simple hello world application and then checking which node ran the application. To finish, you test high-availability by making one of Swarm managers fail and checking the status of the managers.

この例では次の手順で進めます。セキュリティ・グループを作成し、基本的なネットワークセキュリティを確立するために、ポート番号、タイプ、通信元に応じたインバウンドのトラフィックを制限します。それから、ネットワーク上にエラスティック・クラウド（EC2）インスタンスを４ホスト起動します。それぞれ適切なセキュリティ・グループを割り当て、それぞれに Docker Engine をインストールします。ホストの１つはディスカバリ・バックエンドとして consul コンテナを実行します。そして２つの Swarm マネージャを実行し、高い可用性を持つクラスタの設定を行います。Swarm マネージャの１つは consul とホストを共有します。それから２つの Swarm ノードを起動し、アプリケーションがノード上で動作するか確認するため、簡単な hello world アプリケーションを動かします。最後に高可用性を確認するため Swarm マネージャの１つを落とし、マネージャの状態がどうなるかを確認します。

.. For a gentler introduction to Swarm, try the Evaluate Swarm in a sandbox page.

一般的な Swarm の導入方法については :doc:`install-w-machine` をご覧ください。

.. Prerequisites

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

.. Update the network security rules

.. _update-the-network-security-rules:

ネットワークのセキュリティ・ルールを変更
========================================

.. AWS uses a “security group” to allow specific types of network traffic on your VPC network. The default security group’s initial set of rules deny all inbound traffic, allow all outbound traffic, and allow all traffic between instances. You’re going to add a couple of rules to allow inbound SSH connections and inbound container images. This set of rules somewhat protects the Engine, Swarm, and Consul ports. For a production environment, you would apply more restrictive security measures. Do not leave Docker Engine ports unprotected.

AWS は VPC ネットワークに対して許可するネットワーク通信を「セキュリティ・グループ」で指定します。初期状態の **default** セキュリティ・グループは、インバウンドの通信を全て拒否し、アウトバンドの通信を全て許可し、インスタンス間の通信を許可するルール群です。ここに SSH 接続とコンテナのイメージを取得（インバウンド）する２つのルールを追加します。このルール設定は Engine 、Swarm 、 Consul のポートを少々は守ります。プロダクション環境においては、セキュリティ度合いによって更に制限するでしょう。Docker Engine のポートを無防備にしないでください。

.. From your AWS home console, click VPC - Isolated Cloud Resources. Then, in the VPC Dashboard that opens, navigate to Security Groups. Select the default security group that’s associated with your default VPC and add the following two rules. (The Allows column is just for your reference.)

AWs ホーム・コンソール画面から、 **VPC - 独立したクラウドリソース** をクリックします。VPC ダッシュボードが開いたら、 **セキュリティグループ** をクリックします。 **default** セキュリティ・グループを選び、 default VPC にセキュリティ・グループを関連付け、以下の２つのルールを追加します（ **説明** の列は自分の確認用です ）。

.. Type     Protocol    Port Range  Source  Allows
.. SSH  TCP     22  0.0.0.0/0   SSH connection
.. HTTP     TCP     80  0.0.0.0/0   Container images

.. list-table::
   :header-rows: 1
   
   * - タイプ
     - プロトコル
     - ポート範囲
     - 送信元
     - 説明
   * - SSH
     - TCP
     - 22
     - 0.0.0.0/0
     - SSH接続
   * - HTTP
     - TCP
     - 80
     - 0.0.0.0/0
     - コンテナのイメージ

.. Create your hosts

.. _create-your-host:

ホストの作成
====================

.. Here, you create five Linux hosts that are part of the “Docker Swarm Example” security group.

ここでは４つの Linux ホストを作成します。それぞれ「Docker Swarm Example」セキュリティ・グループに属します。

.. Open the EC2 Dashboard and launch four EC2 instances, one at a time:

EC2 ダッシュボードを開き、EC2 インスタンスを１つずつ起動します。

..    During Step 1: Choose an Amazon Machine Image (AMI), pick the Amazon Linux AMI.
..    During Step 5: Tag Instance, under Value, give each instance one of these names:
        manager0 & consul0
        manager1
        node0
        node1
..    During Step 6: Configure Security Group, choose Select an existing security group and pick the “default” security group.

* **ステップ１** では ： **Amazon マシン・イメージ (AMI)を選択** します。 *Amazon Linux AMI* を探します。 
* **ステップ５** では： **インスタンスにタグ** を付けます。各インスタンスの **Value** に名前を付けます。

  * manager0 & consul0
  * manager1
  * node0
  * node1

* **ステップ６** では： **セキュリティ・グループを設定** します。 **既存のセキュリティグループ** から「default」を探します。

.. Review and launch your instances.

インスタンスの起動を確認します。

.. Install Docker Engine on each instance

.. _install-docker-engine-on-each-instance:

各インスタンスに Docker Engine をインストール
==================================================

.. Connect to each instance using SSH and install Docker Engine.

各インスタンスに SSH で接続し、Docker エンジンをインストールします。

.. Update the yum packages, and keep an eye out for the “y/n/abort” prompt:

yum パッケージを更新し、「y/n/abort」プロンプトに注意します。

.. code-block:: bash

   $ sudo yum update

.. Run the installation script:

インストール用スクリプトを実行します。

.. code-block:: bash

   $ curl -sSL https://get.docker.com/ | sh

.. Configure and start Docker Engine so it listens for Swarm nodes on port 2375 :

Docker エンジンが Swarm ノードのポート 2375 をリッスンできる指定をして起動します。

.. code-block:: bash

   $ sudo docker daemon -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock

.. Verify that Docker Engine is installed correctly:

Docker Engine が正常にインストールされたことを確認します。

.. code-block:: bash

   $ sudo docker run hello-world

.. The output should display a “Hello World” message and other text without any error messages.

「Hello World」メッセージが画面に表示され、エラーではない文字列が表示されます。

.. Give the ec2-user root privileges:

ec2-user に root 権限を与えます。

.. code-block:: bash

   $ sudo usermod -aG docker ec2-user

.. Then, enter logout.

それから ``logout`` を実行します。

..     Troubleshooting: If entering a docker command produces a message asking whether docker is available on this host, it may be because the user doesn’t have root privileges. If so, use sudo or give the user root privileges. For this example, don’t create an AMI image from one of your instances running Docker Engine and then re-use it to create the other instances. Doing so will produce errors. Troubleshooting: If your host cannot reach Docker Hub, the docker run commands that pull container images may fail. In that case, check that your VPC is associated with a security group with a rule that allows inbound traffic (e.g., HTTP/TCP/80/0.0.0.0/0). Also Chejck the Docker Hub status page for service availability.

.. note::

   トラブルシューティング： ``docker`` コマンドを実行してもホスト上で docker が動作しているかどうか訊ねる表示が出るのは、ユーザが root 権限を持っていない可能性があります。そうであれば、 ``sudo`` を使うか、ユーザに対して root 権限を付与します。この例では、Docker Engine を実行するインスタンスのために AMI イメージを使っておらず、既存のインスタンスを再利用する方法ではありません。そのため、エラーが起こった場合は確認してください。

.. note::

   トラブルシューティング： ホスト上で ``docker run`` コマンドを実行しても Docker Hub に接続できない場合は、コンテナ・イメージの取得に失敗するでしょう。そのような場合、VPC に関連付けられているセキュリティ・グループのルールを参照し、インバウンドの通信（例： HTTP/TCP/80/0.0.0.0.0/0）が許可されているか確認します。また、 `Docker Hub ステータス・ページ <http://status.docker.com/>`_ でサービスが利用可能かどうか確認します。

.. Set up an consul discovery backend

.. _set-up-an-consul-discovery-backend:

consul ディスカバリ・バックエンドのセットアップ
==================================================

.. Here, you’re going to create a minimalist discovery backend. The Swarm managers and nodes use this backend to authenticate themselves as members of the cluster. The Swarm managers also use this information to identify which nodes are available to run containers.

ここでは最小のディスカバリ・バックエンドを作成します。Swarm マネージャとノードは、このバックエンドをクラスタ上のメンバを認識するために使います。また、Swarm マネージャはコンテナを実行可能なノードがどれかを識別するためにも使います。

.. To keep things simple, you are going to run a single consul daemon on the same host as one of the Swarm managers.

簡単さを保つために、Swarm マネージャが動いているホストのうちどれか１つで consul デーモンを起動します。

.. To start, copy the following launch command to a text file.

実行するには、以下のコマンドをコピーして consul コンテナを起動します。

.. code-block:: bash

   $ docker run -d -p 8500:8500 —name=consul progrium/consul -server -bootstrap

.. Then, use SSH to connect to the “manager0 & consul0” instance. At the command line, enter ifconfig. From the output, copy the eth0 IP address from inet addr.

それから、「manager0 & consul0」インスタンスに SSH を使って接続します。コマンドラインで ``ifconfig`` を実行します。出力結果の ``inet addr`` から ``eth0`` IP アドレスをコピーします。

.. Using SSH, connect to the “manager0 & etc0” instance. Copy the launch command from the text file and paste it into the command line.

.. Your consul node is up and running, providing your cluster with a discovery backend. To increase its reliability, you can create a high-availability cluster using a trio of consul nodes using the link mentioned at the end of this page. (Before creating a cluster of console nodes, update the VPC security group with rules to allow inbound traffic on the required port numbers.)

consul ノードを立ち上げて実行すると、クラスタ用のディスカバリ・バックエンドを提供します。このバックエンドの信頼性を高めるには、３つの consul ノードを使った高可用性クラスタを作成する方法があります。詳細情報へリンクを、このページの一番下をご覧ください（consul ノードのクラスタを作成する前に、VPC セキュリティ・グループに対し、必要なポートに対するインバウンド通信を許可する必要があります）。

.. Create a high-availability Swarm cluster

高可用性 Swarm クラスタを作成
==============================

.. After creating the discovery backend, you can create the Swarm managers. Here, you are going to create two Swarm managers in a high-availability configuration. The first manager you run becomes the Swarm’s primary manager. Some documentation still refers to a primary manager as a “master”, but that term has been superseded. The second manager you run serves as a replica. If the primary manager becomes unavailable, the cluster elects the replica as the primary manager.

ディスカバリ・バックエンドを作ったあとは、Swarm マネージャを作成できます。ここでは高い可用性を持つ設定のため、２つの Swarm マネージャを作成します。１つめのマネージャを Swarm の *プライマリ・マネージャ (primary manager) * とします。ドキュメントのいくつかはプライマリを「マスタ」と表現していますが、置き換えてください。２つめのマネージャは *レプリカ（replica）* を提供します。もしもプライマリ・マネージャが利用できなくなれば、クラスタはレプリカからプライマリ・マネージャを選出します。

.. To create the primary manager in a high-availability Swarm cluster, use the following syntax:

高可用性 Swarm クラスタのプライマリ・マネージャを作成するには、次の構文を使います。

.. code-block:: bash

   $ docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise <manager0_ip>:4000  consul://<consul_ip>

.. Because this is particular manager is on the same “manager0 & consul0” instance as the consul node, replace both <manager0_ip> and <consul_ip> with the same IP address. For example:

特定のマネージャは「manager0 & consul0」インスタンスの consul ノードでもあるので、 ``<manager0_ip>`` と ``<consul_ip>`` と同じ IP アドレスに書き換えます。例：

.. code-block:: bash

   $ docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise 172.30.0.161:4000  consul://172.30.0.161:8500

.. Enter docker ps. From the output, verify that both a swarm and an consul container are running. Then, disconnect from the “manager0 & consul0” instance.

``docker ps`` を実行します。出力結果から swarm と consul コンテナが動いているのを確認します。それから「manager0 & consul0」インスタンスから切断します。

.. Connect to the “manager1” instance and use ifconfig to get its IP address. Then, enter the following command, replacing <manager1_ip>. For example:

「manager1」インスタンスに接続し、 ``ifconfig`` で IP アドレスを取得します。それから次のコマンドを実行しますが ``<manager1_ip>`` の部分は書き換えてください。実行例：

.. code-block:: bash

   $ docker run -d swarm manage -H :4000 --replication --advertise <manager1_ip>:4000  consul://172.30.0.161:8500

.. Enter docker ps and, from the output, verify that a swarm container is running.

``docker ps`` を実行し、出力結果から swarm コンテナの実行を確認します。

.. Now, connect to each of the “node0” and “node1” instances, get their IP addresses, and run a Swarm node on each one using the following syntax:

あとは「node0」「node1」インスタンスに接続し、それぞれの IP アドレスを取得し、次の構文を使って Swarm ノードを実行します。

.. code-block:: bash

   $ docker run -d swarm join --advertise=<node_ip>:2375 consul://<consul_ip>:8500

.. For example:

実行例：

   $ docker run -d swarm join --advertise=172.30.0.69:2375 consul://172.30.0.161:8500

.. Your small Swarm cluster is up and running on multiple hosts, providing you with a high-availability virtual Docker Engine. To increase its reliability and capacity, you can add more Swarm managers, nodes, and a high-availability discovery backend.

あなたの小さな Swarm クラスタが起動し、複数のホスト上で実行中になりました。

.. Communicate with the Swarm

.. _communicate-with-the-swarm:

Swarm との通信
====================

.. You can communicate with the Swarm to get information about the managers and nodes using the Swarm API, which is nearly the same as the standard Docker API.
.. In this example, you use SSL to connect to “manager0 & etc0” host again. Then, you address commands to the Swarm manager.

Swarm API を使って Swarm と通信し、マネージャとノードに関する情報を取得できます。Swarm API はスタンダード Docker API とよく似ています。この例では SSL を使って「manager0 & consul0」ホストに再び接続します。そしてコマンドを Swarm マネージャに対して割り当てます。

.. Get information about the master and nodes in the cluster:

クラスタ内のマスタとノードの情報を取得します。

.. code-block:: bash

   $ docker -H :4000 info

.. The output gives the manager’s role as primary (Role: primary) and information about each of the nodes.

出力結果から、マスターの役割がプライマリ（ ``Role: primary`` ）であることと、各ノードの情報が分かります。

.. Now run an application on the Swarm:

次は Swarm 上でアプリケーションを実行します。

.. code-block:: bash

   $ docker -H :4000 run hello-world

.. Check which Swarm node ran the application:

Swarm ノード上でアプリケーションが動いているのを確認します。

   $ docker -H :4000 ps

.. Test the high-availability Swarm managers

.. _test-the-high-availability-swarm-managers:

Swarm マネージャの高可用性試験
==============================

.. To see the replica instance take over, you’re going to shut down the primary manager. Doing so kicks off an election, and the replica becomes the primary manager. When you start the manager you shut down earlier, it becomes the replica.

レプリカ・インスタンスへの継承を確認するために、プライマリ・マネージャをシャットダウンします。これが選出のきっかけとなり、レプリカがプライマリ・マネージャになります。停止したマネジャを再び起動すると、今度はこちらがレプリカになります。

.. Using an SSH connection to the “manager0 & etc0” instance, get the container id or name of the swarm container:

SSH を使って「manager0 & consul0」インスタンスに接続し、swarm コンテナのコンテナ ID かコンテナ名を取得します。

.. code-block:: bash

   $ docker ps

.. Shut down the primary master, replacing <id_name> with the container id or name (e.g., “8862717fe6d3” or “trusting_lamarr”).

プライマリ・マスタをシャットダウンするため、 ``<id_name>`` の部分をコンテナ ID あるいはコンテナ名に置き換えます（例： 「8862717fe6d3」または「trusting_lamarr」）。

.. code-block:: bash

   $ docker rm -f <id_name>

.. Start the swarm master. For example:

swarm マスタを起動します。例：

.. code-block:: bash

   $ docker run -d -p 4000:4000 swarm manage -H :4000 --replication --advertise 172.30.0.161:4000  consul://172.30.0.161:237

.. Look at the logs, replacing <id_name> with the new container id or name:

ログを確認します。 ``<id_name>`` は新しいコンテナ ID かコンテナ名に置き換えます。

.. code-block:: bash

   $ sudo docker logs <id_name>

.. The output shows will show two entries like these ones:

出力から次のような２つのエントリが確認できます。

.. code-block:: bash

   time="2016-02-02T02:12:32Z" level=info msg="Leader Election: Cluster leadership lost"
   time="2016-02-02T02:12:32Z" level=info msg="New leader elected: 172.30.0.160:4000"

.. To get information about the master and nodes in the cluster, enter:

クラスタのマスタとノードに関する情報を取得するには、次のように実行します。

.. code-block:: bash

   $ docker -H :4000 info

.. You can connect to the “master1” node and run the info and logs commands. They will display corresponding entries for the change in leadership.

「master1」ノードに接続し、 ``info`` や ``logs`` コマンドを実行できます。そうすると、新しいリーダーが適切なエントリを返します。

.. Additional Resources

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