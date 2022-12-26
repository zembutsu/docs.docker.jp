.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_build/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_build.md
.. check date: 2022/03/04
.. -------------------------------------------------------------------

.. build

=======================================
docker buildx build
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Start a build

構築を開始します。

使い方
==========

.. code-block:: bash

   $ docker buildx build [OPTIONS] PATH | URL | -

.. Extended description

補足説明
==========

.. The buildx build command starts a build using BuildKit. This command is similar to the UI of docker build command and takes the same flags and arguments.

``buildx build`` コマンドは BuidKit を使って構築を開始します。このコマンドは ``docker build`` コマンドの見た目と似ており、いくつかのフラグや引数が同じです。

.. For documentation on most of these flags, refer to the docker build documentation. In here we’ll document a subset of the new flags.

ほとんどのフラグに関するドキュメントは :doc:`docker build のドキュメント <build>` をご覧ください。ここでは新しいフラグのサブセットを説明します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx_build-examples>` をご覧ください。

.. _buildx_build-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--add-host``
     - 
     - 任意のホストに対し IP を割り当てを追加（書式： ``host:ip`` ）
   * - ``--allow``
     - 
     - :ruby:`拡張特権資格 <extra privileged entitlement>` を許可（例： ``network.host`` , ``security.insecure`` ）
   * - ``--build-arg``
     - 
     - 構築時の変数を設定
   * - ``--cache-from``
     - 
     - 外部キャッシュのソース（例： ``ser/app:cache`` , ``type=local,src=path/to/dir`` ）
   * - ``--cache-to``
     - 
     - 外部キャッシュの宛先（例： ``ser/app:cache`` , ``type=local,src=path/to/dir`` ）
   * - ``--cgroup-parent``
     - 
     - コンテナに対する任意の親 cgroup
   * - ``--compress``
     - 
     - 構築コンテクストを gzip を使って圧縮
   * - ``--cpu-period``
     - 
     - CPU CFS (completely Fair Scheduler)期間を制限
   * - ``--cpu-quota``
     - 
     - CPU CFS (completely Fair Scheduler)クォータを制限
   * - ``--cpu-shares`` 、 ``-c``
     - 
     - CPU :ruby:`配分 <share>` （相対ウェイト）
   * - ``--cpuset-cpus``
     - 
     - アクセスを許可する CPU を指定（ 0-3, 0, 1 ）
   * - ``--cpuset-mems``
     - 
     - アクセスを許可するメモリノードを指定（ 0-3, 0, 1 ）
   * - ``--file`` 、 ``-f``
     - 
     - Dockerfile の名前（デフォルトは ``パス/Dockerfile`` ）
   * - ``--force-rm``
     - 
     - 中間コンテナを常に削除
   * - ``--iidfile``
     - 
     - イメージ ID をファイルに書き込む
   * - ``--isolation``
     - 
     - コンテナ分離技術
   * - ``--label``
     - 
     - イメージにメタデータを設定
   * - ``--load``
     - 
     - ``--output=type=docker`` の省略形
   * - ``--memory`` 、 ``-m``
     - 
     - メモリの上限
   * - ``--memory-swap``
     - 
     - スワップの上限は、メモリとスワップの合計と同じ： ``-1`` はスワップを無制限にする
   * - ``--metadata-file``
     - 
     - 構築結果のメタデータをファイルに書き込む
   * - ``--network``
     - 
     - 構築中の RUN 命令で使うネットワークモードを指定
   * - ``--no-cache``
     - 
     - イメージの構築時にキャッシュを使用しない
   * - ``--output`` 、 ``-o``
     - 
     - アウトプット先を指定（書式：type=local,dest=path）
   * - ``--platform``
     - 
     - サーバがマルチプラットフォーム対応であれば、プラットフォームを指定
   * - ``--progress``
     - ``auto``
     - 進行状況の出力タイプを設定（auto、plain、tty）。plain を使うと、コンテナの出力を表示
   * - ``--pull``
     - 
     - イメージは、常に新しいバージョンのダウンロードを試みる
   * - ``--push``
     - 
     - ``--output=type=registry`` の省略形
   * - ``--quiet`` 、 ``-q``
     - 
     - 構築時の出力と成功時のイメージ ID 表示を抑制
   * - ``--rm``
     - ``true``
     - 構築に成功後、中間コンテナを削除
   * - ``--secret``
     - 
     - 構築時に利用するシークレットファイル（書式： ``id=mysecret,src=/local/secret`` ）
   * - ``--security-opt``
     - 
     - セキュリティのオプション
   * - ``--shm-size``
     - 
     - ``/dev/shm`` の容量
   * - ``--squash``
     - 
     - 構築するレイヤを、単一の新しいレイヤに :ruby:`押し込む <squash>`
   * - ``--ssh``
     - 
     - 構築時に利用する SSH エージェントのソケットやキー（書式： ``default | <id>[=<socket>] | <key>[,<key>]]`` ）
   * - ``--tag`` 、 ``-t``
     - 
     - 名前と、オプションでタグを ``名前:タグ`` の形式で指定
   * - ``--target``
     - 
     - 構築する対象の構築ステージを指定
   * - ``--ulimit``
     - 
     - ulimit オプション
   * - ``--builder``
     - 
     - ビルダー・インスタンス設定を上書き

.. _buildx_build-examples:

使用例
==========

.. Override the configured builder instance (--builder)

builder 対象の設定を上書き (--builder)
----------------------------------------

.. Same as buildx --builder.

``buildx --builder`` と同じです。

.. Set the target platforms for the build (--platform)

構築対象のプラットフォームを指定
----------------------------------------

.. code-block:: bash

   --platform=value[,value]

.. Set the target platform for the build. All FROM commands inside the Dockerfile without their own --platform flag will pull base images for this platform and this value will also be the platform of the resulting image. The default value will be the current platform of the buildkit daemon.

構築対象のプラットフォームを指定します。Dockerfile 内にある全ての ``FROM`` 命令は、 ``--platform`` フラグがなければ、自身のプラットフォーム用のイメージを取得します。そして、最終的なイメージのプラットフォームも自身のものとなります。デフォルトの値は、buidkit デーモンが動作しているプラットフォームです。

.. When using docker-container driver with buildx, this flag can accept multiple values as an input separated by a comma. With multiple values the result will be built for all of the specified platforms and joined together into a single manifest list.

``buildx`` で ``docker-container`` ドライバを使う場合は、フラグに対してカンマ区切りで複数の値を指定できます。複数の値を指定した結果は、指定したプラットフォームすべてに対して構築し、1つのマニフェストリストに連結します。

.. If the Dockerfile needs to invoke the RUN command, the builder needs runtime support for the specified platform. In a clean setup, you can only execute RUN commands for your system architecture. If your kernel supports binfmt_misc launchers for secondary architectures, buildx will pick them up automatically. Docker desktop releases come with binfmt_misc automatically configured for arm64 and arm architectures. You can see what runtime platforms your current builder instance supports by running docker buildx inspect --bootstrap.

``Dockerfile`` で ``RUN`` 命令を実行する必要がある場合、ビルダは指定したプラットフォーム用のランタイムをサポートする必要があります。クリーンセットアップの場合、ビルダは自らのシステムアーキテクチャ用のランタイムのサポートが必要です。カーネルが `binfmt_misc <https://en.wikipedia.org/wiki/Binfmt_misc>`_ ランチャーをセカンダリ・アーキテクチャとしてサポートしている場合、buildx はそれらを自動的に対応します。Docker デスクトップ版は ``binfmt_misc`` を備えており、 ``arm64`` と ``arm`` アーキテクチャに自動的に対応しています。現在のビルダ・インスタンスが対応しているランタイム・プラットフォームを確認するには、 ``docker buildx inspect --bootstrap`` を実行します。

.. Inside a Dockerfile, you can access the current platform value through TARGETPLATFORM build argument. Please refer to the docker build documentation for the full description of automatic platform argument variants .

``Dockerfile`` 内では、 ``TARGETPLATFORM `` build 引数よって現在のプラットフォーム値を取得できます。自動プラットフォーム引数の種類は、 :ref:`docker build ドキュメント <automatic-platform-args-in-the-global-scope>`  をご覧ください。

.. The formatting for the platform specifier is defined in the containerd source code.

プラットフォームの指定形式は `containerd ソースコード <https://github.com/containerd/containerd/blob/v1.4.3/platforms/platforms.go#L63>`_ で定義されています。

使用例
^^^^^^^^^^

.. code-block:: bash

   $ docker buildx build --platform=linux/arm64 .
   $ docker buildx build --platform=linux/amd64,linux/arm64,linux/arm/v7 .
   $ docker buildx build --platform=darwin .

.. Set type of progress output (--progress)

.. _buildx_build-progress:

進捗の出力形式を指定（--progress）
----------------------------------------

.. code-block:: bash

  --progress=VALUE

.. Set type of progress output (auto, plain, tty). Use plain to show container output (default “auto”).

進捗の出力形式を指定します（ auto、plain、tty）。plain を使うとコンテナの出力を表示します（デフォルトは ``auto`` ）。

.. You can also use the BUILDKIT_PROGRESS environment variable to set its value.

.. note::

   値を指定するには、``BUILDKIT_PROGRESS`` 環境変数の値も利用できます。

.. The following example uses plain output during the build:

以下は、構築中に ``plain`` 出力を使う例です。

.. code-block:: bash

   $ docker buildx build --load --progress=plain .
   
   #1 [internal] load build definition from Dockerfile
   #1 transferring dockerfile: 227B 0.0s done
   #1 DONE 0.1s
   #2 [internal] load .dockerignore
   #2 transferring context: 129B 0.0s done
   #2 DONE 0.0s
   ...

.. Set the export action for the build result (-o, --output)

.. _buildx_build-output:

構築結果の出力方法を指定（-o, --output）
----------------------------------------

.. code-block:: bash

   -o, --output=[PATH,-,type=TYPE[,KEY=VALUE]

.. Sets the export action for the build result. In docker build all builds finish by creating a container image and exporting it to docker images. buildx makes this step configurable allowing results to be exported directly to the client, oci image tarballs, registry etc.

build 結果の出力処理を設定します。 ``docker build`` で全ての構築が終わると、コンテナのイメージを作成し、それを ``docker images`` に出力します。 ``buildx`` ではこの手順が設定できるようになっており、処理結果を直接クライアントや、oci イメージ・tar ボールやレジストリ等に出力できます。

.. Buildx with docker driver currently only supports local, tarball exporter and image exporter. docker-container driver supports all the exporters.

Buildx の ``docker`` ドライバが現時点でサポートしているのは、 local 、 :ruby:`tar ボール・エクスポータ <tarball exporter>` と :ruby:`イメージ・エクスポータ <image exporter>` のみです。 ``docker-container`` ドライバは全てのエクスポータをサポートします。

.. If just the path is specified as a value, buildx will use the local exporter with this path as the destination. If the value is “-“, buildx will use tar exporter and write to stdout.

値にパスを指定した場合には、 ``buidx`` は :ruby:`ローカル・エクスポータ <local exporter>` でこのパスを出力先に使います。もしも値が「-」であれば、 ``buildx`` は ``tar`` エクスポータを使い ``stdout`` に書き出します。

**使用例**

.. code-block:: bash

   $ docker buildx build -o . .
   $ docker buildx build -o outdir .
   $ docker buildx build -o - - > out.tar
   $ docker buildx build -o type=docker .
   $ docker buildx build -o type=docker,dest=- . > myimage.tar
   $ docker buildx build -t tonistiigi/foo -o type=registry

サポートしているエクスポータは以下の通りです。

``local``
^^^^^^^^^^

.. The local export type writes all result files to a directory on the client. The new files will be owned by the current user. On multi-platform builds, all results will be put in subdirectories by their platform.

``local`` エクスポート型は、全ての結果をクライアント上のディレクトリにあるファイルへ書き出します。新しいファイルの所有者は現在のユーザになります。マルチプラットフォーム・ビルドでは、各プラットフォーム用のサブディレクトリに結果が出力されます。

.. Attribute key:

属性のキー：

..    dest - destination directory where files will be written

* ``dest`` - ファイル出力先のディレクトリ


tar
^^^^^^^^^^

.. The tar export type writes all result files as a single tarball on the client. On multi-platform builds all results will be put in subdirectories by their platform.

``tar`` エクスポート型は、全ての結果をクライアント上の tar ボールに書き出します。マルチプラットフォーム・ビルドでは、各プラットフォーム用のサブディレクトリに結果が出力されます。

.. Attribute key:

属性のキー：

..    dest - destination path where tarball will be written. “-” writes to stdout.

* ``dest`` - tar ボール出力先のディレクトリ。 ``-`` は標準出力に書き出す

``oci``
^^^^^^^^^^

.. The oci export type writes the result image or manifest list as an OCI image layout tarball on the client.

``oci`` エクスポート型は、全ての結果をクライアント上の `OCI イメージ・レイアウト <https://github.com/opencontainers/image-spec/blob/v1.0.1/image-layout.md>`_ に書き出します。

.. Attribute key:

属性のキー：

..    dest - destination path where tarball will be written. “-” writes to stdout.

* ``dest`` - tar ボール出力先のディレクトリ。 ``-`` は標準出力に書き出す

.. _buildx_build-docker:

``docker``
^^^^^^^^^^^

.. The docker export type writes the single-platform result image as a Docker image specification tarball on the client. Tarballs created by this exporter are also OCI compatible.

``docker`` エクスポート型は、特定のプラットフォームに対する `Docker イメージ仕様 <https://github.com/docker/docker/blob/v20.10.2/image/spec/v1.2.md>`_ のイメージとしてクライアント上に書き出します。このエクスポータによって作成される tar ボールは、 OCI 互換性もあります。

.. Currently, multi-platform images cannot be exported with the docker export type. The most common usecase for multi-platform images is to directly push to a registry (see registry).

現時点では、マルチプラットフォーム・イメージは ``docker`` エクスポート型はでは出力できません。マルチプラットフォーム対応イメージの最も一般的な利用方法は、レジストリに直接送信する場合です（ :ref:`registry <buildx_build-registry>` をご覧ください。）。

.. Attribute keys:

属性のキー：

..    dest - destination path where tarball will be written. If not specified the tar will be loaded automatically to the current docker instance.
    context - name for the docker context where to import the result

* ``dest`` - tarボール出力先のパス。このパスの指定が無い場合、tar は現在の Docker インスタンスへ自動的に読み込む
* ``context`` -  結果をインポートする docker コンテクスト名です

.. _buildx_build-image:

``image``
^^^^^^^^^^

.. The image exporter writes the build result as an image or a manifest list. When using docker driver the image will appear in docker images. Optionally, image can be automatically pushed to a registry by specifying attributes.

``image`` エクスポータは、構築結果をイメージまたはマニフェストリストとして出力します。 ``docker`` ドライバでイメージを使う場合は、docker イメージとして出力されます。オプションとして、属性の指定によってイメージを自動的にレジストリに送信できます。

.. Attribute keys:

属性のキー：

..    name - name (references) for the new image.
    push - boolean to automatically push the image.

* ``name`` - 新しいイメージの名前（リファレンス）
* ``push`` - 自動的にイメージを送信するかどうかを bollean（0か1）で指定

.. _buildx_build-registry:

``registry``
^^^^^^^^^^^^^^^^^^^^

.. The registry exporter is a shortcut for type=image,push=true.

``registry`` エクスポータは ``type=image,push=true`` の省略形です。

.. Push the build result to a registry (--push)

.. _buildx_build-push:

構築結果をレジストリに送信（--push）
----------------------------------------

.. Shorthand for --output=type=registry. Will automatically push the build result to registry.

:ref:`--output=type=registry <buildx_build-registry>` の省略形です。構築結果をレジストリに自動送信します。

.. Load the single-platform build result to docker images (--load)

.. _buildx_build-load:

単一プラットフォームの構築結果を ``docker images`` に読み込む（--load）
--------------------------------------------------------------------------------

.. Shorthand for --output=type=docker. Will automatically load the single-platform build result to docker images.

:ref:`--output=type=docker <buildx_build-docker>` の省略形です。単一プラットフォーム向けの構築結果を ``docker images`` に読み込みます。

.. _buildx_build-cache-from:

.. Use an external cache source for a build (--cache-from)

構築用に外部のキャッシュソースを使用（--cache-from）
------------------------------------------------------------

.. code-block:: bash

  --cache-from=[NAME|type=TYPE[,KEY=VALUE]]

.. Use an external cache source for a build. Supported types are registry, local and gha.

構築用に外部のキャッシュソースを使います。サポートしている型は ``registry`` 、 ``local`` 、``gha`` です。

..    registry source can import cache from a cache manifest or (special) image configuration on the registry.
    local source can import cache from local files previously exported with --cache-to.
    gha source can import cache from a previously exported cache with --cache-to in your GitHub repository


- ``registry`` … `registry ソース <https://github.com/moby/buildkit#registry-push-image-and-cache-separately>`_ は、キャッシュ・マニフェストやレジストリ上の（特別な）設定からキャシュを取り込めます。
- ``local`` … `local ソース <https://github.com/moby/buildkit#local-directory-1>`_ は、以前に ``--cache-to`` で出力済みのロールファイルから、キャッシュを取り込めます。
- ``gha`` … `gha ソース <https://github.com/moby/buildkit#github-actions-cache-experimental>`_ は、以前に ``--cache-to`` で GitHub リポジトリに出力済みのキャッシュから、キャッシュを取り込めます。

.. If no type is specified, registry exporter is used with a specified reference.

型（タイプ）を指定しなければ、 ``registry`` エクスポータが指定された参照先として使われます。

.. docker driver currently only supports importing build cache from the registry.

``docker`` ドライバでは、現時点でサポートしているのは、レジストリからの構築キャッシュ取り込みだけです。

.. Examples

使用例
^^^^^^^^^^

.. code-block:: bash

   $ docker buildx build --cache-from=user/app:cache .
   $ docker buildx build --cache-from=user/app .
   $ docker buildx build --cache-from=type=registry,ref=user/app .
   $ docker buildx build --cache-from=type=local,src=path/to/cache .
   $ docker buildx build --cache-from=type=gha .

.. More info about cache exporters and available attributes: https://github.com/moby/buildkit#export-cache

キャッシュエクスポータと利用可能な属性については、こちらをご覧ください：https://github.com/moby/buildkit#export-cache

.. _buildx_build-cache-to:

.. Export build cache to an external cache destination (--cache-to)

構築キャッシュを外部のキャッシュ先へ出力（--cache-to）
------------------------------------------------------------

.. code-block:: bash

   --cache-to=[NAME|type=TYPE[,KEY=VALUE]]

.. Export build cache to an external cache destination. Supported types are registry, local, inline and gha.

外部のキャッシュ先に構築キャッシュを出力します。サポートしている型は ``registry`` 、 ``local`` 、 ``inline`` 、 ``gha`` です。

..    registry type exports build cache to a cache manifest in the registry.
    local type type exports cache to a local directory on the client.
    inline type type writes the cache metadata into the image configuration.
    gha type type exports cache through the Github Actions Cache service API.

* ``registry`` … `registry 型 <https://github.com/moby/buildkit#registry-push-image-and-cache-separately>`_ は、構築キャッシュをレジストリ内のキャッシュ・マニフェストに出力します。
* ``local`` … `local 型 <https://github.com/moby/buildkit#local-directory-1>`_ は、クライアント上のローカルディレクトリへキャッシュを出力します。
* ``inline`` … `inline 型 <https://github.com/moby/buildkit#inline-push-image-and-cache-together>`_ は、イメージ設定内部のキャッシュ・メタデータに出力します。
* ``gha`` … `gha 型 <https://github.com/moby/buildkit#github-actions-cache-experimental>`_ は `Github Actions Cache service API <https://github.com/tonistiigi/go-actions-cache/blob/master/api.md#authentication>`_ を通してキャッシュを出力します。

.. docker driver currently only supports exporting inline cache metadata to image configuration. Alternatively, --build-arg BUILDKIT_INLINE_CACHE=1 can be used to trigger inline cache exporter.

``docker`` ドライバが現時点でサポートしているのは、イメージ設定内部のキャッシュ・メタデータに直接（インラインに）出力するだけです。別の方法として、 ``--build-arg BUILDKIT_INLINE_CACHE=1`` をインライン・キャッシュ・エクスポータのトリガとして使えます。

.. Attribute key:

属性のキー：

.. mode - Specifies how many layers are exported with the cache. min on only exports layers already in the final build stage, max exports layers for all stages. Metadata is always exported for the whole build.

* ``mode`` … キャッシュがどれだけのレイヤに対応するかを指定します。 ``min`` は最終構築ステージのレイヤのみ出力します。 ``max`` は全ステージのレイヤを出力します。メタデータは構築全体を通し、常に出力します。

使用例
^^^^^^^^^^

.. code-block:: bash

   $ docker buildx build --cache-to=user/app:cache .
   $ docker buildx build --cache-to=type=inline .
   $ docker buildx build --cache-to=type=registry,ref=user/app .
   $ docker buildx build --cache-to=type=local,dest=path/to/cache .
   $ docker buildx build --cache-to=type=gha .

.. More info about cache exporters and available attributes: https://github.com/moby/buildkit#export-cache

キャッシュ・エクスポータと利用可能な属性については、 `https://github.com/moby/buildkit#export-cache <https://github.com/moby/buildkit#export-cache>`_ をご覧ください。

.. _buildx_build-allow:

:ruby:`拡張特権資格 <extra privileged entitlement>` を許可（--allow）
----------------------------------------------------------------------

.. code-block:: bash

   --allow=ENTITLEMENT

.. Allow extra privileged entitlement. List of entitlements:

:ruby:`拡張特権資格 <extra privileged entitlement>` を許可します。資格（entitlement）の一覧はこちらです：

..    network.host - Allows executions with host networking.
    security.insecure - Allows executions without sandbox. See related Dockerfile extensions.

* ``network.host`` … ホストネットワーク機能の実行を許可します。
* ``security.insecure`` … サンドボックス無しでの実行を許可。 `関連する Dockerfile 拡張 <https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/experimental.md#run---securityinsecuresandbox>`_ をご覧ください。

.. For entitlements to be enabled, the buildkitd daemon also needs to allow them with --allow-insecure-entitlement (see create --buildkitd-flags)

資格の有効化には、 ``buildkit`` デーモンも ``--allow-insecure-entitlement`` を許可する必要があります（ :ref:`create --buildkit-flags <buildx_create-buildkit-flags>` をご覧ください）。

.. Examples

使用例
^^^^^^^^^^

.. code-block:: bash

   $ docker buildx create --use --name insecure-builder --buildkitd-flags '--allow-insecure-entitlement security.insecure'
   $ docker buildx build --allow security.insecure .

.. _buildx_build-shm-size:

.. Size of /dev/shm (--shm-size)

``/dev/shm`` の容量（--shm-size）
----------------------------------------

.. The format is <number><unit>. number must be greater than 0. Unit is optional and can be b (bytes), k (kilobytes), m (megabytes), or g (gigabytes). If you omit the unit, the system uses bytes.

書式は ``<数値><単位>`` です。 ``数値`` は ``0`` より大きい必要があります。単位はオプションで指定でき、 ``b`` （バイト）、 ``k`` （キロバイト）、 ``m`` （メガバイト）、 ``g`` （ギガバイト）が使えます。単位を省略すると、システムはバイトとして扱います。

.. _buildx_build-ulimit:

..  Set ulimits (--ulimit)

ulimit の設定（--ulimit）
------------------------------

.. --ulimit is specified with a soft and hard limit as such: <type>=<soft limit>[:<hard limit>], for example:

``--ulimit`` は :ruby:`ソフトリミット <soft limit>` と :ruby:`ハードリミット <hard limit>` を指定します。書式は ``<type>=<ソフトリミット>[:<ハードリミット>]`` です。以下は例です。

.. code-block:: bash

   $ docker buildx build --ulimit nofile=1024:1024 .

..    Note
    If you do not provide a hard limit, the soft limit is used for both values. If no ulimits are set, they are inherited from the default ulimits set on the daemon.

.. note::

   ``hard limit`` を指定しない場合、 ``soft limit`` が両方の値として用いられます。 ``ulimits`` の指定が無ければ、デーモン上のデフォルト ``ulimits`` を継承します。


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`buildx`
     - Docker Buildx


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker buildx bake<buildx_bake>`
     - ファイルから構築
   * - :doc:`docker buildx build<buildx_build>`
     - 構築開始
   * - :doc:`docker buildx create<buildx_create>`
     - 新しいビルダー・インスタンスを作成
   * - :doc:`docker buildx du<buildx_du>`
     - ディスク使用量
   * - :doc:`docker buildx imagetools<buildx_imagetools>`
     - レジストリにあるイメージを操作するコマンド
   * - :doc:`docker buildx inspect<buildx_inspect>`
     - 現在のビルダー・インスタンスを調査
   * - :doc:`docker buildx ls<buildx_ls>`
     - ビルダー・インスタンス一覧
   * - :doc:`docker buildx prune<buildx_prune>`
     - 構築キャッシュの削除
   * - :doc:`docker buildx rm<buildx_rm>`
     - ビルダー・インスタンスの削除
   * - :doc:`docker buildx stop<buildx_stop>`
     - ビルダー・インスタンスの停止
   * - :doc:`docker buildx use<buildx_use>`
     - 現在のビルダー・インスタンスを設定
   * - :doc:`docker buildx version<buildx_version>`
     - buildx バージョン情報を表示



.. seealso:: 

   docker buildx build
      https://docs.docker.com/engine/reference/commandline/buildx_build/
