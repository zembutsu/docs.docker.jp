.. -*- coding: utf-8 -*-
.. https://docs.docker.com/compose/reference/docker-compose/
.. doc version: 1.9
.. check date: 2016/01/18
.. -----------------------------------------------------------------------------

.. docker-compose Command

.. _docker-compose-command:

=======================================
docker-compose コマンド
=======================================

.. code-block:: bash

   Usage:
     docker-compose [-f=<arg>...] [options] [COMMAND] [ARGS...]
     docker-compose -h|--help
   
   Options:
     -f, --file FILE           Specify an alternate compose file (default: docker-compose.yml)
     -p, --project-name NAME   Specify an alternate project name (default: directory name)
     --verbose                 Show more output
     -v, --version             Print version and exit
   
   Commands:
     build              Build or rebuild services
     help               Get help on a command
     kill               Kill containers
     logs               View output from containers
     pause              Pause services
     port               Print the public port for a port binding
     ps                 List containers
     pull               Pulls service images
     restart            Restart services
     rm                 Remove stopped containers
     run                Run a one-off command
     scale              Set number of containers for a service
     start              Start services
     stop               Stop services
     unpause            Unpause services
     up                 Create and start containers
     migrate-to-labels  Recreate containers to add labels
     version            Show the Docker-Compose version information

.. The Docker Compose binary. You use this command to build and manage multiple services in Docker containers.

``docker-compose`` は Docker Compose のバイナリです。このコマンドを使い Docker コンテナ上の複数のサービスを管理します。

.. Use the -f flag to specify the location of a Compose configuration file. You can supply multiple -f configuration files. When you supply multiple files, Compose combines them into a single configuration. Compose builds the configuration in the order you supply the files. Subsequent files override and add to their successors.

Compose 設定ファイルの場所を指定するには、 ``-f`` フラグを使います。複数の ``-f`` 設定ファイルを指定できます。複数のファイルをしていすると、Compose は１つの設定ファイルに連結します。Compose はファイルを指定した順番で構築します。後に続くファイルは、既に実行したものを上書き・追加します。

.. For example, consider this command line:

例えば、次のようなコマンドラインを考えます。

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

また、 ``docker-compose.admin.yml`` ファイルで同じサービスを指定すると、以前のファイルで指定した同じフィールドの項目があれば、それを上書きします。新しい値があれば、 ``webapp`` サービスの設定に追加します。

.. code-block:: yaml

   webapp:
     build: .
     environment:
       - DEBUG=1

.. Use a -f with - (dash) as the filename to read the configuration from stdin. When stdin is used all paths in the configuration are relative to the current working directory.

``-f`` に ``-`` （ダッシュ）をファイル名として指定すると、標準入力から設定を読み込みます。設定に標準入力を使う場合のパスは、現在の作業用ディレクトリからの相対パスとなります。

.. The -f flag is optional. If you don’t provide this flag on the command line, Compose traverses the working directory and its subdirectories looking for a docker-compose.yml and a docker-compose.override.yml file. You must supply at least the docker-compose.yml file. If both files are present, Compose combines the two files into a single configuration. The configuration in the docker-compose.override.yml file is applied over and in addition to the values in the docker-compose.yml file.

``-f`` フラグはオプションです。コマンドラインでこのフラグを指定しなければ、Compose は現在の作業用ディレクトリと ``docker-compose.yml`` ファイルと ``docker-compose.override.yml`` ファイルのサブディレクトリを探します。もし、２つのファイルが指定されると、１つの設定ファイルに連結します。 このとき、 ``docker-compose.yml`` ファイルにある値は、 ``docker-compose.override.yml`` ファイルで設定された値で上書きされます。

.. See also the COMPOSE_FILE environment variable.

詳しくは ``COMPOSE`` :ref:`環境変数 <compose-file>` をご覧ください。

.. Each configuration has a project name. If you supply a -p flag, you can specify a project name. If you don’t specify the flag, Compose uses the current directory name. See also the COMPOSE_PROJECT_NAME environment variable

各設定ファイルはプロジェクト名を持っています。 ``-p`` フラグでプロジェクト名を指定できます。フラグを指定しなければ、Compose は現在のディレクトリの名前を使います。詳細は ``COMPOSE_PROJECT`` :ref:`環境変数 <compose-project-name>` をご覧ください。

.. Where to go next

次はどこへ
==========

..    CLI environment variables
    Command line reference

* :doc:`CLI 環境変数 </compose/reference/overview>`
* :doc:`コマンドライン・リファレンス </compose/reference/index>`
