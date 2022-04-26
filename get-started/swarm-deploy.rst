.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/swarm-deploy/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/get-started/swarm-deploy.md
   doc version: 20.10
.. check date: 2020/06/21
.. Commits on Aug 7, 2021 7b2f0e92bc9c0095c251b28b211d1e20c2b5803f
.. -----------------------------------------------------------------------------

.. Deploy to Swarm

.. _deploy-to-swarm:

=======================================
Swarm にデプロイ
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Prerequisites

動作条件
==========

..    Download and install Docker Desktop as described in Orientation and setup.
    Work through containerizing an application in Part 2.
    Make sure that Swarm is enabled on your Docker Desktop by typing docker system info, and looking for a message Swarm: active (you might have to scroll up a little).
    If Swarm isn’t running, simply type docker swarm init in a shell prompt to set it up.


* :doc:`概要説明とセットアップ <index>` に記述された Docker Desktop のダウンロードとインストール
* :doc:`Part 2 <02_our_app>` でアプリケーションのコンテナ化を一通り行う
* Docker Desktop 上で Swarm 機能が有効化されていることを確認するには、 ``docker system info`` を入力し、 ``Swarm: active`` の文字列を探します（画面を少々スクロールする必要があるでしょう）。

.. If Swarm isn’t running, simply type docker swarm init in a shell prompt to set it up.

Swarm が実行中でなければ、シェルのプロンプト上でシンプルに ``docker swarm init``  を実行し、セットアップします。


.. Introduction

はじめに
==========

.. Now that we’ve demonstrated that the individual components of our application run as stand-alone containers and shown how to deploy it using Kubernetes, let’s look at how to arrange for them to be managed by Docker Swarm. Swarm provides many tools for scaling, networking, securing and maintaining your containerized applications, above and beyond the abilities of containers themselves.

.. Now that we’ve demonstrated that the individual components of our application run as stand-alone containers, it’s time to arrange for them to be managed by an orchestrator like Kubernetes. Kubernetes provides many tools for scaling, networking, securing and maintaining your containerized applications, above and beyond the abilities of containers themselves.

ここからは、私たちのアプリケーションの個々のコンポーネントを、Kubernetes スタンドアロン・コンテナ（stand-alone container）として実行してみましょう。Docker Swarm オーケストレータによって管理できるように、調整する機会です。Swarm  はコンテナ化アプリケーションのをスケール、ネットワーク機能、安全性、管理するための多くのツールを提供し、コンテナ自身に前述および後述の能力を与えます。

.. In order to validate that our containerized application works well on Swarm, we’ll use Docker Desktop’s built in Swarm environment right on our development machine to deploy our application, before handing it off to run on a full Swarm cluster in production. The Swarm environment created by Docker Desktop is fully featured, meaning it has all the Swarm features your app will enjoy on a real cluster, accessible from the convenience of your development machine.

私たちのコンテナ化アプリケーションが Swarm 上でも同様に動作するのを確認します。プロダクションの完全な Swarm クラスタにアプリケーションを持ち出す前に、開発マシン上にある Docker Desktop の Swarm 環境を使い、アプリケーションをデプロイします。Docker Desktop によって作成される Swarm 環境は、全ての機能を持ちます。つまり、アプリケーションが Swarm 環境で全て動作するのであれば、実際のクラスタ上でも動作しますので、開発マシン上からも簡単に利用できるのを意味します。

.. Describe apps using stack files

.. _describe-apps-using-stack-files:

stack ファイルを使ってアプリケーションを記述
==================================================

.. Swarm never creates individual containers like we did in the previous step of this tutorial. Instead, all Swarm workloads are scheduled as services, which are scalable groups of containers with added networking features maintained automatically by Swarm. Furthermore, all Swarm objects can and should be described in manifests called stack files. These YAML files describe all the components and configurations of your Swarm app, and can be used to easily create and destroy your app in any Swarm environment.

このチュートリアルは、以前のステップで行ったように、コンテナを１つ１つ作成するようなことは決してしません。そのかわりに、全ての Swarm ワークロードはサービス（ *service* ）としてスケジュールされます。これはスケーラブルな（拡張性を備えた）コンテナ のグループであり、Swarm によって自動的にメンテナンスされます。最終的に、全ての Swarm オブジェクトはマニフェストと呼ばれる *stack ファイル* に記述すべきです。これらの YAML ファイルは Swarm アプリの全コンポーネントと設定を記述します。そして、あらゆる Swarm 環境内でアプリケーションの作成と破棄を簡単に行えるようにします。

.. Let’s write a simple stack file to run and manage our bulletin board. Place the following in a file called bb-stack.yaml:

それでは、掲示板を実行・管理するための簡単な stack ファイルを書きましょう。 ``bb.yaml`` と名前を付けたファイルに、以下の内容を記述します。

::

   version: '3.7'
   
   services:
     bb-app:
       image: bulletinboard:1.0
       ports:
         - "8000:8080"

.. In this Swarm YAML file, we have just one object: a service, describing a scalable group of identical containers. In this case, you’ll get just one container (the default), and that container will be based on your bulletinboard:1.0 image created in Part 2 of the Quickstart tutorial. In addition, We’ve asked Swarm to forward all traffic arriving at port 8000 on our development machine to port 8080 inside our bulletin board container.

この Swarm YAML ファイルでは、 ``service`` という１つのオブジェクトのみあります。これはコンテナごとのスケーラブルなグループを記述します。今回の例では、１つのコンテナを持ちます（これがデフォルトです）。このコンテナは、このチュートリアル以前のステップで用いた ``bulletinboard:1.0`` イメージをベースとするものです。さらに、 Swarm に対して開発マシン上のポート 8000 に到達した全てのトラフィックを、掲示板コンテナ内の 8080 に転送するよう依頼します。

.. attention::

  **Kubernetes サービスと Swarm サービスは全く違います！** 似たような名前ですが、「サービス」という単語を含む２つのオーケストレータの意味は非常に異なるものです。 Swarm では、スケジューリングとネットワーク・ファシリティの両方を提供し、コンテナを作成し、トラフィックをそこに転送するツールも提供します。Kubernetes では、スケジューリングとネットワーキングは別々に扱います。具体的には、deployment（あるいは、他のコントローラ）はコンテナのスケジューリングを Pod として処理し、サービスとは各 pod に対するネットワーク機能の追加を表すだけです。


.. Deploy and check your application

.. _swarm-deploy-and-check-your-application:

アプリケーションののデプロイと確認
========================================

.. 1. Deploy your application to Swarm:

1. アプリケーションを Swarm にデプロイします。

.. code-block:: bash

   $ docker stack deploy -c bb-stack.yaml demo

.. If all goes well, Swarm will report creating all your stack objects with no complaints:

正常に処理されれば、Swarm は全ての stack オブジェクトが問題なく作成されたと報告します。

.. code-block:: bash

   Creating network demo_default
   Creating service demo_bb-app

.. Notice that in addition to your service, Swarm also creates a Docker network by default to isolate the containers deployed as part of your stack.

サービスに対する注意を追加すると、 Swarm は stack の一部として、Docker ネットワークもデフォルトでコンテナを隔離した状態で作成します。

.. Make sure everything worked by listing your service:

2. サービス一覧で、全てが動作しているのを確認します。

.. code-block:: bash

   $ docker service ls

.. If all has gone well, your service will report with 1/1 of its replicas created:

全て正常であれば、サービスは自身の作成したレプリカが 1/1 だと報告します。

.. code-block:: bash

   ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
   il7elwunymbs        demo_bb-app         replicated          1/1                 bulletinboard:1.0   *:8000->8080/tcp

.. This indicates 1/1 containers you asked for as part of your services are up and running. Also, we see that port 8000 on your development machine is getting forwarded to port 8080 in your bulletin board container.

1/1 のコンテナと表示されているのは、サービスとしていくつのコンテナが起動しているかを示しています。また、開発マシン上のポート 8000 が、掲示板コンテナのポート 8080 に転送されるのも分かります。

.. Open a browser and visit your bulletin board at localhost:8000; you should see your bulletin board, the same as when we ran it as a stand-alone container in Part 2 of the Quickstart tutorial.

3. ブラウザで ``localhost:8000`` を開き、掲示板を訪ねましょう。そうすると、クイックスタート・チュートリアルの :doc:`Part 2 <02_our_app>` で実行したスタンドアロン・コンテナと同じ掲示板が表示されます。

.. Once satisfied, tear down your application:

4. 満足したら、アプリケーションを解体します。

.. code-block:: bash

   $ docker stack rm demo


.. Conclusion

まとめ
==========

.. At this point, we have successfully used Docker Desktop to deploy our application to a fully-featured Swarm environment on our development machine. We haven’t done much with Swarm yet, but the door is now open: you can begin adding other components to your app and taking advantage of all the features and power of Swarm, right on your own machine.

これまで、 Docker Desktop を使い、私たちの開発マシン上で全機能が揃った Swarm 環境に、私たちのアプリケーションをデプロイすることに成功しました。まだ Swarm をほとんど触っていませんが、新しいドアが開かれました。つまり、アプリケーションに他のコンポーネントを追加できますし、まさにあなたのマシン上で、Swarm の全ての機能とパワーを活用できるのです。

.. In addition to deploying to Swarm, we have also described our application as a stack file. This simple text file contains everything we need to create our application in a running state; we can check it into version control and share it with our colleagues, allowing us to distribute our applications to other clusters (like the testing and production clusters that probably come after our development environments) easily.

Swarm へのデプロイに付け加えると、アプリケーションを stack ファイルとして記述しました。これはシンプルなテキストファイルで、アプリケーションを実行状態として生成するために全てを含むものです。同僚とバージョンコントロールでチェックおよび共有できるようにすると、他のクラスタ（開発環境の後に続く、テストやプロダクションに対応したクラスタ）に対するアプリケーションの配布が簡単になります。

.. Swarm and CLI references

Swarm と CLI リファレンス
==============================

.. Further documentation for all new Swarm objects and CLI commands used in this article are available here:

この記事で使われた新しい Swarm オブジェクトと CLI コマンドに関する詳しい情報は、こちらをご覧ください。

* :doc:`Swarm モード </engine/swarm/index>`
* :doc:`Swarm モード サービス </engine/swarm/how-swarm-mode-works/services>`
* :doc:`Swarm スタック </engine/swarm/stack-deploy>`
* :doc:`docker stack * </engine/reference/commandline/stack>`
* :doc:`docker service * </engine/reference/commandline/service/>`


.. seealso:: 
   Deploy to Swarm
     https://docs.docker.com/get-started/swarm-deploy/


