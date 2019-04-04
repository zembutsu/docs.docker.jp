.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/part4/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/get-started/part4.md
.. check date: 2017/09/09
.. Commits on Aug 26 2017 4445f27581bd2d190ecd69b6ca31b8dc04b2b9e3
.. -----------------------------------------------------------------------------

.. Get Started, Part 4: Swarms

========================================
Part 4：Swarm
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Prerequisites

必要条件
==========

..    Install Docker version 1.13 or higher.
    Get Docker Compose as described in Part 3 prerequisites.
    Get Docker Machine, which is pre-installed with Docker for Mac and Docker for Windows, but on Linux systems you need to install it directly. On pre Windows 10 systems without Hyper-V, as well as Windows 10 Home, use Docker Toolbox.
    Read the orientation in Part 1.
    Learn how to create containers in Part 2.
    Make sure you have published the friendlyhello image you created by pushing it to a registry. We’ll be using that shared image here.
    Be sure your image works as a deployed container. Run this command, slotting in your info for username, repo, and tag: docker run -p 80:80 username/repo:tag, then visit http://localhost/.
    Have a copy of your docker-compose.yml from Part 3 handy.

* :doc:`Docker バージョン 1.13 またはそれ以上をインストールしていること。</engine/installation/index>`
* :doc:`Part 3 の必要条件 </get-started/part3.md#prerequisites>` で説明した :doc:`Docker Compose </engine/installation/index>` を入手していること。
* :doc:`Docker Machine </machine/overview>` を入手。 Docker for Mac と Docker for Windows ではインストール済みですので、このまま読み進めてください。Linux システムでは :ref:`直接インストール <installing-machine-directly>_ が必要です。Widows 10 システム上で Hyper-V が入っていなければ、 :doc:`Docker Toolbox </toolbox/overview>` をお使い下さい。
* :doc:`Part 1 <index>` の概要を読んでいること
* :doc:`Part 2 <part>` のコンテナの作成方法学んでいること
* 自分で作成した ``friendlyhello`` イメージを :ref:`レジストリに送信 <share-your-image>` して公開済みなのを確認します。ここでは、この共有イメージを使います。
* イメージをコンテナとしてデプロイできるのを確認します。次のコマンドを実行しますが、 ``ユーザ名`` と ``リポジトリ`` ``タグ`` は皆さんのものに置き換えます。コマンドは ``docker run -p 80:80 ユーザ名/リポジトリ:タグ`` です。そして ``http://localhost/`` を表示します。
* :doc:`Part 3 <part3>` で扱った ``docker-compose.yml`` のコピーを持っていること

.. Introduction

はじめに
==========

.. In part 3, you took an app you wrote in part 2, and defined how it should run in production by turning it into a service, scaling it up 5x in the process.

:doc:`Part 3 <part3>` では、 :doc:`Part 2 <part2>` で書いたアプリを元に、プロダクションで実行可能にサービスとして調整したものを定義し、５つのプロセスへとスケールアップしました。

.. Here in part 4, you deploy this application onto a cluster, running it on multiple machines. Multi-container, multi-machine applications are made possible by joining multiple machines into a “Dockerized” cluster called a swarm.

この Part 4 では、アプリケーションをクラスタにデプロイし、複数のマシン上で実行します。複数のコンテナ、複数のマシンにおけるアプリケーションは、 **swarm** （スウォーム）と呼ぶ複数のマシンが参加する「Docker化」（Dockerized）クラスタで利用可能になります。

.. _understanding-swarm-clusters:

.. Understanding Swarm clusters

Swarm クラスタの理解
====================

.. A swarm is a group of machines that are running Docker and joined into a cluster. After that has happened, you continue to run the Docker commands you’re used to, but now they are executed on a cluster by a swarm manager. The machines in a swarm can be physical or virtual. After joining a swarm, they are referred to as nodes.

swarm とは Docker が動作し、クラスタに参加しているマシン・グループです。swarm を使えば、Docker コマンドをこれまで通り使い続けながら、 **swarm マネージャ** を通してクラスタ上で実行可能になります。swarm 上のマシンは物理あるいは仮想どちらも使えます。swarm に加わった後は、これらは **ノード** として参照されます。

.. Swarm managers can use several strategies to run containers, such as “emptiest node” – which fills the least utilized machines with containers. Or “global”, which ensures that each machine gets exactly one instance of the specified container. You instruct the swarm manager to use these strategies in the Compose file, just like the one you have already been using.

swarm マネージャはコンテナの実行時、複数のストラテジ（strategy；計画、方針）を扱います。例えば「emptiest node」（最も空いているノード）であれば、最も使われていないマシンが選ばれます。あるいは「global」（グローバル）であれば、特定の１つのマシンだけでなく、すべてのマシン上で特定のコンテナを実行します。このように様々なストラテジがありますが、 swarm マネージャには Compose ファイルを通して命令できます。

.. Swarm managers are the only machines in a swarm that can execute your commands, or authorize other machines to join the swarm as workers. Workers are just there to provide capacity and do not have the authority to tell any other machine what it can and cannot do.

swarm マネージャは swarm における単なるマシンであり、コマンドの実行や、swarm に参加したマシンを **ワーカ（workers）** として認証できます。ワーカは収容能力（キャパシティ）を提供するのみであり、他のマシンに対して何ができる・できないといった権限を持ちません。

.. Up until now, you have been using Docker in a single-host mode on your local machine. But Docker also can be switched into swarm mode, and that’s what enables the use of swarms. Enabling swarm mode instantly makes the current machine a swarm manager. From then on, Docker will run the commands you execute on the swarm you’re managing, rather than just on the current machine.

これまではローカルマシン上の単一ホスト上で動く Docker を使ってきました。しかし、Docker は **swarm mode**  に切り替え可能であり、swarm（クラスタ）上でも利用できます。現在のマシンを swarm マネージャとしたら、簡単に swarm モードを有効化できます。あとは、現在のマシンで Docker を操作する代わりに、swarm クラスタ上で処理します。

.. Set up your swarm

.. _set-up-your-swarm:

swarm のセットアップ
==============================

.. A swarm is made up of multiple nodes, which can be either physical or virtual machines. The basic concept is simple enough: run docker swarm init to enable swarm mode and make your current machine a swarm manager, then run docker swarm join on other machines to have them join the swarm as workers. Choose a tab below to see how this plays out in various contexts. We’ll use VMs to quickly create a two-machine cluster and turn it into a swarm.

swarm は複数のノードで構成します。物理マシンまたは仮想マシンどちらでもノードになれます。基本概念は極めてシンプルです。 ``docker swarm init`` を実行すると、 swarm mode を有効化し、現在のマシンを swarm マネージャにします。そして ``docker swarm join`` を実行し、他のマシンをワーカとして swarm に追加します。環境に応じて以下の項目を読み進めてください。ここでは２つの仮想マシンを素早く作成し、swarm に追加します。

.. Create a cluster

.. _create-a-cluster:

クラスタの作成
====================

..    Local VMs (Mac, Linux, Windows 7 and 8)
    Local VMs (Windows 10/Hyper-V)

.. VMs on your local machine (Mac, Linux, Windows 7 and 8)

ローカルマシン上の仮想マシン（Mac、Linux、Windows 7 および 8）
----------------------------------------------------------------------

.. First, you’ll need a hypervisor that can create VMs, so install VirtualBox for your machine’s OS.

まず、仮想マシンを作成できるハイパーバイザが必要です。そのため、各マシンの OS に対応した `VirtualBox をインストール <https://www.virtualbox.org/wiki/Downloads>`_ します。

    Note: If you’re on a Windows system that has Hyper-V installed, such as Windows 10, there is no need to install VirtualBox and you should use Hyper-V instead. View the instructions for Hyper-V systems by clicking the Hyper-V tab above.

.. note::

   WIndows 10 のような Hyper-V をインストールした WIndows システムをお使いの場合、Hyper-V を利用する代わりに VirtualBox のインストールが必要です。ページ下方の Hyper-V に関する項目をご覧ください。

.. Now, create a couple of VMs using docker-machine, using the VirtualBox driver:

次に ``docker-machine`` を使い、２つの仮想マシンを作成します。ここでは VirtualBox ドライバを使います。

.. code-block:: bash

   $ docker-machine create --driver virtualbox myvm1
   $ docker-machine create --driver virtualbox myvm2

ローカルマシン上の仮想マシン（Windows 10/Hyper-V）
----------------------------------------------------------------------

.. First, quickly create a virtual switch for your VMs to share, so they will be able to connect to each other.

まず、仮想マシンが共有する仮想スイッチを作成したら、仮想マシンがお互い接続可能になります。

..    Launch Hyper-V Manager
    Click Virtual Switch Manager in the right-hand menu
    Click Create Virtual Switch of type External
    Give it the name myswitch, and check the box to share your host machine’s active network adapter

1. Hyper-V マネージャを起動
2. 右側メニューにある **Virtual Switch Manager** をクリック
3. **Create Virtual Switch** の **External** タイプをクリック
4. 名前を **myswitch** に指定子、ホストマシンのアクティブ・ネットワーク・アダプタとの共有ボックスにチェックを入れる

.. Now, create a couple of virtual machines using our node management tool, docker-machine:

次にノード管理ツール ``docker-machine`` を使い、２つの仮想マシンを作成します。

.. code-block:: bash

   $ docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1
   $ docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm2





作成
----------

.. You now have two VMs created, named myvm1 and myvm2 (as docker-machine ls shows). The first one will act as the manager, which executes docker commands and authenticates workers to join the swarm, and the second will be a worker.

このように ``myvm1`` と ``myvm2`` という名前の２つの仮想マシン（ ``docker-machine ls`` で表示 ）を作成しました。１つめはマネージャとして ``docker`` コマンドを実行し、ワーカを swarm に追加する認証をします。２つめはワーカにします。

.. You can send commands to your VMs using docker-machine ssh. Instruct myvm1 to become a swarm manager with docker swarm init and you’ll see output like this:

仮想マシンには ``docker-machine ssh`` を使ってコマンドを送ります。 ``myvm1`` に対して ``docker swarm init`` で swarm マネージャになるよう命令します。次のような実行結果になるでしょう。

.. code-block:: bash

   $ docker-machine ssh myvm1 "docker swarm init"
   Swarm initialized: current node <node ID> is now a manager.
   
   To add a worker to this swarm, run the following command:
   
     docker swarm join \
     --token <token> \
     <ip>:<port>

..    Got an error about needing to use --advertise-addr?
    Copy the IP address for myvm1 by running docker-machine ls, then run the docker swarm init command again, using that IP and specifying port 2377 (the port for swarm joins) with --advertise-addr. For example:

.. hint::

   エラーが出る場合は、 ``--advertise-addr`` を使う必要があるかもしれません
   
   ``docker-machine ls`` を実行し、 ``myvm1`` の IP アドレスをコピーします。それから ``docker swarm init`` コマンドを再び実行しますが、 ``--advertise-addr`` で IP アドレスとポート ``2377`` を指定（swarm が join に使うポート）します。実行例：
   
   .. code-block:: bash
   
      docker-machine ssh myvm1 "docker swarm init --advertise-addr 192.168.99.100:2377"

.. As you can see, the response to docker swarm init contains a pre-configured docker swarm join command for you to run on any nodes you want to add. Copy this command, and send it to myvm2 via docker-machine ssh to have myvm2 join your new swarm as a worker:

ご覧の通り、 ``docker swarm init`` の応答があれば、必要なあらゆるノードをあらかじめ調整済みの ``docker swarm join`` で追加できます。 ``myvm2`` を新しい swarm でワーカとして追加するには、次のコマンドをコピーし、 ``docker-machine ssh`` 経由で ``myvm2`` に送信します。

.. code-block:: bash

   $ docker-machine ssh myvm2 "docker swarm join \
   --token <token> \
   <ip>:<port>"
   
   This node joined a swarm as a worker.

.. Congratulations, you have created your first swarm.

これで初めての swarm （クラスタ）が完成しました。お疲れさまでした。

..    Note: You can also run docker-machine ssh myvm2 with no command attached to open a terminal session on that VM. Type exit when you’re ready to return to the host shell prompt. It may be easier to paste the join command in that way.

.. note::

   別の方法として、 ``docker-machine ssh myvm2`` でコマンドを付与しなければ、仮想マシンに対するターミナル・セッションを開きます。ホスト側のシェル・プロンプトに戻る準備が整えば、 ``exit`` を実行します。場合によっては join コマンドを実行するよりも簡単でしょう。

.. Use ssh to connect to the (docker-machine ssh myvm1), and run docker node ls to view the nodes in this swarm:

``ssh`` を使って接続し（ ``docker-machine ssh myvm1`` ）、 この swarm のノード一覧を表示するため ``docker node ls`` を実行します。

.. code-block:: bash

   docker@myvm1:~$ docker node ls
   ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS
   brtu9urxwfd5j0zrmkubhpkbd     myvm2               Ready               Active              
   rihwohkh3ph38fhillhhb84sk *   myvm1               Ready               Active              Leader

.. Type exit to get back out of that machine.

``exit`` を実行し、マシン側に戻ります。

.. Alternatively, wrap commands in docker-machine ssh to keep from having to directly log in and out. For example:

別の方法として、 ``docker-machine ssh`` でコマンドをまとめ、直接ログインしてログアウトもできます。実行例：

.. code-block:: bash

   docker-machine ssh myvm1 "docker node ls"

.. Deploy your app on a cluster

.. _deploy-your-app-on-a-cluster:

アプリをクラスタ上にデプロイ
==============================

.. The hard part is over. Now you just repeat the process you used in part 3 to deploy on your new swarm. Just remember that only swarm managers like myvm1 execute Docker commands; workers are just for capacity.

大変な部分は終わりました。次は :doc:`Part 3 <part3>` で用いた手順を、新しい swarm 上で繰り返します。 ``myvm1`` のような swarm マネージャは Docker コマンドを実行できるのを思い出してください。ワーカはキャパシティ（収容能力）のためのみです。

.. Copy the file docker-compose.yml you created in part 3 to the swarm manager myvm1’s home directory (alias: ~) by using the docker-machine scp command:

part 3 で作成した ``docker-compose.yml`` ファイルを、 swarm マネージャ ``myvm1`` のホームディレクトリ（別名： ``~`` ）に ``docker-machine scp`` コマンドを使ってコピーします。

.. code-block:: bash

   docker-machine scp docker-compose.yml myvm1:~

.. Now have myvm1 use its powers as a swarm manager to deploy your app, by sending the same docker stack deploy command you used in part 3 to myvm1 using docker-machine ssh:

これで ``myvm1`` は swarm マネージャの力によりアプリをデプロイできるようになりました。part 3 で使ったのと同じ ``docker stack deploy`` コマンドを ``docker-machine ssh`` コマンドで ``myvm1`` に送信します。

.. code-block:: bash

   docker-machine ssh myvm1 "docker stack deploy -c docker-compose.yml getstartedlab"

.. And that’s it, the app is deployed on a cluster.

これだけの作業で、アプリはクラスタ上にデプロイされました。

.. Wrap all the commands you used in part 3 in a call to docker-machine ssh, and they’ll all work as you’d expect. Only this time, you’ll see that the containers have been distributed between both myvm1 and myvm2.

part 3 で使った全てのコマンドを ``docker-machine ssh`` で送るだけで、全て期待通りに動作します。今回のケースでは、コンテナは ``myvm1`` と ``myvm2`` の両方に分散したことが分かります。

.. code-block:: bash

   $ docker-machine ssh myvm1 "docker stack ps getstartedlab"
   
   ID            NAME        IMAGE              NODE   DESIRED STATE
   jq2g3qp8nzwx  test_web.1  username/repo:tag  myvm1  Running
   88wgshobzoxl  test_web.2  username/repo:tag  myvm2  Running
   vbb1qbkb0o2z  test_web.3  username/repo:tag  myvm2  Running
   ghii74p9budx  test_web.4  username/repo:tag  myvm1  Running
   0prmarhavs87  test_web.5  username/repo:tag  myvm2  Running

.. Accessing your cluster

.. _accessing-your-cluster:

クラスタにアクセス
====================

.. You can access your app from the IP address of either myvm1 or myvm2. The network you created is shared between them and load-balancing. Run docker-machine ls to get your VMs’ IP addresses and visit either of them on a browser, hitting refresh (or just curl them). You’ll see five possible container IDs all cycling by randomly, demonstrating the load-balancing.

アプリに対しては ``myvm1`` か ``myvm2`` の **どちらか** の IP アドレスでアクセスできます。作成したネットワークは双方のホストで共有され、負荷分散できます。 ``docker-machine ls`` を実行して仮想マシンの IP アドレスを確認し、ブラウザでどちらかを表示し、それから再読み込みします（あるいは ``curl`` でも同様です）。読み込み直すたびに、ランダムに５つのコンテナ ID のどれかを表示するでしょう。負荷分散のデモンストレーションです。

.. The reason both IP addresses work is that nodes in a swarm participate in an ingress routing mesh. This ensures that a service deployed at a certain port within your swarm always has that port reserved to itself, no matter what node is actually running the container. Here’s a diagram of how a routing mesh for a service called my-web published at port 8080 on a three-node swarm would look:

どちらの IP アドレスでも動作する理由は、swarm の各ノードが ingress **ルーティング・メッシュ（rougint mesh）** に所属しているからです。これにより、サービスのデプロイにあたり swarm 上で指定したポートを確保できるよう、コンテナが実際にどのノードで実行中か気にすることなく、ノード自身がポートを予約します。下図は ``my-web`` という名前のサービスが公開するポート ``8080`` を、３つの swarm ノード上で、どのようにルーティング・メッシュするかの説明です。

.. routing mesh diagram

.. figure:: /engine/swarm/images/ingress-routing-mesh.png
   :alt: ingress ルーティング・メッシュ

..    Having connectivity trouble?
..    Keep in mind that in order to use the ingress network in the swarm, you need to have the following ports open between the swarm nodes before you enable swarm mode:
        Port 7946 TCP/UDP for container network discovery.
        Port 4789 UDP for the container ingress network.

.. hint::

   接続に問題がありますか？
   
   swarm で ingress ネットワークを使うためには、swarm モード有効にする前に、swarm ノード間で以下のポートを開く必要がありますので、ご注意ください。
   
   * Port 7946 TCP/UDP を、コンテナのネットワーク・ディスカバリ用に
   * Port 4789UDP をコンテナ ingress ネットワーク用に

.. Iterating and scaling your app

.. _iterating-and-scaling-your-app:

アプリの繰り返しとスケーリング
==============================

.. From here you can do everything you learned about in part 3.

ここからは part 3 で学んだ全ての動作を行えます。

.. Scale the app by changing the docker-compose.yml file.

アプリのスケールは、``docker-compose.yml`` ファイルを変更します。

.. Change the app behavior by editing code.

アプリの挙動を変更するには、コードを編集します。

.. In either case, simply run docker stack deploy again to deploy these changes.

いずれにしろ、変更を反映（デプロイ）するには ``docker stack deploy`` を再び実行するだけです。

.. You can join any machine, physical or virtual, to this swarm, using the same docker swarm join command you used on myvm2, and capacity will be added to your cluster. Just run docker stack deploy afterwards, and your app will take advantage of the new resources.

物理マシンと仮想マシンのどちらにしても、 ``myvm2`` に対して実行したのと 同じ ``docker swarm join`` コマンドを使って swarm に追加でき、クラスタの収容能力に追加できます。そして ``docker stack deploy`` を実行するだけで、アプリは新しいリソースを利用可能になります。

.. Cleanup

クリーンアップ
====================

.. You can tear down the stack with docker stack rm. For example:

スタックは ``docker stack rm`` で解体できます。実行例：

.. code-block:: bash

   docker-machine ssh myvm1 "docker stack rm getstartedlab"

..    Keep the swarm or remove it?
..    At some point later, you can remove this swarm if you want to with docker-machine ssh myvm2 "docker swarm leave" on the worker and docker-machine ssh myvm1 "docker swarm leave --force" on the manager, but you’ll need this swarm for part 5, so please keep it around for now.

.. hint::

   swarm は維持？それとも削除？
   
   後々、必要に応じてワーカを削除したい場合は ``docker-machine ssh myvm2 "docker swarm leave"`` を、マネージャの削除は ``docker-machine ssh myvm1 "docker swarm leave --force"`` で行えます。 *ですが、swarm は part 5 でも使いますので、今はこのままにしておいてください。*

.. On to Part 5 »

* :doc:`パート５へ進む <part5>`

.. Recap and cheat sheet (optional)

まとめとチート・シート（オプション）
========================================

.. Here’s a terminal recording of what was covered on this page:

`このページで扱ったターミナルの録画 <https://asciinema.org/a/113837>`_ がこちらです。

.. In part 4 you learned what a swarm is, how nodes in swarms can be managers or workers, created a swarm, and deployed an application on it. You saw that the core Docker commands didn’t change from part 3, they just had to be targeted to run on a swarm master. You also saw the power of Docker’s networking in action, which kept load-balancing requests across containers, even though they were running on different machines. Finally, you learned how to iterate and scale your app on a cluster.

Part 4 では、swarm とは何か、swarm においてノードをマネージャまたはワーカにする方法、swarm の作成と、そこにアプリケーションをデプロイする方法を学びました。ご覧の通り、主なコマンドは part 3 と変わることはなく、単に実行対象が swarm マネージャになっただけでした。また、Docker ネットワークの力もご覧になったでしょう。コンテナ間で負荷分散（ロードバランサ）を組めるだけでなく、コンテナが異なったマシン上で実行していても可能なのです。最後に、クラスタ上でアプリの繰り返しとスケールを学びました。

.. Here are some commands you might like to run to interact with your swarm a bit:

ここでは swarm 上で実行すると便利なコマンドをいくつか紹介します。

.. code-block:: bash

   docker-machine create --driver virtualbox myvm1          # 仮想マシン作成 (Mac, Win7, Linux)
   docker-machine create -d hyperv --hyperv-virtual-switch "myswitch" myvm1             # Win10
   docker-machine env myvm1                                      # ノードに関する基本情報の表示
   docker-machine ssh myvm1 "docker node ls"                               # swarm のノード一覧
   docker-machine ssh myvm1 "docker node inspect <node ID>"                      # ノードの調査
   docker-machine ssh myvm1 "docker swarm join-token -q worker"           # join トークンの表示
   docker-machine ssh myvm1          # 仮想マシンの SSH セッションを開く；"exit" を入力して終了
   docker-machine ssh myvm2 "docker swarm leave"                      # ワーカを swarm から離脱
   docker-machine ssh myvm1 "docker swarm leave -f"            # マスターを離脱し、swarm を停止
   docker-machine start myvm1                            # 仮想マシンが起動していなければ、起動
   docker-machine stop $(docker-machine ls -q)                 # 実行中の全ての仮想マシンを停止
   docker-machine rm $(docker-machine ls -q)       # 全ての仮想マシンとディスク・イメージを削除
   docker-machine scp docker-compose.yml myvm1:~ # ファイルをノードのホームディレクトリにコピー
   docker-machine ssh myvm1 "docker stack deploy -c <file> <app>"            # アプリをデプロイ
   



