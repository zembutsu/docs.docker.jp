.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/manifest_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/manifest_inspect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_manifest_inspect.yaml
.. check date: 2022/03/28
.. Commits on Nov 30, 2018 c5c166a74f730c9c7de2d4e1e7687b92568d304e
.. -------------------------------------------------------------------

.. docker manifest inspect

=======================================
docker manifest inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _manifest_inspect-description:

説明
==========

.. Display an image manifest, or manifest list

イメージのマニフェストか、マニフェストリストを表示します。

..    This command is experimental on the Docker client.
    It should not be used in production environments.
    To enable experimental features in the Docker CLI, edit the config.json and set experimental to enabled. You can go here for more information.

.. important::

   **これは Docker クライアントの実験的なコマンドです。**
   
   **プロダクション環境では使うべきではありません。**
   Docker CLI で実験的機能を有効かするには、 :ref:`config.json <configuration-files>` を編集し、 ``experimental`` を ``enabled`` にします。

.. _manifest_inspect-usage:

使い方
==========

.. code-block:: bash

   $ docker manifest create MANIFEST_LIST MANIFEST [MANIFEST...]


.. _manifest_inspect-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--insecure``
     - 
     - 安全ではないレジストリとの通信を許可
   * - ``--verbose`` , ``-v``
     - 
     - レイヤとプラットフォームを含む、追加情報を出力


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker manifest <manifest>`
     - Docker イメージ・マニフェストとマニフェスト一覧を管理


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker manifest annotate <manifest_annotate>`
     - ローカルイメージマニフェストに追加情報を追加
   * - :doc:`docker manifest crate <manifest_create>`
     - ローカルマニフェスト用の注記（annotating）を作成し、レジストリに送信
   * - :doc:`docker manifest inspect <manifest_inspect>`
     - イメージのマニフェストか、マニフェストリストを表示
   * - :doc:`docker manifest push <manifest_push>`
     - マニフェストリストをリポジトリに送信
   * - :doc:`docker manifest rm <manifest_rm>`
     - ローカルストレージから1つまたは複数のマニフェストリストを削除


.. seealso:: 

   docker manifest inspect
      https://docs.docker.com/engine/reference/commandline/manifest_inspect/
