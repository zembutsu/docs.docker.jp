.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/part6/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/get-started/part6.md
.. check date: 2017/09/12
.. Commits on Aug 26 2017 4445f27581bd2d190ecd69b6ca31b8dc04b2b9e3
.. -----------------------------------------------------------------------------

.. Get Started, Part 6: Deploy you app

========================================
Part 6：アプリのデプロイ
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Prerequisites

必要条件
==========

..    Install Docker version 1.13 or higher.
   Get Docker Compose as described in Part 3 prerequisites.
   Get Docker Machine as described in Part 4 prerequisites.
   Read the orientation in Part 1.
   Learn how to create containers in Part 2.
   Make sure you have published the friendlyhello image you created by pushing it to a registry. We’ll be using that shared image here.
   Be sure your image works as a deployed container. Run this command, slotting in your info for username, repo, and tag: docker run -p 80:80 username/repo:tag, then visit http://localhost/.
   Have the final version of docker-compose.yml from Part 5 handy.

* :doc:`Docker バージョン 1.13 以上のインストール </engine/installation/index>`
* :doc:`Part 4 <part4>' で扱った :doc:`Docker Machine </machine/overview>` を入手。
* :doc:`Part 1 <index>` の概要を読んでいること
* :doc:`Part 2 <part>` のコンテナの作成方法学んでいること
* 自分で作成した ``friendlyhello`` イメージを :ref:`レジストリに送信 <share-your-image>` して公開済みなのを確認します。ここでは、この共有イメージを使います。
* イメージをコンテナとしてデプロイできるのを確認します。次のコマンドを実行しますが、 ``ユーザ名`` と ``リポジトリ`` ``タグ`` は皆さんのものに置き換えます。コマンドは ``docker run -p 80:80 ユーザ名/リポジトリ:タグ`` です。そして ``http://localhost/`` を表示します。
* :doc:`Par t5 <part5>` で作成した ``docker-compose.yml`` の :ref:`最終バージョン <persist-the-data>` があること

.. Introduction

はじめに
==========

.. You’ve been editing the same Compose file for this entire tutorial. Well, we have good news. That Compose file works just as well in production as it does on your machine. Here, we’ll go through some options for running your Dockerized application.
Choose an option

..    Docker CE (Cloud provider)
    Enterprise (Cloud provider)
    Enterprise (On-premise)

Docker CE（クラウド・プロバイダ）
----------------------------------------

.. If you’re okay with using Docker Community Edition in production, you can use Docker Cloud to help manage your app on popular service providers such as Amazon Web Services, DigitalOcean, and Microsoft Azure.

Docker コミュニティ・エディションをプロダクションで使う方針であれば、Amazon Web Services や DeigalOcean、Microsoft Azure のような有名なサービスプロバイダ上でアプリを管理するのに Docker Cloud を利用できます。

.. To set up and deploy:

セットアップとデプロイをするには：

..    Connect Docker Cloud with your preferred provider, granting Docker Cloud permission to automatically provision and “Dockerize” VMs for you.
    Use Docker Cloud to create your computing resources and create your swarm.
    Deploy your app.

* 任意のプロバイダと Docker Cloud を接続し、 Docker Cloud に対して「Docker対応」の仮想マシンを自動的にプロビジョンする権限を付与
* Docker Cloud で計算資源と swarm の作成
* アプリのデプロイ

..    Note: We will be linking into the Docker Cloud documentation here; be sure to come back to this page after completing each step.

.. note::

   以降は Docker Cloud ドキュメントにリンクをしていますが、各ステップが終わりましたら、このページにお戻りください。

.. Connect Docker Cloud

Docker Cloud へ接続
====================

.. You can run Docker Cloud in standard mode or in Swarm mode.

Docker Cloud は `スタンダード・モード <https://docs.docker.com/docker-cloud/infrastructure/>`_ または `swarm モード <https://docs.docker.com/docker-cloud/cloud-swarm/>`_ で実行できます。

.. If you are running Docker Cloud in standard mode, follow instructions below to link your service provider to Docker Cloud.

Docker Cloud をスタンダード・モードで動かす場合は各サービス・プロバイダと Docker Cloud を接続するため、以下のドキュメントをご覧ください。

..    Amazon Web Services setup guide
    DigitalOcean setup guide
    Microsoft Azure setup guide
    Packet setup guide
    SoftLayer setup guide
    Use the Docker Cloud Agent to bring your own host

* `Amazon Web Services setup guide <https://docs.docker.com/docker-cloud/cloud-swarm/link-aws-swarm/>`_
* `DigitalOcean setup guide <https://docs.docker.com/docker-cloud/infrastructure/link-do/>`_
* `Microsoft Azure setup guide <https://docs.docker.com/docker-cloud/infrastructure/link-azure/>`_
* `Packet setup guide <https://docs.docker.com/docker-cloud/infrastructure/link-packet/>`_
* `SoftLayer setup guide <https://docs.docker.com/docker-cloud/infrastructure/link-softlayer/>`_
* `Docker Cloud エージェントで自分のホストを使う <https://docs.docker.com/docker-cloud/infrastructure/byoh/>`_

.. If you are running in Swarm mode (recommended for Amazon Web Services or Microsoft Azure), then skip to the next section on how to create your swarm.

Docker Cloud を swarm モードで動かす場合は、次の :ref:`create-your-swarm` をご覧ください。

.. Create your swarm

.. _create-your-swarm:

swarm の作成
====================

..Ready to create a swarm?

swarm 作成の準備が整いましたか？

..    If you’re on Amazon Web Services (AWS) you can automatically create a swarm on AWS.
    If you are on Microsoft Azure, you can automatically create a swarm on Azure.
    Otherwise, create your nodes in the Docker Cloud UI, and run the docker swarm init and docker swarm join commands you learned in part 4 over SSH via Docker Cloud. Finally, enable Swarm Mode by clicking the toggle at the top of the screen, and register the  swarm you just created.

* Amazon Web Services (AWS) をお使いの場合は、 `AWS で swarm を自動的に作成できます <https://docs.docker.com/docker-cloud/cloud-swarm/create-cloud-swarm-aws/>`_
* Microsoft Azure の場合は、 `Azure で swarm を自動的に作成できます <https://docs.docker.com/docker-cloud/cloud-swarm/create-cloud-swarm-azure/>`_ 
* あるいは、 Docker Cloud UI を通して `自分でノードを作成し <https://docs.docker.com/docker-cloud/getting-started/your_first_node/>`_ 、 :doc:`Part 4 <part4>` で学んだ ``docker swarm init`` と ``docker swarm join`` コマンドを `Docker Cloud に対して SSH 経由で実行し <https://docs.docker.com/docker-cloud/infrastructure/ssh-into-a-node/>`_ 、最後に画面上部のトグルにある `enable Sarm Mode（swarm モードの有効化） <https://docs.docker.com/docker-cloud/cloud-swarm/using-swarm-mode/>`_ をクリックし、作成した `Swarm を登録 <https://docs.docker.com/docker-cloud/cloud-swarm/register-swarms/>`_ します。

..    Note: If you are Using the Docker Cloud Agent to Bring your Own Host, this provider does not support swarm mode. You can register your own existing swarms with Docker Cloud.

.. note::

   `自分で用意したホストで Docker Cloud エージェントを使う <https://docs.docker.com/docker-cloud/infrastructure/byoh/>`_ 場合は、swarm モードのサポートがありません。Docker Cloud で `作成した swarm を登録 <https://docs.docker.com/docker-cloud/cloud-swarm/register-swarms/>`_ ください。


.. Deploy your app

アプリのデプロイ
====================

.. Connect to your swarm via Docker Cloud. On Docker for Mac or Docker for Windows (Edge releases), you can connect to your swarms directly through the desktop app menus.

`Docker Cloud を通して swarm に接続します <https://docs.docker.com/docker-cloud/cloud-swarm/connect-to-swarm/>`_  。Docker for Mac や Docker for Windows （Edge リリース）であれば、デスクトップのアプリ側メニューから、 `直接 swarm に接続 <https://docs.docker.com/docker-cloud/cloud-swarm/connect-to-swarm/#use-docker-for-mac-or-windows-edge-to-connect-to-swarms>`_  できます。

.. Either way, this opens a terminal whose context is your local machine, but whose Docker commands are routed up to the swarm running on your cloud service provider. This is a little different from the paradigm you’ve been following, where you were sending commands via SSH. Now, you can directly access both your local file system and your remote swarm, enabling some very tidy-looking commands:

あるいは別の方法として、ローカルホスト上でターミナルを開いての操作も行えますが、Docker コマンドを各クラウド・サービス・プロバイダの swarm に向ける必要があります。しかし、今から送ろうとするコマンドは、SSH を使ってコマンドを送る必要があるため、手順はいささか異なります。ここでは、自分のローカルのファイルシステムとリモートの swarm の両方を直接アクセスするため、小綺麗なコマンドを使ってみましょう。

.. code-block:: bash

   docker stack deploy -c docker-compose.yml getstartedlab

.. That’s it! Your app is running in production and is managed by Docker Cloud.

以上です！ アプリはプロダクションで稼働を開始し、環境は Docker Cloud によって管理されています。

.. Congratulations!

おつかれさまでした！
====================

.. You’ve taken a full-stack, dev-to-deploy tour of the entire Docker platform.

これで Docker プラットフォーム全体としてのフルスタック、すなわち開発からデプロイへの流れを習得しました。

.. There is much more to the Docker platform than what was covered here, but you have a good idea of the basics of containers, images, services, swarms, stacks, scaling, load-balancing, volumes, and placement constraints.

Docker Cloud にはここで扱わなかった以上の事も可能ですが、コンテナ、イメージ、サービス、swarm、スタック、スケーリング、負荷分散ボリューム、場所の制約といった、基本的な考えを習得しました。

.. Want to go deeper? Here are some resources we recommend:

より深く学びたいですか？　私たちは以下のリソースを推奨します。

..    Samples: Our samples include multiple examples of popular software running in containers, and some good labs that teach best practices.
    User Guide: The user guide has several examples that explain networking and storage in greater depth than was covered here.
    Admin Guide: Covers how to manage a Dockerized production environment.
    Training: Official Docker courses that offer in-person instruction and virtual classroom environments.
    Blog: Covers what’s going on with Docker lately.

* `サンプル <https://docs.docker.com/samples/>`_ ： コンテナで有名なソフトウェアを動かす例や、ベストプラクティスを教えるラボがあります
* :doc:`ユーザ・ガイド </engine/uesrguide/index>` ： チュートリアルで扱った内容よりも深いネットワークやストレージに関して、いくつかの例とともに紹介するユーザガイドです
* :doc:`管理者ガイド </engine/admin/index>` ： Docker 対応プロダクション環境を管理する方法を扱います
* `トレーニング <https://training.docker.com/>`_ ： 対面での教室や仮想クラス環境における公式 Docker コースです
* `ブログ <https://blog.docker.com/>`_ ： 直近の Docker の話題を扱います


