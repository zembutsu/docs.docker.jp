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

