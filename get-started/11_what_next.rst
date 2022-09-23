.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/11_what_next/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/get-started/11_what_next.md
.. check date: 2022/09/20
.. Commits on Feb 2, 2021 dc7352020eb1e19aa7319c895c01970dd011d0e0
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

.. Although we’re done with our workshop, there’s still a LOT more to learn about containers! We’re not going to go deep-dive here, but here are a few other areas to look at next!

ワークショップが全て完了しましたが、コンテナについてはまだまだ学ぶことが多くあります！ ここでは深掘りをしませんでしたが、ここに次に見るべき場所があります。

.. Container orchestration
.. _get-started-container-orchestration:

コンテナ オーケストレーション
==============================

.. Running containers in production is tough. You don’t want to log into a machine and simply run a docker run or docker-compose up. Why not? Well, what happens if the containers die? How do you scale across several machines? Container orchestration solves this problem. Tools like Kubernetes, Swarm, Nomad, and ECS all help solve this problem, all in slightly different ways.

本番環境でコンテナを実行するのは大変です。マシンへログインしたり、簡単な ``docker run`` や ``docker-compose up`` も実行したくはないでしょう。ちがいますか？ そうですね、もしコンテナが停止してしまったら？ 複数のマシンを横断してスケールするには？ この問題を解決するのが :ruby:`コンテナ オーケストレーション <container orchestration>` です。Kubernetes 、 Swarm 、 Nomad 、 ECS のようなツール、これらすべてが問題解決に役立ちますが、どれもわずかに手法が異なります。

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

.. seealso::

   What next
      https://docs.docker.com/get-started/11_what_next/


