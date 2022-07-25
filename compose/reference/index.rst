.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/
.. SOURCE:
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/reference/overview.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/index.md
.. check date: 2022/04/06
.. Commits on Dec 21, 2021 d8816a5b90ca6eca30ccb7099270a5b43e42bbb9
.. -----------------------------------------------------------------------------

.. Overview of docker-compose CLI

.. _overview-of-docker-compose-cli:

=======================================
docker-compose CLI 概要
=======================================

.. This page provides the usage information for the docker-compose Command.

.. Command options overview and help:
.. _docker-compose-command options overview and help:

コマンドオプションの概要とヘルプ
========================================


このページに掲載するのは ``docker-compose`` コマンドの使い方に関する情報です。

You can also see this information by running docker-compose --help from the command line.

この情報はコマンドライン上で ``docker-compose --help`` を使っても確認できます。


.. code-block:: bash

   Define and run multi-container applications with Docker.
   
   Usage:
     docker-compose [-f <arg>...] [--profile <name>...] [options] [COMMAND] [ARGS...]
     docker-compose -h|--help
   
   Options:
     -f, --file FILE             Specify an alternate compose file
                                 (default: docker-compose.yml)
     -p, --project-name NAME     Specify an alternate project name
                                 (default: directory name)
     --profile NAME              Specify a profile to enable
     --verbose                   Show more output
     --log-level LEVEL           DEPRECATED and not working from 2.0 - Set log level (DEBUG, INFO, WARNING, ERROR, CRITICAL)
     --no-ansi                   Do not print ANSI control characters
     -v, --version               Print version and exit
     -H, --host HOST             Daemon socket to connect to
   
     --tls                       Use TLS; implied by --tlsverify
     --tlscacert CA_PATH         Trust certs signed only by this CA
     --tlscert CLIENT_CERT_PATH  Path to TLS certificate file
     --tlskey TLS_KEY_PATH       Path to TLS key file
     --tlsverify                 Use TLS and verify the remote
     --skip-hostname-check       Don't check the daemon's hostname against the
                                 name specified in the client certificate
     --project-directory PATH    Specify an alternate working directory
                                 (default: the path of the Compose file)
     --compatibility             If set, Compose will attempt to convert deploy
                                 keys in v3 files to their non-Swarm equivalent
   
   Commands:
     build              Build or rebuild services
     bundle             Generate a Docker bundle from the Compose file
     config             Validate and view the Compose file
     create             Create services
     down               Stop and remove containers, networks, images, and volumes
     events             Receive real time events from containers
     exec               Execute a command in a running container
     help               Get help on a command
     images             List images
     kill               Kill containers
     logs               View output from containers
     pause              Pause services
     port               Print the public port for a port binding
     ps                 List containers
     pull               Pull service images
     push               Push service images
     restart            Restart services
     rm                 Remove stopped containers
     run                Run a one-off command
     scale              Set number of containers for a service
     start              Start services
     stop               Stop services
     top                Display the running processes
     unpause            Unpause services
     up                 Create and start containers
     version            Show the Docker-Compose ve

.. You can use Docker Compose binary, docker-compose [-f <arg>...] [options] [COMMAND] [ARGS...], to build and manage multiple services in Docker containers.

Docker コンテナで複数のサービスを構築・管理するには、 Docker Compose のバイナリを使い、 ``docker-compose [-f <arg>...] [options] [COMMAND] [ARGS...]`` のようにして実行できます。

.. Use -f to specify name and path of one or more Compose files
.. _use--f-to-specify-name-and-path-of-one-or-more-compose-files:

``-f`` を使い、Compose ファイルの名前とパスを指定
==================================================

.. Use the -f flag to specify the location of a Compose configuration file. 

Compose 設定ファイルの場所を指定するには、 ``-f`` フラグを使います。

.. Specifying multiple Compose files
.. _specifying-multiple-compose-files:

複数の Compose ファイル指定
------------------------------
.. You can supply multiple -f configuration files. When you supply multiple files, Compose combines them into a single configuration. Compose builds the configuration in the order you supply the files. Subsequent files override and add to their predecessors.

複数の ``-f`` 設定ファイルを指定できます。複数のファイルを指定したら、Compose は１つの設定ファイルに連結します。Compose はファイルを指定した順番で構築します。後に続くファイルは、既に実行したものを上書き・追加します。

.. For example, consider this command line:

たとえば、次のようなコマンドラインを考えます。

.. code-block:: bash

   $ docker-compose -f docker-compose.yml -f docker-compose.admin.yml run backup_db`

.. The docker-compose.yml file might specify a webapp service.

``docker-compose.yml`` ファイルは ``webapp`` サービスを指定しています。

.. code-block:: yaml

   webapp:
     image: examples/web
     ports:
       - "8000:8000"
     volumes:
       - "/data"

.. If the docker-compose.admin.yml also specifies this same service, any matching fields will override the previous file. New values, add to the webapp service configuration.

また、 ``docker-compose.admin.yml`` ファイルで同じサービスを指定したら、以前のファイルで指定した同じフィールドの項目があれば、それを上書きします。新しい値があれば、 ``webapp`` サービスの設定に追加します。

.. code-block:: yaml

   webapp:
     build: .
     environment:
       - DEBUG=1

.. When you use multiple Compose files, all paths in the files are relative to the first configuration file specified with -f. You can use the --project-directory option to override this base path.

複数の Compose ファイルを指定する場合は、全てのパスは、1番目に ``-f`` で指定した設定ファイルからの相対パスです。この基準となるパスを上書きするには ``--project-directory`` オプションが使えます。

.. Use a -f with - (dash) as the filename to read the configuration from stdin. When stdin is used all paths in the configuration are relative to the current working directory.

``-f`` に ``-`` （ダッシュ）をファイル名として指定すると、標準入力から設定を読み込みます。設定に標準入力を使う場合のパスは、現在の作業用ディレクトリからの相対パスとなります。

.. The -f flag is optional. If you don’t provide this flag on the command line, Compose traverses the working directory and its parent directories looking for a docker-compose.yml and a docker-compose.override.yml file. You must supply at least the docker-compose.yml file. If both files are present on the same directory level, Compose combines the two files into a single configuration.

``-f`` フラグはオプションです。コマンドラインでこのフラグを指定しなければ、Compose は現在の作業用ディレクトリと ``docker-compose.yml`` ファイルと ``docker-compose.override.yml`` ファイルのサブディレクトリを探します。もし、２つのファイルが同じディレクトリ階層にある場合、Compose は2つのファイルを1つの設定ファイルに連結します。

.. The configuration in the docker-compose.override.yml file is applied over and in addition to the values in the docker-compose.yml file.

この時、 ``docker-compose.yml`` ファイルにある値は、 ``docker-compose.override.yml`` ファイルで設定し値で上書きします。

.. Specifying a path to a single Compose file
.. _specifying-a-path-to-a-single-compose-file:

1つの Compose ファイルのパスを指定
----------------------------------------

.. You can use the -f flag to specify a path to a Compose file that is not located in the current directory, either from the command line or by setting up a COMPOSE_FILE environment variable in your shell or in an environment file.

現在のディレクトリに存在しない Compose ファイルのパスは指定可能です。そのためには、コマンドラインで ``-f`` フラグを使い指定するか、あるいは、シェル上の :ref:`COMPOSE_FILE 環境変数 <envvars_compose_file>` もしくは環境変数ファイルで指定するかのどちらかです。

.. For an example of using the -f option at the command line, suppose you are running the Compose Rails sample, and have a docker-compose.yml file in a directory called sandbox/rails. You can use a command like docker-compose pull to get the postgres image for the db service from anywhere by using the -f flag as follows: docker-compose -f ~/sandbox/rails/docker-compose.yml pull db

コマンドラインで ``-f`` オプションを使う例として、 :doc:`Compose Rails サンプル </samples/rails>` を使うと仮定すると、 ``docker-compose.yml`` ファイルは ``sandbox/rails`` という名前のディレクトリにあります。 :doc:`docker-compose pull` のようなコマンドを使い、 ``db`` サービス用の postgres イメージを何らかの場所から取得するには、 ``-f``` フラグを次のように使います。 ``docker-compose -f ~/sandbox/rails/docker-compose.yml pull db``

.. Here’s the full example:

以下は、サンプルの全体です。

.. code-block:: bash

   $ docker-compose -f ~/sandbox/rails/docker-compose.yml pull db
   Pulling db (postgres:latest)...
   latest: Pulling from library/postgres
   ef0380f84d05: Pull complete
   50cf91dc1db8: Pull complete
   d3add4cd115c: Pull complete
   467830d8a616: Pull complete
   089b9db7dc57: Pull complete
   6fba0a36935c: Pull complete
   81ef0e73c953: Pull complete
   338a6c4894dc: Pull complete
   15853f32f67c: Pull complete
   044c83d92898: Pull complete
   17301519f133: Pull complete
   dcca70822752: Pull complete
   cecf11b8ccf3: Pull complete
   Digest: sha256:1364924c753d5ff7e2260cd34dc4ba05ebd40ee8193391220be0f9901d4e1651
   Status: Downloaded newer image for postgres:latest

.. Use -p to specify a project name
``-p`` を使いプロジェクト名を指定
========================================

.. Each configuration has a project name. If you supply a -p flag, you can specify a project name. If you don’t specify the flag, Compose uses the current directory name. See also the COMPOSE_PROJECT_NAME environment variable.

各設定ファイルはプロジェクト名を持ちます。 ``-p`` フラグを追加すると、プロジェクト名を指定できます。このフラグを指定しなければ、Compose は現在のディレクトリ名をプロジェクト名として使います。 詳細は ``COMPOSE_PROJECT`` :ref:`環境変数 <compose-project-name>` をご覧ください。

.. Use --profile to specify one or more active profiles
.. _use---profile-to-specify-one-or-more-active-profiles:

``--profile`` を使い1つまたは複数のアクティブなプロファイルを指定
======================================================================

.. Calling docker-compose --profile frontend up will start the services with the profile frontend and services without specified profiles. You can also enable multiple profiles, e.g. with docker-compose --profile frontend --profile debug up the profiles frontend and debug will be enabled.

``docker-compose --profile frontend up `` を呼び出すと、プロファイル ``frontend`` のサービスを起動し、プロファイルの指定が無いサービスも起動します。また、複数のプロファイル指定も可能であり、たとえば ``docker-compose --profile frontend --profile debug up`` であれば ``frontend`` と ``debug`` を有効化します。

.. See also Using profiles with Compose and the COMPOSE_PROFILES environment variable.

:doc:`/compose/profiles` と :ref:`COMPOSE_PROFILES 環境変数 <compose_profiles>` をご覧ください。

..  Set up environment variables
.. _compose_set-up-environment-variables:

環境変数のセットアップ
==============================

.. You can set environment variables for various docker-compose options, including the -f and -p flags.

``-f`` と ``-p`` フラグを含む様々な ``docker-compose`` オプション用の :doc:`環境変数 <envvars>` を指定できます。

.. For example, the COMPOSE_FILE environment variable relates to the -f flag, and COMPOSE_PROJECT_NAME environment variable relates to the -p flag.

たとえば、 ``-f`` フラグに関係する :ref:`COMPOSE_FILE 環境変数 <envvars-compose_file>` や、 ``-p`` フラグに関係する :ref:`COMPOSE_PROJECT_NAME 閑居変数 <compose_project_name>` です。

.. Also, you can set some of these variables in an environment file.

また、各環境変数は :doc:`環境変数用のファイル </compose/env-file>` でも設定できます。

.. Where to go next
次に読む文章
====================

..    CLI environment variables
    Declare default environment variables in file

* :doc:`CLI 環境変数 <envvars>`
* :doc:`デフォルトの環境変数をファイルで宣言 </compose/env-file>`

.. seealso:: 

   Overview of docker-compose CLI
      https://docs.docker.com/compose/reference/
