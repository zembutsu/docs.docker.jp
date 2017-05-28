.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/containers/networkingcontainers/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/containers/networkingcontainers.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/containers/networkingcontainers.md
.. check date: 2016/06/13
.. Commits on Apr 10, 2016 a609c2c48b5d504120777db2ac1ba83bfe355b66
.. ----------------------------------------------------------------------------

.. Networking containers

.. _networking-containers-guide:

=======================================
コンテナのネットワーク
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. If you are working your way through the user guide, you just built and ran a simple application. You’ve also built in your own images. This section teaches you how to network your containers.

これまでのユーザ・ガイドでは、単純なアプリケーションを構築して実行しました。また、自分でイメージの構築をしました。このセクションでは、コンテナをどのように接続するかを学びます。

.. Name a container

コンテナ名
====================

.. You’ve already seen that each container you create has an automatically created name; indeed you’ve become familiar with our old friend nostalgic_morse during this guide. You can also name containers yourself. This naming provides two useful functions:

これまで作成してきたコンテナは、自動的にコンテナ名が作成されました。このガイドでは  ``nostalgic_morse`` という古い友人のような名前でした。自動ではなく、自分でもコンテナに名前を付けられます。コンテナに名前があれば、２つの便利な機能が使えます。

..    You can name containers that do specific functions in a way that makes it easier for you to remember them, for example naming a container containing a web application web.

* コンテナに対して何らかの役割を示す名前を付けると、簡単に覚えられます。例えば、ウェブ・アプリケーションを含むコンテナには ``web`` と名付けます。

..    Names provide Docker with a reference point that allows it to refer to other containers. There are several commands that support this and you’ll use one in a exercise later.

* 名前を付けると、それが Docker の他コンテナから参照する時のポイントになります。後ほど、この働きをサポートする複数のコマンドを紹介します。

.. You name your container by using the --name flag, for example launch a new container called web:

コンテナに名前を付けるには、``--name`` フラグを使います。例えば、新しく起動するコンテナを web と呼ぶには、次のように実行します。

.. code-block:: bash

   $ docker run -d -P --name web training/webapp python app.py

.. Use the docker ps command to check the name:

``docker ps`` コマンドで名前を確認します。

.. code-block:: bash

   $ docker ps -l
   CONTAINER ID  IMAGE                  COMMAND        CREATED       STATUS       PORTS                    NAMES
   aed84ee21bde  training/webapp:latest python app.py  12 hours ago  Up 2 seconds 0.0.0.0:49154->5000/tcp  web

.. You can also use docker inspect with the container’s name.

あるいは ``docker inspect`` を使ってもコンテナ名を確認できます。

.. code-block:: bash

   $ docker inspect web
   [
   {
       "Id": "3ce51710b34f5d6da95e0a340d32aa2e6cf64857fb8cdb2a6c38f7c56f448143",
       "Created": "2015-10-25T22:44:17.854367116Z",
       "Path": "python",
       "Args": [
           "app.py"
       ],
       "State": {
           "Status": "running",
           "Running": true,
           "Paused": false,
           "Restarting": false,
           "OOMKilled": false,
     ...

.. Container names must be unique. That means you can only call one container web. If you want to re-use a container name you must delete the old container (with docker rm) before you can reuse the name with a new container. Go ahead and stop and them remove your web container.

コンテナ名はユニークである必要があります。これが意味するのは、``web`` と呼ばれるコンテナはただ一つしか使えません。もしも同じコンテナ名を再利用したいならば、新しいコンテナで名前を使う前に、古いコンテナを削除（``docker rm`` コマンドで）しなくてはいけません。``web`` コンテナの停止と削除をしてから、次に進みます。

.. code-block:: bash

   $ docker stop web
   web
   $ docker rm web
   web

.. Launch a container on the default network

.. _launch-a-container-on-the-default-network:

コンテナをデフォルトのネットワークで起動
========================================

.. Docker includes support for networking containers through the use of network drivers. By default, Docker provides two network drivers for you, the bridge and the overlay driver. You can also write a network driver plugin so that you can create your own drivers but that is an advanced task.

Docker は **ネットワーク・ドライバ** を使うことで、コンテナのネットワーク（訳者注：連結や接続するという意味の機能）をサポートします。標準では、Docker は ``bridge`` （ブリッジ） と  
``overlay`` （オーバレイ） の２つのネットワーク・ドライバを提供します。高度な使い方として、自分でネットワーク・ドライバ・プラグインを書き、その自分のドライバでネットワークを作成することも可能です。

.. Every installation of the Docker Engine automatically includes three default networks. You can list them:

Docker Engine は、自動的に３つのデフォルト・ネットワークをインストールします。

.. code-block:: bash

   $ docker network ls
   NETWORK ID          NAME                DRIVER
   18a2866682b8        none                null                
   c288470c46f6        host                host                
   7b369448dccb        bridge              bridge  

.. The network named bridge is a special network. Unless you tell it otherwise, Docker always launches your containers in this network. Try this now:

``bridge`` という名前のネットワークは特別です。特に指定しなければ、Docker は常にこのネットワーク上にコンテナを起動します。次のコマンドを試します：

.. code-block:: bash

   $ docker run -itd --name=networktest ubuntu
   74695c9cea6d9810718fddadc01a727a5dd3ce6a69d09752239736c030599741

.. Inspecting the network is an easy way to find out the container’s IP address.

ネットワークの調査（訳者注： network inspect コマンド）によって、コンテナの IP アドレスが簡単に分かります。

.. code-block:: json

   [
       {
           "Name": "bridge",
           "Id": "f7ab26d71dbd6f557852c7156ae0574bbf62c42f539b50c8ebde0f728a253b6f",
           "Scope": "local",
           "Driver": "bridge",
           "IPAM": {
               "Driver": "default",
               "Config": [
                   {
                       "Subnet": "172.17.0.1/16",
                       "Gateway": "172.17.0.1"
                   }
               ]
           },
           "Containers": {
               "3386a527aa08b37ea9232cbcace2d2458d49f44bb05a6b775fba7ddd40d8f92c": {
                   "EndpointID": "647c12443e91faf0fd508b6edfe59c30b642abb60dfab890b4bdccee38750bc1",
                   "MacAddress": "02:42:ac:11:00:02",
                   "IPv4Address": "172.17.0.2/16",
                   "IPv6Address": ""
               },
               "94447ca479852d29aeddca75c28f7104df3c3196d7b6d83061879e339946805c": {
                   "EndpointID": "b047d090f446ac49747d3c37d63e4307be745876db7f0ceef7b311cbba615f48",
                   "MacAddress": "02:42:ac:11:00:03",
                   "IPv4Address": "172.17.0.3/16",
                   "IPv6Address": ""
               }
           },
           "Options": {
               "com.docker.network.bridge.default_bridge": "true",
               "com.docker.network.bridge.enable_icc": "true",
               "com.docker.network.bridge.enable_ip_masquerade": "true",
               "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
               "com.docker.network.bridge.name": "docker0",
               "com.docker.network.driver.mtu": "9001"
           }
       }
   ]


.. You can remove a container from a network by disconnecting the container. To do this, you supply both the network name and the container name. You can also use the container id. In this example, though, the name is faster.

コンテナを切断（disconnect）し、ネットワークからコンテナを取り外せます。切断にはネットワーク名とコンテナ名を指定します。あるいは、コンテナ ID も使えます。この例では、名前を指定する方が速いです。

.. code-block:: bash

   $ docker network disconnect bridge networktest

.. While you can disconnect a container from a network, you cannot remove the builtin bridge network named bridge. Networks are natural ways to isolate containers from other containers or other networks. So, as you get more experienced with Docker, you’ll want to create your own networks.

コンテナをネットワークから切断しようとしても、 ``bridge`` という名前で組み込まれている ``ブリッジ`` ネットワークを削除できません。ネットワークとはコンテナを他のコンテナやネットワークを隔離する一般的な手法です。そのため、Docker を使い込み、自分自身でネットワークの作成も可能です。

.. Create your own bridge network

.. _create-your-own-bridge-network:

ブリッジ・ネットワークの作成
==============================

.. Docker Engine natively supports both bridge networks and overlay networks. A bridge network is limited to a single host running Docker Engine. An overlay network can include multiple hosts and is a more advanced topic. For this example, you’ll create a bridge network:

Docker Engine はブリッジ・ネットワークとオーバレイ・ネットワークをどちらもネイティブにサポートしています。ブリッジ・ネットワークは、単一ホスト上で実行している Docker Engine でしか使えない制限があります。オーバレイ・ネットワークは複数のホストで導入でき、高度な使い方ができます。次の例は、ブリッジ・ネットワークの作成です。

.. code-block:: bash

   $ docker network create -d bridge my-bridge-network

.. The -d flag tells Docker to use the bridge driver for the new network. You could have left this flag off as bridge is the default value for this flag. Go ahead and list the networks on your machine:

Docker に対して新しいネットワークで使用する ``bridge`` ドライバを指定するには、 ``-d`` フラグを使います。このフラグを指定しなくても、同様にこの ``bridge`` フラグが適用されます。マシン上のネットワーク一覧を表示します。

.. code-block:: bash

   $ docker network ls
   NETWORK ID          NAME                DRIVER
   7b369448dccb        bridge              bridge              
   615d565d498c        my-bridge-network   bridge              
   18a2866682b8        none                null                
   c288470c46f6        host                host

.. If you inspect the network, you’ll find that it has nothing in it.

このネットワークを調査しても、中にはコンテナが存在しないのが分かります。

.. code-block:: bash

   $ docker network inspect my-bridge-network
   [
       {
           "Name": "my-bridge-network",
           "Id": "5a8afc6364bccb199540e133e63adb76a557906dd9ff82b94183fc48c40857ac",
           "Scope": "local",
           "Driver": "bridge",
           "IPAM": {
               "Driver": "default",
               "Config": [
                   {
                       "Subnet": "172.18.0.0/16",
                       "Gateway": "172.18.0.1/16"
                   }
               ]
           },
           "Containers": {},
           "Options": {}
       }
   ]

.. Add containers to a network

.. _add-containers-to-a-network:

ネットワークにコンテナを追加
==============================

.. To build web applications that act in concert but do so securely, create a network. Networks, by definition, provide complete isolation for containers. You can add containers to a network when you first run a container.

ウェブ・アプリケーションの構築にあたり、安全性を高めるためにネットワークを作成します。ネットワークとは、コンテナの完全な分離を提供するものと定義します。コンテナを実行する時に、コンテナをネットワークに追加できます。

.. Launch a container running a PostgreSQL database and pass it the --net=my-bridge-network flag to connect it to your new network:

PostgreSQL データベースを実行するコンテナを起動します。``--net=my-bridge-network`` フラグを付けて、新しいネットワークに接続します。

.. code-block:: bash

   $ docker run -d --net=my-bridge-network --name db training/postgres

.. If you inspect your my-bridge-network you’ll see it has a container attached. You can also inspect your container to see where it is connected:

``my-bridge-network`` を調べると、コンテナがアタッチ（接続）しているのが分かります。同様にコンテナを調べても、どこに接続しているのか分かります。

.. code-block:: bash

   $ docker inspect --format='{{json .NetworkSettings.Networks}}'  db
   {"my-bridge-network":{"NetworkID":"7d86d31b1478e7cca9ebed7e73aa0fdeec46c5ca29497431d3007d2d9e15ed99","EndpointID":"508b170d56b2ac9e4ef86694b0a76a22dd3df1983404f7321da5649645bf7043","Gateway":"172.18.0.1","IPAddress":"172.18.0.2","IPPrefixLen":16,"IPv6Gateway":"","GlobalIPv6Address":"","GlobalIPv6PrefixLen":0,"MacAddress":"02:42:ac:11:00:02"}}

.. Now, go ahead and start your by now familiar web application. This time leave off the -P flag and also don’t specify a network.

次に進み、近くでウェブ・アプリケーションを起動します。今回は ``-P`` フラグもネットワークも指定しません。

.. code-block:: bash

   $ docker run -d --name web training/webapp python app.py

.. Which network is your web application running under? Inspect the application and you’ll find it is running in the default bridge network.

ウェブ・アプリケーションはどのネットワーク上で実行しているのでしょうか。アプリケーションを調査したら、標準の ``bridge`` ネットワークで実行していることが分かります。

.. code-block:: bash

   $ docker inspect --format='{{json .NetworkSettings.Networks}}'  web
   {"bridge":{"NetworkID":"7ea29fc1412292a2d7bba362f9253545fecdfa8ce9a6e37dd10ba8bee7129812","EndpointID":"508b170d56b2ac9e4ef86694b0a76a22dd3df1983404f7321da5649645bf7043","Gateway":"172.17.0.1","IPAddress":"172.17.0.2","IPPrefixLen":16,"IPv6Gateway":"","GlobalIPv6Address":"","GlobalIPv6PrefixLen":0,"MacAddress":"02:42:ac:11:00:02"}}

.. Then, get the IP address of your web

次に web の IP アドレスを取得しましょう。

.. code-block:: bash

   $ docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' web
   172.17.0.2

.. Now, open a shell to your running db container:

次は、実行中の ``db`` コンテナでシェルを開きます：

.. code-block:: bash

   $ docker exec -it db bash
   root@a205f0dd33b2:/# ping 172.17.0.2
   ping 172.17.0.2
   PING 172.17.0.2 (172.17.0.2) 56(84) bytes of data.
   ^C
   --- 172.17.0.2 ping statistics ---
   44 packets transmitted, 0 received, 100% packet loss, time 43185ms

.. After a bit, use `CTRL-C` to end the `ping` and you'll find the ping failed. That is because the two containers are running on different networks. You can fix that. Then, use the `exit` command to close the container.

少したってから CTRL-C を使って ``ping`` を終了します。ping が通らないことが分かりました。これは、２つのコンテナが異なるネットワークで実行しているからです。これを修正しましょう。次に ``exit`` を使って、コンテナから出ます。

.. Docker networking allows you to attach a container to as many networks as you like. You can also attach an already running container. Go ahead and attach your running web app to the my-bridge-network.

Docker のネットワーク機能は、必要に応じてコンテナに対して多くのネットワークを接続（attach）できます。接続は、実行中のコンテナに対しても可能です。次に、実行中の ``web`` アプリケーションを ``my-bridge-network`` に接続します。

.. code-block:: bash

   $ docker network connect my-bridge-network web

.. Open a shell into the db application again and try the ping command. This time just use the container name web rather than the IP Address.

``db`` アプリケーションのシェルを再び開き、ping コマンドを再度試します。今回は IP アドレスではなく、コンテナ名 ``web`` を使います。

.. code-block:: bash

   $ docker exec -it db bash
   root@a205f0dd33b2:/# ping web
   PING web (172.19.0.3) 56(84) bytes of data.
   64 bytes from web (172.19.0.3): icmp_seq=1 ttl=64 time=0.095 ms
   64 bytes from web (172.19.0.3): icmp_seq=2 ttl=64 time=0.060 ms
   64 bytes from web (172.19.0.3): icmp_seq=3 ttl=64 time=0.066 ms
   ^C
   --- web ping statistics ---
   3 packets transmitted, 3 received, 0% packet loss, time 2000ms
   rtt min/avg/max/mdev = 0.060/0.073/0.095/0.018 ms

別の IP アドレスに ``ping`` しているのが分かります。このアドレスは ``my-bridge-network`` のアドレスであり、 ``bridge`` ネットワーク上のものではありません。

.. Next steps

次のステップ
====================

.. Now that you know how to network containers, see how to manage data in containers.

コンテナのネットワークについて学びましたので、次は :doc:`コンテナにおけるデータ管理 <dockervolumes>` を理解していきます。

.. seealso:: 

   Network containers
      https://docs.docker.com/engine/userguide/containers/networkingcontainers/

