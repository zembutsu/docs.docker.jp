.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/compose-file/build/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/compose-file/build.md
.. check date: 2022/07/23
.. Commits on Jun 28, 2022 18a85dcd9a84b663ece5b3973fb2a4e7c8149571
.. -------------------------------------------------------------------

.. Compose file build reference
.. _compose-file-build-reference:

==============================
Compose ファイル構築リファレンス
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose specification is a platform-neutral way to define multi-container applications. A Compose implementation focusing on development use-case to run application on local machine will obviously also support (re)building application from sources. The Compose Build specification allows to define the build process within a Compose file in a portable way.

Compose 仕様とは、複数のコンテナアプリケーションを定義するための、プラットフォームに中立な手法です。Compose の実装で焦点をあてているのは、ローカルマシン上でアプリケーションを実行する開発の利用例であり、ソースからアプリケーションを構築（および再構築）も明確にサポートしています。 Compose :ruby:`構築仕様 <Build specification>` により、Compose ファイル内の構築手順をポータブルな方法として定義できます。

.. Definitions
.. _compose-spec-build-definitions:

定義
==========

.. Compose Specification is extended to support an OPTIONAL build subsection on services. This section define the build requirements for service container image. Only a subset of Compose file services MAY define such a Build subsection, others being created based on Image attribute. When a Build subsection is present for a service, it is valid for a Compose file to miss an Image attribute for corresponding service, as Compose implementation can build image from source.

Compose Specification （仕様）は、サービス上で ``build`` （構築）サブセクションをオプションでサポートするように拡張されました。このセクションで定義するのは、サービス コンテナ イメージの :ruby:`構築 <build>` 要件を定義します。Compose ファイルの ``services``  サブセットのみ、 ``build`` サブセクションや ``image`` 属性をもとに作成されるその他を定義できます。サービスに ``build`` サブセクションがある場合、Compose 実装はソースからイメージを構築できるため、 Compose ファイルで対応するサービスの ``image`` 属性を見落とす処理も「 :ruby:`有効 <valid>` 」です。

.. Build can be either specified as a single string defining a context path, or as a detailed build definition.

構築の指定は、単一文字列でコンテクストのパスを指定するか、詳細な構築を定義するかのどちらかです。

.. In the former case, the whole path is used as a Docker context to execute a docker build, looking for a canonical Dockerfile at context root. Context path can be absolute or relative, and if so relative path MUST be resolved from Compose file parent folder. As an absolute path prevent the Compose file to be portable, Compose implementation SHOULD warn user accordingly.

前者の場合、パス全体を Docker コンテクストとして使用しますので、このコンテクストのルートで正しい ``Dockerfile`` を探し、docker build を実行します。コンテクストのパスは、絶対パスか相対パスです。なお、相対パスは Compose ファイルの親フォルダを基準にする必要があります。 Compose ファイルを持ち運びできるようにするには、絶対パスは避けるべきであり、 Compose 実装はユーザに対して :ruby:`警告すべきです <SHOULD>` 。

.. In the later case, build arguments can be specified, including an alternate Dockerfile location. This one can be absolute or relative path. If Dockerfile path is relative, it MUST be resolved from context path. As an absolute path prevent the Compose file to be portable, Compose implementation SHOULD warn user if an absolute alternate Dockerfile path is used.

後者の場合、代替する ``Dockerfile`` の場所指定を含む、構築に対する引数を指定できます。これは、絶対パスも相対パスも利用できます。Dockerfile が相対パスの場合は、コンテキストのパスを基準にする :ruby:`必要があります <MUST>` 。 Compose ファイルを持ち運びできるようにするには、絶対パスは避けるべきであり、Dockerfile の代替パスに絶対パスが使われる場合、 Compose 実装はユーザに対して :ruby:`警告すべきです <SHOULD>` 。

.. Consistency with Image
.. _compose-spec-build-consistency-with-image:

イメージの一貫性
====================

.. When service definition do include both Image attribute and a Build section, Compose implementation can’t guarantee a pulled image is strictly equivalent to building the same image from sources. Without any explicit user directives, Compose implementation with Build support MUST first try to pull Image, then build from source if image was not found on registry. Compose implementation MAY offer options to customize this behaviour by user request.

サービス定義に ``image`` 属性と ``build`` セクションの両方がある場合、取得したイメージがソースから構築したイメージと厳密に同じかどうかを、 Compose 実装では保証できません。ユーザから何らかの指示が明示されない限り、 Compose 実装は第一にイメージの取得を試し、レジストリ内にイメージがみつからない場合は、イメージをソースから構築します。Compose 実装はユーザからの要求によって、この挙動をカスタマイズするオプションを提供しても :ruby:構いません <MAY>` 。

.. Publishing built images
.. _compose-spec-build-publishing-build-images:

構築イメージの公開
====================

.. Compose implementation with Build support SHOULD offer an option to push built images to a registry. Doing so, it MUST NOT try to push service images without an Image attribute. Compose implementation SHOULD warn user about missing Image attribute which prevent image being pushed.

構築をサポートする Compose 実装は、構築したイメージのレジストリ :ruby:`送信 <push>`をオプションで :ruby:`サポートすべきです <SHOULD>` 。 ``image`` 属性を持たないイメージの送信を防ぐため、 Compose 実装はユーザに :ruby:`警告すべきです <SHOULD>` 。

.. Compose implementation MAY offer a mechanism to compute an Image attribute for service when not explicitly declared in yaml file. In such a case, the resulting Compose configuration is considered to have a valid Image attribute, whenever the actual raw yaml file doesn’t explicitly declare one.

YAML ファイル内でサービスに対する ``image`` 属性が明示的に宣言されていない場合、Compose 実装はサービスの ``image`` 属性を生成する仕組みを提供しても :ruby:`構いません <MAY>` 。このような挙動をする場合、 ``image`` 属性を持たないサービス イメージの送信を :ruby:`試みてはいけません <MUST NOT>` 。実際の生の YAML ファイルがイメージ属性を明示していなくても、Compose 実装は有効な ``image`` 属性を持っていると見なします。

.. Illustrative sample
.. _compose-spec-build-illustrative-sample:

説明例
==========

.. The following sample illustrates Compose specification concepts with a concrete sample application. The sample is non-normative.

以下の静的なサンプル アプリケーション例を通し、 Compose 仕様の概念を説明します。このサンプルは実用的ではありません。

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       build: ./webapp
   
     backend:
       image: awesome/database
       build:
         context: backend
         dockerfile: ../backend.Dockerfile
   
     custom:
       build: ~/custom

.. When used to build service images from source, such a Compose file will create three docker images:

ソースからサービス イメージを構築する時、このような Compose ファイルによって3つの Docker イメージが作成されます。

..  awesome/webapp docker image is built using webapp sub-directory within Compose file parent folder as docker build context. Lack of a Dockerfile within this folder will throw an error.
    awesome/database docker image is built using backend sub-directory within Compose file parent folder. backend.Dockerfile file is used to define build steps, this file is searched relative to context path, which means for this sample .. will resolve to Compose file parent folder, so backend.Dockerfile is a sibling file.
    a docker image is built using custom directory within user’s HOME as docker context. Compose implementation warn user about non-portable path used to build image.

* ``awesome/webapp`` docker イメージは、 Compose ファイルがある親フォルダ内の  ``webapp`` サブディレクトリを、 docker 構築コンテクストとして使用します。このフォルダ内に ``Dockerfile`` が無い場合は、エラーを起こします。
* ``awesome/database`` docker イメージは、 Compose ファイルがある親フォルダ内の  ``webapp`` サブディレクトリを、 docker 構築コンテクストとして使用します。構築手順を定義するにあたり、 ``backend.Dockerfile`` ファイルを使います。このファイルはコンテクストパスに関連して検索されますので、つまり、このサンプルでは ``..`` が Compose ファイルの親フォルダとして基準となります（解決されます）ので、 ``backend.Dockerfile`` は兄弟のようなファイルと言えます。
*  ``custom`` ディレクトリで、ユーザの HOME （ホームディレクトリ）内を docker コンテクストとして使い、 Docker イメージを構築します。ポータブルではないパスが構築イメージで使われた場合、Compose 実装はユーザに警告します。

.. On push, both awesome/webapp and awesome/database docker images are pushed to (default) registry. custom service image is skipped as no Image attribute is set and user is warned about this missing attribute.

:ruby:`送信 <push>` すると、 ``awesome/webapp`` と ``awesome/database`` の両 Docker イメージが（デフォルトの）レジストリに :ruby:`送信 <push>` されます。 ``custom`` サービスイメージは ``image`` 属性を持たないためスキップされ、ユーザには、この属性が無いと警告します。

.. Build definition
.. _compose-spec-build-build-definition:

build 定義
==========

.. The build element define configuration options that are applied by Compose implementations to build Docker image from source. build can be specified either as a string containing a path to the build context or a detailed structure:

``build`` 要素は、 Docker イメージをソースから構築するために、 Compose 実装によって適用される設定情報のオプションを定義します。 build は、構築コンテクストへのパスを含む文字列か、詳細な構造のどちらかで指定します。

.. code-block:: yaml

   services:
     webapp:
       build: ./dir

.. Using this string syntax, only the build context can be configured as a relative path to the Compose file’s parent folder. This path MUST be a directory and contain a Dockerfile.

この文字列の構文を使うと、 Compose ファイルの親フォルダからの相対パスとしてのみ、構築コンテキストを設定できます。このパスはディレクトリであり、かつ、 ``Dockerfile`` を含む必要があります。

.. Alternatively build can be an object with fields defined as follow

あるいは、 ``build`` は以下のように定義されたフィールドを持つオブジェクトにもできます。

.. context (REQUIRED)
.. _compose-spec-build-context:

context（必須）
--------------------

.. context defines either a path to a directory containing a Dockerfile, or a url to a git repository.

``content`` は Dockerifle を含むディレクトリのパスか、 git リポジトリの url を定義します。

.. When the value supplied is a relative path, it MUST be interpreted as relative to the location of the Compose file. Compose implementations MUST warn user about absolute path used to define build context as those prevent Compose file from being portable.

値が相対パスとして指定される場合、 Compose ファイルの場所からの相対パスと解釈する :ruby:`必要があります <MUST>` 。Comopse ファイルがポータブルにならないのを防ぐため、構築コンテキストの定義で絶対パスが使われる場合、Compose 実装はユーザに対して警告が :ruby:`必要です <MUST>` 。

.. code-block:: yaml

   build:
     context: ./dir

.. dockerfile
.. _compose-spec-build-dockerfile:

dockerfile
----------

.. dockerfile allows to set an alternate Dockerfile. A relative path MUST be resolved from the build context. Compose implementations MUST warn user about absolute path used to define Dockerfile as those prevent Compose file from being portable.

``dockerfile`` は別の Dockerfile を指定できるようにします。相対パスは構築コンテキストを基準とする :ruby:`必要があります <MUST>` 。Compose ファイルがポータブルにならないのを防ぐため、 Dockerfile の定義で絶対パスが使われる場合、 Compose 実装はユーザに警告を出す :ruby:`必要があります <MUST>` 。

.. code-block:: yaml

   build:
     context: .
     dockerfile: webapp.Dockerfile

.. args
.. _compose-spec-build-args:

args
----------

.. args define build arguments, i.e. Dockerfile ARG values.

``args`` は、たとえば Dockerfile の ``ARG`` 値のように構築の引数を指定します。

.. Using following Dockerfile:

以下の Dockerfile を使います：

.. code-block:: yaml

   ARG GIT_COMMIT
   RUN echo "Based on commit: $GIT_COMMIT"

.. args can be set in Compose file under the build key to define GIT_COMMIT. args can be set a mapping or a list:

``args`` は Compose ファイルの ``build`` キー以下で ``GIT_COMMIT`` を定義できます。 ``args`` はマップかリストで指定できます。

.. code-block:: yaml

   build:
     context: .
     args:
       GIT_COMMIT: cdc3b19

.. code-block:: yaml

   build:
     context: .
     args:
       - GIT_COMMIT=cdc3b19

.. Value can be omitted when specifying a build argument, in which case its value at build time MUST be obtained by user interaction, otherwise build arg won’t be set when building the Docker image.

build の引数（args）の指定時に、値を省略できます。その場合、ユーザの操作によって構築時に値の指定が :ruby:`必要です <MUST>` 。そうしなければ、 Docker イメージの構築時に引数が設定されません。

.. code-block:: yaml

   args:
     - GIT_COMMIT

.. ssh
.. _compose-spec-build-ssh:

ssh
----------

.. ssh defines SSH authentications that the image builder SHOULD use during image build (e.g., cloning private repository)

``ssh`` は、イメージ構築中にイメージビルダが :ruby:`使うべき <SHOULD>` SSH 認証を定義します（例：プライベート リポジトリのクローン時）。

.. ssh property syntax can be either:

``ssh`` 属性の構文は、以下どちらかです。

..  default - let the builder connect to the ssh-agent.
    ID=path - a key/value definition of an ID and the associated path. Can be either a PEM file, or path to ssh-agent socket

* `default``` ：ビルダを ssh-agent に接続します。
* ``ID=path`` ：ID と関連するパスをキーバリューで定義します。 `PEM <https://en.wikipedia.org/wiki/Privacy-Enhanced_Mail>`_ ファイルや、 ssh-agent ソケットのパスを指定できます。

.. Simple default sample

シンプルな ``default`` 例：

.. code-block:: yaml

   build:
     context: .
     ssh: 
       - default   # mount the default ssh agent

.. or

または

.. code-block:: yaml

   build:
     context: .
     ssh: ["default"]   # mount the default ssh agent

.. Using a custom id myproject with path to a local SSH key:

任意の ID ``myproject`` にローカルの SSH 鍵のパスを使う場合：

.. code-block:: yaml

   build:
     context: .
     ssh: 
       - myproject=~/.ssh/myproject.pem

.. Image builder can then rely on this to mount SSH key during build. For illustration, BuildKit extended syntax can be used to mount ssh key set by ID and access a secured resource:

イメージビルダは構築期間中に SSH 鍵をマウントできます。具体例として、 BuildKit 拡張構文によって、 ID として設定された SSH 鍵をマウントすると、リソースへ安全なアクセスできます：

``RUN --mount=type=ssh,id=myproject git clone ...``

.. cache_from
.. _compose-spec-build-cache_from:

cache_from
----------

.. cache_from defines a list of sources the Image builder SHOULD use for cache resolution.

``cache_from`` は、イメージビルダがキャッシュの解決に :ruby:`使うべき <SHOULD>` ソースのリストを定義します。

.. Cache location syntax MUST follow the global format [NAME|type=TYPE[,KEY=VALUE]]. Simple NAME is actually a shortcut notation for type=registry,ref=NAME.

キャッシュ場所の構文は、以下のグローバル形式 ``[NAME|type=TYPE[,KEY=VALUE]]`` に従う必要があります。シンプルな ``NAME`` は、実際には ``type=registry,ref=NAME`` と書く形式の省略形です。

.. Compose Builder implementations MAY support custom types, the Compose Specification defines canonical types which MUST be supported:

Compose ビルダの実装は任意のタイプをサポートしても :ruby:`構いません <MAY>` 。Compose 仕様ではサポートしなければ :ruby:`ならない <MUST>` 正式な型を定義しています。

..    registry to retrieve build cache from an OCI image set by key ref

* ``registry`` は、キー ``ref`` によって設定された OCI イメージから構築キャッシュを取得します。

.. code-block:: yaml

   build:
     context: .
     cache_from:
       - alpine:latest
       - type=local,src=path/to/cache
       - type=gha

.. Unsupported caches MUST be ignored and not prevent user from building image.

サポートされていないキャッシュは無視が :ruby:`必要で <MUST>` 、ユーザによるイメージ構築を妨げてはいけません。

.. cache_to
.. _compose-spec-build-cache_to:

cache_to
----------

.. cache_to defines a list of export locations to be used to share build cache with future builds.

``cache_to`` は、以後の構築時に構築キャッシュとして共有するために使えるよう、エクスポートする場所のリストを定義します。

.. code-block:: yaml

   build:
     context: .
     cache_to: 
      - user/app:cache
      - type=local,dest=path/to/cache

.. Cache target is defined using the same type=TYPE[,KEY=VALUE] syntax defined by cache_from.

:ruby:`キャッシュ対象 <cache target>` は :ref:`cache_from <compose-spec-build-cache_from>` で定義された同じ ``type=TYPE[,KEY=VALUE]`` 構文を使って定義できます。

.. Unsupported cache target MUST be ignored and not prevent user from building image.

サポートされていないキャッシュ対象は無視が :ruby:`必要で <MUST>` 、ユーザによるイメージ構築を妨げてはいけません。

.. extra_hosts
.. _compose-spec-build-extra_hosts:

extra_hosts
--------------------

.. extra_hosts adds hostname mappings at build-time. Use the same syntax as extra_hosts.

``extra_hosts`` は構築時に追加のホスト名を割り当てます。 :ref:`extra_hosts <compose-spec-extra_hosts>` と同じ構文です。

.. code-block:: yaml

   extra_hosts:
     - "somehost:162.242.195.82"
     - "otherhost:50.31.209.229"

.. Compose implementations MUST create matching entry with the IP address and hostname in the container’s network configuration, which means for Linux /etc/hosts will get extra lines:

Compose 実装は、コンテナのネットワーク設定内に、 IP アドレスとホスト名の一致するエントリを作成する :ruby:`必要があります <MUST>` 。つまり Linux の ``/etc/hosts`` に行を追加します。

.. code-block:: yaml

   162.242.195.82  somehost
  50.31.209.229   otherhost

.. isolation
.. _compose-spec-build-isolation:

isolation
----------

.. isolation specifies a build’s container isolation technology. Like isolation supported values are platform-specific.

``isolation`` は構築時のコンテナ分離技術を指定します。 :ref:`isolation <compose-spec-isolation>` のように、サポートしている値はプラットフォーム固有です。

.. labels
.. _compose-spec-build-labels:

labels
----------

.. labels add metadata to the resulting image. labels can be set either as an array or a map.

``labels`` は構築成果のイメージにメタデータを追加します。 ``labels`` はアレイ形式かマップ形式のどちらかです。

.. reverse-DNS notation SHOULD be used to prevent labels from conflicting with those used by other software.

他のソフトウェアが使うラベルとの重複を避けるため、逆引き DNS 記法を :ruby:`使うべきです <SHOULD>` 。

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

.. shm_size
.. _compose-spec-build-shm_size:

shm_size
----------

.. shm_size set the size of the shared memory (/dev/shm partition on Linux) allocated for building Docker image. Specify as an integer value representing the number of bytes or as a string expressing a byte value.

``shm_size`` は、Docker イメージ構築時に割り当てる共有メモリの容量（ Linux 上の ``/dev/shm`` パーティション ）を設定します。設定はバイトを整数値で指定するか、 :ref:`バイト値 <compose-spec-specifying-byte-values>` の文字列で表現します。

.. code-block:: yaml

   build:
     context: .
     shm_size: '2gb'

.. code-block:: yaml

   build:
     context: .
     shm_size: 10000000

.. target
.. _compose-spec-build-target:

target
----------

.. target defines the stage to build as defined inside a multi-stage Dockerfile.

``target`` は、マルチステージ ``Dockerfile`` 内で定義されている :ruby:`構築ステージ <build stage>` を定義します。

.. code-block:: yaml

   build:
     context: .
     target: prod

.. Implementations
.. _compose-spec-build-implementations:

実装
==========

..  docker-compose
    buildX bake

* :doc:`Docker Compose </compose/index>` 
* :doc:`buildX bake </buildx/working-with-buildx>` 

.. seealso:: 

   Compose file build reference
      https://docs.docker.com/compose/compose-file/build/
