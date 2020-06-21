.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/networking/default_network/binding/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/default_network/binding.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/networking/default_network/binding.md
.. check date: 2016/06/15
.. Commits on Nov 3, 2016 9ef855f9e5fa8077468bda5ce43155318c58e60e
.. ---------------------------------------------------------------------------

.. Bind container ports to the host

.. _bind-container-ports-to-the-host:

========================================
ホスト上にコンテナのポートを割り当て
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The information in this section explains binding container ports within the Docker default bridge. This is a bridge network named bridge created automatically when you install Docker.

このセクションでは、 Docker のデフォルト・ブリッジ内にあるコンテナに対して、ポートを割り当てる方法を説明します。このネットワークは ``bridge`` という名称の ``bridge`` ネットワークであり、Docker インストール時に自動的に作成されるものです。

..    Note: The Docker networks feature allows you to create user-defined networks in addition to the default bridge network.

.. note::

   :doc:`Docker ネットワーク機能 </engine/userguide/networking/dockernetworks>` を使えば、デフォルト・ブリッジ・ネットワークに加え、自分で定義したネットワークも作成できます。

.. By default Docker containers can make connections to the outside world, but the outside world cannot connect to containers. Each outgoing connection will appear to originate from one of the host machine’s own IP addresses thanks to an iptables masquerading rule on the host machine that the Docker server creates when it starts:

デフォルトの Docker コンテナは外の世界と通信できます。しかし、外の世界からはコンテナに接続できません。外に対するそれぞれの接続は、ホストマシン自身が持つ IP アドレスから行われているように見えます。これはホストマシン上の ``iptables`` マスカレーディング機能によるルールであり、Docker サーバ起動時に自動的に作成されます。

.. code-block:: bash

   $ sudo iptables -t nat -L -n
   ...
   Chain POSTROUTING (policy ACCEPT)
   target     prot opt source               destination
   MASQUERADE  all  --  172.17.0.0/16       0.0.0.0/0
   ...

.. The Docker server creates a masquerade rule that let containers connect to IP addresses in the outside world.

Docker サーバが作成するマスカレード・ルールは、外の世界からコンテナに IP アドレスで接続できるようにします。

.. If you want containers to accept incoming connections, you will need to provide special options when invoking docker run. There are two approaches.

もしもコンテナが内側への（incoming）接続を受け付けたいのなら、 ``docker run`` の実行時に特別なオプション指定が必要です。

.. First, you can supply -P or --publish-all=true|false to docker run which is a blanket operation that identifies every port with an EXPOSE line in the image’s Dockerfile or --expose <port> commandline flag and maps it to a host port somewhere within an ephemeral port range. The docker port command then needs to be used to inspect created mapping. The ephemeral port range is configured by /proc/sys/net/ipv4/ip_local_port_range kernel parameter, typically ranging from 32768 to 61000.

まずは、 ``docker run`` で  ``-P`` か ``--publish-all=true|false`` を指定します。これは全体的なオプションであり、イメージの ``Dockerfile`` 内にある ``EXPOSE`` 命令で各ポートを指定するか、あるいは、コマンドラインで ``--expose <ポート>`` フラグを使って指定します。いずれかを使い、ホスト上の *エフェメラル・ポート範囲内（ephemeral port range）* にあるポートに割り当てられます。以後、どのポートに割り当てられているか調べるには ``docker port`` コマンドを使います。エフェメラル・ポート範囲とは、カーネル・パラメータの ``/proc/sys/net/ipv4/ip_local_port_range`` で指定されており、典型的な範囲は 32768 ～ 61000 です。

.. Mapping can be specified explicitly using -p SPEC or --publish=SPEC option. It allows you to particularize which port on docker server - which can be any port at all, not just one within the ephemeral port range -- you want mapped to which port in the container.

割り当て（マッピング）を明示するには、 ``-p 指定`` か ``--publish=指定`` オプションを使います。これは、Docker サーバのどのポートを使うか明示するものであり、ポートの指定が無ければ、エフェメラル・ポート範囲から割り当てられます。この指定を使い、コンテナの任意のポートに割り当て可能です。

.. Either way, you should be able to peek at what Docker has accomplished in your network stack by examining your NAT tables.

どちらにしろ、Docker がネットワーク・スタックでどのような処理を行っているのかは、NAT テーブルを例に垣間見えます。

.. code-block:: bash

   # Docker で -P 転送を指定した時、NAT ルールがどうなるか
   
   $ iptables -t nat -L -n
   ...
   Chain DOCKER (2 references)
   target     prot opt source               destination
   DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:49153 to:172.17.0.2:80
   
   # Docker で -p 80:80 を指定した時、NAT ルールがどうなるか
   
   Chain DOCKER (2 references)
   target     prot opt source               destination
   DNAT       tcp  --  0.0.0.0/0            0.0.0.0/0            tcp dpt:80 to:172.17.0.2:80

.. You can see that Docker has exposed these container ports on 0.0.0.0, the wildcard IP address that will match any possible incoming port on the host machine. If you want to be more restrictive and only allow container services to be contacted through a specific external interface on the host machine, you have two choices. When you invoke docker run you can use either -p IP:host_port:container_port or -p IP::port to specify the external interface for one particular binding.

Docker はこれらコンテナ側のポートを ``0.0.0.0`` 、つまりワイルドカード IP アドレスで公開しているのが分かります。これはホストマシン上に到達可能な全ての IP アドレスが対象です。制限を加えたい場合や、ホストマシン上の特定の外部インターフェースを通してのみコンテナのサービスへ接続したい場合は、２つの選択肢があります。

１つは  ``docker run`` の実行時、 ``-p IP:ホスト側ポート:コンテナ側ポート`` か ``-p IP::ポート`` を指定し、特定の外部インターフェースをバインドする指定ができます。

.. Or if you always want Docker port forwards to bind to one specific IP address, you can edit your system-wide Docker server settings and add the option --ip=IP_ADDRESS. Remember to restart your Docker server after editing this setting.

あるいは、Docker のポート転送で常に特定の IP アドレスに割り当てたい場合には、システム全体の Docker サーバ設定ファイルを編集し、 ``--ip=IP_ADDRESS`` オプションを使います。編集内容が有効になるのは、Docker サーバの再起動後なのでご注意ください。

..    Note: With hairpin NAT enabled (--userland-proxy=false), containers port exposure is achieved purely through iptables rules, and no attempt to bind the exposed port is ever made. This means that nothing prevents shadowing a previously listening service outside of Docker through exposing the same port for a container. In such conflicting situation, Docker created iptables rules will take precedence and route to the container.

.. note::

   ヘアピン NAT を有効にすると（ ``--userland-proxy=false`` ）、コンテナのポート公開は、純粋な iptables のルールを通して処理され、特定のポートを結び付けようとする処理は、一切ありません。つまり、コンテナが使おうとしているポートを、Docker の他の何かのサービスが使おうとしても阻止できません。このような衝突があれば、Docker はコンテナに対する経路を優先するよう、iptabels のルールを書き換えます。

.. The --userland-proxy parameter, true by default, provides a userland implementation for inter-container and outside-to-container communication. When disabled, Docker uses both an additional MASQUERADE iptable rule and the net.ipv4.route_localnet kernel parameter which allow the host machine to connect to a local container exposed port through the commonly used loopback address: this alternative is preferred for performance reasons.

``--userland-proxy`` パラメータは、デフォルトでは true （有効）であり、コンテナ内部とコンテナ外からの通信を可能にするユーザ領域を提供します。無効化しますと、Docker はどちらの通信に対しても ``MASQUERADE`` iptables ルールを追加し、 ``net.ipv4.route_localnet`` カーネル・パラメータを使い、ホストマシンがローカルのコンテナが公開しているポートに対し、通常はループバック・アドレスを用いて通信します。どちらを選ぶかは、性能を根拠として選びます。

.. Related information

関連情報
==========

..    Understand Docker container networks
    Work with network commands
    Legacy container links

* :doc:`/engine/userguide/networking/dockernetworks`
* :doc:`/engine/userguide/networking/work-with-networks`
* :doc:`dockerlinks`

.. seealso:: 

   Bind container ports to the host
      https://docs.docker.com/engine/userguide/networking/default_network/binding/
