.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/swarm-mode/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/swarm-mode.md
   doc version: 20.10
.. check date: 2022/04/29
mo.. Commits on Aug 16, 2021 15836782038638a20f4e214af6e92bdd01624726
.. -----------------------------------------------------------------------------

.. Run Docker Engine in swarm mode

.. _run-docker-engine-in-swarm-mode:

==================================================
Docker Engine を swarm モードで動作
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. When you first install and start working with Docker Engine, swarm mode is disabled by default. When you enable swarm mode, you work with the concept of services managed through the docker service command.

Docker Engine を初回インストールして実行すると、デフォルトでは swarm モードは無効です。swarm モードを有効化すると、 ``docker service`` コマンドを通してサービスの概念を扱えます。

.. hint::

   訳者注： Docker のドキュメントで「swarm」という言葉が出てくる場合は、ソフトウェア名称としての「swarm」ではなく、Docker Engine のノードで構成する「クラスタ」の意味で用いられるのが大半です。たとえば、「swarm を作成する」という表現は「swarm クラスタを作成する」と置き換えて読む必要があります。

.. There are two ways to run the Engine in swarm mode:

swarm モードで Engine を動かすには、2つの方法があります。

..  Create a new swarm, covered in this article.
    Join an existing swarm.

* 新しい swarm を作成します。このページ中で扱います。
* :doc:`既存のクラスタに参加します <join-nodes>`

.. When you run the Engine in swarm mode on your local machine, you can create and test services based upon images you’ve created or other available images. In your production environment, swarm mode provides a fault-tolerant platform with cluster management features to keep your services running and available.

ローカルマシン上の Engine を swarm モードで動作すると、既に作成したか、他から利用可能なイメージをもとに、サービスの作成やテストが可能です。プロダクション環境であれば、swarm モードはクラスタ管理機能を持つ耐障害性プラットフォームを提供し、サービスを実行中かつ利用可能な状態を維持します。

.. These instructions assume you have installed the Docker Engine 1.12 or later on a machine to serve as a manager node in your swarm.

以下の手順では、マシン上に Docker Engine 1.12 以上をインストールし、そこで swarm の manager ノードを実行するのを想定しています。

.. If you haven’t already, read through the swarm mode key concepts and try the swarm mode tutorial.

もしまだの場合は、 :doc:`key-concepts` を読み、 :doc:`swarm-tutorial/index` をお試しください。

.. Create a swarm

.. _swarm-mode-create-a-swarm:

swarm の作成
====================

.. When you run the command to create a swarm, the Docker Engine starts running in swarm mode.

swarm を作成するコマンドを実行すると、Docker Engine は swarm モードで動作開始します。

.. Run docker swarm init to create a single-node swarm on the current node. The Engine sets up the swarm as follows:

``docker swarm init`` を実行し、現在のノード上で単一ノードの swarm を作成します。Engine は以下の手順で swarm をセットアップします。

..  switches the current node into swarm mode.
    creates a swarm named default.
    designates the current node as a leader manager node for the swarm.
    names the node with the machine hostname.
    configures the manager to listen on an active network interface on port 2377.
    sets the current node to Active availability, meaning it can receive tasks from the scheduler.
    starts an internal distributed data store for Engines participating in the swarm to maintain a consistent view of the swarm and all services running on it.
    by default, generates a self-signed root CA for the swarm.
    by default, generates tokens for worker and manager nodes to join the swarm.
    creates an overlay network named ingress for publishing service ports external to the swarm.
    creates an overlay default IP addresses and subnet mask for your networks

* 現在のノードを swarm モードに切り替え
* ``default`` という名前の swarm を作成
* 現在のノードを swarm におけるleader（リーダー） manager ノードと仮定
* マシンのホスト名をノード名にする
* manager を設定し、アクティブなネットワーク・インターフェース上の port 2377 をリッスンする
* 現在のノードの稼働状況（availability）を ``Active`` に設定。意味はスケジューラからのタスクを受け入れ可能
* swarm に参加する Engine のための内部分散データ・ストアを開始する。これは swarm と swarm 上で実行する全てのサービスの一覧を、一貫して保持。
* デフォルトでは、swarm に対して自己署名ルート CA を生成
* デフォルトでは、swarm に参加する worker と manager 用のトークンを生成
* swarm の外にサービスを公開するため、 ``ingress`` という名前のオーバレイ・ネットワークを作成
* オーバレイ・デフォルト IP アドレスとサブネット・マスクをネットワーク上に作成

.. The output for docker swarm init provides the connection command to use when you join new worker nodes to the swarm:

``docker swarm init`` の出力に、swarm に新しい worker ノードが参加する時に使う接続用コマンドが出ています。

.. code-block:: bash

   $ docker swarm init
   Swarm initialized: current node (dxn1zf6l61qsb1josjja83ngz) is now a manager.
   
   To add a worker to this swarm, run the following command:
   
       docker swarm join \
       --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
       192.168.99.100:2377
   
   To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

.. Configuring default address pools

.. _configuring-default-address-pools:

デフォルトのアドレス・プールを設定
----------------------------------------

.. By default Docker Swarm uses a default address pool 10.0.0.0/8 for global scope (overlay) networks. Every network that does not have a subnet specified will have a subnet sequentially allocated from this pool. In some circumstances it may be desirable to use a different default IP address pool for networks.

デフォルトの Docker Swarm は、グローバル範囲（overlay）ネットワーク用にデフォルトのアドレス・プール ``10.0.0.0/8`` を使用します。全てのネットワークでサブネットの指定がない場合、このプールからサブネットを連続して払い出します。特定の状況においては、ネットワークが使用するデフォルトの IP アドレス・プールを変更した方が望ましいでしょう。

.. For example, if the default 10.0.0.0/8 range conflicts with already allocated address space in your network, then it is desirable to ensure that networks use a different range without requiring Swarm users to specify each subnet with the --subnet command.

たとえば、デフォルト ``10.0.0.0/8`` の範囲が、あなたのネットワークに既に割り当て済みのアドレス範囲と重複する場合です。Swarm ユーザがコマンドで ``--subnet`` を毎回指定するのを避けるには、異なるネットワーク範囲を使う方が望ましいでしょう。

.. To configure custom default address pools, you must define pools at Swarm initialization using the --default-addr-pool command line option. This command line option uses CIDR notation for defining the subnet mask. To create the custom address pool for Swarm, you must define at least one default address pool, and an optional default address pool subnet mask. For example, for the 10.0.0.0/27, use the value 27.

デフォルトのアドレス・プールを変更するには、Swarm 初期化時に、コマンドラインのオプションで ``--default-addr-pool`` を使う必要があります。このコマンドライン・オプションはサブネット・マスク定義に CIDR 記法を使います。Swarm に対してアドレス・プールを調整して作成するには、少なくとも1つのデフォルト・アドレス・プールの指定が必要で、デフォルトのアドレス・プール・サブネットマスクの指定はオプションです。たとえば、 ``10.0.0.0/27`` の場合は ``27`` の値を使います。

.. Docker allocates subnet addresses from the address ranges specified by the --default-addr-pool option. For example, a command line option --default-addr-pool 10.10.0.0/16 indicates that Docker will allocate subnets from that /16 address range. If --default-addr-pool-mask-len were unspecified or set explicitly to 24, this would result in 256 /24 networks of the form 10.10.X.0/24.

``--default-addr-pool`` オプションで指定したアドレス範囲から、Docker がサブネット・アドレスを割り当てます。たとえば、コマンドライン・オプション ``--default-addr-pool 10.10.0.0/16`` が示すのは、Docker が ``/16`` のアドレス範囲からサブネットを割り当てます。もしも ``--default-addr-pool-mask-len`` が未指定か 24 を明示する場合は、この結果 ``10.10.X.0/24`` から 256 ``/24`` が割り当てられます。

.. The subnet range comes from the --default-addr-pool, (such as 10.10.0.0/16). The size of 16 there represents the number of networks one can create within that default-addr-pool range. The --default-addr-pool option may occur multiple times with each option providing additional addresses for docker to use for overlay subnets.

``--default-addr-pool`` からのサブネットの範囲（ ``10.10.0.0/16`` ）を与えられます。この 16 の大きさが表すのは、 ``default-addr-pool`` 範囲内で作成可能な、ネットワーク1つあたりの数です。Docker がオーバレイ・サブネットを使うために、追加のアドレスを提供するオプション指定するため、 ``--default-addr-pool`` オプションは複数回指定する場合もあります。

.. The format of the command is:

コマンドの形式とは、このようなものです。

.. code-block:: bash

   $ docker swarm init --default-addr-pool <IP range in CIDR> [--default-addr-pool <IP range in CIDR> --default-addr-pool-mask-length <CIDR value>]

.. To create a default IP address pool with a /16 (class B) for the 10.20.0.0 network looks like this:

10.20.0.0 ネットワークに対して /16 （クラスB）を持つデフォルトの IP アドレス・プールの作成とは、次のようなものです。

.. code-block:: bash

   $ docker swarm init --default-addr-pool 10.20.0.0/16

.. To create a default IP address pool with a /16 (class B) for the 10.20.0.0 and 10.30.0.0 networks, and to create a subnet mask of /26 for each network looks like this:

``10.20.0.0`` と ``10.30.0.0`` ネットワークに対して ``/16`` （クラスB）のデフォルト IP アドレス・プールを作成し、各ネットワークに対して ``/26`` のサブネット・マスクを作成するには、次のようにします。

.. code-block:: bash

   $ docker swarm init --default-addr-pool 10.20.0.0/16 --default-addr-pool 10.30.0.0/16 --default-addr-pool-mask-length 26

.. In this example, docker network create -d overlay net1 will result in 10.20.0.0/26 as the allocated subnet for net1, and docker network create -d overlay net2 will result in 10.20.0.64/26 as the allocated subnet for net2. This continues until all the subnets are exhausted.

この例では、 ``docker network create -d overlay net1`` によって、 ``net1`` に対して ``10.20.0.0/26`` としてサブネットが割り当てられます。そして、 ``docker network create -d overlay net2`` によって、 ``net2`` に対して ``10.20.0.24/26`` としてサブネットが割り当てられます。これがサブネットを使い切るまで続きます。

.. Refer to the following pages for more information:

詳しい情報は以下のページもご覧ください。

..  Swarm networking for more information about the default address pool usage
    docker swarm init CLI reference for more detail on the --default-addr-pool flag.

* :doc:`Swarm のネットワーク機能 <networking>` に、デフォルト・アドレス・プールに関する詳しい情報があります
* ``docker swarm init`` :doc:`コマンドライン・リファレンス </engine/reference/commandline/swarm_init>` に、 ``--default-addr-pool`` フラグに関する詳しい情報があります。

.. Configure the advertise address

アドバタイズ・アドレスの設定
------------------------------

.. Manager nodes use an advertise address to allow other nodes in the swarm access to the Swarmkit API and overlay networking. The other nodes on the swarm must be able to access the manager node on its advertise address.

manager ノードはアドバタイズ・アドレス（advertise address）を使い、 swarm 上で他のノードが Swarmkit API とオーバレイ・ネットワーク機能にアクセスできるようにします。swarm 上の他のノードは、このアドバタイズ・アドレスを使って manager ノードに対してアクセスできるようにする必要があります。

.. If you don’t specify an advertise address, Docker checks if the system has a single IP address. If so, Docker uses the IP address with the listening port 2377 by default. If the system has multiple IP addresses, you must specify the correct --advertise-addr to enable inter-manager communication and overlay networking:

もしアドバタイズ・アドレスを指定しなければ、Docker が単一の IP アドレスを持っているかどうか確認します。もし単一であれば、 Docker はその IP アドレスを使い、デフォルトでポート ``2377`` をリッスンします。システムが複数の IP アドレスを持つ場合は、manager 間での内部通信やオーバレイ・ネットワーク機能のため、 ``--advertise-addr`` で適切な指定が必須です。

.. code-block:: bash

   $ docker swarm init --advertise-addr <MANAGER-IP>

.. You must also specify the --advertise-addr if the address where other nodes reach the first manager node is not the same address the manager sees as its own. For instance, in a cloud setup that spans different regions, hosts have both internal addresses for access within the region and external addresses that you use for access from outside that region. In this case, specify the external address with --advertise-addr so that the node can propagate that information to other nodes that subsequently connect to it.

1番目の manager ノードが他のノードから到達できない場合は、マネージャに対して接続できるアドレスを ``--advertise-addr`` で指定する必要があります。たとえば、クラウドでのセットアップでは、リージョンが異なったり、ホストがリージョン内と外部のアクセスでは異なる内部アドレスを持つ場合があり、そのリージョンの外から使うアドレスを指定しなくてはいけません。たとえば、 ``--advertise-addr`` で外部のアドレスを指定すると、他のノードに対して継続してノードに接続するための情報として、この情報を伝達（propagete）します。

.. Refer to the docker swarm init CLI reference for more detail on the advertise address.

アドバタイズ・アドレスに関する詳しい情報は、 ``docker swarm init`` :doc:`コマンドライン・リファレンス </engine/reference/commandline/swarm_init>` をご覧ください。

.. View the join command or update a swarm join token

.. _view-the-join-command-or-update-a-swarm-join-token:

join コマンドの表示や、swarm join トークンの更新
--------------------------------------------------

.. Nodes require a secret token to join the swarm. The token for worker nodes is different from the token for manager nodes. Nodes only use the join-token at the moment they join the swarm. Rotating the join token after a node has already joined a swarm does not affect the node’s swarm membership. Token rotation ensures an old token cannot be used by any new nodes attempting to join the swarm.

ノードが swarm に参加するには、シークレット・トークンが必要です。worker ノードに対するトークンは、 manager ノードに対するトークンとは異なります。ノードが使えるのは、swarm に参加するための瞬間的な参加トークン（join-token）のみです。参加トークンが更新されても、既にノードが swarm に参加している状態であれば、ノードの swarm メンバーに対する影響はありません。トークンを更新するのは、 swarm に対して新しいノードの参加を古いトークンを使って試みさせないためです。

.. To retrieve the join command including the join token for worker nodes, run:

worker ノードが参加するためのトークンを含む join コマンドを表示するには、次のようにします。

.. code-block:: bash

   $ docker swarm join-token worker
   
   To add a worker to this swarm, run the following command:
   
       docker swarm join \
       --token SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c \
       192.168.99.100:2377
   
   This node joined a swarm as a worker.

.. To view the join command and token for manager nodes, run:

manager ノードとして参加するコマンドとトークンを表示するには、次のように実行します。

.. code-block:: bash

   $ docker swarm join-token manager
   
   To add a worker to this swarm, run the following command:
   
       docker swarm join \
       --token SWMTKN-1-59egwe8qangbzbqb3ryawxzk3jn97ifahlsrw01yar60pmkr90-bdjfnkcflhooyafetgjod97sz \
       192.168.99.100:2377

.. Pass the --quiet flag to print only the token:

``--quiet`` フラグを使うと、トークンのみを表示します。

.. code-block:: bash

   $ docker swarm join-token --quiet worker
   
   SWMTKN-1-49nj1cmql0jkz5s954yi3oex3nedyz0fb0xx14ie39trti4wxv-8vxv8rssmk743ojnwacrr2e7c

.. Be careful with the join tokens because they are the secrets necessary to join the swarm. In particular, checking a secret into version control is a bad practice because it would allow anyone with access to the application source code to add new nodes to the swarm. Manager tokens are especially sensitive because they allow a new manager node to join and gain control over the whole swarm.

参加トークンには swarm に参加するために必要なシークレットを含みますので、取り扱いに注意してください。特に、バージョン管理においてシークレットを確認するのは悪いプラクティスです。これは誰もがアプリケーションのソースコードにアクセス可能であれば、誰でも swarm に新しいノードを追加できるからです。manager トークンは極めて注意すべきです。これがあれば、新しいマネージャが参加できるようになり、swarm 全体の制御を得られるからです。

.. We recommend that you rotate the join tokens in the following circumstances:

私たちは、以下の状況であれば join トークンをローテートするのを推奨します。

..  If a token was checked-in by accident into a version control system, group chat or accidentally printed to your logs.
    If you suspect a node has been compromised.
    If you wish to guarantee that no new nodes can join the swarm.

* バージョン管理システムに誤ってトークンが入ってしまった場合、グループチャットや事故報告書などに記録します
* ノードは既に信用できない状態であると想定します。
* 新たなノードを一切 swarm に参加させない状況を確保します。

.. Additionally, it is a best practice to implement a regular rotation schedule for any secret including swarm join tokens. We recommend that you rotate your tokens at least every 6 months.

付け加えておくと、ベストプラクティスは、swarm join トークンを含むあらゆるシークレットを、定期的に更新（ローテーション）する実装です。私たちが推奨するのは、少なくとも6ヶ月ごとのトークン更新です。

.. Run swarm join-token --rotate to invalidate the old token and generate a new token. Specify whether you want to rotate the token for worker or manager nodes:

``swarm join-token --rotate`` を実行すると、古いトークンを無効化し、新しいトークンを生成します。更新するのトークンは ``worker`` か ``manager`` ノードかどちらか指定できます。

.. code-block:: bash

   $ docker swarm join-token  --rotate worker
   
   To add a worker to this swarm, run the following command:
   
       docker swarm join \
       --token SWMTKN-1-2kscvs0zuymrsc9t0ocyy1rdns9dhaodvpl639j2bqx55uptag-ebmn5u927reawo27s3azntd44 \
       192.168.99.100:2377

.. Learn more

詳しく学ぶ
==========

..  Join nodes to a swarm
    swarm init command line reference
    Swarm mode tutorial

* :doc:`join-nodes` 
* ``swarm init`` :doc:`コマンドライン・リファレンス </engine/reference/commandline/swarm_init>`
* :doc:`swarm-tutorial/index`



.. seealso:: 

   Run Docker Engine in swarm mode
      https://docs.docker.com/engine/swarm/ingress/
