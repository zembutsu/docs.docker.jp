.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/compose-file/compose-file-v3/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/compose-file/compose-file-v3.md
.. check date: 2022/02/11
.. Commits on Feb 4, 2022 b730e42610b038f938fa4f43da564127b6609d29
.. ----------------------------------------------------------------------------

.. Compose file version 3 reference

.. _compose-file-version-3-reference:

=======================================
Compose ファイル version 3 リファレンス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Reference and guidelines

.. _v2-reference-and-guidelines:

リファレンスと方針
==============================

.. These topics describe version 3 of the Compose file format.

以下のトピックでは、 Compose ファイル形式バージョン3について説明します。

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

.. Compose file structure and examples

.. _compose-file-structure-and-examples:

Compose ファイル構造と例
==============================

.. Here is a sample Compose file from the voting app sample used in the Docker for Beginners lab topic on Deploying an app to a Swarm:

こちらはサンプルの Compose ファイルです。 `Docker for Beginners lab <https://github.com/docker/labs/tree/master/beginner/>`_ の `Deploying an app to a Swarm <https://github.com/docker/labs/blob/master/beginner/chapters/votingapp.md>`_ トピックで使われている投票アプリのサンプルです。

* :doc:`Compose ファイルバージョン v3 の例 <example-v3>`

.. The topics on this reference page are organized alphabetically by top-level key to reflect the structure of the Compose file itself. Top-level keys that define a section in the configuration file such as build, deploy, depends_on, networks, and so on, are listed with the options that support them as sub-topics. This maps to the <key>: <option>: <value> indent structure of the Compose file.

このリファレンスページ上のトピックは、Compose ファイル自身の構造をトップレベルのキーとして反映し、アルファベット順に並べています。トップレベルのキーとは、 ``build`` 、 ``deploy`` 、 ``depends_on`` 、 ``networks`` 等の設定があるセクション定義です。


.. Service configuration reference

.. _compose-file-v3-service-configuration-reference:

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

.. This section contains a list of all configuration options supported by a service definition in version 3.

このセクションで扱うのは、（Docker Compose）バージョン3のサービス定義用にサポートされている、設定オプションの一覧です。


.. _compose-file-v3-build:

build
----------

.. Configuration options that are applied at build time.

:ruby:`構築時 <build time>` に適用するオプションを指定します。

.. build can be specified either as a string containing a path to the build context:

``build`` では :ruby:`構築コンテキスト <build context>` へのパスを含む文字列を指定できます。

.. code-block:: yaml

   version: "3.9"
   services:
     webapp:
       build: ./dir

.. Or, as an object with the path specified under context and optionally Dockerfile and args:

または、 :ref:`context <compose-file-v3-context>` 配下のパスにある特定の（ファイルやディレクトリなどの）物（オブジェクト）と、 :ref:`Dockerfile <compose-file-v3-dockerfile>` のオプションと :ref:`引数 <compose-file-v3-args>` を指定できます。

.. code-block:: yaml

   version: "3.9"
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

.. attention::

   **docker stack deploy 使用時の注意**
   ``build`` オプションは :doc:`swarm mode でスタックのデプロイ </engine/reference/commandline/stack_deploy>` 時に無視されます。 ``docker stack`` コマンドは、デプロイ前にイメージを構築しません。

.. context

.. _compose-file-v3-context:

context
^^^^^^^^^^^^^^^^^^^^


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

.. _compose-file-v3-dockerfile:

dockerfile
^^^^^^^^^^^^^^^^^^^^

.. Alternate Dockerfile.

別の Dockerfile を指定します。

.. Compose will use an alternate file to build with. A build path must also be specified.

Compose は別の Dockerfile ファイルを使い構築します。 :ruby:`構築パス <build path>` の指定も必要です（訳者注：構築コンテキスト、つまり、使いたい Dockerfile のある場所を指定）。

.. code-block:: yaml

   build:
     context: .
     dockerfile: Dockerfile-alternate

.. args

.. _compose-file-v3-args:

args
^^^^^^^^^^^^^^^^^^^^

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

.. _compose-file-v3-cache_from:

cache_from
^^^^^^^^^^^^^^^^^^^^

.. Added in version 3.2 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-32` で追加されました。

.. A list of images that the engine uses for cache resolution.

Engine がキャッシュの解決に使うイメージの一覧。

.. code-block:: yaml

   build:
     context: .
     cache_from:
       - alpine:latest
       - corp/web_app:3.14

.. _compose-file-v3-labels:

labels
^^^^^^^^^^^^^^^^^^^^

.. Added in version 3.3 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-33` で追加されました。

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


.. _compose-file-v3-network:

network
^^^^^^^^^^^^^^^^^^^^

.. Added in version 3.4 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-34` で追加されました。

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

.. _compose-file-v3-shm_size:

shm_size
^^^^^^^^^^^^^^^^^^^^

.. Added in version 3.5 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-35` で追加されました。

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

.. _compose-file-v3-target:

target
^^^^^^^^^^^^^^^^^^^^

.. Added in version 3.4 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-34` で追加されました。

.. Build the specified stage as defined inside the Dockerfile. See the multi-stage build docs for details.

``Dockerfile`` の中で定義された :ruby:`ステージ <stage>` を指定して構築します。詳細は :doc:`マルチステージ・ビルド </develop/develop-images/multistage-build>` をご覧ください。

.. code-block:: yaml

   build:
     context: .
     target: prod


.. cap_add, cap_drop

.. _compose-file-v3-cap_add-cap_drop:

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

.. attention::

   **docker stack deploy 使用時の注意**
   ``cap_add`` と ``cap_drop`` オプションは :doc:`swarm mode でスタックのデプロイ </engine/reference/commandline/stack_deploy>` 時に無視されます。 ``docker stack`` コマンドは、デプロイ前にイメージを構築しません。

.. _compose-file-v3-cgroup_parent:

cgroup_parent
--------------------

.. Specify an optional parent cgroup for the container.

コンテナに対してオプションの親  cgroup を指定します。

.. code-block:: yaml

   cgroup_parent: m-executor-abcd

.. attention::

   **docker stack deploy 使用時の注意**
   ``cgroup_parent`` オプションは :doc:`swarm mode でスタックのデプロイ </engine/reference/commandline/stack_deploy>` 時に無視されます。 ``docker stack`` コマンドは、デプロイ前にイメージを構築しません。



.. _compose-file-v3-command:

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

.. _compose-file-v3-configs:

configs
--------------------

.. Grant access to configs on a per-service basis using the per-service configs configuration. Two different syntax variants are supported.

サービスごとに使う ``configs`` 設定に基いて、アクセス権限を設定します。2つの構文がサポートされています。

..    Note: The config must already exist or be defined in the top-level configs configuration of this stack file, or stack deployment fails.

.. note::

   config は既に存在しているか、 :ref:`トップレベルの configs 設定に関する定義 <configs-configuration-reference>` がこのスタックファイルに存在している必要があります。そうでなければ、スタックのデプロイに失敗します。

.. For more information on configs, see configs.

configs に関する詳しい情報は :doc:`configs </engine/swarm/configs>` をご覧ください。

短い構文
^^^^^^^^^^

.. The short syntax variant only specifies the config name. This grants the container access to the config and mounts it at /<config_name> within the container. The source name and destination mountpoint are both set to the config name.

:ruby:`短い構文 <short syntax>` の形式は、config 名でのみ指定できます。これは、コンテナがコンテナ内で設定にアクセスしたり、 ``/<設定名>`` でマウントする権限を与えます。ソース名とマウントポイント先の、どちらも config 名で設定されます。

.. The following example uses the short syntax to grant the redis service access to the my_config and my_other_config configs. The value of my_config is set to the contents of the file ./my_config.txt, and my_other_config is defined as an external resource, which means that it has already been defined in Docker, either by running the docker config create command or by another stack deployment. If the external config does not exist, the stack deployment fails with a config not found error.

以下の例は短い構文を使い、 ``redis`` サービスに ``my_config`` と ``my_other_config`` 設定に対するアクセスを許可します。 ``my_config`` の値は、ファイル ``./my_config.txt`` と ``my_other_configs`` の中で定義されているものに、外部リソースとして設定されます。これはつまり、既に Docker 内で定義されているのを意味しますので、 ``docker config create`` コマンドを実行しているか、あるいは、他のスタックによってデプロイされている必要があります。もしも外部設定が存在しなければ、 ``config not found`` のエラーをと共に、スタックのデプロイに失敗します。

.. Added in version 3.3 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-33` で追加されました。
   ``config`` 定義がサポートされているのは、Compose ファイル形式バージョン 3.3 以上です。

.. code-block:: yaml

   version: "3.9"
   services:
     redis:
       image: redis:latest
       deploy:
         replicas: 1
       configs:
         - my_config
         - my_other_config
   configs:
     my_config:
       file: ./my_config.txt
     my_other_config:
       external: true

長い構文
^^^^^^^^^^

.. The long syntax provides more granularity in how the config is created within the service’s task containers.

:ruby:`長い構文 <long syntax>` の形式は、サービスタスク用のコンテナ内で作成される設定を、より細かく指定します。

..    source: The identifier of the config as it is defined in this configuration.
    target: The path and name of the file to be mounted in the service’s task containers. Defaults to /<source> if not specified.
    uid and gid: The numeric UID or GID that owns the mounted config file within in the service’s task containers. Both default to 0 on Linux if not specified. Not supported on Windows.
    mode: The permissions for the file that is mounted within the service’s task containers, in octal notation. For instance, 0444 represents world-readable. The default is 0444. Configs cannot be writable because they are mounted in a temporary filesystem, so if you set the writable bit, it is ignored. The executable bit can be set. If you aren’t familiar with UNIX file permission modes, you may find this permissions calculator useful.

* ``source`` ：この設定自身、そのものを識別するための設定です。
* ``target`` ：サービスタスクのコンテナ内でマウントする、ファイル名とパスです。指定が無ければ、 ``/<source>`` がデフォルトです。
* ``uid`` と ``gid`` ：サービスタスクのコンテナ内で設定ファイルをマウントする所有者を、整数の UID または GID で指定します。指定が無ければ、 Linux 上では ``0`` がデフォルトです。Windows 上ではサポートされません。
* ``mode`` ：サービスタスク内のコンテナで、マウントするファイルのパーミッションを8進数で書きます。たとえば、 ``0444`` は誰もが読み込めるのを意味します。デフォルトは ``0444`` です。設定は一時的なファイルシステムにマウントされるため、書き込み可能にできません。そのため、書き込み可能なビットを指定しても、無視されます。実行権限は設定できません。UNIX のファイルパーミッション・モードに慣れていなければ、 `パーミッション計算（英語） <http://permissions-calculator.org/>`_ が役立つでしょう。

.. The following example sets the name of my_config to redis_config within the container, sets the mode to 0440 (group-readable) and sets the user and group to 103. The redis service does not have access to the my_other_config config.

以下の例は、 ``my_config`` の名前をコンテナ内で ``redis_config`` と設定し、モードを ``0440`` （グループが読み込みできる）に設定し、ユーザとグループを ``103``  へと設定します。

.. code-block:: yaml

   version: "3.9"
   services:
     redis:
       image: redis:latest
       deploy:
         replicas: 1
       configs:
         - source: my_config
           target: /redis_config
           uid: '103'
           gid: '103'
           mode: 0440
   configs:
     my_config:
       file: ./my_config.txt
     my_other_config:
       external: true

.. You can grant a service access to multiple configs and you can mix long and short syntax. Defining a config does not imply granting a service access to it.

サービスに対して複数の設定を与えられます。また、長い構文と短い構文を混ぜて使えます。config の定義は、サービスがアクセスできる権限の付与を意味しません。

.. _compose-file-v3-container_name:

container_name
--------------------

.. Specify a custom container name, rather than a generated default name.

自動作成されるコンテナ名ではなく、任意のコンテナ名を指定します。

.. code-block:: yaml

   container_name: my-web-container

.. Because Docker container names must be unique, you cannot scale a service beyond 1 container if you have specified a custom name. Attempting to do so results in an error.

Docker コンテナ名は重複できません。そのため、任意のコンテナ名を指定した場合、サービスは複数のコンテナにスケールできなくなります。

.. attention::

   **docker stack deploy 使用時の注意**
   
     :doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` する場合、  ``container_name`` オプションは無視されます。

.. _compose-file-v3-credential_spec:

credential_spec
--------------------

.. Added in version 3.3 file format.
.. The credential_spec option was added in v3.3. Using group Managed Service Account (gMSA) configurations with compose files is supported in file format version 3.8 or up.

.. hint::

   Compose 形式 :ref:`compose-file-version-33` で追加されました。
   
   ``credential_spec`` オプションは v3.3 で追加されました。グループ管理サービスアカウント（gMSA）設定を compose ファイルで使うのがサポートされているのは、バージョン 3.8 以上の形式です。

.. Configure the credential spec for managed service account. This option is only used for services using Windows containers. The credential_spec must be in the format file://<filename> or registry://<value-name>.

マネージド・サービス・アカウントに対して credentail spec を指定します。このオプションは Windows コンテナで使うサービスでのみ使えます。 ``credentail_spec`` の形式は ``file://<ファイル名>`` または ``registry://<値の名前>`` の必要があります。

.. When using file:, the referenced file must be present in the CredentialSpecs subdirectory in the Docker data directory, which defaults to C:\ProgramData\Docker\ on Windows. The following example loads the credential spec from a file named C:\ProgramData\Docker\CredentialSpecs\my-credential-spec.json.

``file:`` を使う場合、参照されるファイルは Docker データディレクトリ内の ``CredentialSpecs`` に存在する必要があります。Windows 上でのデフォルトは ``C:\ProgramData\Docker\`` です。以下の例は、ファイル名 ``C:\ProgramData\Docker\CredentialSpecs\my-credential-spec.json`` から credential spec を読み込みます。

.. code-block:: bash

   credential_spec:
     file: my-credential-spec.json

.. When using registry:, the credential spec is read from the Windows registry on the daemon’s host. A registry value with the given name must be located in:

``registry:`` を使う場合は、credential spec をデーモンのホスト上にある Windows レジストリから読み込みます。レジストリの値には、存在している場所も名前に入れる必要があります。

::

   HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Containers\CredentialSpecs

.. The following example load the credential spec from a value named my-credential-spec in the registry:

以下の例はレジストリ内の ``my-credentials-spec`` の名前が付いている値から credential spec を読み込みます。

.. code-block:: yaml

   credential_spec:
     registry: my-credential-spec

.. _example-gmsa-configuration:

gMSA 設定例
^^^^^^^^^^^^^^^^^^^^

.. When configuring a gMSA credential spec for a service, you only need to specify a credential spec with config, as shown in the following example:

gMSA credential spec をサービスに対して設定する時は、以下の例にあるように、 ``config`` で credential spec の指定が必要です。

.. code-block:: yaml

   version: "3.9"
   services:
     myservice:
       image: myimage:latest
       credential_spec:
         config: my_credential_spec
   
   configs:
     my_credentials_spec:
       file: ./my-credential-spec.json|

.. _compose-file-v3-depends_on:

depends_on
--------------------

.. depends_on expresses startup and shutdown dependencies between services.

``depends_on``は、サービス間のスタート、シャットダウンの依存関係を表します。

..  Short syntax

短い構文
^^^^^^^^^^

..  The short syntax variant only specifies service names of the dependencies. Service dependencies cause the following behaviors:

短い構文では、依存関係を表す特定のサービスの名前を指定するだけです。サービスの依存関係を指定すると、以下のような挙動になります。

..  Compose creates services in dependency order. In the following example, db and redis are created before web.
    Compose removes services in dependency order. In the following example, web is removed before db and redis.

* Composeは、 依存関係のある順にサービスを作成します。以下の例では、 ``web``よりも先に ``db`` と ``redis`` を作成します。
* Composeは、依存関係の順番でサービスを削除します。以下の例では、 ``db`` と ``redis`` の前に ``web`` を削除します。

.. Simple example:

シンプルな例：

.. code-block:: yaml

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

..  Compose guarantees dependency services have been started before starting a dependent service. 
    Compose waits for dependency services to be "ready" before starting a dependent service.

この場合、Composeは、依存関係を指定したservicesがすでにstartしてからstartすることを保証します。
Composeは、依存関係を指定したservicesが"ready"になったことを確認してからstartします

.. Long syntax

長い構文
^^^^^^^^^^

..  The long form syntax enables the configuration of additional fields that can't be expressed in the short form.

長い構文では、短い構文では表現できない追加フィールドを設定することができます。

.. restart: When set to true Compose restarts this service after it updates the dependency service. 
　　This applies to an explicit restart controlled by a Compose operation, and excludes automated restart by the container runtime after the container dies.

* ``restart``: ``true``にセットした時、Composeは依存しているサービスを更新した後にこのサービスを再起動します。これは、Composeオペレーションによって、制御される再起動に適応され、コンテナが停止した後のランタイム自動再起動は含まれません。

.. condition: Sets the condition under which dependency is considered satisfied
   service_started: An equivalent of the short syntax described above
   service_healthy: Specifies that a dependency is expected to be "healthy" (as indicated by healthcheck) before starting a dependent service.
   service_completed_successfully: Specifies that a dependency is expected to run to successful completion before starting a dependent service.

* ``condition``: 依存関係が満たされたとされる条件を設定することができます。
  * ``service_started``: 上記の短い構文に相当するもの
  * ``service_healthy``: 依存サービスを開始する前に、依存関係が(healthcheck)によって示されるように、"healthy"であることが期待されます。
  * ``service_completed_successfully``: 依存サービスを開始する前に、依存関係が正常に終了していることを指定できる。

.. required: When set to false Compose only warns you when the dependency service isn't started or available. 
   If it's not defined the default value of required is true.
* ``required``: ``false``に設定をすると、Composeは依存サービスが開始されていないか、利用可能でない場合に警告を表示します。定義されていない場合のデフォルト値はtrueです。

.. Service dependencies cause the following behaviors:
サービスの依存関係は、以下のような動作をします：

.. Compose creates services in dependency order. In the following example, db and redis are created before web.

* Composeは、依存関係のある順にサービスを作成する。以下の例では、 ``db`` と ``redis`` が ``web`` よりも先に作成されています。

.. Compose waits for healthchecks to pass on dependencies marked with service_healthy. In the following example, db is expected to be "healthy" before web is created.

* Composeは、service_healthyとマークされた依存関係について、ヘルスチェックが通過するのを待ちます。次の例では、 ``db``は ``web``が作成される前に "healthy "であることが期待されます。

.. Compose removes services in dependency order. In the following example, web is removed before db and redis.

* Composeは、依存関係のあるサービスを順に削除します。次の例では、 ``web``が ``db``と ``redis``の前に削除されます。


.. code-block:: yaml
  services:
  web:
    build: .
    depends_on:
      db:
        condition: service_healthy
        restart: true
      redis:
        condition: service_started
  redis:
    image: redis
  db:
    image: postgres

.. Compose guarantees dependency services are started before starting a dependent service. 
   Compose guarantees dependency services marked with service_healthy are "healthy" before starting a dependent service.

Composeは、依存サービスを開始する前に、依存サービスが開始されることを保証します。
Composeは、service_healthy でマークされた依存サービスが、 依存サービスを開始する前に "healthy" であることを保証します。

.. _compose-file-v3-deploy:

deploy
----------

.. hint::

   Compose 形式 :ref:`compose-file-version-3` で追加されました。

.. Specify configuration related to the deployment and running of services. This only takes effect when deploying to a swarm with docker stack deploy, and is ignored by docker-compose up and docker-compose run.

サービスのデプロイと実行に関連する設定をします。効果があるのは :doc:`swarm </engine/swarm>` を使って :doc:`docker stack deploy </engine/reference/commandline/stack_deploy>` でデプロイした時のみです。 ``docker-compose up`` と ``docker-compose run`` では無視されます。

.. code-block:: yaml

   version: "3.9"
   services:
     redis:
       image: redis:alpine
       deploy:
         replicas: 6
         placement:
           max_replicas_per_node: 1
         update_config:
           parallelism: 2
           delay: 10s
         restart_policy:
           condition: on-failure

.. Several sub-options are available:

いくつかのサブオプションがあります。

.. _compose-file-v3-endpoint_mode:

endpoint_mode
^^^^^^^^^^^^^^^^^^^^

.. hint::

   Compose 形式 :ref:`compose-file-version-32` で追加されました。

.. Specify a service discovery method for external clients connecting to a swarm.

外部のクライアントが swarm に接続するため、サービス・ディスカバリ手法を指定します。

..    endpoint_mode: vip - Docker assigns the service a virtual IP (VIP) that acts as the front end for clients to reach the service on a network. Docker routes requests between the client and available worker nodes for the service, without client knowledge of how many nodes are participating in the service or their IP addresses or ports. (This is the default.)
    endpoint_mode: dnsrr - DNS round-robin (DNSRR) service discovery does not use a single virtual IP. Docker sets up DNS entries for the service such that a DNS query for the service name returns a list of IP addresses, and the client connects directly to one of these. DNS round-robin is useful in cases where you want to use your own load balancer, or for Hybrid Windows and Linux applications.

* ``endpoint_mode: vip`` - Docker はサービスに仮想 IP (VIP) を割り当てます。これは、クライアントがネットワーク上のサービスに到達するための、フロントエンドとして動作します。クライアントとサービス上で利用可能な worker ノード間とのリクエストを、Docker が経路付けします。この時、クライアントはサービス上で何台のクライアントが動作しているかや、それぞれの IP アドレスやポートを知る必要がありません。（これがデフォルトの挙動です）
* ``endpoint_mode: dnsrr`` - DNS ラウンドロビン（DNSRR）サービスディスカバリは、仮想 IP を1つだけでは使いません。Docker はサービスに対する DNS エントリをセットアップします。これは、DNS の問い合わせがあれば、サービス名に対して IP アドレスの一覧を返します。そして、クライアントは IP アドレスのどれか1つに直接接続します。自分自身でロードバランサを使いたい場合や、Windows と Linux アプリケーションを混在したい場合に、DNS ラウンドロビンが役立ちます。

.. code-block:: yaml

   version: "3.9"
   
   services:
     wordpress:
       image: wordpress
       ports:
         - "8080:80"
       networks:
         - overlay
       deploy:
         mode: replicated
         replicas: 2
         endpoint_mode: vip
   
     mysql:
       image: mysql
       volumes:
          - db-data:/var/lib/mysql/data
       networks:
          - overlay
       deploy:
         mode: replicated
         replicas: 2
         endpoint_mode: dnsrr
   
   volumes:
     db-data:
   
   networks:
     overlay:

.. The options for endpoint_mode also work as flags on the swarm mode CLI command docker service create. For a quick list of all swarm related docker commands, see Swarm mode CLI commands.

``endpoint_mode``  のオプションは、swarm モード CLI コマンド :doc:`docker service create </engine/reference/commandline/service_create>` 上のフラグでも動作します。swarm に関連する ``docker`` コマンドをざっと眺めるには、 :doc:`Swarm モード CLI コマンド </engine/swarm/#swarm-mode-key-concepts-and-tutoria>` をご覧ください。

.. To learn more about service discovery and networking in swarm mode, see Configure service discovery in the swarm mode topics.

サービスディスカバリと swarm モードでのネットワーク機能について学ぶには、swarm モードのトピックにある :ref:`サービスディスカバリの設定 <configure-service-discovery>` をご覧ください。

labels
^^^^^^^^^^

.. Specify labels for the service. These labels are only set on the service, and not on any containers for the service.

対象サービスにラベルを指定します。ラベルはサービスに対して「のみ」指定できます。サービスのコンテナに対しては指定「できません」。

.. code-block:: yaml

   version: "3.9"
   services:
     web:
       image: web
       deploy:
         labels:
           com.example.description: "This label will appear on the web service"

.. To set labels on containers instead, use the labels key outside of deploy:

コンテナに対してラベルを指定するには、 ``deploy`` の外で ``label`` キーを使います。

.. code-block:: bash

   version: "3.9"
   services:
     web:
       image: web
       labels:
         com.example.description: "This label will appear on all containers for the web service"


mode
^^^^^^^^^^

.. Either global (exactly one container per swarm node) or replicated (a specified number of containers). The default is replicated. (To learn more, see Replicated and global services in the swarm topics.)

``global`` （swarm ノードごとに、1つのコンテナを確実に起動）か ``replicated`` （コンテナの数を指定）のどちらかです。デフォルトは ``replicated`` です。（詳しく学ぶには :doc:`swarm </engine/swarm/>` ）トピックの :ref:`replicated-and-global-services` をご覧ください。）

.. code-block:: yaml

   version: "3.9"
   services:
     worker:
       image: dockersamples/examplevotingapp_worker
       deploy:
         mode: global

placement
^^^^^^^^^^

.. Specify placement of constraints and preferences. See the docker service create documentation for a full description of the syntax and available types of constraints, preferences, and specifying the maximum replicas per node

constraints と preferences の :ruby:`配置 <placement>` を指定します。詳細な説明や利用可能な構文については、docker service create ドキュメントの :ref:`constraints <specify-service-constraints---constraint>` 、 :ref:`preferences <specify-service-placement-preferences---placement-pref>` 、 :ref:`ノードごとの最大複製数を指定 <specify-maximum-replicas-per-node---replicas-max-per-node>` をご覧ください。

.. code-block:: bash

   version: "3.9"
   services:
     db:
       image: postgres
       deploy:
         placement:
           constraints:
             - "node.role==manager"
             - "engine.labels.operatingsystem==ubuntu 18.04"
           preferences:
             - spread: node.labels.zone

max_replicas_per_node
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. hint::

   Compose 形式 :ref:`compose-file-version-38` で追加されました。

.. If the service is replicated (which is the default), limit the number of replicas that can run on a node at any time.

サービスが ``replicated`` （これがデフォルト）の場合、常にノード上で実行可能な :ref:`レプリカ数の上限 <specify-maximum-replicas-per-node---replicas-max-per-node>` を指定します。

.. When there are more tasks requested than running nodes, an error no suitable node (max replicas per node limit exceed) is raised.

ノード上で実行している以上のタスク要求があれば、エラー ``no suitable node (max replicas per node limit exceed)`` を出します。

.. code-block:: yaml

   version: "3.9"
   services:
     worker:
       image: dockersamples/examplevotingapp_worker
       networks:
         - frontend
         - backend
       deploy:
         mode: replicated
         replicas: 6
         placement:
           max_replicas_per_node: 1

.. compose-file-v3-replicas:
replicas
^^^^^^^^^^

.. If the service is replicated (which is the default), specify the number of containers that should be running at any given time.

サービスが ``replicated`` （これがデフォルト）であれば、常に実行するべきコンテナ数を指定します。

.. code-block:: yaml

   version: "3.9"
   services:
     worker:
       image: dockersamples/examplevotingapp_worker
       networks:
         - frontend
         - backend
       deploy:
         mode: replicated
         replicas: 6

resources
^^^^^^^^^^

.. Configures resource constraints.

リソース制限を指定します。

..    Changed in compose-file version 3
    The resources section replaces the older resource constraint options in Compose files prior to version 3 (cpu_shares, cpu_quota, cpuset, mem_limit, memswap_limit, mem_swappiness). Refer to Upgrading version 2.x to 3.x to learn about differences between version 2 and 3 of the compose-file format.

.. note::

   **compose-file バージョン 3 で変更されました**
   
   Compose ファイルのバージョン3から、 :ref:`古いリソース制限オプション <cpu-and-other-resources>` （ ``cpu_shares`` 、 ``cpu_quota`` 、 ``cpuset`` 、 ``mem_limit`` 、 ``memswap_limit`` 、 ``mem_swappiness`` ）は、 ``resources`` セクションに変わりました。compose ファイル形式のバージョン2と3の違いについて学ぶには、 :ref:`バージョン 2.x から 3.x へのアップグレード <compose-file-upgrading>` をご覧ください。

.. Each of these is a single value, analogous to its docker service create counterpart.

それぞれの値は1つであり、 :doc:`docker service create </engine/reference/commandline/service_create>` での指定に相当します。

.. In this general example, the redis service is constrained to use no more than 50M of memory and 0.50 (50% of a single core) of available processing time (CPU), and has 20M of memory and 0.25 CPU time reserved (as always available to it).

以下にある一般的な例では、 ``redis`` サービスは、メモリの 50M を越えて利用できず、利用可能な :ruby:`処理時間 <processing time>` （CPU）の ``0.50`` （1コアの50%）と制限されます。また、メモリの ``20M`` と CPU 時間の ``0.25`` が予約されます（常に利用可能です）。

.. code-block:: yaml

   version: "3.9"
   services:
     redis:
       image: redis:alpine
       deploy:
         resources:
           limits:
             cpus: '0.50'
             memory: 50M
           reservations:
             cpus: '0.25'
             memory: 20M

.. The topics below describe available options to set resource constraints on services or containers in a swarm.

以下のトピックでは、swarm 内のサービスまたはコンテナに対し、リソースを制限するために指定可能なオプションを説明します。

..    Looking for options to set resources on non swarm mode containers?
    The options described here are specific to the deploy key and swarm mode. If you want to set resource constraints on non swarm deployments, use Compose file format version 2 CPU, memory, and other resource options. If you have further questions, refer to the discussion on the GitHub issue docker/compose/4513.

.. attention::

   **swarm モードではないコンテナのリソース制限のオプションを探していますか？**
   
   ここで説明しているオプションは、 ``deploy`` キーと swarm モードでの指定です。もしも swarm 以外のデプロイ対象に対してリソース制限を設定したいのであれば、 :ref:`Compose ファイル形式バージョン2の CPU、メモリ、その他リソースに関するオプション <cpu-and-other-resources>` を使います。

.. Out Of Memory Exceptions (OOME)

**Out of Memory 例外（OOME）**

.. If your services or containers attempt to use more memory than the system has available, you may experience an Out Of Memory Exception (OOME) and a container, or the Docker daemon, might be killed by the kernel OOM killer. To prevent this from happening, ensure that your application runs on hosts with adequate memory and see Understand the risks of running out of memory.

サービスかコンテナが、システムで利用可能なメモリを越えて使おうとすると、Out Of Memory 例外（OOME）が発生し、コンテナか Docker デーモンはカーネル OOM キラーによって強制停止されるでしょう。このような状態が発生しないようにするには、ホスト上で実行するアプリケーションに適切なメモリを割り当て、 :ref:`understand-the-risks-of-running-out-of-memory` をご覧ください。

.. _compose-file-v3-restart_policy:
restart_policy
^^^^^^^^^^^^^^^^^^^^

.. Configures if and how to restart containers when they exit. Replaces restart.

もしもコンテナが :ruby:`終了 <exit>` すると、どのように再起動するかを設定します。 ``restart`` を置き換えたものです。

..    condition: One of none, on-failure or any (default: any).
    delay: How long to wait between restart attempts, specified as a duration (default: 5s).
    max_attempts: How many times to attempt to restart a container before giving up (default: never give up). If the restart does not succeed within the configured window, this attempt doesn’t count toward the configured max_attempts value. For example, if max_attempts is set to ‘2’, and the restart fails on the first attempt, more than two restarts may be attempted.
    window: How long to wait before deciding if a restart has succeeded, specified as a duration (default: decide immediately).

- ``condition`` ： ``none`` 、 ``on-failure`` 、 ``any`` のどちらかです（デフォルト： ``any`` ）。
- ``delay`` ：再起動を試みるまでどれだけ待機するか、 :ref:`duration <compose-file-v3-specifying-durations>` （継続時間）として指定します（デフォルト： 5s）。
- ``max_attempts`` ：処理を中止するまで、コンテナの再起動を何回繰り返すか指定します（デフォルト：中止しません）。指定した ``window`` 以内に再起動が成功しなければ、設定した ``max_attempts`` （最大試行数）の値としてカウントしません。例えば、 ``max_attempts`` の指定が ``2`` で、再起動を試みて1回目が失敗している場合でも、2回以上の再起動を行う場合があります。
- ``window`` ：何秒待機して再起動が成功したと判断するのかを、 :ref:`duration <compose-file-v3-specifying-durations>` （継続時間）として指定します（デフォルト： 直ちに判断）。

.. code-block:: yaml

   version: "3.9"
   services:
     redis:
       image: redis:alpine
       deploy:
         restart_policy:
           condition: on-failure
           delay: 5s
           max_attempts: 3
           window: 120s

rollback_config
^^^^^^^^^^^^^^^^^^^^

.. hint::

   Compose 形式 :ref:`compose-file-version-37` で追加されました。

.. Configures how the service should be rollbacked in case of a failing update.

更新に失敗した場合、サービスをどのようにして :ruby:`戻す <rollback>` かを設定します。

..    parallelism: The number of containers to rollback at a time. If set to 0, all containers rollback simultaneously.
    delay: The time to wait between each container group’s rollback (default 0s).
    failure_action: What to do if a rollback fails. One of continue or pause (default pause)
    monitor: Duration after each task update to monitor for failure (ns|us|ms|s|m|h) (default 5s) Note: Setting to 0 will use the default 5s.
    max_failure_ratio: Failure rate to tolerate during a rollback (default 0).
    order: Order of operations during rollbacks. One of stop-first (old task is stopped before starting new one), or start-first (new task is started first, and the running tasks briefly overlap) (default stop-first).

* ``parallelism`` ：同時ロールバックするコンテナの数です。 0 に設定すると、全コンテナのロールバックを一斉にします。
* ``delay`` ：各コンテナのグループをロールバックするまで待機する時間です（デフォルト： 0s）。
* ``failure_action`` ：ロールバックに失敗したらどうするかです。 ``continue`` か ``pause`` のどちらかです（デフォルト： ``pause`` ）。
* ``monitor`` ：各タスクの更新が失敗したと判断するまでの期間（ ``ns`` | ``us`` | ``ms`` | ``s`` | ``m`` | ``h`` | ）です（デフォルト： 5s）。 **メモ** ： 0 を指定すると、デフォルトの 5s になります。
* ``max_failure_ratio`` ：ロールバックするまで許容する失敗回数です（デフォルト： 0）。
* ``order`` ：ロールバック処理の順番です。 ``stop-first`` （新しいタスクを開始する前に、古いタスクを停止）か、 ``start-first`` （まず新しいタスクを開始するため、瞬間的に実行中のタスクが重複します）のどちらかです（デフォルト： ``start-first`` ）。

update_config
^^^^^^^^^^^^^^^^^^^^

.. Configures how the service should be updated. Useful for configuring rolling updates.

サービスをどのように更新するかを設定します。ローリングアップデートの設定に役立ちます。

..     parallelism: The number of containers to update at a time.
    delay: The time to wait between updating a group of containers.
    failure_action: What to do if an update fails. One of continue, rollback, or pause (default: pause).
    monitor: Duration after each task update to monitor for failure (ns|us|ms|s|m|h) (default 5s) Note: Setting to 0 will use the default 5s.
    max_failure_ratio: Failure rate to tolerate during an update.
    order: Order of operations during updates. One of stop-first (old task is stopped before starting new one), or start-first (new task is started first, and the running tasks briefly overlap) (default stop-first) Note: Only supported for v3.4 and higher.

* ``parallelism`` ：同時に更新するコンテナの数です。 
* ``delay`` ：各コンテナのグループを更新するまで待機する時間です。
* ``failure_action`` ：更新に失敗したらどうするかです。 ``continue`` か ``rollback`` か ``pause`` のどちらかです（デフォルト： ``pause`` ）。
* ``monitor`` ：各タスクの更新が失敗したと判断するまでの期間（ ``ns`` | ``us`` | ``ms`` | ``s`` | ``m`` | ``h`` | ）です（デフォルト： 5s）。 **メモ** ： 0 を指定すると、デフォルトの 5s になります。
* ``max_failure_ratio`` ：更新するまで許容する失敗回数です（デフォルト： 0）。
* ``order`` ：更新処理の順番です。 ``stop-first`` （新しいタスクを開始する前に、古いタスクを停止）か、 ``start-first`` （まず新しいタスクを開始するため、瞬間的に実行中のタスクが重複します）のどちらかです（デフォルト： ``start-first`` ）。 **メモ** ：v3.4 以上でのみサポート

.. hint::

   Compose 形式 :ref:`compose-file-version-34` で追加されました。
   ``order`` オプションは v3.4 以上の Compose ファイル形式でのみサポートされています。

.. code-block:: yaml

   version: "3.9"
   services:
     vote:
       image: dockersamples/examplevotingapp_vote:before
       depends_on:
         - redis
       deploy:
         replicas: 2
         update_config:
           parallelism: 2
           delay: 10s
           order: stop-first

``docker stack deploy`` では非サポート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. The following sub-options (supported for docker-compose up and docker-compose run) are not supported for docker stack deploy or the deploy key.

以下のサブオプション（ ``docker-compose up`` と ``docker-compose run`` ではサポート）は ``docker stack deploy``  や ``deploy`` キーで *サポートされません* 。

* :ref:`build <compose-file-v3-build>`
* :ref:`cgroup_parent <compose-file-v3-cgroup_parent>`
* :ref:`container_name <compose-file-v3-container_name>`
* :ref:`devices <compose-file-v3-devices>`
* :ref:`tmpfs <compose-file-v3-tmpfs>`
* :ref:`external_links <compose-file-v3-external_links>`
* :ref:`links <compose-file-v3-links>`
* :ref:`network_mode <compose-file-v3-network_mode>`
* :ref:`restart <compose-file-v3->`
* :ref:`security_opt <compose-file-v3-security_opt>`
* :ref:`userns_mode <compose-file-v3-userns_mode>`

.. See the section on how to configure volumes for services, swarms, and docker-stack.yml files. Volumes are supported but to work with swarms and services, they must be configured as named volumes or associated with services that are constrained to nodes with access to the requisite volumes.

.. tip::

   :ref:`サービス、swarm、docker-stack.yml ファイルでのボリューム設定の仕方 <compose-file-v3-volumes-for-services-swarms-and-stack-files>` セクションをご覧ください。ボリューム（volumes）はサポートされていますが、swarm とサービスで使うには、名前付きボリュームとして設定するか、サービスを関連付けをし、ボリュームを必要とするノードでアクセスできるように制限する必要があります。

.. _compose-file-v3-devices:

devices
----------

.. List of device mappings. Uses the same format as the --device docker client create option.

:ruby:`デバイス・マッピング（割り当て） <device mapping>` の一覧です。docker クライアントで作成するオプションの ``--device`` と同じ形式を使います。

.. code-block:: yaml

   devices:
     - "/dev/ttyUSB0:/dev/ttyUSB0"

.. attention::

   **docker stack deploy 使用時の注意**
   
  :doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` する場合、  ``devices`` オプションは無視されます。

.. _compose-file-v3-dns:

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

.. _compose-file-v3-dns_search:

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

.. _compose-file-v3-entrypoint:

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

.. _compose-file-v3-env_file:

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

.. _compose-file-v3-environment:

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


.. _compose-file-v3-expose:

expose
----------

.. Expose ports without publishing them to the host machine - they’ll only be accessible to linked services. Only the internal port can be specified.

コンテナの :ruby:`公開（露出） <expose>` 用のポート番号を指定しますが、ホストマシン上で公開するポートを指定しません。つまり、つながったサービス間でのみアクセス可能になります。内部で使うポートのみ指定できます。

.. code-block:: yaml

   expose:
    - "3000"
    - "8000"


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

.. attention::

   **docker stack deploy 使用時の注意**
   
     :doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` する場合、  ``external_links`` オプションは無視されます。


.. extra_hosts

.. _compose-file-v3-extra_hosts:

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


.. healthcheck

.. _compose-file-v3-healthheck:

healthcheck
--------------------

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

   ``start_period`` オプションは、Compose 形式 :ref:`compose-file-version-34` で追加されました。

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

.. _compose-file-v3-image:

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

.. _compose-file-v3-init:

init
--------------------

.. Added in version 3.7 file format.

.. hint::

   Compose 形式 :ref:`compose-file-version-37` で追加されました。

.. Run an init inside the container that forwards signals and reaps processes. Set this option to true to enable this feature for the service.

コンテナ内で init を実行し、シグナルの転送と、プロセス :ruby:`再配置 <reap>` します。サービスに対してこの機能を有効化するには、このオプションで ``true`` を指定します。

.. code-block:: yaml

   version: "3.9"
   services:
     web:
       image: alpine:latest
       init: true

.. The default init binary that is used is Tini, and is installed in /usr/libexec/docker-init on the daemon host. You can configure the daemon to use a custom init binary through the init-path configuration option.

.. note::

   デフォルトの init バイナリは、 `Tiny <https://github.com/krallin/tini>`_ が使われ、デーモンのホスト上の ``/usr/libexec/docker-init`` にインストールされます。 任意の init バイナリ使うには、デーモンに対して ``init-path``  :ref:`設定オプション <daemon-configuration-file>` を通して指定できます。

.. isolation

.. _compose-file-v3-isolation:

isolation
--------------------

.. Specify a container’s isolation technology. On Linux, the only supported value is default. On Windows, acceptable values are default, process and hyperv. Refer to the Docker Engine docs for details.

コンテナの :ruby:`隔離 <isolation>` 技術を指定します。 Linux 上では、唯一サポートしている値が ``default`` です。Windows specify-isolation-technology-for-container-isolation用では、 ``default`` 、 ``process`` 、 ``hyperv`` が指定できます。詳細は、 :ref:`Docker Engine ドキュメント <specify-isolation-technology-for-container-isolation>` をご覧ください。


.. _compose-file-v3-labels:

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

.. _compose-file-v3-links:

links
----------

.. The --link flag is a legacy feature of Docker. It may eventually be removed. Unless you absolutely need to continue using it, we recommend that you use user-defined networks to facilitate communication between two containers instead of using --link.
   One feature that user-defined networks do not support that you can do with --link is sharing environmental variables between containers. However, you can use other mechanisms such as volumes to share environment variables between containers in a more controlled way.

.. warning:: 

   ``--link`` フラグは Docker の古い機能です。最終的には削除されるでしょう。明確に使い続けるための理由がなければ、2つのコンテナ間の通信で ``--link`` を使うのではなく、 :doc:`ユーザ定義ネットワーク </compose/networking>` の利用を推奨します。
   
   なお、 ``--link`` を使った時にコンテナ間で環境変数を共有できましたが、ユーザ定義ネットワークではサポートされていない機能です。しかしながら、ボリュームの仕組みを使い、より制御しやすい方法として、コンテナ間で環境変数を共有できます。


.. Link to containers in another service. Either specify both the service name and a link alias ("SERVICE:ALIAS"), or just the service name.

コンテナを他のサービスと :ruby:`リンク <link>` します。指定するのは、サービス名とリンク用エイリアスの両方（ ``"SERVICE:ALIAS"`` ）か、サービス名だけです。

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

.. note::

   links と :ref:`networks <compose-file-networks>` を両方定義すると、リンクしたサービス間で通信するため、少なくとも1つの共通するネットワークが使われます。この links ではなく、 networks の利用を推奨します。

.. attention::

   **docker stack deploy 使用時の注意**
   
     :doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` する場合、  ``links`` オプションは無視されます。


.. _compose-file-v3-logging:

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

.. The default driver json-file, has options to limit the amount of logs stored. To do this, use a key-value pair for maximum storage size and maximum number of files:

デフォルトのドライバは :doc:`json-file </config/containers/logging/json-file>` であり、これはログの保存量を制限できます。そのためには、キーバリューのペアで最大容量と最大ファイル数を指定します。

.. code-block:: bash

   options:
     max-size: "200k"
     max-file: "10"

.. The example shown above would store log files until they reach a max-size of 200kB, and then rotate them. The amount of individual log files stored is specified by the max-file value. As logs grow beyond the max limits, older log files are removed to allow storage of new logs.

上の例では、保存するログファイルは ``max-size`` の 200kB に到達するまでで、その後それらがローテートされます。個々のログファイルを保存する数は ``max-file`` 値で指定します。ログが上限に到達すると、古いログファイルは削除され、新しいログを保存できるようになります。

.. Here is an example docker-compose.yml file that limits logging storage:

これは、ログ記録ストレージの制限をする ``docker-compose.yaml`` 例です。

.. code-block:: bash

   version: "3.9"
   services:
     some-service:
       image: some-service
       logging:
         driver: "json-file"
         options:
           max-size: "200k"
           max-file: "10"

..     Logging options available depend on which logging driver you use
    The above example for controlling log files and sizes uses options specific to the json-file driver. These particular options are not available on other logging drivers. For a full list of supported logging drivers and their options, refer to the logging drivers documentation.

.. note::

   **指定できるログ記録のオプションは、どのログ記録ドライバを使うかに依存します**
   
   上の例では、ログファイルやサイズの制御オプションを使うため :doc:`json-file ドライバ </config/containers/logging/json-file>` を指定しました。ここで使った詳細オプションは、他のログ記録ドライバでは利用できません。サポートしているログ記録ドライバとオプションの一覧は、 :doc:`ログ記録ドライバ </config/containers/logging/configure>` のドキュメントをご覧ください。

.. network_mode

.. _compose-file-v3-network_mode:

network_mode
--------------------

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

.. attention::

   **docker stack deploy 使用時の注意**
   
   * :doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` する場合、  ``container_name`` オプションは無視されます。
   * ``network_mode: "host"`` は :ref:`links <compose-file-v3-links>` と混在できません。

.. networks

.. _compose-file-v3-networks:

networks
----------

.. Networks to join, referencing entries under the top-level networks key.

ネットワークに追加するには、:ref:`トップレベルの networks キー <network-configuration-reference>` の項目をご覧ください。

.. code-block:: yaml

   services:
     some-service:
       networks:
        - some-network
        - other-network

.. _compose-file-v3-aliases:

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

   version: "3.9"
   
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

.. _compose-file-v3-ipv4-address-ipv6-address:

ipv4_address 、 ipv6_address
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Specify a static IP address for containers for this service when joining the network.

サービスがネットワークへ追加時、コンテナに対して :ruby:`固定 <static>` IP アドレスを割り当てます。

.. The corresponding network configuration in the top-level networks section must have an ipam block with subnet and gateway configurations covering each static address.

:ref:`トップレベルのネットワーク・セクション <network-configuration-reference>` では、適切なネットワーク設定に ``ipam`` ブロックが必要です。ここで、それぞれの固定アドレスが扱うサブネットやゲートウェイを定義します。 

.. If you’d like to use IPv6, you must first ensure that the Docker daemon is configured to support IPv6. See Enable IPv6 for detailed instructions. You can then access IPv6 addressing in a version 3.x Compose file by editing the /etc/docker/daemon.json to contain: {"ipv6": true, "fixed-cidr-v6": "2001:db8:1::/64"}

IPv6 を使いたい場合は、最初に Docker デーモンが IPv6 をサポートするように設定する必要があります。詳細な手順は :doc:`IPv6 の有効化 </config/daemon/ipv6>` をご覧ください。まず、バージョン 3.x Compose ファイルで IPv6 での接続ができるようにするため、 ``/etc/docker/daemon.json`` に ``{"ipv6": true, "fixed-cidr-v6": "2001:db8:1::/64"}`` を追加します。

.. Then, reload the docker daemon and edit docker-compose.yml to contain the following under the service:

その後、docker デーモンを再起動し、 docker-compose.yml のサービス以下に、次の記述を追加します。

.. code-block:: yaml

       sysctls:
         - net.ipv6.conf.all.disable_ipv6=0

.. note::

   ``enable_ipv6`` オプションは :ref:`バージョン 2.x Compose ファイル <ipv4_address-ipv6_address>` でのみ利用できます。 *IPv6 オプションは現在の swarm モードでは動作しません。*

.. An example:

例：

.. code-block:: yaml

   version: "3.9"
   
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

pid
----------

.. code-block:: yaml

   pid: "host"

.. Sets the PID mode to the host PID mode. This turns on sharing between container and the host operating system the PID address space. Containers launched with this flag can access and manipulate other containers in the bare-metal machine’s namespace and vice versa.

PID モードをホスト PID モードに設定します。これは、コンテナとホスト OS 間で、 PID アドレス空間の共有をできるようにします。このフラグを有効化したコンテナを起動すると、ベアメタルマシンでの名前空間等で、他のコンテナにアクセスや操作ができます。


ports
----------

.. EXpose ports.

公開用のポートです。

..    Note
    Port mapping is incompatible with network_mode: host

.. note::

   ``network_mode: host`` と互換性のあるポート割り当てです。

..    Note
    docker-compose run ignores ports unless you include --service-ports.

   ``docker-compose run`` では、 ``--service-ports`` を除いて ``ports`` を無視します。

.. _compose-file-v3-ports-short:

短い構文
^^^^^^^^^^

3つのオプションがあります。

..    Specify both ports (HOST:CONTAINER)
    Specify just the container port (an ephemeral host port is chosen for the host port).
    Specify the host IP address to bind to AND both ports (the default is 0.0.0.0, meaning all interfaces): (IPADDR:HOSTPORT:CONTAINERPORT). If HOSTPORT is empty (for example 127.0.0.1::80), an ephemeral port is chosen to bind to on the host.

* 両方のポートを指定（ ``ホスト:コンテナ`` ）
* コンテナのポートだけ指定（ホスト側のポートは、一時的なホスト側ポートが選択）
* ホスト IP とポート番号の両方を指定（デフォルトは 0.0.0.0 で、全てのインターフェースを意味します）：（ ``IPアドレス:ホスト側ポート:コンテナ側ポート`` ）。もしもホスト側ポートの指定が無ければ（例 ``127.0.0.1:80`` ）、ホスト上では一時的なポートのバインドが選択されます。

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
    - "127.0.0.1::5000"
    - "6060:6060/udp"
    - "12400-12500:1240"

.. _compose-file-v3-ports-long:

長い構文
^^^^^^^^^^

.. The long form syntax allows the configuration of additional fields that can’t be expressed in the short form.

長い構文によって、短い構文では指定できない追加設定ができるようになります。

..    target: the port inside the container
    published: the publicly exposed port
    protocol: the port protocol (tcp or udp)
    mode: host for publishing a host port on each node, or ingress for a swarm mode port to be load balanced.

* ``target`` ：コンテナ内のポートです。
* ``published`` ：公開用のポートです。
* ``protocol`` ：プロトコル（ ``tcp`` か ``udp`` ）です。
* ``mode`` ： ``host`` であれば各ノード上で公開するホスト側のポート、あるいは、 ``ingress`` であれば負荷分散する swarm モードのポートです。

.. code-block:: yaml

   ports:
     - target: 80
       published: 8080
       protocol: tcp
       mode: host

.. hint::

   Compose 形式 :ref:`compose-file-version-32` で追加されました。

.. _compose-file-v3-profiles:
profiles
----------

.. code-block:: profiles

.. code-block:: yaml

    profiles: ["frontend", "debug"]
    profiles:
      - frontend
      - debug

.. profiles defines a list of named profiles for the service to be enabled under. When not set, the service is always enabled. For the services that make up your core application you should omit profiles so they will always be started.

``profiles`` は有効なサービスに対する名前付きプロフィール一覧を定義します。設定が無ければ、対象のサービスは「常に」有効です。このサービスは、中心となるアプリケーションに対しては ``profiles`` を省略して常に起動すべきでしょう。

.. Valid profile names follow the regex format [a-zA-Z0-9][a-zA-Z0-9_.-]+.

プロフィール名では正規表現の書式 ``[a-zA-Z0-9][a-zA-Z0-9_.-]+`` が使えます。

.. See also Using profiles with Compose to learn more about profiles.

profiles について詳しく学ぶには、 :doc:`Compose で profiles の使用 </compose/profiles>` をご覧ください。

.. _compose-file-v3-restart:

restart
----------

.. no is the default restart policy, and it does not restart a container under any circumstance. When always is specified, the container always restarts. The on-failure policy restarts a container if the exit code indicates an on-failure error. unless-stopped always restarts a container, except when the container is stopped (manually or otherwise).

``no`` がデフォルトの :ref:`再起動ポリシー <use-a-restart-policy>` であり、どのような状況でもコンテナを再起動しません。 ``always`` を指定すると、コンテナは常に再起動します。 ``on-failure`` ポリシーは、エラーが発生時し、終了コードがあれば再起動します。 ``unless-stopped`` は常にコンテナの再起動を行いますが、コンテナの停止時（手動やその他）は除きます。

.. code-block:: bash

   restart: "no"
   restart: always
   restart: on-failure
   restart: unless-stopped

.. attention::

   **docker stack deploy 使用時の注意**
   
     :doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` する場合、  ``restart`` オプションは無視されます。

.. _compose-file-v3-secret:

secrets
----------

サービスごとの ``secrets`` 設定に基いて、機微情報（シークレット）へのアクセスを許可します。2つの構文がサポートされます。

.. attention::

   **docker stack deploy 使用時の注意**
   
   secret は既に存在しているか、compose ファイルで :ref:`トップレベルの secrets 定義 <secrets-configuration-reference>` がなければ、デプロイに失敗します。

secrets に関する詳しい情報は、 :doc:`/engine/swarm/secrets <secrets>` をご覧ください。

短い構文
^^^^^^^^^^

.. The short syntax variant only specifies the secret name. This grants the container access to the secret and mounts it at /run/secrets/<secret_name> within the container. The source name and destination mountpoint are both set to the secret name.

短い構文の書き方は、シークレット名のみ指定します。これによって、対象のコンテナはシークレットにアクセスできるようになり、コンテナ内で ``/run/secrets/<シークレット名>`` でマウントします。ソース名とマウントポイントのどちらもシークレット名が指定されます。

.. The following example uses the short syntax to grant the redis service access to the my_secret and my_other_secret secrets. The value of my_secret is set to the contents of the file ./my_secret.txt, and my_other_secret is defined as an external resource, which means that it has already been defined in Docker, either by running the docker secret create command or by another stack deployment. If the external secret does not exist, the stack deployment fails with a secret not found error.

以下の例では短い構文を使い、 ``redis`` サービスに ``my_secret`` と ``my_other_secret`` シークレットに対するアクセスを許可します。 ``my_secret`` の値には ``./my_secret.txt`` ファイルを指定します。また、 ``my_other_secret`` には外部リソースを定義しています。つまりこれは既に Docker で定義済みか、 ``docker secret create`` コマンのを実行したか、あるいは他のスタックでデプロイ済みです。もし外部シークレットがなければ、 ``secret not found`` のエラーを表示し、スタックのデプロイに失敗します。

.. code-block:: bash

   version: "3.9"
   services:
     redis:
       image: redis:latest
       deploy:
         replicas: 1
       secrets:
         - my_secret
         - my_other_secret
   secrets:
     my_secret:
       file: ./my_secret.txt
     my_other_secret:
       external: true

長い構文
^^^^^^^^^^

.. The long syntax provides more granularity in how the secret is created within the service’s task containers.

長い構文によって、サービスタスク内のコンテナでどのようにシークレットを作成するか、より詳しく設定します。

..     source: The identifier of the secret as it is defined in this configuration.
    target: The name of the file to be mounted in /run/secrets/ in the service’s task containers. Defaults to source if not specified.
    uid and gid: The numeric UID or GID that owns the file within /run/secrets/ in the service’s task containers. Both default to 0 if not specified.
    mode: The permissions for the file to be mounted in /run/secrets/ in the service’s task containers, in octal notation. For instance, 0444 represents world-readable. The default in Docker 1.13.1 is 0000, but is be 0444 in newer versions. Secrets cannot be writable because they are mounted in a temporary filesystem, so if you set the writable bit, it is ignored. The executable bit can be set. If you aren’t familiar with UNIX file permission modes, you may find this permissions calculator useful.

* ``source`` ：この設定を定義するためのシークレットを指定します。
* ``target`` ：サービスタスク内のコンテナで、 ``/run/secrets/`` にマウントするファイル名を指定します。指定がなければ、デフォルトは ``source`` です。
* ``uid`` と ``gid`` ：サービスタスク内のコンテナで、 ``/run/secrets/`` にあるファイルを所有する UID と GID を整数で指定します。
* ``mode`` ：サービスタスク内のコンテナで、 ``/run/secrets/`` にマウントするファイルのパーミッションを8進数で指定します。たとえば ``0444`` は誰でも読める状態を表します。 Docker 1.13.1 のデフォルトは ``0000`` ですが、以降のバージョンでは ``0444`` です。シークレットは一時的なファイルシステムへマウントするため、書き込みができません。そのため、書き込み用のビットを指定しても無視されます。実行ビットも設定できません。UNIX ファイルのパーミッションに慣れていなければ、 `permissions calculator <http://permissions-calculator.org/>`_ が役立ちます。

.. The following example sets name of the my_secret to redis_secret within the container, sets the mode to 0440 (group-readable) and sets the user and group to 103. The redis service does not have access to the my_other_secret secret.

以下の例は、 ``my_secret`` という名前で、 ``redis_secret`` コンテナ内に対し、 モードを ``0440`` （グループが書き込み可能）、かつユーザとグループを ``103`` に指定します。 ``redis`` サービスは ``my_other_secret`` シークレットに対するアクセスができません。

.. code-block:: yaml

   version: "3.9"
   services:
     redis:
       image: redis:latest
       deploy:
         replicas: 1
       secrets:
         - source: my_secret
           target: redis_secret
           uid: '103'
           gid: '103'
           mode: 0440
   secrets:
     my_secret:
       file: ./my_secret.txt
     my_other_secret:
       external: true

.. You can grant a service access to multiple secrets and you can mix long and short syntax. Defining a secret does not imply granting a service access to it.

サービスがアクセスできるシークレットは複数指定できますし、短い構文と長い構文の両方を混ぜて使えます。シークレットの定義は、サービスがシークレットに対してアクセスできるのを意味しません。

.. _compose-file-v3-security_opt:

security_opt
--------------------

.. Override the default labeling scheme for each container.

各コンテナに対するデフォルトの :ruby:`ラベリング・スキーマ <labeling scheme>` を上書きします。

.. code-block:: yaml

   security_opt:
     - label:user:USER
     - label:role:ROLE

.. attention::

   **docker stack deploy 使用時の注意**
   
     :doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` する場合、  ``security_opt`` オプションは無視されます。

.. -compose-file-v3-stop_grace_period:

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

.. -compose-file-v3-stop_signal:

stop_signal
--------------------

.. Sets an alternative signal to stop the container. By default stop uses SIGTERM. Setting an alternative signal using stop_signal will cause stop to send that signal instead.

コンテナに対して別の停止シグナルを設定します。デフォルトでは ``stop`` で SIGTERM を使います。 ``stop_signal`` で別のシグナルを指定したら、 ``stop`` 実行時にそのシグナルを送信します。

.. code-block:: yaml

   stop_signal: SIGUSR1


.. _compose-file-v3-sysctls:

sysctls
--------------------

.. Kernel parameters to set in the container. You can use either an array or a dictionary.

コンテナ内でのカーネル・パラメータを指定します。配列もしくはディレクトリのどちらかで指定できます。

.. code-block:: yaml

   sysctls:
     net.core.somaxconn: 1024
     net.ipv4.tcp_syncookies: 0

.. You can only use sysctls that are namespaced in the kernel. Docker does not support changing sysctls inside a container that also modify the host system. For an overview of supported sysctls, refer to configure namespaced kernel parameters (sysctls) at runtime.

sysctls が使えるのはカーネルの名前空間内のみです。Docker はコンテナ内の sysctls 変更をサポートしていませんし、ホストシステム上の変更もできません。サポートしている sysctls の概要は、 :red:`実行時に名前空間内でのカーネルパラメータ（sysctls）を設定 configure-namespaced-kernel-parameters-sysctls-at-runtime` をご覧ください。

.. note::

   **docker stack deploy 使用時の注意**
   
   このオプションは Docker Engine 19.03 以上か、:doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` する時に利用できます。

.. tmpfs

.. _copmose-file-v3-tmpfs:

tmpfs
----------

.. hint::

   Compose 形式 :ref:`compose-file-version-36` で追加されました。

.. Mount a temporary file system inside the container. Can be a single value or a list.

コンテナ内にテンポラリ・ファイルシステムをマウントします。単一の値もしくはリストです。

.. code-block:: yaml

   tmpfs: /run

.. code-block:: yaml

   tmpfs:
     - /run
     - /tmp

.. attention::

   **docker stack deploy 使用時の注意**
   
    Compose ファイル（バージョン 3～3.5 ）で :doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` をする場合、 このオプションは無視されます。

.. Mount a temporary file system inside the container. Size parameter specifies the size of the tmpfs mount in bytes. Unlimited by default.

コンテナ内の一時的なファイルシステムをマウントします。tmpfs マウントの容量は size パラメータにバイト単位で指定します。デフォルトは無制限です。

.. code-block:: yaml

   - type: tmpfs
     target: /app
     tmpfs:
       size: 1000

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

.. _compose-file-v3-userns_mode:

userns_mode
--------------------

.. code-block:: yaml

   userns_mode: "host"

.. Disables the user namespace for this service, if Docker daemon is configured with user namespaces. See dockerd for more information.

Docker デーモンでユーザ名前空間の指定があっても、このサービスに対する :ruby:`ユーザ名前空間 <user namespace>` を無効にします。詳しい情報は :ref:`dockerd <disable-user-namespace-for-a-container>` をご覧ください。

.. attention::

   **docker stack deploy 使用時の注意**
   
     :doc:`swarm モードのスタックにデプロイ </engine/reference/commandline/stack_deploy>` する場合、  ``userns_mode`` オプションは無視されます。

.. _compose-file-v3-volumes:

volumes
------------------------------

.. Mount host paths or named volumes, specified as sub-options to a service.

ホスト上のパスや :ruby:`名前付きボリューム <named volumes>` のマウントを、サービスのサブオプションとして指定します。

.. You can mount a host path as part of a definition for a single service, and there is no need to define it in the top level volumes key.

ホスト上のパスに対するマウントは、単一サービス向け定義の一部として記述できます。また、その場合はトップレベルの ``volumes`` キー定義は不要です。

.. But, if you want to reuse a volume across multiple services, then define a named volume in the top-level volumes key. Use named volumes with services, swarms, and stack files.

ですが、複数のサービスを横断してボリュームを再利用したい場合は、名前付きボリュームを  :ref:`トップレベルの volume キー <volume-configuration-reference>` としての定義が必要です。

..    Changed in version 3 file format.
    The top-level volumes key defines a named volume and references it from each service’s volumes list. This replaces volumes_from in earlier versions of the Compose file format.

.. note::

   **バージョン 3 ファイル形式で変わりました**
   
   トップレベルの :ref:`volumes <volume-configuration-reference>` キー定義は、名前付きボリュームを定義し、各サービスの ``volumes`` 一覧から参照できるようになります。これは Compose ファイル形式の初期バージョンの ``volumes_from`` を置き換えるものです。

.. This example shows a named volume (mydata) being used by the web service, and a bind mount defined for a single service (first path under db service volumes). The db service also uses a named volume called dbdata (second path under db service volumes), but defines it using the old string format for mounting a named volume. Named volumes must be listed under the top-level volumes key, as shown

次の例が表すのは、名前付きボリューム（ ``mydata`` ）は ``web`` サービスが使用しつつ、単一のサービス（ ``db`` サービスの ``volumes`` にある1行目のパス）に対するバインドマウントです。また、 ``db`` サービスも名前付きボリューム ``dbdata`` （2つめのパスは ``db`` サービス以下の ``volumes`` ）を使いますが、古い書式の文字を使って名前付きボリュームを定義しています。名前付きボリュームを使うには、以下にあるようにトップレベルの ``volumes`` キーに記述する必要があります。

.. code-block:: bash

   version: "3.9"
   services:
     web:
       image: nginx:alpine
       volumes:
         - type: volume
           source: mydata
           target: /data
           volume:
             nocopy: true
         - type: bind
           source: ./static
           target: /opt/app/static
   
     db:
       image: postgres:latest
       volumes:
         - "/var/run/postgres/postgres.sock:/var/run/postgres/postgres.sock"
         - "dbdata:/var/lib/postgresql/data"
   
   volumes:
     mydata:
     dbdata:

..    Note
    For general information on volumes, refer to the use volumes and volume plugins sections in the documentation.

.. note::

   volumes の一般的な情報は、ドキュメントの :doc:`ボリュームの利用 </storage/volumes/>` と :doc:`ボリュームプラグイン </engine/extend/plugins_volume>` をご覧ください。

.. _compose-file-v3-volumes-short-syntax:

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

.. _compose-file-v3-volumes-long-syntax:

.. long syntax

長い書式
^^^^^^^^^^

.. Added in version 3.2 file format.

.. hint::

   ファイル形式 :ref:`compose-file-version-32` で追加されました。

.. The long form syntax allows the configuration of additional fields that can’t be expressed in the short form.

:ruby:`長い書式 <long syntax>` は、短い書式では表現できない追加フィールドを設定できるようにします。

* ``type`` ：マウントの :ruby:`種類 <type>` で ``volume`` 、 ``bind`` 、 ``tmpfs`` 、 ``npipe`` のどれか
* ``source`` ： :ruby:`マウント元 <source>` であり、バインド・マウントするホスト上のパスか、 :ref:`トップレベルの volume キー <compose-file-v3-volume-configuration-reference>` で定義済みのボリューム名。tmpfs マウントでの利用には、不適切
* ``target`` ：コンテナ内で、ボリュームをマウントするパス
* ``read_only`` ：ボリュームを読み込み専用に指定するフラグ
* ``bind`` ：バインドの追加オプションを指定

   * ``propagation`` ：バインドには :ruby:`プロパゲーション・モード <propagation mode>` を使用

* ``volueme`` ：ボリュームの追加オプションを指定

   * ``nocopy`` ：ボリュームを作成しても、コンテナからのデータのコピーを無効にするフラグ

* ``tmpfs`` ：tmpfs の追加オプションを指定

   * ``size`` ：tmpfs マウント用の容量をバイトで指定


.. code-block:: yaml

   version: "3.9"
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

.. _compose-file-v3-volumes-for-services

サービス、swarm、stack ファイルでのボリューム
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. When working with services, swarms, and docker-stack.yml files, keep in mind that the tasks (containers) backing a service can be deployed on any node in a swarm, and this may be a different node each time the service is updated.

.. note::

   **docker stack deploy 使用時の注意**
   
   サービス、swarm、 ``docker-stack.yml`` ファイルを扱う場合、気を付けることがあります。それは、タスク（コンテナ）の背後にあるサービスが swarm 上のどこかにあるノードにデプロイされるため、サービスを更新するたびにノードが異なる可能性があります。

.. In the absence of having named volumes with specified sources, Docker creates an anonymous volume for each task backing a service. Anonymous volumes do not persist after the associated containers are removed.

名前付きボリュームのソースとして指定した場所が存在していなければ、Docker はサービスの後ろにある各タスクに対し、それぞれ匿名ボリュームを作成します。匿名ボリュームは、関連付けられたコンテナが削除されると、存続しません。

.. If you want your data to persist, use a named volume and a volume driver that is multi-host aware, so that the data is accessible from any node. Or, set constraints on the service so that its tasks are deployed on a node that has the volume present.

データを保持し続けたい場合は、名前付きボリュームを使い、かつ、複数のホストで扱えるボリュームドライバを使いますので、あらゆるノード上でアクセス可能なデータとなります。あるいは、サービスにタイして制約（constraint）を指定し、ボリュームが存在しているノード上にタスクがデプロイされるようにします。

.. As an example, the docker-stack.yml file for the votingapp sample in Docker Labs defines a service called db that runs a postgres database. It is configured as a named volume to persist the data on the swarm, and is constrained to run only on manager nodes. Here is the relevant snip-it from that file:

`Docker Labs にある投票アプリ例 <https://github.com/docker/labs/blob/master/beginner/chapters/votingapp.md>`_ 向けの ``docker-stack.yml`` を例に挙げると、 ``postgres`` データベースを動かすための ``db`` と呼ぶサービスを定義します。swarm 上でデータを保持するため、名前付きボリュームを定義します。また、 ``manager`` ノードでのみ実行するよう制約を加えています。先の yaml ファイルから関連する部分だけ取り出したのがこちらです。

.. code-block:: bash

   version: "3.9"
   services:
     db:
       image: postgres:9.4
       volumes:
         - db-data:/var/lib/postgresql/data
       networks:
         - backend
       deploy:
         placement:
           constraints: [node.role == manager]

.. domainname, hostname, ipc, mac_address, privileged, read_only, shm_size, stdin_open, tty, user, working_dir

domainname、hostname、ipc、mac_address、privileged、read_only、shm_size、stdin_open、tty、user、working_dir
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

.. Each of these is a single value, analogous to its docker run counterpart. Note that mac_address is a legacy option.

それぞれの単一の値であり、 :ref:`docker run <runtime-constraints-on-resources>` の値に対応します。 ``mac_address`` は過去のオプションです。


.. code-block:: yaml

   user: postgresql
   working_dir: /code
   
   domainname: foo.com
   hostname: foo
   ipc: host
   mac_address: 02:42:ac:11:65:43
   
   privileged: true
   
   
   read_only: true
   shm_size: 64M
   stdin_open: true
   tty: true


.. Specifying durations

.. _compose-file-v3-specifying-durations:

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

.. _compose-file-v3-specifying-byte-values:

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

.. _compose-file-v3-volume-configuration-reference:

ボリューム設定リファレンス
==============================

.. While it is possible to declare volumes on the fly as part of the service declaration, this section allows you to create named volumes that can be reused across multiple services (without relying on volumes_from), and are easily retrieved and inspected using the docker command line or API. See the docker volume subcommand documentation for more information.

サービス宣言の一部として :ref:`ボリューム <compose-file-volumes>` を臨機応変に宣言できますが、このセクションでは、複数のサービス間（ ``volumes_from`` に依存）を横断して再利用可能な :ruby:`名前付きボリューム <named volume>` を作成します。それから、 docker コマンドラインや API を使って、簡単に取り出したり調査したりします。

.. See use volumes and volume plugins for general information on volumes.

ボリューム上での一般的な情報は、 :doc:`ボリュームの使用 </storage/volumes>` と :doc:`/engine/extend/plugins_volume` をご覧下さい。

.. Here’s an example of a two-service setup where a database’s data directory is shared with another service as a volume so that it can be periodically backed up:

以下は2つのサービスをセットアップする例です。データベースの（ ``data-volume`` という名前の）データ・ディレクトリを、他のサービスからはボリュームとして共有するため、定期的なバックアップのために利用できます。

.. code-block:: yaml

   version: "3.9"
   
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

.. _compose-file-v3-volume-driver:

driver
----------

.. Specify which volume driver should be used for this volume. Defaults to whatever driver the Docker Engine has been configured to use, which in most cases is local. If the driver is not available, the Engine returns an error when docker-compose up tries to create the volume.

このボリュームに対して、どのボリューム・ドライバを使うか指定します。デフォルトは、Docker Engineで使用するように設定されているドライバであり、多くの場合は ``local`` です。対象のドライバが利用できなければ、 ``docker-compose up`` でボリュームを作成しようとしても、Engine はエラーを返します。

.. code-block:: yaml

   driver: foobar

.. driver_opts

.. _compose-file-v3-volume-driver_opts:

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

.. _compose-file-v3-volume-external:

external
--------------------

.. If set to true, specifies that this volume has been created outside of Compose. docker-compose up will not attempt to create it, and will raise an error if it doesn’t exist.

このオプションを ``true`` に設定すると、Compose の外でボリュームを作成します（訳者注：Compose が管理していない Docker ボリュームを利用します、という意味）。 ``docker-compose up`` を実行してもボリュームを作成しません。もしボリュームが存在していなければ、エラーを返します。

.. For version 3.3 and below of the format, external cannot be used in conjunction with other volume configuration keys (driver, driver_opts, labels). This limitation no longer exists for version 3.4 and above.

バージョン 3.3 形式以下では、``external`` は他のボリューム用の設定キー（ ``driver`` 、``driver_opts`` 、 ``labels`` ） と一緒に使えません。この制限は、バージョン 3.4 以上ではありません。

.. In the example below, instead of attemping to create a volume called [projectname]_data, Compose will look for an existing volume simply called data and mount it into the db service’s containers.

以下の例は、 ``[プロジェクト名]_data`` という名称のボリュームを作成する代わりに、Compose は ``data`` という名前で外部に存在するボリュームを探し出し、それを ``db`` サービスのコンテナの中にマウントします。

.. code-block:: yaml

   version: '3.4'
   
   services:
     db:
       image: postgres
       volumes:
         - data:/var/lib/postgres/data
   
   volumes:
     data:
       external: true

.. attention::

   **バージョン 3.4 ファイル形式で非推奨となりました** 
   
   external.name はバージョン 3.4 ファイル形式から非推奨となり、代わりに ``name`` を使います。

.. You can also specify the name of the volume separately from the name used to refer to it within the Compose file:

また、Compose ファイルの中で使われている名前を参照し、ボリューム名を指定可能です。

.. code-block:: yaml

   volumes
     data:
       external:
         name: actual-name-of-volume（実際のボリューム名）

.. attention::

   **docker stack deploy 使用時の注意** 
   
   :ref:`docker stack deploy <compose-file-v3-deploy>` を使い、 :doc:`swarm モード </engine/swarm>` を使って（ :doc:`docker compose up </compose/reference/up>` に代わりに）アプリケーションを起動するとき、 :ruby:`外部ボリューム <extra volumes>` が存在しなければ作成します。swarm モードでは、サービスの定義時にボリュームが自動的に作成されます。サービスタスクが新しいノードにスケジュールされると、 `swarmkit <https://github.com/docker/swarmkit/blob/master/README.md>`_ はローカルノード上にボリュームを作成します。詳しく知るには、 `moby/moby#29976 <https://github.com/moby/moby/issues/29976>`_ をご覧ください。


.. labels

.. _compose-file-v3-volume-labels:

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

.. _compose-file-v3-volume-name:

name
--------------------

.. hint::

   ファイル形式 :ref:`compose-file-version-34` で追加されました。

.. Set a custom name for this volume. The name field can be used to reference volumes that contain special characters. The name is used as is and will not be scoped with the stack name.

このボリュームに対してカスタム名を設定します。この名前の領域は、特別な文字列を含むボリュームとして参照できます。この名前はそのまま全体を通して使用されますので、他の場所ではボリューム名として使用 **できません** 。

.. code-block:: yaml

   version: "3.9"
   volumes:
     data:
       name: my-app-data

.. It can also be used in conjunction with the external property:

また、 `external` 属性とあわせて使えます。

.. code-block:: yaml

   version: "3.9"
   volumes:
     data:
       external: true
       name: my-app-data

.. Network configuration reference

.. _compose-file-v3-network-configuration-reference:

ネットワーク設定リファレンス
==============================

.. The top-level networks key lets you specify networks to be created.
    For a full explanation of Compose’s use of Docker networking features and all network driver options, see the Networking guide.
    For Docker Labs tutorials on networking, start with Designing Scalable, Portable Docker Container Networks

ネットワークを作成するには、トップレベルの ``networks`` キーを使って指定します。

* Compose 上でネットワーク機能を使うための詳細情報は、 :doc:`networking` をご覧ください。
* `Docker Labs <https://github.com/docker/labs/blob/master/README.md>`__ チュートリアルのネットワークについては、 `Designing Scalable, Portable Docker Container Networks <https://github.com/docker/labs/blob/master/networking/README.md>`_ をご覧ください。

.. driver
 
.. _compose-file-v3-network-driver:

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


bridge
^^^^^^^^^^

.. Docker defaults to using a bridge network on a single host. For examples of how to work with bridge networks, see the Docker Labs tutorial on Bridge networking.

単一ホスト上では、Docker はデフォルトで ``bridge`` ネットワークを使用します。ブリッジネットワークの動作については、 Docker Labs チュートリアルにある `Bridge networking <https://github.com/docker/labs/blob/master/networking/A2-bridge-networking.md>`_ をご覧ください。

overlay
^^^^^^^^^^

.. The overlay driver creates a named network across multiple nodes in a swarm.
    For a working example of how to build and use an overlay network with a service in swarm mode, see the Docker Labs tutorial on Overlay networking and service discovery.
    For an in-depth look at how it works under the hood, see the networking concepts lab on the Overlay Driver Network Architecture.

``overlay`` ドライバは :doc:`/engine/swarm` 上の複数のノードを横断する名前付きネットワークを作成します。

* swam モード上のサービスが、 ``overlay`` ネットワークをどのようにバインドして使うかについて、Docker Labs チュートリアルにある `Overlay networking and service discovery <https://github.com/docker/labs/blob/master/networking/A3-overlay-networking.md>`_ をご覧ください。
* 仕組みに関する詳細な実装は、networking concepts la にある `Overlay Driver Network Architecture <https://github.com/docker/labs/blob/master/networking/concepts/06-overlay-networks.md>`_ をご覧ください。

host か none
^^^^^^^^^^^^^^^^^^^^

.. Use the host’s networking stack, or no networking. Equivalent to docker run --net=host or docker run --net=none. Only used if you use docker stack commands. If you use the docker-compose command, use network_mode instead.

ホスト側のネットワーク・スタックを使うか、使用しないかです。これは ``docker run --net=host`` や ``docker run --net=none`` と同等です。 ``docker stack`` コマンドの使用時にのみ有効です。 ``docker-compose`` コマンドを使う場合は、代わりに :ref:`network_mode <compose-file-v3-network_mode>` を使います。

.. If you want to use a particular network on a common build, use [network] as mentioned in the second yaml file example.

構築に共通する特定のネットワークを作成したい場合は、以下の2つめの yaml ファイル例にあるような [network] を使います。

.. The syntax for using built-in networks such as host and none is a little different. Define an external network with the name host or none (that Docker has already created automatically) and an alias that Compose can use (hostnet or nonet in the following examples), then grant the service access to that network using the alias.

``host`` と ``none`` のような組み込みネットワークを使う構文は、少し異なります。 ``host`` や ``none`` は外部ネットワークとして定義してあり（これらは Docker が自動的に作成済み）、それを Compose が別名として使えるようにしていますので（以下の例にある ``hostnet`` と ``none`` ）、サービスが各ネットワークに接続するには、それらの別名でアクセス権限を与えます。

.. code-block:: yaml

   version: "3.9"
   services:
     web:
       networks:
         hostnet: {}
   
   networks:
     hostnet:
       external: true
       name: host

.. code-block:: yaml

   services:
     web:
       ...
       build:
         ...
         network: host
         context: .
         ...

.. code-block:: yaml

   services:
     web:
       ...
       networks:
         nonet: {}
   
   networks:
     nonet:
       external: true
       name: none

.. driver_opts

.. _compose-file-v3-network-driver_opts:

driver_opts
--------------------

.. Specify a list of options as key-value pairs to pass to the driver for this network. Those options are driver-dependent - consult the driver’s documentation for more information. Optional.

ネットワークが使うドライバに対して、オプションをキーバリューのペアで指定します。これらのオプションはドライバに依存します。オプションの詳細については、各ドライバのドキュメントをご確認ください。

.. code-block:: yaml

     driver_opts:
       foo: "bar"
       baz: 1

.. _compose-file-v3-network-attachable:

attachable
--------------------

.. hint::

   Compose 形式 :ref:`compose-file-version-32` で追加されました。

.. Only used when the driver is set to overlay. If set to true, then standalone containers can attach to this network, in addition to services. If a standalone container attaches to an overlay network, it can communicate with services and standalone containers that are also attached to the overlay network from other Docker daemons.

``driver`` を ``overlay`` に設定した時のみ利用できます。これを ``true`` に指定すると、スタンドアロン・コンテナが対象ネットワークに加え、サービスに対しても接続できるようになります。もしもスタンドアロン・コンテナがオーバレイネットワークにアタッチすると、サービスとスタンドアロン・コンテナが通信可能となります。さらに、他の Docker デーモンからもオーバレイ・ネットワークに接続できるようになります。

.. code-block:: yaml

   networks:
     mynet1:
       driver: overlay
       attachable: true

.. enable_ipv6

.. _compose-file-v3-network-enable_ipv6:

enable_ipv6
--------------------

.. Enable IPv6 networking on this network.

このネットワーク上で IPv6 通信を有効にします。

.. warning::

   **Compose ファイル形式バージョン 3 ではサポートされていません**
   
   ``enable_ipv6`` が必要な場合は、バージョン 2 Compose ファイルを使います。また、この指定は Swarm モードでも未サポートです。


.. ipam

.. _compose-file-v3-network-ipam:

ipam
----------

.. Specify custom IPAM config. This is an object with several properties, each of which is optional:

IPAM （IPアドレス管理）のカスタム設定を指定します。様々なプロパティ（設定）を持つオブジェクトですが、各々の指定はオプションです。

..    driver: Custom IPAM driver, instead of the default.
    config: A list with zero or more config blocks, each containing any of the following keys:
        subnet: Subnet in CIDR format that represents a network segment

* ``driver`` ：デフォルトの代わりに、カスタム IPAM ドライバを指定します。
* ``config`` ：ゼロもしくは複数の設定ブロック一覧です。次のキーを使えます。

  * ``subnet`` ：ネットワーク・セグメントにおける CIDR のサブネットを指定します。
* ``options`` ：キーバリュー形式で、ドライバ固有のオプションを指定します。

.. A full example:

全てを使った例：

.. code-block:: yaml

   ipam:
     driver: default
     config:
       - subnet: 172.28.0.0/16

.. Additional IPAM configurations, such as gateway, are only honored for version 2 at the moment.

.. note::

   ``gateway`` のような追加の IPAM 設定は、現時点ではバージョン 2 のみ有効です。

.. _compose-file-v3-network-internal:

internal
--------------------

.. By default, Docker also connects a bridge network to it to provide external connectivity. If you want to create an externally isolated overlay network, you can set this option to true.

Docker は外部との接続をするために、デフォルトではブリッジネットワークにも接続します。外部への隔たれたオーバレイ・ネットワークを作成したい場合は、このオプションを ``true`` に指定できます。


.. _compose-file-v3-network-labels:
labels
----------

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

.. _compose-file-v3-network-external:

external
--------------------

.. If set to true, specifies that this network has been created outside of Compose. docker-compose up will not attempt to create it, and will raise an error if it doesn’t exist.

このオプションを ``true`` に設定したら、Compose の外にネットワークを作成します（訳者注：Compose が管理していない Docker ネットワークを利用します、という意味）。 ``docker-compose up`` を実行してもネットワークを作成しません。もしネットワークが存在していなければ、エラーを返します。

.. For version 3.3 and below of the format, external cannot be used in conjunction with other network configuration keys (driver, driver_opts, ipam, internal). This limitation no longer exists for version 3.4 and above.

バージョン 3.3 形式までは、``external`` は他のネットワーク用の設定キー（ ``driver`` 、``driver_opts`` 、 ``ipam`` ） と一緒に使えません。この制限はバージョン 3.4 以上にはありません。

.. In the example below, proxy is the gateway to the outside world. Instead of attemping to create a network called [projectname]_outside, Compose will look for an existing network simply called outside and connect the proxy service’s containers to it.

以下の例は、外の世界とのゲートウェイに ``proxy`` を使います。 ``[プロジェクト名]_outside`` という名称のネットワークを作成する代わりに、Compose は ``outside`` という名前で外部に存在するネットワークを探し出し、それを ``proxy`` サービスのコンテナに接続します。

.. code-block:: yaml

   version: '3.9'
   
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

.. attention::

   **バージョン3.5ファイル形式で非推奨になりました**
   
   external.name はバージョン 3.5 形式で非推奨となり、代わりに ``name`` を使います。

.. You can also specify the name of the network separately from the name used to refer to it within the Compose file:

また、Compose ファイルの中で使われている名前を参照し、ネットワーク名を指定可能です。

.. code-block:: yaml

   version: "3.9"
   networks:
     outside:
       external:
         name: actual-name-of-network

.. _compose-file-v3-network-name:

name
----------

.. hint::

   Compose 形式 :ref:`compose-file-version-35` で追加されました。

.. Set a custom name for this network. The name field can be used to reference networks which contain special characters. The name is used as is and will not be scoped with the stack name.

このネットワークにカスタム名を指定します。 name のフィールドには、特別な文字を含むネットワーク参照が使えます。この名前は単に名前として使われるだけであり、スタック名のスコープでは使われ **ません** 。

.. code-block:: yaml

   version: "3.9"
   networks:
     network1:
       name: my-app-net

.. It can also be used in conjunction with the external property:

また、 ``external`` プロパティをつなげても利用できます。

.. code-block:: yaml

    version: "3.9"
    networks:
      network1:
        external: true
        name: my-app-net

.. configs configuration reference

.. _compose-file-v3-configs-configuration-reference:

configs 設定リファレンス
==============================

.. The top-level configs declaration defines or references configs that can be granted to the services in this stack. The source of the config is either file or external.

トップレベルの ``configs`` は :doc:`configs </engine/swarm/configs>` の定義やリファレンスを宣言します。また、対象スタック上のサービスに対しても権限を与えられます。設定の元になるのは ``file`` か ``external`` です。

..    file: The config is created with the contents of the file at the specified path.
    external: If set to true, specifies that this config has already been created. Docker does not attempt to create it, and if it does not exist, a config not found error occurs.
    name: The name of the config object in Docker. This field can be used to reference configs that contain special characters. The name is used as is and will not be scoped with the stack name. Introduced in version 3.5 file format.
    driver and driver_opts: The name of a custom secret driver, and driver-specific options passed as key/value pairs. Introduced in version 3.8 file format, and only supported when using docker stack.
    template_driver: The name of the templating driver to use, which controls whether and how to evaluate the secret payload as a template. If no driver is set, no templating is used. The only driver currently supported is golang, which uses a golang. Introduced in version 3.8 file format, and only supported when using docker stack. Refer to use a templated config for a examples of templated configs.

* ``file`` ：指定したパスにあるファイル内容から、設定を作成します。
* ``external`` ：true に設定するのは、設定が既に作成済みの場合です。Docker は設定を作成しようとしませんが、もし存在していなければ、 ``config not found`` エラーを出します。
* ``name`` ：Docker 内の設定オブジェクトに対する名前です。このフィールドには、対象の設定に対するリファレンス（参照）として用いることができる特別な文字を含められます。この名前は設定でのみ利用できるもので、スタック名の範囲内では **使えません** 。バージョン 3.5 ファイル形式から導入されました。
* ``driver`` と ``driver_opts`` ：カスタムシークレット・ドライバの名前と、ドライバ固有のオプションをキーバリューのペアで渡します。バージョン 3.8 ファイル形式から導入されました。また、 ``docker stack`` の利用時のみサポートされます。
* ``template_driver`` ：使用するテンプレーティング・ドライバの名前です。これは、シークレットのペイロード（内容）をテンプレートとして、どこでどのように扱うかを制御します。現在サポートされているドライバは ``golang`` のみで、使うには ``golang`` と書きます。バージョン 3.8 ファイル形式から導入され、 ``docker stack`` 利用時のみサポートされます。テンプレート化設定の例については :ref:`テンプレート化設定を使う <example-use-a-templated-config>` をご覧ください。

.. In this example, my_first_config is created (as <stack_name>_my_first_config)when the stack is deployed, and my_second_config already exists in Docker.

この例では、スタックがデプロイされると ``my_first_config`` が（ ``<スタック名>_my_first_config``として ）作成されます。そして、 ``my_second_config`` は Docker 内に既に存在しています。

.. code-block:: yaml

   configs:
     my_first_config:
       file: ./config_data
     my_second_config:
       external: true

.. Another variant for external configs is when the name of the config in Docker is different from the name that exists within the service. The following example modifies the previous one to use the external config called redis_config.

外部設定の他の書き方は、既存のサービス内に存在するものとは異なる名前で Docker 上で設定名を使うものです。以下の例は、先ほどの例を ``redis_config`` と呼ぶ外部設定を使います。

.. code-block:: yaml

   configs:
     my_first_config:
       file: ./config_data
     my_second_config:
       external:
         name: redis_config

.. You still need to grant access to the config to each service in the stack.

なお、スタック上の各サービスに対しても :ref:`configs に対するアクセス権限 <compose-file-v3-configs>` が必要です。

.. _compose-file-v3-secrets-configuration-reference:

secrets 設定リファレンス
==============================

.. The top-level secrets declaration defines or references secrets that can be granted to the services in this stack. The source of the secret is either file or external.

トップレベルの ``secrets`` は :doc:`configs </engine/swarm/secrets>` の定義やリファレンスを宣言します。また、対象スタック上のサービスに対しても権限を与えられます。設定の元になるのは ``file`` か ``external`` です。

* ``file`` ：指定したパスにあるファイル内容から、設定を作成します。
* ``external`` ：true に設定するのは、設定が既に作成済みの場合です。Docker は設定を作成しようとしませんが、もし存在していなければ、 ``config not found`` エラーを出します。
* ``name`` ：Docker 内の設定オブジェクトに対する名前です。このフィールドには、対象の設定に対するリファレンス（参照）として用いることができる特別な文字を含められます。この名前は設定でのみ利用できるもので、スタック名の範囲内では **使えません** 。バージョン 3.5 ファイル形式から導入されました。
* ``driver`` と ``driver_opts`` ：カスタムシークレット・ドライバの名前と、ドライバ固有のオプションをキーバリューのペアで渡します。バージョン 3.8 ファイル形式から導入されました。また、 ``docker stack`` の利用時のみサポートされます。
* ``template_driver`` ：使用するテンプレーティング・ドライバの名前です。これは、シークレットのペイロード（内容）をテンプレートとして、どこでどのように扱うかを制御します。現在サポートされているドライバは ``golang`` のみで、使うには ``golang`` と書きます。バージョン 3.8 ファイル形式から導入され、 ``docker stack`` 利用時のみサポートされます。テンプレート化設定の例については :ref:`テンプレート化設定を使う <example-use-a-templated-config>` をご覧ください。

.. In this example, my_first_secret is created as <stack_name>_my_first_secret when the stack is deployed, and my_second_secret already exists in Docker.

この例では、スタックがデプロイされると ``my_first_secret`` が（ ``<スタック名>_my_first_secret``として ）作成されます。そして、 ``my_second_secret`` は Docker 内に既に存在しています。

.. code-block:: yaml

   secrets:
     my_first_secret:
       file: ./secret_data
     my_second_secret:
       external: true

.. Another variant for external secrets is when the name of the secret in Docker is different from the name that exists within the service. The following example modifies the previous one to use the external secret called redis_secret.

外部設定の他の書き方は、既存のサービス内に存在するものとは異なる名前で Docker 上で設定名を使うものです。以下の例は、先ほどの例を ``redis_config`` と呼ぶ外部設定を使います。

Compose ファイル v3.5 以上
------------------------------

.. code-block:: yaml

   secrets:
     my_first_secret:
       file: ./secret_data
     my_second_secret:
       external: true
       name: redis_secret

Compose ファイル v3.4 以下
------------------------------

.. code-block:: bash

     my_second_secret:
       external:
         name: redis_secret

.. You still need to grant access to the secrets to each service in the stack.

なお、スタック上の各サービスに対しても :ref:`secrets に対するアクセス権限 <compose-file-v3-secrets>` が必要です。

.. Variable substitution

.. _compose-file-v3-variable-substitution:

変数の置き換え
====================

.. Your configuration options can contain environment variables. Compose uses the variable values from the shell environment in which docker-compose is run. For example, suppose the shell contains POSTGRES_VERSION=9.3 and you supply this configuration:

設定オプションでは環境変数も含めることができます。シェル上の Compose は ``docker-compose`` の実行時に環境変数を使えます。たとえば、シェルで ``POSTGRES_VERSION=9.3`` という変数を設定ファイルで扱うには、次のようにします。

.. code-block:: yaml

   db:
     image: "postgres:${POSTGRES_VERSION}"

.. When you run docker-compose up with this configuration, Compose looks for the POSTGRES_VERSION environment variable in the shell and substitutes its value in. For this example, Compose resolves the image to postgres:9.3 before running the configuration.

この設定で ``docker-compose up`` を実行したら、Compose は ``POSTGRES_VERSION`` 環境変数をシェル上で探し、それを値と置き換えます。この例では、Compose は設定を実行する前に ``image`` に ``postgres:9.3`` を割り当てます。

.. If an environment variable is not set, Compose substitutes with an empty string. In the example above, if POSTGRES_VERSION is not set, the value for the image option is postgres:.

環境変数が設定されていなければ、Compose は空の文字列に置き換えます。先の例では、 ``POSTGRES_VERSION`` が設定されなければ、 ``image`` オプションは ``postgres:`` です。

.. You can set default values for environment variables using a .env file, which Compose automatically looks for in project directory (parent folder of your Compose file). Values set in the shell environment override those set in the .env file.

環境変数のデフォルト値は doc:`.env ファイル <env-file>` を使って指定できます。Compose はプロジェクトのディレクトリ内（Compose ファイルが置いてある親フォルダ）を自動的に探します。シェル環境における値は、 ``.env`` ファイル内のもので上書きします。

..     Note when using docker stack deploy
    The .env file feature only works when you use the docker-compose up command and does not work with docker stack deploy.

.. attention::

   ``.env`` ファイル機能が使えるのは ``docker-compose up`` コマンドを使った時のみです。 ``docker stack deploy`` では機能しません。

.. Both $VARIABLE and ${VARIABLE} syntax are supported. Additionally when using the 2.1 file format, it is possible to provide inline default values using typical shell syntax:

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

   Compose 形式 :ref:`compose-file-version-34` で追加されました。

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

