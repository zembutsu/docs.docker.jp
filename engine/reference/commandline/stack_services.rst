.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/stack_services/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/stack_services.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_stack_services.yaml
.. check date: 2022/04/09
.. Commits on Apr 2, 2022 098129a0c12e3a79398b307b38a67198bd3b66fc
.. -------------------------------------------------------------------

.. docker stack services

=======================================
docker stack services
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _stack_services-description:

説明
==========

.. List the services in the stack

タスク内のサービスを一覧表示します。

.. API 1.25+
   Open the 1.25 API reference (in a new window)
   The client and daemon API must both be at least 1.25 to use this command. Use the docker version command on the client to check your client and daemon API versions.

【API 1.25+】このコマンドを使うには、クライアントとデーモン API の両方が、少なくとも `1.25 <https://docs.docker.com/engine/api/v1.25/>`_ の必要があります。クライアントとデーモン API のバージョンを調べるには、 ``docker version`` コマンドを使います。


.. _stack_services-usage:

使い方
==========

.. code-block:: bash

   $ docker stack services [OPTIONS] STACK

.. Extended description
.. _stack_services-extended-description:

補足説明
==========

.. Lists the services that are running as part of the specified stack.

指定したタスクの一部として実行中のサービスを表示します。

..    Note
    This is a cluster management command, and must be executed on a swarm manager node. To learn about managers and workers, refer to the Swarm mode section in the documentation.

.. note::

   これはクラスタ管理コマンドであり、 swarm manager ノードで実行する必要があります。manager と worker について学ぶには、ドキュメント内の :doc:`Swarm モードのセクション </engine/swarm/index>` を参照ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <stack_services-examples>` をご覧ください。

.. _stack_services-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--filter`` , ``-f``
     - 
     - 指定した状況に基づき出力を整形
  * - ``--format``
     - 
     - Go テンプレートを使ってスタックの出力を整形
    * - ``--namespaces``
     - 
     - 【deprecated】【Kubernetes】使用する Kubernetes 名前空間
  * - ``--quiet`` , ``-q``
     - 
     - タスク ID のみ表示
   * - ``--kubeconfig``
     - 
     - 【非推奨】【Kubernetes】Kubernetes 設定ファイル
   * - ``--orchestrator``
     - 
     - 【非推奨】使用するオーケストレータ（ swarm | kubernetes | all）

.. _stack_services-examples:

使用例
==========

.. The following command shows all services in the myapp stack:

以下のコマンドは ``myapp`` スタックの全サービスを表示します。

.. code-block:: bash

   $ docker stack services myapp
   
   ID            NAME            REPLICAS  IMAGE                                                                          COMMAND
   7be5ei6sqeye  myapp_web       1/1       nginx@sha256:23f809e7fd5952e7d5be065b4d3643fbbceccd349d537b62a123ef2201bc886f
   dn7m7nhhfb9y  myapp_db        1/1       mysql@sha256:a9a5b559f8821fe73d58c3606c812d1c044868d42c63817fa5125fd9d8b7b539


.. _stack_services-filtering

フィルタリング
------------------------------

.. The filtering flag (-f or --filter) format is a key=value pair. If there is more than one filter, then pass multiple flags (e.g. --filter "foo=bar" --filter "bif=baz"). Multiple filter flags are combined as an OR filter.

フィルタリング・フラグ（ ``-f`` または ``--filter`` ）の書式は ``key=value`` のペアです。フィルタを何回もしたい場合は、複数のフラグを使います（例： ``-filter "foo=bar" --filter "bif=baz"`` ）。複数のフィルタを指定したら、 ``OR`` （同一条件）フィルタとして連結されます。

.. The following command shows both the web and db services:

以下のコマンドは ``web`` と ``db`` サービスの両方を表示するコマンドです。

.. code-block:: bash

   $ docker stack services --filter name=myapp_web --filter name=myapp_db myapp
   
   ID            NAME            REPLICAS  IMAGE                                                                          COMMAND
   7be5ei6sqeye  myapp_web       1/1       nginx@sha256:23f809e7fd5952e7d5be065b4d3643fbbceccd349d537b62a123ef2201bc886f
   dn7m7nhhfb9y  myapp_db        1/1       mysql@sha256:a9a5b559f8821fe73d58c3606c812d1c044868d42c63817fa5125fd9d8b7b539

.. The currently supported filters are:

現時点でサポートしているフィルタは、次の通りです。


* id / ID ( ``--filter id=7be5ei6sqeye`` や ``--filter ID=7be5ei6sqeye`` )

   * Swarm: サポート
   * Kubernetes: 非サポート

* label ( ``--filter label=key=value`` )

   * Swarm: サポート
   * Kubernetes: サポート

* mode ( ``--filter mode=replicated`` や ``--filter mode=global`` )

   * Swarm: 非サポート
   * Kubernetes: サポート

* name ( ``--filter name=myapp_web`` )

   * Swarm: サポート
   * Kubernetes: サポート

* node ( ``--filter node=mynode`` )

   * Swarm: 非サポート
   * Kubernetes: サポート

* service ( ``--filter service=web`` )

   * Swarm: 非サポート
   * Kubernetes: サポート

.. _stack_services-formatting:
表示形式
----------

.. The formatting options (--format) pretty-prints secret output using a Go template.

表示形式のオプション（ ``--format`` ）は、Go テンプレートを使ってシークレット出力を整形します。

.. Valid placeholders for the Go template are listed below:

Go テンプレートで有効なプレースホルダは以下の通りです。


.. list-table::
   :header-rows: 1

   * - placeholder
     - 説明
   * - ``.ID``
     - タスク ID
   * - ``.Name``
     - タスクイメージ
   * - ``.Mode``
     - サービスモード（ ``replicated`` , ``global`` ）
   * - ``.Replicas``
     - サービスレプリカ
   * - ``.Image``
     - サービスイメージ

.. When using the --format option, the stack services command will either output the data exactly as the template declares or, when using the table directive, includes column headers as well.

``--format`` オプションを指定すると、 ``stack services`` コマンドはテンプレートで宣言した通りにデータを出力するか、 ``table`` 命令を使えばカラム列も同様に表示するかのどちらかです。

.. The following example uses a template without headers and outputs the ID, Mode, and Replicas entries separated by a colon (:) for all services:

以下の例はヘッダ無しのテンプレートを使い、全てのサービスに対する ``ID`` と ``Mode`` と ``Replicas`` のエントリをコロン（ ``:`` ）で区切って出力します。

.. code-block:: bash

   $ docker stack services --format "{{.ID}}: {{.Mode}} {{.Replicas}}"
   
   0zmvwuiu3vue: replicated 10/10
   fm6uf97exkul: global 5/5


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker stack <stack>`
     - Docker stack を管理

.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker stack deploy<stack_deploy>`
     - 新しいスタックをデプロイするか、既存のスタックを更新
   * - :doc:`docker stack ls<stack_ls>`
     - スタックを一覧表示
   * - :doc:`docker stack ps<stack_ps>`
     - スタック内のタスクを一覧表示
   * - :doc:`docker stack rm<stack_rm>`
     - 1つまたは複数スタックを削除
   * - :doc:`docker stack services<stack_services>`
     - タスク内のサービスを一覧表示


.. seealso:: 

   docker stack services
      https://docs.docker.com/engine/reference/commandline/stack_services/
