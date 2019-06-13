.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/compose-file/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/compose-file.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/compose-file.md
.. check date: 2016/04/28
.. Commits on Apr 21, 2016 55fcd1c3e32ccbd71caa14462a6239d4bf7a1685
.. ----------------------------------------------------------------------------

.. Compose file reference

.. _compose-file-reference:

=======================================
Compose ファイル・リファレンス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The Compose file is a YAML file defining services, networks and volumes. The default path for a Compose file is ./docker-compose.yml.

Compose ファイルは `YAML <http://yaml.org/>`_ ファイルであり、 :ref:`サービス（services） <service-configuration-reference>` 、 :ref:`ネットワーク（networks） <network-configuration-reference>` 、 :ref:`ボリューム（volumes） <volume-configuration-reference>` を定義します。Compose ファイルのデフォルトのパスは ``./docker-compose.yml`` です。

.. A service definition contains configuration which will be applied to each container started for that service, much like passing command-line parameters to docker run. Likewise, network and volume definitions are analogous to docker network create and docker volume create.

サービスの定義では、各コンテナをサービスとして定義できます。このサービスを起動する時、コマンドラインの ``docker run`` のパラメータのような指定が可能です。同様に、ネットワークやボリュームの定義も ``docker network create`` や ``docker volume create`` と似ています。

.. As with docker run, options specified in the Dockerfile (e.g., CMD, EXPOSE, VOLUME, ENV) are respected by default - you don’t need to specify them again in docker-compose.yml.

``docker run`` では、 Dockerfile で指定したオプション（例： ``CMD`` 、 ``EXPOSE`` 、 ``VOLUME`` 、``ENV`` ）はデフォルトとして尊重されます。そのため、 ``docker-compose.yml`` で再び指定する必要はありません。

.. You can use environment variables in configuration values with a Bash-like ${VARIABLE} syntax - see variable substitution for full details.

Bash の ``${変数}`` の構文のように、環境変数を使って設定を行えます｡詳しくは :ref:`compose-file-variable-substitution` をご覧ください。

.. Service configuration reference

.. _service-configuration-reference:

サービス設定リファレンス
==============================

.. Note: There are two versions of the Compose file format -- version 1 (the legacy format, which does not support volumes or networks) and version 2 (the most up-to-date). For more information, see the Versioning section.

.. note::

   Compose ファイルの形式には、バージョン１（過去のフォーマットであり、ボリュームやネットワークをサポートしていません）とバージョン２（最新版）という２つのバージョンが存在します。詳しい情報は :ref:`バージョン <compose-file-versioning>` に関するドキュメントをご覧ください。

.. This section contains a list of all configuration options supported by a service definition.

（Docker Composeの）サービス定義用にサポートされている設定オプションの一覧を、このセクションで扱います。

.. build

.. _compose-file-build:

build
----------

.. Configuration options that are applied at build time.

構築時に適用するオプションを指定します。

.. build can be specified either as a string containing a path to the build context, or an object with the path specified under context and optionally dockerfile and args.

``build`` で指定できるのは、構築用コンテクストのパスを含む文字列だけでなく、 :ref:`context <compose-file-context>` の配下にある特定の物（オブジェクト）や、 :ref:`dockerfile <compose-file-dockerfile>` のオプションと :ref:`引数 <compose-file-args>` を指定できます。

.. code-block:: yaml

   build: ./dir
   
   build:
     context: ./dir
     dockerfile: Dockerfile-alternate
     args:
       buildno: 1

.. If you specify image as well as build, then Compose tags the built image with the tag specified in image:

``build`` だけでなく ``image`` も指定できます。 Compose は ``image`` で指定したタグを使い、構築したイメージをタグ付けします。

.. code-block:: yaml

   build: ./dir
   image: webapp

.. This will result in an image tagged webapp, built from ./dir.

これは ``./dir`` で構築したイメージを ``webapp`` としてタグ付けしています。

..    Note: In the version 1 file format, build is different in two ways:
        Only the string form (build: .) is allowed - not the object form.
        Using build together with image is not allowed. Attempting to do so results in an error.

.. note::

   :ref:`バージョン１のフォーマット <compose-file-version-1>` では、 ``build`` の使い方が異なります：
   
   * ``build: .`` の文字列のみ許可されています。オブジェクトは指定できません。
   * ``build`` と ``image`` は同時に使えません。指定するとエラーになります。

.. context

.. _compose-file-context:

context
----------

..     Version 2 file format only. In version 1, just use build.

.. note::

   context は :ref:`バージョン２のフォーマット <compose-file-version-2>` のみで利用可能です。バージョン１では :ref:`build <compose-file-build>` をお使いください。

.. Either a path to a directory containing a Dockerfile, or a url to a git repository.

コンテクスト（訳者注：内容物の意味）には Dockerfile があるディレクトリのパスや Git リポジトリの URL を指定します。

.. When the value supplied is a relative path, it is interpreted as relative to the location of the Compose file. This directory is also the build context that is sent to the Docker daemon.

値に相対パスを指定したら、Compose ファイルのある場所を基準とした相対パスとして解釈します。また、指定したディレクトリが構築コンテクストとなり、Docker デーモンに送信します。

.. Compose will build and tag it with a generated name, and use that image thereafter.

Compose は生成時の名前で構築・タグ付けし、それがイメージとなります。

.. code-block:: yaml

   build:
     context: ./dir

.. dockerfile

.. _compose-file-dockerfile:

dockerfile
----------

.. Alternate Dockerfile.

Dockerfile の代わりになるものです。

.. Compose will use an alternate file to build with. A build path must also be specified.

Compose は構築時に別のファイルを使えます。構築時のパスも指定する必要があります。

.. code-block:: bash

   build:
     context: .
     dockerfile: Dockerfile-alternate

..    Note: In the version 1 file format, dockerfile is different in two ways:
    It appears alongside build, not as a sub-option:
    Using dockerfile together with image is not allowed. Attempting to do so results in an error.

.. note::

   :ref:`バージョン１のフォーマット <compose-file-version-1>` とは ``dockerfile`` の使い方が異なります。
   
   * ``build`` と ``dockerfile`` は並列であり、サブオプションではありません。
   
      build: .
      dockerfile: Dockerfile-alternate
   
   * ``dockerfile`` と ``image`` を同時に使えません。使おうとしてもエラーになります。

.. args

.. _compose-file-args:

args
----------

..    Version 2 file format only.

.. Add build arguments. You can use either an array or a dictionary. Any boolean values; true, false, yes, no, need to be enclosed in quotes to ensure they are not converted to True or False by the YML parser.

.. note::

   対応しているのは :ref:`バージョン２のファイル形式 <compose-file-version-2>` のみです。

構築時に build のオプション（args）を追加します。配列でも辞書形式（訳者注：「foo=bar」の形式）も指定できます。ブール演算子（true、false、yes、no）を使う場合はクォートで囲む必要があります。そうしませんと YAML パーサは True か False か判別できません。

.. Build arguments with only a key are resolved to their environment value on the machine Compose is running on.

構築時に引数のキーとして解釈する環境変数の値は、Compose を実行するマシン上のみです。

.. code-block:: yaml

   build:
     args:
       buildno: 1
       user: someuser
   
   build:
     args:
       - buildno=1
       - user=someuser

.. cap_add, cap_drop

cap_add, cap_drop
--------------------

.. Add or drop container capabilities. See man 7 capabilities for a full list.

コンテナのケーパビリティ（capabilities）を追加・削除します。ケーパビリティの一覧は ``man 7 capabilities`` をご覧ください。

.. code-block:: yaml

   cap_add:
     - ALL
   
   cap_drop:
     - NET_ADMIN
     - SYS_ADMIN


.. _compose-file-command:

command
----------

.. Override the default command.

デフォルトのコマンドを上書きします。

.. code-block:: yaml

   command: bundle exec thin -p 3000

.. The command can also be a list, in a manner similar to dockerfile:

これは :ref:`Dockerfile <cmd>` の書き方に似せることもできます。

.. code-block:: yaml

   command: [bundle, exec, thin, -p, 3000]

cgroup_parent
--------------------

.. Specify an optional parent cgroup for the container.

コンテナに対し、オプションの親グループを指定します。

.. code-block:: yaml

   cgroup_parent: m-executor-abcd

.. _compose-file-container-name:

container_name
--------------------

.. Specify a custom container name, rather than a generated default name.

デフォルトで生成される名前の代わりに、カスタム・コンテナ名を指定します。

.. code-block:: yaml

   container_name: my-web-container

.. Because Docker container names must be unique, you cannot scale a service beyond 1 container if you have specified a custom name. Attempting to do so results in an error.

Docker コンテナ名はユニークである必要があります。そのため、カスタム名を指定時、サービスは複数のコンテナにスケールできなくなります。

.. _compose-file-devices:

devices
----------

.. List of device mappings. Uses the same format as the --device docker client create option.

デバイス・マッピングの一覧を表示します。docker クライアントで作成する際の ``--device`` と同じ形式を使います。

.. code-block:: yaml

   devices:
     - "/dev/ttyUSB0:/dev/ttyUSB0"

.. _compose-file-depends_on:

depends_on
----------

.. Express dependency between services, which has two effects:

サービス間の依存関係を指定したら、２つの効果があります。

..    docker-compose up will start services in dependency order. In the following example, db and redis will be started before web.

* ``docker-compose up`` を実行したら、依存関係のある順番に従ってサービスを起動します。以下の例では、 ``web`` を開始する前に ``db`` と ``redis`` を実行します。

..    docker-compose up SERVICE will automatically include SERVICE’s dependencies. In the following example, docker-compose up web will also create and start db and redis.

* ``docker-compose up サービス（の名称）`` を実行したら、自動的に ``サービス`` の依存関係を処理します。以下の例では、 ``docker-compose up web`` を実行したら、 ``db`` と ``redis`` も作成・起動します。

.. Simple example:

簡単なサンプル：

.. code-block:: bash

   version: '2'
   services:
     web:
       build: .
       depends_on:
         - db
         - redis
     redis:
       image: redis
     db:
       image: postgres

..     Note: depends_on will not wait for db and redis to be “ready” before starting web - only until they have been started. If you need to wait for a service to be ready, see Controlling startup order for more on this problem and strategies for solving it.

.. note::

   ``depends_on`` では、  ``web`` の実行にあたり、 ``db`` と ``redis`` の準備が整うのを待てません。待てるのはコンテナを開始するまでです。サービスの準備が整うまで待たせる必要がある場合は、 :doc:`起動順番の制御 <startup-order>` に関するドキュメントで、問題への対処法や方針をご確認ください。

.. _compose-file-dns:

dns
----------

.. Custom DNS servers. Can be a single value or a list.

DNS サーバの設定を変更します。単一の値、もしくはリストになります。

.. code-block:: yaml

   dns: 8.8.8.8
   dns:
     - 8.8.8.8
     - 9.9.9.9

.. _compose-file-dns-search:

dns_search
----------

.. Custom DNS search domains. Can be a single value or a list.

DNS の検索ドメインを変更します。単一の値、もしくはリストになります。

.. code-block:: yaml

   dns_search: example.com
   dns_search:
     - dc1.example.com
     - dc2.example.com


.. tmpfs

.. _copmose-file-tmpfs:

tmpfs
----------

.. Mount a temporary file system inside the container. Can be a single value or a list.

コンテナ内にテンポラリ・ファイルシステムをマウントします。単一の値もしくはリストです。

.. code-block:: yaml

   tmpfs: /run
   tmpfs:
     - /run
     - /tmp




.. _compose-file-entrypoint:

entrypoint
----------

.. Override the default entrypoint.

デフォルトの entrypoint を上書きします。

.. code-block:: yaml

   entrypoint: /code/entrypoint.sh

.. The entrypoint can also be a list, in a manner similar to dockerfile:

entrypoint は :ref:`Dockerfile <entrypoint>` のように列挙できます。

.. code-block:: yaml

   entrypoint:
       - php
       - -d
       - zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20100525/xdebug.so
       - -d
       - memory_limit=-1
       - vendor/bin/phpunit


.. _compose-file-env_file:

env_file
----------

.. Add environment variables from a file. Can be a single value or a list.

ファイル上の定義から環境変数を追加します。単一の値、もしくはリストになります。

.. If you have specified a Compose file with docker-compose -f FILE, paths in env_file are relative to the directory that file is in.

Compose ファイルを ``docker-compose -f ファイル名`` で指定する場合は、 ``env_file`` ファイルは指定したディレクトリに対する相対パスとみなします。

.. Environment variables specified in environment override these values.

環境変数で指定されている値は、 ``environment`` で上書きできます。

.. code-block:: yaml

   env_file: .env
   
   env_file:
     - ./common.env
     - ./apps/web.env
     - /opt/secrets.env

.. Compose expects each line in an env file to be in VAR=VAL format. Lines beginning with # (i.e. comments) are ignored, as are blank lines.

Compose は各行を ``変数=値`` の形式とみなします。 ``#`` で始まる行（例：コメント）は無視され、空白行として扱います。

.. code-block:: yaml

   # Rails/Rack 環境変数を設定
   RACK_ENV=development


.. _compose-file-environment:

environment
--------------------

.. Add environment variables. You can use either an array or a dictionary. Any boolean values; true, false, yes no, need to be enclosed in quotes to ensure they are not converted to True or False by the YML parser.

環境変数を追加します。配列もしくは辞書形式（dictionary）で指定できます。boolean 値 (true、false、yes、no のいずれか) は、YML パーサによって True か False に変換されないよう、クォート（ ' 記号）で囲む必要があります。

.. Environment variables with only a key are resolved to their values on the machine Compose is running on, which can be helpful for secret or host-specific values.

キーだけの環境変数は、Compose の実行時にマシン上で指定するものであり、シークレット（訳注：API鍵などの秘密情報）やホスト固有の値を指定するのに便利です。

.. code-block:: yaml

   environment:
     RACK_ENV: development
     SHOW: 'true'
     SESSION_SECRET:
   
   environment:
     - RACK_ENV=development
     - SHOW=true
     - SESSION_SECRET

.. _compose-file-expose:

expose
----------

.. Expose ports without publishing them to the host machine - they’ll only be accessible to linked services. Only the internal port can be specified.

ホストマシン上で公開するポートを指定せずに、コンテナの公開（露出）用のポート番号を指定します。これらはリンクされたサービス間でのみアクセス可能になります。内部で使うポートのみ指定できます。

.. code-block:: yaml

   expose:
    - "3000"
    - "8000"

.. _compose-file-extends:

extends
----------

.. Extend another service, in the current file or another, optionally overriding configuration.

現在のファイルから別のファイルにサービスを拡張するもので、設定のオプションを追加します。

.. You can use extends on any service together with other configuration keys. The extends value must be a dictionary defined with a required service and an optional file key.

他の設定用のキーと一緒にサービスを ``extends`` （拡張）できます。 ``extends`` 値には ``service`` の定義が必要であり、オプションで ``file`` キーを指定します。

.. code-block:: yaml

   extends:
     file: common.yml
     service: webapp

.. The service the name of the service being extended, for example web or database. The file is the location of a Compose configuration file defining that service.

サービスを拡張する ``service`` の名前とは、たとえば ``web`` や ``database`` です。 ``file`` はサービスを定義する Compose 設定ファイルの場所です。

.. If you omit the file Compose looks for the service configuration in the current file. The file value can be an absolute or relative path. If you specify a relative path, Compose treats it as relative to the location of the current file.

``file`` を省略したら、Compose は現在の設定ファイル上からサービスの定義を探します。 ``file`` の値は相対パスまたは絶対パスです。相対パスを指定したら、Compose はその場所を、現在のファイルからの相対パスとして扱います。

.. You can extend a service that itself extends another. You can extend indefinitely. Compose does not support circular references and docker-compose returns an error if it encounters one.

自分自身を他に対して拡張するサービス定義ができます。拡張は無限に可能です。Compose は循環参照をサポートしておらず、もし循環参照があれば ``docker-compose`` はエラーを返します。

.. For more on extends, see the the extends documentation.

``extends`` に関するより詳細は、 :ref:`extends ドキュメント <extending-services>` をご覧ください。

.. compose-file-external_links:

external_links
--------------------

.. Link to containers started outside this docker-compose.yml or even outside of Compose, especially for containers that provide shared or common services. external_links follow semantics similar to links when specifying both the container name and the link alias (CONTAINER:ALIAS).

対象の ``docker-compose.yml`` の外にあるコンテナだけでなく、Compose の外にあるコンテナとリンクします。特に、コンテナが共有サービスもしくは一般的なサービスを提供している場合に有用です。 ``external_links`` でコンテナ名とエイリアスを指定すると（ ``コンテナ名:エイリアス名`` ）、 ``link`` のように動作します。

.. code-block:: yaml

   external_links:
    - redis_1
    - project_db_1:mysql
    - project_db_1:postgresql

..    Note: If you’re using the version 2 file format, the externally-created containers must be connected to at least one of the same networks as the service which is linking to them.

.. note::

   :ref:`バージョン２のファイル形式 <compose-file-version-2>` を使う時、外部に作成したコンテナと接続する必要があれば、接続先のサービスは対象ネットワーク上に少なくとも１つリンクする必要があります。

.. extra_hosts

.. _compose-file-extra_hosts:

extra_hosts
--------------------

.. Add hostname mappings. Use the same values as the docker client --add-host parameter.

ホスト名を割り当てます。これは docker クライアントで ``--add-host`` パラメータを使うのと同じものです。

.. code-block:: yaml

   extra_hosts:
    - "somehost:162.242.195.82"
    - "otherhost:50.31.209.229"

.. An entry with the ip address and hostname will be created in /etc/hosts inside containers for this service, e.g:

コンテナ内の ``/etc/hosts`` に IP アドレスとホスト名のエントリが追加されます。例：

.. code-block:: yaml

   162.242.195.82  somehost
   50.31.209.229   otherhost

.. _compose-file-image:

image
----------

.. Specify the image to start the container from. Can either be a repository/tag or a partial image ID.

コンテナを実行時に元となるイメージを指定します。リポジトリ名・タグあるいはイメージ ID の一部を指定できます。

.. code-block:: yaml

   image: redis
   image: ubuntu:14.04
   image: tutum/influxdb
   image: example-registry.com:4000/postgresql
   image: a4bc65fd

.. If the image does not exist, Compose attempts to pull it, unless you have also specified build, in which case it builds it using the specified options and tags it with the specified tag.

イメージが存在していなければ、Compose は pull （取得）を試みます。しかし :ref:`build <compose-file-build>` を指定している場合は除きます。その場合、指定されたタグやオプションを使って構築します。

..    Note: In the version 1 file format, using build together with image is not allowed. Attempting to do so results in an error.

.. note::

   :ref:`バージョン１のファイル形式 <compose-file-version-1>` では、 ``build`` と ``image`` を同時に使えません。実行しようとしてもエラーが出ます。

.. _compose-file-labels:

labels
----------

.. Add metadata to containers using Docker labels. You can use either an array or a dictionary.

:doc:`Docker ラベル </engine/userguide/labels-custom-metadata>` を使いコンテナにメタデータを追加します。配列もしくは辞書形式で追加できます。

.. It’s recommended that you use reverse-DNS notation to prevent your labels from conflicting with those used by other software.

他のソフトウェアとラベルが競合しないようにするため、DNS 逆引き記法の利用を推奨します。

.. code-block:: yaml

   labels:
     com.example.description: "Accounting webapp"
     com.example.department: "Finance"
     com.example.label-with-empty-value: ""
   
   labels:
     - "com.example.description=Accounting webapp"
     - "com.example.department=Finance"
     - "com.example.label-with-empty-value"

.. _compose-file-links:

links
----------

.. Link to containers in another service. Either specify both the service name and the link alias (SERVICE:ALIAS), or just the service name (which will also be used for the alias).

コンテナを他のサービスとリンクします。サービス名とリンク用エイリアスの両方を指定できます（ ``サービス名:エイリアス名`` ）。あるいはサービス名だけの指定もできます（このサービス名はエイリアス名としても使われます）。

.. code-block:: yaml

   links:
    - db
    - db:database
    - redis

.. Containers for the linked service will be reachable at a hostname identical to the alias, or the service name if no alias was specified.

リンクするサービスのコンテナは、エイリアスとして認識できるホスト名で到達（接続）可能になります。エイリアスが指定されなければ、サービス名で到達できます。

.. Links also express dependency between services in the same way as depends_on, so they determine the order of service startup.

また、サービス間の依存関係は :ref:`depends_on <compose-file-depends_on>` を使っても同様に指定できますし、サービスを起動する順番も指定できます。

..    Note: If you define both links and networks, services with links between them must share at least one network in common in order to communicate.

.. note::

   links と :ref:`networks <compose-file-networks>` を両方定義する時は、リンクするサービスが通信するために、ネットワークの少なくとも１つを共有する必要があります。

.. _compose-file-logging:

logging
----------

.. note::

   :ref:`バージョン２のファイル形式 <compose-file-version-2>` のみ対応しています。バージョン１では :ref:`log_driver <compose-file-log_driver>` と :ref:`log_opt <compose-file-log_opt>` をお使いください。

.. Logging configuration for the service.

サービスに対してログ記録の設定をします。

.. code-block:: yaml

   logging:
     driver: syslog
     options:
       syslog-address: "tcp://192.168.0.42:123"

.. The driver name specifies a logging driver for the service’s containers, as with the --log-driver option for docker run (documented here).

``driver`` にはコンテナのサービスに使うロギング・ドライバを指定します。これは docker run コマンドにおける ``--log-driver`` オプションと同じです （ :doc:`ドキュメントはこちら </engine/admin/logging/overview>` ）。

.. The default value is json-file.

デフォルトの値は json-file です。

.. code-block:: yaml

   driver: "json-file"
   driver: "syslog"
   driver: "none"

..     Note: Only the json-file driver makes the logs available directly from docker-compose up and docker-compose logs. Using any other driver will not print any logs.

.. note::

   ``docker-compose up`` で立ち上げた場合、 ``docker-compose logs`` コマンドでログを表示できるのは ``json-file`` ドライバを指定した時のみです。他のドライバを指定したら logs コマンドを実行しても画面に表示されません。

.. Specify logging options for the logging driver with the options key, as with the --log-opt option for docker run.

ロギング・ドライバのオプションを指定するには ``options`` キーを使います。これは ``docker run`` コマンド実行時の ``--log-opt`` オプションと同じです。

.. Logging options are key-value pairs. An example of syslog options:

ロギングのオプションはキーバリューのペアです。以下は ``syslog`` オプションを指定する例です。

.. code-block:: yaml

   driver: "syslog"
   options:
     syslog-address: "tcp://192.168.0.42:123"

.. _compose-file-log_driver:

log_driver
----------

.. Version 1 file format only. In version 2, use logging.

.. note::

   :ref:`ファイル形式バージョン１ <compose-file-version-1>` のオプションです。バージョン２では :ref:`logging <compose-file-logging>` を使います。

.. Specify a log driver. The default is json-file.

ログ・ドライバを指定します。デフォルトは json-file（JSON ファイル形式）です。

.. code-block:: yaml

   log_driver: "syslog"

.. _compose-file-log_opt:

log_opt
----------

.. Version 1 file format only. In version 2, use logging.

.. note::

   :ref:`ファイル形式バージョン１ <compose-file-version-1>` のオプションです。バージョン２では :ref:`logging <compose-file-logging>` を使います。


.. Specify logging options as key-value pairs. An example of syslog options:

ログ記録のオプション、キー・バリューのペアで指定します。次の例は ``syslog`` のオプションです。

.. code-block:: yaml

   log_opt:
     syslog-address: "tcp://192.168.0.42:123"

.. _compose-file-net:

net
----------

.. Version 1 file format only. In version 2, use network_mode.

.. note::

   :ref:`ファイル形式バージョン１ <compose-file-version-1>` のオプションです。バージョン２では :ref:`network_mode <compose-file-network_mode>` を使います。

.. Network mode. Use the same values as the docker client --net parameter. The container:... form can take a service name instead of a container name or id.

ネットワーク・モードを指定します。これは docker クライアントで ``--net`` パラメータを指定するのと同じものです。コンテナ名や ID の代わりに、 ``container:...`` で指定した名前が使えます。

.. code-block:: yaml

   net: "bridge"
   net: "none"
   net: "host"
   net: "container:[サービス名かコンテナ名/id]"

.. network_mode

.. _compose-file-network_mode:

network_mode
--------------------

.. Version 2 file format only. In version 1, use net.

.. note::

   :ref:`ファイル形式バージョン２ <compose-file-version-2>` のオプションです。バージョン１では :ref:`net <compose-file-net>` を使います。

.. Network mode. Use the same values as the docker client --net parameter, plus the special form service:[service name].

ネットワーク・モードです。 docker クライアントで ``--net`` パラメータを使うのと同じ働きですが、 ``サービス:[サービス名]`` の形式で指定します。

.. code-block:: yaml

   network_mode: "bridge"
   network_mode: "host"
   network_mode: "none"
   network_mode: "service:[service name]"
   network_mode: "container:[container name/id]"

.. networks

.. _compose-file-networks:

networks
----------

..    Version 2 file format only. In version 1, use net.

.. note::

   :ref:`ファイル形式バージョン２ <compose-file-version-2>` のオプションです。バージョン１では使えません。

.. Networks to join, referencing entries under the top-level networks key.

ネットワークに参加する時、トップ・レベルの ``network`` :ref:`キー <network-configuration-reference>` のエントリを参照します。

.. code-block:: yaml

   services:
     some-service:
       networks:
        - some-network
        - other-network

.. _compose-file-aliases:

aliases
^^^^^^^^^^

.. Aliases (alternative hostnames) for this service on the network. Other containers on the same network can use either the service name or this alias to connect to one of the service’s containers.

エイリアス（ホスト名の別名）は、ネットワーク上のサービスに対してです。同一ネットワーク上の他のコンテナが、サービス名またはこのエイリアスを使い、サービスのコンテナの１つに接続します。

.. Since aliases is network-scoped, the same service can have different aliases on different networks

``aliases`` が適用されるのはネットワーク範囲内のみです。そのため、同じサービスでも他のネットワークからは異なったエイリアスが使えます。

..     Note: A network-wide alias can be shared by multiple containers, and even by multiple services. If it is, then exactly which container the name will resolve to is not guaranteed.

.. note::

   複数のコンテナだけでなく複数のサービスに対しても、ネットワーク範囲内でエイリアスが利用できます。ただしその場合、名前解決がどのコンテナに対して名前解決されるのか保証されません。

.. The general format is shown here.

一般的な形式は、以下の通りです。

.. code-block:: yaml

   services:
     some-service:
       networks:
         some-network:
           aliases:
            - alias1
            - alias3
         other-network:
           aliases:
            - alias2

.. In the example below, three services are provided (web, worker, and db), along with two networks (new and legacy). The db service is reachable at the hostname db or database on the new network, and at db or mysql on the legacy network.

この例では、３つのサービス（ ``web`` 、 ``worker`` 、 ``db`` ）と２つのネットワーク（ ``new`` と ``legacy`` ）が提供されています。 ``db`` サービスはホスト名 ``db`` または ``database`` として ``new`` ネットワーク上で到達可能です。そして、``legacy`` ネットワーク上では  ``db`` または ``mysql`` として到達できます。

.. code-block:: yaml

   version: '2'
   
   services:
     web:
       build: ./web
       networks:
         - new
   
     worker:
       build: ./worker
       networks:
       - legacy
   
     db:
       image: mysql
       networks:
         new:
           aliases:
             - database
         legacy:
           aliases:
             - mysql
   
   networks:
     new:
     legacy:


.. ipv4_address, ipv6_address

.. _ipv4-address-ipv6-address:

IPv4 アドレス、IPv6 アドレス
------------------------------

.. Specify a static IP address for containers for this service when joining the network.

サービスをネットワークに追加する時、コンテナに対して静的な IP アドレスを割り当てます。

.. The corresponding network configuration in the top-level networks section must have an ipam block with subnet and gateway configurations covering each static address. If IPv6 addressing is desired, the com.docker.network.enable_ipv6 driver option must be set to true.

:ref:`トップレベルのネットワーク・セクション <network-configuration-reference>` では、適切なネットワーク設定に ``ipam`` ブロックが必要です。ここで各静的アドレスが扱うサブネットやゲートウェイを定義します。 IPv6 アドレスが必要であれば、 ``com.docker.network.enable_ipv6`` ドライバ・オプションを ``true`` にする必要があります。

.. An example:

例：

.. code-block:: yaml

   version: '2'
   
   services:
     app:
       image: busybox
       command: ifconfig
       networks:
         app_net:
           ipv4_address: 172.16.238.10
           ipv6_address: 2001:3984:3989::10
   
   networks:
     app_net:
       driver: bridge
       driver_opts:
         com.docker.network.enable_ipv6: "true"
       ipam:
         driver: default
         config:
         - subnet: 172.16.238.0/24
           gateway: 172.16.238.1
         - subnet: 2001:3984:3989::/64
           gateway: 2001:3984:3989::1


.. _compose-file-pid:

pid
----------

.. code-block:: yaml

   pid: "host"

.. Sets the PID mode to the host PID mode. This turns on sharing between container and the host operating system the PID address space. Containers launched with this flag will be able to access and manipulate other containers in the bare-metal machine’s namespace and vise-versa.

PID モードはホストの PID モードを設定します。有効化したら、コンテナとホスト・オペレーティング・システム間で PID アドレス空間を共有します。コンテナにこのフラグを付けて起動したら、他のコンテナからアクセスできるだけでなく、ベアメタル・マシン上の名前空間などから操作できるようになります。

.. _compose-file-ports:

ports
----------

.. Expose ports. Either specify both ports (HOST:CONTAINER), or just the container port (a random host port will be chosen).

公開用のポートです。ホスト側とコンテナ側の両方のポートを指定（ ``ホスト側:コンテナ側`` ）できるだけでなく、コンテナ側のポートのみも指定できます（ホスト側はランダムなポートが選ばれます）。

..    Note: When mapping ports in the HOST:CONTAINER format, you may experience erroneous results when using a container port lower than 60, because YAML will parse numbers in the format xx:yy as sexagesimal (base 60). For this reason, we recommend always explicitly specifying your port mappings as strings.

.. note::

   ``ホスト側:コンテナ側`` の書式でポートを割り当てる時、コンテナのポートが 60 以下であればエラーが発生します。これは YAML が ``xx:yy`` 形式の指定を、60 進数（60が基準）の数値とみなすからです。そのため、ポートの割り当てには常に文字列として指定することを推奨します（訳者注： " で囲んで文字扱いにする）。

.. code-block:: yaml

   ports:
    - "3000"
    - "3000-3005"
    - "8000:8000"
    - "9090-9091:8080-8081"
    - "49100:22"
    - "127.0.0.1:8001:8001"
    - "127.0.0.1:5000-5010:5000-5010"

.. _compose-file-security_opt:

security_opt
--------------------

.. Override the default labeling scheme for each container.

各コンテナに対するデフォルトのラベリング・スキーマ（labeling scheme）を上書きします。

.. code-block:: yaml

   security_opt:
     - label:user:USER
     - label:role:ROLE

.. -compose-file-stop_signal:

stop_signal
--------------------

.. Sets an alternative signal to stop the container. By default stop uses SIGTERM. Setting an alternative signal using stop_signal will cause stop to send that signal instead.

コンテナに対して別の停止シグナルを設定します。デフォルトでは ``stop`` で SIGTERM を使います。 ``stop_signal`` で別のシグナルを指定したら、 ``stop`` 実行時にそのシグナルを送信します。

.. code-block:: yaml

   stop_signal: SIGUSR1

.. _compose-file-ulimits:

ulimits
----------

.. Override the default ulimits for a container. You can either specify a single limit as an integer or soft/hard limits as a mapping.

コンテナのデフォルト ulimits を上書きします。単一の整数値で上限を指定できるだけでなく、ソフト／ハード・リミットの両方も指定できます。

.. code-block:: yaml

     ulimits:
       nproc: 65535
       nofile:
         soft: 20000
         hard: 40000

.. _compose-file-volumes:

volumes, volume_driver
------------------------------

.. Mount paths or named volumes, optionally specifying a path on the host machine (HOST:CONTAINER), or an access mode (HOST:CONTAINER:ro). For version 2 files, named volumes need to be specified with the top-level volumes key. When using version 1, the Docker Engine will create the named volume automatically if it doesn’t exist.

マウント・パスまたは名前を付けたボリュームは、オプションでホストマシン（ ``ホスト:コンテナ`` ）上のパス指定や、アクセス・モード（ ``ホスト:コンテナ:rw`` ） を指定できます。 :ref:`バージョン２のファイル <compose-file-version-2>` では名前を付けたボリュームを使うにはトップ・レベルの ``volumes`` :ref:`キー <volume-configuration-reference>` を指定する必要があります。 :ref:`バージョン１ <compose-file-version-1>` の場合は、ボリュームが存在していなければ Docker Engine が自動的に作成します。

.. You can mount a relative path on the host, which will expand relative to the directory of the Compose configuration file being used. Relative paths should always begin with . or ...

ホスト上の相対パスをマウント可能です。相対パスは Compose 設定ファイルが使っているディレクトリを基準とします。相対パスは ``.`` または ``..`` で始まります。

.. code-block:: yaml

   volumes:
     # パスを指定したら、Engine はボリュームを作成
     - /var/lib/mysql
   
     # 絶対パスを指定しての割り当て
     - /opt/data:/var/lib/mysql
   
     # ホスト上のパスを指定する時、Compose ファイルからのパスを指定
     - ./cache:/tmp/cache
   
     # ユーザの相対パスを使用
     - ~/configs:/etc/configs/:ro
   
     # 名前付きボリューム（Named volume）
     - datavolume:/var/lib/mysql

.. If you do not use a host path, you may specify a volume_driver.

ホスト側のパスを指定せず、 ``volume_driver`` を指定したい場合があるかもしれません。

.. code-block:: yaml

   volume_driver: mydriver

.. Note that for version 2 files, this driver will not apply to named volumes (you should use the driver option when declaring the volume instead). For version 1, both named volumes and container volumes will use the specified driver.

:ref:`バージョン２のファイル <compose-file-version-2>` では、名前付きボリュームに対してドライバを適用できません（ :ref:`ボリュームを宣言する <volume-configuration-reference>` のではなく、 ``driver`` オプションを使ったほうが良いでしょう  ）。 :ref:`バージョン１ <compose-file-version-1>` の場合は、ドライバを指定すると名前付きボリュームにもコンテナのボリュームにも適用されます。

..    Note: No path expansion will be done if you have also specified a volume_driver.

.. note::

   ``volume_driver`` も指定しても、パスは拡張されません。

.. See Docker Volumes and Volume Plugins for more information.

詳しい情報は :doc:`Docker ボリューム </engine/userguide/containers/dockervolumes>` と :doc:`ボリューム・プラグイン </engine/extend/plugins_volume>` をご覧ください。

volumes_from
--------------------

.. Mount all of the volumes from another service or container, optionally specifying read-only access(ro) or read-write(rw).

他のサービスやコンテナ上のボリュームをマウントします。オプションで、読み込み専用のアクセス（ ``ro`` ）や読み書き（ ``rw`` ）を指定できます。

.. code-block:: yaml

   volumes_from:
    - service_name
    - service_name:ro
    - container:container_name
    - container:container_name:rw

.. Note: The container:... formats are only supported in the version 2 file format. In version 1, you can use container names without marking them as such:

.. note::

   ``コンテナ:...`` の形式をサポートしているのは :ref:`バージョン２のファイル形式 <compose-file-version-2>` のみです。 :ref:`バージョン１の場合 <compose-file-version-1>` は、次のように明示しなくてもコンテナ名を使えます。
   
   - service_name
   - service_name:ro
   - container_name
   - container_name:rw

.. cpu_shares, cpuset, domainname, entrypoint, hostname, ipc, mac_address, mem_limit, memswap_limit, privileged, read_only, restart, stdin_open, tty, user, working_dir

.. _compose-options:

その他
----------

.. Each of these is a single value, analogous to its docker run counterpart.

cpu_shares、 cpuset、 domainname、 entrypoint、 hostname、 ipc、 mac_address、 mem_limit、 memswap_limit、 privileged、 read_only、 restart、 stdin_open、 tty、 user、 working_dir は、それぞれ単一の値を持ちます。いずれも :doc:`docker run </engine/reference/run/>` コマンドのオプションに対応しています。

.. code-block:: yaml

   cpu_shares: 73
   cpu_quota: 50000
   cpuset: 0,1
   
   user: postgresql
   working_dir: /code
   
   domainname: foo.com
   hostname: foo
   ipc: host
   mac_address: 02:42:ac:11:65:43
   
   mem_limit: 1000000000
   memswap_limit: 2000000000
   privileged: true
   
   restart: always
   
   read_only: true
   stdin_open: true
   tty: true

.. Volume configuration reference

.. _volume-configuration-reference:

ボリューム設定リファレンス
==============================

.. While it is possible to declare volumes on the fly as part of the service declaration, this section allows you to create named volumes that can be reused across multiple services (without relying on volumes_from), and are easily retrieved and inspected using the docker command line or API. See the docker volume subcommand documentation for more information.

サービス宣言の一部として、オン・ザ・フライでボリュームを宣言できます。このセクションでは名前付きボリューム（named volume）の作成方法を紹介します。このボリュームは複数のサービスを横断して再利用可能なものです（ ``volumes_from`` に依存しません ）。そして docker コマンドラインや API を使って、簡単に読み込みや調査が可能です。 :doc:`docker volumes </engine/reference/commandline/volume_create>` のサブコマンドの詳細から、詳しい情報をご覧ください。

.. driver

driver
----------

.. Specify which volume driver should be used for this volume. Defaults to local. The Docker Engine will return an error if the driver is not available.

ボリューム・ドライバがどのボリュームを使うべきかを指定します。デフォルトは ``local`` です。ドライバを指定しなければ、Docker Engine はエラーを返します。

.. code-block:: yaml

   driver: foobar

.. driver_opts

driver_opts
--------------------

.. Specify a list of options as key-value pairs to pass to the driver for this volume. Those options are driver-dependent - consult the driver’s documentation for more information. Optional.

ボリュームが使うドライバに対して、オプションをキーバリューのペアで指定します。これらのオプションはドライバに依存します。オプションの詳細については、各ドライバのドキュメントをご確認ください。

.. code-block:: yaml

   driver_opts:
     foo: "bar"
     baz: 1

.. external

.. _compose-file-external:

external
==========

.. If set to true, specifies that this volume has been created outside of Compose. docker-compose up will not attempt to create it, and will raise an error if it doesn’t exist.

このオプションを ``true`` に設定したら、Compose の外にあるボリュームを作成します（訳者注：Compose が管理していない Docker ボリュームを利用します、という意味）。 ``docker-compose up`` を実行してもボリュームを作成しません。もしボリュームが存在していなければ、エラーを返します。

.. external cannot be used in conjunction with other volume configuration keys (driver, driver_opts).

``external`` は他のボリューム用の設定キー（ ``driver`` 、``driver_opts`` ） と一緒に使えません。

.. In the example below, instead of attemping to create a volume called [projectname]_data, Compose will look for an existing volume simply called data and mount it into the db service’s containers.

以下の例は、 ``[プロジェクト名]_data`` という名称のボリュームを作成する代わりに、Compose は ``data`` という名前で外部に存在するボリュームを探し出し、それを ``db`` サービスのコンテナの中にマウントします。

.. code-block:: yaml

   version: '2'
   
   services:
     db:
       image: postgres
       volumes:
         - data:/var/lib/postgres/data
   
   volumes:
     data:
       external: true

.. You can also specify the name of the volume separately from the name used to refer to it within the Compose file:

また、Compose ファイルの中で使われている名前を参照し、ボリューム名を指定可能です。

.. code-block:: yaml

   volumes
     data:
       external:
         name: actual-name-of-volume（実際のボリューム名）

.. Network configuration reference

.. _network-configuration-reference:

ネットワーク設定リファレンス
==============================

.. The top-level networks key lets you specify networks to be created. For a full explanation of Compose’s use of Docker networking features, see the Networking guide.

ネットワークを作成するには、トップレベルの ``networks`` キーを使って指定します。Compose 上でネットワーク機能を使うための詳細情報は、 :doc:`networking` をご覧ください。

.. driver

driver
----------

.. Specify which driver should be used for this network.

対象のネットワークが使用するドライバを指定します。

.. The default driver depends on how the Docker Engine you’re using is configured, but in most instances it will be bridge on a single host and overlay on a Swarm.

デフォルトでどのドライバを使用するかは Docker Engine の設定に依存します。一般的には単一ホスト上であれば ``bridge`` でしょうし、 Swarm 上であれば ``overlay`` でしょう。

.. The Docker Engine will return an error if the driver is not available.

ドライバが使えなければ、Docker Engine はエラーを返します。

.. code-block:: yaml

   driver: overlay

.. driver_opts

driver_opts
--------------------

.. Specify a list of options as key-value pairs to pass to the driver for this network. Those options are driver-dependent - consult the driver’s documentation for more information. Optional.

ネットワークが使うドライバに対して、オプションをキーバリューのペアで指定します。これらのオプションはドライバに依存します。オプションの詳細については、各ドライバのドキュメントをご確認ください。

.. code-block:: yaml

     driver_opts:
       foo: "bar"
       baz: 1

.. ipam

ipam
^^^^^^^^^^

.. Specify custom IPAM config. This is an object with several properties, each of which is optional:

IPAM （IPアドレス管理）のカスタム設定を指定します。様々なプロパティ（設定）を持つオブジェクトですが、各々の指定はオプションです。

..    driver: Custom IPAM driver, instead of the default.
    config: A list with zero or more config blocks, each containing any of the following keys:
        subnet: Subnet in CIDR format that represents a network segment
        ip_range: Range of IPs from which to allocate container IPs
        gateway: IPv4 or IPv6 gateway for the master subnet
        aux_addresses: Auxiliary IPv4 or IPv6 addresses used by Network driver, as a mapping from hostname to IP

* ``driver`` ：デフォルトの代わりに、カスタム IPAM ドライバを指定します。
* ``config`` ：ゼロもしくは複数の設定ブロック一覧です。次のキーを使えます。

  * ``subnet`` ：ネットワーク・セグメントにおける CIDR のサブネットを指定します。
  * ``ip_range``  ：コンテナに割り当てる IP アドレスの範囲を割り当てます。
  * ``gateway`` ：マスタ・サブネットに対する IPv4 または IPv6 ゲートウェイを指定します。
  * ``aux_addresses`` ：ネットワーク・ドライバが補助で使う IPv4 または IPv6 アドレスを指定します。これはホスト名を IP アドレスに割り当てるためのものです。

.. A full example:

全てを使った例：

.. code-block:: yaml

   ipam:
     driver: default
     config:
       - subnet: 172.28.0.0/16
         ip_range: 172.28.5.0/24
         gateway: 172.28.5.254
         aux_addresses:
           host1: 172.28.1.5
           host2: 172.28.1.6
           host3: 172.28.1.7

.. external

external
^^^^^^^^^^

.. If set to true, specifies that this network has been created outside of Compose. docker-compose up will not attempt to create it, and will raise an error if it doesn’t exist.

このオプションを ``true`` に設定したら、Compose の外にネットワークを作成します（訳者注：Compose が管理していない Docker ネットワークを利用します、という意味）。 ``docker-compose up`` を実行してもネットワークを作成しません。もしネットワークが存在していなければ、エラーを返します。

.. external cannot be used in conjunction with other network configuration keys (driver, driver_opts, ipam).

``external`` は他のネットワーク用の設定キー（ ``driver`` 、``driver_opts`` 、 ``ipam`` ） と一緒に使えません。

.. In the example below, proxy is the gateway to the outside world. Instead of attemping to create a network called [projectname]_outside, Compose will look for an existing network simply called outside and connect the proxy service’s containers to it.

以下の例は、外の世界とのゲートウェイに ``proxy`` を使います。 ``[プロジェクト名]_outside`` という名称のネットワークを作成する代わりに、Compose は ``outside`` という名前で外部に存在するネットワークを探し出し、それを ``proxy`` サービスのコンテナに接続します。

.. code-block:: yaml

   version: '2'
   
   services:
     proxy:
       build: ./proxy
       networks:
         - outside
         - default
     app:
       build: ./app
       networks:
         - default
   
   networks:
     outside:
       external: true

.. You can also specify the name of the network separately from the name used to refer to it within the Compose file:

また、Compose ファイルの中で使われている名前を参照し、ネットワーク名を指定可能です。

.. code-block:: yaml

   networks:
     outside:
       external:
         name: actual-name-of-network

.. Versioning

.. _compose-file-versioning:

バージョン
--------------------

.. There are two versions of the Compose file format:

Compose ファイル形式には２つのバージョンがあります。

..    Version 1, the legacy format. This is specified by omitting a version key at the root of the YAML.
    Version 2, the recommended format. This is specified with a version: '2' entry at the root of the YAML.

* バージョン１は過去のフォーマットです。YAML の冒頭で ``version`` キーを指定不要です。
* バージョン２は推奨フォーマットです。YAML の冒頭で ``version: '2'`` のエントリを指定します。

.. To move your project from version 1 to 2, see the Upgrading section.

プロジェクトをバージョン１からバージョン２に移行する方法は、 :ref:`アップグレード方法 <compose-file-upgrading>` のセクションをご覧ください。

..    Note: If you’re using multiple Compose files or extending services, each file must be of the same version - you cannot mix version 1 and 2 in a single project.

.. note::

   :ref:`複数の Compose ファイル <different-environments>` や :ref:`拡張サービス <extending-services>` を使う場合は、各ファイルが同じバージョンでなくてはいけません。１つのプロジェクト内でバージョン１と２を混在できません。

.. Several things differ depending on which version you use:

バージョンごとに異なった制約があります。

..    The structure and permitted configuration keys
    The minimum Docker Engine version you must be running
    Compose’s behaviour with regards to networking

* 構造と利用可能な設定キー
* 実行に必要な Docker Engine の最低バージョン
* ネットワーク機能に関する Compose の挙動

.. These differences are explained below.

これらの違いを、以下で説明します。

.. Version 1

.. _compose-file-version-1:

バージョン１
^^^^^^^^^^^^^^^^^^^^

.. Compose files that do not declare a version are considered “version 1”. In those files, all the services are declared at the root of the document.

Compose ファイルでバージョンを宣言しなければ「バージョン１」として考えます。バージョン１では、ドキュメントの冒頭から全ての :ref:`サービス <service-configuration-reference>` を定義します。

.. Version 1 is supported by Compose up to 1.6.x. It will be deprecated in a future Compose release.

バージョン１は **Compose 1.6.x まで** サポートされます。今後の Compose バージョンでは廃止予定です。

.. Version 1 files cannot declare named volumes, networks or build arguments.

バージョン１のファイルでは  :ref:`volumes <volume-configuration-reference>` 、 :doc:`networks <networking>` 、 :ref:`build 引数 <compose-file-build>` を使えません。

.. Example:

例：

.. code-block:: yaml

   web:
     build: .
     ports:
      - "5000:5000"
     volumes:
      - .:/code
     links:
      - redis
   redis:
     image: redis

.. Version 2

.. _compose-file-version-2:

バージョン２
^^^^^^^^^^^^^^^^^^^^

.. Compose files using the version 2 syntax must indicate the version number at the root of the document. All services must be declared under the services key.

バージョン２の Compose ファイルでは、ドキュメントの冒頭でバージョン番号を明示する必要があります。 ``services`` キーの下で全ての :ref:`サービス <service-configuration-reference>` を定義する必要があります。

.. Version 2 files are supported by Compose 1.6.0+ and require a Docker Engine of version 1.10.0+.

バージョン２のファイルは **Compose 1.6.0 以上** でサポートされており、実行には Docker Engine **1.10.0 以上** が必要です。

.. Named volumes can be declared under the volumes key, and networks can be declared under the networks key.

名前付き :ref:`ボリューム <volume-configuration-reference>` の宣言は ``volumes`` キーの下で行えます。また、名前付き :ref:`ネットワーク <network-configuration-reference>` の宣言は ``networks`` キーの下で行えます。

.. Simple example:

シンプルな例：

.. code-block:: yaml

   version: '2'
   services:
     web:
       build: .
       ports:
        - "5000:5000"
       volumes:
        - .:/code
     redis:
       image: redis

.. A more extended example, defining volumes and networks:

ボリュームとネットワークを定義するよう拡張した例：

.. code-block:: yaml

   version: '2'
   services:
     web:
       build: .
       ports:
        - "5000:5000"
       volumes:
        - .:/code
       networks:
         - front-tier
         - back-tier
     redis:
       image: redis
       volumes:
         - redis-data:/var/lib/redis
       networks:
         - back-tier
   volumes:
     redis-data:
       driver: local
   networks:
     front-tier:
       driver: bridge
     back-tier:
       driver: bridge

.. Upgrading

.. _compose-file-upgrading:

アップグレード方法
^^^^^^^^^^^^^^^^^^^^

.. In the majority of cases, moving from version 1 to 2 is a very simple process:

ほとんどの場合、バージョン１から２への移行はとても簡単な手順です。

..    Indent the whole file by one level and put a services: key at the top.
    Add a version: '2' line at the top of the file.

1. 最上位レベルとして ``services:`` キーを追加する。
2. ファイルの１行め冒頭に ``version: '2'`` を追加する。

.. It’s more complicated if you’re using particular configuration features:

特定の設定機能を使っている場合は、より複雑です。

..     dockerfile: This now lives under the build key:

* ``dockerfile`` ： ``build`` キー配下に移動します。

.. code-block:: yaml

   build:
     context: .
     dockerfile: Dockerfile-alternate

.. log_driver, log_opt: These now live under the logging key:

* ``log_driver`` 、 ``log_opt`` ：これらは ``logging`` キー以下です。

.. code-block:: yaml

   logging:
     driver: syslog
     options:
       syslog-address: "tcp://192.168.0.42:123"

.. links with environment variables: As documented in the environment variables reference, environment variables created by links have been deprecated for some time. In the new Docker network system, they have been removed. You should either connect directly to the appropriate hostname or set the relevant environment variable yourself, using the link hostname:

* ``links`` と環境変数： :doc:`環境変数リファレンス </compose/link-env-deprecated>` に文章化している通り、links によって作成される環境変数機能は、いずれ廃止予定です。新しい Docker ネットワーク・システム上では、これらは削除されています。ホスト名のリンクを使う場合は、適切なホスト名で接続できるように設定するか、あるいは自分自身で代替となる環境変数を指定します。

.. code-block:: yaml

   web:
     links:
       - db
     environment:
       - DB_PORT=tcp://db:5432

.. external_links: Compose uses Docker networks when running version 2 projects, so links behave slightly differently. In particular, two containers must be connected to at least one network in common in order to communicate, even if explicitly linked together.

* ``external_links`` ： バージョン２のプロジェクトを実行する時、 Compose は Docker ネットワーク機能を使います。つまり、これまでのリンク機能と挙動が変わります。典型的なのは、２つのコンテナが通信するためには、少なくとも１つのネットワークを共有する必要があります。これはリンク機能を使う場合でもです。

.. Either connect the external container to your app’s default network, or connect both the external container and your service’s containers to an external network.

外部のコンテナがアプリケーションの :doc:`デフォルト・ネットワーク </compose/networking>` に接続する場合や、自分で作成したサービスが外部のコンテナと接続するには、 :ref:`外部ネットワーク機能 <using-a-pre-existing-network>` を使います。

.. net: This is now replaced by network_mode:

* ``net`` ：これは :ref:`network_mode <compose-file-network_mode>` に置き換えられました。

::

   net: host    ->  network_mode: host
   net: bridge  ->  network_mode: bridge
   net: none    ->  network_mode: none

.. If you’re using net: "container:[service name]", you must now use network_mode: "service:[service name]" instead.

``net: "コンテナ:[サービス名]"`` を使っていた場合は、 ``network_mode: "サービス:[サービス名]"`` に置き換える必要があります。

::

   net: "container:web"  ->  network_mode: "service:web"

.. If you’re using net: "container:[container name/id]", the value does not need to change.


``net: "コンテナ:[コンテナ名/ID]"`` の場合は変更不要です。

::

   net: "container:cont-name"  ->  network_mode: "container:cont-name"
   net: "container:abc12345"   ->  network_mode: "container:abc12345"

net: "container:abc12345"   ->  network_mode: "container:abc12345"

.. volumes with named volumes: these must now be explicitly declared in a top-level volumes section of your Compose file. If a service mounts a named volume called data, you must declare a data volume in your top-level volumes section. The whole file might look like this:

* ``volumes`` を使う名前付きボリューム：Compose ファイル上で、トップレベルの ``volumes`` セクションとして明示する必要があります。 ``data`` という名称のボリュームにサービスがマウントする必要がある場合、トップレベルの ``volumes`` セクションで ``data`` ボリュームを宣言する必要があります。記述は以下のような形式です。

.. code-block:: yaml

   version: '2'
   services:
     db:
       image: postgres
       volumes:
         - data:/var/lib/postgresql/data
   volumes:
     data: {}

.. By default, Compose creates a volume whose name is prefixed with your project name. If you want it to just be called data, declared it as external:

デフォルトでは、 Compose はプロジェクト名を冒頭に付けたボリュームを作成します。 ``data`` のように名前を指定するには、以下のように宣言します。

.. code-block:: yaml

   volumes:
     data:
       external: true


.. Variable substitution

.. _compose-file-variable-substitution:

変数の置き換え
====================

.. Your configuration options can contain environment variables. Compose uses the variable values from the shell environment in which docker-compose is run. For example, suppose the shell contains EXTERNAL_PORT=8000 and you supply this configuration:

設定オプションでは環境変数も含めることができます。シェル上の Compose は ``docker-compose`` の実行時に環境変数を使えます。たとえば、シェルで ``EXTERNAL_PORT=8000`` という変数を設定ファイルで扱うには、次のようにします。

.. code-block:: yaml

   web:
     build: .
     ports:
       - "${EXTERNAL_PORT}:5000"

.. When you run docker-compose up with this configuration, Compose looks for the EXTERNAL_PORT environment variable in the shell and substitutes its value in. For this example, Compose resolves the port mapping to "8000:5000" before creating the `web` container.

この設定で ``docker-compose up`` を実行したら、Compose は ``EXTERNAL_PORT`` 環境変数をシェル上で探し、それを値と置き換えます。この例では、Compose が ``web`` コンテナを作成する前に "8000:5000" のポート割り当てをします。

.. If an environment variable is not set, Compose substitutes with an empty string. In the example above, if EXTERNAL_PORT is not set, the value for port mapping is `:5000` (which is of course an invalid port mapping, and will result in an error when attempting to create the container).

環境変数が設定されていなければ、Compose は空の文字列に置き換えます。先の例では、 ``EXTERNAL_PORT`` が設定されなければ、 ポートの割り当ては ``:5000`` になります（もちろん、これは無効なポート割り当てなため、コンテナを作成しようとしてもエラーになります）。

.. Both $VARIABLE and ${VARIABLE} syntax are supported. Extended shell-style features, such as ${VARIABLE-default} and ${VARIABLE/foo/bar}, are not supported.

``$変数`` と ``${変数}`` の両方がサポートされています。シェルの拡張形式である ``$変数-default`` と ``${変数/foo/bar}`` はサポートされません。

.. You can use a $$ (double-dollar sign) when your configuration needs a literal dollar sign. This also prevents Compose from interpolating a value, so a $$ allows you to refer to environment variables that you don’t want processed by Compose.

``$$`` （二重ドル記号）を指定する時は、設定ファイル上でリテラルなドル記号の設定が必要です。Compose は値を補完しませんので、 ``$$`` の指定により、 Compose によって処理されずに環境変数を参照します。

.. code-block:: yaml

   web:
     build: .
     command: "$$VAR_NOT_INTERPOLATED_BY_COMPOSE"

.. If you forget and use a single dollar sign ($), Compose interprets the value as an environment variable and will warn you:

もしも間違えてドル記号（ ``$`` ）だけにしたら、 Compose は環境変数の値を解釈し、次のように警告を表示します。

.. The VAR_NOT_INTERPOLATED_BY_COMPOSE is not set. Substituting an empty string.

.. code-block:: bash

   The VAR_NOT_INTERPOLATED_BY_COMPOSE is not set. Substituting an empty string.

.. Compose documentation

Compose に関するドキュメント
==============================

..    User guide
    Installing Compose
    Get started with Django
    Get started with Rails
    Get started with WordPress
    Command line reference

* :doc:`/compose/overview`
* :doc:`/compose/install`
* :doc:`/compose/django`
* :doc:`/compose/rails`
* :doc:`/compose/wordpress`
* :doc:`/compose/reference/index`

.. seealso:: 

   Compose file reference
      https://docs.docker.com/compose/compose-file/

