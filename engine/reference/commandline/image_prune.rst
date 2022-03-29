.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/image_prune/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/image_prune.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_image_prune.yaml
.. check date: 2022/03/28
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker image prune

=======================================
docker image prune
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _image_prune-description:

説明
==========

.. Remove unused images

使用していないイメージを削除します。

.. API 1.25+  The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】 このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.30 <https://docs.docker.com/engine/api/v1.30/>`_ の必要があります。クライアントとデーモンの API バージョンを調べるには、クライアント上で ``docker version`` コマンドを使います。

.. Extended description
.. _image_prune-extended-description:

補足説明
==========

.. Remove all dangling images. If -a is specified, will also remove all images not referenced by any container.

全ての :ruby:`宙ぶらりんなイメージ <dangling image>` を削除します。 ``-a`` を指定すると、どのコンテナからも参照されていないイメージも全て削除します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <image_prune-examples>` をご覧ください。


.. _image_ls-usage:

使い方
==========

.. code-block:: bash

   $ docker image ls [OPTIONS] [REPOSITORY[:TAG]]


.. _image_ls-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--all`` , ``-a``
     - 
     - 宙ぶらりんなイメージだけでなく、全ての未使用イメージを削除
   * - ``--filter`` , ``-f``
     - 
     - フィルタする値を指定（例： ``until=<timestamp>`` ）
   * - ``--force`` , ``-f``
     - 
     - 確認のプロンプトを表示しない

.. Examples
.. _image_prune-examples:

使用例
==========

.. Example output:

出力例：

.. code-block:: bash

   $ docker image prune -a
   
   WARNING! This will remove all images without at least one container associated to them.
   Are you sure you want to continue? [y/N] y
   Deleted Images:
   untagged: alpine:latest
   untagged: alpine@sha256:3dcdb92d7432d56604d4545cbd324b14e647b313626d99b889d0626de158f73a
   deleted: sha256:4e38e38c8ce0b8d9041a9c4fefe786631d1416225e13b0bfe8cfa2321aec4bba
   deleted: sha256:4fe15f8d0ae69e169824f25f1d4da3015a48feeeeebb265cd2e328e15c6a869f
   untagged: alpine:3.3
   untagged: alpine@sha256:4fa633f4feff6a8f02acfc7424efd5cb3e76686ed3218abf4ca0fa4a2a358423
   untagged: my-jq:latest
   deleted: sha256:ae67841be6d008a374eff7c2a974cde3934ffe9536a7dc7ce589585eddd83aff
   deleted: sha256:34f6f1261650bc341eb122313372adc4512b4fceddc2a7ecbb84f0958ce5ad65
   deleted: sha256:cf4194e8d8db1cb2d117df33f2c75c0369c3a26d96725efb978cc69e046b87e7
   untagged: my-curl:latest
   deleted: sha256:b2789dd875bf427de7f9f6ae001940073b3201409b14aba7e5db71f408b8569e
   deleted: sha256:96daac0cb203226438989926fc34dd024f365a9a8616b93e168d303cfe4cb5e9
   deleted: sha256:5cbd97a14241c9cd83250d6b6fc0649833c4a3e84099b968dd4ba403e609945e
   deleted: sha256:a0971c4015c1e898c60bf95781c6730a05b5d8a2ae6827f53837e6c9d38efdec
   deleted: sha256:d8359ca3b681cc5396a4e790088441673ed3ce90ebc04de388bfcd31a0716b06
   deleted: sha256:83fc9ba8fb70e1da31dfcc3c88d093831dbd4be38b34af998df37e8ac538260c
   deleted: sha256:ae7041a4cc625a9c8e6955452f7afe602b401f662671cea3613f08f3d9343b35
   deleted: sha256:35e0f43a37755b832f0bbea91a2360b025ee351d7309dae0d9737bc96b6d0809
   deleted: sha256:0af941dd29f00e4510195dd00b19671bc591e29d1495630e7e0f7c44c1e6a8c0
   deleted: sha256:9fc896fc2013da84f84e45b3096053eb084417b42e6b35ea0cce5a3529705eac
   deleted: sha256:47cf20d8c26c46fff71be614d9f54997edacfe8d46d51769706e5aba94b16f2b
   deleted: sha256:2c675ee9ed53425e31a13e3390bf3f539bf8637000e4bcfbb85ee03ef4d910a1
   
   Total reclaimed space: 16.43 MB

.. Filtering
.. _image_prune-filtering:
フィルタリング
--------------------

.. The filtering flag (--filter) format is of “key=value”. If there is more than one filter, then pass multiple flags (e.g., --filter "foo=bar" --filter "bif=baz")

フィルタリングのフラグ（ ``--filter`` ）書式は「key=value」です。複数のフィルタがある場合は、フラグを複数回渡します（例 ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. The currently supported filters are:

現在サポートしているフィルタは、こちらです。

..     until (<timestamp>) - only remove images created before given timestamp
    label (label=<key>, label=<key>=<value>, label!=<key>, or label!=<key>=<value>) - only remove images with (or without, in case label!=... is used) the specified labels.

* until （ ``<timestamp>`` まで ） - 指定したタイムスタンプより前に作成したイメージのみ削除します。
* label （ ``label=<key>`` 、  ``label=<key>=<value>`` 、 ``label!=<key>`` 、 ``label!=<key>=<value>`` ） - 指定したラベルのイメージのみ削除します（または、 ``label!=...`` が使われる場合は、ラベルがない場合 ）

.. The until filter can be Unix timestamps, date formatted timestamps, or Go duration strings (e.g. 10m, 1h30m) computed relative to the daemon machine’s time. Supported formats for date formatted time stamps include RFC3339Nano, RFC3339, 2006-01-02T15:04:05, 2006-01-02T15:04:05.999999999, 2006-01-02Z07:00, and 2006-01-02. The local timezone on the daemon will be used if you do not provide either a Z or a +-00:00 timezone offset at the end of the timestamp. When providing Unix timestamps enter seconds[.nanoseconds], where seconds is the number of seconds that have elapsed since January 1, 1970 (midnight UTC/GMT), not counting leap seconds (aka Unix epoch or Unix time), and the optional .nanoseconds field is a fraction of a second no more than nine digits long.

``until`` でフィルタできるのは Unix タイムスタンプ、日付形式のタイムスタンプ、あるいはデーモンが動作しているマシン上の時刻からの相対時間を、 Go duration 文字列（例： ``10m`` 、 ``1h3-m`` ）で計算します。日付形式のタイムスタンプがサポートしているのは、RFC3339Nano 、 RFC3339 、 ``2006-01-02T15:04:05`` 、 ``2006-01-02T15:04:05.999999999`` 、 ``2006-01-02Z07:00`` 、 ``2006-01-02`` です。タイムスタンプの最後にタイムゾーンオフセットとして ``Z`` か ``+-00:00`` が指定されなければ、デーモンはローカルのタイムゾーンを使います。Unix タイムスタンプを 秒[.ナノ秒] で指定すると、秒数は 1970 年 1 月 1 日（UTC/GMT 零時）からの経過時間ですが、うるう秒（別名 Unix epoch や Unix time）を含みません。また、オプションで、9桁以上  .ナノ秒 フィールドは省略されます。

.. The label filter accepts two formats. One is the label=... (label=<key> or label=<key>=<value>), which removes containers with the specified labels. The other format is the label!=... (label!=<key> or label!=<key>=<value>), which removes containers without the specified labels.

``label`` フィルタは2つの形式に対応します。1つは ``label=...`` （ ``label=<key>`` または ``label=<key>=<value>`` ）であり、指定したラベルを持つイメージを削除します。もう1つの形式は ``label!=...`` （ ``label!=<key>`` または ``label!=<key>=<value>`` ）であり、指定たラベルがないイメージを削除します。

..    Predicting what will be removed
    If you are using positive filtering (testing for the existence of a label or that a label has a specific value), you can use docker image ls with the same filtering syntax to see which images match your filter.
    However, if you are using negative filtering (testing for the absence of a label or that a label does not have a specific value), this type of filter does not work with docker image ls so you cannot easily predict which images will be removed. In addition, the confirmation prompt for docker image prune always warns that all dangling images will be removed, even if you are using --filter.

.. important::

   **何を削除しようとしているか、予測する**
   
   :ruby:`肯定 <positive>` のフィルタを使う場合には（ラベルが存在しているかの確認や、ラベルが特定の値を持っているかの確認）、フィルタにイメージが一致するかどうかは ``docker image ls`` で同様のフィルタ構文が使えます。
   
   しかしながら、 :ruby:`否定 <netavie>` のフィルタを使う場合（ラベルの欠損の確認や、ラベルが特定の値を *持っていない* ことの確認 ）は、 ``docker image ls`` のフィルタとは挙動が異なりますので、どのイメージが削除されるか予測が簡単ではありません。加えて、 ``docker image prune`` の確認プロンプトは、 ``--filter`` を使っていたとしても、全ての削除されるべき宙ぶらりんなイメージの情報も表示します。

.. The following removes images created before 2017-01-04T00:00:00:

以下の例は ``2017-01-04T00:00:00`` 以前に作成されたイメージを削除します。

.. code-block:: bash

   $ docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}'
   
   REPOSITORY          TAG                 IMAGE ID            CREATED AT                      SIZE
   foo                 latest              2f287ac753da        2017-01-04 13:42:23 -0800 PST   3.98 MB
   alpine              latest              88e169ea8f46        2016-12-27 10:17:25 -0800 PST   3.98 MB
   busybox             latest              e02e811dd08f        2016-10-07 14:03:58 -0700 PDT   1.09 MB
   
   $ docker image prune -a --force --filter "until=2017-01-04T00:00:00"
   
   Deleted Images:
   untagged: alpine:latest
   untagged: alpine@sha256:dfbd4a3a8ebca874ebd2474f044a0b33600d4523d03b0df76e5c5986cb02d7e8
   untagged: busybox:latest
   untagged: busybox@sha256:29f5d56d12684887bdfa50dcd29fc31eea4aaf4ad3bec43daf19026a7ce69912
   deleted: sha256:e02e811dd08fd49e7f6032625495118e63f597eb150403d02e3238af1df240ba
   deleted: sha256:e88b3f82283bc59d5e0df427c824e9f95557e661fcb0ea15fb0fb6f97760f9d9
   Total reclaimed space: 1.093 MB
   
   $ docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.ID}}\t{{.CreatedAt}}\t{{.Size}}'
   
   REPOSITORY          TAG                 IMAGE ID            CREATED AT                      SIZE
   foo                 latest              2f287ac753da        2017-01-04 13:42:23 -0800 PST   3.98 MB

.. The following removes images created more than 10 days (240h) ago:

以下の例は 10 日（ ``240h`` ）以前に作成されたイメージを削除します。

.. code-block:: bash

   $ docker images
   
   REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
   foo                 latest              2f287ac753da        14 seconds ago      3.98 MB
   alpine              latest              88e169ea8f46        8 days ago          3.98 MB
   debian              jessie              7b0a06c805e8        2 months ago        123 MB
   busybox             latest              e02e811dd08f        2 months ago        1.09 MB
   golang              1.7.0               138c2e655421        4 months ago        670 MB
   
   $ docker image prune -a --force --filter "until=240h"
   
   Deleted Images:
   untagged: golang:1.7.0
   untagged: golang@sha256:6765038c2b8f407fd6e3ecea043b44580c229ccfa2a13f6d85866cf2b4a9628e
   deleted: sha256:138c2e6554219de65614d88c15521bfb2da674cbb0bf840de161f89ff4264b96
   deleted: sha256:ec353c2e1a673f456c4b78906d0d77f9d9456cfb5229b78c6a960bfb7496b76a
   deleted: sha256:fe22765feaf3907526b4921c73ea6643ff9e334497c9b7e177972cf22f68ee93
   deleted: sha256:ff845959c80148421a5c3ae11cc0e6c115f950c89bc949646be55ed18d6a2912
   deleted: sha256:a4320831346648c03db64149eafc83092e2b34ab50ca6e8c13112388f25899a7
   deleted: sha256:4c76020202ee1d9709e703b7c6de367b325139e74eebd6b55b30a63c196abaf3
   deleted: sha256:d7afd92fb07236c8a2045715a86b7d5f0066cef025018cd3ca9a45498c51d1d6
   deleted: sha256:9e63c5bce4585dd7038d830a1f1f4e44cb1a1515b00e620ac718e934b484c938
   untagged: debian:jessie
   untagged: debian@sha256:c1af755d300d0c65bb1194d24bce561d70c98a54fb5ce5b1693beb4f7988272f
   deleted: sha256:7b0a06c805e8f23807fb8856621c60851727e85c7bcb751012c813f122734c8d
   deleted: sha256:f96222d75c5563900bc4dd852179b720a0885de8f7a0619ba0ac76e92542bbc8
   Total reclaimed space: 792.6 MB
   
   $ docker images
   
   REPOSITORY          TAG                 IMAGE ID            CREATED              SIZE
   foo                 latest              2f287ac753da        About a minute ago   3.98 MB
   alpine              latest              88e169ea8f46        8 days ago           3.98 MB
   busybox             latest              e02e811dd08f        2 months ago         1.09 MB

.. The following example removes images with the label deprecated:

以下の例は ``deprecated`` のラベルを持つイメージを削除します。

.. code-block:: bash

   $ docker image prune --filter="label=deprecated"

.. The following example removes images with the label maintainer set to john:

以下の例は ``maintainer`` のラベルが ``john`` に設定されているイメージを削除します。

.. code-block:: bash

   $ docker image prune --filter="label=maintainer=john"

.. This example removes images which have no maintainer label:

以下の例は ``maintainer`` ラベルがないイメージを削除します。

.. code-block:: bash

   $ docker image prune --filter="label!=maintainer"

.. This example removes images which have a maintainer label not set to john:

以下の例は ``maintainer`` ラベルが ``john`` に設定されていないイメージを削除します。

.. code-block:: bash

   $ docker image prune --filter="label!=maintainer=john"

..    Note
    You are prompted for confirmation before the prune removes anything, but you are not shown a list of what will potentially be removed. In addition, docker image ls does not support negative filtering, so it difficult to predict what images will actually be removed.

.. note::

   ``prune`` で何かを消す前に、確認のプロンプトが表示されますが、どのイメージが削除される可能性があるかは表示されません。加えて、 ``dockare image ls`` は否定のフィルタリングをサポートしていないため、実際に削除されるイメージが何であるかの予測は難しいです。


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker image <image>`
     - イメージの管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker image build <image_build>`
     - Dockerfile からイメージを構築
   * - :doc:`docker image history <image_history>`
     - イメージの履歴を表示
   * - :doc:`docker image import <image_import>`
     - ファイルシステム・イメージを作成するため、tar ボールから内容を :ruby:`取り込み <import>`
   * - :doc:`docker image inspect <image_inspect>`
     - 1つまたは複数イメージの詳細情報を表示
   * - :doc:`docker image load <image_load>`
     - tar アーカイブか標準入力からイメージを :ruby:`読み込み <load>`
   * - :doc:`docker image ls <image_ls>`
     - イメージ一覧表示
   * - :doc:`docker image prune <image_prune>`
     - 使用していないイメージの削除
   * - :doc:`docker image pull <image_pull>`
     - レジストリからイメージやリポジトリを :ruby:`取得 <pull>`
   * - :doc:`docker image push <image_push>`
     - レジストリにイメージやリポジトリを :ruby:`送信 <push>`
   * - :doc:`docker image rm <image_rm>`
     - 1つまたは複数のイメージを削除
   * - :doc:`docker image save<image_save>`
     - 1つまたは複数イメージを tar アーカイブに保存（デフォルトで標準出力にストリーミング）
   * - :doc:`docker image tag<image_tag>`
     - :ruby:`対象イメージ <TARGET_IMAGE>` に :ruby:`元イメージ <SOURCE_IMAGE>` を参照する :ruby:`タグ <tag>` を作成


.. seealso:: 

   docker image prune
      https://docs.docker.com/engine/reference/commandline/image_prune/
