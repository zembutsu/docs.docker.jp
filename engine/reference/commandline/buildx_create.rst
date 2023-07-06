.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_create.md
.. check date: 2022/03/05
.. -------------------------------------------------------------------

=======================================
docker buildx create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Create a new builder instance

新しい :ruby:`ビルダ・インスタンス <builder instance>` を作成します。

使い方
==========

.. code-block:: bash

   $ docker buildx create [OPTIONS] [CONTEXT|ENDPOINT]

.. Extended description

補足説明
==========

.. Create makes a new builder instance pointing to a docker context or endpoint, where context is the name of a context from docker context ls and endpoint is the address for docker socket (eg. DOCKER_HOST value).

docker コンテクストやエンドポイントを指定する、新しいビルダ・インスタンスを作成します。コンテクストとは ``docker context ls`` にあるコンテクスト名であり、エンドポイントとは docker ソケットの場所を示します（例： ``DOCKER_HOST`` の値）。

.. By default, the current Docker configuration is used for determining the context/endpoint value.

デフォルトでは、現在の Docker 設定がコンテクストとエンドポイントの値として使われます。

.. Builder instances are isolated environments where builds can be invoked. All Docker contexts also get the default builder instance.

ビルダ・インスタンスとは、構築を処理時の :ruby:`隔離環境 <isolated environment>` です。全ての Docker コンテクストもまた、デフォルトのビルダー・インスタンスを持っています。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx_create-examples>` をご覧ください。

.. _buildx_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--append``
     - 
     - ビルダを交代するノードを追加
   * - ``--bootstrap``
     - 
     - 作成後のブート・ビルダ
   * - ``--buildkit-flags``
     - 
     - buildkitd デーモン用のフラグ
   * - ``--config``
     - 
     - BuildKit 設定ファイル
   * - ``--driver``
     - 
     - 使用するドライバ（利用可能なもの： ``docker`` 、 ``docker-container`` 、 ``kubernetes`` ）
   * - ``--driver-opt``
     - 
     - ドライバに対するオプション
   * - ``--leave``
     - 
     - ビルダを交代するノードの削除
   * - ``--name``
     - 
     - ビルダ・インスタンス名
   * - ``--node``
     - 
     - 指定した名前でノードを作成・変更
   * - ``--platform``
     - 
     - 現在のノードに対するプラットフォームを指定
   * - ``--use``
     - 
     - 現在のビルダー・インスタンスを指定
   * - ``--builder``
     - 
     - ビルダー・インスタンス設定を上書き

.. _buildx_create-examples:

使用例
==========

.. _buildx_create-append:

.. Append a new node to an existing builder (--append)

既存のビルダーに新しいノードを追加（--append）
--------------------------------------------------

.. The --append flag changes the action of the command to append a new node to an existing builder specified by --name. Buildx will choose an appropriate node for a build based on the platforms it supports.

``--append`` は命令の処理を変更するフラグで、 ``--name`` で指定された既存のビルダーに新しいノードを追加します。Buildx はサポートしているプラットフォームに基づき、適切な構築用のノードを選択します。

.. Examples

使用例
^^^^^^^^^^

.. code-block:: bash

   $ docker buildx create mycontext1
   eager_beaver
   
   $ docker buildx create --name eager_beaver --append mycontext2
   eager_breaver

.. _buildx_create-buildkitd-flags:
.. Specify options for the buildkitd daemon (--buildkitd-flags)

buildkitd デーモンに対するオプションを指定（--buildkitd-flags）
----------------------------------------------------------------------

.. code-block:: bash

   --buildkitd-flags FLAGS

.. Adds flags when starting the buildkitd daemon. They take precedence over the configuration file specified by --config. See buildkitd --help for the available flags.

buildkitd デーモンの起動時にフラグを追加します。これは ``--config`` で指定した設定よりも優先されます。利用可能なフラグは ``buildkitd --help`` をご覧ください。

.. Example

使用例
^^^^^^^^^^

.. code-block:: bash

   --buildkitd-flags '--debug --debugaddr 0.0.0.0:6666'

.. Specify a configuration file for the buildkitd daemon (--config)

buildkitd デーモン用の設定ファイルを指定（--config）
------------------------------------------------------------

.. code-block:: bash

   --config FILE

.. Specifies the configuration file for the buildkitd daemon to use. The configuration can be overridden by --buildkitd-flags. See an example buildkitd configuration file.

buildkitd デーモンが使うための設定ファイルを指定します。この設定は ``--buildkitd-flags`` で上書き出来ます。 `buildkitd 設定ファイルの例 <https://github.com/moby/buildkit/blob/master/docs/buildkitd.toml.md>`_ をご覧ください。

.. Note that if you create a docker-container builder and have specified certificates for registries in the buildkitd.toml configuration, the files will be copied into the container under /etc/buildkit/certs and configuration will be updated to reflect that.

注意が必要なのは、 ``docker-container`` ビルダを作成し、 ``buildkitd.toml`` 設定でレジストリの証明書を指定している場合です。この設定ファイルは、コンテナ内の ``/etc/buildkit/certs`` 以下にコピーされ、更新された設定はそこに反映されます。


.. Set the builder driver to use (--driver)
.. _buildx_create-driver:

使用するビルダ・ドライバを指定（--driver）
--------------------------------------------------

.. code-block:: bash

   --driver DRIVER

.. Sets the builder driver to be used. There are two available drivers, each have their own specificities.

使用するビルダ・ドライバを指定します。複数のドライバが利用可能で、それぞれに設定があります。

.. docker driver

``docker`` ドライバ
^^^^^^^^^^^^^^^^^^^^

.. Uses the builder that is built into the docker daemon. With this driver, the --load flag is implied by default on buildx build. However, building multi-platform images or exporting cache is not currently supported.

ビルダは docker デーモンの中で構築します。ドライバに ``--load`` フラグがあれば、デフォルトの ``buildx build`` を意味します。しかし、マルチプラットフォームのイメージ構築や、既存のキャッシュに対しては、現時点ではサポートしていません。

``docker-container`` ドライバ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Uses a BuildKit container that will be spawned via docker. With this driver, both building multi-platform images and exporting cache are supported.

docker を経由して実行する BuildKit コンテナを使います。このドライバでは、マルチプラットフォーム・イメージと出力されたキャッシュの両方をサポートしています。

.. Unlike docker driver, built images will not automatically appear in docker images and build --load needs to be used to achieve that.

``docker`` ドライバとは異なり、構築イメージは自動的に ``docker images`` に反映されません。また、そこにイメージを反映するには ``build --load`` の指定が必要です。

``kubernetes`` ドライバ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Uses a kubernetes pods. With this driver, you can spin up pods with defined BuildKit container image to build your images.

kubernets ポッドを使います。このドライバでは、イメージ構築構築用に、 BuildKit コンテナイメージを指定したポッドを起動できます。

.. Unlike docker driver, built images will not automatically appear in docker images and build --load needs to be used to achieve that.

``docker`` ドライバとは異なり、構築イメージは自動的に ``docker images`` に反映されません。また、そこにイメージを反映するには ``build --load`` の指定が必要です。

.. _buildx_craete-driver-opt:

.. Set additional driver-specific options (--driver-opt)

ドライバ固有のオプションを追加設定（--driver-opt）
------------------------------------------------------------

.. --driver-opt OPTIONS

.. code-block:: bash

   --driver-opt OPTIONS

.. Passes additional driver-specific options. Details for each driver:

ドライバ固有のオプションを追加します。各ドライバごとの詳細はこちらです。

* ``docker`` … ドライバのオプションはありません。
* ``docker-container`` 

   * ``image=IMAGE`` … buildkit 実行用のコンテナ・イメージを指定します。
   * ``network=NETMODE`` … buildkit コンテナ実行時のネットワーク・モードを指定します。
   * ``cgroup-parent=CGROUP`` … docker が「cgroupfs」ドライバを使用している場合は、buildkit コンテナの親 cgroup を指定します。デフォルトは ``/docker/buildx`` です。

* ``kubernetes``

   * ``image=IMAGE`` … buildkit 実行用のコンテナ・イメージを指定します。
   * ``namespace=NS`` … Kubernetes 名前空間を指定します。デフォルトは現在の名前空間です。
   * ``replicas=N`` … ``Pod`` レプリカ数を指定します。デフォルトは 1 です。
   * ``requests.cpu`` … 要求する CPU の値を、Kubernetes CPU 単位で指定します。例  ``requests.cpu=100m`` 、 ``requests.cpu=2``
   * ``requests.memory`` … 要求するメモリの値を、バイトあるいは有効な単位で指定します。例 ``requests.memory=500Mi`` 、 ````
   * ``limits.cpu`` … CPU 制限値を Kubernetes CPU 単位で指定します。例 ``limits.cpu=100m`` 、 ``limits.cpu=2``
   * ``limits.memory`` … メモリ上限値を、バイトあるいは有効な単位で指定します。例 ``limits.memory=500Mi`` 、 ``limits.memory=4G``
   * ``nodeselector="label1=value1,label2=value2`` … ``Pod``  ノードセレクタの kv （キーと値）を指定します。デフォルトはありません。例 ``nodeselector=kubernetes.io/arch=arm64``
   * ``rootless=(true|false)`` … ``securityContext.privileged`` を使わず、root ではないユーザとしてコンテナを実行します。 `Ubuntu ホスト・カーネルの利用を推奨します。 <https://github.com/moby/buildkit/blob/master/docs/rootless.md>`_ デフォルトは false です。
   * ``loadbalance=(sticky|random)`` … 負荷分散方式を設定します。 ``sticky`` に指定すると、ポッドはパスに含むハッシュを使って選ばれます。デフォルトは ``sticky`` です。
   * ``qemu.install=(true|false)`` … マルチプラットフォームをサポートするため、QEMU エミュレーションをインストールします。
   * ``qemu.image=IMAGE`` … QEMU エミュレーション・イメージを指定します。デフォルトは ``tonistiigi/binfmt:latest`` です。

**例**

.. Use a custom network

カスタム・ネットワークを使用
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: bash

   $ docker network create foonet
   $ docker buildx create --name builder --driver docker-container --driver-opt network=foonet --use
   $ docker buildx inspect --bootstrap
   $ docker inspect buildx_buildkit_builder0 --format={{.NetworkSettings.Networks}}
   map[foonet:0xc00018c0c0]

OpenTelemetry サポート
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To capture the trace to Jaeger, set JAEGER_TRACE environment variable to the collection address using the driver-opt:

`Jaeger <https://github.com/jaegertracing/jaeger>`_ でトレースをキャプチャするには、 ``JAEGER_TRACE`` 環境変数を指定し、 ``driver-opt`` で収集用のアドレス（collection address）を指定します。

.. code-block:: bash

   $ docker run -d --name jaeger -p 6831:6831/udp -p 16686:16686 jaegertracing/all-in-one
   $ docker buildx create --name builder --driver docker-container --driver-opt network=host --driver-opt env.JAEGER_TRACE=localhost:6831 --use
   $ docker buildx inspect --bootstrap
   # buildx command should be traced at http://127.0.0.1:16686/


.. _buildx_create-leave:
.. Remove a node from a builder (--leave)

ビルダをノードから削除（--leave）
----------------------------------------

.. The --leave flag changes the action of the command to remove a node from a builder. The builder needs to be specified with --name and node that is removed is set with --node.

ビルダからノードを削除するには、 ``--leave`` フラグによって命令の処理を変更します。ビルダは ``--name`` の指定が必要であり、削除するノードは ``--node`` の指定が必要です。

.. Examples

**使用例**

.. code-block:: bash

   $ docker buildx create --name mybuilder --node mybuilder0 --leave

.. _buildx_create-name:
.. Specify the name of the builder (--name)

ビルダ名を指定します（--name）
----------------------------------------

.. code-block:: bash

   --name NAME

.. The --name flag specifies the name of the builder to be created or modified. If none is specified, one will be automatically generated.
Specify the name of the node (--node)🔗

``--name`` フラグは、作成もしくは変更するビルダの名前を指定します。 指定がなければ、何らかの名前が自動生成されます。

.. _buildx_create-node:
.. Specify the name of the node (--node)

ノード名を指定（--node）
------------------------------

.. code-block:: bash

   --node NODE

.. The --node flag specifies the name of the node to be created or modified. If none is specified, it is the name of the builder it belongs to, with an index number suffix.

``--node`` フラグは、作成もしくは変更するノードの名前を指定します。 指定がなければ、何らかの名前をインデックス値に基づき自動生成します。

.. Set the platforms supported by the node

ノードがサポートしているプラットフォームを設定
--------------------------------------------------

.. code-block:: bash

   --platform PLATFORMS

.. The --platform flag sets the platforms supported by the node. It expects a comma-separated list of platforms of the form OS/architecture/variant. The node will also automatically detect the platforms it supports, but manual values take priority over the detected ones and can be used when multiple nodes support building for the same platform.

``--platform`` フラグは、ノードがサポートしているプラットフォームを指定します。プラットフォームの形式は OS/アーキテクチャ/派生 のカンマ区切りを想定しています。ノードはサポートしているプラットフォームを自動検出しますが、同じプラットフォームを複数のノードがサポートしている場合、手動でもプラットフォームを優先指定できます。

**使用例**

.. code-block:: bash

   $ docker buildx create --platform linux/amd64
   $ docker buildx create --platform linux/arm64,linux/arm/v8

.. Automatically switch to the newly created builder🔗

新しく作成したビルダに自動的に切り替える
----------------------------------------

.. The --use flag automatically switches the current builder to the newly created one. Equivalent to running docker buildx use $(docker buildx create ...).

``--use`` フラグを使うと、現在のビルダから新しく作成したビルダへと、自動的に切り替えます。これは ``docker buildx use $(docker buildx create ...)`` を実行するのと同等です。

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

   docker buildx create
      https://docs.docker.com/engine/reference/commandline/buildx_create/
