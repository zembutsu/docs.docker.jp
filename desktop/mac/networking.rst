.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/networking/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/networking.md
.. check date: 2020/06/09
.. Commits on Jun 2, 2020 c082784316d8a212f04ac526cb6415ceb0a91dd6
.. -----------------------------------------------------------------------------

.. Networking features in Docker Desktop for Mac

.. _networking-features-in-docker-desktop-for-mac:

==================================================
ネットワーク構築機能
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Desktop for Mac provides several networking features to make it easier to use.

.. Features

.. _mac-networking-features:

機能
==========

.. VPN Passthrough

.. _mac-vpn-passthrough:

VPN パススルー
--------------------

.. Docker Desktop for Mac’s networking can work when attached to a VPN. To do this, Docker Desktop for Mac intercepts traffic from the containers and injects it into Mac as if it originated from the Docker application.

Docker Desktop のネットワーク構築は、VPN 接続時も動作します。そのためには、あたかも Docker アプリケーションが発信しているかのように、Docker Desktop がコンテナからのトラフィックを取り込み、Mac へ投入します。

.. Port Mapping

.. _mac-port-mapping:

ポートマッピング
--------------------

.. When you run a container with the -p argument, for example:

コンテナに :code:`-p` 引数を付けて実行します。こちらが実行例です。

.. code-block:: bash

   $ docker run -p 80:80 -d nginx

.. Docker Desktop for Mac makes whatever is running on port 80 in the container (in this case, nginx) available on port 80 of localhost. In this example, the host and container ports are the same. What if you need to specify a different host port? If, for example, you already have something running on port 80 of your host machine, you can connect the container to a different port:

Docker Desktop for Mac はコンテナ内のポート 80 で実行しているものが何であろうと（この例では `nginx` ）、 :code:`localhost` のポート 80 上で利用可能にします。ホスト側で異なるポートを指定するにはどうしたら良いでしょうか。例えば、ホストマシン側でポート 80 上で実行中の何かがある場合、コンテナに対しては別のポートで接続できます。

.. code-block:: bash

   $ docker run -p 8000:80 -d nginx

.. Now, connections to localhost:8000 are sent to port 80 in the container. The syntax for -p is HOST_PORT:CLIENT_PORT.

これで :code:`localhost:8000` への接続が、コンテナ内のポート 80 へ送られます。 :code:`-p` の構文は `ホスト側ポート:クライアント側ポート` です。

.. HTTP/HTTPS Proxy Support

.. _mac-http-https-proxy-support:

HTTP/HTTPS Proxy サポート
------------------------------

.. See Proxies.

:ref:`mac-preferences-proxies` をご覧ください。

.. Known limitations, use cases, and workarounds

.. _mac-known-limitations-use-cases-and-workarounds:

既知の制限、利用例、回避方法
==============================

.. Following is a summary of current limitations on the Docker Desktop for Mac networking stack, along with some ideas for workarounds.

以下で扱うのは、 Docker Desktop for Mac 上のネットワーク構築スタックにおける、現時点での制限の要約と、回避策に対する考え方です。


.. There is no docker0 bridge on macOS

.. _there-is-no-docker0-bridge-on-macos:

macOS に docker0 ブリッジがありません
----------------------------------------

.. Because of the way networking is implemented in Docker Desktop for Mac, you cannot see a docker0 interface on the host. This interface is actually within the virtual machine.

ネットワーク構築機能の実装が、Docker Desktop for Mac 用のため、ホスト側では :code:`docker0` インターフェースは見えません。このインターフェースは、実際には仮想マシン内にあります。


.. I cannot ping my containers

.. _mac-i-cannot-ping-my-containers:

コンテナに ping できません
------------------------------

.. Docker Desktop for Mac can’t route traffic to containers.

Docker Desktop for Mac は Linux コンテナに対してトラフィックを経路付け（ルーティング）できません。

.. Per-container IP addressing is not possible

.. _mac-pre-container-ip-addressing-is-not-possible:

コンテナごとに IP アドレスを割り当てられません
--------------------------------------------------

.. The docker (Linux) bridge network is not reachable from the macOS host.

docker (Linux) ブリッジ・ネットワークは macOS ホストから到達できません。

.. Use cases and workarounds

.. _mac-use-cases-and-workarounds:

利用例と回避方法
--------------------

.. There are two scenarios that the above limitations affect:

前述の制限に対応する、2つのシナリオがあります。

.. I want to connect from a container to a service on the host

.. _mac-i-want-to-connect-from-a-container-to-a-service-on-the-host:

コンテナからホスト上のサービスに対して接続したい
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. The host has a changing IP address (or none if you have no network access). From 18.03 onwards our recommendation is to connect to the special DNS name host.docker.internal, which resolves to the internal IP address used by the host. This is for development purpose and will not work in a production environment outside of Docker Desktop for Mac.

ホストの IP アドレスは変動します（あるいは、ネットワークへの接続がありません）。18.03 よりも前は、特定の DNS 名 :code:`host.docker.internal` での接続を推奨していました。これはホスト上で内部の IP アドレスで名前解決します。これは開発用途であり、Docker Desktop forMac 外の本番環境では動作しません。

.. The gateway is also reachable as gateway.docker.internal.

また、ゲートウェイに対しては :code:`gateway.docker.internal` で到達可能です。

.. I want to connect to a container from the Mac

.. _i-want-to-connect-to-a-container-from-the-mac:

Mac からコンテナに対して接続したい
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Port forwarding works for localhost; --publish, -p, or -P all work. Ports exposed from Linux are forwarded to the host.

:code:`localhost` に対するポート転送（port forwarding）が動作します。つまり、 :code:`--publish` 、 :code:`-p` 、 :code:`-P` が全て機能します。Linux からのポート公開（露出）は、ホスト側に転送されます。

.. Our current recommendation is to publish a port, or to connect from another container. This is what you need to do even on Linux if the container is on an overlay network, not a bridge network, as these are not routed.

現時点で推奨するのは、ポートの公開か、他のコンテナからの接続です。これは Linux 上でも同様ですが、ブリッジ・ネットワークではなくオーバレイ・ネットワーク上にコンテナがある場合、到達（経路付け）できません。

.. The command to run the nginx webserver shown in Getting Started is an example of this.

:ref:`始めましょう <mac-explore-the-application>` で用いたアプリケーション例にある :code:`nginx` ウェブサーバを表示するには、次のコマンドを使います。


.. code-block:: bash

   $ docker run -d -p 80:80 --name webserver nginx

.. To clarify the syntax, the following two commands both expose port 80 on the container to port 8000 on the host:

構文を明確にしましょう。以下の2つのコマンドは、いずれも同じコンテナのポート :code:`80` をホスト側のポート :code:`8080` に公開するものです。

.. code-block:: bash

   $ docker run --publish 8000:80 --name webserver nginx
   
   $ docker run -p 8000:80 --name webserver nginx

.. To expose all ports, use the -P flag. For example, the following command starts a container (in detached mode) and the -P exposes all ports on the container to random ports on the host.

全ポートを公開するには :code:`-P` フラグを使います。例えば、以下のコマンドはコンテナを起動し（デタッチド・モードで）、 :code:`-P` フラグはコンテナが公開する全てのポートを、ホスト側ランダムなポートに対して割り当てます。

.. code-block:: bash

   $ docker run -d -P --name webserver nginx

.. See the run command for more details on publish options used with docker run.

:code:`docker run` で公開するオプションに関する詳細は :doc:`/engine/reference/commandline/run` コマンドを御覧ください。


.. seealso:: 

   Networking features in Docker Desktop for Mac
      https://docs.docker.com/docker-for-mac/networking/
