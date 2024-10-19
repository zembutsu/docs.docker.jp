.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/compose-file/compose-file-v2/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/compose-file/compose-file-v2.md
.. check date: 2022/02/10
.. Commits on Sep 13, 2021 173d3c65f8e7df2a8c0323594419c18086fc3a30
.. ----------------------------------------------------------------------------

.. Compose file version 2 reference

.. _compose-file-version-2-reference:

=======================================
Compose ファイル version 2 リファレンス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Reference and guidelines

.. _v2-reference-and-guidelines:

リファレンスと方針
==============================

.. These topics describe version 2 of the Compose file format.

以下のトピックでは、 Compose ファイル形式バージョン2について説明します。

.. Compose and Docker compatibility matrix

Compose と Docker の互換表
==============================

.. There are several versions of the Compose file format – 1, 2, 2.x, and 3.x. The table below is a quick look. For full details on what each version includes and how to upgrade, see About versions and upgrading.

Compose ファイル形式には、1 、 2 、 2.x 、 3.x のように複数のバージョンがあります。下にある表をちらっと見てみましょう。各バージョンの詳細についてや、アップグレードの仕方については、 :doc:`compose-versioning` をご覧ください。


.. This table shows which Compose file versions support specific Docker releases.

この表は、各 Compose ファイル形式を、どの Docker リリースでサポートしているかを表します。

.. list-table::
   :header-rows: 1

   * - Compose ファイル形式
     - Docker Engine リリース
   * - Compose 仕様
     - 19.03.0+
   * - 3.8
     - 19.03.0+
   * - 3.7
     - 18.06.0+
   * - 3.6
     - 18.02.0+
   * - 3.5
     - 17.12.0+
   * - 3.4
     - 17.09.0+
   * - 3.3
     - 17.06.0+
   * - 3.2
     - 17.04.0+
   * - 3.1
     - 1.13.1+
   * - 3.0
     - 1.13.0+
   * - 2.4
     - 17.12.0+
   * - 2.3
     - 17.06.0+
   * - 2.2
     - 1.13.0+
   * - 2.1
     - 1.12.0+
   * - 2.0
     - 1.10.0+

.. In addition to Compose file format versions shown in the table, the Compose itself is on a release schedule, as shown in Compose releases, but file format versions do not necessarily increment with each release. For example, Compose file format 3.0 was first introduced in Compose release 1.10.0, and versioned gradually in subsequent releases.

先ほどの表中にある Compose ファイル形式のバージョンに加え、Compose 自身も `Compose リリースのページ <https://github.com/docker/compose/releases/>`_ にリリース情報の一覧があります。しかし、ファイル形式のバージョンは、各リリースごとに増えていません。たとえば、Compose ファイル形式 3.0 が始めて導入されたのは、 `Compose リリース 1.10.0 <https://github.com/docker/compose/releases/tag/1.10.0>`_ からであり、以降はリリースに従って順々とバージョンが割り当てられています。

.. The latest Compose file format is defined by the Compose Specification and is implemented by Docker Compose 1.27.0+.

最新の Compose ファイル形式は `Compose 仕様`_ で定義されており、 Docker Compose **1.27.0 以上** から実装されています。

.. Service configuration reference

.. _compose-file-v2-service-configuration-reference:

サービス設定リファレンス
==============================

.. The Compose file is a YAML file defining services, networks and volumes. The default path for a Compose file is ./docker-compose.yml.

Compose ファイルは `YAML <http://yaml.org/>`_ ファイルであり、 :ref:`サービス（services） <service-configuration-reference>` 、 :ref:`ネットワーク（networks） <network-configuration-reference>` 、 :ref:`ボリューム（volumes） <volume-configuration-reference>` を定義します。Compose ファイルのデフォルトのパスは ``./docker-compose.yml`` です。

.. Tip: You can use either a .yml or .yaml extension for this file. They both work.

.. tip::

   このファイルは ``.yml`` か ``.yaml`` いずれか一方の拡張子を利用できます。どちらも機能します。

.. A service definition contains configuration that is applied to each container started for that service, much like passing command-line parameters to docker run. Likewise, network and volume definitions are analogous to docker network create and docker volume create.

サービスの定義に入るのは、コマンドラインで ``docker run`` にパラメータを渡すのと同じように、サービスとして起動するコンテナに対して適用する設定です。同様に、ネットワークやボリュームの定義も ``docker network create`` や ``docker volume create`` と似ています。

.. As with docker run, options specified in the Dockerfile, such as CMD, EXPOSE, VOLUME, ENV, are respected by default - you don’t need to specify them again in docker-compose.yml.

``docker run`` と同様に、 Dockerfile で指定した ``CMD`` 、 ``EXPOSE`` 、 ``VOLUME`` 、``ENV`` のようなオプションが、デフォルト（の設定値）として尊重されます。そのため、 ``docker-compose.yml`` で再び指定する必要はありません。

.. You can use environment variables in configuration values with a Bash-like ${VARIABLE} syntax - see variable substitution for full details.

Bash のような ``${変数名}`` の構文を使い、環境変数を設定値として使用できます。詳しくは :ref:`compose-file-variable-substitution` をご覧ください。

.. This section contains a list of all configuration options supported by a service definition in version 2.

.. This section contains a list of all configuration options supported by a service definition.

このセクションでは、（Docker Compose）バージョン2のサービス定義用にサポートされている、設定オプションの一覧を扱います。

.. blkio_config

.. _compose-file-blkio_config:

blkio_config
--------------------

.. A set of configuration options to set block IO limits for this service.

対象のサービスに対し、:ruby:`ブロック IO 制限 <block IO limits>` を指定するためのオプション設定です。

::

   version: "2.4"
   services:
     foo:
       image: busybox
       blkio_config:
         weight: 300
         weight_device:
           - path: /dev/sda
             weight: 400
         device_read_bps:
           - path: /dev/sdb
             rate: '12mb'
         device_read_iops:
           - path: /dev/sdb
             rate: 120
         device_write_bps:
           - path: /dev/sdb
             rate: '1024k'
         device_write_iops:
           - path: /dev/sdb
             rate: 30

.. device_read_bps, device_write_bps

device_read_bps, device_write_bps
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Set a limit in bytes per second for read / write operations on a given device. Each item in the list must have two keys:

指定するデバイスに対し、読み書き処理を1秒あたりのバイト数（バイト/秒）で制限する設定です。記載する項目ごとに、2つのキーが必要です。

..    path, defining the symbolic path to the affected device
    rate, either as an integer value representing the number of bytes or as a string expressing a byte value.

* ``path`` 、対象となるデバイスを示す（ファイルシステム上に見える） :ruby:`パス <path>` を定義
* ``rate`` 、（制限する転送レートとして）バイト数を整数の値で表すか、（転送レートの） :ref:`バイト値 <compose-file-v2-specifying-byte-values>` を文字列で表す

device_read_iops, device_write_iops
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Set a limit in operations per second for read / write operations on a given device. Each item in the list must have two keys:

指定するデバイスに対し、1秒あたりの処理数を制限する設定です。記載する項目ごとに、2つのキーが必要です。

..  path, defining the symbolic path to the affected device
    rate, as an integer value representing the permitted number of operations per second.

* ``path`` 、対象となるデバイスを示す（ファイルシステム上に見える） :ruby:`パス <path>` を定義
* ``rate`` 、整数の値で1秒間で許可される操作数を表す

weight
^^^^^^^^^^

.. Modify the proportion of bandwidth allocated to this service relative to other services. Takes an integer value between 10 and 1000, with 500 being the default.

他のサービスと比較し、指定対象のサービスに割り当てられる帯域の割合を変更。値は 10 から 1000 までの整数で、デフォルトは 500 です。

weight_device
^^^^^^^^^^^^^^^^^^^^

.. Fine-tune bandwidth allocation by device. Each item in the list must have two keys:

デバイスに割り当てる帯域を微調整します。記載する項目ごとに、2つキーが必要です。

..  path, defining the symbolic path to the affected device
    weight, an integer value between 10 and 1000

* ``path`` 、対象となるデバイスを示す（ファイルシステム上に見える） :ruby:`パス <path>` を定義
* ``weight`` 、値は 10 から 1000 までの整数

.. build

.. _compose-file-build:

build
----------

.. Configuration options that are applied at build time.

:ruby:`構築時 <build time>` に適用するオプションを指定します。

.. build can be specified either as a string containing a path to the build context:

``build`` では :ruby:`構築コンテキスト <build context>` へのパスを含む文字列を指定できます。

.. code-block:: yaml

   version: "2.4"
   services:
     webapp:
       build: ./dir

.. Or, as an object with the path specified under context and optionally Dockerfile and args:

または、 :ref:`context <compose-file-context>` 配下のパスにある特定の（ファイルやディレクトリなどの）物（オブジェクト）と、 :ref:`Dockerfile <compose-file-dockerfile>` のオプションと :ref:`引数 <compose-file-args>` を指定できます。

.. code-block:: yaml

   version: "2.4"
   services:
     webapp:
       build:
         context: ./dir
         dockerfile: Dockerfile-alternate
         args:
           buildno: 1

.. If you specify image as well as build, then Compose names the built image with the webapp and optional tag specified in image:

``build`` と同様に ``image`` （Docker イメージ）も指定する場合、  ``image`` の場所で指定された ``webapp`` とオプションの ``tag`` を使い、 Docker Compose が構築されるイメージに名前を付けます。

.. code-block:: yaml

   build: ./dir
   image: webapp:tag

.. This results in an image named webapp and tagged tag, built from ./dir.

つまり、 ``./`` 以下から :ruby:`構築 <build>` した結果、 ``webapp`` という名前と ``tag`` というタグ名を持つイメージができます。

.. context

.. _compose-file-context:

context
^^^^^^^^^^^^^^^^^^^^

.. Added in version 2.0 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-2` で追加されました。

.. Either a path to a directory containing a Dockerfile, or a url to a git repository.

Dockerfile を含むディレクトリのパス、あるいは、git リポジトリへの URL を指定します。

.. When the value supplied is a relative path, it is interpreted as relative to the location of the Compose file. This directory is also the build context that is sent to the Docker daemon.

相対パスとして値を指定すると、 Compose ファイルがある場所を基準とした相対パスとして解釈されます。また、そのディレクトリが構築コンテキストとなり、その内容が Docker デーモンに対して送られます。

.. Compose will build and tag it with a generated name, and use that image thereafter.

Compose は作成時の名前を使ってイメージ構築やタグ付けをし、以降は、そのイメージを使います。

.. code-block:: yaml

   build:
     context: ./dir

.. dockerfile

.. _compose-file-dockerfile:

dockerfile
^^^^^^^^^^^^^^^^^^^^

.. Alternate Dockerfile.

別の Dockerfile を指定します。


.. Compose uses an alternate file to build with. A build path must also be specified.

.. Compose will use an alternate file to build with. A build path must also be specified.

Compose は別の Dockerfile ファイルを使い構築します。 :ruby:`構築パス <build path>` の指定も必要です（訳者注：構築コンテキスト、つまり、使いたい Dockerfile のある場所を指定）。

.. code-block:: yaml

   build:
     context: .
     dockerfile: Dockerfile-alternate

.. args

.. _compose-file-args:

args
^^^^^^^^^^^^^^^^^^^^

.. Added in version 2.0 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-2` で追加されました。

.. Add build arguments, which are environment variables accessible only during the build process.

build の :ruby:`引数 <arg>` （構築時のオプション）を指定します。ここで指定した引数は、構築の処理中のみ環境変数として利用できます。

.. First, specify the arguments in your Dockerfile:

まずはじめに、 Dockerfile 内で引数を指定しておきます。

.. code-block:: yaml

   # syntax=docker/dockerfile:1
   
   ARG buildno
   ARG gitcommithash
   
   RUN echo "Build number: $buildno"
   RUN echo "Based on commit: $gitcommithash"

そして、 ``build`` キーの下で引数を指定します。 :ruby:`マッピング <mapping>` またはリストで引数を渡します。

.. code-block:: yaml

   build:
     context: .
     args:
       buildno: 1
       gitcommithash: cdc3b19

.. code-block:: yaml

   build:
     context: .
     args:
       - buildno=1
       - gitcommithash=cdc3b19

..     Scope of build-args
    In your Dockerfile, if you specify ARG before the FROM instruction, ARG is not available in the build instructions under FROM. If you need an argument to be available in both places, also specify it under the FROM instruction. Refer to the understand how ARGS and FROM interact section in the documentation for usage details.

.. note:: **buildにおけるargの範囲** 

   Dockerfile で、 ``FROM`` 命令の前に ``ARG`` 命令を指定すると、 ``FROM`` 命令以下の構築処理で ``ARG`` を利用できなくなります。もし両方で使いたい場合には、 ``FROM`` 命令の下でも指定する必要があります。使い方の詳細についてのドキュメントは :ref:`understand-how-arg-and-from-interact` を参照ください。

.. You can omit the value when specifying a build argument, in which case its value at build time is the value in the environment where Compose is running.

biuld 引数に対して値を指定しない場合は、Compose を実行時、環境変数の値が構築時の値として使用されます。

.. code-block:: yaml

   args:
     - buildno
     - gitcommithash

..     Tip when using boolean values
    YAML boolean values ("true", "false", "yes", "no", "on", "off") must be enclosed in quotes, so that the parser interprets them as strings.

.. tip:: **ブール値を使う場合**

   YAML の :ruby:`ブール値 <boolean values>` （ ``"true"`` , ``"false"`` , ``"yes"`` , ``"no"`` , ``"on"`` , ``"off"`` ）は、引用符で囲む必要があり、そうするとパーサは文字列としてそれらを解釈します。

.. _compose-file-cache_from:

cache_from
^^^^^^^^^^^^^^^^^^^^

.. Added in version 2.2 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-22` で追加されました。

.. A list of images that the engine uses for cache resolution.

Engine がキャッシュの解決に使うイメージの一覧。

.. code-block:: yaml

   build:
     context: .
     cache_from:
       - alpine:latest
       - corp/web_app:3.14

.. _compose-file-extra_hosts:

extra_hosts
^^^^^^^^^^^^^^^^^^^^

.. Add hostname mappings at build-time. Use the same values as the docker client --add-host parameter.


構築時に割り当てる（マッピングする）ホスト名を追加します。docker クライアントで ``--add-host`` パラメータを追加するのと同じ働きをします。

.. code-block:: yaml

   extra_hosts:
     - "somehost:162.242.195.82"
     - "otherhost:50.31.209.229"


.. An entry with the ip address and hostname is created in /etc/hosts inside containers for this build, e.g:

次のように、構築時にコンテナ内の ``/etc/hosts`` にIP アドレスとホスト名の項目が作成されます。

::

   162.242.195.82  somehost
   50.31.209.229   otherhost

.. _compose-file-isolation:

isolation
^^^^^^^^^^^^^^^^^^^^

.. Added in version 2.1 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-21` で追加されました。

.. Specify a build’s container isolation technology. On Linux, the only supported value is default. On Windows, acceptable values are default, process and hyperv. Refer to the Docker Engine docs for details.

構築時のコンテナ :ruby:`分離 <isolation>` 技術を指定します。 Linux 上で唯一サポートされている値は ``default`` です。Windows では ``default`` 、 ``process`` 、``hyperv`` を指定できます。詳細は :ref:`Docker Engine のドキュメント <specify-isolation-technology-for-container---isolation>` をご覧ください。

.. If unspecified, Compose will use the isolation value found in the service’s definition to determine the value to use for builds.

指定が無い場合、 Compose が構築に使う値の決定には、サービスの定義で見つかった isolation 値を使います。

.. _compose-file-labels:

labels
^^^^^^^^^^^^^^^^^^^^

.. Added in version 2.1 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-21` で追加されました。

.. Add metadata to the resulting image using Docker labels. You can use either an array or a dictionary.

:doc:`Docker ラベル </config/labels-custom-metadata>` を使い、結果として作成されるイメージにメタデータを追加します。 :ruby:`配列 <array>` または :ruby:`連想配列 <dictionary>` が使えます。

.. It’s recommended that you use reverse-DNS notation to prevent your labels from conflicting with those used by other software.

指定するラベルが他のソフトウェアで使われているものと重複を避けるには、 :ruby:`逆引き DNS 記法 <reverse-DNS notation>` の利用を推奨します。

.. code-block:: yaml

   build:
     context: .
     labels:
       com.example.description: "Accounting webapp"
       com.example.department: "Finance"
       com.example.label-with-empty-value: ""

.. code-block:: yaml

   build:
     context: .
     labels:
       - "com.example.description=Accounting webapp"
       - "com.example.department=Finance"
       - "com.example.label-with-empty-value"


.. _compose-file-network:

network
^^^^^^^^^^^^^^^^^^^^

.. Added in version 2.w file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-22` で追加されました。

.. Set the network containers connect to for the RUN instructions during build.

``RUN`` 命令で構築中に、コンテナが接続するネットワークを指定します。

.. code-block:: yaml

   build:
     context: .
     network: host

.. code-block:: yaml

   build:
     context: .
     network: custom_network_1


.. Use none to disable networking during build:

``none`` の指定は、構築中にネットワーク機能を無効化します。

.. code-block:: yaml

   build:
     context: .
     network: none

.. _compose-file-shm_size:

shm_size
^^^^^^^^^^^^^^^^^^^^

.. Added in version 2.3 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-23` で追加されました。

.. Set the size of the /dev/shm partition for this build’s containers. Specify as an integer value representing the number of bytes or as a string expressing a byte value.

構築用コンテナの ``/dev/shm`` パーティションの容量を指定します。（容量の）バイト数を整数の値として表すか、 :ref:`バイト値 <compose-file-v2-specifying-byte-values>` の文字列で表します。

.. code-block:: yaml

   build:
     context: .
     shm_size: '2gb'

.. code-block:: yaml

   build:
     context: .
     shm_size: 10000000

.. _compose-file-target:

target
^^^^^^^^^^^^^^^^^^^^

.. Added in version 2.3 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-23` で追加されました。

.. Build the specified stage as defined inside the Dockerfile. See the multi-stage build docs for details.

``Dockerfile`` の中で定義された :ruby:`ステージ <stage>` を指定して構築します。詳細は :doc:`マルチステージ・ビルド </develop/develop-images/multistage-build>` をご覧ください。

.. code-block:: yaml

   build:
     context: .
     target: prod


.. cap_add, cap_drop

.. _compose-file-cap_add-cap_drop:

cap_add, cap_drop
--------------------

.. Add or drop container capabilities. See man 7 capabilities for a full list.

コンテナの :ruby:`ケーパビリティ <capabilities>` を追加・削除します。ケーパビリティの一覧は ``man 7 capabilities`` をご覧ください。

.. code-block:: yaml

   cap_add:
     - ALL
   
   cap_drop:
     - NET_ADMIN
     - SYS_ADMIN


.. _compose-file-cgroup_parent:

cgroup_parent
--------------------

.. Specify an optional parent cgroup for the container.

コンテナに対してオプションの親  cgroup を指定します。

.. code-block:: yaml

   cgroup_parent: m-executor-abcd


.. _compose-file-command:

command
----------

.. Override the default command.

デフォルトの :ruby:`コマンド <command>` を上書きします。

.. code-block:: yaml

   command: bundle exec thin -p 3000

.. The command can also be a list, in a manner similar to dockerfile:

コマンドは、 :ref:`Dockerfile <cmd>` と同じようにリスト形式にもできます。

.. code-block:: yaml

   command: [bundle, exec, thin, -p, 3000]


.. _compose-file-container-name:

container_name
--------------------

.. Specify a custom container name, rather than a generated default name.

自動作成されるコンテナ名ではなく、任意のコンテナ名を指定します。

.. code-block:: yaml

   container_name: my-web-container

.. Because Docker container names must be unique, you cannot scale a service beyond 1 container if you have specified a custom name. Attempting to do so results in an error.

Docker コンテナ名は重複できません。そのため、任意のコンテナ名を指定した場合、サービスは複数のコンテナにスケールできなくなります。

.. _compose-file-cpu_rt_runtime-cpu_rt_period

cpu_rt_runtime、 cpu_rt_period
------------------------------

.. Added in version 2.2 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-22` で追加されました。

.. Configure CPU allocation parameters using the Docker daemon realtime scheduler.

Docker デーモンのリアルタイム・スケジューラが使う CPU 割り当てパラメータを設定します。

.. code-block:: yaml

   cpu_rt_runtime: '400ms'
   cpu_rt_period: '1400us'

.. Integer values will use microseconds as units:

整数の単位はマイクロ秒を使います。

.. code-block:: yaml

   cpu_rt_runtime: 95000
   cpu_rt_period: 11000


.. _compose-file-device_cgroup_rules

device_cgroup_rules
------------------------------

.. Added in version 2.3 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-23` で追加されました。

.. Add rules to the cgroup allowed devices list.

cgroup が :ruby:`許可されたデバイス一覧 <allowed devices list>` にルールを追加します。

.. code-block:: yaml

   device_cgroup_rules:
     - 'c 1:3 mr'
     - 'a 7:* rmw'


.. _compose-file-devices:

devices
----------

.. List of device mappings. Uses the same format as the --device docker client create option.

:ruby:`デバイス・マッピング（割り当て） <device mapping>` の一覧です。docker クライアントで作成するオプションの ``--device`` と同じ形式を使います。

.. code-block:: yaml

   devices:
     - "/dev/ttyUSB0:/dev/ttyUSB0"

.. _compose-file-depends_on:

depends_on
----------

.. Added in version 2.0 file format.

.. hint::

   Compose 形式 :ref:`バージョン 2.0 <compose-file-version-2>` で追加されました。

.. Express dependency between services. Service dependencies cause the following behaviors:

サービス間の :ruby:`依存関係 <dependency>` を明示します。サービス依存関係は、以下の挙動が発生します。

..   docker-compose up starts services in dependency order. In the following example, db and redis are started before web.
    docker-compose up SERVICE automatically includes SERVICE’s dependencies. In the example below, docker-compose up web also creates and starts db and redis.
    docker-compose stop stops services in dependency order. In the following example, web is stopped before db and redis.

* ``docker-compose up`` を実行すると、依存関係の順番に従いサービスを :ruby:`起動 <start>` します。以下の例では、 ``web`` を起動する前に ``db`` と ``redis`` を起動します。
* ``docker-compose up サービス名`` を実行すると、自動的に ``サービス名`` と依存関係のあるサービスも起動します。以下の例では、 ``docker-compose up web`` によって、 ``db`` と ``red`` サービスも作成・起動します。
* ``docker-compose stop`` は、依存関係の順番に従いサービスを :ruby:`停止 <stop>` します。以下の例では、 ``db`` と ``redis`` の前に  ``web`` を停止します。

.. Simple example:

簡単な例：

.. code-block:: bash

   version: "2.4"
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

..     depends_on does not wait for db and redis to be “ready” before starting web - only until they have been started. If you need to wait for a service to be ready, see Controlling startup order for more on this problem and strategies for solving it.

.. note::

   ``depends_on`` では、 ``web`` が起動する前に ``db`` と ``redis`` が「 :ruby:`準備完了 <ready>` 」になるのを待ちません。単に各サービスが起動するのを待つだけです。サービスの準備が完了するまで待つ必要がある場合は、この問題の解決や方針検討のために :doc:`起動順番の制御 </compose/startup-order>` をご覧ください。

.. Added in version 2.1 file format.

.. hint::

   Compose 形式 :ref:`バージョン 2.1compose-file-version-21>` で追加されました。

.. A healthcheck indicates that you want a dependency to wait for another container to be “healthy” (as indicated by a successful state from the healthcheck) before starting.

:ruby:`ヘルスチェック <healthcheck>` が指示するのは、あるコンテナを起動する前に依存関係が必要で、他のコンテナが「 :ruby:`正常 <healthy>`」（ヘルスチェックの状態が成功を示す時）になるまで依待機します。

.. Example:

例：

.. code-block:: yaml

   version: "2.4"
   services:
     web:
       build: .
       depends_on:
         db:
           condition: service_healthy
         redis:
           condition: service_started
     redis:
       image: redis
     db:
       image: postgres
       healthcheck:
         test: "exit 0"

.. In the above example, Compose waits for the redis service to be started (legacy behavior) and the db service to be healthy before starting web.

上の例では、 Compose は ``redis`` サービスが :ruby:`起動完了 <started>` するまで待ち（従来の挙動）、そして、 ``db`` サービスが :ruby:`正常 <healthy>` になった後に、 ``web`` を起動します。

.. See the healthcheck section for complementary information.

補足情報については、 :ref:`healchechek セクション <compose-file-healthcheck>` をご覧ください。

.. _compose-file-dns:

dns
----------

.. Custom DNS servers. Can be a single value or a list.

任意の DNS サーバに設定を変更します。単一の値、もしくはリストになります。

.. code-block:: yaml

   dns: 8.8.8.8

.. code-block:: yaml

   dns:
     - 8.8.8.8
     - 9.9.9.9

.. _compose-file-dns_opt:

dns_opt
----------

.. List of custom DNS options to be added to the container’s resolv.conf file.

コンテナの ``resolv.conf`` ファイルに、任意の DNS オプションをリストで追加。

.. code-block:: yaml

   dns_opt:
     - use-vc
     - no-tld-query

.. _compose-file-dns_search:

dns_search
----------

.. Custom DNS search domains. Can be a single value or a list.

任意のDNS 検索ドメインを変更します。単一の値、もしくはリストになります。

.. code-block:: yaml

   dns_search: example.com

.. code-block:: yaml

   dns_search:
     - dc1.example.com
     - dc2.example.com

.. _compose-file-entrypoint:

entrypoint
----------

.. Override the default entrypoint.

デフォルトの entrypoint を上書きします。

.. code-block:: yaml

   entrypoint: /code/entrypoint.sh

.. The entrypoint can also be a list, in a manner similar to dockerfile:

entrypoint は :ref:`Dockerfile <entrypoint>` と同様にリストにもできます。

.. code-block:: yaml

   entrypoint: ["php", "-d", "memory_limit=-1", "vendor/bin/phpunit"]

.. Setting entrypoint both overrides any default entrypoint set on the service’s image with the ENTRYPOINT Dockerfile instruction, and clears out any default command on the image - meaning that if there’s a CMD instruction in the Dockerfile, it is ignored.

.. note::

   サービス用のイメージが Dockerfile で ``ENTRYPOINT`` 命令を持っていたとしても、 ``entrypoint`` はすべてのデフォルトの entrypoint 設定を上書きします。さらに、イメージ上のデフォルトのコマンドもクリアします。つまり、 Dockerifle 上のに ``CMD`` 命令は無視されます。

.. _compose-file-env_file:

env_file
----------

.. Add environment variables from a file. Can be a single value or a list.

ファイル上の定義から環境変数を追加します。単一の値、もしくはリストになります。

.. If you have specified a Compose file with docker-compose -f FILE, paths in env_file are relative to the directory that file is in.

Compose ファイルを ``docker-compose -f ファイル名`` で指定する場合は、 ``env_file`` ファイルは指定したディレクトリに対する相対パスにあるとみなします。

.. Environment variables declared in the environment section override these values – this holds true even if those values are empty or undefined.

:ref:`environment <compose-file-environment>` でセクションで宣言された環境変数は、これらの値で上書きされます。つまり、値が保持されるのは、それぞれの値が空白もしくは未定義の場合です。

.. code-block:: yaml

   env_file: .env

.. code-block:: yaml

   env_file:
     - ./common.env
     - ./apps/web.env
     - /opt/secrets.env

.. Compose expects each line in an env file to be in VAR=VAL format. Lines beginning with # are treated as comments and are ignored. Blank lines are also ignored.

.. Compose expects each line in an env file to be in VAR=VAL format. Lines beginning with # (i.e. comments) are ignored, as are blank lines.

Compose は各行が ``VAR=VAL`` （変数=値）の形式と想定します。 ``#`` で始まる行はコメントとして無視します。また、空白行も無視します。

.. code-block:: yaml

   # Rails/Rack 環境変数を設定
   RACK_ENV=development

..     Note
    If your service specifies a build option, variables defined in environment files are not automatically visible during the build. Use the args sub-option of build to define build-time environment variables.

.. note::

   サービスに :ref:`biuld <compose-file-build>` オプションを指定している場合、環境変数用ファイルで定義された変数は、構築中に自動で見えるようになりません。構築時の環境変数として定義するには、 ``build`` の :ref:`args <compose-file-args>` サブオプションを使います。

.. The value of VAL is used as is and not modified at all. For example if the value is surrounded by quotes (as is often the case of shell variables), the quotes are included in the value passed to Compose.

``VAL`` の値は、一切変更されることなく、そのまま使われます。たとえば、値がクォートで囲まれていた場合（シェル変数でよくあります）、クォートも値としてそのまま Compose に渡されます。

.. Keep in mind that the order of files in the list is significant in determining the value assigned to a variable that shows up more than once. The files in the list are processed from the top down. For the same variable specified in file a.env and assigned a different value in file b.env, if b.env is listed below (after), then the value from b.env stands. For example, given the following declaration in docker-compose.yml:

「繰り返し現れる変数に対し、割り当てる値を決定するために、リスト内でのファイル順番が重要」なのを忘れないでください。リスト内のファイルは、上から下に処理されます。もしも ``a.env`` ファイルで指定された変数と、同じ変数が ``b.env`` ファイルにあっても、違う値が割り当てられた場合には、 ``b.env`` がリストの下（後方）にあるため、 ``b.env`` の値が有効になります。たとえば、以下のような ``docker-compose.yml`` が宣言されたとします。

.. code-block:: yaml

   services:
     some-service:
       env_file:
         - a.env
         - b.env

.. And the following files:

それぞれのファイルは、

.. code-block:: yaml

   # a.env
   VAR=1

.. and

こちらと、

.. code-block:: yaml

   # b.env
   VAR=hello

.. $VAR is hello.

このような場合、 ``$VAR`` の値は ``hello`` になります。

.. _compose-file-environment:

environment
--------------------

.. Add environment variables. You can use either an array or a dictionary. Any boolean values; true, false, yes no, need to be enclosed in quotes to ensure they are not converted to True or False by the YML parser.

環境変数を追加します。配列もしくは :ruby:`辞書形式 <dictionary>` で指定できます。boolean 値 (true、false、yes、no のいずれか) は、YML パーサによって True か False に変換されないよう、クォート（ ' 記号）で囲む必要があります。

.. Environment variables with only a key are resolved to their values on the machine Compose is running on, which can be helpful for secret or host-specific values.

キーだけの環境変数は、Compose の実行時にマシン上で指定するものであり、 :ruby:`シークレット <secret>`（訳注：API鍵などの秘密情報）やホスト固有の値を指定するのに便利です。

.. code-block:: yaml

   environment:
     RACK_ENV: development
     SHOW: 'true'
     SESSION_SECRET:

.. code-block:: yaml

   environment:
     - RACK_ENV=development
     - SHOW=true
     - SESSION_SECRET

..     Note
    If your service specifies a build option, variables defined in environment files are not automatically visible during the build. Use the args sub-option of build to define build-time environment variables.

.. note::

   サービスに :ref:`biuld <compose-file-build>` オプションを指定している場合、環境変数用ファイルで定義された変数は、構築中に自動で見えるようになりません。構築時の環境変数として定義するには、 ``build`` の :ref:`args <compose-file-args>` サブオプションを使います。


.. _compose-file-expose:

expose
----------

.. Expose ports without publishing them to the host machine - they’ll only be accessible to linked services. Only the internal port can be specified.

コンテナの :ruby:`公開（露出） <expose>` 用のポート番号を指定しますが、ホストマシン上で公開するポートを指定しません。つまり、つながったサービス間でのみアクセス可能になります。内部で使うポートのみ指定できます。

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

``service`` とは、 :ruby:`拡張される <extend>` サービスの名前で、 ``web`` や ``database`` などです。 ``file`` は対象のサービスを定義する Compose 設定ファイルの場所です。

.. If you omit the file Compose looks for the service configuration in the current file. The file value can be an absolute or relative path. If you specify a relative path, Compose treats it as relative to the location of the current file.

``file`` を省略したら、Compose は現在の設定ファイル上からサービスの定義を探します。 ``file`` の値は相対パスまたは絶対パスです。相対パスを指定したら、Compose はその場所を、現在のファイルからの相対パスとして扱います。

.. You can extend a service that itself extends another. You can extend indefinitely. Compose does not support circular references and docker-compose returns an error if it encounters one.

サービス自身が、他に対して拡張するサービス定義をできます。拡張は無限に可能です。Compose は循環参照をサポートしておらず、もし循環参照があれば ``docker-compose`` はエラーを返します。

.. For more on extends, see the the extends documentation.

``extends`` に関するより詳細は、 :ref:`extends ドキュメント <extending-services>` をご覧ください。

.. compose-file-external_links:

external_links
--------------------

.. Link to containers started outside this docker-compose.yml or even outside of Compose, especially for containers that provide shared or common services. external_links follow semantics similar to the legacy option links when specifying both the container name and the link alias (CONTAINER:ALIAS).

対象の ``docker-compose.yml`` の外にあるコンテナだけでなく、Compose の外にあるコンテナとリンクします。特に、コンテナが共有サービスもしくは一般的なサービスを提供している場合に有用です。 ``external_links`` でコンテナ名とエイリアスを指定すると（ ``コンテナ名:エイリアス名`` ）、古い（レガシー）オプション ``link`` のように動作します。

.. code-block:: yaml

   external_links:
    - redis_1
    - project_db_1:mysql
    - project_db_1:postgresql

..     Note    If you’re using the version 2 or above file format, the externally-created containers must be connected to at least one of the same networks as the service that is linking to them. Links are a legacy option. We recommend using networks instead.

.. note::

   :ref:`バージョン２のファイル形式 <compose-file-version-2>` を使う場合、外部に作成したコンテナと接続する必要があれば、接続先のサービスが対象ネットワーク上に少なくとも１つ接続する必要があります。 :ref:`links <compose-file-links>` は古いオプションです。そのかわりに、 :ref:`networks <compose-file-networks>` の使用を推奨します。

.. extra_hosts

.. _compose-file-extra_hosts:

extra_hosts
--------------------

.. Add hostname mappings. Use the same values as the docker client --add-host parameter.

ホスト名を割り当てます（マッピングします）。これは docker クライアントで ``--add-host`` パラメータを使うのと同じ値です。

.. code-block:: yaml

   extra_hosts:
    - "somehost:162.242.195.82"
    - "otherhost:50.31.209.229"

.. An entry with the ip address and hostname is created in /etc/hosts inside containers for this service, e.g:

コンテナ内の ``/etc/hosts`` に、 IP アドレスとホスト名のエントリが追加されます。例：

.. code-block:: yaml

   162.242.195.82  somehost
   50.31.209.229   otherhost

.. group_add

.. _compose-file-group_add:

group_add
--------------------

..  Specify additional groups (by name or number) which the user inside the container should be a member of. Groups must exist in both the container and the host system to be added. An example of where this is useful is when multiple containers (running as different users) need to all read or write the same file on the host system. That file can be owned by a group shared by all the containers, and specified in group_add. See the Docker documentation for more details.

コンテナ内のユーザが所属する可能性のある、追加グループ（名前または番号）を指定します。コンテナ内と追加するホストシステム上の両方で、対象のグループが存在している必要があります。これが役立つ例は、（異なるユーザで動作する）複数のコンテナが、ホストシステム上にある同じファイルを読み書きする場合です。対象ファイルは、すべてのコンテナで共有されるグループで所有でき、そのために ``group_add`` で指定します。詳細については :ref:`Docker のドキュメント <additional-groups>` をご覧ください。

.. A full example:

完全な例：

.. code-block:: yaml

   version: "2.4"
   services:
     myservice:
       image: alpine
       group_add:
         - mail

作成されたコンテナ内で ``id`` （コマンドを）実行すると、対象ユーザが ``mail`` グループに所属していると表示されます。これは、 ``group_add`` を指定しなかった場合の挙動と異なります。

.. healthcheck

.. _compose-file-healthheck:

healthcheck
--------------------

.. Added in version 2.1 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-21` で追加されました。

.. Configure a check that’s run to determine whether or not containers for this service are “healthy”. See the docs for the HEALTHCHECK Dockerfile instruction for details on how healthchecks work.

このサービスのコンテナが「 :ruby:`正常 <healthy>` 」かどうかを判断するために実行する、確認用コマンドを設定します。ヘルスチェックがどのように動作するかの詳細は、 :ref:`HEALTHCHECK Dockerfile 命令 <builder-healthcheck>` のドキュメントをご覧ください。

.. code-block:: yaml

   healthcheck:
     test: ["CMD", "curl", "-f", "http://localhost"]
     interval: 1m30s
     timeout: 10s
     retries: 3
     start_period: 40s

.. interval, timeout and start_period are specified as durations.

``interval`` 、 ``timeout`` 、 ``start_period`` は :ref:`継続時間 <compose-file-healthheck>` として指定します。

.. The start_period option was added in file format 2.3.

.. hint::

   ``start_period`` オプションは、Compose 形式 :ref:`compose-file-version-23` で追加されました。

.. test must be either a string or a list. If it’s a list, the first item must be either NONE, CMD or CMD-SHELL. If it’s a string, it’s equivalent to specifying CMD-SHELL followed by that string.

``test`` は文字列またはリスト形式のどちらかの必要があります。リスト形式の場合、１番目のアイテムは ``NONE`` か ``CMD`` か ``CMD-SHELL`` のどちらかの必要があります。文字列の場合は、 ``CMD-SHELL`` に続けて文字列をを指定するのと同じです。


.. code-block:: yaml

   # ローカルの web アプリを叩く
   test: ["CMD", "curl", "-f", "http://localhost"]

.. As above, but wrapped in /bin/sh. Both forms below are equivalent.

前述したのは ``/bin/sh`` でラッピングされています。以下の２つは同じです。

.. code-block:: yaml

   test: ["CMD-SHELL", "curl -f http://localhost || exit 1"]

.. code-block:: yaml

   test: curl -f https://localhost || exit 1

.. To disable any default healthcheck set by the image, you can use disable: true. This is equivalent to specifying test: ["NONE"].

対象のイメージで設定されているデフォルトのヘルスチェックを無効化するには、 ``disable: true`` を使えます。これは ``test: ["NONE"]`` を指定するのと同じです。

.. code-block:: yaml

   healthcheck:
     disable: true

.. _compose-file-image:

image
----------

.. Specify the image to start the container from. Can either be a repository/tag or a partial image ID.

コンテナの実行時、元になるイメージを指定します。リポジトリ名/タグ、あるいはイメージ ID の一部を（前方一致で）指定できます。

.. code-block:: yaml

   image: redis

.. code-block:: yaml

   image: ubuntu:18.04

.. code-block:: yaml

   image: tutum/influxdb

.. code-block:: yaml

   image: example-registry.com:4000/postgresql

.. code-block:: yaml

   image: a4bc65fd

.. If the image does not exist, Compose attempts to pull it, unless you have also specified build, in which case it builds it using the specified options and tags it with the specified tag.

イメージが存在していなければ、Compose は pull （取得）を試みます。しかし :ref:`build <compose-file-build>` を指定している場合は除きます。その場合、指定されたオプションやタグを使って構築します。

.. init

.. _compose-file-init:

init
--------------------

.. Added in version 2.2 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-22` で追加されました。

.. Run an init inside the container that forwards signals and reaps processes. Set this option to true to enable this feature for the service.

コンテナ内で init を実行し、シグナルの転送と、プロセス :ruby:`再配置 <reap>` します。サービスに対してこの機能を有効化するには、このオプションで ``true`` を指定します。

.. code-block:: yaml

   version: "2.4"
   services:
     web:
       image: alpine:latest
       init: true

.. The default init binary that is used is Tini, and is installed in /usr/libexec/docker-init on the daemon host. You can configure the daemon to use a custom init binary through the init-path configuration option.

.. note::

   デフォルトの init バイナリは、 `Tiny <https://github.com/krallin/tini>`_ が使われ、デーモンのホスト上の ``/usr/libexec/docker-init`` にインストールされます。 任意の init バイナリ使うには、デーモンに対して ``init-path``  :ref:`設定オプション <daemon-configuration-file>` を通して指定できます。

.. isolation

.. _compose-file-isolation:

isolation
--------------------

.. Added in version 2.1 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-21` で追加されました。

.. Specify a container’s isolation technology. On Linux, the only supported value is default. On Windows, acceptable values are default, process and hyperv. Refer to the Docker Engine docs for details.

コンテナの :ruby:`隔離 <isolation>` 技術を指定します。 Linux 上では、唯一サポートしている値が ``default`` です。Windows specify-isolation-technology-for-container-isolation用では、 ``default`` 、 ``process`` 、 ``hyperv`` が指定できます。詳細は、 :ref:`Docker Engine ドキュメント <specify-isolation-technology-for-container-isolation>` をご覧ください。


.. _compose-file-labels:

labels
----------

.. Add metadata to containers using Docker labels. You can use either an array or a dictionary.

:doc:`Docker ラベル </engine/userguide/labels-custom-metadata>` を使い、コンテナに :ruby:`メタデータ <metadata>` を追加します。配列または辞書形式で追加できます。

.. It’s recommended that you use reverse-DNS notation to prevent your labels from conflicting with those used by other software.

他のソフトウェアが使うラベルと競合しないようにするため、 :ruby:`逆引き DNS 記法 <reverse-DNS notation>` の利用を推奨します。

.. code-block:: yaml

   labels:
     com.example.description: "Accounting webapp"
     com.example.department: "Finance"
     com.example.label-with-empty-value: ""

.. code-block:: yaml


   labels:
     - "com.example.description=Accounting webapp"
     - "com.example.department=Finance"
     - "com.example.label-with-empty-value"

.. _compose-file-links:

links
----------

.. Link to containers in another service. Either specify both the service name and a link alias ("SERVICE:ALIAS"), or just the service name.

コンテナを他のサービスと :ruby:`リンク <link>` します。指定するのは、サービス名とリンク用エイリアスの両方（ ``"SERVICE:ALIAS"`` ）か、サービス名だけです。

.. Links are a legacy option. We recommend using networks instead.

.. hint::

   liks はレガシーのオプションです。代わりに :ref:`networks <compose-file-v2-networks>` の利用を推奨します。

.. code-block:: yaml

   links:
    - db
    - db:database
    - redis

.. Containers for the linked service are reachable at a hostname identical to the alias, or the service name if no alias was specified.

リンクするサービスのコンテナは、エイリアスとして認識できるホスト名で到達（接続）可能になります。エイリアスが指定されなければ、サービス名で到達できます。

.. Links are not required to enable services to communicate - by default, any service can reach any other service at that service’s name. (See also, the Links topic in Networking in Compose.)

サービス間で通信するため、links を有効にする必要はありません。デフォルトでは、あらゆるサービスが他のサービスにサービス名で接続できます。（ :ref:`Compose ネットワーク機能における links のトピック <compose-links>` をご覧ください）

.. Links also express dependency between services in the same way as depends_on, so they determine the order of service startup.

また、 links は :ref:`depends_on <compose-file-depends_on>` と同じ方法でサービス間の依存関係表すため、サービスの起動順番を指定できます。

.. If you define both links and networks, services with links between them must share at least one network in common to communicate. We recommend using networks instead.

   links と :ref:`networks <compose-file-networks>` を両方定義すると、リンクしたサービス間で通信するため、少なくとも1つの共通するネットワークが使われます。この links ではなく、 networks の利用を推奨します。

.. _compose-file-logging:

logging
----------

.. Logging configuration for the service.

サービスに対して :ruby:`ログ記録 <logging>` の設定をします。

.. code-block:: yaml

   logging:
     driver: syslog
     options:
       syslog-address: "tcp://192.168.0.42:123"

.. The driver name specifies a logging driver for the service’s containers, as with the --log-driver option for docker run (documented here).

``driver`` にはサービス用のコンテナで使う :ruby:`ロギング・ドライバ <logging driver>` を指定します。これは docker run コマンドにおける ``--log-driver`` オプションと同じです （ :doc:`ドキュメントはこちら </config/containers/logging/configure>` ）。

.. The default value is json-file.

デフォルトの値は json-file です。

.. code-block:: yaml

   driver: "json-file"

.. code-block:: yaml

   driver: "syslog"

.. code-block:: yaml

   driver: "none"

.. Only the json-file and journald drivers make the logs available directly from docker-compose up and docker-compose logs. Using any other driver does not print any logs.

.. note::

   ``docker-compose up`` で立ち上げてから ``docker-compose logs`` コマンドを使い、ログを表示できるのは ``json-file`` と ``journald`` ドライバを指定した時のみです。他のドライバを指定しても、ログは何ら表示されません。

.. Specify logging options for the logging driver with the options key, as with the --log-opt option for docker run.

ロギング・ドライバのオプションを指定するには ``options`` キーを使います。これは ``docker run`` コマンド実行時の ``--log-opt`` オプションと同じです。

.. Logging options are key-value pairs. An example of syslog options:

ロギングのオプションはキーバリューのペアです。以下は ``syslog`` オプションを指定する例です。

.. code-block:: yaml

   driver: "syslog"
   options:
     syslog-address: "tcp://192.168.0.42:123"


.. network_mode

.. _compose-file-network_mode:

network_mode
--------------------

.. Changed in version 2 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-2` で変更されました。

.. Network mode. Use the same values as the docker client --network parameter, plus the special form service:[service name].

ネットワークの動作モードを指定します。 docker クライアントで ``--network`` パラメータを指定する時と同じように使うには、 ``service:[サービス名]`` という特別な形式を加えます。

.. code-block:: yaml

   network_mode: "bridge"

.. code-block:: yaml

   network_mode: "host"

.. code-block:: yaml

   network_mode: "none"

.. code-block:: yaml

   network_mode: "service:[サービス名]"

.. code-block:: yaml

   network_mode: "container:[コンテナ名/id]"

.. networks

.. _	:

networks
----------

.. Changed in version 2 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-2` で変更されました。


.. Networks to join, referencing entries under the top-level networks key.

ネットワークに追加するには、:ref:`トップレベルの networks キー <network-configuration-reference>` の項目をご覧ください。

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

:ruby:`エイリアス <aliases>` （別のホスト名）とは、ネットワーク上のサービスに対してです。同一ネットワーク上の他のコンテナが、サービス名か、このエイリアスを使い、サービス用コンテナの１つに接続します。

.. Since aliases is network-scoped, the same service can have different aliases on different networks

``aliases`` が適用されるのは :ruby:`同一ネットワークの範囲内 <network-scoped>` のみです。そのため、同じサービスでも、ネットワークごとに異なったエイリアスが使えます。

..     Note: A network-wide alias can be shared by multiple containers, and even by multiple services. If it is, then exactly which container the name will resolve to is not guaranteed.

.. note::

   複数のコンテナだけでなく複数のサービスに対しても、ネットワーク範囲内でエイリアスが利用できます。ただしその場合、どのコンテナに対して名前解決されるのかの保証はありません。

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

以下の例では、３つのサービス（ ``web`` 、 ``worker`` 、 ``db`` ）に、２つのネットワーク（ ``new`` と ``legacy`` ）が提供されています。 ``db`` サービスはホスト名 ``db`` または ``database`` として ``new`` ネットワーク上で到達可能です。そして、``legacy`` ネットワーク上では  ``db`` または ``mysql`` として到達できます。

.. code-block:: yaml

   version: "2.4"
   
   services:
     web:
       image: "nginx:alpine"
       networks:
         - new
   
     worker:
       image: "my-worker-image:latest"
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

ipv4_address 、 ipv6_address
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Specify a static IP address for containers for this service when joining the network.

サービスがネットワークへ追加時、コンテナに対して :ruby:`固定 <static>` IP アドレスを割り当てます。

.. The corresponding network configuration in the top-level networks section must have an ipam block with subnet and gateway configurations covering each static address.

:ref:`トップレベルのネットワーク・セクション <network-configuration-reference>` では、適切なネットワーク設定に ``ipam`` ブロックが必要です。ここで、それぞれの固定アドレスが扱うサブネットやゲートウェイを定義します。 

.. If IPv6 addressing is desired, the enable_ipv6 option must be set.

.. note::

   IPv6 アドレスが必要であれば、 ``com.docker.network.enable_ipv6`` ドライバ・オプションを ``true`` にする必要があります。

.. An example:

例：

.. code-block:: yaml

   version: "2.4"
   
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
       enable_ipv6: true
       ipam:
         driver: default
         config:
           - subnet: 172.16.238.0/24
             gateway: 172.16.238.1
           - subnet: 2001:3984:3989::/64
             gateway: 2001:3984:3989::1

.. _link_local_ips:

link_local_ips
^^^^^^^^^^^^^^^^^^^^

.. Added in version 2.1 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-21` で追加されました。

.. Specify a list of link-local IPs. Link-local IPs are special IPs which belong to a well known subnet and are purely managed by the operator, usually dependent on the architecture where they are deployed. Therefore they are not managed by docker (IPAM driver).

:ruby:`リンクローカル IP アドレス <link-local IPs>` の一覧を指定します。リンクローカル IP アドレスは、既知のサブネットに所属する特別な IP アドレスであり、作業者によって純粋に管理されるものです。通常は、どのアーキテクチャにデプロイするかによって依存します。つまり、 docker （IAPMドライバ）によっては管理されていません。

.. Example usage:

使用例：

.. code-block:: yaml

   version: "2.4"
   services:
     app:
       image: busybox
       command: top
       networks:
         app_net:
           link_local_ips:
             - 57.123.22.11
             - 57.123.22.13
   networks:
     app_net:
       driver: bridge


.. priority

.. _compose-file-priority:

priority
^^^^^^^^^^^^^^^^^^^^

.. Specify a priority to indicate in which order Compose should connect the service’s containers to its networks. If unspecified, the default value is 0.

Compose がサービス用コンテナをどのネットワークに接続させるか、その優先度を指定します。指定がない場合、デフォルトの値は ``0`` です。

.. In the following example, the app service connects to app_net_1 first as it has the highest priority. It then connects to app_net_3, then app_net_2, which uses the default priority value of 0.

以下の例では、 ``app`` サービスがまず接続するのは、優先度の高い ``app_net_1`` です。それから、 ``app_net_3`` に接続し、それからデフォルトの優先度が ``0`` の ``app_net_2`` に接続します。

.. code-block:: yaml

   version: "2.4"
   services:
     app:
       image: busybox
       command: top
       networks:
         app_net_1:
           priority: 1000
         app_net_2:
   
         app_net_3:
           priority: 100
   networks:
     app_net_1:
     app_net_2:
     app_net_3:

..     If multiple networks have the same priority, the connection order is undefined.

.. note::

   複数のネットワークが同じ優先度の場合、接続順は未定義になります。


.. _compose-file-pid:

pid
----------

.. code-block:: yaml

   pid: "host"

.. code-block:: yaml

   pid: "container:custom_container_1"

.. code-block:: yaml

   pid: "service:foobar"

.. If set to one of the following forms: container:<container_name>, service:<service_name>, the service shares the PID address space of the designated container or service.

``container:<コンテナ名>`` 、 ``service:<サービス名>`` の形式を指定すると、サービスは指定したコンテナかサービスが使用する PID アドレス空間を共有します。

.. If set to “host”, the service’s PID mode is the host PID mode. This turns on sharing between container and the host operating system the PID address space. Containers launched with this flag can access and manipulate other containers in the bare-metal machine’s namespace and vice versa.

"host" を指定すると、サービスの PID モードは、ホスト PID モードを設定します。これを有効化すると、コンテナとホスト・オペレーティング・システム間で PID アドレス空間を共有します。コンテナにこのフラグを付けて起動すると、、他のコンテナからアクセスできるだけでなく、ベアメタル・マシン上の名前空間などから操作できるようになります。

.. Added in version 2.1 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-21` で追加されました。
   ``service:`` と ``container:`` 形式には、  :ref:`compose-file-version-21` 以上が必要です。

.. _compose-file-pids_limit:

pids_limit
--------------------

.. Added in version 2.1 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-21` で追加されました。

.. Tunes a container’s PIDs limit. Set to -1 for unlimited PIDs.

コンテナの PID 上限を調整します。 ``-1`` を指定すると、 PID は無制限になります。

.. code-block:: yaml

   pids_limit: 10


.. _compose-file-platform:

platform
--------------------

.. Added in version 2.4 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-24` で追加されました。

.. Target platform containers for this service will run on, using the os[/arch[/variant]] syntax, e.g.

サービスを実行するコンテナの、対象プラットフォームを ``os[/arch[/variant]]``  の形式で指定します。以下は例です。

.. code-block:: yaml

   platform: osx

.. code-block:: yaml

   platform: windows/amd64

.. code-block:: yaml

   platform: linux/arm64/v8

.. This parameter determines which version of the image will be pulled and/or on which platform the service’s build will be performed.

このパラメータは、どのイメージを取得するかや、サービスをどのプラットフォームで構築するかを指定します。

.. _compose-file-ports:

ports
----------

.. Expose ports. Either specify both ports (HOST:CONTAINER), or just the container port (a random host port will be chosen).

公開用のポートです。ホスト側とコンテナ側の両方のポートを指定（ ``ホスト側:コンテナ側`` ）できるだけでなく、コンテナ側のポートのみも指定できます（ホスト側はランダムなポートが選ばれます）。

..    Note: When mapping ports in the HOST:CONTAINER format, you may experience erroneous results when using a container port lower than 60, because YAML will parse numbers in the format xx:yy as sexagesimal (base 60). For this reason, we recommend always explicitly specifying your port mappings as strings.

.. note::

   ``ホスト側:コンテナ側`` の形式でポートを割り当てる時、コンテナのポートが 60 以下であればエラーが発生します。これは YAML が ``xx:yy`` 形式の指定を、60 進数（60が基準）の数値とみなすからです。そのため、ポートの割り当てには常に文字列としての指定を推奨します（訳者注： " で囲んで文字扱いにする）。

.. code-block:: yaml

   ports:
    - "3000"
    - "3000-3005"
    - "8000:8000"
    - "9090-9091:8080-8081"
    - "49100:22"
    - "127.0.0.1:8001:8001"
    - "127.0.0.1:5000-5010:5000-5010"
    - "6060:6060/udp"
    - "12400-12500:1240"


.. _compose-file-runtime:

runtime
--------------------

.. Added in version 2.3 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-23` で追加されました。

.. Specify which runtime to use for the service’s containers. Default runtime and available runtimes are listed in the output of docker info.

サービスのコンテナが使う ;ruby:`ランタイム <runtime>` を指定します。デフォルトのランタイムと、利用可能なランタイムの一覧は ``docker info`` の出力から確認できます。

.. code-block:: yaml

   web:
     image: busybox:latest
     command: true
     runtime: runc

.. _compose-file-scale:

scale
--------------------

.. Added in version 2.2 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-22` で追加されました。

.. Specify the default number of containers to deploy for this service. Whenever you run docker-compose up, Compose creates or removes containers to match the specified number. This value can be overridden using the --scale flag.

このサービス用にデプロイする、デフォルトのコンテナ数を指定します。 ``docker-compse up`` を実行するとすぐに、 指定した数に一致するよう Compose がコンテナの作成または削除をします。この値は ``--scale`` フラグを使って上書き可能です。

.. code-block:: yaml

   web:
     image: busybox:latest
     command: echo 'scaled'
     scale: 3


.. _compose-file-security_opt:

security_opt
--------------------

.. Override the default labeling scheme for each container.

各コンテナに対するデフォルトの :ruby:`ラベリング・スキーマ <labeling scheme>` を上書きします。

.. code-block:: yaml

   security_opt:
     - label:user:USER
     - label:role:ROLE


.. -compose-file-stop_grace_period:

stop_grace_period
--------------------

.. Specify how long to wait when attempting to stop a container if it doesn’t handle SIGTERM (or whatever stop signal has been specified with stop_signal), before sending SIGKILL. Specified as a duration.

コンテナを停止するために SIGTERM （あるいは、 ``stop_signal`` で指定した何らかの停止シグナル）を処理出来ない場合、 SIGKILL を送信するまで、どれだけ待機するか指定します。 :ref:`期間 <compose-file-specifying-durations>` として指定します。

.. code-block:: yaml

   stop_grace_period: 1s

.. code-block:: yaml

   stop_grace_period: 1m30s

.. By default, stop waits 10 seconds for the container to exit before sending SIGKILL.

デフォルトでは、コンテナに SIGKILL を送信して終了するまでの ``stop`` ウェイトは 10 秒です。

.. -compose-file-stop_signal:

stop_signal
--------------------

.. Sets an alternative signal to stop the container. By default stop uses SIGTERM. Setting an alternative signal using stop_signal will cause stop to send that signal instead.

コンテナに対して別の停止シグナルを設定します。デフォルトでは ``stop`` で SIGTERM を使います。 ``stop_signal`` で別のシグナルを指定したら、 ``stop`` 実行時にそのシグナルを送信します。

.. code-block:: yaml

   stop_signal: SIGUSR1


.. _compose-file-storage_opt:

storage_opt
--------------------

.. Added in version 2.1 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-21` で追加されました。

.. Set storage driver options for this service.

このサービスに対し、ストレージ・ドライバのオプションを指定します。

.. code-block:: yaml

   storage_opt:
     size: '1G'


.. _compose-file-sysctls:

sysctls
--------------------

.. Added in version 2.1 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-21` で追加されました。

.. Kernel parameters to set in the container. You can use either an array or a dictionary.

コンテナ内でのカーネル・パラメータを指定します。配列もしくはディレクトリのどちらかで指定できます。

.. code-block:: yaml

   sysctls:
     net.core.somaxconn: 1024
     net.ipv4.tcp_syncookies: 0

.. code-block:: yaml

   sysctls:
     - net.core.somaxconn=1024
     - net.ipv4.tcp_syncookies=0

.. tmpfs

.. _copmose-file-tmpfs:

tmpfs
----------

.. Mount a temporary file system inside the container. Can be a single value or a list.

コンテナ内にテンポラリ・ファイルシステムをマウントします。単一の値もしくはリストです。

.. code-block:: yaml

   tmpfs: /run

.. code-block:: yaml

   tmpfs:
     - /run
     - /tmp


.. _copmose-file-ulimits:

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

.. _compose-file-userns_mode:

userns_mode
--------------------

.. Added in version 2.1 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-21` で追加されました。

.. code-block:: yaml

   userns_mode: "host"

.. Disables the user namespace for this service, if Docker daemon is configured with user namespaces. See dockerd for more information.

Docker デーモンでユーザ名前空間の指定があっても、このサービスに対する :ruby:`ユーザ名前空間 <user namespace>` を無効にします。詳しい情報は :ref:`dockerd <disable-user-namespace-for-a-container>` をご覧ください。

.. _compose-file-volumes:

volumes
------------------------------

.. Mount host paths or named volumes. Named volumes need to be specified with the top-level volumes key.

ホスト上のパス、または :ruby:`名前付きボリューム <named volumes>` をマウントします。名前付きボリュームには、 :ref:`トップレベルの volume キー <volume-configuration-reference>` を指定が必要です。

.. _compose-file-volumes-short-syntax:

短い書式
^^^^^^^^^^

.. The short syntax uses the generic [SOURCE:]TARGET[:MODE] format, where SOURCE can be either a host path or volume name. TARGET is the container path where the volume is mounted. Standard modes are ro for read-only and rw for read-write (default).

:ruby:`短い書式 <short syntax>` は、一般的に ``[ソース:]ターゲット[:モード]`` の形式を使います。 ``ソース`` の場所にはホスト上のパスまたはボリューム名のどちらかを指定できます。 ``ターゲット`` とはボリュームがマウントされるコンテナ上のパスです。標準的なモードは、 ``ro`` は :ruby:`読み込み専用 <read-only>` と ``rw`` の :ruby:`読み書き <read-write>` （デフォルト）です。

.. You can mount a relative path on the host, which will expand relative to the directory of the Compose configuration file being used. Relative paths should always begin with . or ...

ホスト上の相対パスをマウント可能です。相対パスは Compose 設定ファイルが使っているディレクトリを基準とします。相対パスは ``.`` または ``..`` で始まります。

.. code-block:: yaml

   volumes:
     # パスを指定する場合は、Engine がボリュームを作成
     - /var/lib/mysql
   
     # 絶対パスを指定しての割り当て
     - /opt/data:/var/lib/mysql
   
     # ホスト上のパスを指定する時は、Compose ファイルからの相対パスを指定
     - ./cache:/tmp/cache
   
     # ユーザ用ディレクトリのパスを使用
     - ~/configs:/etc/configs/:ro
   
     # 名前付きボリューム（Named volume）
     - datavolume:/var/lib/mysql

.. _compose-file-volumes-long-syntax:

.. long syntax

長い書式
^^^^^^^^^^

.. Added in version 2.3 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-23` で追加されました。

.. The long form syntax allows the configuration of additional fields that can’t be expressed in the short form.

:ruby:`長い書式 <long syntax>` は、短い書式では表現できない追加フィールドを設定できるようにします。

* ``type`` ：マウントの :ruby:`種類 <type>` で ``volume`` 、 ``bind`` 、 ``tmpfs`` 、 ``npipe`` のどれか
* ``source`` ： :ruby:`マウント元 <source>` であり、バインド・マウントするホスト上のパスか、 :ref:`トップレベルの volume キー <volume-configuration-reference>` で定義済みのボリューム名。tmpfs マウントでの利用には、不適切
* ``target`` ：コンテナ内で、ボリュームをマウントするパス
* ``read_only`` ：ボリュームを読み込み専用に指定するフラグ
* ``bind`` ：バインドの追加オプションを指定

   * ``propagation`` ：バインドには :ruby:`プロパゲーション・モード <propagation mode>` を使用

* ``volume`` ：ボリュームの追加オプションを指定

   * ``nocopy`` ：ボリュームを作成しても、コンテナからのデータのコピーを無効にするフラグ

* ``tmpfs`` ：tmpfs の追加オプションを指定

   * ``size`` ：tmpfs マウント用の容量をバイトで指定


.. code-block:: yaml

   version: "2.4"
   services:
     web:
       image: nginx:alpine
       ports:
         - "80:80"
       volumes:
         - type: volume
           source: mydata
           target: /data
           volume:
             nocopy: true
         - type: bind
           source: ./static
           target: /opt/app/static
   
   networks:
     webnet:
   
   volumes:
     mydata:

.. When creating bind mounts, using the long syntax requires the referenced folder to be created beforehand. Using the short syntax creates the folder on the fly if it doesn’t exist. See the bind mounts documentation for more information.

.. note::

   バインド・マウントを作成する場合、長い構文では参照するフォルダを事前に作成しておく必要があります。短い構文では、対象フォルダが存在しなければ即時作成します。詳しい情報は :ref:`バインド・マウントのドキュメント <differences-between--v-and---mount-behavior>` をご覧ください。

.. _compose-file-volume_driver:

volume_driver
--------------------

.. Specify a default volume driver to be used for all declared volumes on this service.

このサービス上で宣言されたすべてのボリュームが使う、デフォルトの :ruby:`ボリューム・ドライバ <volume driver>` を指定します。

.. code-block:: yaml

   volume_driver: mydriver

.. In version 2 files, this option only applies to anonymous volumes (those specified in the image, or specified under volumes without an explicit named volume or host path). To configure the driver for a named volume, use the driver key under the entry in the top-level volumes option.

.. note::

   :ref:`compose-file-version-2` ファイルでは、このオプションが適用されるのは :ruby:`匿名ボリューム <anonymous volume>` （イメージの中で指定されているか、 ``volumes`` 以下で指定したボリュームが、明示された名前付きボリューム、または、ホスト上のパスではない場合）のみです。名前付きボリュームに対してドライバを指定するには、 :ref:`トップレベルの volume オプション <volume-configuration-reference>` 以下で ``driver`` キーを使います。

.. See Docker Volumes and Volume Plugins for more information.

詳しい情報は :doc:`Docker ボリューム </storage/volumes>` と :doc:`ボリューム・プラグイン </engine/extend/plugins_volume>` をご覧ください。

.. _compose-file-volumes_from:

volumes_from
--------------------

.. Mount all of the volumes from another service or container, optionally specifying read-only access (ro) or read-write (rw). If no access level is specified, then read-write is used.

他のサービスやコンテナから、すべてのボリュームをマウントします。オプションで、 :ruby:`read-only <読み込み専用>` のアクセス（ ``ro`` ）や :ruby:`<read-write> 読み書き可能` （ ``rw`` ）を指定できます。アクセスレベルの指定がなければ、読み書き可能です。

.. code-block:: yaml

   volumes_from:
    - service_name
    - service_name:ro
    - container:container_name
    - container:container_name:rw

.. Changed in version 2 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-2` で変更されました。

.. _compose-file-restart:

restart
----------

.. no is the default restart policy, and it doesn’t restart a container under any circumstance. When always is specified, the container always restarts. The on-failure policy restarts a container if the exit code indicates an on-failure error.

``no`` はデフォルトの :ruby:`再起動ポリシー <restart policy>` であり、どのような状況下でもコンテナを再起動しません。 ``always`` （常に）が指定されれば、コンテナは常に再起動します。 ``on-failure`` ポリシーは、終了コードが :ruby:`障害発生 <on-failure>` エラーの場合に、コンテナを再起動します。

.. code-block:: yaml

   restart: "no"

.. code-block:: yaml

   restart: "always"

.. code-block:: yaml

   restart: "on-failure"

.. code-block:: yaml

   restart: "unless-stopped"

.. _cpu-and-other-resources:

.. cpu_count, cpu_percent, cpu_shares, cpu_period, cpu_quota, cpus, cpuset, domainname, hostname, ipc, mac_address, mem_limit, memswap_limit, mem_swappiness, mem_reservation, oom_kill_disable, oom_score_adj, privileged, read_only, shm_size, stdin_open, tty, user, working_dir

cpu_count, cpu_percent, cpu_shares, cpu_period, cpu_quota, cpus, cpuset, domainname, hostname, ipc, mac_address, mem_limit, memswap_limit, mem_swappiness, mem_reservation, oom_kill_disable, oom_score_adj, privileged, read_only, shm_size, stdin_open, tty, user, working_dir
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

.. Each of these is a single value, analogous to its docker run counterpart.

それぞれの単一の値であり、 :ref:`docker run <runtime-constraints-on-resources>` の値に対応します。

.. Added in version 2.2 file format.

.. hint::

   ``cpu_count`` 、 ``cpu_percent`` 、 ``cpus`` オプションは、ファイル形式 :ref:`compose-file-version-22` で追加されました。

.. Added in version 2.1 file format.

.. hint::

   ``oom_kill_disable`` と ``cpu_period`` は、ファイル形式 :ref:`compose-file-version-21` で追加されました。

.. code-block:: yaml

   cpu_count: 2
   cpu_percent: 50
   cpus: 0.5
   cpu_shares: 73
   cpu_quota: 50000
   cpu_period: 20ms
   cpuset: 0,1
   
   user: postgresql
   working_dir: /code
   
   domainname: foo.com
   hostname: foo
   ipc: host
   mac_address: 02:42:ac:11:65:43
   
   mem_limit: 1000000000
   memswap_limit: 2000000000
   mem_reservation: 512m
   privileged: true
   
   oom_score_adj: 500
   oom_kill_disable: true
   
   read_only: true
   shm_size: 64M
   stdin_open: true
   tty: true


.. Specifying durations

.. _compose-file-specifying-durations:

期間の指定
====================

.. Some configuration options, such as the interval and timeout sub-options for healthcheck, accept a duration as a string in a format that looks like this:

設定オプションのいくつかには、 ``healthcheck`` 用サブオプションの ``interval`` と ``timeout`` のように、期間を文字列で指定可能な形式があります。次のように指定します。

.. code-block:: yaml

   2.5s
   10s
   1m30s
   2h32m
   5h34m56s

.. The supported units are us, ms, s, m and h.

サポートしている単位は、 ``us`` 、 ``ms`` 、 ``s`` 、 ``m`` 、 ``h`` です。

.. Specifying byte values

.. _compose-file-specifying-byte-values:

バイト値の指定
====================

.. Some configuration options, such as the device_read_bps sub-option for blkio_config, accept a byte value as a string in a format that looks like this:


設定オプションのいくつかには、 ``blkio_config`` 用サブオプションの ``device_read_bps`` のように、バイト値を文字列で指定可能な形式があります。次のように指定します。

.. code-block:: yaml

   2b
   1024kb
   2048k
   300m
   1gb

.. The supported units are b, k, m and g, and their alternative notation kb, mb and gb. Decimal values are not supported at this time.

サポートしている単位は、 ``b`` 、 ``k`` 、 ``m`` 、 ``g`` と、他にも ``kb`` 、 ``mb`` 、 ``gd`` の記法です。


.. Volume configuration reference

.. _compose-file-volume-configuration-reference:

ボリューム設定リファレンス
==============================

.. While it is possible to declare volumes on the fly as part of the service declaration, this section allows you to create named volumes that can be reused across multiple services (without relying on volumes_from), and are easily retrieved and inspected using the docker command line or API. See the docker volume subcommand documentation for more information.

サービス宣言の一部として :ref:`ボリューム <compose-file-volumes>` を臨機応変に宣言できますが、このセクションでは、複数のサービス間（ ``volumes_from`` に依存）を横断して再利用可能な :ruby:`名前付きボリューム <named volume>` を作成します。それから、 docker コマンドラインや API を使って、簡単に取り出したり調査したりします。

.. See use volumes and volume plugins for general information on volumes.

ボリューム上での一般的な情報は、 :doc:`ボリュームの使用 </storage/volumes>` と :doc:`/engine/extend/plugins_volume` をご覧下さい。

.. Here’s an example of a two-service setup where a database’s data directory is shared with another service as a volume so that it can be periodically backed up:

以下は2つのサービスをセットアップする例です。データベースの（ ``data-volume`` という名前の）データ・ディレクトリを、他のサービスからはボリュームとして共有するため、定期的なバックアップのために利用できます。

.. code-block:: yaml

   version: "2.4"
   
   services:
     db:
       image: db
       volumes:
         - data-volume:/var/lib/db
     backup:
       image: backup-service
       volumes:
         - data-volume:/var/lib/backup/data
   
   volumes:
     data-volume:

.. An entry under the top-level volumes key can be empty, in which case it uses the default driver configured by the Engine (in most cases, this is the local driver). Optionally, you can configure it with the following keys:

トップレベルの ``volumes`` キー以下のエントリは、空っぽにできます。その場合、Engine によって設定されているデフォルトのドライバ設定（多くの場合、 ``local`` ドライバ）が使われます。オプションで、以下のキーを設定できます。


.. driver

.. _compose-file-volume-driver:

driver
----------

.. Specify which volume driver should be used for this volume. Defaults to whatever driver the Docker Engine has been configured to use, which in most cases is local. If the driver is not available, the Engine returns an error when docker-compose up tries to create the volume.

このボリュームに対して、どのボリューム・ドライバを使うか指定します。デフォルトは、Docker Engineで使用するように設定されているドライバであり、多くの場合は ``local`` です。対象のドライバが利用できなければ、 ``docker-compose up`` でボリュームを作成しようとしても、Engine はエラーを返します。

.. code-block:: yaml

   driver: foobar

.. driver_opts

.. _compose-file-volume-driver_opts:

driver_opts
--------------------


.. Specify a list of options as key-value pairs to pass to the driver for this volume. Those options are driver-dependent - consult the driver’s documentation for more information. Optional.

ボリュームが使うドライバに対して、オプションをキーバリューのペアで指定します。これらのオプションはドライバに依存します。オプションの詳細については、各ドライバのドキュメントをご確認ください。

.. code-block:: yaml

   volumes:
     example:
       driver_opts:
         type: "nfs"
         o: "addr=10.40.0.199,nolock,soft,rw"
         device: ":/docker/example"

.. external

.. _compose-file-volume-external:

external
--------------------

.. If set to true, specifies that this volume has been created outside of Compose. docker-compose up will not attempt to create it, and will raise an error if it doesn’t exist.

このオプションを ``true`` に設定すると、Compose の外でボリュームを作成します（訳者注：Compose が管理していない Docker ボリュームを利用します、という意味）。 ``docker-compose up`` を実行してもボリュームを作成しません。もしボリュームが存在していなければ、エラーを返します。

.. For version 2.0 of the format, external cannot be used in conjunction with other volume configuration keys (driver, driver_opts, labels). This limitation no longer exists for version 2.1 and above.

バージョン 2.0 形式では、``external`` は他のボリューム用の設定キー（ ``driver`` 、``driver_opts`` 、 ``labels`` ） と一緒に使えません。この制限は、バージョン 2.1 以上ではありません。

.. In the example below, instead of attemping to create a volume called [projectname]_data, Compose will look for an existing volume simply called data and mount it into the db service’s containers.

以下の例は、 ``[プロジェクト名]_data`` という名称のボリュームを作成する代わりに、Compose は ``data`` という名前で外部に存在するボリュームを探し出し、それを ``db`` サービスのコンテナの中にマウントします。

.. code-block:: yaml

   version: '2.4'
   
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


..     Deprecated in version 2.1 file format.
    external.name was deprecated in version 2.1 file format use name instead.

.. warning::

   :ref:`compose-file-version-21` では非推奨となりました。
   
   external.name はファイル形式バージョン 2.1 では非推奨となりました。代わりに ``name`` を使います。


.. labels

.. _compose-file-volume-labels:

labels
--------------------

.. hint::

   ファイル形式 :ref:`compose-file-version-21` で追加されました。

.. Add metadata to containers using Docker labels. You can use either an array or a dictionary.

:doc:`Docker ラベル </config/labels-custom-metadata>` を使い、コンテナにメタデータを追加します。配列もしくは :ruby:`辞書形式 <dictionary>` で指定できます。

.. It’s recommended that you use reverse-DNS notation to prevent your labels from conflicting with those used by other software.

他のソフトウェアが使うラベルと競合しないようにするため、ラベルには逆引き DNS 機能の利用を推奨します。

.. code-block:: yaml

   labels:
     com.example.description: "Database volume"
     com.example.department: "IT/Ops"
     com.example.label-with-empty-value: ""

.. code-block:: yaml

   labels:
     - "com.example.description=Database volume"
     - "com.example.department=IT/Ops"
     - "com.example.label-with-empty-value"

.. name

.. _compose-file-volume-name:

name
--------------------

.. hint::

   ファイル形式 :ref:`compose-file-version-21` で追加されました。

.. Set a custom name for this volume. The name field can be used to reference volumes that contain special characters. The name is used as is and will not be scoped with the stack name.

このボリュームに対してカスタム名を設定します。この名前の領域は、特別な文字列を含むボリュームとして参照できます。この名前はそのまま全体を通して使用されますので、他の場所ではボリューム名として使用 **できません** 。

.. code-block:: yaml

   version: "2.4"
   volumes:
     data:
       name: my-app-data

.. It can also be used in conjunction with the external property:

また、 `external` 属性とあわせて使えます。

.. code-block:: yaml

   version: "2.4"
   volumes:
     data:
       external: true
       name: my-app-data

.. Network configuration reference

.. _network-configuration-reference:

ネットワーク設定リファレンス
==============================

.. The top-level networks key lets you specify networks to be created. For a full explanation of Compose’s use of Docker networking features, see the Networking guide.

ネットワークを作成するには、トップレベルの ``networks`` キーを使って指定します。Compose 上でネットワーク機能を使うための詳細情報は、 :doc:`networking` をご覧ください。

.. driver
 
.. _network-driver:

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

.. Starting with Compose file format 2.1, overlay networks are always created as attachable, and this is not configurable. This means that standalone containers can connect to overlay networks.

.. hint::

   :ref:`compose-file-version-21` ファイル形式で変更されました。
   
   Compose 形式 2.1 からは、オーバレイ・ネットワークは ``attachable``  として常に作成可能となりました。また、これは設定変更できません。つまり、スタンドアロン・コンテナはオーバレイ・ネットワークに接続できないことを意味します。


.. driver_opts

driver_opts
--------------------

.. Specify a list of options as key-value pairs to pass to the driver for this network. Those options are driver-dependent - consult the driver’s documentation for more information. Optional.

ネットワークが使うドライバに対して、オプションをキーバリューのペアで指定します。これらのオプションはドライバに依存します。オプションの詳細については、各ドライバのドキュメントをご確認ください。

.. code-block:: yaml

     driver_opts:
       foo: "bar"
       baz: 1

.. enable_ipv6

enable_ipv6
--------------------

.. hint::

   Compose 形式 :ref:`compose-file-version-21` で追加されました。

.. Enable IPv6 networking on this network.

このネットワーク上で IPv6 通信を有効にします。

.. ipam

ipam
----------

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

* ``options`` ：キーバリュー形式で、ドライバ固有のオプションを指定します。

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
     options:
       foo: bar
       baz: "0"

internal
--------------------

.. By default, Docker also connects a bridge network to it to provide external connectivity. If you want to create an externally isolated overlay network, you can set this option to true.

Docker は外部との接続をするために、デフォルトではブリッジネットワークにも接続します。外部への隔たれたオーバレイ・ネットワークを作成したい場合は、このオプションを ``true`` に指定できます。

labels
----------

.. hint::

   Compose 形式 :ref:`compose-file-version-21` で追加されました。

.. Add metadata to containers using Docker labels. You can use either an array or a dictionary.

:doc:`Docker ラベル </config/labels-custom-metadata>` を使ってコンテナにメタデータを追加します。アレイ形式か辞書形式が使えます。

.. It’s recommended that you use reverse-DNS notation to prevent your labels from conflicting with those used by other software.

他のソフトウェアが使っているラベルとの重複を避けるため、逆引き DNS 記法の利用を推奨します。

.. code-block:: yaml

   labels:
     com.example.description: "Financial transaction network"
     com.example.department: "Finance"
     com.example.label-with-empty-value: ""

.. code-block:: yaml

labels:
  - "com.example.description=Financial transaction network"
  - "com.example.department=Finance"
  - "com.example.label-with-empty-value"


.. external

external
--------------------

.. If set to true, specifies that this network has been created outside of Compose. docker-compose up will not attempt to create it, and will raise an error if it doesn’t exist.

このオプションを ``true`` に設定したら、Compose の外にネットワークを作成します（訳者注：Compose が管理していない Docker ネットワークを利用します、という意味）。 ``docker-compose up`` を実行してもネットワークを作成しません。もしネットワークが存在していなければ、エラーを返します。

.. For version 2.0 of the format, external cannot be used in conjunction with other network configuration keys (driver, driver_opts, ipam, internal). This limitation no longer exists for version 2.1 and above.

バージョン 2.0 形式までは、``external`` は他のネットワーク用の設定キー（ ``driver`` 、``driver_opts`` 、 ``ipam`` ） と一緒に使えません。この制限はバージョン 2.1 以上にはありません。

.. In the example below, proxy is the gateway to the outside world. Instead of attemping to create a network called [projectname]_outside, Compose will look for an existing network simply called outside and connect the proxy service’s containers to it.

以下の例は、外の世界とのゲートウェイに ``proxy`` を使います。 ``[プロジェクト名]_outside`` という名称のネットワークを作成する代わりに、Compose は ``outside`` という名前で外部に存在するネットワークを探し出し、それを ``proxy`` サービスのコンテナに接続します。

.. code-block:: yaml

   version: '2.4'
   
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

   version: "2.4"
   networks:
     outside:
       external:
         name: actual-name-of-network

.. Not supported for version 2 docker-compose files. Use network_mode instead.

バージョン 2 ``docker-compose`` ファイルではサポートしていません。代わりに :ref:`network_mode <compose-file-network_mode>` を使います。

name
----------

.. hint::

   Compose 形式 :ref:`compose-file-version-21` で追加されました。

.. Set a custom name for this network. The name field can be used to reference networks which contain special characters. The name is used as is and will not be scoped with the stack name.

このネットワークにカスタム名を指定します。 name のフィールドには、特別な文字を含むネットワーク参照が使えます。この名前は単に名前として使われるだけであり、スタック名のスコープでは使われ **ません** 。

.. code-block:: yaml

   version: "2.4"
   networks:
     network1:
       name: my-app-net

.. It can also be used in conjunction with the external property:

また、 ``external`` プロパティをつなげても利用できます。

.. code-block:: yaml

    version: "2.4"
    networks:
      network1:
        external: true
        name: my-app-net

.. Variable substitution

.. _compose-file-variable-substitution:

変数の置き換え
====================

.. Your configuration options can contain environment variables. Compose uses the variable values from the shell environment in which docker-compose is run. For example, suppose the shell contains POSTGRES_VERSION=9.3 and you supply this configuration:

設定オプションでは環境変数も含めることができます。シェル上の Compose は ``docker-compose`` の実行時に環境変数を使えます。たとえば、シェルで ``POSTGRES_VERSION=9.3`` という変数を設定ファイルで扱うには、次のようにします。

.. code-block:: yaml

   db:
     image: "postgres:${POSTGRES_VERSION}"

.. When you run docker-compose up with this configuration, Compose looks for the POSTGRES_VERSION environment variable in the shell and substitutes its value in. For this example, Compose resolves the image to postgres:9.3 before running the configuration.

.. When you run docker-compose up with this configuration, Compose looks for the EXTERNAL_PORT environment variable in the shell and substitutes its value in. For this example, Compose resolves the port mapping to "8000:5000" before creating the `web` container.

この設定で ``docker-compose up`` を実行したら、Compose は ``POSTGRES_VERSION`` 環境変数をシェル上で探し、それを値と置き換えます。この例では、Compose は設定を実行する前に ``image`` に ``postgres:9.3`` を割り当てます。

.. If an environment variable is not set, Compose substitutes with an empty string. In the example above, if POSTGRES_VERSION is not set, the value for the image option is postgres:.

環境変数が設定されていなければ、Compose は空の文字列に置き換えます。先の例では、 ``POSTGRES_VERSION`` が設定されなければ、 ``image`` オプションは ``postgres:`` です。

.. You can set default values for environment variables using a .env file, which Compose automatically looks for in project directory (parent folder of your Compose file). Values set in the shell environment override those set in the .env file.

環境変数のデフォルト値は doc:`.env ファイル <env-file>` を使って指定できます。Compose はプロジェクトのディレクトリ内（Compose ファイルが置いてある親フォルダ）を自動的に探します。シェル環境における値は、 ``.env`` ファイル内のもので上書きします。

..     Note when using docker stack deploy
    The .env file feature only works when you use the docker-compose up command and does not work with docker stack deploy.

.. warning::

   ``.env`` ファイル機能が使えるのは ``docker-compose up`` コマンドを使った時のみです。 ``docker stack deploy`` では機能しません。

.. Both $VARIABLE and ${VARIABLE} syntax are supported. Additionally when using the 2.1 file format, it is possible to provide inline default values using typical shell syntax:

.. Both $VARIABLE and ${VARIABLE} syntax are supported. Extended shell-style features, such as ${VARIABLE-default} and ${VARIABLE/foo/bar}, are not supported.

``$変数`` と ``${変数}`` の両方がサポートされています。加えて、 2.1 ファイル形式を使う時は、典型的なシェル構文を用いて、デフォルトの値を指定できます。

..    ${VARIABLE:-default} evaluates to default if VARIABLE is unset or empty in the environment.
    ${VARIABLE-default} evaluates to default only if VARIABLE is unset in the environment.

* ``${変数:-default}``  は、環境変数における ``変数`` が未定義もしくは空の場合、値は ``default`` になります。
* ``${変数-default}``  は、環境変数における ``変数`` が未定義の場合のみ、値は ``default`` になります。

.. Similarly, the following syntax allows you to specify mandatory variables:

同様に、以下の構文によって省略できない変数を指定できます。

..    ${VARIABLE:?err} exits with an error message containing err if VARIABLE is unset or empty in the environment.
    ${VARIABLE?err} exits with an error message containing err if VARIABLE is unset in the environment.

* ``${変数:?err}`` は、環境変数における ``変数`` が未定義もしくは空の場合、 ``err`` を含むメッセージのエラーと共に終了します。
* ``${変数?err}`` は、環境変数における ``変数`` が未定義の場合のみ、 ``err`` を含むメッセージのエラーと共に終了します。

.. Other extended shell-style features, such as ${VARIABLE/foo/bar}, are not supported.

``${変数/foo/bar}`` のような拡張シェル形式の機能はサポートされていません。

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

.. Extension fields

.. _extension-fields:

拡張フィールド
====================

.. hint::

   Compose 形式 :ref:`compose-file-version-21` で追加されました。

.. It is possible to re-use configuration fragments using extension fields. Those special fields can be of any format as long as they are located at the root of your Compose file and their name start with the x- character sequence.

拡張フィールドを使い、設定の一部の再利用できる場合があります。それぞれの特別フィールドは、Compose ファイルの存在する場所（ルート）に位置する限り利用でき、それらの名前は ``x-`` で始まる文字に続きます。

.. Starting with the 3.7 format (for the 3.x series) and 2.4 format (for the 2.x series), extension fields are also allowed at the root of service, volume, network, config and secret definitions.

.. note::

   3.7 形式以降（の 3.x 系統）と、2.4 形式（以降の 2.x 形式）では、拡張フィールドでも service のルート、volume、network、config、secret を定義できます。

.. code-block:: yaml

   version: "3.9"
   x-custom:
     items:
       - a
       - b
     options:
       max-size: '12m'
     name: "custom"

.. The contents of those fields are ignored by Compose, but they can be inserted in your resource definitions using YAML anchors. For example, if you want several of your services to use the same logging configuration:

各フィールドの内容は Compose からは無視されます。ですが、 `YAML アンカー <https://yaml.org/spec/1.2/spec.html#id2765878>`_ を使ったリソース定義のために挿入できます。たとえば、同じログ記録設定を使うために、複数のサービスを使いたい場合を考えます。

.. code-block:: yaml

   logging:
     options:
       max-size: '12m'
       max-file: '5'
     driver: json-file

.. You may write your Compose file as follows:

Compose ファイルでは、次のようにも書けます。

.. code-block:: yaml

   version: "3.9"
   x-logging:
     &default-logging
     options:
       max-size: '12m'
       max-file: '5'
     driver: json-file
   
   services:
     web:
       image: myapp/web:latest
       logging: *default-logging
     db:
       image: mysql:latest
       logging: *default-logging

.. It is also possible to partially override values in extension fields using the YAML merge type. For example:

`YAML merge type <https://yaml.org/type/merge.html>`_ を使い、拡張フィールド値の部分的に上書きもできます。例：

.. code-block:: yaml

   version: "3.9"
   x-volumes:
     &default-volume
     driver: foobar-storage
   
   services:
     web:
       image: myapp/web:latest
       volumes: ["vol1", "vol2", "vol3"]
   volumes:
     vol1: *default-volume
     vol2:
       << : *default-volume
       name: volume02
     vol3:
       << : *default-volume
       driver: default
       name: volume-local


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

