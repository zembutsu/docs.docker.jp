.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/python/deploy/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/language/python/deploy.md
.. check date: 2022/09/30
.. Commits on Sep 29, 2022 561118ec5b1f1497efad536545c0b39aa8026575
.. -----------------------------------------------------------------------------

.. Deploy your app
.. _python-deploy-your-app

========================================
アプリのデプロイ
========================================

.. Now, that we have configured a CI/CD pipleline, let’s look at how we can deploy the application. Docker supports deploying containers on Azure ACI and AWS ECS. You can also deploy your application to Kubernetes if you have enabled Kubernetes in Docker Desktop.

これで CI/CD パイプラインを設定できましたので、アプリケーションのデプロイ方法をみていきましょう。Docker は Azure ACI と AWS ECS にコンテナのデプロイをサポートしています。また、 Docker Desktop で Kubernetes を有効化している場合は、アプリケーションを Kubernetes にもデプロイできます。

.. Docker and Azure ACI
.. _python-docker-and-azure-aci:

Docker と Azure ACI
====================

.. The Docker Azure Integration enables developers to use native Docker commands to run applications in Azure Container Instances (ACI) when building cloud-native applications. The new experience provides a tight integration between Docker Desktop and Microsoft Azure allowing developers to quickly run applications using the Docker CLI or VS Code extension, to switch seamlessly from local development to cloud deployment.

Docker Azure Integration はクラウドネイティブなアプリケーションの構築時、開発者がネイティブな Docker コマンドを使い、 Azure Container Instances (ACI) にアプリケーションをデプロイできるようにします。この新しい体験をもたらすのは Docker Desktop と Microsoft Azure との密接な統合によるもので、 Docker CLI や VS Code extension を使って、ローカル開発とクラウド開発をシームレスに切り替えるため、素早くアプリケーションを実行できるようになります。

.. For detailed instructions, see Deploying Docker containers on Azure.

詳しい手順は :doc:`Azure 上に Docker コンテナをデプロイ </cloud/aci-integration>` をご覧ください。

.. seealso::

   Deploying Docker containers on Azure | Docker Documentation
      https://docs.docker.com/cloud/aci-integration/

.. Docker and AWS ECS
.. _python-docker-and-aws-ecs:

Docker と AWS ECS
====================

.. The Docker ECS Integration enables developers to use native Docker commands in Docker Compose CLI to run applications in Amazon EC2 Container Service (ECS) when building cloud-native applications.

Docker ECS Integration はクラウドネイティブなアプリケーションの構築時、開発者が Docker Compose CLI でネイティブな Docker コマンドを使い、Amazon EC2 Container Service (ECS) にアプリケーションをデプロイできるようにします。

.. The integration between Docker and Amazon ECS allows developers to use the Docker Compose CLI to set up an AWS context in one Docker command, allowing you to switch from a local context to a cloud context and run applications quickly and easily simplify multi-container application development on Amazon ECS using Compose files.

Docker と Amazon ECS 間の統合によって、開発者は Docker Compose CLI を使い、1つの Docker コマンドで AWS コンテクストをセットアップできます。これにより、ローカルのコンテクストとクラウドのコンテクストを切り替えできるようになり、アプリケーションを素早く実行できるようにし、Compose ファイルを使う Amazon ECS 上の複数コンテナアプリケーションの開発を簡単にします。

.. For detailed instructions, see Deploying Docker containers on ECS.

詳しい手順は :doc:`ECS 上に Docker コンテナをデプロイ </cloud/ecs-integration>` をご覧ください。

.. seealso::

   Deploying Docker containers on ECS
      https://docs.docker.com/cloud/ecs-integration/

.. Kubernetes
.. _python-kubernetes:

Kubernetes
--------------------

.. Docker Desktop includes a standalone Kubernetes server and client, as well as Docker CLI integration that runs on your machine. When you enable Kubernetes, you can test your workloads on Kubernetes.

Docker Desktop には独立した Kubernetes サーバとクライアントを持ち、自分のマシン上で Docker CLI と統合して実行できます。Kubernetes を有効化すると、Kubernetes 上で自分のワークロードをテストできるようになります。

.. To enable Kubernetes:

Kubernetes を有効化するには：

..    From the Docker menu, select Preferences (Settings on Windows).

1. Docker メニューから、 **Preferences** を選ぶ（ Windows 上では **Settings** ）

..    Select Kubernetes and click Enable Kubernetes.

2. **Kubernetes** を選び、 **Enable Kubernetes** をクリック

   ..    This starts a Kubernetes single-node cluster when Docker Desktop starts.

   これは Docker Desktop の起動時に Kubernetes 1ノードクラスタを起動します。

.. For detailed information, see Deploy on Kubernetes and Describing apps using Kubernetes YAML.

詳細な情報は、 :doc:`/desktop/kubernetes` と :ref:`describing-apps-using-kubernetes-yaml` をご覧ください。


.. Feedback
.. _python-deploy-feedback:

フィードバック
====================

.. Help us improve this topic by providing your feedback. Let us know what you think by creating an issue in the Docker Docs GitHub repository. Alternatively, create a PR to suggest updates.

フィードバックを通し、このトピックの改善を支援ください。考えがあれば、 `Docker Docs <https://github.com/docker/docs/issues/new?title=[Python%20docs%20feedback]>`_ GitHub リポジトリに issue を作成して教えてください。あるいは、更新の提案のために `RP を作成 <https://github.com/docker/docs/pulls>`_ してください。

.. seealso::

   Deploy your app
      https://docs.docker.com/language/python/deploy/