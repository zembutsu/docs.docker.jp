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
コンテナ・リンク機能（古い機能）
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The information in this section explains legacy container links within the Docker default `bridge` network which is created automatically when you install Docker.

ここでは古い機能であるコンテナ・リンクについて説明します。
これは Docker のデフォルトである ``bridge`` ネットワーク内にあるもので、この ``bridge`` ネットワークは Docker をインストールした際に自動的に生成されます。

.. Before the [Docker networks feature](/engine/userguide/networking/index.md), you could use the
   Docker link feature to allow containers to discover each other and securely
   transfer information about one container to another container. With the
   introduction of the Docker networks feature, you can still create links but they
   behave differently between default `bridge` network and
   [user defined networks](/engine/userguide/networking/work-with-networks.md#linking-containers-in-user-defined-networks).

:doc:`Docker のネットワーク機能 </engine/userguide/networking/index>` が提供される以前は、Docker のリンク機能によって複数のコンテナが互いを検出し、一方から他方への情報送信を安全に行うようにしていました。
Docker のネットワーク機能が導入されてからも、リンクを生成することはできます。
ただしデフォルトの ``bridge`` ネットワークであるか、:ref:`ユーザ定義のネットワーク <linking-containers-in-user-defined-networks>` であるかによって、その動作は異なることになります。

.. This section briefly discusses connecting via a network port and then goes into
   detail on container linking in default `bridge` network.

この節においてはネットワークポートを通じてネットワークに接続する方法を簡単に説明した上で、デフォルトの ``bridge`` ネットワーク内でのコンテナ・リンクを行う方法へ進んでいきます。

.. >**Warning**:
   >The `--link` flag is a deprecated legacy feature of Docker. It may eventually
   be removed. Unless you absolutely need to continue using it, we recommend that you use
   user-defined networks to facilitate communication between two containers instead of using
   `--link`. One feature that user-defined networks do not support that you can do
   with `--link` is sharing environmental variables between containers. However,
   you can use other mechanisms such as volumes to share environment variables
   between containers in a more controlled way.
   {:.warning}

.. warning::

   Docker の ``--link`` フラグは過去の機能です。
   そのうちに削除されるかもしれません。
   この機能を確実に必要としているのでなければ ``--link`` を使わず、2 つのコンテナ間の通信を実現するユーザ定義のネットワークを利用することをお勧めします。
   ``--link`` に存在していて、ユーザ定義のネットワークにない機能は、コンテナ間で環境変数を共有できる機能です。
   ただしボリュームのような別の機能を使えば、コンテナ間での環境変数の共有は、より制御しやすく利用できます。

.. ## Connect using network port mapping

.. _connect-using-network-port-mapping:

ネットワーク・ポート・マッピングを利用した接続
===============================================

.. Let's say you used this command to run a simple Python Flask application:

以下のコマンドによって Python Flask アプリケーションを起動しているとします。

..  $ docker run -d -P training/webapp python app.py
.. code-block:: bash

   $ docker run -d -P training/webapp python app.py

.. > **Note**:
   > Containers have an internal network and an IP address.
   > Docker can have a variety of network configurations. You can see more
   > information on Docker networking [here](/engine/userguide/networking/index.md).
.. note::

   コンテナには内部ネットワークと IP アドレスがあります。
   そして Docker にはさまざまなネットワーク設定方法があります。
   Docker のネットワーク機能の詳細は :doc:`こちら </engine/userguide/networking/index>` を参照してください。

.. When that container was created, the `-P` flag was used to automatically map
   any network port inside it to a random high port within an *ephemeral port
   range* on your Docker host. Next, when `docker ps` was run, you saw that port
   5000 in the container was bound to port 49155 on the host.

このコンテナの生成時には ``-P`` フラグが指定されているので、コンテナ内部のネットワークポートはすべて、Docker ホスト上の「エフェメラルポート」範囲内にあるランダムな高位ポートに自動的に割り当てられます。
その後に ``docker ps`` を実行すれば、コンテナ内の 5000 番ポートが、ホスト上の 49155 番ポートに割り当てられているのがわかります。

..  $ docker ps nostalgic_morse

    CONTAINER ID  IMAGE                   COMMAND       CREATED        STATUS        PORTS                    NAMES
    bc533791f3f5  training/webapp:latest  python app.py 5 seconds ago  Up 2 seconds  0.0.0.0:49155->5000/tcp  nostalgic_morse

.. code-block:: bash

   $ docker ps nostalgic_morse

   CONTAINER ID  IMAGE                   COMMAND       CREATED        STATUS        PORTS                    NAMES
   bc533791f3f5  training/webapp:latest  python app.py 5 seconds ago  Up 2 seconds  0.0.0.0:49155->5000/tcp  nostalgic_morse

.. You also saw how you can bind a container's ports to a specific port using
   the `-p` flag. Here port 80 of the host is mapped to port 5000 of the
   container:

またコンテナのポートを特定のポートに割り当てるには ``-p`` フラグを使えばよいことも、すでに見てきました。
以下はホストの 80 番ポートを、コンテナの 5000 番ポートに割り当てます。

..  $ docker run -d -p 80:5000 training/webapp python app.py

.. code-block:: bash

   $ docker run -d -p 80:5000 training/webapp python app.py

.. And you saw why this isn't such a great idea because it constrains you to
   only one container on that specific port.

ただしこれはあまり良い方法でないのは、すでにお分かりでしょう。
これでは、特定のポートを指定できるのが、ただ一つのコンテナでしかないからです。

.. Instead, you may specify a range of host ports to bind a container port to
   that is different than the default *ephemeral port range*:

上とは違って、コンテナ・ポートに対して、ホストのポート範囲を指定することができます。
この範囲は「エフェメラル・ポート」の範囲とは異なるものです。

..  $ docker run -d -p 8000-9000:5000 training/webapp python app.py

.. code-block:: bash

   $ docker run -d -p 8000-9000:5000 training/webapp python app.py

.. This would bind port 5000 in the container to a randomly available port
   between 8000 and 9000 on the host.

これによるとコンテナの 5000 番ポートは、ホスト上の 8000 から 9000 の中で利用可能なポートがランダムに選び出されます。

.. There are also a few other ways you can configure the `-p` flag. By
   default the `-p` flag will bind the specified port to all interfaces on
   the host machine. But you can also specify a binding to a specific
   interface, for example only to the `localhost`.

``-p`` フラグの設定方法には他にもいくつかあります。
デフォルトにおいて ``-p`` フラグは、ホストマシン上のすべてのインターフェースに対して、指定されたポートを割り当てます。
しかし特定のインターフェースに対しての割り当てを行うこともできます。
たとえば以下は ``loalhost`` にのみ割り当てる例です。

..  $ docker run -d -p 127.0.0.1:80:5000 training/webapp python app.py
.. code-block:: bash

   $ docker run -d -p 127.0.0.1:80:5000 training/webapp python app.py

.. This would bind port 5000 inside the container to port 80 on the
   `localhost` or `127.0.0.1` interface on the host machine.

上はコンテナ内の 5000 番ポートを、ホストマシン上の 80 番ポートに割り当てますが、これが行われるのは ``localhost`` つまり ``127.0.0.1`` インターフェースに対してのみです。

.. Or, to bind port 5000 of the container to a dynamic port but only on the
   `localhost`, you could use:

コンテナ内の 5000 番ポートを ``localhost`` 上の動的ポートに割り当てるなら、以下のようにします。

..  $ docker run -d -p 127.0.0.1::5000 training/webapp python app.py
.. code-block:: bash

   $ docker run -d -p 127.0.0.1::5000 training/webapp python app.py

.. You can also bind UDP ports by adding a trailing /udp. For example:

また、UDP ポートを割り当てたい場合は、最後に ``/udp`` を追加します。例えば、次のように実行します。

.. code-block:: bash

   $ docker run -d -p 127.0.0.1:80:5000/udp training/webapp python app.py

.. You also learned about the useful `docker port` shortcut which showed us the
   current port bindings. This is also useful for showing you specific port
   configurations. For example, if you've bound the container port to the
   `localhost` on the host machine, then the `docker port` output will reflect that.

便利なコマンド ``docker port`` についてはこれまでにも使ってきました。
これによって現時点でのポート割り当ての状況がすぐにわかります。
また特定のポートがどのように設定されているかがわかります。
たとえばコンテナの特定のポートを、ホストマシンの ``localhost`` に割り当てていたとします。
``docker port`` コマンドの出力には、そのことが示されます。

..  $ docker port nostalgic_morse 5000

    127.0.0.1:49155
.. code-block:: bash

   $ docker port nostalgic_morse 5000

   127.0.0.1:49155

.. > **Note**:
   > The `-p` flag can be used multiple times to configure multiple ports.
.. note::

   ``-p`` フラグは複数個の指定が可能であり、これにより複数ポートの指定を行うことができます。

.. ## Connect with the linking system

.. _connect-with-the-linking-system:

リンク・システムを用いた接続
==============================

.. > **Note**:
   > This section covers the legacy link feature in the default `bridge` network.
   > Please refer to [linking containers in user-defined networks](/engine/userguide/networking/work-with-networks.md#linking-containers-in-user-defined-networks)
   > for more information on links in user-defined networks.
.. note::

   この節ではデフォルトの ``bridge`` ネットワーク内の古い機能であるリンク機能について説明します。
   ユーザ定義ネットワーク上のリンクに関しては :ref:`ユーザ定義ネットワークでのコンテナのリンク <linking-containers-in-user-defined-networks>` を参照してください。

.. Network port mappings are not the only way Docker containers can connect to one
   another. Docker also has a linking system that allows you to link multiple
   containers together and send connection information from one to another. When
   containers are linked, information about a source container can be sent to a
   recipient container. This allows the recipient to see selected data describing
   aspects of the source container.

Docker コンテナを別のコンテナと接続させるのは、ネットワークのポート割り当てだけが唯一の方法ではありません。
Docker にはリンクシステム（linking system）があります。
このシステムにより複数のコンテナは互いにリンクすることが可能となり、接続情報をやり取りできるようになります。
複数のコンテナがリンクされていると、1 つのコンテナの情報を別のコンテナに送信することが可能です。
つまり情報を受け取る側のコンテナは、情報元のコンテナに関する情報の中から、必要な情報を取り出して見ることができます。

.. ### The importance of naming

.. _the-importance-of-naming:

名前づけの重要性
--------------------

.. To establish links, Docker relies on the names of your containers.
   You've already seen that each container you create has an automatically
   created name; indeed you've become familiar with our old friend
   `nostalgic_morse` during this guide. You can also name containers
   yourself. This naming provides two useful functions:

Docker がリンクを確立するためには、コンテナの名前が重要になります。
これまでコンテナを生成した際には、各コンテナに自動的に名前がつけられることを見てきました。
実際にここまでの説明においては、おなじみの ``nostalgic_morse`` という名前を用いています。
コンテナの名前は自由につけることができます。
名前をつけることによって、以下の 2 点が得られます。

.. 1. It can be useful to name containers that do specific functions in a way
      that makes it easier for you to remember them, for example naming a
      container containing a web application `web`.

1. コンテナが実現する特定の機能に合わせて、それを表わす名称にしておくと覚えやすく便利です。
   たとえばウェブ・アプリケーションを含んだコンテナには ``web`` という名前をつけます。

.. 2. It provides Docker with a reference point that allows it to refer to other
      containers, for example, you can specify to link the container `web` to container `db`.

2. 名前は、他のコンテナから参照させるための参照名となります。
   たとえば ``web`` コンテナからのリンクとして、``db`` という名前の別のコンテナを指定することができます。

.. You can name your container by using the `--name` flag, for example:

たとえば以下のようにして ``--name`` フラグを使ってコンテナに名前をつけることができます。

..  $ docker run -d -P --name web training/webapp python app.py
.. code-block:: bash

   $ docker run -d -P --name web training/webapp python app.py

.. This launches a new container and uses the `--name` flag to
   name the container `web`. You can see the container's name using the
   `docker ps` command.

上のコマンドは、新規にコンテナを起動させ、``--name`` フラグの情報からコンテナに ``web`` という名前をつけます。
``docker ps`` コマンドによってコンテナ名を確認することができます。

..  $ docker ps -l

    CONTAINER ID  IMAGE                  COMMAND        CREATED       STATUS       PORTS                    NAMES
    aed84ee21bde  training/webapp:latest python app.py  12 hours ago  Up 2 seconds 0.0.0.0:49154->5000/tcp  web
.. code-block:: bash

   $ docker ps -l

   CONTAINER ID  IMAGE                  COMMAND        CREATED       STATUS       PORTS                    NAMES
   aed84ee21bde  training/webapp:latest python app.py  12 hours ago  Up 2 seconds 0.0.0.0:49154->5000/tcp  web

.. You can also use `docker inspect` to return the container's name.

``docker inspect`` の結果からも、コンテナ名を得ることができます。

.. > **Note**:
   > Container names have to be unique. That means you can only call
   > one container `web`. If you want to re-use a container name you must delete
   > the old container (with `docker rm`) before you can create a new
   > container with the same name. As an alternative you can use the `--rm`
   > flag with the `docker run` command. This will delete the container
   > immediately after it is stopped.
.. note::

   コンテナ名は一意である必要があります。
   つまり ``web`` と呼ぶことができるコンテナは 1 つだけということです。
   コンテナ名を再利用したい場合は、それまでの古いコンテナを（``docker container rm`` を使って）削除する必要があります。
   その後であれば、同一名のコンテナを生成して利用することができます。
   これとは別に ``docker run`` の ``--rm`` フラグを利用する方法もあります。
   この方法ではそれまでのコンテナが停止され、すぐに削除されます。

.. ## Communication across links

.. _communication-across-links:

リンク間の通信
====================

.. Links allow containers to discover each other and securely transfer information
   about one container to another container. When you set up a link, you create a
   conduit between a source container and a recipient container. The recipient can
   then access select data about the source. To create a link, you use the `--link`
   flag. First, create a new container, this time one containing a database.

リンク機能によって複数のコンテナが互いを検出し、一方から他方への情報送信を安全に行うことができます。
リンク機能を設定すると、情報発信元のコンテナと受信先のコンテナの間に経路が生成されます。
そして受信先コンテナは、発信元コンテナに関する情報を選び出してアクセスできるようになります。
リンクの生成には `--link` フラグを使います。
そこで以下では、まず新たなコンテナを生成します。
今回はデータベースを含むコンテナーです。

..  $ docker run -d --name db training/postgres
.. code-block:: bash

   $ docker run -d --name db training/postgres

.. This creates a new container called `db` from the `training/postgres`
   image, which contains a PostgreSQL database.

上のコマンドは、PostgreSQL データベースを含む ``training/postgres`` イメージから ``db`` という新規のコンテナを生成します。

.. Now, you need to delete the `web` container you created previously so you can replace it
   with a linked one:

先ほど生成した ``web`` コンテナは、リンクされた状態のコンテナとするために、いったんここで削除する必要があります。

..  $ docker rm -f web
.. code-block:: bash

   $ docker rm -f web

.. Now, create a new `web` container and link it with your `db` container.

新たな ``web`` コンテナを生成して ``db`` コンテナにリンクします。

..  $ docker run -d -P --name web --link db:db training/webapp python app.py
.. code-block:: bash

   $ docker run -d -P --name web --link db:db training/webapp python app.py

.. This will link the new `web` container with the `db` container you created
   earlier. The `--link` flag takes the form:

これにより、新しい ``web`` コンテナが、直前に生成した ``db`` コンテナにリンクされます。
``--link`` フラグは以下のような書式です。

..  --link <name or id>:alias
.. code-block:: bash

   --link <name または id>:alias

.. Where `name` is the name of the container we're linking to and `alias` is an
   alias for the link name. You'll see how that alias gets used shortly.
   The `--link` flag also takes the form:

ここで ``name`` はリンクするコンテナの名前を指定します。
また ``alias`` はリンク名に対するエイリアス名の定義です。
このエイリアス名は簡単に利用することができます。
``--link`` フラグは以下の書式でも構いません。

..	--link <name or id>
.. code-block:: bash

   --link <name または id>

.. In which case the alias will match the name. You could have written the previous
   example as:

この場合、エイリアスはリンク名そのものになります。
先ほどの実行例は、以下のようにすることもできます。

..  $ docker run -d -P --name web --link db training/webapp python app.py
.. code-block:: bash

   $ docker run -d -P --name web --link db training/webapp python app.py

.. Next, inspect your linked containers with `docker inspect`:

次にリンクしたコンテナを ``docker inspect`` によって確認してみます。

..  {% raw %}
    $ docker inspect -f "{{ .HostConfig.Links }}" web

    [/db:/web/db]
    {% endraw %}
.. code-block:: bash

   $ docker inspect -f "{{ .HostConfig.Links }}" web

   [/db:/web/db]

.. You can see that the `web` container is now linked to the `db` container
   `web/db`. Which allows it to access information about the `db` container.

``web`` コンテナが ``db`` コンテナにリンクされ ``web/db`` となっているのがわかります。
これにより ``db`` コンテナに関する情報にアクセスできるようになりました。

.. So what does linking the containers actually do? You've learned that a link allows a
   source container to provide information about itself to a recipient container. In
   our example, the recipient, `web`, can access information about the source `db`. To do
   this, Docker creates a secure tunnel between the containers that doesn't need to
   expose any ports externally on the container; you'll note when we started the
   `db` container we did not use either the `-P` or `-p` flags. That's a big benefit of
   linking: we don't need to expose the source container, here the PostgreSQL database, to
   the network.

コンテナのリンク機能は実際には何をしているでしょう？
リンクを使うと、情報発信元となるコンテナそのものの情報を、受信先コンテナに提供できるということを、すでに学びました。
上の例においては情報を受け取るコンテナが ``web`` であり、情報元となる ``db`` の情報にアクセスできるというものです。
Docker はこのとき、コンテナ間にセキュアなトンネルを作り出します。
そこではコンテナから外部に向けてポートを公開する必要がないようにしています。
そもそも ``db`` コンテナを起動する際には、``-P`` フラグも ``-p`` フラグも使っていませんでした。
これこそがリンクシステムの優れたところです。
情報元となるコンテナ、つまり上の例では PostgreSQL データベースを、ネットワーク上に公開していなくても構わないということです。

.. Docker exposes connectivity information for the source container to the
   recipient container in two ways:

情報元のコンテナから受信先のコンテナに公開される接続情報は、以下の 2 つの手段を通じて受け渡されます。

.. * Environment variables,
   * Updating the `/etc/hosts` file.

* 環境変数
* ``/etc/hosts`` ファイルの更新

.. ### Environment variables

.. _environment-variables:

環境変数
----------

.. Docker creates several environment variables when you link containers. Docker
   automatically creates environment variables in the target container based on
   the `--link` parameters. It will also expose all environment variables
   originating from Docker from the source container. These include variables from:

コンテナをリンクすると、環境変数が数種類作り出されます。
Docker は ``--link`` パラメータに基づいて、対象とするコンテナ上に自動的に環境変数を作り出すものです。
また発信元コンテナからは、Docker がもともと提供している環境変数もすべて公開されています。
そういった環境変数は以下に基づくものです。

.. * the `ENV` commands in the source container's Dockerfile
   * the `-e`, `--env`, and `--env-file` options on the `docker run`
   command when the source container is started

* 情報元のコンテナにおける Dockerfile に記述された ``ENV`` コマンド
* 情報元のコンテナを ``docker run`` によって起動する際の、``-e``, ``--env``, ``--env-file`` オプション

.. These environment variables enable programmatic discovery from within the
   target container of information related to the source container.

このような環境変数があることによって、発信元コンテナに関する情報を、目的としているコンテナ内部においてプログラムレベルで検出できるようになります。

.. > **Warning**:
   > It is important to understand that *all* environment variables originating
   > from Docker within a container are made available to *any* container
   > that links to it. This could have serious security implications if sensitive
   > data is stored in them.
   {:.warning}
.. warning::

   コンテナ内の環境変数のうち Docker がもともと提供している環境変数はすべて、リンクしているどのコンテナからも利用可能である点を、十分に留意しておいてください。
   その環境変数の中に重要な機密情報が含まれていたら、重大なセキュリティ問題にもなります。

.. Docker sets an `<alias>_NAME` environment variable for each target container
   listed in the `--link` parameter. For example, if a new container called
   `web` is linked to a database container called `db` via `--link db:webdb`,
   then Docker creates a `WEBDB_NAME=/web/webdb` variable in the `web` container.

``--link`` パラメータに指定されたコンテナに対しては、``<alias>_NAME`` という名前の環境変数が定義されます。
たとえば ``web`` という名前の新たなコンテナが、``--link db:webdb`` という指定を通じてデータベースコンテナ ``db`` にリンクしているとします。
このとき ``web`` コンテナ内には ``WEBDB_NAME=/web/webdb`` という環境変数が生成されます。

.. Docker also defines a set of environment variables for each port exposed by the
   source container. Each variable has a unique prefix in the form:

さらに情報発信元となるコンテナが公開しているポートに対しても、環境変数が定義されます。
各変数には一意なプリフィックスがつけられます。

``<name>_PORT_<port>_<protocol>``

.. The components in this prefix are:

プリフィックスは以下のものから構成されます。

.. * the alias `<name>` specified in the `--link` parameter (for example, `webdb`)
   * the `<port>` number exposed
   * a `<protocol>` which is either TCP or UDP

* ``<name>``： ``--link`` パラメータによって指定されたエイリアス名。
  (たとえば ``webdb``)
* ``<port>``： 公開されているポート番号。
* ``<protocol>``： TCP、 UDP いずれかのプロトコル。

.. Docker uses this prefix format to define three distinct environment variables:

このプリフィックスの書式から、以下の 3 つの環境変数が定義されます。

.. * The `prefix_ADDR` variable contains the IP Address from the URL, for
   example `WEBDB_PORT_5432_TCP_ADDR=172.17.0.82`.
   * The `prefix_PORT` variable contains just the port number from the URL for
   example `WEBDB_PORT_5432_TCP_PORT=5432`.
   * The `prefix_PROTO` variable contains just the protocol from the URL for
   example `WEBDB_PORT_5432_TCP_PROTO=tcp`.

* ``prefix_ADDR`` 変数： URL に対する IP アドレス。
  たとえば ``WEBDB_PORT_5432_TCP_ADDR=172.17.0.82`` など。
* ``prefix_PORT`` 変数： URL に対するポート番号。
  たとえば ``WEBDB_PORT_5432_TCP_PORT=5432`` など。
* ``prefix_PROTO`` 変数： URL に対するプロトコル。
  たとえば ``WEBDB_PORT_5432_TCP_PROTO=tcp`` など。

.. If the container exposes multiple ports, an environment variable set is
   defined for each one. This means, for example, if a container exposes 4 ports
   that Docker creates 12 environment variables, 3 for each port.

コンテナが複数ポートを公開している場合は、個々のポートに対して環境変数が定義されます。
これはたとえば、コンテナが 4 つのポートを公開していたとすると、1 つのポートに対して 3 つの環境変数、つまり全部で 12 個の環境変数が定義されることになります。

.. Additionally, Docker creates an environment variable called `<alias>_PORT`.
   This variable contains the URL of the source container's first exposed port.
   The 'first' port is defined as the exposed port with the lowest number.
   For example, consider the `WEBDB_PORT=tcp://172.17.0.82:5432` variable. If
   that port is used for both tcp and udp, then the tcp one is specified.

さらに ``<alias>_PORT`` という環境変数も生成されます。
この変数には、発信元コンテナの一番初めの公開ポートを用いた URL が定義されます。
この「一番初めの」というのは、公開ポート番号の中で最も小さなものを指します。
たとえば ``WEBDB_PORT=tcp://172.17.0.82:5432`` という変数があったとして、このポートが tcp、udp の双方で利用されている場合、tcp が設定されます。

.. Finally, Docker also exposes each Docker originated environment variable
   from the source container as an environment variable in the target. For each
   variable Docker creates an `<alias>_ENV_<name>` variable in the target
   container. The variable's value is set to the value Docker used when it
   started the source container.

最後に、発信元コンテナにおいて Docker が元から定義している環境変数が、対象とするコンテナ上の環境変数として公開されます。
各変数に対しては、対象コンテナ上に ``<alias>_ENV_<name>`` という変数が生成されます。
この変数の値は、発信元コンテナが起動する際に、Docker が利用した値が設定されます。

.. Returning back to our database example, you can run the `env`
   command to list the specified container's environment variables.

データベースの例に戻ります。
``env`` コマンドを実行して、指定するコンテナ上の環境変数を一覧表示してみます。

.. ```
       $ docker run --rm --name web2 --link db:db training/webapp env
   
       . . .
       DB_NAME=/web2/db
       DB_PORT=tcp://172.17.0.5:5432
       DB_PORT_5432_TCP=tcp://172.17.0.5:5432
       DB_PORT_5432_TCP_PROTO=tcp
       DB_PORT_5432_TCP_PORT=5432
       DB_PORT_5432_TCP_ADDR=172.17.0.5
       . . .
   ```
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

.. You can see that Docker has created a series of environment variables with
   useful information about the source `db` container. Each variable is prefixed
   with
   `DB_`, which is populated from the `alias` you specified above. If the `alias`
   were `db1`, the variables would be prefixed with `DB1_`. You can use these
   environment variables to configure your applications to connect to the database
   on the `db` container. The connection will be secure and private; only the
   linked `web` container will be able to talk to the `db` container.

この出力から、情報元である ``db`` コンテナに関して必要となる情報が、環境変数としていくつも生成されているのがわかります。
各環境変数には ``DB_`` というプリフィックスがつけられていて、これは上で指定した ``alias`` から命名されたものです。
``alias`` を ``db1`` としていたら、環境変数のプリフィックスは ``DB1_`` になっていたはずです。
この環境変数を使えば、``db`` コンテナ上にあるデータベースに、アプリケーションから接続する設定を行うことができます。
その際の接続はセキュアでありプライベートなものです。
そしてリンクしている ``web`` コンテナだけが、``db`` コンテナとの通信を行うことができます。

.. ### Important notes on Docker environment variables

.. _important-notes-on-docker-environment-variables:

Docker 環境変数に関する重要事項
----------------------------------------

.. Unlike host entries in the [`/etc/hosts` file](#updating-the-etchosts-file),
   IP addresses stored in the environment variables are not automatically updated
   if the source container is restarted. We recommend using the host entries in
   `/etc/hosts` to resolve the IP address of linked containers.

``/etc/hosts`` :ref:`ファイル <updating-the-etchosts-file>` におけるホストの設定とは違って、環境変数内に保存された IP アドレスは、発信元のコンテナが再起動されたときに自動的に更新されません。
リンクされたコンテナの IP アドレスを取得するためには、``/etc/hosts`` に設定することをお勧めします。

.. These environment variables are only set for the first process in the
   container. Some daemons, such as `sshd`, will scrub them when spawning shells
   for connection.

こういった環境変数の設定は、そのコンテナの初期処理段階でのみ行われます。
デーモンの中には ``sshd`` などのように、接続を実現するために起動するシェルにおいて、そのような変数を破棄するものもあります。

.. ### Updating the `/etc/hosts` file

.. _updating-the-etchosts-file:

``/etc/hosts`` ファイルの更新
------------------------------

.. In addition to the environment variables, Docker adds a host entry for the
   source container to the `/etc/hosts` file. Here's an entry for the `web`
   container:

環境変数とは別に Docker は、発信元コンテナを示すホスト設定を ``/etc/hosts`` ファイルに加えます。
以下は ``web`` コンテナに対するホスト設定の例です。

..  $ docker run -t -i --rm --link db:webdb training/webapp /bin/bash

    root@aed84ee21bde:/opt/webapp# cat /etc/hosts

    172.17.0.7  aed84ee21bde
    . . .
    172.17.0.5  webdb 6e5cdeb2d300 db
.. code-block:: bash

   $ docker run -t -i --rm --link db:webdb training/webapp /bin/bash

   root@aed84ee21bde:/opt/webapp# cat /etc/hosts

   172.17.0.7  aed84ee21bde
   . . .
   172.17.0.5  webdb 6e5cdeb2d300 db

.. You can see two relevant host entries. The first is an entry for the `web`
   container that uses the Container ID as a host name. The second entry uses the
   link alias to reference the IP address of the `db` container. In addition to
   the alias you provide, the linked container's name--if unique from the alias
   provided to the `--link` parameter--and the linked container's hostname will
   also be added in `/etc/hosts` for the linked container's IP address. You can ping
   that host now via any of these entries:

上においては、関連する 2 つの設定を見ることができます。
1 つめは ``web`` コンテナに対する設定であり、ホスト名としてコンテナ ID が用いられています。
2 つめの設定では、``db`` コンテナの IP アドレスを参照する、リンク機能のエイリアスを用いています。
エイリアス名の他に、リンクされたコンテナ名も追加されています。
そして ``--link`` パラメータによって指定されたエイリアスとホスト名が異なっていれば、このホスト名も、``/etc/hosts`` 内のリンクされたコンテナの IP アドレスに対して追加されます。
設定項目の要素のどれを使っても ping を実行することができます。

..  root@aed84ee21bde:/opt/webapp# apt-get install -yqq inetutils-ping

    root@aed84ee21bde:/opt/webapp# ping webdb

    PING webdb (172.17.0.5): 48 data bytes
    56 bytes from 172.17.0.5: icmp_seq=0 ttl=64 time=0.267 ms
    56 bytes from 172.17.0.5: icmp_seq=1 ttl=64 time=0.250 ms
    56 bytes from 172.17.0.5: icmp_seq=2 ttl=64 time=0.256 ms
.. code-block:: bash

   root@aed84ee21bde:/opt/webapp# apt-get install -yqq inetutils-ping

   root@aed84ee21bde:/opt/webapp# ping webdb

   PING webdb (172.17.0.5): 48 data bytes
   56 bytes from 172.17.0.5: icmp_seq=0 ttl=64 time=0.267 ms
   56 bytes from 172.17.0.5: icmp_seq=1 ttl=64 time=0.250 ms
   56 bytes from 172.17.0.5: icmp_seq=2 ttl=64 time=0.256 ms

.. > **Note**:
   > In the example, you'll note you had to install `ping` because it was not included
   > in the container initially.
.. note::

   ここに示す例においては ``ping`` をインストールしています。
   このコンテナの初期状態ではインストールされていないためです。

.. Here, you used the `ping` command to ping the `db` container using its host entry,
   which resolves to `172.17.0.5`. You can use this host entry to configure an application
   to make use of your `db` container.

上では ``db`` コンテナに対しての ``ping`` コマンド実行において、``/etc/hosts`` の設定項目を利用しました。
そしてそれは ``172.17.0.5`` であることがわかりました。
このように ``/etc/hosts`` の設定項目を用いてアプリケーションを設定すれば、``db`` コンテナを利用することができます。

.. > **Note**:
   > You can link multiple recipient containers to a single source. For
   > example, you could have multiple (differently named) web containers attached to your
   >`db` container.
.. note::

   情報発信元となる 1 つのコンテナに対して、受信先となるコンテナを複数リンクすることができます。
   たとえば複数の（名前の異なる）ウェブ・コンテナを ``db`` コンテナにリンクすることもできます。

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
