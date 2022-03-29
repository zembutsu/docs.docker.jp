.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/network_inspect/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/network_inspect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_network_inspect.yaml
.. check date: 2022/03/29
.. Commits on Jun 1, 2019 ffe8ffd1e8137160aa342b0552ce8c8d58aaad5b
.. -------------------------------------------------------------------

.. docker network inspect

=======================================
docker network inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _network_inspect-description:

説明
==========

.. Display detailed information on one or more networks

1つまたは複数ネットワークの情報を表示します。

.. API 1.21+
   Open the 1.21 API reference (in a new window)
   The client and daemon API must both be at least 1.21 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.21+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.21 <https://docs.docker.com/engine/api/v1.21/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。

.. _network_inspect-usage:

使い方
==========

.. code-block:: bash

   $ docker network inspect [OPTIONS] NETWORK [NETWORK...]

.. Extended description
.. _network_inspect-extended-description:

補足説明
==========

.. Returns information about one or more networks. By default, this command renders all results in a JSON object.

１つまたは複数のネットワークの情報を返します。デフォルトでは、このコマンドは結果を JSON オブジェクト形式で返します。

.. _network_inspect-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレートを使って出力を整形
   * - ``--force`` , ``-f``
     - 
     - 調査用の冗長な出力



.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network <network>`
     - ネットワークを管理



.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker network connect <network_connect>`
     - コンテナをネットワークに接続
   * - :doc:`docker network craete <network_create>`
     - ネットワーク作成
   * - :doc:`docker network disconnect <network_disconnect>`
     - ネットワークからコンテナを切断
   * - :doc:`docker network inspect <network_inspect>`
     - 1つまたは複数ネットワークの情報を表示
   * - :doc:`docker network ls <network_ls>`
     - ネットワーク一覧表示
   * - :doc:`docker network prune <network_prune>`
     - 使用していないネットワークを全て削除
   * - :doc:`docker network rm <network_rm>`
     - 1つまたは複数ネットワークの削除


.. seealso:: 

   docker network inspect
      https://docs.docker.com/engine/reference/commandline/network_inspect/
