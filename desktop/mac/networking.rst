.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/mac/networking/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/networking.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/mac/networking.md
.. check date: 2022/05/08
.. Commits on Sep 23, 2021 86cac4de75fced27776df2696dd547676a20c472
.. -----------------------------------------------------------------------------

.. Networking features in Docker Desktop for Mac
.. _networking-features-in-docker-desktop-for-mac:

==================================================
Docker Desktop for Mac のネットワーク機能
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Desktop for Mac provides several networking features to make it easier to use.

Docker Desktop for Mac には、使いやすくするための複数のネットワーク機能があります。

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

ポート :ruby:`割り当て <mapping>`
----------------------------------------

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

.. SSH agent forwarding
.. _mac-ssh-agent-forwarding:
SSH :ruby:`エージェント転送 <agent forwarding>`
--------------------------------------------------

.. Docker Desktop for Mac allows you to use the host’s SSH agent inside a container. To do this:

Docker Desktop for Mac は、ホスト側の SSH エージェントをコンテナ内で使えるようにします。そのためには、次のようにします。

..    Bind mount the SSH agent socket by adding the following parameter to your docker run command:

1. ``docker run`` コマンドに以下のパラメータを追加し、SSH エージェント ソケットをバインドマウント

   .. code-block:: bash

      --mount type=bind,src=/run/host-services/ssh-auth.sock,target=/run/host-services/ssh-auth.sock

..    Add the SSH_AUTH_SOCK environment variable in your container:

2. コンテナ内に ``SSH_AUTH_SOCK`` 環境変数を追加

      -e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock"

.. To enable the SSH agent in Docker Compose, add the following flags to your service:

Docker Compose 内で SSH エージェントを有効化するには、サービスに以下のフラグを追加します。

.. code-block:: yaml

   services:
     web:
       image: nginx:alpine
       volumes:
         - type: bind
           source: /run/host-services/ssh-auth.sock
           target: /run/host-services/ssh-auth.sock
       environment:
         - SSH_AUTH_SOCK=/run/host-services/ssh-auth.sock


.. Known limitations, use cases, and workarounds
.. _mac-known-limitations-use-cases-and-workarounds:
既知の制限、利用例、回避方法
==============================

.. Following is a summary of current limitations on the Docker Desktop for Mac networking stack, along with some ideas for workarounds.

以下で扱うのは、 Docker Desktop for Mac 上のネットワーク構築スタックにおける、現時点での制限の要約と、回避策に対する考え方です。

.. Changing internal IP addresses
.. _mac-changing-internal-ip-addresses:
内部 IP アドレスの変更
------------------------------

.. The internal IP addresses used by Docker can be changed via the Settings (Windows) or Preferences (Mac). After changing IPs, it is necessary to reset the Kubernetes cluster and to leave any active Swarm.

Docker によって使われる内部 IP アドレスは、設定（ Windows の場合は Settings、 Mac の場合は Preferences）で変更できます。 IP アドレスの変更後は、 Kubernetes クラスタのリセットか、アクティブな Swarm から離脱する必要があります。

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

.. The host has a changing IP address (or none if you have no network access). We recommend that you connect to the special DNS name host.docker.internal which resolves to the internal IP address used by the host. This is for development purpose and will not work in a production environment outside of Docker Desktop for Mac.

ホストの IP アドレスは変動します（ネットワークへの接続がなければ、割り当てられません）。ホストからアクセスするには、内部 IP アドレスを名前解決するために、特別な DNS 名 ``host.docker.internal`` の利用を推奨します。これは開発用途であり、Docker Desktop forMac 外の本番環境では動作しません。

.. You can also reach the gateway using gateway.docker.internal.

また、ゲートウェイに対しては :code:`gateway.docker.internal` で到達可能です。

.. If you have installed Python on your machine, use the following instructions as an example to connect from a container to a service on the host:

マシン上に Python をインストールしている場合、コンテナからホスト上のサービスに接続するためには、以下の手順を例に使えます。

..     Run the following command to start a simple HTTP server on port 8000.

1. 以下のコマンドを使い、サーバ上のポート 8080 でシンプルな HTTP サーバを起動します。

      $ python -m http.server 8000

   ..    If you have installed Python 2.x, run python -m SimpleHTTPServer 8000.

   Python 2.x をインストールしている場合、 ``python -m SimpleHTTPServer 8000`` を実行します。

..     Now, run a container, install curl, and try to connect to the host using the following commands:

2. 次は、コンテナを実行し、 ``curl`` をインストールし、以下のコマンドを使ってホストに接続します。

   .. code-block:: bash

      $ docker run --rm -it alpine sh
      # apk add curl
      # curl http://host.docker.internal:8000
      # exit


.. I want to connect to a container from the Mac
.. _i-want-to-connect-to-a-container-from-the-mac:

Mac からコンテナに対して接続したい
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Port forwarding works for localhost; --publish, -p, or -P all work. Ports exposed from Linux are forwarded to the host.

:code:`localhost` に対するポート転送（port forwarding）が動作します。つまり、 :code:`--publish` 、 :code:`-p` 、 :code:`-P` が全て機能します。Linux からのポート公開（露出）は、ホスト側に転送されます。

.. Our current recommendation is to publish a port, or to connect from another container. This is what you need to do even on Linux if the container is on an overlay network, not a bridge network, as these are not routed.

現時点で推奨するのは、ポートの公開か、他のコンテナからの接続です。これは Linux 上でも同様ですが、ブリッジ・ネットワークではなくオーバレイ・ネットワーク上にコンテナがある場合、到達（経路付け）できません。

.. For example, to run an nginx webserver:

たとえば、 ``nginx`` ウェブサーバを起動します。

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
