.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/network/iptables/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/network/iptables.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Aug 7, 2021 4068208b74003075b5db4e9675262652e72b0e32
.. ---------------------------------------------------------------------------

.. Docker and iptables
.. _docker-and-iptables:o

========================================
Docker と iptables
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. On Linux, Docker manipulates iptables rules to provide network isolation. While this is an implementation detail and you should not modify the rules Docker inserts into your iptables policies, it does have some implications on what you need to do if you want to have your own policies in addition to those managed by Docker.

Linux 上では、 Docker は :ruby:`ネットワークの分離 <network isolation>` のために ``iptables`` ルールを操作します。これは実装の詳細であり、 Docker が追加する ``iptables`` ポリシーを変更すべきではありません。しかしながら、 Docker によって管理されている追加されたポリシーを、自分自身で変更したい場合には、いくつかの影響が発生する可能性があります。

.. If you’re running Docker on a host that is exposed to the Internet, you will probably want to have iptables policies in place that prevent unauthorized access to containers or other services running on your host. This page describes how to achieve that, and what caveats you need to be aware of.

Docker を実行しているホストをインターネット上に公開している場合、コンテナやホスト上で実行しているサービスに対する許可のない接続を防ぐように、おそらく何らかの iptables ポリシーを追加しようとするでしょう。これをどのようにして行うか、そして、気を付けるべき警告について、このページで扱います。

.. Add iptables policies before Docker’s rules
.. _add-iptables-policies-before-dockers-rules:
iptables ポリシーは Docker 用ルールの前に追加
==================================================

.. Docker installs two custom iptables chains named DOCKER-USER and DOCKER, and it ensures that incoming packets are always checked by these two chains first.

Docker は2つのカスタム iptables :ruby:`チェイン <chain>` を追加します。チェインの名前は ``DOCKER-USER`` と ``DOCKER`` です。そして、常に入力側のパケットは、これら2つのチェインによるチェックが第一に行われます。

.. All of Docker’s iptables rules are added to the DOCKER chain. Do not manipulate this chain manually. If you need to add rules which load before Docker’s rules, add them to the DOCKER-USER chain. These rules are applied before any rules Docker creates automatically.

Docker の ``iptables`` 全ルールは ``DOCKER`` チェインに追加されます。このチェインは手動で操作しないでください。Docker のルールを読み込む前にルールの追加が必要な場合は、 ``DOCKER-USER`` チェインにルールを追加します。これらのルールは Docker が自動的に作成するルールより前に適用されます。

.. Rules added to the FORWARD chain -- either manually, or by another iptables-based firewall -- are evaluated after these chains. This means that if you expose a port through Docker, this port gets exposed no matter what rules your firewall has configured. If you want those rules to apply even when a port gets exposed through Docker, you must add these rules to the DOCKER-USER chain.

ルールは ``FORWARD`` チェインにも追加されます。手動で、あるいは他の ipables をベースとするファイアウォールによって追加されたものは、これらの（ Docker が追加した）チェインの後で処理されます。つまり、Docker を通してポートを公開している場合、ファイアウォールによってどのようなルールが追加されていても、ポート公開に何ら問題ありません。Docker を通して公開しているポートに対し、何らかのルールを適用したい場合は、 ``DOCKER-USER`` チェインに「必ず」追加する必要があります。

.. Restrict connections to the Docker host
.. _restrict-connections-to-the-docker-host:
Docker ホストに対する接続を制限
========================================

.. By default, all external source IPs are allowed to connect to the Docker host. To allow only a specific IP or network to access the containers, insert a negated rule at the top of the DOCKER-USER filter chain. For example, the following rule restricts external access from all IP addresses except 192.168.1.1:

デフォルトでは、全ての外部ソース IP アドレスから Docker ホストに接続できます。コンテナに対して特定の IP アドレスもしくはネットワークからのみ許可するには、 ``DOCKER-USER`` フィルタ チェインの一番上に :ruby:`無効化 <negated>` ルールを追加します。たとえば、以下のルールは ``192.168.1.1`` を除く全ての外部アクセスを制限します。

.. code-block:: bash

   $ iptables -I DOCKER-USER -i ext_if ! -s 192.168.1.1 -j DROP

.. Please note that you will need to change ext_if to correspond with your host’s actual external interface. You could instead allow connections from a source subnet. The following rule only allows access from the subnet 192.168.1.0/24:

注意点として、 ``ext_if`` をホスト上での実際の外部インターフェースと一致するように変更が必要です。（IPアドレスの代わりに）ソース となるサブネットでも指定できます。以下の例はサブネット ``192.168.1.0/24`` からのアクセスを許可するルールです。

.. code-block:: bash

   $ iptables -I DOCKER-USER -i ext_if ! -s 192.168.1.0/24 -j DROP

.. Finally, you can specify a range of IP addresses to accept using --src-range (Remember to also add -m iprange when using --src-range or --dst-range):

最後に、 ``--src-range`` を使って IP アドレス範囲を指定できます（ ``--src-range`` や ``--dst-range`` を使う場合も、 ``-m iprange`` が追加されますので、覚えておいてください）。

.. code-block:: bash

   $ iptables -I DOCKER-USER -m iprange -i ext_if ! --src-range 192.168.1.1-192.168.1.3 -j DROP

.. You can combine -s or --src-range with -d or --dst-range to control both the source and destination. For instance, if the Docker daemon listens on both 192.168.1.99 and 10.1.2.3, you can make rules specific to 10.1.2.3 and leave 192.168.1.99 open.

:ruby:`送信元 <source>`と :ruby:`送信先 <destination>` の両方を制御するため、 ``-s`` または ``--src-range`` と ``-d`` または ``--dst-range`` を一緒に使えます。たとえば、 Docker デーモンが ``192.168.1.99`` と ``10.1.2.3`` の両方をリッスンする場合、 ``10.1.2.3`` に対してルールを追加するものの、 ``192.168.1.99`` は開いたままにできます。

.. iptables is complicated and more complicated rules are out of scope for this topic. See the Netfilter.org HOWTO for a lot more information.

``iptables`` は複雑であり、より複雑なルールは、このトピックの範囲外です。更なる詳しい情報は `Netfilter.org HOWTO <https://www.netfilter.org/documentation/HOWTO/NAT-HOWTO.html>`_ をご覧ください。

.. Docker on a router
.. docker-on-a-router:
ルータ上の Docker
====================

.. Docker also sets the policy for the FORWARD chain to DROP. If your Docker host also acts as a router, this will result in that router not forwarding any traffic anymore. If you want your system to continue functioning as a router, you can add explicit ACCEPT rules to the DOCKER-USER chain to allow it:

Docker は ``FORWARD`` チェインに ``DROP`` するポリシーも追加出来ます。Docker ホストがルータとしても機能している場合は、このポリシーを追加した結果、あらゆるトラフィックが転送されなくなる可能性があります。システムがルータとしても機能し続けたい場合は、 ``DOCKER-USER`` チェインで ``ACCEPT`` ルールを追加し、許可を明示する必要があります。

.. code-block:: bash

   $ iptables -I DOCKER-USER -i src_if -o dst_if -j ACCEPT

.. Prevent Docker from manipulating iptables
.. _prevent-docker-from-manipulating-iptables:
Docker からの iptables 操作を回避するには
==================================================

.. It is possible to set the iptables key to false in the Docker engine’s configuration file at /etc/docker/daemon.json, but this option is not appropriate for most users. It is not possible to completely prevent Docker from creating iptables rules, and creating them after-the-fact is extremely involved and beyond the scope of these instructions. Setting iptables to false will more than likely break container networking for the Docker engine.

Docker エンジンの ``/etc/docker/daemon.json`` 設定ファイルで、 ``iptables``  キーを ``false`` に設定できます。ですが、このオプションは大部分のユーザにとって適切ではありません。Docker によって作成された ``iptables`` ルールを完全に回避できないだけでなく、作成後のルールは、極めて複雑かつ命令範囲が広まってしまう懸念があります。 ``iptables`` を ``false`` にする設定とは、Docker Engine のコンテナネットワークへ通信を遮断するような場合に使います。

.. For system integrators who wish to build the Docker runtime into other applications, explore the moby project.

Docker ランタイムを他のアプリケーションと構築し、システム統合したい場合には、 `moby プロジェクト <https://mobyproject.org/>`_ をお探しください。

.. Setting the default bind address for containers
コンテナ用のデフォルト バインド アドレスを指定
==================================================

.. By default, the Docker daemon will expose ports on the 0.0.0.0 address, i.e. any address on the host. If you want to change that behavior to only expose ports on an internal IP address, you can use the --ip option to specify a different IP address. However, setting --ip only changes the default, it does not restrict services to that IP.

デフォルトでは、 Docker デーモンは ``0.0.0.0`` アドレス上、つまり、ホスト上のあらゆるアドレスにポートを公開します。もしもこの挙動を変更し、特定の内部 IP アドレスだけ公開したい場合には、 ``--ip`` オプションを使って別の IP アドレスが指定可能です。一方で、 ``--ip`` が変更できるのは「デフォルト」だけであり、サービスごとの IP アドレスは制限できません。

.. Integration with Firewalld
.. _integaration-with-firewalld:
Firewalld との統合
====================

.. If you are running Docker version 20.10.0 or higher with firewalld on your system with --iptables enabled, Docker automatically creates a firewalld zone called docker and inserts all the network interfaces it creates (for example, docker0) into the docker zone to allow seamless networking.

Docker バージョン 20.10.0 以上を実行中で、 ``--iptables`` を有効にし、システム上で `firewalld <https://firewalld.org/>`_ を使っている場合、 Docker は自動的に ``docker`` という名称の ``firewalld`` ゾーンを作成し、作成されている全てのネットワークインタフェース（例： ``docker0`` ）を ``docker`` ゾーン内に追加し、シームレスなネットワーク通信を可能にします。

.. Consider running the following firewalld command to remove the docker interface from the zone.

docker インタフェースを zone から削除するには、以下の ``firewalld`` コマンドの実行を考えます。

.. code-block:: bash

   # 適切な zone や docker インタフェースに置き換えてください
   $ firewall-cmd --zone=trusted --remove-interface=docker0 --permanent
   $ firewall-cmd --reload


.. seealso:: 

   Docker and iptables
      https://docs.docker.com/network/iptables/
