.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/manifest_rm/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/manifest_rm.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_manifest_rm.yaml
.. check date: 2022/03/28
.. Commits on Dec 9, 2020 3ed725064445f19e836620432ba7522865002da5
.. -------------------------------------------------------------------

.. docker manifest push

=======================================
docker manifest push
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _manifest_rm-description:

説明
==========

.. Delete one or more manifest lists from local storage

ローカルストレージから1つまたは複数のマニフェストリストを削除します。


..    This command is experimental on the Docker client.
    It should not be used in production environments.
    To enable experimental features in the Docker CLI, edit the config.json and set experimental to enabled. You can go here for more information.

.. important::

   **これは Docker クライアントの実験的なコマンドです。**
   
   **プロダクション環境では使うべきではありません。**
   Docker CLI で実験的機能を有効かするには、 :ref:`config.json <configuration-files>` を編集し、 ``experimental`` を ``enabled`` にします。

.. _manifest_rm-usage:

使い方
==========

.. code-block:: bash

   $docker manifest rm MANIFEST_LIST [MANIFEST_LIST...]


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

   docker manifest rm
      https://docs.docker.com/engine/reference/commandline/manifest_rm/
