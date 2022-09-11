.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/context_create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/context_create.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_context_create.yaml
.. check date: 2022/03/18
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker context create

=======================================
docker context create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _context_create-description:

説明
==========

.. Create a context

context を :ruby:`作成 <create>` します。

.. _context_create-usage:

使い方
==========

.. code-block:: bash

   $ docker context create [OPTIONS] CONTEXT

.. Extended description
.. _context_create-extended-description:

補足説明
==========


.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <context_create-examples>` をご覧ください。


.. _context_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--default-stack-orchestrator``
     - 
     - 【:doc:`deprecated </engine/replicated>`】スタックを操作するデフォルトのオーケストレータとして、この context を使う（ swarm | kubernetes | all ）
   * - ``--description``
     - 
     - context の説明
   * - ``--docker``
     - 
     - docker エンドポイントを指定
   * - ``--from``
     - 
     - :ruby:`名前付き <named>` context から context を作成
   * - ``--kubernetes``
     - 
     - 【:doc:`deprecated </engine/replicated>`】【kubernetes】kubernetes エンドポイントを指定


.. _context_craete-examples:

使用例
==========

.. Create a context with a docker and kubernetes endpoint
.. _create-a-context-with-a-docker-and-kubernetes-endpoint:

docker と kubernetes エンドポイントを使い context を作成
------------------------------------------------------------

.. To create a context from scratch provide the docker and, if required, kubernetes options. The example below creates the context my-context with a docker endpoint of /var/run/docker.sock and a kubernetes configuration sourced from the file /home/me/my-kube-config:

指定した docker を使い、ゼロから context を作成します。また、必要があれば kubernetes オプションもあります。以下の例は docker のエンドポイント ``/var/run/docker.sock`` と、 ``/home/me/my-kube-config`` ファイルを元にする kubernetes 設定を使い、 ``my-context`` という名前の context を作成します。

.. code-block:: bash

   $ docker context create \
       --docker host=unix:///var/run/docker.sock \
       --kubernetes config-file=/home/me/my-kube-config \
       my-context

.. Create a context based on an existing context
.. _create-a-context-based-on-an-existing-context:

既存の context を元に context を作成
----------------------------------------

.. Use the --from=<context-name> option to create a new context from an existing context. The example below creates a new context named my-context from the existing context existing-context:

既存の context から新しい context を作成するには、 ``--from=<context-name>`` オプションを使います。以下の例は、既存の context ``existing-context`` から、 ``my-context`` という名前の新しい context を作成します。

.. code-block:: bash

   $ docker context create --from existing-context my-context

.. docker context create --from existing-context my-context

``--from`` オプションの指定がなければ、現在の context から ``context`` を作成します。

.. code-block:: bash

   $ docker context create my-context

.. This can be used to create a context out of an existing DOCKER_HOST based script:

以下は、既存の ``DOCKER_HOST`` の外にあるスクリプトを元に context を作成します。

.. code-block:: bash

   $ source my-setup-script.sh
   $ docker context create my-context

.. To source only the docker endpoint configuration from an existing context use the --docker from=<context-name> option. The example below creates a new context named my-context using the docker endpoint configuration from the existing context existing-context and a kubernetes configuration sourced from the file /home/me/my-kube-config:

``docker`` エンドポイント設定の元（ソース）となるのは、 ``--docker from=<context-name>`` オプションを使った既存の context のみです。以下の例は、 ``my-context`` という名前の context を作成するために、既存の context ``existing-context`` にある docker エンドポイント設定を使い、また、 ``/home/me/my-kube-config`` ファイルを元にする kubernetes 設定を使います。

.. code-block:: bash

   $ docker context create \
       --docker from=existing-context \
       --kubernetes config-file=/home/me/my-kube-config \
       my-context

.. To source only the kubernetes configuration from an existing context use the --kubernetes from=<context-name> option. The example below creates a new context named my-context using the kuberentes configuration from the existing context existing-context and a docker endpoint of /var/run/docker.sock:

``kubernetes`` エンドポイント設定の元（ソース）となるのは、 ``--kubernetes from=<context-name>`` オプションを使った既存の context のみです。以下の例は ``my-context`` という名前の context を作成するため、既存の ``existing-context`` にある kubernetes 設定と、 ``/var/run/docker.sock`` の docker エンドポイント設定を使います。

.. code-block:: bash

   $ docker context create \
       --docker host=unix:///var/run/docker.sock \
       --kubernetes from=existing-context \
       my-context

.. Docker and Kubernetes endpoints configurations, as well as default stack orchestrator and description can be modified with docker context update.

Docker と Kubernetes エンドポイント設定だけでなく、デフォルトの stack オーケストレータと説明は、 ``docker context update`` で更新できます。

.. Refer to the docker context update reference for details.

詳細は :doc:`docker context update リファレンス <context_update>` をご覧ください。


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker context create<context_create>`
     - context を作成
   * - :doc:`docker context export<context_export>`
     - context を tar もしくは kubeconfig ファイルに出力
   * - :doc:`docker context import<context_import>`
     - tar もしくは zip ファイルから context を読み込み
   * - :doc:`docker context inspect<context_inspect>`
     - 1つまたは複数 context の情報を表示
   * - :doc:`docker context ls<context_ls>`
     - context 一覧表示
   * - :doc:`docker context rm<context_rm>`
     - 1つまたは複数 context を削除
   * - :doc:`docker context update<context_update>`
     - context の更新
   * - :doc:`docker context use<context_use>`
     - 現在の docker context を指定

.. seealso:: 

   docker context create
      https://docs.docker.com/engine/reference/commandline/context_create/
