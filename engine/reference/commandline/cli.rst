.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/cli/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/cli.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/cli.md
.. check date: 2016/06/14
.. Commits on Mar 12, 2016 219e5fdda36a18104f7593da9ed8ca097a60aab3
.. -------------------------------------------------------------------

.. Use the Docker command line

.. _user-the-docker-command-line:

=======================================
Docker コマンドラインを使う
=======================================

.. To list available commands, either run docker with no parameters or execute docker help:

利用可能なコマンドを確認するには、 ``docker`` にパラメータを付けずに実行するか、``docker help`` を実行します。

.. code-block:: bash

   $ docker
     Usage: docker [OPTIONS] COMMAND [arg...]
            docker daemon [ --help | ... ]
            docker [ --help | -v | --version ]
   
       -H, --host=[]: The socket(s) to talk to the Docker daemon in the format of tcp://host:port/path, unix:///path/to/socket, fd://* or fd://socketfd.
   
     A self-sufficient runtime for Linux containers.
   
     ...

.. Depending on your Docker system configuration, you may be required to preface each docker command with sudo. To avoid having to use sudo with the docker command, your system administrator can create a Unix group called docker and add users to it.

Docker のシステム設定によっては、各 ``docker`` コマンドの前に ``sudo`` を付ける必要があるかもしれません。 ``docker`` コマンドを実行する度に ``sudo`` を実行しないようするには、システム管理者に ``docker`` という Unix グループの作成を、そこへのユーザの追加を依頼ください。

.. For more information about installing Docker or sudo configuration, refer to the installation instructions for your operating system.

Docker のインストールや ``sudo`` 設定については、各オペレーティング・システム向けの :doc:`インストール方法 </engine/installation/index>` をご覧ください。

.. Environment variables

.. _environment-variables-cli:

環境変数
====================

.. For easy reference, the following list of environment variables are supported by the docker command line:

簡単に利用できるように、 ``docker`` コマンドラインは以下の環境変数をサポートしています。

..    DOCKER_CONFIG The location of your client configuration files.
    DOCKER_CERT_PATH The location of your authentication keys.
    DOCKER_DRIVER The graph driver to use.
    DOCKER_HOST Daemon socket to connect to.
    DOCKER_NOWARN_KERNEL_VERSION Prevent warnings that your Linux kernel is unsuitable for Docker.
    DOCKER_RAMDISK If set this will disable ‘pivot_root’.
    DOCKER_TLS_VERIFY When set Docker uses TLS and verifies the remote.
    DOCKER_CONTENT_TRUST When set Docker uses notary to sign and verify images. Equates to --disable-content-trust=false for build, create, pull, push, run.
    DOCKER_CONTENT_TRUST_SERVER The URL of the Notary server to use. This defaults to the same URL as the registry.
    DOCKER_TMPDIR Location for temporary Docker files.

* ``DOCKER_CONFIG`` クライアントの設定ファイルの場所。
* ``DOCKER_CERT_PATH`` 認証鍵ファイルの場所。
* ``DOCKER_DRIVER`` 使用するグラフドライバ。
* ``DOCKER_HOST`` デーモンのソケット接続先。
* ``DOCKER_NOWARN_KERNEL_VERSION`` Docker に対応していない Linux カーネルで警告を出さない。
* ``DOCKER_RAMDISK`` 'pivot_root' を無効に設定。
* ``DOCKER_TLS_VERIFY`` Docker で TLS とリモート認証を使う。
* ``DOCKER_CONTENT_TRUST`` Docker でイメージの署名・確認用のために Notary 使用時に設定。これは、build、create、pull、push、run で ``--disable-content-trust=false`` を実行するのと同等
* ``DOCKER_CONTENT_TRUST_SERVER`` Notary サーバが使う URL  を指定。デフォルトはレジストリと同じ URL 。
* ``DOCKER_TMPDIR`` 一時 Docker ファイルの場所。

.. Because Docker is developed using ‘Go’, you can also use any environment variables used by the ‘Go’ runtime. In particular, you may find these useful:

Docker は「Go」言語で開発されているので、「Go」ランタイムが利用する環境変数も使えます。特に次のものは便利です。

* ``HTTP_PROXY``
* ``HTTPS_PROXY``
* ``NO_PROXY``

.. These Go environment variables are case-insensitive. See the Go specification for details on these variables.

これら Go 言語の環境変数は大文字と小文字を区別しません。変数の詳細については `Go 言語の仕様 <http://golang.org/pkg/net/http/>`_ をご確認ください。

.. Configuration files

.. _configuration-files:

設定ファイル
====================

.. By default, the Docker command line stores its configuration files in a directory called .docker within your HOME directory. However, you can specify a different location via the DOCKER_CONFIG environment variable or the --config command line option. If both are specified, then the --config option overrides the DOCKER_CONFIG environment variable. For example:

Docker コマンドラインは、ホームディレクトリ ``$HOME`` にある ``.docker`` ディレクトリ内に保管されている設定ファイルを、デフォルトで使います。しかし、 ``DOCKER_CONFIG`` 環境変数や ``--config`` コマンドライン・オプションを使い、異なった場所を指定できます。両方が指定された場合は ``--config`` オプションが ``DOCKER_CONFIG`` 環境変数を上書きします。例：

.. code-block:: bash

   docker --config ~/testconfigs/ ps

.. Instructs Docker to use the configuration files in your ~/testconfigs/ directory when running the ps command.

``ps`` コマンドの実行時、 ``~/testconfigs/`` ディレクトリにある設定ファイルで Docker に命令します。

.. Docker manages most of the files in the configuration directory and you should not modify them. However, you can modify the config.json file to control certain aspects of how the docker command behaves.

Docker は設定ディレクトリにある大部分のファイルを管理していますので、これらを自分で変更すべきではありません。しかし、 ``docker`` コマンドの居津を制御するため、 ``config.json`` を *編集できます* 。

.. Currently, you can modify the docker command behavior using environment variables or command-line options. You can also use options within config.json to modify some of the same behavior. When using these mechanisms, you must keep in mind the order of precedence among them. Command line options override environment variables and environment variables override properties you specify in a config.json file.

現在、 ``docker`` コマンドの挙動を環境変数かコマンドラインのオプションで変更可能です。あるいは、オプションとして ``config.json`` を使い、同じように挙動を設定できます。これらの仕組みを使う場合は、優先順位に気を付ける必要があります。コマンドラインのオプションは環境変数で上書きされ、環境変数は ``config.json`` ファイルで指定した項目に上書きされます。

.. The config.json file stores a JSON encoding of several properties:

``config.json`` ファイルは複数の属性  JSON エンコーディングで記述します。

.. The property HttpHeaders specifies a set of headers to include in all messages sent from the Docker client to the daemon. Docker does not try to interpret or understand these header; it simply puts them into the messages. Docker does not allow these headers to change any headers it sets for itself.

``HttpHeader`` 属性は、Docker クライアントがデーモンに対して送信するとき、全てのメッセージに含めるヘッダを指定します。Docker は、これらのヘッダを解釈したり理解しようとしません。つまり、単純にメッセージの中に追加するだけです。Docker は設定したヘッダ自身に対する変更を許可しません。

.. The property psFormat specifies the default format for docker ps output. When the --format flag is not provided with the docker ps command, Docker’s client uses this property. If this property is not set, the client falls back to the default table format. For a list of supported formatting directives, see the Formatting section in the docker ps documentation

``psFormat`` 属性は ``docker ps`` 出力のデフォルトの出力フォーマットを指定します。 ``docker ps`` コマンドで ``--format`` フラグが指定されなければ、Docker クライアントはこの属性を使います。この属性が設定されなければ、クライアントはデフォルトの表フォーマットに戻ります。サポートされている形式を確認するには、 ``docker ps`` :doc:`ドキュメントにあるフォーマットのセクション <ps>` をご覧ください。

.. Once attached to a container, users detach from it and leave it running using the using CTRL-p CTRL-q key sequence. This detach key sequence is customizable using the detachKeys property. Specify a <sequence> value for the property. The format of the <sequence> is a comma-separated list of either a letter [a-Z], or the ctrl- combined with any of the following:

コンテナにアタッチ後は、 ``CTRL-p CTRL-q`` キー・シーケンスで使ってデタッチできます。このデタッチ用キー・シーケンスは ``detachKeys`` 属性を使ってカスタマイズできます。カスタマイズでは ``<シーケンス>`` 値の属性を指定します。 ``<シーケンス>`` の書式は [a-Z] までの文字列をカンマ区切りにしたリストにするか、 ``ctrl-`` に以下のいずれかを組み合わせます。

..    a-z (a single lowercase alpha character )
    @ (at sign)
    [ (left bracket)
    \\ (two backward slashes)
    _ (underscore)
    ^ (caret)

* ``a-z`` （小文字のアルファベット文字列）
* ``@`` （アット記号）
* ``[`` （左かっこ）
* ``\\`` （２つのバックスラッシュ）
* ``_`` （アンダースコア）
* ``^`` （キャレット）

.. Your customization applies to all containers started in with your Docker client. Users can override your custom or the default key sequence on a per-container basis. To do this, the user specifies the --detach-keys flag with the docker attach, docker exec, docker run or docker start command.

Docker クライアントで起動するコンテナ全てにカスタマイズが適用されます。ユーザはコンテナごとにデフォルトのキー・シーケンスを変更可能です。ユーザが指定するには、 ``--detach-keys`` フラグを ``docker attach`` 、 ``docker exec`` 、 ``docker run`` 、 ``docker start`` コマンドで使います。

.. The property imagesFormat specifies the default format for docker images output. When the --format flag is not provided with the docker images command, Docker’s client uses this property. If this property is not set, the client falls back to the default table format. For a list of supported formatting directives, see the Formatting section in the docker images documentation

``imageFormat`` 属性は ``docker ps`` 出力のデフォルトの出力フォーマットを指定します。 ``docker images`` コマンドで ``--format`` フラグが指定されなければ、Docker クライアントはこの属性を使います。この属性が設定されなければ、クライアントはデフォルトの表フォーマットに戻ります。サポートされている形式を確認するには、 ``docker images`` :doc:`ドキュメントにあるフォーマットのセクション <images>` をご覧ください。

.. Following is a sample config.json file:

以下は ``config.json`` ファイルの記述例です：

.. code-block:: json

   {
     "HttpHeaders": {
       "MyHeader": "MyValue"
     },
     "psFormat": "table {{.ID}}\\t{{.Image}}\\t{{.Command}}\\t{{.Labels}}"
   }

.. Notary

Notary
----------

.. If using your own notary server and a self-signed certificate or an internal Certificate Authority, you need to place the certificate at tls/<registry_url>/ca.crt in your docker config directory.

自身で Notary サーバを使っている場合で、もしも自己証明の証明書や、内部の証明機関を使っているのであれば、docker 設定ディレクトリにある ``tls/<レジストリのURL>/ca.crt`` 証明書を置き換える必要があります。

.. Alternatively you can trust the certificate globally by adding it to your system’s list of root Certificate Authorities.

あるいは、自分の証明書を信頼できるようにするためには、自分のシステム上のルート証明機関一覧に証明書を追加する方法もあります。

.. Help

.. _help:

ヘルプ
==========

.. To list the help on any command just execute the command, followed by the --help option.

ヘルプの一覧を表示するには、単純にコマンドを実行するか、 ``--help`` オプションを付けます。

.. code-block:: bash

   $ docker run --help
   
   Usage: docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
   
   Run a command in a new container
   
     -a, --attach=[]            Attach to STDIN, STDOUT or STDERR
     --cpu-shares=0             CPU shares (relative weight)
   ...

.. Option types

.. _option-types:

オプションの種類
====================

.. Single character command line options can be combined, so rather than typing docker run -i -t --name test busybox sh, you can write docker run -it --name test busybox sh.

１文字のコマンドラインのオプションは、連結できます。 ``docker run -i -t --name test busybox sh`` は、 ``docker run -it -name test busybox sh`` に書き換えられます。

.. Boolean

.. _boolean:

ブール値
----------

.. Boolean options take the form -d=false. The value you see in the help text is the default value which is set if you do not specify that flag. If you specify a Boolean flag without a value, this will set the flag to true, irrespective of the default value.

ブール値のオプションとは ``-d=false`` のような形式です。何らかのフラグを設定 **しない** 場合のデフォルト値は、ヘルプテキストで確認できます。ブール値にフラグ値を指定しなければ、デフォルト値に関係なくフラグは ``true`` になります。

.. For example, running docker run -d will set the value to true, so your container will run in “detached” mode, in the background.

例えば、 ``docker run -d`` を実行すると、値は ``true`` になります。そのため、コンテナは「デタッチド」モードとしてバックグラウンドで動作します。

.. Options which default to true (e.g., docker build --rm=true) can only be set to the non-default value by explicitly setting them to false:

オプションのデフォルトは ``true`` （例： ``docker build --rm=true`` ）ですが、デフォルトではない値を指定するには ``false`` を明示します。

.. code-block:: bash

   $ docker build --rm=false .

.. Multi

.. _multi:

複数回の指定
--------------------

.. You can specify options like -a=[] multiple times in a single command line, for example in these commands:

``-a=[]`` のようなオプションは、コマンドライン上で複数回使えます。例えば、次のようなコマンドです。

.. code-block:: bash

   $ docker run -a stdin -a stdout -i -t ubuntu /bin/bash
   $ docker run -a stdin -a stdout -a stderr ubuntu /bin/ls

.. Sometimes, multiple options can call for a more complex value string as for -v:

オプションによっては、 ``-v`` のように複雑になる場合もあります。

.. code-block:: bash

   $ docker run -v /host:/container example/mysql

..    Note: Do not use the -t and -a stderr options together due to limitations in the pty implementation. All stderr in pty mode simply goes to stdout.

.. note::

   ``pty`` 実装に限界があるため、 ``-t`` と ``-a stderr`` オプションを同時に使わないでください。 ``pty`` モードの ``stderr`` （標準エラー出力）は、単純に ``stdout`` （標準出力）になります。

..  Strings and Integers

.. _strings-and-integers:

文字列と整数
--------------------

.. Options like --name="" expect a string, and they can only be specified once. Options like -c=0 expect an integer, and they can only be specified once.

``--name=""`` のように文字が含まれるオプションは、１つしか指定できません。 ``-c=0`` のように整数の場合も、１つしか指定できません。


