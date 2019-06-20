.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/compose-file/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/compose/compose-file/index.md
   doc version: 1.11
      https://github.com/docker/docker.github.io/blob/master/compose/compose-file/index.md
.. ----------------------------------------------------------------------------

.. title: Compose file version 3 reference

.. _compose-file-reference:

===========================================
Compose ファイル バージョン 3 リファレンス
===========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. ## Reference and guidelines

.. _reference-and-guidelines:

リファレンスとガイドライン
===========================

.. These topics describe version 3 of the Compose file format. This is the newest
   version.

ここに示す内容は Compose ファイルフォーマット、バージョン 3 です。
これが最新バージョンです。

.. ## Compose and Docker compatibility matrix

.. _compose-and-docker-compatibility-matrix:

Compose と Docker の互換マトリックス
=====================================

.. There are several versions of the Compose file format – 1, 2, 2.x, and 3.x. The
   table below is a quick look. For full details on what each version includes and
   how to upgrade, see **[About versions and upgrading](compose-versioning.md)**.

Compose ファイルフォーマットには 1、2、2.x、3.x という複数のバージョンがあります。
その様子は以下の一覧表に見ることができます。
各バージョンにて何が増えたのか、どのようにアップグレードしたのか、といった詳細については :ref:`バージョンとアップグレードについて <compose-versioning>` を参照してください。

.. {% include content/compose-matrix.md %}

.. include:: ../../_includes/content/compose-matrix.rst

.. ## Compose file structure and examples

.. _compose-file-structure-and-examples:

Compose ファイルの構造と記述例
===============================

.. 以下の raw 構文をコメント化；うまく動作しないため
.. .. raw:: html
   
      <div class="panel panel-default">
          <div class="panel-heading collapsed" data-toggle="collapse" data-target="#collapseSample1" style="cursor: pointer">
          Compose ファイル バージョン 3 の記述例
          <i class="chevron fa fa-fw"></i></div>
          <div class="collapse block" id="collapseSample1">
      <pre><code>
      version: "3"
      services:
      
        redis:
          image: redis:alpine
          ports:
            - "6379"
          networks:
            - frontend
          deploy:
            replicas: 2
            update_config:
              parallelism: 2
              delay: 10s
            restart_policy:
              condition: on-failure
      
        db:
          image: postgres:9.4
          volumes:
            - db-data:/var/lib/postgresql/data
          networks:
            - backend
          deploy:
            placement:
              constraints: [node.role == manager]
      
        vote:
          image: dockersamples/examplevotingapp_vote:before
          ports:
            - 5000:80
          networks:
            - frontend
          depends_on:
            - redis
          deploy:
            replicas: 2
            update_config:
              parallelism: 2
            restart_policy:
              condition: on-failure
      
        result:
          image: dockersamples/examplevotingapp_result:before
          ports:
            - 5001:80
          networks:
            - backend
          depends_on:
            - db
          deploy:
            replicas: 1
            update_config:
              parallelism: 2
              delay: 10s
            restart_policy:
              condition: on-failure
      
        worker:
          image: dockersamples/examplevotingapp_worker
          networks:
            - frontend
            - backend
          deploy:
            mode: replicated
            replicas: 1
            labels: [APP=VOTING]
            restart_policy:
              condition: on-failure
              delay: 10s
              max_attempts: 3
              window: 120s
            placement:
              constraints: [node.role == manager]
      
        visualizer:
          image: dockersamples/visualizer:stable
          ports:
            - "8080:8080"
          stop_grace_period: 1m30s
          volumes:
            - "/var/run/docker.sock:/var/run/docker.sock"
          deploy:
            placement:
              constraints: [node.role == manager]
      
      networks:
        frontend:
        backend:
      
      volumes:
        db-data:
      </code></pre>
          </div>
      </div>

Compose ファイル バージョン 3 の記述例:

.. code-block:: dockerfile

   version: "3"
   services:
   
     redis:
       image: redis:alpine
       ports:
         - "6379"
       networks:
         - frontend
       deploy:
         replicas: 2
         update_config:
           parallelism: 2
           delay: 10s
         restart_policy:
           condition: on-failure
   
     db:
       image: postgres:9.4
       volumes:
         - db-data:/var/lib/postgresql/data
       networks:
         - backend
       deploy:
         placement:
           constraints: [node.role == manager]
   
     vote:
       image: dockersamples/examplevotingapp_vote:before
       ports:
         - 5000:80
       networks:
         - frontend
       depends_on:
         - redis
       deploy:
         replicas: 2
         update_config:
           parallelism: 2
         restart_policy:
           condition: on-failure
   
     result:
       image: dockersamples/examplevotingapp_result:before
       ports:
         - 5001:80
       networks:
         - backend
       depends_on:
         - db
       deploy:
         replicas: 1
         update_config:
           parallelism: 2
           delay: 10s
         restart_policy:
           condition: on-failure
   
     worker:
       image: dockersamples/examplevotingapp_worker
       networks:
         - frontend
         - backend
       deploy:
         mode: replicated
         replicas: 1
         labels: [APP=VOTING]
         restart_policy:
           condition: on-failure
           delay: 10s
           max_attempts: 3
           window: 120s
         placement:
           constraints: [node.role == manager]
   
     visualizer:
       image: dockersamples/visualizer:stable
       ports:
         - "8080:8080"
       stop_grace_period: 1m30s
       volumes:
         - "/var/run/docker.sock:/var/run/docker.sock"
       deploy:
         placement:
           constraints: [node.role == manager]
   
   networks:
     frontend:
     backend:
   
   volumes:
     db-data:

.. The topics on this reference page are organized alphabetically by top-level key
   to reflect the structure of the Compose file itself. Top-level keys that define
   a section in the configuration file such as `build`, `deploy`, `depends_on`,
   `networks`, and so on, are listed with the options that support them as
   sub-topics. This maps to the `<key>: <option>: <value>` indent structure of the
   Compose file.

このリファレンスページで取り上げているトピックは、Compose ファイルの構造に合わせて、最上位のキー項目をアルファベット順に示しています。
最上位のキー項目とは、設定ファイルにおいてのセクションを定義するものであり、``build``、``deploy``、``depends_on``、``networks`` などのことです。
そのキー項目ごとに、それをサポートするオプションをサブトピックとして説明しています。
これは Compose ファイルにおいて ``<key>: <option>: <value>`` という形式のインデント構造に対応します。

.. A good place to start is the [Getting Started](/get-started/index.md) tutorial
   which uses version 3 Compose stack files to implement multi-container apps,
   service definitions, and swarm mode. Here are some Compose files used in the
   tutorial.

理解しやすいのは、:doc:`始めましょう </get-started/index>` にて示しているチュートリアルです。
そこでは Compose ファイルのバージョン 3 を使って、マルチコンテナーアプリケーション、サービス定義、スウォームモードを実現しています。
チュートリアルで利用している Compose ファイルは以下のものです。

.. - [Your first docker-compose.yml File](/get-started/part3.md#your-first-docker-composeyml-file)
   
   - [Adding a new service and redeploying](/get-started/part5.md#adding-a-new-service-and-redeploying)

* :ref:`はじめての docker-compose.yml ファイル <your-first-docker-composeyml-file>`

* :ref:`サービスの新規追加と再デプロイ <adding-a-new-service-and-redeploying>`

.. Another good reference is the Compose file for the voting app sample used in the
   [Docker for Beginners lab](https://github.com/docker/labs/tree/master/beginner/)
   topic on [Deploying an app to a
   Swarm](https://github.com/docker/labs/blob/master/beginner/chapters/votingapp.md). This is also shown on the accordion at the top of this section.

別のリファレンスとして `Deploying an app to a
Swarm <https://github.com/docker/labs/blob/master/beginner/chapters/votingapp.md>`_ の中のトピック `Docker for Beginners lab <https://github.com/docker/labs/tree/master/beginner/>`_ において利用されている投票アプリのサンプルの Compose ファイルが参考になります。
これも本節の上部にあるコードの中に示しています。

.. Service configuration reference

.. _service-configuration-reference:

サービス設定リファレンス
==============================

.. The Compose file is a [YAML](http://yaml.org/) file defining
   [services](#service-configuration-reference),
   [networks](#network-configuration-reference) and
   [volumes](#volume-configuration-reference).
   The default path for a Compose file is `./docker-compose.yml`.

Compose ファイルは `YAML <http://yaml.org/>`_ 形式のファイルであり、:ref:`サービス（services） <service-configuration-reference>` 、:ref:`ネットワーク（networks） <network-configuration-reference>` 、 :ref:`ボリューム（volumes） <volume-configuration-reference>` を定義します。
Compose ファイルのデフォルトパスは ``./docker-compose.yml`` です。

.. >**Tip**: You can use either a `.yml` or `.yaml` extension for this file.
   They both work.

.. tip::

   このファイルの拡張子は ``.yml`` と ``.yaml`` のどちらでも構いません。
   いずれでも動作します。

.. A service definition contains configuration which will be applied to each
   container started for that service, much like passing command-line parameters to
   `docker run`. Likewise, network and volume definitions are analogous to
   `docker network create` and `docker volume create`.

サービスの定義とは、そのサービスを起動する各コンテナに適用される設定を行うことです。
コマンドラインから ``docker container create`` のパラメータを受け渡すことと、非常によく似ています。
同様に、ネットワークの定義、ボリュームの定義は、それぞれ ``docker network create`` と ``docker volume create`` のコマンドに対応づくものです。

.. As with `docker run`, options specified in the Dockerfile (e.g., `CMD`,
   `EXPOSE`, `VOLUME`, `ENV`) are respected by default - you don't need to
   specify them again in `docker-compose.yml`.

``docker container create`` に関しても同じことが言えますが、Dockerfile にて指定された ``CMD``、 ``EXPOSE``、 ``VOLUME``、 ``ENV`` のようなオプションはデフォルトでは維持されます。したがって ``docker-compose.yml`` の中で再度設定する必要はありません。

.. You can use environment variables in configuration values with a Bash-like
   `${VARIABLE}` syntax - see
   [variable substitution](#variable-substitution) for full details.

設定を記述する際には環境変数を用いることができます。
環境変数は Bash 風に ``${VARIABLE}`` のように記述します。
詳しくは :ref:`変数の置換 <variable-substitution>` を参照してください。

.. This section contains a list of all configuration options supported by a service
   definition in version 3.

このセクションでは、バージョン 3 のサービス定義においてサポートされている設定オプションをすべて説明しています。

.. build

.. _compose-file-build:

build
----------

.. Configuration options that are applied at build time.

この設定オプションはビルド時に適用されます。

.. `build` can be specified either as a string containing a path to the build
   context:

``build`` の指定方法の 1 つは、ビルドコンテキストへのパスを表わす文字列を指定します。

.. ```none
   version: '2'
   services:
     webapp:
       build: ./dir
   ```

.. code-block:: yaml

   version: '2'
   services:
     webapp:
       build: ./dir

.. Or, as an object with the path specified under [context](#context) and
   optionally [Dockerfile](#dockerfile) and [args](#args):

あるいは :ref:`コンテキスト <compose-file-context>` の指定のもとにパスを指定し、オプションとして :ref:`Dockerfile <compose-file-dockerfile>` や :ref:`args <compose-file-args>` を記述する方法をとります。

.. ```none
   version: '2'
   services:
     webapp:
       build:
         context: ./dir
         dockerfile: Dockerfile-alternate
         args:
           buildno: 1
   ```

.. code-block:: yaml

   version: '2'
   services:
     webapp:
       build:
         context: ./dir
         dockerfile: Dockerfile-alternate
         args:
           buildno: 1

.. If you specify `image` as well as `build`, then Compose names the built image
   with the `webapp` and optional `tag` specified in `image`:

``build`` に加えて ``image`` も指定した場合、Compose はビルドイメージに名前をつけます。
たとえば以下のように ``image`` を指定すると、イメージ名を ``webapp``、オプションのタグを ``tag`` という名前にします。

..  build: ./dir
    image: webapp:tag

.. code-block:: yaml

   build: ./dir
   image: webapp:tag

.. This will result in an image named `webapp` and tagged `tag`, built from `./dir`.

結果としてイメージ名は ``webapp`` であり ``tag`` というタグづけが行われます。
そしてこのイメージは ``./dir`` から作り出されます。

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file. The `docker stack` command accepts only pre-built images.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。
   ``docker stack`` コマンドは、ビルド済のイメージのみを受け付けるためです。

.. context

.. _compose-file-context:

context
^^^^^^^^

.. Either a path to a directory containing a Dockerfile, or a url to a git repository.

Dockerfile を含むディレクトリへのパスか、あるいは git リポジトリの URL を設定します。

.. When the value supplied is a relative path, it is interpreted as relative to the
   location of the Compose file. This directory is also the build context that is
   sent to the Docker daemon.

設定された記述が相対パスを表わしている場合、Compose ファイルのあるディレクトリからの相対パスとして解釈されます。
このディレクトリはビルドコンテキストでもあり、Docker デーモンへ送信されるディレクトリです。

.. Compose will build and tag it with a generated name, and use that image
   thereafter.

Compose は指定された名前により、イメージのビルドとタグづけを行い、後々これを利用します。

..  build:
      context: ./dir

.. code-block:: yaml

   build:
     context: ./dir

.. dockerfile

.. _compose-file-dockerfile:

dockerfile
^^^^^^^^^^^

.. Alternate Dockerfile.

別の Dockerfile を指定します。

.. Compose will use an alternate file to build with. A build path must also be
   specified.

Compose は指定された別の Dockerfile を使ってビルドを行います。
このときは、ビルドパスを同時に指定しなければなりません。

..  build:
      context: .
      dockerfile: Dockerfile-alternate

.. code-block:: yaml

   build:
     context: .
     dockerfile: Dockerfile-alternate

.. args

.. _compose-file-args:

args
^^^^^

.. Add build arguments, which are environment variables accessible only during the
   build process.

ビルド引数を追加します。
これは環境変数であり、ビルド処理の間だけ利用可能なものです。

.. First, specify the arguments in your Dockerfile:

Dockerfile 内にてはじめにビルド引数を指定します。

..  ARG buildno
    ARG password

..  RUN echo "Build number: $buildno"
    RUN script-requiring-password.sh "$password"

.. code-block:: yaml

   ARG buildno
   ARG password

   RUN echo "Build number: $buildno"
   RUN script-requiring-password.sh "$password"

.. Then specify the arguments under the `build` key. You can pass either a mapping
   or a list:

そして ``build`` キーのもとにその引数を指定します。
指定は個々をマッピングする形式か、リストとする形式が可能です。

..  build:
      context: .
      args:
        buildno: 1
        password: secret

..  build:
      context: .
      args:
        - buildno=1
        - password=secret

.. code-block:: yaml

   build:
     context: .
     args:
       buildno: 1
       password: secret

   build:
     context: .
     args:
       - buildno=1
       - password=secret

.. You can omit the value when specifying a build argument, in which case its value
   at build time is the value in the environment where Compose is running.

ビルド引数の指定にあたって、その値設定を省略することができます。
この場合、ビルド時におけるその値は、Compose を起動している環境での値になります。

..  args:
      - buildno
      - password

.. code-block:: yaml

   args:
     - buildno
     - password

.. > **Note**: YAML boolean values (`true`, `false`, `yes`, `no`, `on`, `off`) must
   > be enclosed in quotes, so that the parser interprets them as strings.

.. note::

   YAML のブール値（``true``, ``false``, ``yes``, ``no``, ``on``, ``off``）を用いる場合は、クォートで囲む必要があります。
   そうすることで、これらの値は文字列として解釈されます。

.. #### cache_from

cache_from
^^^^^^^^^^^

.. > **Note:** This option is new in v3.2

.. note::

   このオプションはバージョン 3.2 において新たに追加されました。

.. A list of images that the engine will use for cache resolution.

エンジンがキャッシュ解決のために利用するイメージを設定します。

..  build:
      context: .
      cache_from:
        - alpine:latest
        - corp/web_app:3.14

.. code-block:: yaml

   build:
     context: .
     cache_from:
       - alpine:latest
       - corp/web_app:3.14

.. #### labels

.. _compose-file-labels:

labels
^^^^^^^^

.. > **Note:** This option is new in v3.3

.. note::

   このオプションはバージョン 3.3 において新たに追加されました。

.. Add metadata to the resulting image using [Docker labels](/engine/userguide/labels-custom-metadata.md).
   You can use either an array or a dictionary.

:doc:`Docker labels </engine/userguide/labels-custom-metadata>` を使ってイメージにメタデータを追加します。
配列形式と辞書形式のいずれかにより指定します。

.. It's recommended that you use reverse-DNS notation to prevent your labels from conflicting with
   those used by other software.

ここでは逆 DNS 記法とすることをお勧めします。
この記法にしておけば、他のソフトウェアが用いるラベルとの競合が避けられるからです。

..  build:
      context: .
      labels:
        com.example.description: "Accounting webapp"
        com.example.department: "Finance"
        com.example.label-with-empty-value: ""

.. code-block:: yaml

   build:
     context: .
     labels:
       com.example.description: "Accounting webapp"
       com.example.department: "Finance"
       com.example.label-with-empty-value: ""

..  build:
      context: .
      labels:
        - "com.example.description=Accounting webapp"
        - "com.example.department=Finance"
        - "com.example.label-with-empty-value"

.. code-block:: yaml

   build:
     context: .
     labels:
       - "com.example.description=Accounting webapp"
       - "com.example.department=Finance"
       - "com.example.label-with-empty-value"

.. ### cap_add, cap_drop

cap_add, cap_drop
--------------------

.. Add or drop container capabilities.
   See `man 7 capabilities` for a full list.

コンテナケーパビリティーの機能を追加または削除します。
詳細な一覧は ``man 7 capabilities`` を参照してください。

..  cap_add:
      - ALL

..  cap_drop:
      - NET_ADMIN
      - SYS_ADMIN

.. code-block:: yaml

   cap_add:
     - ALL

   cap_drop:
     - NET_ADMIN
     - SYS_ADMIN

.. > **Note**: These options are ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。
   ``docker stack`` コマンドは、ビルド済のイメージのみを受け付けるためです。

.. ### command

.. _compose-file-command:

command
----------

.. Override the default command.

デフォルトコマンドを上書きします。

..  command: bundle exec thin -p 3000

.. code-block:: yaml

   command: bundle exec thin -p 3000

.. The command can also be a list, in a manner similar to
   [dockerfile](/engine/reference/builder.md#cmd):

コマンドは :ref:`Dockerfile <cmd>` の場合と同じように、リスト形式により指定することもできます。

..  command: ["bundle", "exec", "thin", "-p", "3000"]

.. code-block:: yaml

   command: ["bundle", "exec", "thin", "-p", "3000"]

.. ### configs

.. _compose-file-configs:

configs
----------

.. Grant access to configs on a per-service basis using the per-service `configs`
   configuration. Two different syntax variants are supported.

サービスごとの ``configs`` を利用して、サービス単位での configs 設定を許可します。
2 つの異なる文法がサポートされています。

.. > **Note**: The config must already exist or be
   > [defined in the top-level `configs` configuration](#configs-configuration-reference)
   > of this stack file, or stack deployment will fail.

.. note::

   config は既に定義済であるか、あるいは :ref:`最上位の configs 設定が定義済 <configs-configuration-reference>` である必要があります。
   そうでない場合、このファイルによるデプロイが失敗します。

.. #### Short syntax

.. _compose-file-configs-short-syntax:

短い文法
^^^^^^^^^
.. The short syntax variant only specifies the config name. This grants the
   container access to the config and mounts it at `/<config_name>`
   within the container. The source name and destination mountpoint are both set
   to the config name.

短い文法の場合には config 名を指定するのみです。
これを行うと、コンテナー内において ``/<config_name>`` というディレクトリをマウントしてアクセス可能とします。
マウント元の名前とマウント名はともに config 名となります。

.. The following example uses the short syntax to grant the `redis` service
   access to the `my_config` and `my_other_config` configs. The value of
   `my_config` is set to the contents of the file `./my_config.txt`, and
   `my_other_config` is defined as an external resource, which means that it has
   already been defined in Docker, either by running the `docker config create`
   command or by another stack deployment. If the external config does not exist,
   the stack deployment fails with a `config not found` error.

以下の例では短い文法を用います。
``redis`` サービスが 2 つの configs ファイル ``my_config`` と ``my_other_config`` にアクセスできるようにするものです。
``my_config`` へは、ファイル ``./my_config.txt`` の内容を設定しています。
そして ``my_other_config`` は外部リソースとして定義します。
これはつまり Docker によりすでに定義されていることを意味し、``docker config create`` の実行により、あるいは別のスタックデプロイメントにより指定されます。
外部 config が存在していない場合は、スタックデプロイメントは失敗し ``config not found`` というエラーになります。

.. > **Note**: `config` definitions are only supported in version 3.3 and higher
   >  of the compose file format.

.. note::

   ``config`` 定義は、Compose ファイルフォーマットのバージョン 3.3 またはそれ以上においてサポートされています。

.. ```none
   version: "3.3"
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
   ```

.. code-block:: yaml

   version: "3.3"
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

.. #### Long syntax

.. _compose-file-configs-long-syntax:

長い文法
^^^^^^^^^

.. The long syntax provides more granularity in how the config is created within
   the service's task containers.

長い文法は、サービスのタスクコンテナ内にて生成する config をより細かく設定します。

.. - `source`: The name of the config as it exists in Docker.
   - `target`: The path and name of the file that will be mounted in the service's
     task containers. Defaults to `/<source>` if not specified.
   - `uid` and `gid`: The numeric UID or GID which will own the mounted config file
     within in the service's task containers. Both default to `0` on Linux if not
     specified. Not supported on Windows.
   - `mode`: The permissions for the file that will be mounted within the service's
     task containers, in octal notation. For instance, `0444`
     represents world-readable. The default is `0444`. Configs cannot be writable
     because they are mounted in a temporary filesystem, so if you set the writable
     bit, it is ignored. The executable bit can be set. If you aren't familiar with
     UNIX file permission modes, you may find this
     [permissions calculator](http://permissions-calculator.org/){: target="_blank" class="_" }
     useful.

* ``source``: Docker 内に設定する config 名。
* ``target``: サービスのタスクコンテナ内にマウントされるファイルパス名。
  指定されない場合のデフォルトは ``/<source>``。
* ``uid`` と ``gid``: サービスのタスクコンテナ内にマウントされる config ファイルの所有者を表わす UID 値および GID 値。
  指定されない場合のデフォルトは、Linux においては ``0``。
  Windows においてはサポートされません。
* ``mode``: サービスのタスクコンテナ内にマウントされる config ファイルのパーミッション。
  8 進数表記。
  たとえば ``0444`` であればすべて読み込み可。
  デフォルトは ``0444``。
  Configs は、テンポラリなファイルシステム上にマウントされるため、書き込み可能にはできません。
  したがって書き込みビットを設定しても無視されます。
  実行ビットは設定できます。
  UNIX のファイルパーミッションモードに詳しくない方は、`パーミッション計算機 <http://permissions-calculator.org/>`_ を参照してください。

.. The following example sets the name of `my_config` to `redis_config` within the
   container, sets the mode to `0440` (group-readable) and sets the user and group
   to `103`. The `redis` service does not have access to the `my_other_config`
   config.

以下の例では ``my_config`` という名前の config を、コンテナ内では ``redis_config`` として設定します。
そしてモードを ``0440`` （グループが読み込み可能）とし、ユーザとグループは ``103`` とします。
``redis`` サービスは ``my_other_config`` へはアクセスしません。

.. ```none
   version: "3.3"
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
   ```

.. code-block:: yaml

   version: "3.3"
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

.. You can grant a service access to multiple configs and you can mix long and
   short syntax. Defining a config does not imply granting a service access to it.

1 つのサービスを複数の configs にアクセスする設定とすることもできます。
また短い文法、長い文法を混在することも可能です。
config を定義しただけでは、サービスの config へのアクセスを許可するものにはなりません。

.. ### cgroup_parent

.. _compose-file-cgroup_parent:

cgroup_parent
--------------------

.. Specify an optional parent cgroup for the container.

コンテナに対して、オプションで指定する親の cgroup を指定します。

..  cgroup_parent: m-executor-abcd

.. code-block:: yaml

   cgroup_parent: m-executor-abcd

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### container_name

.. _compose-file-container-name:

container_name
--------------------

.. Specify a custom container name, rather than a generated default name.

デフォルトのコンテナ名ではない、独自のコンテナ名を設定します。

..  container_name: my-web-container

.. code-block:: yaml

   container_name: my-web-container

.. Because Docker container names must be unique, you cannot scale a service beyond
   1 container if you have specified a custom name. Attempting to do so results in
   an error.

Docker コンテナ名はユニークである必要があります。
そこで独自のコンテナ名を設定したときは、サービスをスケールアップして複数コンテナとすることはできません。
これを行うとエラーが発生します。

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### credential_spec

.. _compose-file-credential-spec:

credential_spec
--------------------

.. > **Note:** this option was added in v3.3

.. note::

   このオプションは v3.3 で追加されました。

.. Configure the credential spec for managed service account. This option is only
   used for services using Windows containers. The `credential_spec` must be in the
   format `file://<filename>` or `registry://<value-name>`.

管理サービスアカウントに対する資格情報スペック（``credential_spec``）を設定します。
このオプションは Windows コンテナを利用するサービスにおいてのみ用いられます。
``credential_spec`` の書式は ``file://<filename>`` または ``registry://<value-name>`` でなければなりません。

.. When using `file:`, the referenced file must be present in the `CredentialSpecs`
   subdirectory in the docker data directory, which defaults to `C:\ProgramData\Docker\`
   on Windows. The following example loads the credential spec from a file named
   `C:\ProgramData\Docker\CredentialSpecs\my-credential-spec.json`:

``file:`` を用いるとき、参照するファイルは実際に存在するファイルでなければならず、Docker データディレクトリ配下のサブディレクトリ ``CredentialSpecs`` になければなりません。
Windows における Docker データディレクトリのデフォルトは ``C:\ProgramData\Docker\`` です。
以下の例は ``C:\ProgramData\Docker\CredentialSpecs\my-credential-spec.json`` というファイルから資格情報スペックを読み込みます。

..  credential_spec:
      file: my-credential-spec.json

.. code-block:: yaml

   credential_spec:
     file: my-credential-spec.json

.. When using `registry:`, the credential spec is read from the Windows registry on
   the daemon's host. A registry value with the given name must be located in:

``registry:`` を用いるとき資格情報スペックは、デーモンホスト内の Windows レジストリから読み込まれます。
指定された名称のレジストリ値は、以下に定義されている必要があります。

..  HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Containers\CredentialSpecs

::

   HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Containers\CredentialSpecs

.. The following example load the credential spec from a value named `my-credential-spec`
   in the registry:

以下の例は、レジストリ内の ``my-credential-spec`` という値から資格情報スペックを読み込みます。

..  credential_spec:
      registry: my-credential-spec

.. code-block:: yaml

   credential_spec:
     registry: my-credential-spec

.. ### deploy

.. _compose-file-deploy:

deploy
-------

.. > **[Version 3](compose-versioning.md#version-3) only.**

.. note::

   :ref:`バージョン 3 <compose-versioning-version-3>` のみ。

.. Specify configuration related to the deployment and running of services. This
   only takes effect when deploying to a [swarm](/engine/swarm/index.md) with
   [docker stack deploy](/engine/reference/commandline/stack_deploy.md), and is
   ignored by `docker-compose up` and `docker-compose run`.

サービスのデプロイや起動に関する設定を行います。
この設定が有効になるのは :doc:`スウォーム </engine/swarm/index>` に対して :doc:`docker stack deploy </engine/reference/commandline/stack_deploy>` コマンドを実行したときであって、 ``docker-compose up`` や ``docker-compose run`` を実行したときには無視されます。

..  version: '3'
    services:
      redis:
        image: redis:alpine
        deploy:
          replicas: 6
          update_config:
            parallelism: 2
            delay: 10s
          restart_policy:
            condition: on-failure

.. code-block:: yaml

   version: '3'
   services:
     redis:
       image: redis:alpine
       deploy:
         replicas: 6
         update_config:
           parallelism: 2
           delay: 10s
         restart_policy:
           condition: on-failure

.. Several sub-options are available:

利用可能なサブオプションがあります。

.. #### endpoint_mode

.. _compose-file-endpoint-mode:

endpoint_mode
^^^^^^^^^^^^^^

.. Specify a service discovery method for external clients connecting to a swarm.

スウォームに接続する外部クライアントのサービスディスカバリ方法を指定します。

.. > **[Version 3.3](compose-versioning.md#version-3) only.**

.. note::

   :ref:`バージョン 3.3 <compose-versioning-version-3>` のみ。

.. * `endpoint_mode: vip` - Docker assigns the service a virtual IP (VIP),
   which acts as the “front end” for clients to reach the service on a
   network. Docker routes requests between the client and available worker
   nodes for the service, without client knowledge of how many nodes
   are participating in the service or their IP addresses or ports.
   (This is the default.)

* ``endpoint_mode: vip`` - Docker はサービスに対して仮想 IP（virtual IP; VIP）を割り当てます。
  これはネットワーク上のサービスに対して、クライアントがアクセスできるようにするためのフロントエンドとして機能します。
  Docker がサービスに参加する稼動中のワーカーノードやクライアントの間でリクエストを受け渡ししている際に、クライアントはそのサービス上にどれだけの数のノードが参加しているのか、その IP アドレスやポートが何なのか、一切分かりません。
  （この設定がデフォルトです。）

.. * `endpoint_mode: dnsrr` -  DNS round-robin (DNSRR) service discovery does
   not use a single virtual IP. Docker sets up DNS entries for the service
   such that a DNS query for the service name returns a list of IP addresses,
   and the client connects directly to one of these. DNS round-robin is useful
   in cases where you want to use your own load balancer, or for Hybrid
   Windows and Linux applications.

* ``endpoint_mode: dnsrr`` -  DNS ラウンドロビン（DNS round-robin; DNSRR）によるサービスディスカバリでは、仮想 IP は単一ではありません。
  Docker はサービスに対する DNS エントリーを設定し、サービス名に対する DNS クエリーが IP アドレスのリストを返すようにします。
  クライアントはそのうちの 1 つに対して直接アクセスします。
  DNS ラウンドロビンが有効なのは、独自のロードバランサーを利用したい場合や、Windows と Linux が統合されたアプリケーションに対して利用する場合です。

.. ```none
   version: "3.3"

   services:
     wordpress:
       image: wordpress
       ports:
         - 8080:80
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
   ```

.. code-block:: yaml

   version: "3.3"

   services:
     wordpress:
       image: wordpress
       ports:
         - 8080:80
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

.. The options for `endpoint_mode` also work as flags on the swarm mode CLI command
   [docker service create](/engine/reference/commandline/service_create.md). For a
   quick list of all swarm related `docker` commands, see [Swarm mode CLI
   commands](/engine/swarm.md#swarm-mode-key-concepts-and-tutorial).

``endpoint_mode`` に対する設定は、スウォームモードの CLI コマンド :doc:`docker service create </engine/reference/commandline/service_create>` におけるフラグとしても動作します。
スウォームに関連する ``docker`` コマンドの一覧は :ref:`スウォームモード CLI コマンド <swarm-mode-key-concepts-and-tutorial>` を参照してください。

.. To learn more about service discovery and networking in swarm mode, see
   [Configure service
   discovery](/engine/swarm/networking.md#configure-service-discovery) in the swarm
   mode topics.

スウォームモードにおけるサービスディスカバリやネットワークに関しての詳細は、スウォームモードのトピックにある :ref:`サービスディスカバリの設定 <networking-configure-service-discovery>` を参照してください。


.. #### labels

.. _compose-file-deploy-labels:

labels
^^^^^^^

.. Specify labels for the service. These labels will *only* be set on the service,
   and *not* on any containers for the service.

サービスに対してのラベルを設定します。
このラベルはサービスに対してのみ設定するものであって、サービスのコンテナに設定するものでは **ありません** 。

..  version: "3"
    services:
      web:
        image: web
        deploy:
          labels:
            com.example.description: "This label will appear on the web service"

.. code-block:: yaml

   version: "3"
   services:
     web:
       image: web
       deploy:
         labels:
           com.example.description: "このラベルは web サービス上に現れます。"

.. To set labels on containers instead, use the `labels` key outside of `deploy`:

コンテナにラベルを設定するのであれば、``deploy`` の外に ``labels`` キーを記述してください。

..  version: "3"
    services:
      web:
        image: web
        labels:
          com.example.description: "This label will appear on all containers for the web service"

.. code-block:: yaml


   version: "3"
   services:
     web:
       image: web
       labels:
         com.example.description: "このラベルは web サービスに対するコンテナすべてに現れます。"

.. #### mode

.. _compose-file-deploy-mode:

mode
^^^^^

.. Either `global` (exactly one container per swarm node) or `replicated` (a
   specified number of containers). The default is `replicated`. (To learn more,
   see [Replicated and global
   services](/engine/swarm/how-swarm-mode-works/services/#replicated-and-global-services)
   in the [swarm](/engine/swarm/) topics.)

``global`` （スウォームノードごとに 1 つのコンテナとする）か、``replicated`` （指定されたコンテナ数とするか）のいずれかを設定します。
デフォルトは ``replicated`` です。
（詳しくは :doc:`スウォーム </engine/swarm/>` のトピックにある :ref:`サービスの Replicated と global <replicated-and-global-services>` を参照してください。）

..  version: '3'
    services:
      worker:
        image: dockersamples/examplevotingapp_worker
        deploy:
          mode: global

.. code-block:: yaml

   version: '3'
   services:
     worker:
       image: dockersamples/examplevotingapp_worker
       deploy:
         mode: global

.. #### placement

.. _compose-file-deploy-placement:

placement
^^^^^^^^^^

.. Specify placement constraints. For a full description of the syntax and
   available types of constraints, see the
   [docker service create](/engine/reference/commandline/service_create.md#specify-service-constraints-constraint)
   documentation.

制約（constraints）とプリファレンス（preferences）の記述場所を指定します。
docker service create のドキュメントには、:ref:`制約 <specify-service-constraints-constraint>` と :ref:`プリファレンス <specify-service-placement-preferences-placement-pref>` に関する文法と設定可能な型について、詳細に説明しているので参照してください。

..  version: '3'
    services:
      db:
        image: postgres
        deploy:
          placement:
            constraints:
              - node.role == manager
              - engine.labels.operatingsystem == ubuntu 14.04

.. code-block:: yaml

   version: '3'
   services:
     db:
       image: postgres
       deploy:
         placement:
           constraints:
             - node.role == manager
             - engine.labels.operatingsystem == ubuntu 14.04

.. #### replicas

.. _compose-file-deploy-replicas:

replicas
^^^^^^^^^

.. If the service is `replicated` (which is the default), specify the number of
   containers that should be running at any given time.

サービスを ``replicated`` （デフォルト）に設定しているときに、起動させるコンテナ数を指定します。

..  version: '3'
    services:
      worker:
        image: dockersamples/examplevotingapp_worker
        networks:
          - frontend
          - backend
        deploy:
          mode: replicated
          replicas: 6

.. code-block:: yaml

   version: '3'
   services:
     worker:
       image: dockersamples/examplevotingapp_worker
       networks:
         - frontend
         - backend
       deploy:
         mode: replicated
         replicas: 6

.. #### resources

.. _compose-file-deploy-resources:

resources
^^^^^^^^^^

.. Configures resource constraints.

リソースの制約を設定します。

.. > **Note**: This replaces the [older resource constraint options](compose-file-v2.md#cpu-and-other-resources) for non swarm mode in
   Compose files prior to version 3 (`cpu_shares`, `cpu_quota`, `cpuset`,
   `mem_limit`, `memswap_limit`, `mem_swappiness`), as described in [Upgrading
   version 2.x to 3.x](/compose/compose-file/compose-versioning.md#upgrading).

.. note::

   Compose ファイルバージョン 3 より前には、:ref:`リソースに対する古い制約オプション <compose-file-v2-cpu-and-other-resources>` があって、非スウォームモードで用いられていました。
   （``cpu_shares``, ``cpu_quota``, ``cpuset``, ``mem_limit``, ``memswap_limit``, ``mem_swappiness``）
   ここに示すオプションはそれに替わるものです。
   このことは :ref:`バージョン 2.x から 3.x へのアップグレード <compose-versioning-upgrading>` にて説明しています。

.. Each of these is a single value, analogous to its [docker service
   create](/engine/reference/commandline/service_create.md) counterpart.

個々の設定には単一の値を指定します。
これは :doc:`docker service create </engine/reference/commandline/service_create>` のオプションに対応づきます。

.. In this general example, the `redis` service is constrained to use no more than
   50M of memory and `0.001` (0.1%) of available processing time (CPU), and has
   `20M` of memory and `0.0001` CPU time reserved (as always available to it).

以下の一般的な例は ``redis`` サービスに制約をつけるものです。
メモリ利用は 50M まで、利用可能なプロセス時間（CPU）は ``0.50`` （シングルコアの 50%）まで。
最低メモリは ``20M`` 確保し（常時利用可能な） CPU 時間は ``0.25`` とします。

.. ```none
   version: '3'
   services:
     redis:
       image: redis:alpine
       deploy:
         resources:
           limits:
             cpus: '0.001'
             memory: 50M
           reservations:
             cpus: '0.0001'
             memory: 20M
   ```

.. code-block:: yaml

   version: '3'
   services:
     redis:
       image: redis:alpine
       deploy:
         resources:
           limits:
             cpus: '0.001'
             memory: 50M
           reservations:
             cpus: '0.0001'
             memory: 20M

.. The topics below describe available options to set resource constraints on
   services or containers in a swarm.

以下では、スウォーム内のサービスやコンテナに設定できるリソース制約を説明します。

.. > Looking for options to set resources on non swarm mode containers?
   >
   > The options described here are specific to the
   `deploy` key and swarm mode. If you want to set resource constraints
   on non swarm deployments, use
   [Compose file format version 2 CPU, memory, and other resource
   options](compose-file-v2.md#cpu-and-other-resources).
   If you have further questions, please refer to the discussion on the GitHub
   issue [docker/compose/4513](https://github.com/docker/compose/issues/4513){: target="_blank" class="_"}.
   {: .important}

.. important::
   スウォームモードではないコンテナーでのリソース設定を探していますか？
     ここに説明している設定は、スウォームモードで利用する ``deploy`` キーにおけるオプションです。
     スウォームモードではないデプロイメントにおけるリソース制約を設定したい場合は、:ref:`Compose ファイルバージョン 2 における CPU、メモリなどに関するリソースオプション <compose-file-v2-cpu-and-other-resources>` を参照してください。
     それでもよくわからない場合は、GitHub 上にあげられている議論 `docker/compose/4513 <https://github.com/docker/compose/issues/4513>`_ を参照してください。

.. ##### Out Of Memory Exceptions (OOME)

.. _out-of-memory-exceptions-oome:

Out Of Memory Exceptions (OOME)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.. If your services or containers attempt to use more memory than the system has
   available, you may experience an Out Of Memory Exception (OOME) and a container,
   or the Docker daemon, might be killed by the kernel OOM killer. To prevent this
   from happening, ensure that your application runs on hosts with adequate memory
   and see [Understand the risks of running out of
   memory](/engine/admin/resource_constraints.md#understand-the-risks-of-running-out-of-memory).

サービスやコンテナが、システムにおいて利用可能なメモリ容量以上を利用しようとして、Out Of Memory Exception (OOME) が発生するということがあります。
コンテナあるいは Docker デーモンは、このときカーネルの OOM killer によって強制終了させられます。
これが発生しないようにするためには、ホスト上で動作させるアプリケーションのメモリ利用を適切に行うことが必要です。
:ref:`メモリ不足のリスクへの理解 <understand-the-risks-of-running-out-of-memory>` を参照してください。

.. #### restart_policy

.. _compose-file-deploy-restart-policy:

restart_policy
^^^^^^^^^^^^^^^

.. Configures if and how to restart containers when they exit. Replaces
   [`restart`](compose-file-v2.md#orig-resources).

コンテナが終了した後に、いつどのようにして再起動するかを設定します。
:ref:`restart <compose-file-v2-orig-resources>` に置き換わるものです。

.. - `condition`: One of `none`, `on-failure` or `any` (default: `any`).
   - `delay`: How long to wait between restart attempts, specified as a
     [duration](#specifying-durations) (default: 0).
   - `max_attempts`: How many times to attempt to restart a container before giving
     up (default: never give up).
   - `window`: How long to wait before deciding if a restart has succeeded,
     specified as a [duration](#specifying-durations) (default:
     decide immediately).

* ``condition``: ``none``, ``on-failure``, ``any`` のいずれかを指定します。（デフォルト: ``any``）
* ``delay``: 再起動までどれだけの間隔をあけるかを :ref:`duration <specifying-durations>` として指定します。
  （デフォルト: 0）
* ``max_attempts``: 再起動に失敗しても何回までリトライするかを指定します。
  （デフォルト: 無制限）
  設定した ``window`` 時間内に再起動が成功しなかったとしても、そのときの再起動リトライは、``max_attempts`` の値としてカウントされません。
  たとえば ``max_attempts`` が ``2`` として設定されていて、1 回めの再起動が失敗したとします。
  この場合、2 回以上の再起動が発生する可能性があります。
* ``window``: 再起動が成功したかどうかを決定するためにどれだけ待つかを :ref:`duration <specifying-durations>` として指定します。
  （デフォルト: 即時）

.. ```none
   version: "3"
   services:
     redis:
       image: redis:alpine
       deploy:
         restart_policy:
           condition: on-failure
           delay: 5s
           max_attempts: 3
           window: 120s
   ```

.. code-block:: yaml

   version: "3"
   services:
     redis:
       image: redis:alpine
       deploy:
         restart_policy:
           condition: on-failure
           delay: 5s
           max_attempts: 3
           window: 120s

.. #### update_config

.. _compose-file-deploy-update-config:

update_config
^^^^^^^^^^^^^^

.. Configures how the service should be updated. Useful for configuring rolling
   updates.

どのようにサービスを更新するかを設定します。
Rolling update を設定する際に有効です。

.. - `parallelism`: The number of containers to update at a time.
   - `delay`: The time to wait between updating a group of containers.
   - `failure_action`: What to do if an update fails. One of `continue`, `rollback`, or `pause`
     (default: `pause`).
   - `monitor`: Duration after each task update to monitor for failure `(ns|us|ms|s|m|h)` (default 0s).
   - `max_failure_ratio`: Failure rate to tolerate during an update.

* ``parallelism``： 一度に更新を行うコンテナ数を設定します。
* ``delay``： 一連のコンテナを更新する間隔を設定します。
* ``failure_action``： 更新に失敗したときの動作を設定します。
  ``continue``, ``rollback``, ``pause`` のいずれかです。
  （デフォルト： ``pause`` ）
* ``monitor``: 各タスク更新後に失敗を監視する時間 ``(ns|us|ms|s|m|h)`` を設定します。
  （デフォルト： 0s）
* ``max_failure_ratio``: 更新時の失敗許容率を設定します。

.. ```none
   version: '3'
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
   ```

.. code-block:: yaml

   version: '3'
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

.. #### Not supported for `docker stack deploy`

.. _not-supported-for-docker-stack-deploy:

``docker stack deploy`` でサポートされないオプション
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. The following sub-options (supported for `docker compose up` and `docker compose run`) are _not supported_ for `docker stack deploy` or the `deploy` key.

以下に示すサブオプション（``docker-compose up`` と ``docker-compose run`` においてサポートされるオプション）は、``docker stack deploy`` または ``deploy`` キーにおいては **サポートされません** 。

.. - [build](#build)
   - [cgroup_parent](#cgroup_parent)
   - [container_name](#container_name)
   - [devices](#devices)
   - [dns](#dns)
   - [dns_search](#dns_search)
   - [tmpfs](#tmpfs)
   - [external_links](#external_links)
   - [links](#links)
   - [network_mode](#network_mode)
   - [security_opt](#security_opt)
   - [stop_signal](#stop_signal)
   - [sysctls](#sysctls)
   - [userns_mode](#userns_mode)

* :ref:`build <compose-file-build>`
* :ref:`cgroup_parent <compose-file-cgroup_parent>`
* :ref:`container_name <compose-file-container-name>`
* :ref:`devices <compose-file-devices>`
* :ref:`dns <compose-file-dns>`
* :ref:`dns_search <compose-file-dns-search>`
* :ref:`tmpfs <copmose-file-tmpfs>`
* :ref:`external_links <compose-file-external_links>`
* :ref:`links <compose-file-links>`
* :ref:`network_mode <compose-file-network_mode>`
* :ref:`security_opt <compose-file-security_opt>`
* :ref:`stop_signal <compose-file-stop_signal>`
* :ref:`sysctls <compose-file-sysctls>`
* :ref:`userns_mode <compose-file-userns_mode>`

.. >**Tip:** See also, the section on [how to configure volumes
   for services, swarms, and docker-stack.yml
   files](#volumes-for-services-swarms-and-stack-files).  Volumes _are_ supported
   but in order to work with swarms and services, they must be configured properly,
   as named volumes or associated with services that are constrained to nodes with
   access to the requisite volumes.

.. tip::

   :ref:`サービス、スウォーム、docker-stack.yml ファイルにおけるボリューム設定方法 <volumes-for-services-swarms-and-stack-files>` にある説明を確認してください。
   ボリュームはサポートされますが、これはスウォームとサービスに対してです。
   ボリュームは名前つきとして設定されるか、あるいは必要なボリュームにアクセスするノードのみから構成されるサービスに関連づけられている必要があります。

.. ### devices

.. _compose-file-devices:

devices
----------

.. List of device mappings.  Uses the same format as the `--device` docker
   client create option.

デバイスのマッピングをリスト形式で設定します。
Docker クライアントの create オプション ``--device`` と同じ書式とします。

..  devices:
      - "/dev/ttyUSB0:/dev/ttyUSB0"

.. code-block:: yaml

   devices:
     - "/dev/ttyUSB0:/dev/ttyUSB0"


.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### depends_on

.. _compose-file-depends_on:

depends_on
----------

.. Express dependency between services, which has two effects:

サービス間の依存関係を表わします。
これにより以下の 2 つの効果が発生します。

.. - `docker-compose up` will start services in dependency order. In the following
     example, `db` and `redis` will be started before `web`.

* ``docker-compose up`` は依存関係の順にサービスを起動します。
  以下の例において ``db`` と ``redis`` は ``web`` の後に起動します。

.. - `docker-compose up SERVICE` will automatically include `SERVICE`'s
     dependencies. In the following example, `docker-compose up web` will also
     create and start `db` and `redis`.

* ``docker-compose up SERVICE`` を実行すると ``SERVICE`` における依存関係をもとに動作します。
  以下の例において ``docker-compose up web`` を実行すると ``db`` と ``redis`` を生成して起動します。

.. Simple example:

以下がその簡単な例です。

..  version: '3'
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

.. code-block:: yaml

   version: '3'
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

.. > There are several things to be aware of when using `depends_on`:
   >
   > - `depends_on` will not wait for `db` and `redis` to be "ready" before
   >   starting `web` - only until they have been started. If you need to wait
   >   for a service to be ready, see [Controlling startup order](/compose/startup-order.md)
   >   for more on this problem and strategies for solving it.
   >
   > - Version 3 no longer supports the `condition` form of `depends_on`.
   >
   > - The `depends_on` option is ignored when
   >   [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   >   with a version 3 Compose file.

.. note::

   ``depends_on`` の利用にあたっては、気をつけておくべきことがあります。

   - ``depends_on`` では ``db`` や ``redis`` が「準備」状態になるのを待たずに、つまりそれらを開始したらすぐに ``web`` を起動します。
     準備状態になるのを待ってから次のサービスを起動することが必要な場合は、:doc:`Compose における起動順の制御 </compose/startup-order>` にて示す内容と解決方法を確認してください。

   - バージョン 3 では ``depends_on`` の ``condition`` 形式はサポートされなくなりました。

   - Compose ファイルバージョン 3 において ``depends_on`` オプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### dns

.. _compose-file-dns:

dns
----

.. Custom DNS servers. Can be a single value or a list.

DNS サーバーを設定します。
設定は 1 つだけとするか、リストにすることができます。

..  dns: 8.8.8.8
    dns:
      - 8.8.8.8
      - 9.9.9.9

.. code-block:: yaml

   dns: 8.8.8.8
   dns:
     - 8.8.8.8
     - 9.9.9.9

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### dns_search

.. _compose-file-dns-search:

dns_search
----------

.. Custom DNS search domains. Can be a single value or a list.

DNS 検索ドメインを設定します。
設定は 1 つだけとするか、リストにすることができます。

..  dns_search: example.com
    dns_search:
      - dc1.example.com
      - dc2.example.com

.. code-block:: yaml

   dns_search: example.com
   dns_search:
     - dc1.example.com
     - dc2.example.com

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### tmpfs

.. _copmose-file-tmpfs:

tmpfs
----------

.. > [Version 2 file format](compose-versioning.md#version-2) and up.

.. note::

   :ref:`ファイルフォーマットバージョン 2 <compose-versioning-version-2>` またはそれ以上。

.. Mount a temporary file system inside the container. Can be a single value or a list.

コンテナ内においてテンポラリファイルシステムをマウントします。
設定は 1 つだけとするか、リストにすることができます。

..  tmpfs: /run
    tmpfs:
      - /run
      - /tmp

.. code-block:: yaml

   tmpfs: /run
   tmpfs:
     - /run
     - /tmp

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

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

.. > **Note**: Setting `entrypoint` will both override any default entrypoint set
   > on the service's image with the `ENTRYPOINT` Dockerfile instruction, *and*
   > clear out any default command on the image - meaning that if there's a `CMD`
   > instruction in the Dockerfile, it will be ignored.

.. note::

   ``entrypoint`` を設定すると、サービスイメージ内に Dockerfile 命令の ``ENTRYPOINT`` によって設定されているデフォルトのエントリーポイントは上書きされ、**さらに** イメージ内のあらゆるデフォルトコマンドもクリアされます。
   これはつまり、Dockerfile に ``CMD`` 命令があったとしたら無視されるということです。

.. ### env_file

.. _compose-file-env_file:

env_file
----------

.. Add environment variables from a file. Can be a single value or a list.

ファイルを用いて環境変数を追加します。
設定は 1 つだけとするか、リストにすることができます。

.. If you have specified a Compose file with `docker-compose -f FILE`, paths in
   `env_file` are relative to the directory that file is in.

Compose ファイルを ``docker-compose -f FILE`` という起動により指定している場合、``env_file`` におけるパスは、Compose ファイルがあるディレクトリからの相対パスとします。

.. Environment variables declared in the [environment](#environment) section
   _override_ these values &ndash; this holds true even if those values are
   empty or undefined.

環境変数が :ref:`environment <compose-file-environment>` の項に宣言されていれば、ここでの設定を **オーバーライド** します。
たとえ設定値が空や未定義であっても、これは変わりません。

..  env_file: .env

    env_file:
      - ./common.env
      - ./apps/web.env
      - /opt/secrets.env

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

.. Compose expects each line in an env file to be in `VAR=VAL` format. Lines
   beginning with `#` (i.e. comments) are ignored, as are blank lines.

env ファイルの各行は ``VAR=VAL`` の書式とします。
行先頭に `#` がある行は（コメントとして扱われ）無視されます。
空行も無視されます。

..  # Set Rails/Rack environment
    RACK_ENV=development

.. code-block:: yaml

   # Rails/Rack 環境変数を設定
   RACK_ENV=development

.. > **Note**: If your service specifies a [build](#build) option, variables
   > defined in environment files will _not_ be automatically visible during the
   > build. Use the [args](#args) sub-option of `build` to define build-time
   > environment variables.

.. note::

   サービスに :ref:`build <compose-file-build>` オプションを指定している場合、env ファイル内に定義された変数は、ビルド時にこのままでは自動的に参照されません。
   その場合は ``build`` のサブオプション :ref:`args <compose-file-args>` を利用して、ビルド時の環境変数を設定してください。

.. The value of `VAL` is used as is and not modified at all. For example if the
   value is surrounded by quotes (as is often the case of shell variables), the
   quotes will be included in the value passed to Compose.

``VAL`` の値は記述されたとおりに用いられ、一切修正はされません。
たとえば値がクォートにより囲まれている（よくシェル変数に対して行う）場合、クォートもそのまま値として Compose に受け渡されます。

.. Keep in mind that _the order of files in the list is significant in determining
   the value assigned to a variable that shows up more than once_. The files in the
   list are processed from the top down. For the same variable specified in file
   `a.env` and assigned a different value in file `b.env`, if `b.env` is
   listed below (after), then the value from `b.env` stands. For example, given the
   following declaration in `docker_compose.yml`:

ファイルを複数用いる場合の順番には気をつけてください。
特に何度も出現する変数に対して、値がどのように決定されるかです。
ファイルが複数指定された場合、その処理は上から順に行われます。
たとえば ``a.env`` ファイルに変数が指定されていて、``b.env`` ファイルには同じ変数が異なる値で定義されていたとします。
ここで ``b.env`` ファイルが下に（後に）指定されているとします。
このとき変数の値は ``b.env`` のものが採用されます。
さらに例として ``docker-compose.yml`` に以下のような宣言があったとします。

.. ```none
   services:
     some-service:
       env_file:
         - a.env
         - b.env
   ```

.. code-block:: yaml

   services:
     some-service:
       env_file:
         - a.env
         - b.env

.. And the following files:

ファイルの内容は以下であるとします。

.. ```none
   # a.env
   VAR=1
   ```
   
   and
   
   ```none
   # b.env
   VAR=hello
   ```

.. code-block:: yaml

   # a.env
   VAR=1

.. code-block:: yaml

   # b.env
   VAR=hello

.. $VAR will be `hello`.

この結果 $VAR は ``hello`` になります。

.. ### environment

.. _compose-file-environment:

environment
--------------------

.. Add environment variables. You can use either an array or a dictionary. Any
   boolean values; true, false, yes no, need to be enclosed in quotes to ensure
   they are not converted to True or False by the YML parser.

環境変数を追加します。
配列形式または辞書形式での指定が可能です。
ブール値 ``true``, ``false``, ``yes``, ``no`` を用いる場合は、クォートで囲むことで YML パーサによって True や False に変換されてしまうのを防ぐ必要があります。

.. Environment variables with only a key are resolved to their values on the
   machine Compose is running on, which can be helpful for secret or host-specific values.

環境変数だけが記述されている場合は、Compose が起動しているマシン上にて定義されている値が設定されます。
これは機密情報やホスト固有の値を設定する場合に利用できます。

..  environment:
      RACK_ENV: development
      SHOW: 'true'
      SESSION_SECRET:

    environment:
      - RACK_ENV=development
      - SHOW=true
      - SESSION_SECRET

.. code-block:: yaml

   environment:
     RACK_ENV: development
     SHOW: 'true'
     SESSION_SECRET:

   environment:
     - RACK_ENV=development
     - SHOW=true
     - SESSION_SECRET

.. > **Note**: If your service specifies a [build](#build) option, variables
   > defined in `environment` will _not_ be automatically visible during the
   > build. Use the [args](#args) sub-option of `build` to define build-time
   > environment variables.

.. note::

   サービスに :ref:`build <compose-file-build>` オプションを指定している場合、env ファイル内に定義された変数は、ビルド時にこのままでは自動的に参照されません。
   その場合は ``build`` のサブオプション :ref:`args <compose-file-args>` を利用して、ビルド時の環境変数を設定してください。

.. _compose-file-expose:

expose
----------

.. Expose ports without publishing them to the host machine - they’ll only be accessible to linked services. Only the internal port can be specified.

ホストマシン上で公開するポートを指定せずに、コンテナの公開（露出）用のポート番号を指定します。これらはリンクされたサービス間でのみアクセス可能になります。内部で使うポートのみ指定できます。

.. code-block:: yaml

   expose:
    - "3000"
    - "8000"

.. ### external_links

.. _compose-file-external_links:

external_links
--------------------

.. Link to containers started outside this `docker-compose.yml` or even outside of
   Compose, especially for containers that provide shared or common services.
   `external_links` follow semantics similar to the legacy option `links` when
   specifying both the container name and the link alias (`CONTAINER:ALIAS`).

今の ``docker-compose.yml`` からではない別のところから起動されたコンテナをリンクします。
あるいは Compose の外から、特に共有サービスや汎用サービスとして提供されるコンテナをリンクします。
``external_links`` の文法は、かつてのオプション ``links`` と同様です。
つまりコンテナ名とリンクのエイリアス名（``CONTAINER:ALIAS`` ）を同時に指定します。

..  external_links:
     - redis_1
     - project_db_1:mysql
     - project_db_1:postgresql

.. code-block:: yaml

   external_links:
    - redis_1
    - project_db_1:mysql
    - project_db_1:postgresql

.. > **Notes:**
   >
   > If you're using the [version 2 or above file format](compose-versioning.md#version-2), the externally-created  containers
   must be connected to at least one of the same networks as the service which is
   linking to them. Starting with Version 2, [links](compose-file-v2#links) are a
   legacy option. We recommend using [networks](#networks) instead.
   >
   > This option is ignored when [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   with a (version 3) Compose file.

.. note::

   :ref:`バージョン 2 またはそれ以上のファイルフォーマット <compose-versioning-version-2>` を利用しているときに、外部にて生成されたコンテナをネットワークに接続する場合は、そのコンテナがサービスとしてリンクしているネットワークのうちの 1 つでなければなりません。
   :ref:`Links <compose-file-v2-links>` は古いオプションです。
   これではなく :ref:`networks <compose-file-networks>` を用いるようにしてください。

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### extra_hosts

.. _compose-file-extra_hosts:

extra_hosts
--------------------

.. Add hostname mappings. Use the same values as the docker client `--add-host` parameter.

ホスト名のマッピングを追加します。
Docker Client の ``--add-host`` パラメータと同じ値を設定します。

..  extra_hosts:
     - "somehost:162.242.195.82"
     - "otherhost:50.31.209.229"

.. code-block:: yaml

   extra_hosts:
    - "somehost:162.242.195.82"
    - "otherhost:50.31.209.229"

.. An entry with the ip address and hostname will be created in `/etc/hosts` inside containers for this service, e.g:

ホスト名と IP アドレスによるこの設定内容は、サービスコンテナ内の ``/etc/hosts`` に追加されます。
たとえば以下のとおりです。

..  162.242.195.82  somehost
    50.31.209.229   otherhost

.. code-block:: yaml

   162.242.195.82  somehost
   50.31.209.229   otherhost

.. ### healthcheck

.. _compose-file-healthcheck:

healthcheck
--------------------

.. > [Version 2.1 file format](compose-versioning.md#version-21) and up.

.. note::

   :ref:`ファイルフォーマットバージョン 2.1 <compose-versioning-version-21>` またはそれ以上。

.. Configure a check that's run to determine whether or not containers for this
   service are "healthy". See the docs for the
   [HEALTHCHECK Dockerfile instruction](/engine/reference/builder.md#healthcheck)
   for details on how healthchecks work.

このサービスを起動させているコンテナが「健康」（healthy）かどうかを確認する処理を設定します。
ヘルスチェックがどのように動作するのかの詳細は :ref:`Dockerfile の HEALTHCHECK 命令 <build-healthcheck>` を参照してください。

..  healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 1m30s
      timeout: 10s
      retries: 3

.. code-block:: yaml

   healthcheck:
     test: ["CMD", "curl", "-f", "http://localhost"]
     interval: 1m30s
     timeout: 10s
     retries: 3

.. `interval` and `timeout` are specified as
   [durations](#specifying-durations).

``interval``, ``timeout``, ``start_period`` は :ref:`間隔 <specifying-durations>` を設定します。

.. `test` must be either a string or a list. If it's a list, the first item must be
   either `NONE`, `CMD` or `CMD-SHELL`. If it's a string, it's equivalent to
   specifying `CMD-SHELL` followed by that string.

``test`` は 1 つの文字列かリスト形式である必要があります。
リスト形式の場合、第 1 要素は必ず ``NONE``, ``CMD``, ``CMD-SHELL`` のいずれかとします。
文字列の場合は、``CMD-SHELL`` に続けてその文字列を指定することと同じになります。

..  # Hit the local web app
    test: ["CMD", "curl", "-f", "http://localhost"]

    # As above, but wrapped in /bin/sh. Both forms below are equivalent.
    test: ["CMD-SHELL", "curl -f http://localhost || exit 1"]
    test: curl -f https://localhost || exit 1

.. code-block:: yaml

   # ローカルのウェブアプリにアクセスします。
   test: ["CMD", "curl", "-f", "http://localhost"]

   # 上と同様。ただし /bin/sh でラップします。以下の 2つは同等です。
   test: ["CMD-SHELL", "curl -f http://localhost || exit 1"]
   test: curl -f https://localhost || exit 1

.. To disable any default healthcheck set by the image, you can use `disable:
   true`. This is equivalent to specifying `test: ["NONE"]`.

イメージが設定するデフォルトのヘルスチェックを無効にするには、``disable: true`` を指定します。
これは ``test: ["NONE"]`` と指定することと同じです。

..  healthcheck:
      disable: true

.. code-block:: yaml

   healthcheck:
     disable: true

.. ### image

.. _compose-file-image:

image
----------

.. Specify the image to start the container from. Can either be a repository/tag or
   a partial image ID.

コンテナを起動させるイメージを設定します。
リポジトリ/タグの形式か、あるいは部分イメージ ID により指定します。

..  image: redis
    image: ubuntu:14.04
    image: tutum/influxdb
    image: example-registry.com:4000/postgresql
    image: a4bc65fd

.. code-block:: yaml

   image: redis
   image: ubuntu:14.04
   image: tutum/influxdb
   image: example-registry.com:4000/postgresql
   image: a4bc65fd

.. If the image does not exist, Compose attempts to pull it, unless you have also
   specified [build](#build), in which case it builds it using the specified
   options and tags it with the specified tag.

イメージが存在しなかった場合、:ref:`build <compose-file-build>` を指定していなければ Compose はイメージを取得しようとします。
取得する際には、指定されたオプションを使ってビルドを行い、指定されたタグ名によりタグづけを行います。

.. ### isolation

.. _compose-file-isolation:

isolation
----------

.. Specify a container’s isolation technology. On Linux, the only supported value
   is `default`. On Windows, acceptable values are `default`, `process` and
   `hyperv`. Refer to the
   [Docker Engine docs](/engine/reference/commandline/run.md#specify-isolation-technology-for-container---isolation)
   for details.

コンテナの分離技術（isolation technology）を設定します。
Linux においてサポートされるのは ``default`` のみです。
Windows では ``default``, ``process``, ``hyperv`` の設定が可能です。
詳しくは :ref:`Docker Engine ドキュメント <specify-isolation-technology-for-container---isolation>` を参照してください。

.. ### labels

.. _compose-file-labels:

labels
----------

.. Add metadata to containers using [Docker labels](/engine/userguide/labels-custom-metadata.md). You can use either an array or a dictionary.

:doc:`Docker labels </engine/userguide/labels-custom-metadata>` を使ってコンテナにメタデータを追加します。
配列形式と辞書形式のいずれかにより指定します。

.. It's recommended that you use reverse-DNS notation to prevent your labels from conflicting with those used by other software.

他のソフトウェアが用いるラベルとの競合を避けるため、逆 DNS 記法とすることをお勧めします。

..  labels:
      com.example.description: "Accounting webapp"
      com.example.department: "Finance"
      com.example.label-with-empty-value: ""

.. code-block:: yaml

   labels:
     - "com.example.description=Accounting webapp"
     - "com.example.department=Finance"
     - "com.example.label-with-empty-value"

.. ### links

.. _compose-file-links:

links
----------

.. Link to containers in another service. Either specify both the service name and
   a link alias (`SERVICE:ALIAS`), or just the service name.

他サービスのコンテナをリンクします。
サービス名とリンクのエイリアス名（``SERVICE:ALIAS`` ）を指定するか、直接サービス名を指定します。

..  web:
      links:
       - db
       - db:database
       - redis

.. code-block:: yaml

   web:
     links:
      - db
      - db:database
      - redis

.. Containers for the linked service will be reachable at a hostname identical to
   the alias, or the service name if no alias was specified.

リンクされたサービスのコンテナは、エイリアスと同等のホスト名により到達可能になります。
エイリアスが設定されていない場合はサービス名により到達可能です。

.. Links are not required to enable services to communicate - by default,
   any service can reach any other service at that service’s name. (See also, the
   [Links topic in Networking in Compose](/compose/networking.md#links).)

Links はサービスを通信可能とするために必要になるものではありません。
デフォルトで各サービスは、サービス名を使って他サービスにアクセスすることができます。
（:ref:`Compose ネットワークにおける Links のトピック </compose/networking-links>` も参照してください。）

.. Links also express dependency between services in the same way as
   [depends_on](#depends_on), so they determine the order of service startup.

Links は :ref:`depends_on <compose-file-depends_on>` と同様にサービス間の依存関係を表わします。
したがってサービスの起動順を設定するものになります。

..    Note: If you define both links and networks, services with links between them must share at least one network in common in order to communicate.

.. > **Notes**
   >
   > * If you define both links and [networks](#networks), services with
   > links between them must share at least one network in common in order to
   > communicate.
   >
   > *  This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   * links と :ref:`networks <compose-file-networks>` をともに設定する場合、リンクするサービスは、少なくとも 1 つのネットワークが共有され通信ができるようにする必要があります。

   * Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### logging

.. _compose-file-logging:

logging
----------

.. Logging configuration for the service.

サービスに対するログ記録の設定をします。

..  logging:
      driver: syslog
      options:
        syslog-address: "tcp://192.168.0.42:123"

.. code-block:: yaml

   logging:
     driver: syslog
     options:
       syslog-address: "tcp://192.168.0.42:123"

.. The `driver`  name specifies a logging driver for the service's
   containers, as with the ``--log-driver`` option for docker run
   ([documented here](/engine/admin/logging/overview.md)).

``driver`` 名にはサービスコンテナにおけるロギングドライバを指定します。
これは docker run コマンドに対する ``--log-driver`` オプションと同じです。
（:doc:`ドキュメントはこちら </engine/admin/logging/overview>` ）

.. The default value is json-file.

デフォルトは json-file です。

..  driver: "json-file"
    driver: "syslog"
    driver: "none"

.. code-block:: yaml

   driver: "json-file"
   driver: "syslog"
   driver: "none"

.. > **Note**: Only the `json-file` and `journald` drivers make the logs
   available directly from `docker-compose up` and `docker-compose logs`.
   Using any other driver will not print any logs.

.. note::

   ドライバのうち ``json-file`` と ``journald`` だけが、``docker-compose up`` と ``docker-compose logs`` によって直接ログ参照ができます。
   その他のドライバではログ出力は行われません。

.. Specify logging options for the logging driver with the ``options`` key, as with the ``--log-opt`` option for `docker run`.

ロギングドライバへのロギングオプションの設定は ``options`` キーにより行います。
これは ``docker run`` コマンドの ``--log-opt`` オプションと同じです。

.. Logging options are key-value pairs. An example of `syslog` options:

ロギングオプションはキーバリューのペアで指定します。
たとえば ``syslog`` オプションは以下のようになります。

..  driver: "syslog"
    options:
      syslog-address: "tcp://192.168.0.42:123"

.. code-block:: yaml

   driver: "syslog"
   options:
     syslog-address: "tcp://192.168.0.42:123"

.. The default driver [json-file](/engine/admin/logging/overview.md#json-file), has options to limit the amount of logs stored. To do this, use a key-value pair for maximum storage size and maximum number of files:

デフォルトドライバである :doc:`json-file <json-file>` には、保存するログの容量を制限するオプションがあります。
これを利用する場合は、キーバリューのペアを使って、最大保存容量（max-size）と最大ファイル数（max-file）を指定します。

..  options:
      max-size: "200k"
      max-file: "10"

.. code-block:: yaml

   options:
     max-size: "200k"
     max-file: "10"

.. The example shown above would store log files until they reach a `max-size` of
   200kB, and then rotate them. The amount of individual log files stored is
   specified by the `max-file` value. As logs grow beyond the max limits, older log
   files are removed to allow storage of new logs.

上に示した例では、``max-size`` に指定された 200 KB に達するまでログファイルへの出力を行います。
最大値に達するとログをローテートします。
保存するログファイル数は ``max-file`` により指定します。
ログ出力が上限数を越えた場合、古いログファイルは削除され、新たなログファイルへの保存が行われます。

.. Here is an example `docker-compose.yml` file that limits logging storage:

以下に示すのは ``docker-compose.yml`` ファイルにおいてログ保存の制限を行う例です。

..  services:
      some-service:
        image: some-service
        logging:
          driver: "json-file"
          options:
            max-size: "200k"
            max-file: "10"

.. code-block:: yaml

   services:
     some-service:
       image: some-service
       logging:
         driver: "json-file"
         options:
           max-size: "200k"
           max-file: "10"

.. > Logging options available depend on which logging driver you use
   >
   > The above example for controlling log files and sizes uses options
   specific to the [json-file driver](/engine/admin/logging/overview.md#json-file).
   These particular options are not available on other logging drivers.
   For a full list of supported logging drivers and their options, see
   [logging drivers](/engine/admin/logging/overview.md).

.. note::

   利用可能なロギングオプションは、利用しているロギングドライバによって変わります。

   上で示した例においては、ログファイルや容量を制御するために :ref:`json-file ドライバ <json-file>` に固有のオプションを利用しました。
   このようなオプションはその他のロギングドライバでは利用できません。
   サポートされるロギングドライバと個々のオプションについては :doc:`ロギングドライバ </engine/admin/logging/overview>` を参照してください。

.. ### network_mode

.. _compose-file-network_mode:

network_mode
--------------------

.. Network mode. Use the same values as the docker client `--net` parameter, plus
   the special form `service:[service name]`.

ネットワークモードを設定します。
Docker クライアントの ``--network`` パラメータと同じ値を設定します。
これに加えて ``service:[service name]`` という特別な書式も指定可能です。

..  network_mode: "bridge"
    network_mode: "host"
    network_mode: "none"
    network_mode: "service:[service name]"
    network_mode: "container:[container name/id]"

.. code-block:: yaml

   network_mode: "bridge"
   network_mode: "host"
   network_mode: "none"
   network_mode: "service:[service name]"
   network_mode: "container:[container name/id]"

.. > **Notes**
   >
   >* This option is ignored when
   [deploying a stack in swarm
    mode](/engine/reference/commandline/stack_deploy.md) with a (version 3) Compose
    file.
   >
   >* `network_mode: "host"` cannot be mixed with [links](#links).

.. note::

   * Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

   * ``network_mode: "host"`` とした場合、:ref:`links <compose-file-links>` を同時に指定することはできません。
.. ### networks

.. _compose-file-networks:

networks
----------

.. Networks to join, referencing entries under the
   [top-level `networks` key](#network-configuration-reference).

ネットワークへの参加を設定します。
設定には :ref:`最上位の networks キー <network-configuration-reference>` に設定された値を用います。

..  services:
      some-service:
        networks:
         - some-network
         - other-network

.. code-block:: yaml

   services:
     some-service:
       networks:
        - some-network
        - other-network

.. #### aliases

.. _compose-file-aliases:

aliases
^^^^^^^^^^

.. Aliases (alternative hostnames) for this service on the network. Other containers on the same network can use either the service name or this alias to connect to one of the service's containers.

ネットワーク上のサービスに対して、ホスト名の別名となるエイリアスを設定します。
同じネットワーク上にある他のコンテナは、この 1 つのサービスコンテナに対して、サービス名か、あるいはそのエイリアスを使ってアクセスすることができます。

.. Since `aliases` is network-scoped, the same service can have different aliases on different networks.

``aliases`` はネットワーク範囲内において有効です。
ネットワークが異なれば、同一サービスに違うエイリアスを持たせることができます。

.. > **Note**: A network-wide alias can be shared by multiple containers, and even by multiple services. If it is, then exactly which container the name will resolve to is not guaranteed.

.. note::

   ネットワーク全体にわたってのエイリアスを複数コンテナ間で共有することができます。
   それは複数サービス間でも可能です。
   ただしこの場合、名前解決がどのコンテナに対して行われるかは保証されません。

.. The general format is shown here.

一般的な書式は以下のとおりです。

..  services:
      some-service:
        networks:
          some-network:
            aliases:
             - alias1
             - alias3
          other-network:
            aliases:
             - alias2

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

.. In the example below, three services are provided (`web`, `worker`, and `db`),
   along with two networks (`new` and `legacy`). The `db` service is reachable at
   the hostname `db` or `database` on the `new` network, and at `db` or `mysql` on
   the `legacy` network.

以下の例では 3 つのサービス（``web``, ``worker``, ``db`` ）と 2 つのネットワーク（``new`` と ``legacy`` ）を提供します。
``db`` サービスは ``new`` ネットワーク上では、ホスト名 ``db`` あるいは ``database`` としてアクセスできます。
一方 ``legacy`` ネットワーク上では ``db`` あるいは ``mysql`` としてアクセスできます。

..  version: '2'

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

.. #### ipv4_address, ipv6_address

.. _ipv4-address-ipv6-address:

IPv4 アドレス、IPv6 アドレス
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Specify a static IP address for containers for this service when joining the network.

サービスをネットワークに参加させる際、そのコンテナに対してスタティック IP アドレスを設定します。

.. The corresponding network configuration in the [top-level networks section](#network-configuration-reference) must have an `ipam` block with subnet configurations covering each static address. If IPv6 addressing is desired, the [`enable_ipv6`](#enableipv6) option must be set.

:ref:`最上位の networks セクション <network-configuration-reference>` の対応するネットワーク設定においては、``ipam`` ブロックが必要です。
そこでは各スタティックアドレスに応じたサブネットの設定が必要になります。

.. An example:

例：

..  version: '2.1'

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
          -
            subnet: 172.16.238.0/24
          -
            subnet: 2001:3984:3989::/64

.. code-block:: yaml

   version: '2.1'

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
         -
           subnet: 172.16.238.0/24
         -
           subnet: 2001:3984:3989::/64

.. ### pid

.. _compose-file-pid:

pid
----------

..  pid: "host"

.. code-block:: yaml

   pid: "host"

.. Sets the PID mode to the host PID mode.  This turns on sharing between
   container and the host operating system the PID address space.  Containers
   launched with this flag will be able to access and manipulate other
   containers in the bare-metal machine's namespace and vise-versa.

PID モードをホスト PID モードに設定します。
これはコンテナとホストオペレーティングシステムとの間で、PID アドレス空間の共有を開始します。
このフラグを使って起動したコンテナは、ベアメタルマシンの名前空間にあるコンテナにアクセスし、操作することが可能になります。
逆もまた可能です。

.. ### ports

.. _compose-file-ports:

ports
----------

.. Expose ports.

公開用のポートを設定します。

.. #### Short syntax

.. _compose-file-ports-short-syntax:

短い文法
^^^^^^^^^

.. Either specify both ports (`HOST:CONTAINER`), or just the container
   port (a random host port will be chosen).

ホスト側とコンテナ側の両方のポートを指定する（``HOST:CONTAINER`` ）か、あるいはコンテナ側のポートを指定します（ホストポートはランダムに設定されます）。

.. > **Note**: When mapping ports in the `HOST:CONTAINER` format, you may experience
   > erroneous results when using a container port lower than 60, because YAML will
   > parse numbers in the format `xx:yy` as sexagesimal (base 60). For this reason,
   > we recommend always explicitly specifying your port mappings as strings.

.. note::

   ``HOST:CONTAINER`` の書式によってポートをマッピングした場合に、コンテナ側のポートが 60 番未満であるとエラーになることがあります。
   これは YAML パーサが ``xx:yy`` の書式内にある数値を 60 進数値として解釈するからです。
   このことからポートマッピングを指定する際には、常に文字列として設定することをお勧めします。


..  ports:
     - "3000"
     - "3000-3005"
     - "8000:8000"
     - "9090-9091:8080-8081"
     - "49100:22"
     - "127.0.0.1:8001:8001"
     - "127.0.0.1:5000-5010:5000-5010"
     - "6060:6060/udp"

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

.. #### Long syntax

.. _compose-file-ports-long-syntax:

長い文法
^^^^^^^^^

.. The long form syntax allows the configuration of additional fields that can't be
   expressed in the short form.

長い文法は追加の設定項目が加えられていて、短い文法では表現できないものです。

.. - `target`: the port inside the container
   - `published`: the publicly exposed port
   - `protocol`: the port protocol (`tcp` or `udp`)
   - `mode`: `host` for publishing a host port on each node, or `ingress` for a swarm
      mode port which will be load balanced.

* ``target``: コンテナ内部のポート。
* ``published``: 公開ポート。
* ``protocol``: ポートプロトコル。（``tcp`` または ``udp`` ）
* ``mode``: ``host`` は各ノード向けにホストポートを公開、また ``ingress`` はロードバランスを行うためのスウォームモードポート。

.. ```none
   ports:
     - target: 80
       published: 8080
       protocol: tcp
       mode: host
   
   ```

.. code-block:: yaml

   ports:
     - target: 80
       published: 8080
       protocol: tcp
       mode: host

.. > **Note:** The long syntax is new in v3.2

.. note::

   長い文法は v3.2 から導入されました。

.. ### secrets

.. _compose-file-secrets:

secrets
----------

.. Grant access to secrets on a per-service basis using the per-service `secrets`
   configuration. Two different syntax variants are supported.

各サービスごとの ``secrets`` 設定を用いて、個々のサービスごとに secrets へのアクセスを許可します。
2 つの異なる文法がサポートされています。

.. > **Note**: The secret must already exist or be
   > [defined in the top-level `secrets` configuration](#secrets-configuration-reference)
   > of this stack file, or stack deployment will fail.

.. note::

   secrets は既に定義済であるか、あるいは :ref:`最上位の configs が定義済 <configs-configuration-reference>` である必要があります。
   そうでない場合、このファイルによるデプロイが失敗します。

.. #### Short syntax

.. _compose-file-secrets-short-syntax:

短い文法
^^^^^^^^^

.. The short syntax variant only specifies the secret name. This grants the
   container access to the secret and mounts it at `/run/secrets/<secret_name>`
   within the container. The source name and destination mountpoint are both set
   to the secret name.

短い文法では secret 名を指定することだけができます。
これを行うと、コンテナが secret にアクセスできるようになり、secret はコンテナ内の ``/run/secrets/<secret_name>`` にマウントされます。
ソース元となる名前とマウントポイント名は、ともに secret 名となります。

.. The following example uses the short syntax to grant the `redis` service
   access to the `my_secret` and `my_other_secret` secrets. The value of
   `my_secret` is set to the contents of the file `./my_secret.txt`, and
   `my_other_secret` is defined as an external resource, which means that it has
   already been defined in Docker, either by running the `docker secret create`
   command or by another stack deployment. If the external secret does not exist,
   the stack deployment fails with a `secret not found` error.

以下の例では短い文法を使って、``redis`` サービスが 2 つの secret、つまり ``my_secret`` と ``my_other_secret`` にアクセスできるようにします。
``my_secret`` の値には ``./my_secret.txt`` ファイルに含まれる内容を設定します。
``my_other_secret`` は外部リソースとして定義し、それはつまり Docker において定義済の内容を用います。
これは ``docker secret create`` コマンドの実行か、あるいは別のスタックデプロイメントにより与えられます。
外部 secret が存在しなかった場合、スタックデプロイメントは失敗し ``secret not found`` といったエラーが発生します。

.. ```none
   version: "3.1"
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
   ```

.. code-block:: yaml

   version: "3.1"
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

.. #### Long syntax

.. _compose-file-secrets-long-syntax:

長い文法
^^^^^^^^^

.. The long syntax provides more granularity in how the secret is created within
   the service's task containers.

長い文法ではさらに細かな設定として、サービスタスクのコンテナ内にて secret をどのように生成するかを設定します。

.. - `source`: The name of the secret as it exists in Docker.
   - `target`: The name of the file that will be mounted in `/run/secrets/` in the
     service's task containers. Defaults to `source` if not specified.
   - `uid` and `gid`: The numeric UID or GID which will own the file within
     `/run/secrets/` in the service's task containers. Both default to `0` if not
     specified.
   - `mode`: The permissions for the file that will be mounted in `/run/secrets/`
     in the service's task containers, in octal notation. For instance, `0444`
     represents world-readable. The default in Docker 1.13.1 is `0000`, but will
     be `0444` in the future. Secrets cannot be writable because they are mounted
     in a temporary filesystem, so if you set the writable bit, it is ignored. The
     executable bit can be set. If you aren't familiar with UNIX file permission
     modes, you may find this
     [permissions calculator](http://permissions-calculator.org/){: target="_blank" class="_" }
     useful.

* ``source``： Docker 内に存在している secret 名。
* ``target``： サービスのタスクコンテナにおいて ``/run/secrets/`` にマウントされるファイル名。
  指定されなかった場合のデフォルトは ``source`` となります。
* ``uid`` と ``gid``： サービスのタスクコンテナにおいて ``/run/secrets/`` 内のファイルを所有する UID 値と GID 値。
  指定されなかった場合のデフォルトはいずれも ``0``。
* ``mode``： サービスのタスクコンテナにおいて ``/run/secrets/`` にマウントされるファイルのパーミッション。
  8 進数表記。
  たとえば ``0444`` であればすべて読み込み可。
  Docker 1.13.1 におけるデフォルトは ``0000`` でしたが、それ以降では ``0444`` となりました。
  secrets はテンポラリなファイルシステム上にマウントされるため、書き込み可能にはできません。
  したがって書き込みビットを設定しても無視されます。
  実行ビットは設定できます。
  UNIX のファイルパーミッションモードに詳しくない方は、`パーミッション計算機 <http://permissions-calculator.org/>`_ を参照してください。

.. The following example sets name of the `my_secret` to `redis_secret` within the
   container, sets the mode to `0440` (group-readable) and sets the user and group
   to `103`. The `redis` service does not have access to the `my_other_secret`
   secret.

以下の例では ``my_secret`` という名前の secret を、コンテナ内では ``redis_secret`` として設定します。
そしてモードを ``0440`` （グループが読み込み可能）とし、ユーザとグループは ``103`` とします。
``redis`` サービスは ``my_other_secret`` へはアクセスしません。

.. ```none
   version: "3.1"
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
   ```

.. code-block:: yaml

   version: "3.1"
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

.. You can grant a service access to multiple secrets and you can mix long and
   short syntax. Defining a secret does not imply granting a service access to it.

1 つのサービスが複数の secrets にアクセスする設定とすることもできます。
また短い文法、長い文法を混在することも可能です。
secret を定義しただけでは、サービスに対して secret へのアクセスを許可するものにはなりません。

.. ### security_opt

.. _compose-file-security_opt:

security_opt
--------------------

.. Override the default labeling scheme for each container.

各コンテナにおけるデフォルトのラベリング・スキーム（labeling scheme）を上書きします。

..  security_opt:
      - label:user:USER
      - label:role:ROLE

.. code-block:: yaml

   security_opt:
     - label:user:USER
     - label:role:ROLE

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### stop_grace_period

.. _compose-file-stop_grace_period:

stop_grace_period
--------------------

.. Specify how long to wait when attempting to stop a container if it doesn't
   handle SIGTERM (or whatever stop signal has been specified with
   [`stop_signal`](#stopsignal)), before sending SIGKILL. Specified
   as a [duration](#specifying-durations).

コンテナが SIGKILL を送信するまでに、SIGTERM（あるいは :ref:`stop_signal <compose-file-stop_signal>` によって設定されたストップシグナル）をどれだけ待つかを設定します。
指定には :ref:`間隔 <specifying-durations>` を用います。

..  stop_grace_period: 1s
    stop_grace_period: 1m30s

.. code-block:: yaml

   stop_grace_period: 1s
   stop_grace_period: 1m30s

.. By default, `stop` waits 10 seconds for the container to exit before sending
   SIGKILL.

デフォルトで、コンテナが SIGKILL を送信する前に ``stop`` は 10 秒待ちます。

.. ### stop_signal

.. _compose-file-stop_signal:

stop_signal
--------------------

.. Sets an alternative signal to stop the container. By default `stop` uses
   SIGTERM. Setting an alternative signal using `stop_signal` will cause
   `stop` to send that signal instead.

コンテナに対して別の停止シグナルを設定します。
デフォルトにおいて ``stop`` は SIGTERM を用います。
``stop_signal`` を使って別のシグナルを設定すると ``stop`` にはそのシグナルが代わりに送信されます。

..  stop_signal: SIGUSR1

.. code-block:: yaml

   stop_signal: SIGUSR1

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### sysctls

.. _compose-file-sysctls:

sysctls
--------------------

.. Kernel parameters to set in the container. You can use either an array or a
   dictionary.

コンテナに設定するカーネルパラメータを設定します。
配列または辞書形式での指定ができます。

..  sysctls:
      net.core.somaxconn: 1024
      net.ipv4.tcp_syncookies: 0

    sysctls:
      - net.core.somaxconn=1024
      - net.ipv4.tcp_syncookies=0

.. code-block:: yaml

   sysctls:
     net.core.somaxconn: 1024
     net.ipv4.tcp_syncookies: 0

   sysctls:
     - net.core.somaxconn=1024
     - net.ipv4.tcp_syncookies=0

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### ulimits

.. _compose-file-ulimits:

ulimits
----------

.. Override the default ulimits for a container. You can either specify a single
   limit as an integer or soft/hard limits as a mapping.

コンテナにおけるデフォルトの ulimits を上書きします。
1 つの limit を整数値として指定するか、ソフト、ハードの limit をマッピングとして指定することができます。

..  ulimits:
      nproc: 65535
      nofile:
        soft: 20000
        hard: 40000

.. code-block:: yaml

   ulimits:
     nproc: 65535
     nofile:
       soft: 20000
       hard: 40000

.. ### userns_mode

.. _compose-file-userns_mode:

userns_mode
-------------

..  userns_mode: "host"

.. code-block:: yaml

   userns_mode: "host"

.. Disables the user namespace for this service, if Docker daemon is configured with user namespaces.
   See [dockerd](/engine/reference/commandline/dockerd.md#disable-user-namespace-for-a-container) for
   more information.

Docker デーモンにおいてユーザ名前空間が設定されていても、サービスに対してユーザ名前空間を無効にします。
詳しくは :ref:`dockerd <disable-user-namespace-for-a-container>` を参照してください。

.. > **Note**: This option is ignored when
   > [deploying a stack in swarm mode](/engine/reference/commandline/stack_deploy.md)
   > with a (version 3) Compose file.

.. note::

   Compose ファイルバージョン 3 においてこのオプションは、:doc:`スウォームモードでのスタックのデプロイ </engine/reference/commandline/stack_deploy>` を行う場合には無視されます。

.. ### volumes

.. _compose-file-volumes:

volumes
--------

.. Mount host paths or named volumes, specified as sub-options to a service.

マウントホストパスや名前つきボリュームを、サービスに対するサブオプションとして指定します。

.. You can mount a host path as part of a definition for a single service, and
   there is no need to define it in the top level `volumes` key.

ホストパスのマウントは、単一サービスの定義の一部として行うことができます。
これは最上位の `volumes`` キーにて定義する必要はありません。

.. But, if you want to reuse a volume across multiple services, then define a named
   volume in the [top-level `volumes` key](#volume-configuration-reference). Use
   named volumes with [services, swarms, and stack
   files](#volumes-for-services-swarms-and-stack-files).

ただし複数のサービスにわたってボリュームを再利用したい場合は、:ref:`最上位の volumes キー <volume-configuration-reference>` において名前つきボリュームを定義してください。
名前つきボリュームは :ref:`サービス、スウォーム、スタックファイル <volumes-for-services-swarms-and-stack-files>` において用いられます。

.. > **Note**: The top-level
   > [volumes](#volume-configuration-reference) key defines
   > a named volume and references it from each service's `volumes` list. This replaces `volumes_from` in earlier versions of the Compose file format. See [Use volumes](/engine/admin/volumes/volumes.md) and [Volume
   Plugins](/engine/extend/plugins_volume.md) for general information on volumes.

.. note::

   最上位の :ref:`volumes <volume-configuration-reference>` キーは名前つきボリュームを定義し、各サービスの ``volumes`` リストからこれを参照します。
   これは Compose ファイルフォーマットのかつてのバージョンにおける ``volumes_from`` に置き換わるものです。
   ボリュームに関する一般的な情報については :doc:`ボリュームの利用 </engine/admin/volumes/volumes>` や :doc:`ボリューム・プラグイン </engine/extend/plugins_volume>` を参照してください。

.. This example shows a named volume (`mydata`) being used by the `web` service,
   and a bind mount defined for a single service (first path under `db` service
   `volumes`). The `db` service also uses a named volume called `dbdata` (second
   path under `db` service `volumes`), but defines it using the old string format
   for mounting a named volume. Named volumes must be listed under the top-level
   `volumes` key, as shown.

以下の例では名前つきボリューム（``mydata`` ）が ``web`` サービスにおいて利用されています。
またバインドマウントが単一のサービス（``db`` サービスの ``volumes`` にある最初のパス）に対して定義されています。
``db`` サービスはさらに ``dbdata`` という名前つきボリュームを利用しています（``db`` サービスの ``volumes`` の 2 つめのパス）が、その定義の仕方は、名前つきボリュームをマウントする古い文字列書式を使っています。
名前つきボリュームは以下に示しているように、最上位の ``volumes`` キーのもとに列記されていなければなりません。

.. ```none
   version: "3.2"
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
   ```

.. code-block:: yaml

   version: "3.2"
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

.. > **Note**: See [Use volumes](/engine/admin/volumes/volumes.md) and [Volume
   > Plugins](/engine/extend/plugins_volume.md) for general information on volumes.

.. note::

   ボリュームに関する一般的な情報については :doc:`ボリュームの利用 </engine/admin/volumes/volumes>` や :doc:`ボリューム・プラグイン </engine/extend/plugins_volume>` を参照してください。

.. #### Short syntax

.. _compose-file-volumes-short-syntax:

短い文法
^^^^^^^^^

.. Optionally specify a path on the host machine
   (`HOST:CONTAINER`), or an access mode (`HOST:CONTAINER:ro`).

設定方法として、ホストマシンのパスを指定する方法（``HOST:CONTAINER`` ）や、さらにアクセスモードを指定する方法（``HOST:CONTAINER:ro`` ）があります。

.. You can mount a relative path on the host, which will expand relative to
   the directory of the Compose configuration file being used. Relative paths
   should always begin with `.` or `..`.

ホスト上の相対パスをマウントすることができます。
これは、用いられている Compose 設定ファイルのディレクトリからの相対パスとして展開されます。
相対パスは ``.`` または ``..`` で書き始める必要があります。

..  volumes:
      # Just specify a path and let the Engine create a volume
      - /var/lib/mysql

      # Specify an absolute path mapping
      - /opt/data:/var/lib/mysql

      # Path on the host, relative to the Compose file
      - ./cache:/tmp/cache

      # User-relative path
      - ~/configs:/etc/configs/:ro

      # Named volume
      - datavolume:/var/lib/mysql

.. code-block:: yaml

   volumes:
     # パス指定のみ。Engine にボリュームを生成させます。
     - /var/lib/mysql

     # 絶対パスのマッピングを指定。
     - /opt/data:/var/lib/mysql

     # ホストからのパス指定。Compose ファイルからの相対パス。
     - ./cache:/tmp/cache

     # ユーザディレクトリからの相対パス。
     - ~/configs:/etc/configs/:ro

     # 名前つきボリューム。
     - datavolume:/var/lib/mysql

.. #### Long syntax

.. _compose-file-volumes-long-syntax:

長い文法
^^^^^^^^^

.. The long form syntax allows the configuration of additional fields that can't be
   expressed in the short form.

長い文法は追加の設定項目が加えられていて、短い文法では表現できないものです。

.. - `type`: the mount type `volume`, `bind` or `tmpfs`
   - `source`: the source of the mount, a path on the host for a bind mount, or the
     name of a volume defined in the
     [top-level `volumes` key](#volume-configuration-reference). Not applicable for a tmpfs mount.
   - `target`: the path in the container where the volume will be mounted
   - `read_only`: flag to set the volume as read-only
   - `bind`: configure additional bind options
     - `propagation`: the propagation mode used for the bind
   - `volume`: configure additional volume options
     - `nocopy`: flag to disable copying of data from a container when a volume is
       created

* ``type``: マウントタイプを表わす ``volume``, ``bind``, ``tmpfs`` のいずれかを指定します。
* ``source``: マウント元。バインドマウントにおいてはホスト上のパスを指定します。
  また :ref:`最上位の volumes キー <volume-configuration-reference>` で定義したボリューム名を指定します。
  tmpfs マウントはできません。
* ``target``: ボリュームがマウントされるコンテナ内のパスを指定します。
* ``read_only``: ボリュームを読み込み専用に設定します。
* ``bind``: 追加のバインドオプションを設定します。

  * ``propagation``: バインドにおいて伝播モード（propagation mode）を利用します。

* ``volume``: 追加のボリュームオプションを設定します。

  * ``nocopy``: ボリュームの生成時にはコンテナからのデータコピーを無効にします。

* ``tmpfs``: 追加の tmpfs オプションを設定します。

  * ``size``: tmpfs マウントのサイズをバイト数で指定します。

* ``consistency``: マウントに求める一貫性を指定します。以下のいずれか： ``consistent`` （ホストとコンテナは同一ビューを持ちます）、 ``cached`` （読み込みキャッシュ、ホストビューに権限あり）、``delegated`` (読み書きキャッシュ、コンテナビューに権限あり）

.. ```none
   version: "3.2"
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
   ```

.. code-block:: yaml

   version: "3.2"
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

.. > **Note:** The long syntax is new in v3.2

.. note::

   長い文法は v3.2 から導入されました。

.. #### Volumes for services, swarms, and stack files

.. _volumes-for-services-swarms-and-stack-files:

サービス、スウォーム、スタックファイルにおけるボリューム設定
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. When working with services, swarms, and `docker-stack.yml` files, keep in mind
   that the tasks (containers) backing a service can be deployed on any node in a
   swarm, which may be a different node each time the service is updated.

サービス、スウォーム、``docker-stack.yml`` ファイルを扱っている際には気をつけておくべきことがあります。
サービスのもとにあるタスク（コンテナ）はスォーム内のどのノードにでもデプロイされます。
サービスは毎回、異なるノードとなり得るということです。

.. In the absence of having named volumes with specified sources, Docker creates an
   anonymous volume for each task backing a service. Anonymous volumes do not
   persist after the associated containers are removed.

ボリュームに名前をつけずに利用したとすると、Docker はサービスのもとにある各タスクに対して、名前のない匿名のボリュームを生成します。
匿名ボリュームは、関連コンテナが削除された後は持続されません。

.. If you want your data to persist, use a named volume and a volume driver that
   is multi-host aware, so that the data is accessible from any node. Or, set
   constraints on the service so that its tasks are deployed on a node that has the
   volume present.

データを維持しておきたい場合は、名前つきボリュームを設定し、複数ホストに対応したボリュームドライバを利用してください。
そうすればデータはどのノードからでもアクセスできます。
あるいはサービスに対する指定として、ボリュームが存在しているノードへタスクをデプロイするようにしてください。

.. As an example, the `docker-stack.yml` file for the
   [votingapp sample in Docker
   Labs](https://github.com/docker/labs/blob/master/beginner/chapters/votingapp.md) defines a service called `db` that runs a `postgres` database. It is
   configured as a named volume in order to persist the data on the swarm,
   _and_ is constrained to run only on `manager` nodes. Here is the relevant snip-it from that file:

例として `Docker Labs にある投票アプリ <https://github.com/docker/labs/blob/master/beginner/chapters/votingapp.md>`_ では、``docker-stack.yml`` にて ``postgres`` データベースを起動する ``db`` サービスが定義されています。
そして名前つきボリュームを設定して、スウォーム内のデータを失わないようにしています。
**さらに** それは ``manager`` ノードでのみ稼動するように限定しています。
以下は該当するファイル部分の抜粋です。

.. ```none
   version: "3"
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
   ```

.. code-block:: yaml

   version: "3"
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

.. #### Caching options for volume mounts (Docker for Mac)

.. _caching-options-for-volume-mounts-docker-desktop-for-mac:

ボリュームマウントに対するキャッシュオプション（Docker for Mac）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. On Docker 17.04 CE Edge and up, including 17.06 CE Edge and Stable, you can
   configure container-and-host consistency requirements for bind-mounted
   directories in Compose files to allow for better performance on read/write of
   volume mounts. These options address issues specific to `osxfs` file sharing,
   and therefore are only applicable on Docker for Mac.

Docker 17.04 CE Edge とそれ以上の 17.06 CE Edge や Stable においては、Compose ファイル内にてバインドマウントするディレクトリの、コンテナ・ホスト間の一貫性を設定することができます。
これによってボリュームの読み書き性能を向上させることができます。
これを実現するオプションは ``osxfs`` ファイル共有に対する問題に対処しているため、Docker Desktop for Mac においてのみ利用可能です。

.. The flags are:

フラグとして以下があります。

.. * `consistent`： Full consistency. The container runtime and the
   host maintain an identical view of the mount at all times.  This is the default.

* ``consistent``: 完全な一貫性を持ちます。
  起動しているコンテナとホストは、常にマウント上を同一に見ることができます。
  これがデフォルトです。

.. * `cached`: The host's view of the mount is authoritative. There may be
   delays before updates made on the host are visible within a container.

* ``cached``： ホスト側マウントが優先されます。
  ホスト上の更新が、コンテナ内で確認できるまでには遅延が起こりえます。

.. * `delegated`: The container runtime's view of the mount is
   authoritative. There may be delays before updates made in a container
   are visible on the host.

* ``delegated``： コンテナ実行時のコンテナ側マウントが優先されます。
  コンテナ内での更新が、ホスト上で確認できるまでには遅延が起こりえます。

.. Here is an example of configuring a volume as `cached`:

以下はボリュームに ``cached`` を設定した例です。

.. ```none
   version: '3'
   services:
     php:
       image: php:7.1-fpm
       ports:
         - 9000
       volumes:
         - .:/var/www/project:cached
   ```

.. code-block:: yaml

   version: '3'
   services:
     php:
       image: php:7.1-fpm
       ports:
         - 9000
       volumes:
         - .:/var/www/project:cached

.. Full detail on these flags, the problems they solve, and their
   `docker run` counterparts is in the Docker for Mac topic [Performance tuning for
   volume mounts (shared filesystems)](/docker-for-mac/osxfs-caching.md).

このフラグの詳細、これにより解決される諸問題、``docker run`` での対応オプションについては Docker Desktop for Mac のトピック、:doc:`ボリュームマウント（共有ファイルシステム）でのパフォーマンスチューニング </docker-for-mac/osxfs-caching>` を参照してください。

.. ### restart

.. _compose-file-restart:

restart
--------

.. `no` is the default restart policy, and it will not restart a container under
   any circumstance. When `always` is specified, the container always restarts. The
   `on-failure` policy restarts a container if the exit code indicates an
   on-failure error.

再起動ポリシー（restart policy）のデフォルトは ``no`` です。
この場合はどういう状況であってもコンテナは再起動しません。
``always`` を指定した場合、コンテナは常に再起動することになります。
また ``on-failure`` ポリシーでは、終了コードが on-failure エラーを表わしている場合にコンテナが再起動します。

..  restart: "no"
    restart: always
    restart: on-failure
    restart: unless-stopped

.. code-block:: yaml

   restart: "no"
   restart: always
   restart: on-failure
   restart: unless-stopped

.. ### domainname, hostname, ipc, mac\_address, privileged, read\_only, shm\_size, stdin\_open, tty, user, working\_dir

.. _compose-options:

domainname, hostname, ipc, mac\_address, privileged, read\_only, shm\_size, stdin\_open, tty, user, working\_dir
------------------------------------------------------------------------------------------------------------------

.. Each of these is a single value, analogous to its
   [docker run](/engine/reference/run.md) counterpart.

ここに示すオプションはいずれも、値 1 つを設定するものであり、:doc:`docker run </engine/reference/run/>` のオプションに対応づいています。
なお ``mac_address`` は古くなったオプションです。

..  user: postgresql
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

.. ## Specifying durations

.. _specifying-durations:

時間の指定
===============

.. Some configuration options, such as the `interval` and `timeout` sub-options for
   [`check`](#healthcheck), accept a duration as a string in a
   format that looks like this:

:ref:`check <compose-file-healthcheck>` のサブオプション ``interval``、``timeout`` のように、時間を設定するオプションがあります。
これは以下のような書式による文字列を時間として受け付けるものです。

..  2.5s
    10s
    1m30s
    2h32m
    5h34m56s

.. code-block:: yaml

   2.5s
   10s
   1m30s
   2h32m
   5h34m56s

.. The supported units are `us`, `ms`, `s`, `m` and `h`.

サポートされる単位は ``us``, ``ms``, ``s``, ``m``, ``h`` です。

.. ## Volume configuration reference

.. _volume-configuration-reference:

ボリューム設定リファレンス
==============================

.. While it is possible to declare [volumes](#volumes) on the file as part of the
   service declaration, this section allows you to create named volumes (without
   relying on `volumes_from`) that can be reused across multiple services, and are
   easily retrieved and inspected using the docker command line or API. See the
   [docker volume](/engine/reference/commandline/volume_create.md) subcommand
   documentation for more information.

サービスの宣言の一部として、ファイル上に :ref:`volumes <compose-file-volumes>` を宣言することが可能ですが、このセクションでは（``volumes_from`` を利用せずに）名前つきボリュームを生成する方法を説明します。
このボリュームは、複数のサービスにわたっての再利用が可能であり、docker コマンドラインや API を使って簡単に抽出したり確認したりすることができます。
詳しくは :doc:`docker volume </engine/reference/commandline/volume_create>` のサブコマンドを確認してください。

.. See [Use volumes](/engine/admin/volumes/volumes.md) and [Volume
   Plugins](/engine/extend/plugins_volume.md) for general information on volumes.

ボリュームに関する一般的な情報については :doc:`ボリュームの利用 </engine/admin/volumes/volumes>` や :doc:`ボリューム・プラグイン </engine/extend/plugins_volume>` を参照してください。

.. Here's an example of a two-service setup where a database's data directory is
   shared with another service as a volume so that it can be periodically backed
   up:

以下の例では 2 つのサービスを用います。
データベースのデータディレクトリは、もう一方のサービスに対してボリュームとして共有させます。
これによりデータが定期的に反映されます。

..  version: "3"

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

.. code-block:: yaml

   version: "3"

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

.. An entry under the top-level `volumes` key can be empty, in which case it will
   use the default driver configured by the Engine (in most cases, this is the
   `local` driver). Optionally, you can configure it with the following keys:

最上位の ``volumes`` キーは指定しないようにすることもできます。
その場合は Engine によってデフォルトで設定されているドライバが用いられます。
（たいていは ``local`` ドライバとなります。）
さらに追加で、以下のようなキーを設定することができます。

.. ### driver

.. _volume-configuration_driver:

driver
----------

.. Specify which volume driver should be used for this volume. Defaults to whatever
   driver the Docker Engine has been configured to use, which in most cases is
   `local`. If the driver is not available, the Engine will return an error when
   `docker-compose up` tries to create the volume.

どのボリュームドライバを現在のボリュームに対して用いるかを指定します。
デフォルトは Docker Engine が利用するものとして設定されているドライバになります。
たいていは ``local`` です。
ドライバが利用できない場合、``docker-compose up`` によってボリューム生成が行われる際に Engine がエラーを返します。

..   driver: foobar

.. code-block:: yaml

   driver: foobar

.. ### driver_opts

.. driver_opts

driver_opts
--------------------

.. Specify a list of options as key-value pairs to pass to the driver for this
   volume. Those options are driver-dependent - consult the driver's
   documentation for more information. Optional.

このボリュームが利用するドライバに対して、受け渡したいオプションをキーバリューペアのリストとして設定します。
このオプションは各ドライバによって異なります。
詳しくは各ドライバのドキュメントを参照してください。
設定は任意です。

..   driver_opts:
       foo: "bar"
       baz: 1

.. code-block:: yaml

   driver_opts:
     foo: "bar"
     baz: 1

.. ### external

.. _compose-file-external:

external
--------------------

.. If set to `true`, specifies that this volume has been created outside of
   Compose. `docker-compose up` will not attempt to create it, and will raise
   an error if it doesn't exist.

このオプションを ``true`` に設定することにより、Compose の外部において生成されているボリュームを設定します。
``docker-compose up`` はボリュームを生成しないようになりますが、ボリュームが存在しなければエラーとなります。

.. `external` cannot be used in conjunction with other volume configuration keys
   (`driver`, `driver_opts`).

``external`` は他のボリューム設定キー（``driver``, ``driver_opts`` ）と同時に用いることはできません。

.. In the example below, instead of attempting to create a volume called
   `[projectname]_data`, Compose will look for an existing volume simply
   called `data` and mount it into the `db` service's containers.

以下の例では ``[projectname]_data`` というボリュームは生成されることはなく、Compose はすでに存在している ``data`` という単純な名前のボリュームを探しにいきます。
そしてこれを ``db`` サービスコンテナ内にマウントします。

..  version: '2'

    services:
      db:
        image: postgres
        volumes:
          - data:/var/lib/postgresql/data

    volumes:
      data:
        external: true

.. code-block:: yaml

   version: '2'

   services:
     db:
       image: postgres
       volumes:
         - data:/var/lib/postgresql/data

   volumes:
     data:
       external: true

.. You can also specify the name of the volume separately from the name used to
   refer to it within the Compose file:

ボリューム名として指定する名前は、Compose ファイル内で参照されている名前以外でも指定することができます。

..  volumes:
      data:
        external:
          name: actual-name-of-volume

.. code-block:: yaml

   volumes:
     data:
       external:
         name: actual-name-of-volume

.. > External volumes are always created with docker stack deploy
   >
   External volumes that do not exist _will be created_ if you use [docker stack
   deploy](#deploy) to launch the app in [swarm mode](/engine/swarm/index.md)
   (instead of [docker compose up](/compose/reference/up.md)). In swarm mode, a
   volume is automatically created when it is defined by a service. As service
   tasks are scheduled on new nodes,
   [swarmkit](https://github.com/docker/swarmkit/blob/master/README.md) creates the
   volume on the local node. To learn more, see
   [moby/moby#29976](https://github.com/moby/moby/issues/29976).

.. note::
   external ボリュームは docker stack deploy により常に生成されます。
     external ボリュームが存在しない場合に、:ref:`docker stack deploy <compose-file-deploy>` を実行してアプリを :doc:`スウォームモード </engine/swarm/index>` 内に導入すると、ボリュームが **生成されます** 。
     （:doc:`docker compose up </compose/reference/up>` とは異なります。）
     スウォームモードにおいて、サービスとして定義されているボリュームは自動生成されます。
     サービスタスクは新たなノード上においてスケジューリングされるので、`swarmkit <https://github.com/docker/swarmkit/blob/master/README.md>`_ がローカルノード上にボリュームを生成します。
     詳しくは `moby/moby#29976 <https://github.com/moby/moby/issues/29976>`_ を参照してください。

.. ### labels

.. _compose-file-volume-labels:

labels
-------

.. Add metadata to containers using
   [Docker labels](/engine/userguide/labels-custom-metadata.md). You can use either
   an array or a dictionary.

:doc:`Docker labels </engine/userguide/labels-custom-metadata>` を使ってコンテナにメタデータを追加します。
配列形式と辞書形式のいずれかにより指定します。

.. It's recommended that you use reverse-DNS notation to prevent your labels from
   conflicting with those used by other software.

ここでは逆 DNS 記法とすることをお勧めします。
この記法にしておけば、他のソフトウェアが用いるラベルとの競合が避けられるからです。

..  labels:
      com.example.description: "Database volume"
      com.example.department: "IT/Ops"
      com.example.label-with-empty-value: ""

    labels:
      - "com.example.description=Database volume"
      - "com.example.department=IT/Ops"
      - "com.example.label-with-empty-value"

.. code-block:: yaml

   labels:
     com.example.description: "Database volume"
     com.example.department: "IT/Ops"
     com.example.label-with-empty-value: ""

   labels:
     - "com.example.description=Database volume"
     - "com.example.department=IT/Ops"
     - "com.example.label-with-empty-value"

.. ## Network configuration reference

.. _network-configuration-reference:

ネットワーク設定リファレンス
==============================

.. The top-level `networks` key lets you specify networks to be created.

最上位の ``networks`` キーは、生成するネットワークを指定します。

.. * For a full explanation of Compose's use of Docker networking features and all
   network driver options, see the [Networking guide](../networking.md).

* Compose が利用する Docker ネットワーク機能やネットワークドライバのオプションに関して、詳細は :doc:`ネットワークガイド </compose/networking>` を参照してください。

.. * For [Docker Labs](https://github.com/docker/labs/blob/master/README.md)
   tutorials on networking, start with [Designing Scalable, Portable Docker
   Container
   Networks](https://github.com/docker/labs/blob/master/networking/README.md)

* `Docker Labs <https://github.com/docker/labs/blob/master/README.md>`_ にあるネットワークのチュートリアルとして、`Designing Scalable, Portable Docker Container Networks <https://github.com/docker/labs/blob/master/networking/README.md>`_ を試してみてください。

.. ### driver

driver
----------

.. Specify which driver should be used for this network.

現在のネットワークにおいて利用するドライバを設定します。

.. The default driver depends on how the Docker Engine you're using is configured,
   but in most instances it will be `bridge` on a single host and `overlay` on a
   Swarm.

デフォルトとなるドライバは、Docker Engine においてどのドライバを用いているかによって変わります。
たいていの場合、単一ホストであれば ``bridge``、スウォーム上では ``overlay`` となります。

.. The Docker Engine will return an error if the driver is not available.

ドライバが利用できない場合、Docker Engine はエラーを返します。

..  driver: overlay

.. code-block:: yaml

   driver: overlay

.. #### bridge

bridge
^^^^^^^

.. Docker defaults to using a `bridge` network on a single host. For examples of
   how to work with bridge networks, see the Docker Labs tutorial on [Bridge
   networking](https://github.com/docker/labs/blob/master/networking/A2-bridge-networking.md).

単一ホストの場合、Docker はデフォルトとして ``bridge`` ネットワークを利用します。
bridge ネットワークがどのように動作するかは、Docker Labs のチュートリアルである `ブリッジネットワーク <https://github.com/docker/labs/blob/master/networking/A2-bridge-networking.md>`_ の例を参照してください。

.. #### overlay

overlay
^^^^^^^^

.. The `overlay` driver creates a named network across multiple nodes in a
   [swarm](/engine/swarm/).

``overlay`` ドライバは、:doc:`スウォーム </engine/swarm/>` 内での複数ノードにわたって、名前づけされたネットワークを生成します。

.. * For a working example of how to build and use an
   `overlay` network with a service in swarm mode, see the Docker Labs tutorial on
   [Overlay networking and service
   discovery](https://github.com/docker/labs/blob/master/networking/A3-overlay-networking.md).

* スウォームモードにて ``overlay`` ネットワークによるサービスを構築し利用する例として、Docker Labs のチュートリアル `Overlay networking and service discovery <https://github.com/docker/labs/blob/master/networking/A3-overlay-networking.md>`_ を参照してください。

.. * For an in-depth look at how it works under the hood, see the
   networking concepts lab on the [Overlay Driver Network
   Architecture](https://github.com/docker/labs/blob/master/networking/concepts/06-overlay-networks.md).

* さらに詳しく内部動作を知るためには、networking concepts lab にある `Overlay Driver Network Architecture <https://github.com/docker/labs/blob/master/networking/concepts/06-overlay-networks.md>`_ を参照してください。

.. ### driver_opts

driver_opts
--------------------

.. Specify a list of options as key-value pairs to pass to the driver for this
   network. Those options are driver-dependent - consult the driver's
   documentation for more information. Optional.

このネットワークが利用するドライバに対して、受け渡したいオプションをキーバリューペアのリストとして設定します。
このオプションは各ドライバによって異なります。
詳しくは各ドライバのドキュメントを参照してください。
設定は任意です。

..    driver_opts:
        foo: "bar"
        baz: 1

.. code-block:: yaml

   driver_opts:
     foo: "bar"
     baz: 1

.. ### enable_ipv6

enable_ipv6
--------------------

.. Enable IPv6 networking on this network.

現在のネットワークにおいて IPv6 ネットワークを有効にします。

.. ### ipam

ipam
-----

.. Specify custom IPAM config. This is an object with several properties, each of
   which is optional:

独自の IPAM 設定を行います。
いくつかのプロパティにより表わされるオブジェクトであり、それぞれの指定は任意です。

.. -   `driver`: Custom IPAM driver, instead of the default.
   -   `config`: A list with zero or more config blocks, each containing any of
       the following keys:
       - `subnet`: Subnet in CIDR format that represents a network segment

*   ``driver``： デフォルトではない独自の IPAM ドライバを指定します。
*   ``config``： 設定ブロックを指定します。要素数はゼロでも複数でも可です。
    以下のキーを用いることができます。

    * ``subnet``： ネットワークセグメントを表わす CIDR 形式のサブネットを指定します。

.. A full example:

すべてを利用した例が以下です。

..  ipam:
      driver: default
      config:
        - subnet: 172.28.0.0/16

.. code-block:: yaml

   ipam:
     driver: default
     config:
       - subnet: 172.28.0.0/16

.. > **Note**: Additional IPAM configurations, such as `gateway`, are only honored for version 2 at the moment.

.. note::

   ``gateway`` のような設定キーは、, 現時点ではバージョン 2 においてのみ利用できます。

.. ### internal

internal
----------

.. By default, Docker also connects a bridge network to it to provide external
   connectivity. If you want to create an externally isolated overlay network,
   you can set this option to `true`.

デフォルトにおいて Docker はブリッジネットワークに接続する際に、外部接続機能も提供します。
外部に独立した overlay ネットワークを生成したい場合、本オプションを ``true`` にします。

.. ### labels

labels
----------

.. Add metadata to containers using
   [Docker labels](/engine/userguide/labels-custom-metadata.md). You can use either
   an array or a dictionary.

:doc:`Docker labels </engine/userguide/labels-custom-metadata>` を使ってコンテナにメタデータを追加します。
配列形式と辞書形式のいずれかにより指定します。


.. It's recommended that you use reverse-DNS notation to prevent your labels from
   conflicting with those used by other software.

ここでは逆 DNS 記法とすることをお勧めします。
この記法にしておけば、他のソフトウェアが用いるラベルとの競合が避けられるからです。

..  labels:
      com.example.description: "Financial transaction network"
      com.example.department: "Finance"
      com.example.label-with-empty-value: ""

    labels:
      - "com.example.description=Financial transaction network"
      - "com.example.department=Finance"
      - "com.example.label-with-empty-value"

.. code-block:: yaml

   labels:
     com.example.description: "Financial transaction network"
     com.example.department: "Finance"
     com.example.label-with-empty-value: ""

   labels:
     - "com.example.description=Financial transaction network"
     - "com.example.department=Finance"
     - "com.example.label-with-empty-value"

.. ### external

external
---------

.. If set to `true`, specifies that this network has been created outside of
   Compose. `docker-compose up` will not attempt to create it, and will raise
   an error if it doesn't exist.

このオプションを ``true`` に設定することにより、Compose の外部において生成されているネットワークを設定します。
``docker-compose up`` はネットワークを生成しないようになりますが、ネットワークが存在しなければエラーとなります。

.. `external` cannot be used in conjunction with other network configuration keys
   (`driver`, `driver_opts`, `ipam`, `internal`).

``external`` は他のネットワーク設定キー（``driver``, ``driver_opts``, ``ipam``, ``internal`` ）と同時に用いることはできません

.. In the example below, `proxy` is the gateway to the outside world. Instead of
   attempting to create a network called `[projectname]_outside`, Compose will
   look for an existing network simply called `outside` and connect the `proxy`
   service's containers to it.

以下の例において ``proxy`` は外部ネットワークとの間のゲートウェイです。
``[projectname]_outside`` というネットワークは生成されることはなく、Compose はすでに存在している ``outside`` という単純な名前のネットワークを探しにいって、``proxy`` サービスのコンテナに接続します。

..  version: '2'

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

.. You can also specify the name of the network separately from the name used to
   refer to it within the Compose file:

ネットワーク名として指定する名前は、Compose ファイル内で参照されている名前以外でも指定することができます。

..  networks:
      outside:
        external:
          name: actual-name-of-network

.. code-block:: yaml

   networks:
     outside:
       external:
         name: actual-name-of-network

.. ## configs configuration reference

.. _configs-configuration-reference:

configs 設定リファレンス
=========================

.. The top-level `configs` declaration defines or references
   [configs](/engine/swarm/configs.md) which can be granted to the services in this
   stack. The source of the config is either `file` or `external`.

最上位の ``configs`` の宣言では、このスタックファイル内のサービスに対して適用する :doc:`configs </engine/swarm/configs>` を定義し参照します。
config の値となるのは ``file`` か ``external`` です。

.. - `file`: The config is created with the contents of the file at the specified
     path.
   - `external`: If set to true, specifies that this config has already been
     created. Docker will not attempt to create it, and if it does not exist, a
     `config not found` error occurs.

* ``file``： config は、指定されたパスにあるファイルの内容に従って生成されます。
* ``external``： true に設定されている場合、config がすでに定義済であることを設定します。
  Dockder はこれを生成しないようになりますが、config が存在しなければ ``config not found`` というエラーが発生します。
* ``name``： Docker における config オブジェクト名を設定します。
  この設定は、特殊文字を含む config を参照する際に用いることができます。
  name はそのまま用いられ、スタック名によるスコープは **行われません** 。
  これはファイルフォーマットバージョン 3.5 において導入されたものです。

.. In this example, `my_first_config` will be created (as
   `<stack_name>_my_first_config)`when the stack is deployed,
   and `my_second_config` already exists in Docker.

以下の例においては、スタックがデプロイされる際に（``<stack_name>_my_first_config`` として） ``my_first_config`` が生成されます。
また ``my_second_config`` は Docker にすでに定義済のものです。

.. ```none
   configs:
     my_first_config:
       file: ./config_data
     my_second_config:
       external: true
   ```

.. code-block:: yaml

   configs:
     my_first_config:
       file: ./config_data
     my_second_config:
       external: true

.. Another variant for external configs is when the name of the config in Docker
   is different from the name that will exist within the service. The following
   example modifies the previous one to use the external config called
   `redis_config`.

別の状況として、外部にある config を参照する際に、Docker における config 名と、サービス内にある config 名が異なる場合があります。
以下は、前の例における config を、外部に定義されている ``redis_config`` というものに変更した例です。

.. ```none
   configs:
     my_first_config:
       file: ./config_data
     my_second_config:
       external:
         name: redis_config
   ```

.. code-block:: yaml

   configs:
     my_first_config:
       file: ./config_data
     my_second_config:
       external:
         name: redis_config

.. You still need to [grant access to the config](#configs) to each service in the
   stack.

スタック内の各サービスに対しては、:ref:`config へのアクセス許可 <compose-file-configs>` を行う必要があります。

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

