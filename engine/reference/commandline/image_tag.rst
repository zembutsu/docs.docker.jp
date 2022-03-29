.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/image_tag/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/image_tag.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_image_tag.yaml
.. check date: 2022/03/28
.. Commits on Mar 22, 2018 cb157b3318eac0a652a629ea002778ca3d8fa703
.. -------------------------------------------------------------------

.. docker image tag

=======================================
docker image tag
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _image_tag-description:

説明
==========

.. Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE

:ruby:`対象イメージ <TARGET_IMAGE>` に :ruby:`元イメージ <SOURCE_IMAGE>` を参照する :ruby:`タグ <tag>` を作成します。

.. _image_tag-usage:

使い方
==========

.. code-block:: bash

   $ docker image tag SOURCE_IMAGE[:TAG] TARGET_IMAGE[:TAG]


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

   docker image tag
      https://docs.docker.com/engine/reference/commandline/image_tag/
