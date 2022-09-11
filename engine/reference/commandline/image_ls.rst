.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/image_ls/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/image_ls.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_image_ls.yaml
.. check date: 2022/03/28
.. Commits on Dec 9, 2020 3ed725064445f19e836620432ba7522865002da5
.. -------------------------------------------------------------------

.. docker image ls

=======================================
docker image ls
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _image_ls-description:

説明
==========

.. List images

イメージを一覧表示します。

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
     - 全てのイメージを表示（デフォルトは、中間イメージを非表示）
   * - ``--digests``
     - 
     - digest 値を表示
   * - ``--filter`` , ``-f``
     - 
     - 指定した状況に基づき、出力をフィルタ
   * - ``--format``
     - 
     - Go テンプレートを使い、イメージを整えて表示
   * - ``--no-trunc``
     - 
     - 出力を :ruby:`省略しない <truncate>`
   * - ``--quiet`` , ``-q``
     - 
     - イメージ ID のみ表示


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

   docker image ls
      https://docs.docker.com/engine/reference/commandline/image_ls/
