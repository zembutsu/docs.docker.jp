.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/kubernetes/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/kubernetes.md
      https://github.com/docker/docker.github.io/blob/4c9701c26a82253fd20f917784ee4ec644895135/_includes/kubernetes-mac-win.md
.. check date: 2020/06/09
.. Commits on May 20, 2020 a7806de7c56672370ec17c35cf9811f61a800a42
.. -----------------------------------------------------------------------------

.. Deploy on Kubernetes

.. _mac-deploy-on-kubernetes:

========================================
Kubernetes 上にデプロイ
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Desktop includes a standalone Kubernetes server and client, as well as Docker CLI integration. The Kubernetes server runs locally within your Docker instance, is not configurable, and is a single-node cluster.

Docker デスクチップはスタンドアロン Kubernetes サーバとクライアントを含むだけでなく、Docker コマンドライン・インターフェースと統合しています。 Kubernetes サーバはローカルの Docker インスタンス内で実行します。設定の変更はできず、単一ノードのクラスタです。

.. The Kubernetes server runs within a Docker container on your local system, and is only for local testing. When Kubernetes support is enabled, you can deploy your workloads, in parallel, on Kubernetes, Swarm, and as standalone containers. Enabling or disabling the Kubernetes server does not affect your other workloads.

ローカルシステム上の Docker コンテナ内で Kubernetes サーバが稼働します。また、用途はローカルでのテストのみです。Kubernetes サポートを有効化したら、Kubernetes 、 Swarm 、そしてスタンドアロン・コンテナを、それぞれ並列にワークロードをデプロイ可能となります。

.. See Docker Desktop for Mac > Getting started to enable Kubernetes and begin testing the deployment of your workloads on Kubernetes.

Kubernetes を有効化し、 Kubernetes 上にワークロードをデプロイするテストを開始するには、 :ref:`Docker Desktop for Mac > Docker for Mac を始めよう <mac-kubernetes>` を御覧ください。

.. Use Docker commands

.. _mac-use-docker-commands:

Docker コマンドを使う
==============================

.. You can deploy a stack on Kubernetes with docker stack deploy, the docker-compose.yml file, and the name of the stack.

:code:`docker stack deploy` に :code:`docker-compose.yml` ファイルとスタック名を使い、Kubernetes 上にスタックをデプロイ可能です。

.. code-block:: bash

   docker stack deploy --compose-file /path/to/docker-compose.yml mystack
   docker stack services mystack

.. You can see the service deployed with the kubectl get services command.

デプロイしたサービスは :code:`kubectl get services` コマンドで表示できます。

.. Specify a namespace

.. _mac-specify-a-namespace:

名前空間の指定
--------------------

.. By default, the default namespace is used. You can specify a namespace with the --namespace flag.

デフォルトでは :code:`default` namespace （名前空間）が使われます。名前空間は :code:`--namespace` フラグで指定します。

.. code-block:: bash

   docker stack deploy --namespace my-app --compose-file /path/to/docker-compose.yml mystack

.. Run kubectl get services -n my-app to see only the services deployed in the my-app namespace.

:code:`kubectl get services -n my-app` の実行は、 :code:`my-app` 名前空間にデプロイしているサービスのみ表示します。


.. Override the default orchestrator

.. _mac-override-the-default-orchestrator:

デフォルトのオーケストレータを上書き
----------------------------------------

.. While testing Kubernetes, you may want to deploy some workloads in swarm mode. Use the DOCKER_STACK_ORCHESTRATOR variable to override the default orchestrator for a given terminal session or a single Docker command. This variable can be unset (the default, in which case Kubernetes is the orchestrator) or set to swarm or kubernetes. The following command overrides the orchestrator for a single deployment, by setting the variable at the start of the command itself.

Kubernetes でテストをしながら、複数のワークロードを swarm モードにデプロイしたい場合があるでしょう。 :code:`DOCKER_STACK_ORCHESTRATOR` 環境変数を使い、操作中のターミナル・セッションや単一の Docker コマンドで、デフォルトのオーケストレータを上書きします。この環境変数は 設定されていない （デフォルト、この場合はオーケストレータが Kubernetes）か、 :code:`swarm` または :code:`kubernetes` をセットします。以下はコマンドを実行する前に環境変数を設定し、単一デプロイメント用のオーケストレータを上書きするコマンドです。


.. code-block:: bash

   DOCKER_STACK_ORCHESTRATOR=swarm docker stack deploy --compose-file /path/to/docker-compose.yml mystack

.. Alternatively, the --orchestrator flag may be set to swarm or kubernetes when deploying to override the default orchestrator for that deployment.

あるいは、デプロイメント向けのデフォルト・オーケストレータをデプロイ時に上書きする場合は、 :code:`--orchestrator` フラグでも設定できます。


.. code-block:: bash

   docker stack deploy --orchestrator swarm --compose-file /path/to/docker-compose.yml mystack

..    Note
..    Deploying the same app in Kubernetes and swarm mode may lead to conflicts with ports and service names.

.. note::

   Kubernetes と swarm モードで同じアプリをデプロイすると、ポートやサービス名に競合を引き起こす場合があります。

.. Use the kubectl command

.. _mac-use-the-kubectl-command:

kubectl コマンドを使う
==============================

.. The mac Kubernetes integration provides the Kubernetes CLI command at /usr/local/bin/kubectl. This location may not be in your shell’s PATH variable, so you may need to type the full path of the command or add it to the PATH. For more information about kubectl, see the official kubectl documentation. You can test the command by listing the available nodes:

Windows Kubernetes 統合機能により、Kubernetes CLI コマンドが :code:`/usr/local/bin/kubectl` に提供されています。この場所はシェルの :code:`PATH` 変数に入っていない場合があるため、コマンドはフルパスで実行するか、 :code:`PATH` に追加する必要があります。 :code:`kubectl` に関する情報は、 `公式 kubectl ドキュメント <https://kubernetes.io/docs/reference/kubectl/overview/>`_ を御覧ください。コマンドのテストは、利用可能なノード一覧の表示で行えます。

.. code-block:: bash

   kubectl get nodes
   
   NAME                 STATUS    ROLES     AGE       VERSION
   docker-desktop       Ready     master    3h        v1.8.2

.. Example app

.. _mac-kubernetes-example-app:

アプリ例
==========

.. Docker has created the following demo app that you can deploy to swarm mode or to Kubernetes using the docker stack deploy command.

Docker は以下のデモ用アプリケーションを作成しました。 :code:`docker stack deploy` コマンドを使って swarm モードや Kubernetes にデプロイできます。


.. code-block:: yaml

   version: '3.3'
   
   services:
     web:
       image: dockersamples/k8s-wordsmith-web
       ports:
        - "80:80"
   
     words:
       image: dockersamples/k8s-wordsmith-api
       deploy:
         replicas: 5
         endpoint_mode: dnsrr
         resources:
           limits:
             memory: 50M
           reservations:
             memory: 50M
   
     db:
       image: dockersamples/k8s-wordsmith-db

.. If you already have a Kubernetes YAML file, you can deploy it using the kubectl command.

既に Kubernetes YAML ファイルがある場合は、 :code:`kubectl` コマンドを使ってデプロイできます。


.. seealso:: 

   Deploy on Kubernetes
      https://docs.docker.com/docker-for-mac/kubernetes/
