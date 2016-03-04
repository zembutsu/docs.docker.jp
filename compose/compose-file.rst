.. -*- coding: utf-8 -*-
.. https://docs.docker.com/compose/compose-file/
.. doc version: 1.9
.. check date: 2016/01/20
.. -----------------------------------------------------------------------------

.. Compose file reference

.. _compose-file-reference:

=======================================
Compose ファイル・リファレンス
=======================================

.. The compose file is a YAML file where all the top level keys are the name of a service, and the values are the service definition. The default path for a compose file is ./docker-compose.yml.

Compose ファイルは `YAML <http://yaml.org/>`_ ファイルであり、全てのトップ・レベルのキー（key）はサービスの名前であり、値（value）はサービスの定義です。Compose ファイルのデフォルトのパスは ``./docker-compose.yml`` です。

.. Each service defined in docker-compose.yml must specify exactly one of image or build. Other keys are optional, and are analogous to their docker run command-line counterparts.

``docker-compose.yml`` で定義される各サービスは、 ``image`` か ``build`` のどちらかを指定する必要があります。他のキーはオプションであり、それらは ``docker run`` コマンド・ラインに対応するものに似ています。

.. As with docker run, options specified in the Dockerfile (e.g., CMD, EXPOSE, VOLUME, ENV) are respected by default - you don’t need to specify them again in docker-compose.yml.

``docker run`` では、 Dockerfile で指定したオプション（例： ``CMD`` 、 ``EXPOSE`` 、 ``VOLUME`` 、``ENV`` ）はデフォルトとして尊重されます。そのため、 ``docker-compose.yml`` で再び指定する必要がありませ。

.. Service configuration reference

.. _service-configuration-reference:

サービス設定リファレンス
==============================

.. This section contains a list of all configuration options supported by a service definition.

このセクションは、サービスを定義するためにサポートされている設定オプションの一覧を含みます。

.. build

build
----------

.. Either a path to a directory containing a Dockerfile, or a url to a git repository.

Dockerfile を含むディレクトリのパスか Git レポジトリの URL を指定します。

.. When the value supplied is a relative path, it is interpreted as relative to the location of the Compose file. This directory is also the build context that is sent to the Docker daemon.

相対パスで値を指定する時は、Compose ファイルの場所に対する相対パスとして扱われます。また、このディレクトリは構築コンテキスト（build context）であり、Docker デーモンに送られます。

.. Compose will build and tag it with a generated name, and use that image thereafter.

Compose は構築を行い、生成時の名前でタグ付けし、その後にイメージとして使います。

.. code-block:: yaml

   build: /path/to/build/dir

.. Using build together with image is not allowed. Attempting to do so results in an error.

``build`` と ``image`` は同時に使えません。実行してもエラーになります。

.. cap_add, cap_drop

cap_add, cap_drop
--------------------

.. Add or drop container capabilities. See man 7 capabilities for a full list.

コンテナの機能（capabilities）を追加・削除します。機能の一覧については ``man 7 capabilities`` をご覧ください。

.. code-block:: yaml

   cap_add:
     - ALL
   
   cap_drop:
     - NET_ADMIN
     - SYS_ADMIN

command
----------

.. Override the default command.

デフォルトのコマンドを上書きします。

.. code-block:: yaml

   command: bundle exec thin -p 3000

cgroup_parent
--------------------

.. Specify an optional parent cgroup for the container.

コンテナに対し、オプションの親グループを指定します。

.. code-block:: yaml

   cgroup_parent: m-executor-abcd

container_name
--------------------

.. Specify a custom container name, rather than a generated default name.

デフォルトで生成される名前ではなく、カスタム・コンテナ名を指定します。

.. code-block:: yaml

   container_name: my-web-container

.. Because Docker container names must be unique, you cannot scale a service beyond 1 container if you have specified a custom name. Attempting to do so results in an error.

Docker コンテナ名はユニークである必要があるので、カスタム名を指定すると、サービスは複数のコンテナにスケールできなくなります。

devices
----------

.. List of device mappings. Uses the same format as the --device docker client create option.

デバイス・マッピングの一覧を表示します。docker クライアントで作成する際の ``--device`` と同じ形式を使います。

.. code-block:: yaml

   devices:
     - "/dev/ttyUSB0:/dev/ttyUSB0"

dns
----------

.. Custom DNS servers. Can be a single value or a list.

DNS サーバの設定を変更します。単一の値、もしくはリストになります。

.. code-block:: yaml

   dns: 8.8.8.8
   dns:
     - 8.8.8.8
     - 9.9.9.9

dns_search
----------

.. Custom DNS search domains. Can be a single value or a list.

DNS の検索ドメインを変更します。単一の値、もしくはリストになります。

.. code-block:: yaml

   dns_search: example.com
   dns_search:
     - dc1.example.com
     - dc2.example.com

dockerfile
----------

.. Alternate Dockerfile.

別の Dockerfile を指定します。

.. Compose will use an alternate file to build with. A build path must also be specified using the build key.

Compose は構築時に別のファイルを使います。 ``build`` キーを使い、構築時のパス指定が必須です。

.. code-block:: yaml

   build: /path/to/build/dir
   dockerfile: Dockerfile-alternate

.. Using dockerfile together with image is not allowed. Attempting to do so results in an error.

``dockerfile`` と ``image`` は同時に使えません。実行してもエラーになります。

env_file
----------

.. Add environment variables from a file. Can be a single value or a list.

ファイル上の定義から環境変数を追加します。単一の値、もしくはリストになります。

.. If you have specified a Compose file with docker-compose -f FILE, paths in env_file are relative to the directory that file is in.

Compose ファイルを ``docker-compose -f ファイル名`` で指定する場合は、 ``env_file`` ファイルは、指定したディレクトリに対する相対パスとみなします。

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

environment
--------------------

.. Add environment variables. You can use either an array or a dictionary. Any boolean values; true, false, yes no, need to be enclosed in quotes to ensure they are not converted to True or False by the YML parser.

環境変数を追加します。配列もしくは辞書形式（dictionary）で指定できます。boolean 値は true、false、yes、no のいずれかであり、YML パーサによって True か False に変換されるよう、クォート（ ' 記号）で囲む必要があります。

.. Environment variables with only a key are resolved to their values on the machine Compose is running on, which can be helpful for secret or host-specific values.

キーだけの環境変数は、Compose の実行時にマシン上で指定するもので有り、シークレット（訳注：API鍵などの秘密情報）やホスト固有の値を指定するのに便利です。

.. code-block:: yaml

   environment:
     RACK_ENV: development
     SHOW: 'true'
     SESSION_SECRET:
   
   environment:
     - RACK_ENV=development
     - SHOW=true
     - SESSION_SECRET

expose
----------

.. Expose ports without publishing them to the host machine - they’ll only be accessible to linked services. Only the internal port can be specified.

ホストマシン上で公開するポートを指定せずに、コンテナの公開（露出）用のポート番号を指定します。これらはリンクされたサービス間でのみアクセス可能になります。内部で使うポートのみ指定できます。

.. code-block:: yaml

   expose:
    - "3000"
    - "8000"

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

サービスを拡張する ``service`` の名前とは、たとえば、 ``web`` や ``database`` です。 ``file`` はサービスを定義する Compose 設定ファイルの場所です。

.. If you omit the file Compose looks for the service configuration in the current file. The file value can be an absolute or relative path. If you specify a relative path, Compose treats it as relative to the location of the current file.

``file`` を省略すると、Compose は現在の設定ファイル上からサービスの定義を探します。 ``file`` の値は相対パスまたは絶対パスです。相対パスを指定すると、Compose はその場所を、現在のファイルからの相対パスとして扱います。

.. You can extend a service that itself extends another. You can extend indefinitely. Compose does not support circular references and docker-compose returns an error if it encounters one.

自分自身を他に対して拡張するサービス定義ができます。拡張は無限に可能です。Compose は循環参照をサポートしておらず、もし循環参照があれば ``docker-compose`` はエラーを返します。

.. For more on extends, see the the extends documentation.

``extends`` に関するより詳細は、 :ref:`extends ドキュメント <extending-services>` をご覧ください。

external_links
--------------------

.. Link to containers started outside this docker-compose.yml or even outside of Compose, especially for containers that provide shared or common services. external_links follow semantics similar to links when specifying both the container name and the link alias (CONTAINER:ALIAS).

対象の ``docker-compose.yml`` の外にあるコンテナだけでなく、Compose の外にあるコンテナとリンクします。特に、コンテナが共有サービスもしくは一般的なサービスを提供している場合に有用です。 ``external_links`` でコンテナ名とエイリアスを指定すると（ ``コンテナ名:エイリアス名`` ）、 ``link`` のように動作します。

.. code-block:: yaml

   external_links:
    - redis_1
    - project_db_1:mysql
    - project_db_1:postgresql

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


image
----------

.. Tag or partial image ID. Can be local or remote - Compose will attempt to pull if it doesn’t exist locally.

タグもしくはイメージ ID の一部を指定します。ローカルでもリモートでも指定できます。Compose はローカルにイメージが存在しなければ、リモートからの取得を試みます

.. code-block:: yaml

   image: ubuntu
   image: orchardup/postgresql
   image: a4bc65fd

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

.. An entry with the alias’ name will be created in /etc/hosts inside containers for this service, e.g:

エイリアス名として指定したエントリは、 ``/etc/hosts`` ファイルの中でサービス名を示すものとして追加されます。例：

.. code-block:: yaml

   172.17.2.186  db
   172.17.2.186  database
   172.17.2.187  redis

.. Environment variables will also be created - see the environment variable reference for details.

また、環境変数も作成されます。詳細は :doc:`環境変数リファレンス </compose/env>` をご覧ください。

log_driver
----------

.. Specify a logging driver for the service’s containers, as with the --log-driver option for docker run (documented here).

docker run 実行時、サービスのコンテナに対するログ記録ドライバを ``--log-driver`` で指定します（ :doc:`ドキュメントはこちらです </reference/logging/overview>` ）。

.. The default value is json-file.

デフォルト値は json-file（JSON ファイル形式）です。

.. code-block:: yaml

   log_driver: "json-file"
   log_driver: "syslog"
   log_driver: "none"

..    Note: Only the json-file driver makes the logs available directly from docker-compose up and docker-compose logs. Using any other driver will not print any logs.

.. note::

   ``docker-compose up`` で実行したあと、 ``docker-compose logs`` コマンドでログを直接表示できるのは ``json-file`` ドライバのみです。他のドライバを使うとログは表示されません。

log_opt
----------

.. Specify logging options with log_opt for the logging driver, as with the --log-opt option for docker run.

``docker run`` 用の ``--log-opt`` オプションと同じように、 ``log_opt`` でログ記録ドライバのオプションを指定します。

.. Logging options are key value pairs. An example of syslog options:

ログ記録オプションは、キー・バリューのペアです。次の例は ``syslog`` のオプションです。

.. code-block:: yaml

   log_driver: "syslog"
   log_opt:
     syslog-address: "tcp://192.168.0.42:123"

net
----------

.. Networking mode. Use the same values as the docker client --net parameter.

ネットワーキング・モードを指定します。これは docker クライアントで ``--net`` パラメータを指定するのと同じものです。

.. code-block:: yaml

   net: "bridge"
   net: "none"
   net: "container:[name or id]"
   net: "host"

pid
----------

.. code-block:: yaml

   pid: "host"

.. Sets the PID mode to the host PID mode. This turns on sharing between container and the host operating system the PID address space. Containers launched with this flag will be able to access and manipulate other containers in the bare-metal machine’s namespace and vise-versa.

PID モードはホストの PID モードを設定します。有効化すると、コンテナとホスト・オペレーティング・システム間で PID アドレス空間を共有します。コンテナにこのフラグを付けて起動すると、他のコンテナからアクセスできるだけでなく、ベアメタル・マシン上の名前空間などから操作できるようになります。

ports
----------

.. Expose ports. Either specify both ports (HOST:CONTAINER), or just the container port (a random host port will be chosen).

公開用のポートです。ホスト側とコンテナ側の両方のポートを指定（ ``ホスト側:コンテナ側`` ）できるだけでなく、コンテナ側のポートのみも指定できます（ホスト側はランダムなポートが選ばれます）。

..    Note: When mapping ports in the HOST:CONTAINER format, you may experience erroneous results when using a container port lower than 60, because YAML will parse numbers in the format xx:yy as sexagesimal (base 60). For this reason, we recommend always explicitly specifying your port mappings as strings.

.. note::

   ``ホスト側:コンテナ側`` の書式でポートを割り当てる時、コンテナのポートが 60 以下であればエラーが発生します。これは YALM が ``xx:yy`` 形式の指定を、60 進数（60が基準）の数値とみなすからです。そのため、ポートの割り当てには常に文字列として指定することを推奨します（訳者注： " で囲んで文字扱いにする）。

.. code-block:: yaml

   ports:
    - "3000"
    - "3000-3005"
    - "8000:8000"
    - "9090-9091:8080-8081"
    - "49100:22"
    - "127.0.0.1:8001:8001"
    - "127.0.0.1:5000-5010:5000-5010"

security_opt
--------------------

.. Override the default labeling scheme for each container.

各コンテナに対するデフォルトのラベリング・スキーマ（labering scheme）を上書きします。

.. code-block:: yaml

   security_opt:
     - label:user:USER
     - label:role:ROLE

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

volumes, volume_driver
------------------------------

.. Mount paths as volumes, optionally specifying a path on the host machine (HOST:CONTAINER), or an access mode (HOST:CONTAINER:ro).

ボリュームとしてマウントするパス（場所）を指定します。オプションでホスト・マシン上のパス（ ``ホスト側:コンテナ側`` ）の指定や、アクセス・モードの指定（ ``ホスト側:コンテナ側:ro`` ）も可能です。

.. code-block:: yaml

   volumes:
    - /var/lib/mysql
    - ./cache:/tmp/cache
    - ~/configs:/etc/configs/:ro

.. You can mount a relative path on the host, which will expand relative to the directory of the Compose configuration file being used. Relative paths should always begin with . or ...

ホスト上を相対パスでマウント可能です。このとき、Compose 設定ファイルがあるディレクトリ基準にして扱われます。相対パスの場合は、常に ``.`` もしくは ``..`` で始まります。

.. If you use a volume name (instead of a volume path), you may also specify a volume_driver.

（ボリューム・パスの代わりに）ボリューム名を設定するには、 ``volume_driver`` でも指定できます。

.. code-block:: yaml

   volume_driver: mydriver

..    Note: No path expansion will be done if you have also specified a volume_driver.

.. note::

   ``volume_driver`` を指定すると、パスの拡張は行われません。

.. See Docker Volumes and Volume Plugins for more information.

より詳細な情報は :doc:`Docker ボリューム </engine/userguide/dockervolumes>` や :doc:`ボリューム・プラグイン </engine/extend/plugins_volume>` をご覧ください。

volumes_from
--------------------

.. Mount all of the volumes from another service or container, optionally specifying read-only access(ro) or read-write(rw).

他のサービスやコンテナ上のボリュームをマウントします。オプションで、読み込み専用のアクセス（ ``ro`` ）や読み書き（ ``rw`` ）を指定できます。

.. code-block:: yaml

   volumes_from:
    - service_name
    - container_name
    - service_name:rw

.. cpu_shares, cpuset, domainname, entrypoint, hostname, ipc, mac_address, mem_limit, memswap_limit, privileged, read_only, restart, stdin_open, tty, user, working_dir

.. _compose-options:

その他
----------

.. Each of these is a single value, analogous to its docker run counterpart.

cpu_shares、 cpuset、 domainname、 entrypoint、 hostname、 ipc、 mac_address、 mem_limit、 memswap_limit、 privileged、 read_only、 restart、 stdin_open、 tty、 user、 working_dir は、それぞれ単一の値を持ちます。いずれも :doc:`docker run </engine/reference/run/>` に対応します。

.. code-block:: yaml

   cpu_shares: 73
   cpuset: 0,1
   
   entrypoint: /code/entrypoint.sh
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

.. Variable substitution

.. _variable-substitution:

変数の置き換え
====================

.. Your configuration options can contain environment variables. Compose uses the variable values from the shell environment in which docker-compose is run. For example, suppose the shell contains POSTGRES_VERSION=9.3 and you supply this configuration:

設定オプションでは環境変数も含めることができます。シェル上の Compose は ``docker-compose`` の実行時に環境変数を使えます。例えば、シェルで ``POSTGRES_VERSION=9.3`` という変数を設定ファイルで扱うには、次のようにします。

.. code-block:: yaml

   db:
     image: "postgres:${POSTGRES_VERSION}"

.. When you run docker-compose up with this configuration, Compose looks for the POSTGRES_VERSION environment variable in the shell and substitutes its value in. For this example, Compose resolves the image to postgres:9.3 before running the configuration.

この設定で``docker-compose up`` を実行すると、Compose は ``POSTGRES_VERSION`` 環境変数をシェル上で探し、それを値と置き換えます。この例では、Compose が設定ファイルを実行する前に、 ``image`` に対して ``postgres:9.3`` を与えます。

.. If an environment variable is not set, Compose substitutes with an empty string. In the example above, if POSTGRES_VERSION is not set, the value for the image option is postgres:.

環境変数が設定されていなければ、Compose は空の文字列に置き換えます。先の例では、 ``POSTGRES_VERSION`` が設定されなければ、 ``image`` オプションは ``postgres:`` となります。

.. Both $VARIABLE and ${VARIABLE} syntax are supported. Extended shell-style features, such as ${VARIABLE-default} and ${VARIABLE/foo/bar}, are not supported.

``$変数`` と ``${変数}`` の両方がサポートされています。シェルの拡張形式である ``$変数-default`` と ``${変数/foo/bar}`` はサポートされません。

.. You can use a $$ (double-dollar sign) when your configuration needs a literal dollar sign. This also prevents Compose from interpolating a value, so a $$ allows you to refer to environment variables that you don’t want processed by Compose.

``$$`` （二重ドル記号）を指定する時は、設定ファイル上でリテラルなドル記号の設定が必要です。Compose は値を補完しないので、 ``$$`` の指定により、 Compose によって処理されずに環境変数を参照します。

.. code-block:: yaml

   web:
     build: .
     command: "$$VAR_NOT_INTERPOLATED_BY_COMPOSE"

.. If you forget and use a single dollar sign ($), Compose interprets the value as an environment variable and will warn you:

もしも間違えてドル記号（ ``$`` ）だけにすると、 Compose は環境変数の値を解釈し、次のように警告を表示します。

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

* :doc:`/compose/index`
* :doc:`/compose/install`
* :doc:`/compose/django`
* :doc:`/compose/rails`
* :doc:`/compose/wordpress`
* :doc:`/compose/reference/index`
