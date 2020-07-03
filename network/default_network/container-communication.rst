.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/networking/default_network/container-communication/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/default_network/container-communication.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/networking/default_network/container-communication.md
.. check date: 2016/06/14
.. Commits on May 19, 2016 5fb7f9b29e9a85f36d02c4ecec6c04498fdb4315
.. ---------------------------------------------------------------------------

.. Understand container communication

.. _understand-container-communication:

========================================
コンテナ通信の理解
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The information in this section explains container communication within the Docker default bridge. This is a bridge network named bridge created automatically when you install Docker.

このセクションでは、Docker デフォルトのブリッジ・ネットワーク内部におけるコンテナ通信について説明します。このネットワークは ``bridge`` という名称の ``bridge`` ネットワークであり、Docker インストール時に自動的に作成されます。

.. Note: The Docker networks feature allows you to create user-defined networks in addition to the default bridge network.

.. note::

   :doc:`Docker ネットワーク機能 </engine/userguide/networking/dockernetworks>` を使えば、デフォルトのブリッジ・ネットワークに加え、自分で定義したネットワークも作成できます。

.. Communicating to the outside world

.. _communicating-to-the-outside-world:

外の世界との通信
====================

.. Whether a container can talk to the world is governed by two factors. The first factor is whether the host machine is forwarding its IP packets. The second is whether the host's iptables allow this particular connection.

コンテナが世界と通信できるかどうかは、２つの要素が左右します。１つめの要素は、ホストマシンが IP パケットを転送できるかどうかです。２つめはホスト側の ``iptables`` が特定の接続を許可するかどうかです。

.. IP packet forwarding is governed by the ip_forward system parameter. Packets can only pass between containers if this parameter is 1. Usually you will simply leave the Docker server at its default setting --ip-forward=true and Docker will go set ip_forward to 1 for you when the server starts up. If you set --ip-forward=false and your system’s kernel has it enabled, the --ip-forward=false option has no effect. To check the setting on your kernel or to turn it on manually:

IP パケット転送（ip packet forwarding）は、 ``ip_forward`` システム・パラメータで管理します。このパラメータが ``1`` の時のみ、パケットは通信できます。通常、Docker サーバはデフォルトの設定のままでも ``--ip-forward=true`` であり、Docker はサーバの起動時に ``ip_forward`` を ``1`` にします。もし ``--ip-forward=false`` をセットし、システム・カーネルが有効な場合は、この ``--ip-forward=false`` オプションは無効です。カーネル設定の確認は、手動で行います。

.. code-block:: bash

   $ sysctl net.ipv4.conf.all.forwarding
   net.ipv4.conf.all.forwarding = 0
   $ sysctl net.ipv4.conf.all.forwarding=1
   $ sysctl net.ipv4.conf.all.forwarding
   net.ipv4.conf.all.forwarding = 1

.. Note: this setting does not affect containers that use the host network stack (--net=host).

.. note::

  この設定は、コンテナがホスト側のネットワーク・スタックの使用時（ ``--net=host`` ）に影響を与えません。

.. Many using Docker will want ip_forward to be on, to at least make communication possible between containers and the wider world. May also be needed for inter-container communication if you are in a multiple bridge setup.

Docker を使う多くの環境で ``ip_forward`` の有効化が必要となるでしょう。コンテナと世界が通信できるようにするには、この設定が最低限必要だからです。また、複数のブリッジをセットアップする場合は、コンテナ間での通信にも必要となります。

.. Docker will never make changes to your system iptables rules if you set --iptables=false when the daemon starts. Otherwise the Docker server will append forwarding rules to the DOCKER filter chain.

デーモン起動時に ``--iptables=false`` を設定したら、Docker はシステム上の ``iptables`` ルールセットを一切変更しません。そうでなければ、Docker サーバは ``DOCKER`` フィルタ・チェーンの転送ルールを追加します。

.. Docker will not delete or modify any pre-existing rules from the DOCKER filter chain. This allows the user to create in advance any rules required to further restrict access to the containers.

Docker は ``DOCKER`` フィルタ・チェーンのために、既存のルールを削除・変更しません。そのため、ユーザが必要であれば、コンテナに対して更なるアクセス制限するといった、高度なルールも作成できます。

.. Docker’s forward rules permit all external source IPs by default. To allow only a specific IP or network to access the containers, insert a negated rule at the top of the DOCKER filter chain. For example, to restrict external access such that only source IP 8.8.8.8 can access the containers, the following rule could be added:

Docker のデフォルト転送ルールは、全ての外部ソースの IP アドレス対して許可しています。コンテナを特定の IP アドレスやネットワークに対してのみ接続したい場合には、 ``DOCKER`` フィルタ・チェーンの一番上にネガティブ・ルールを追加します。例えば、コンテナが外部の IP アドレス 8.8.8.8 をソースとするもの *しか* 許可しない場合には、次のようなルールを追加します。

.. code-block:: bash

   $ iptables -I DOCKER -i ext_if ! -s 8.8.8.8 -j DROP

.. where ext_if is the name of the interface providing external connectivity to the host.

*ext_if* の場所は、インターフェースが提供するホスト側に接続できる名前です。

.. Communication between containers

.. _communication-between-containers:

コンテナ間の通信
====================

.. Whether two containers can communicate is governed, at the operating system level, by two factors.

２つのコンテナが通信できるかどうかは、オペレーティング・システム・レベルでの２つの要素に左右されます。

..    Does the network topology even connect the containers’ network interfaces? By default Docker will attach all containers to a single docker0 bridge, providing a path for packets to travel between them. See the later sections of this document for other possible topologies.

* コンテナのネットワーク・インターフェースがネットワーク・トポロジに接続されていますか？ デフォルトの Docker は、全てのコンテナを ``docker0`` ブリッジに接続するため、コンテナ間でのパケット通信が可能な経路を提供します。他の利用可能なトポロジに関するドキュメントについては、後述します。

..    Do your iptables allow this particular connection? Docker will never make changes to your system iptables rules if you set --iptables=false when the daemon starts. Otherwise the Docker server will add a default rule to the FORWARD chain with a blanket ACCEPT policy if you retain the default --icc=true, or else will set the policy to DROP if --icc=false.

* ``iptables`` は特定の接続を許可していますか？ Docker はデーモンの起動時に ``--iptables=false`` を設定したら、システム上の ``iptables`` に対する変更を一切行いません。そのかわり、Docker サーバは ``FORWARD`` チェーンにデフォルトのルールを追加する時、デフォルトの ``--icc=true`` であれば空の ``ACCEPT`` ポリシーを追加します。もし ``--icc=false`` であれば ``DROP`` ポリシーを設定します。

.. It is a strategic question whether to leave --icc=true or change it to --icc=false so that iptables will protect other containers -- and the main host -- from having arbitrary ports probed or accessed by a container that gets compromised.

``--icc=true`` のままにしておくか、あるいは ``--icc=false`` にすべきかという方針の検討には、 ``iptables`` を他のコンテナやメインのホストから守るかどうかです。例えば、恣意的なポート探査やコンテナに対するアクセスは、問題を引き起こすかもしれません。

.. If you choose the most secure setting of --icc=false, then how can containers communicate in those cases where you want them to provide each other services? The answer is the --link=CONTAINER_NAME_or_ID:ALIAS option, which was mentioned in the previous section because of its effect upon name services. If the Docker daemon is running with both --icc=false and --iptables=true then, when it sees docker run invoked with the --link= option, the Docker server will insert a pair of iptables ACCEPT rules so that the new container can connect to the ports exposed by the other container -- the ports that it mentioned in the EXPOSE lines of its Dockerfile.

もし、より高い安全のために ``--icc=false`` を選択した場合は、コンテナが他のサービスと相互に通信するには、どのような設定が必要でしょうか。この答えが、 ``--link=コンテナ名_または_ID:エイリアス`` オプションです。これについては以前のセクションで、サービス名について言及しました。もし Docker デーモンが ``--icc=false`` と ``iptables=true`` のオプションを指定したら、 ``docker run`` は ``--link=`` オプションの情報を参照し、他のコンテナが新しいコンテナの公開用ポートに接続できるよう ``iptables`` の ``ACCEPT`` ルールのペアを追加します。この公開用ポートとは、 ``Dockerfile`` の ``EXPOSE`` 行で指定していたものです。

..     Note: The value CONTAINER_NAME in --link= must either be an auto-assigned Docker name like stupefied_pare or else the name you assigned with --name= when you ran docker run. It cannot be a hostname, which Docker will not recognize in the context of the --link= option.

.. note::

   ``--link=`` で指定する ``コンテナ名`` の値は、Docker が自動的に割り当てる ``stupefied_pare`` のような名前ではなく、 ``docker run`` の実行時に ``--name=`` で名前を割り当てておく必要があります。ホスト名でなければ、Docker は ``--link=`` オプションの内容を理解できません。

.. You can run the iptables command on your Docker host to see whether the FORWARD chain has a default policy of ACCEPT or DROP:

Docker ホスト上で ``iptables`` コマンドを実行したら、 ``FORWARD`` チェーンの場所で、デフォルトのポリシーが ``ACCEPT`` か ``DROP`` かを確認できます。

.. code-block:: bash

   # もし--icc=false なら DROP ルールはどのようになるでしょうか：
   
   $ sudo iptables -L -n
   ...
   Chain FORWARD (policy ACCEPT)
   target     prot opt source               destination
   DOCKER     all  --  0.0.0.0/0            0.0.0.0/0
   DROP       all  --  0.0.0.0/0            0.0.0.0/0
   ...
   
   # --icc=false の下で --link= を指定したら、
   # 特定のポートに対する ACCEPT ルールを優先し
   # その他のパケットを DROP するポリシーを適用します。
   
   $ sudo iptables -L -n
   ...
   Chain FORWARD (policy ACCEPT)
   target     prot opt source               destination
   DOCKER     all  --  0.0.0.0/0            0.0.0.0/0
   DROP       all  --  0.0.0.0/0            0.0.0.0/0
   
   Chain DOCKER (1 references)
   target     prot opt source               destination
   ACCEPT     tcp  --  172.17.0.2           172.17.0.3           tcp spt:80
   ACCEPT     tcp  --  172.17.0.3           172.17.0.2           tcp dpt:80

..    Note: Docker is careful that its host-wide iptables rules fully expose containers to each other’s raw IP addresses, so connections from one container to another should always appear to be originating from the first container’s own IP address.

.. note::

  ホストを広範囲にわたって公開する ``iptables`` のルールは、各コンテナが持つ実際の IP アドレスを通して公開されますのでご注意ください。そのため、あるコンテナから別のコンテナに対する接続は、前者のコンテナ自身が持っている IP アドレスからの接続に見えるでしょう。

.. seealso:: 

   Understand container communication
      https://docs.docker.com/engine/userguide/networking/default_network/container-communication/

  