.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/swarm_at_scale/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/swarm_at_scale/index.md
   doc version: 1.10
      https://github.com/docker/swarm/commits/master/docs/swarm_at_scale/index.md
.. check date: 2016/03/03
.. Commits on Feb 28, 2016 ec8ceae209c54091065c8f9e50439bd76255b022
.. -------------------------------------------------------------------

.. Try Swarm at scale

.. _try-swam-at-scale:

=======================================
swarm のスケールを試す
=======================================

.. Using this example, you deploy a voting application on a Swarm cluster. This example illustrates a typical development process. After you establish an infrastructure, you create a Swarm cluster and deploy the application against the cluster.

ここで扱う例は、 Swarm クラスタ上に投票アプリケーションをデプロイします。例では典型的な開発プロセスを使って説明します。インフラを構築すると、Swarm クラスタの作成やクラスタ上にアプリケーションをデプロイできるようになります。

.. After building and manually deploying the voting application, you’ll construct a Docker Compose file. You (or others) can use the file to deploy and scale the application further. The article also provides a troubleshooting section you can use while developing or deploying the voting application.

投票アプリケーションの構築と手動でデプロイした後、Docker Compose ファイルを作成します。あなた（もしくは誰か）はこのファイルを使い、アプリケーションの更なるデプロイやスケールが可能になります。

.. The sample is written for a novice network administrator. You should have a basic skills on Linux systems, ssh experience, and some understanding of the AWS service from Amazon. Some knowledge of Git is also useful but not strictly required. This example takes approximately an hour to complete and has the following steps:

このサンプルは、新人ネットワーク管理者向けに書かれています。基本的な Linux システムのスキルを持ち、 ``ssh`` 経験、Amazon が提供する AWS サービスに対する理解があることでしょう。また、 Git のような知識があれば望ましいのですが、必須ではありません。以下の手順でサンプルを進めていくのに、約１時間ほどかかります。

.. toctree::
   :maxdepth: 3

   01-about.rst
   02-deploy-infra.rst
   03-create-cluster.rst
   04-deploy-app.rst
   05-troubleshoot.rst

.. seealso:: 

   Try Swarm at scale
      https://docs.docker.com/swarm/swarm_at_scale/

