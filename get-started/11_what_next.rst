.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/11_what_next/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/get-started/11_what_next.md
.. check date: 2023/07/17
.. Commits on Mar 2, 2023 5f610a9961a77397bc756ed2a70e97f39215a3b8
.. -----------------------------------------------------------------------------

.. what next
.. _get-started-what-next:

========================================
次にすること
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Although we’re done with our get started guide, there’s still a LOT more to learn about containers! We’re not going to go deep-dive here, but here are a few other areas to look at next!

始め方のガイドは全て完了しましたが、コンテナについて学ぶことはまだまだ多くあります！ これまで深掘りをしませんでしたが、ここには次に見るべき場所があります。

.. Container orchestration
.. _get-started-container-orchestration:

コンテナ オーケストレーション
==============================

.. Running containers in production is tough. You don’t want to log into a machine and simply run a docker run or docker-compose up. Why not? Well, what happens if the containers die? How do you scale across several machines? Container orchestration solves this problem. Tools like Kubernetes, Swarm, Nomad, and ECS all help solve this problem, all in slightly different ways.

本番環境でコンテナを実行するのは大変です。マシンへログインしたり、簡単な ``docker run`` や ``docker compose up`` も実行したくはないでしょう。ちがいますか？ そうですね、もしコンテナが停止してしまったら？ 複数のマシンを横断してスケールするには？ この問題を解決するのが :ruby:`コンテナ オーケストレーション <container orchestration>` です。Kubernetes 、 Swarm 、 Nomad 、 ECS のようなツール、これらすべてが問題解決に役立ちますが、どれもわずかに手法が異なります。

.. The general idea is that you have “managers” who receive expected state. This state might be “I want to run two instances of my web app and expose port 80.” The managers then look at all of the machines in the cluster and delegate work to “worker” nodes. The managers watch for changes (such as a container quitting) and then work to make actual state reflect the expected state.

共通する考え方は **期待する状態（expected state）** を受け取る「 :ruby:`マネージャー <manager>` 」があります。この状態とは「ウェブアプリを２つ実行し、ポート80を公開したい」のようなものです。マネージャーはクラスタ上のすべてのマシンを調べ、「 :ruby:`ワーカー <worker>` 」ノードに権限を :ruby:`委譲します <delegate>` 。マネージャーは変更（コンテナの終了のような状態）も監視し、 **実際の状態（actual state）** に期待する状態を反映します。

.. Cloud Native Computing Foundation projects
.. _cloud-native-computing-foundation-projects:

Cloud Native Computing Foundation のプロジェクト
======================================================================

.. The CNCF is a vendor-neutral home for various open-source projects, including Kubernetes, Prometheus, Envoy, Linkerd, NATS, and more! You can view the graduated and incubated projects here and the entire CNCF Landscape here. There are a LOT of projects to help solve problems around monitoring, logging, security, image registries, messaging, and more!

CNCF とは、様々なオープンソース プロジェクトのためのベンダー中立な拠点であり、Kubernetes、Prometheus、Envoy、Linkerd、NAT などが参画しています！ `graduated や incubated プロジェクトはこちら <https://www.cncf.io/projects/>`_ から見られますし、全体の `CNCF Landscape もこちら <https://landscape.cncf.io/>`_ です。監視、ログ記録、セキュリティ、イメージ レジストリ、メッセージング等の周辺問題を解決する、様々なプロジェクトがあります。

.. So, if you’re new to the container landscape and cloud-native application development, welcome! Please connect with the community, ask questions, and keep learning! We’re excited to have you!

ですから、コンテナの :ruby:`全体図 <landscape>` やクラウドネイティブ アプリケーション開発が初めてでも、歓迎します！ コミュニティとつながって、質問をして、学び続けましょう！ あなたがいるとワクワクします！

.. Getting started video workshop
.. _getting-started-video-workshop:

始め方ワークショップのビデオ
==============================

.. We recommend the video workshop from DockerCon 2022. Watch the video below or use the links to open the video at a particular section.

Dockercon 2022 のビデオワークショップを推奨します。以下の動画を再生するか、適切な動画セクションへのリンクを開きます。


..  Docker overview and installation
    Pull, run, and explore containers
    Build a container image
    Containerize an app
    Connect a DB and set up a bind mount
    Deploy a container to the cloud

* `Docker 概要とインストール <https://youtu.be/gAGEar5HQoU>`_ 
* `pull、run、コンテナを見渡す <https://youtu.be/gAGEar5HQoU?t=1400>`_ 
* `コンテナイメージ構築 <https://youtu.be/gAGEar5HQoU?t=3185>`_ 
* `アプリのコンテナ化 <https://youtu.be/gAGEar5HQoU?t=4683>`_ 
* `DB に接続し、バインド マウントの準備 <https://youtu.be/gAGEar5HQoU?t=6305>`_ 
* `コンテナをクラウドへデプロイ <https://youtu.be/gAGEar5HQoU?t=8280>`_ 


.. raw:: html

   <iframe src="https://www.youtube-nocookie.com/embed/gAGEar5HQoU" style="max-width: 100%; aspect-ratio: 16 / 9;" width="560" height="auto" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
   <br />&nbsp;<br />&nbsp;<br />&nbsp;



.. Creating a container from scratch
.. _creating-a-container-from-scratch:

ゼロからコンテナを作成する
==============================

.. If you’d like to see how containers are built from scratch, Liz Rice from Aqua Security has a fantastic talk in which she creates a container from scratch in Go. While the talk does not go into networking, using images for the filesystem, and other advanced topics, it gives a deep dive into how things are working.

コンテナをゼロから作る方法に興味があれば、Aqua Security の Liz Rice による Go 言語でコンテナをゼロから作成する素敵なトークがあります。トークではネットワーク機能を扱いませんが、ファイルシステムのためにイメージを使い、他の高度なトピックも扱いますので、どのように動作しているかを深掘りするのに役立つでしょう。


.. raw:: html

   <iframe src="https://www.youtube-nocookie.com/embed/8fi7uSYlOdc" style="max-width: 100%; aspect-ratio: 16 / 9;" width="560" height="auto" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
   <br />&nbsp;<br />&nbsp;<br />&nbsp;


.. Language-specific guides
言語別ガイド
====================

.. If you are looking for information on how to containerize an application using your favorite language, see Language-specific getting started guides.

好きな言語を使ってアプリケーションをコンテナ化する情報をさがしている場合は、 :doc:`言語別導入ガイド </language/index>` を御覧ください。

.. seealso::

   What next
      https://docs.docker.com/get-started/11_what_next/


