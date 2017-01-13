.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/networking/default_network/dockerlinks/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/default_network/dockerlinks.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/networking/default_network/dockerlinks.md
.. check date: 2016/06/14
.. Commits on Feb 2, 2016 6f863cfa18f30d1df2f1f81b2b4f456dee2a73b8
.. ---------------------------------------------------------------------------

.. Legacy container links

.. _legacy-container-links:

========================================
レガシーのコンテナ・リンク機能
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The information in this section explains legacy container links within the Docker default bridge. This is a bridge network named bridge created automatically when you install Docker.

このセクションで説明する過去（レガシー）のコンテナ・リンク機能に関する情報は、Docker のデフォルト・ブリッジ内でのみ扱えます。デフォルト・ブリッジとは ``bridge`` という名称の ``ブリッジ`` ネットワークであり、Docker をインストールすると自動的に作成されます。

.. Before the Docker networks feature, you could use the Docker link feature to allow containers to discover each other and securely transfer information about one container to another container. With the introduction of the Docker networks feature, you can still create links but they behave differently between default bridge network and user defined networks

:doc:`Docker にネットワーク機能 </engine/userguide/networking/dockernetworks>` を導入するまでは、この Docker リンク機能によって、あるコンテナから別のコンテナに対してコンテナ間で相互の発見をし、安全に転送する情報を得られました。これから Docker ネットワーク機能を学ぶのであれば注意点があります。今もリンク機能を使いコンテナを作成できます。ただし、デフォルトの ``ブリッジ`` ネットワークと :ref:`ユーザ定義ネットワーク <linking-containers-in-user-defined-networks>` では、サポートされている機能が異なるのでご注意ください。

.. This section briefly discusses connecting via a network port and then goes into detail on container linking in default bridge network.

このセクションではネットワーク・ポートの接続と、それらをデフォルトの ``bridge`` ネットワーク上のコンテナ上でリンクする方法を簡単に扱います。

.. Connect using network port mapping

.. _connect-using-network-port-mapping:

ネットワークのポート・マッピングで接続
========================================

.. In the Using Docker section, you created a container that ran a Python Flask application:

:doc:`Docker を使う</engine/userguide/containers/usingdocker>` のセクションでは、Python Flask アプリケーションを動かすコンテナを、次のように作成しました。

.. code-block:: bash

   $ docker run -d -P training/webapp python app.py

..    Note: Containers have an internal network and an IP address (as we saw when we used the docker inspect command to show the container’s IP address in the Using Docker section). Docker can have a variety of network configurations. You can see more information on Docker networking here.

.. note::

   コンテナは内部ネットワークと IP アドレスを持っています（ :doc:`Docker を使う</engine/userguide/containers/usingdocker>`  セクションで、``docker inspect`` コマンドを実行してコンテナの IP アドレスを確認しました ）。Docker は様々なネットワーク設定を持っています。Docker ネットワーク機能の詳細は :doc:`こちら </engine/userguide/networking/index>` をご覧ください。

.. When that container was created, the -P flag was used to automatically map any network port inside it to a random high port within an ephemeral port range on your Docker host. Next, when docker ps was run, you saw that port 5000 in the container was bound to port 49155 on the host.

コンテナの作成時に ``-P`` フラグを使えば、自動的にコンテナ内部のネットワーク・ポートを、ランダムなハイポート（Docker ホスト上のエフェメラル・ポート範囲内）に割り当てます。次は ``docker ps`` を実行時、コンテナ内のポート 5000 が、ホスト側の 49115 に接続していると分かります。

.. code-block:: bash

   $ docker ps nostalgic_morse
   CONTAINER ID  IMAGE                   COMMAND       CREATED        STATUS        PORTS                    NAMES
   bc533791f3f5  training/webapp:latest  python app.py 5 seconds ago  Up 2 seconds  0.0.0.0:49155->5000/tcp  nostalgic_morse

.. You also saw how you can bind a container’s ports to a specific port using the -p flag. Here port 80 of the host is mapped to port 5000 of the container:

また、コンテナのポートを特定のポートにマッピングする（割り当てる）には、 ``-p`` フラグを使う方法も見てきました。ここでは、ホスト側のポート 80 に、コンテナのポート 5000 を割り当てています。

.. code-block:: bash

   $ docker run -d -p 80:5000 training/webapp python app.py

.. And you saw why this isn’t such a great idea because it constrains you to only one container on that specific port.

そしてこの方法は、なぜ悪い考えのでしょうか。それは、特定のコンテナが特定のポートを拘束するからです。

.. Instead, you may specify a range of host ports to bind a container port to that is different than the default ephemeral port range:

そうではなく、コンテナのポートを割り当てるには、デフォルトのエフェメラル・ポート範囲内を使うよりも、自分でホスト側のポート範囲を指定した方が望ましいでしょう。

.. code-block:: bash

   $ docker run -d -p 8000-9000:5000 training/webapp python app.py

.. This would bind port 5000 in the container to a randomly available port between 8000 and 9000 on the host.

これはコンテナのポート 5000 を、ホスト側のポート 8000 ～ 9000 の範囲において、利用可能なポートをランダムに割り当てます。

.. There are also a few other ways you can configure the -p flag. By default the -p flag will bind the specified port to all interfaces on the host machine. But you can also specify a binding to a specific interface, for example only to the localhost.

また、 ``-p`` フラグは他の目的のためにも設定できます。デフォルトの ``-p`` フラグは、ホスト側マシンの全てのインターフェースに対する特定のポートを使用します。ですが、特定のインターフェースの使用を明示することが可能です。例えば、 ``localhost`` のみの指定は、次のようにします。

.. code-block:: bash

   $ docker run -d -p 127.0.0.1:80:5000 training/webapp python app.py

.. This would bind port 5000 inside the container to port 80 on the localhost or 127.0.0.1 interface on the host machine.

これはコンテナ内のポート 5000 を、ホスト側マシン上の ``localhost`` か ``127.0.0.1`` インターフェース上のポート 80 に割り当てます。

.. Or, to bind port 5000 of the container to a dynamic port but only on the localhost, you could use:

あるいは、コンテナ内のポート 5000 を、ホスト側へ動的に割り当てるますが、 ``localhost`` だけ使いたい時は次のようにします。

.. code-block:: bash

   $ docker run -d -p 127.0.0.1::5000 training/webapp python app.py

.. You can also bind UDP ports by adding a trailing /udp. For example:

また、UDP ポートを割り当てたい場合は、最後に ``/udp`` を追加します。例えば、次のように実行します。

.. code-block:: bash

   $ docker run -d -p 127.0.0.1:80:5000/udp training/webapp python app.py

.. You also learned about the useful docker port shortcut which showed us the current port bindings. This is also useful for showing you specific port configurations. For example, if you’ve bound the container port to the localhost on the host machine, then the docker port output will reflect that.

また、便利な ``docker port`` ショートカットについても学びました。これは現在ポートが割り当てられている情報も含みます。これは、特定のポートに対する設定を確認するのにも便利です。例えば、ホストマシン上の ``localhost`` にコンテナのポートを割り当てている場合、 ``docker port`` を実行すると次のような出力を返します。

.. code-block:: bash

   $ docker port nostalgic_morse 5000
   127.0.0.1:49155

..    Note: The -p flag can be used multiple times to configure multiple ports.

.. note::

   複数のポート設定は、``-p`` フラグを複数指定します。

.. Connect with the linking system

.. _connect-with-the-linking-system:

リンクしているシステムに接続
==============================

.. Note: This section covers the legacy link feature in the default bridge network. Please refer to linking containers in user-defined networks for more information on links in user-defined networks.

.. note::

   このセクションが扱うのはデフォルトの ``ブリッジ`` ネットワークにおけるレガシーのリンク機能です。ユーザ定義ネットワーク上での詳しい情報は、:ref:`ユーザ定義ネットワークにおけるコンテナのリンクの仕方 <linking-containers-in-user-defined-networks>` をご覧ください。

.. Network port mappings are not the only way Docker containers can connect to one another. Docker also has a linking system that allows you to link multiple containers together and send connection information from one to another. When containers are linked, information about a source container can be sent to a recipient container. This allows the recipient to see selected data describing aspects of the source container.

Docker コンテナが他のコンテナに接続する方法は、ネットワーク・ポートの割り当て（mapping）だけではありません。Docker にはリンク・システム（linking system）もあります。これは、複数のコンテナを一緒にリンクするもので、あるコンテナから別のコンテナに対する接続情報を送信します。コンテナをリンクしたら、ソース・コンテナに関する情報が、受信者側のコンテナに送られます。これにより、受信者側は送信元のコンテナを示す説明データを選ぶことができます。

.. The importance of naming

.. _the-importance-of-naming:

名前付けの重要さ
--------------------

.. To establish links, Docker relies on the names of your containers. You’ve already seen that each container you create has an automatically created name; indeed you’ve become familiar with our old friend nostalgic_morse during this guide. You can also name containers yourself. This naming provides two useful functions:

Docker でリンク機能を使うとき、コンテナ名に依存します。既に見てきたように、各コンテナを作成すると自動的に名前が作成されます。実際、このガイドでは ``nostalgic_morse`` という古い友人のような名前でした。コンテナ名は自分でも名付けられます。この名付けは２つの便利な機能を提供します。

..     It can be useful to name containers that do specific functions in a way that makes it easier for you to remember them, for example naming a container containing a web application web.

1. コンテナに名前を付けるのは、コンテナの名前を覚えておくためなど、特定の役割には便利です。例えば、ウェブ・アプリケーションのコンテナには ``web`` と名付けます。

..    It provides Docker with a reference point that allows it to refer to other containers, for example, you can specify to link the container web to container db.

2. Docker で他のコンテナが参照できるようにするための、リファレンス・ポイント（参照地点）を提供します。例えば、 ``web`` コンテナを ``db`` コンテナへリンクします。

.. You can name your container by using the --name flag, for example:

コンテナ名を指定するには ``--name`` フラグを使います。例：

.. code-block:: bash

   $ docker run -d -P --name web training/webapp python app.py

.. This launches a new container and uses the --name flag to name the container web. You can see the container’s name using the docker ps command.

これは新しいコンテナを起動し、 ``--name`` フラグでコンテナ名を ``web`` とします。コンテナ名は ``docker ps`` コマンドで見られます。

.. code-block:: bash

   $ docker ps -l
   CONTAINER ID  IMAGE                  COMMAND        CREATED       STATUS       PORTS                    NAMES
   aed84ee21bde  training/webapp:latest python app.py  12 hours ago  Up 2 seconds 0.0.0.0:49154->5000/tcp  web

.. You can also use docker inspect to return the container’s name.

あるいは ``docker inspect`` を使い、表示結果からコンテナ名の確認もできます。

..    Note: Container names have to be unique. That means you can only call one container web. If you want to re-use a container name you must delete the old container (with docker rm) before you can create a new container with the same name. As an alternative you can use the --rm flag with the docker run command. This will delete the container immediately after it is stopped.

.. note::

   コンテナ名はユニーク（一意）である必要があります。つまり、 ``web`` と呼べるコンテナは１つだけです。コンテナ名を再利用したい場合は、同じ名前で新しいコンテナを作成する前に、古いコンテナの削除（ ``docker rm`` を使用 ）が必要です。あるいは別の方法として、 ``docker run`` コマンドの実行時に ``--rm`` フラグを指定します。これは、コンテナが停止したら、直ちにコンテナを削除するオプションです。

.. Communication across links

.. _communication-across-links:

リンクを横断する通信
====================

.. Links allow containers to discover each other and securely transfer information about one container to another container. When you set up a link, you create a conduit between a source container and a recipient container. The recipient can then access select data about the source. To create a link, you use the --link flag. First, create a new container, this time one containing a database.

コンテナに対するリンクによりお互いのことを発見（discover）し、あるコンテナから別のコンテナに対して安全に転送する情報を得られます。リンクを設定したら、送信元コンテナから送信先コンテナに対する導線を作成します。リンクを作成するには、 ``--link`` フラグを使います。まず、新しいコンテナを作成します。今回はデータベースを含むコンテナを作成します。

.. code-block:: bash

   $ docker run -d --name db training/postgres

.. This creates a new container called db from the training/postgres image, which contains a PostgreSQL database.

これは PostgreSQL データベースを含む ``training/postgres`` イメージを使い、 ``db`` という名称のコンテナを作成します。

.. Now, you need to delete the web container you created previously so you can replace it with a linked one:

次は、先ほどの手順で ``web`` コンテナを既に作成しているのであれば、リンク可能なコンテナに置き換えるため、削除する必要があります。

.. code-block:: bash

   $ docker rm -f web

.. Now, create a new web container and link it with your db container.

次は、 ``db`` コンテナにリンクする新しい ``web`` コンテナを作成します。。

.. code-block:: bash

   $ docker run -d -P --name web --link db:db training/webapp python app.py

.. This will link the new web container with the db container you created earlier. The --link flag takes the form:

これは先ほど作成した ``db`` コンテナを新しい ``web`` コンテナにリンクするものです。 ``--link`` フラグは次のような形式です。

.. code-block:: bash

   --link <名前 or id>:エイリアス

.. Where name is the name of the container we’re linking to and alias is an alias for the link name. You’ll see how that alias gets used shortly. The --link flag also takes the form:

``名前`` の場所はリンクしようとしているコンテナ名の場所であり、 ``エイリアス`` はリンク名の別名です。 ``--link`` フラグは、次のような形式もあります。

.. code-block:: bash

   --link <名前 or id>

.. In which case the alias will match the name. You could have written the previous example as:

このケースではエイリアスはコンテナ名と一致しています。先ほどの例は、次のようにも書き換えられます。

.. code-block:: bash

   $ docker run -d -P --name web --link db training/webapp python app.py

.. Next, inspect your linked containers with docker inspect:

次は、 ``docker inspect`` でリンクしコンテナを確認しましょう。

.. code-block:: bash

   $ docker inspect -f "{{ .HostConfig.Links }}" web
   [/db:/web/db]

.. You can see that the web container is now linked to the db container web/db. Which allows it to access information about the db container.

これで ``web`` コンテナは ``db`` コンテナに ``web/db`` としてリンクされました。これを使い、 ``db`` コンテナに対する接続情報を得られます。

.. So what does linking the containers actually do? You’ve learned that a link allows a source container to provide information about itself to a recipient container. In our example, the recipient, web, can access information about the source db. To do this, Docker creates a secure tunnel between the containers that doesn’t need to expose any ports externally on the container; you’ll note when we started the db container we did not use either the -P or -p flags. That’s a big benefit of linking: we don’t need to expose the source container, here the PostgreSQL database, to the network.

コンテナに対するリンクとは、実際には何をしているのでしょうか？ これまで学んだように、リンクとは、送信元コンテナが送信先コンテナに送るため、自分自身の情報を提供します。今回の例では、受信者は ``web`` であり、元になる ``db`` に関する接続情報を入手できます。これにより、Docker はコンテナ間で安全なトンネルを作成します。つまり、 ``db`` コンテナを開始する時に、 ``-P`` や ``-p`` フラグを使う必要がありません。これはリンク機能の大きな利点です。これは、元のコンテナのポートを公開する必要がありません。今回の例では、 PostgreSQL データベースをネットワークに接続する必要はありません。

.. Docker exposes connectivity information for the source container to the recipient container in two ways:

Docker が元コンテナから送信先コンテナに接続情報を渡すには、２つの方法があります。

..    Environment variables,
    Updating the /etc/hosts file.

* 環境変数
* ``/etc/hosts`` ファイルの更新

.. Environment variables

.. _environment-variables:

環境変数
----------

.. Docker creates several environment variables when you link containers. Docker automatically creates environment variables in the target container based on the --link parameters. It will also expose all environment variables originating from Docker from the source container. These include variables from:

Docker はリンクするコンテナに対する様々な環境変数を作成します。Docker は ``--link`` パラメータで指定したコンテナを対象とする環境変数を、自動的に作成します。また、Docker は参照元とするコンテナの環境変数も作成します。これらの環境変数を使うには、次のようにします。

..    the ENV commands in the source container’s Dockerfile
    the -e, --env and --env-file options on the docker run command when the source container is started

* ソース・コンテナの Dockerfile で ``ENV`` コマンドを使用
* ソース・コンテナの開始時に、``docker run`` コマンドで ``-e``  、 ``--env`` 、 ``--env-file`` オプションを使用

.. These environment variables enable programmatic discovery from within the target container of information related to the source container.

これらの環境変数は、ディスカバリのプログラム化を実現します。これはターゲットのコンテナ内の情報に、ソース・コンテナに関連する情報を含みまます。

..    Warning: It is important to understand that all environment variables originating from Docker within a container are made available to any container that links to it. This could have serious security implications if sensitive data is stored in them.

.. warning::

   重要な理解が必要なのは、Docker がコンテナに関して作成する *全て* の環境変数が、リンクされた *あらゆる* コンテナで利用できることです。これにより、機密事項を扱うデータをコンテナに保管する場合は、セキュリティに関する重大な影響を及ぼす場合があります。

.. Docker sets an <alias>_NAME environment variable for each target container listed in the --link parameter. For example, if a new container called web is linked to a database container called db via --link db:webdb, then Docker creates a WEBDB_NAME=/web/webdb variable in the web container.

Docker は ``--list`` パラメータで指定したターゲットコンテナごとに ``<エイリアス>_名前`` 環境変数を作成します。例えば、新しいコンテナ ``web`` がデータベース・コンテナ ``db`` とリンクするためには ``--link db:webdb`` を指定します。すると Docker は ``web`` コンテナ内で ``WEBDB_NAME=/web/webdb`` 環境変数を作成します。

.. Docker also defines a set of environment variables for each port exposed by the source container. Each variable has a unique prefix in the form:

また Docker は、ソース・コンテナが公開している各ポートの環境変数も定義します。各変数には、ユニークな接頭語を付けています。

.. code-block:: bash

   <名前>_PORT_<ポート番号>_<プロトコル>

.. The components in this prefix are:

この接頭語の要素は、次の通りです。

..    the alias <name> specified in the --link parameter (for example, webdb)
    the <port> number exposed
    a <protocol> which is either TCP or UDP

* エイリアスの ``<名前>`` を ``--link`` パラメータで指定している場合（例： ``webdb`` ）
* 公開している ``<ポート>`` 番号
* TCP もしくは UDP の ``<プロトコル>``

.. Docker uses this prefix format to define three distinct environment variables:

Docker はこれら接頭語の形式を、３つの異なる環境変数で使います。

..    The prefix_ADDR variable contains the IP Address from the URL, for example WEBDB_PORT_5432_TCP_ADDR=172.17.0.82.
    The prefix_PORT variable contains just the port number from the URL for example WEBDB_PORT_5432_TCP_PORT=5432.
    The prefix_PROTO variable contains just the protocol from the URL for example WEBDB_PORT_5432_TCP_PROTO=tcp.

* ``prefix_ADDR`` 変数は、URL 用の IP アドレスを含む。例： ``WEBDB_PORT_5432_TCP_ADDR=172.17.0.82``
* ``prefix_PORT`` 変数は、URL 用のポート番号を含む。例： ``WEBDB_PORT_5432_TCP_PORT=5432``
* ``prefix_PROTO`` 変数は URL 用のプロトコルを含む。例： ``WEBDB_PORT_5432_TCP_PROTO=tcp``

.. If the container exposes multiple ports, an environment variable set is defined for each one. This means, for example, if a container exposes 4 ports that Docker creates 12 environment variables, 3 for each port.

もしコンテナが複数のポートを公開している場合は、それぞれのポートを定義する環境変数が作成されます。つまり、例えばコンテナが４つのポートを公開しているのであれば、Docker はポートごとに３つの環境変数を作成するため、合計12個の変数を作成します。

.. Additionally, Docker creates an environment variable called <alias>_PORT. This variable contains the URL of the source container’s first exposed port. The ‘first’ port is defined as the exposed port with the lowest number. For example, consider the WEBDB_PORT=tcp://172.17.0.82:5432 variable. If that port is used for both tcp and udp, then the tcp one is specified.

更に、Docker は ``<エイリアス>_ポート`` の環境変数も作成します。この変数にはソース・コンテナが１番めに公開しているポートの URL を含みます。「１番め」のポートとは、公開しているポートのうち、最も低い番号です。例えば、 ``WEBDB_PORT=tcp://172.17.0.82:5432`` のような変数が考えられます。もし、ポートが tcp と udp の両方を使っているのであれば、tcp のポートだけが指定されます。

.. Finally, Docker also exposes each Docker originated environment variable from the source container as an environment variable in the target. For each variable Docker creates an <alias>_ENV_<name> variable in the target container. The variable’s value is set to the value Docker used when it started the source container.

最後に、ソース・コンテナ上の Docker に由来する環境変数は、ターゲット上でも環境変数として使えるように公開されます。Docker が作成した各環境変数 ``<エイリアス>_ENV_<名前>`` が、ターゲットのコンテナから参照できます。これら環境変数の値は、ソース・コンテナが起動した時の値を使います。

.. Returning back to our database example, you can run the env command to list the specified container’s environment variables.

データベースの例に戻りましょう。 ``env`` コマンドを実行したら、指定したコンテナの環境変数一覧を表示します。

.. code-block:: bash

   $ docker run --rm --name web2 --link db:db training/webapp env
   . . .
   DB_NAME=/web2/db
   DB_PORT=tcp://172.17.0.5:5432
   DB_PORT_5432_TCP=tcp://172.17.0.5:5432
   DB_PORT_5432_TCP_PROTO=tcp
   DB_PORT_5432_TCP_PORT=5432
   DB_PORT_5432_TCP_ADDR=172.17.0.5
   . . .

.. You can see that Docker has created a series of environment variables with useful information about the source db container. Each variable is prefixed with DB_, which is populated from the alias you specified above. If the alias were db1, the variables would be prefixed with DB1_. You can use these environment variables to configure your applications to connect to the database on the db container. The connection will be secure and private; only the linked web container will be able to talk to the db container.

このように、Docker は環境変数を作成しており、そこには元になった ``ソース`` コンテナに関する便利な情報を含みます。各変数にある接頭語 ``DB_`` とは、先ほど指定した ``エイリアス`` から割り当てられています。もし ``alias`` が ``db1`` であれば、環境変数の接頭語は ``DB1_`` になります。これらの環境変数を使い、アプリケーションが ``db`` コンテナ上のデータベースに接続する設定も可能です。接続は安全かつプライベートなものですが、これはリンクされた ``web`` コンテナと ``db`` コンテナが通信できるようにするだけです。

.. Important notes on Docker environment variables

.. _important-notes-on-docker-environment-variables:

Docker 環境変数に関する重要な注意
----------------------------------------

.. Unlike host entries in the /etc/hosts file, IP addresses stored in the environment variables are not automatically updated if the source container is restarted. We recommend using the host entries in /etc/hosts to resolve the IP address of linked containers.

``/etc/hosts`` :ref:`ファイル <updating-the-etchosts-file>` のエントリとは違い、もし元になったコンテナが再起動しても、保管されている IP アドレスの情報は自動的に更新されません。リンクするコンテナの IP アドレスを名前解決するには、 ``/etc/hosts`` エントリの利用をお勧めします。

.. These environment variables are only set for the first process in the container. Some daemons, such as sshd, will scrub them when spawning shells for connection.

これらの環境変数が作成されるのは、コンテナの初期段階のみです。 ``sshd`` のようなデーモンであれば、シェルへの接続が生じた時に確定します。

.. Updating the /etc/hosts file

.. _updating-the-etchosts-file:

``/etc/hosts`` ファイルの更新
------------------------------

.. In addition to the environment variables, Docker adds a host entry for the source container to the /etc/hosts file. Here’s an entry for the web container:

環境変数について追記しますと、 Docker は ``/etc/hosts`` ファイルに、元になったコンテナのエントリを追加します。ここでは ``web`` コンテナのエントリを見てみましょう。

.. code-block:: bash

   $ docker run -t -i --rm --link db:webdb training/webapp /bin/bash
   root@aed84ee21bde:/opt/webapp# cat /etc/hosts
   172.17.0.7  aed84ee21bde
   . . .
   172.17.0.5  webdb 6e5cdeb2d300 db

.. You can see two relevant host entries. The first is an entry for the web container that uses the Container ID as a host name. The second entry uses the link alias to reference the IP address of the db container. In addition to the alias you provide, the linked container’s name--if unique from the alias provided to the --link parameter--and the linked container’s hostname will also be added in /etc/hosts for the linked container’s IP address. You can ping that host now via any of these entries:

関係あるホスト２つのエントリが見えます。１行めエントリは、 ``web`` コンテナのものであり、コンテナ ID がホスト名として使われています。２つめのエントリは ``db`` コンテナのものであり、IP アドレスの参照にエイリアスが使われています。エイリアスの指定に加えて、もし ``--link`` パラメータで指定したエイリアスがユニークであれば、リンクされるコンテナのホスト名もまた ``/etc/hosts`` でコンテナの IP アドレスをリンクします。これでホスト上では、これらのエントリを通して ping できます。

.. code-block:: bash

   root@aed84ee21bde:/opt/webapp# apt-get install -yqq inetutils-ping
   root@aed84ee21bde:/opt/webapp# ping webdb
   PING webdb (172.17.0.5): 48 data bytes
   56 bytes from 172.17.0.5: icmp_seq=0 ttl=64 time=0.267 ms
   56 bytes from 172.17.0.5: icmp_seq=1 ttl=64 time=0.250 ms
   56 bytes from 172.17.0.5: icmp_seq=2 ttl=64 time=0.256 ms

..    Note: In the example, you’ll note you had to install ping because it was not included in the container initially.

.. note::

   この例で ``ping`` をインストールしているのは、コンテナの初期状態では入っていないためです。

.. Here, you used the ping command to ping the db container using its host entry, which resolves to 172.17.0.5. You can use this host entry to configure an application to make use of your db container.

これで、 ``db`` コンテナに対して ``ping`` コマンドを実行する時は、 hosts エントリにある ``172.17.0.5`` を名前解決して ping します。この hosts のエントリの設定を使えば、アプリケーションが ``db`` コンテナに接続する設定で使えます。

..    Note: You can link multiple recipient containers to a single source. For example, you could have multiple (differently named) web containers attached to your db container.

.. note::

   １つのソース・コンテナから、複数の送信先コンテナにリンクできます。例えば、複数の（異なった名前の）ウェブ・コンテナが、 ``db`` コンテナに接続できます。

.. If you restart the source container, the linked containers /etc/hosts files will be automatically updated with the source container’s new IP address, allowing linked communication to continue.

ソース・コンテナを再起動したら、リンクされたコンテナの ``/etc/hosts`` ファイルはソース・コンテナの IP アドレスを自動的に更新し、継続して通信できるようにします。

.. code-block:: bash

   $ docker restart db
   db
   $ docker run -t -i --rm --link db:db training/webapp /bin/bash
   root@aed84ee21bde:/opt/webapp# cat /etc/hosts
   172.17.0.7  aed84ee21bde
   . . .
   172.17.0.9  db

.. Related information

.. seealso:: 

   Legacy container links
      https://docs.docker.com/engine/userguide/networking/default_network/dockerlinks/
