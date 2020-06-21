.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/kube-deploy/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/get-started/kube-deploy.md
   doc version: 19.03
.. check date: 2020/06/21
.. Commits on Apr 23, 2020 https://github.com/docker/docker.github.io/blob/master/get-started/kube-deploy.md
.. -----------------------------------------------------------------------------

.. Deploy to Kubernetes

.. _deploy-to-kubernetes:

=======================================
Kubernetes にデプロイ
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
    Make sure that Kubernetes is enabled on your Docker Desktop:
        Mac: Click the Docker icon in your menu bar, navigate to Preferences and make sure there’s a green light beside ‘Kubernetes’.
        Windows: Click the Docker icon in the system tray and navigate to Settings and make sure there’s a green light beside ‘Kubernetes’.

* :doc:`概要説明とセットアップ <index>` に記述された Docker Desktop のダウンロードとインストール
* :doc:`Part 2 <part2>` でアプリケーションのコンテナ化を一通り行う
* Docker Desktop 上で Kubernetes 機能が有効かされていることを確認

   * **Mac** ：メニューバー内の Docker アイコンをクリックし、 **Preferences**  に移動し、「Kubernetes」の横に緑のライトが点等していること
   * **Mac** ：システムトレイ内の Docker アイコンをクリックし、 **Settings**  に移動し、「Kubernetes」の横に緑のライトが点等していること

..    If Kubernetes isn’t running, follow the instructions in Orchestration of this tutorial to finish setting it up.


.. Introduction

はじめに
==========

.. Now that we’ve demonstrated that the individual components of our application run as stand-alone containers, it’s time to arrange for them to be managed by an orchestrator like Kubernetes. Kubernetes provides many tools for scaling, networking, securing and maintaining your containerized applications, above and beyond the abilities of containers themselves.

ここからは、私たちのアプリケーションの個々のコンポーネントを、スタンドアロン・コンテナ（stand-alone container）として実行してみましょう。Kubernetes のようなオーケストレータによって管理できるように、調整する機会です。Kubernetes はコンテナ化アプリケーションのをスケール、ネットワーク機能、安全性、管理するための多くのツールを提供し、コンテナ自身に前述および後述の能力を与えます。

.. In order to validate that our containerized application works well on Kubernetes, we’ll use Docker Desktop’s built in Kubernetes environment right on our development machine to deploy our application, before handing it off to run on a full Kubernetes cluster in production. The Kubernetes environment created by Docker Desktop is fully featured, meaning it has all the Kubernetes features your app will enjoy on a real cluster, accessible from the convenience of your development machine.

私たちのコンテナ化アプリケーションが Kubernetes 上でも同様に動作するのを確認します。プロダクションの完全な Kubernetes クラスタにアプリケーションを持ち出す前に、開発マシン上にある Docker Desktop の Kubernetes 環境を使い、アプリケーションをデプロイします。Docker Desktop によって作成される Kubernetes 環境は、全ての機能を持ちます。つまり、アプリケーションが Kubernetes 環境で全て動作するのであれば、実際のクラスタ上でも動作しますので、開発マシン上からも簡単に利用できるのを意味します。

.. Describing apps using Kubernetes YAML

.. _describing-apps-using-kubernetes-yaml:

Kubernetes YAML でアプリケーションを記述
========================================

.. All containers in Kubernetes are scheduled as pods, which are groups of co-located containers that share some resources. Furthermore, in a realistic application we almost never create individual pods; instead, most of our workloads are scheduled as deployments, which are scalable groups of pods maintained automatically by Kubernetes. Lastly, all Kubernetes objects can and should be described in manifests called Kubernetes YAML files. These YAML files describe all the components and configurations of your Kubernetes app, and can be used to easily create and destroy your app in any Kubernetes environment.

Kubernetes 内の全てのコンテナは pod （ポッド）としてスケジュールされます。pod とは同じリソースを共有する、同じ場所に配置されるコンテナのグループです。さらに、実際のアプリケーションでは、ほとんど単体の pod を作りません。そのかわりに、多く音ワークロードは *デプロイメント（deployment）* としてスケジュールされます。これはスケーラブルな（拡張性を備えた）pod のグループであり、Kubernetes によって自動的にメンテナンスされます。最終的に、全ての Kubernetes オブジェクトはマニフェストと呼ばれる *Kubernetes YAML* ファイルに記述すべきです。これらの YAML ファイルは Kubernetes アプリの全コンポーネントと設定を記述します。そして、あらゆる Kubernetes 環境内でアプリケーションの作成と破棄を簡単に行えるようにします。

..    You already wrote a very basic Kubernetes YAML file in the Orchestration overview part of this tutorial. Now, let’s write a slightly more sophisticated YAML file to run and manage our bulletin board. Place the following in a file called bb.yaml:

1. 基本的な Kubernetes YAML ファイルは、このチュートリアルのオーケストレーション概要で既に書いてます。次は、掲示板を実行・管理できるようにするため、より適切な YAML ファイルになるよう少々の手を加えます。 ``bb.yaml`` と名前を付けたファイルに、以下の内容を記述します。

::

    apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: bb-demo
     namespace: default
   spec:
     replicas: 1
     selector:
       matchLabels:
         bb: web
     template:
       metadata:
         labels:
           bb: web
       spec:
         containers:
         - name: bb-site
           image: bulletinboard:1.0
   ---
   apiVersion: v1
   kind: Service
   metadata:
     name: bb-entrypoint
     namespace: default
   spec:
     type: NodePort
     selector:
       bb: web
     ports:
     - port: 8080
       targetPort: 8080
       nodePort: 30001

..  In this Kubernetes YAML file, we have two objects, separated by the ---:
        A Deployment, describing a scalable group of identical pods. In this case, you’ll get just one replica, or copy of your pod, and that pod (which is described under the template: key) has just one container in it, based off of your bulletinboard:1.0 image from the previous step in this tutorial.
        A NodePort service, which will route traffic from port 30001 on your host to port 8080 inside the pods it routes to, allowing you to reach your bulletin board from the network.

この Kubernetes YAML ファイルには、 ``---`` によって区切られる2つのオブジェクトがあります。

* ``Deployment`` で、完全に等しい pod のスケーラブルなグループを記述します。この例では、1つの ``replica`` （レプリカ）を入手するか、 pod のコピーを入手できるようにし、その pod （ ``template`` 以下に記述 ）内で1つのコンテナを持ちます。このコンテナは、このチュートリアル以前のステップで用いた ``bulletinboard:1.0`` イメージをベースとするものです。
* ``NodePort`` サービスは、ホスト上のポート 30001 からのトラフィックを、 pod 内の 8080 に転送します。これにより、ネットワークから掲示板に到達可能になります。

..    Also, notice that while Kubernetes YAML can appear long and complicated at first, it almost always follows the same pattern:
        The apiVersion, which indicates the Kubernetes API that parses this object
        The kind indicating what sort of object this is
        Some metadata applying things like names to your objects
        The spec specifying all the parameters and configurations of your object.

また、kubernetes YAML を初めて見ると、長く複雑に見えてしまいますが、ほとんどが以下のように同じパターンです。

* ``apiVersion`` が示すのは、Kubernetes API で対象オブジェクトをパースする指定
* ``kind``  が示すのは、これがどのような種類のオブジェクトか
* いくつかの ``metadata``  は、オブジェクトに対して名前のようなものを適用
* ``spec``  で指定するのは、オブジェクトに対するパラメータと設定の全て

Deploy and check your application

.. _deploy-and-check-your-application:

アプリケーションののデプロイと確認
========================================

..    In a terminal, navigate to where you created bb.yaml and deploy your application to Kubernetes:

1. ターミナル上で、 ``bb.yaml`` を作成した場所に移動し、 Kubernetes にアプリケーションをデプロイします。

.. code-block:: bash

   kubectl apply -f bb.yaml

..    you should see output that looks like the following, indicating your Kubernetes objects were created successfully:

すると、以下のような出力が現れ、Kubernetes オブジェクトの作成に成功したことが分かります。

.. code-block:: bash

   deployment.apps/bb-demo created
   service/bb-entrypoint created

..    Make sure everything worked by listing your deployments:

2. デプロイメントのリストを表示し、全てが正常動作しているのを確認します。

.. code-block:: bash

   kubectl get deployments

..    if all is well, your deployment should be listed as follows:

全てが正常であれば、デプロイメントは一覧に次のように表示されます。

::

   NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
   bb-demo   1         1         1            1           48s

..    This indicates all one of the pods you asked for in your YAML are up and running. Do the same check for your services:

これが示すのは、YAML で命令した全ての pod が起動して実行中であることがわかります。サービスに対しても同様に確認します。

.. code-block:: bash

   kubectl get services
   
   NAME            TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
   bb-entrypoint   NodePort    10.106.145.116   <none>        8080:30001/TCP   53s
   kubernetes      ClusterIP   10.96.0.1        <none>        443/TCP          138d

..    In addition to the default kubernetes service, we see our bb-entrypoint service, accepting traffic on port 30001/TCP.

デフォルトの ``kubernetes`` サービスに加え、私たちの ``bb-entrypoint`` サービスが見え、ポート 30001/TCP のトラフィックを受け入れるのが分かります。

..    Open a browser and visit your bulletin board at localhost:30001; you should see your bulletin board, the same as when we ran it as a stand-alone container in Part 2 of the Quickstart tutorial.

3. ブラウザで ``localhost:30001`` を開き、掲示板を訪ねましょう。そうすると、クイックスタート・チュートリアルの :doc:`Part 2 <part2>` で実行したスタンドアロン・コンテナと同じ掲示板が表示されます。

..    Once satisfied, tear down your application:

4. 満足したら、アプリケーションを解体します。

.. code-block:: bash

   kubectl delete -f bb.yaml

.. Conclusion

まとめ
==========

.. At this point, we have successfully used Docker Desktop to deploy our application to a fully-featured Kubernetes environment on our development machine. We haven’t done much with Kubernetes yet, but the door is now open; you can begin adding other components to your app and taking advantage of all the features and power of Kubernetes, right on your own machine.

これまで、 Docker Desktop を使い、私たちの開発マシン上で全機能が揃った Kubernetes 環境に、私たちのアプリケーションをデプロイすることに成功しました。まだ Kubernetes をほとんど触っていませんが、新しいドアが開かれました。つまり、アプリケーションに他のコンポーネントを追加できますし、まさにあなたのマシン上で、Kubernetes の全ての機能とパワーを活用できるのです。

.. In addition to deploying to Kubernetes, we have also described our application as a Kubernetes YAML file. This simple text file contains everything we need to create our application in a running state. We can check it into version control and share it with our colleagues, allowing us to distribute our applications to other clusters (like the testing and production clusters that probably come after our development environments) easily.

Kubenetes へのデプロイに付け加えると、アプリケーションを Kubernetes YAML ファイルとして記述しました。これはシンプルなテキストファイルで、アプリケーションを実行状態として生成するために全てを含むものです。同僚とバージョンコントロールでチェックおよび共有できるようにすると、他のクラスタ（開発環境の後に続く、テストやプロダクションに対応したクラスタ）に対するアプリケーションの配布が簡単になります。

.. Kubernetes references

Kubernetes リファレンス
==============================

.. Further documentation for all new Kubernetes objects used in this article are available here:

この記事で使われた新しい Kubernetes オブジェクトに関する詳しい情報は、こちらをご覧ください。

..  Kubernetes Pods
    Kubernetes Deployments
    Kubernetes Services

* `Kubernetes Pod <https://kubernetes.io/ja/docs/concepts/workloads/pods/pod/>`_
* `Kubernetes Deployment <https://kubernetes.io/ja/docs/concepts/workloads/controllers/deployment/>`_
* `Kubernetes Service <https://kubernetes.io/ja/docs/concepts/services-networking/service/>`_


.. seealso:: 
   Deploy to Kubernetes
     https://docs.docker.com/get-started/kube-deploy/


