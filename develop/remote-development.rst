.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/remote-development/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/develop/remote-development.md
.. check date: 2023/07/23
.. Commits on Jul 18, 2023 3f082722a41cbcb2e83c528b60ffeeb0c6d100cd
.. -----------------------------------------------------------------------------

.. Using Kubernetes for remote development
.. _using-kubernetes-for-remote-development:

========================================
リモート開発に Kubernetes を使う
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Teams developing large, cloud-native applications might find themselves in a situation where it’s not possible to run the entire application locally on a development machine. There are several reasons why running an application locally is sometimes not feasible:

クラウドネイティブなアプリケーションの大規模チーム開発では、ローカルな開発マシン上でアプリケーション全体を実行するのが困難な状況が起こり得るでしょう。アプリケーションをローカルで実行できないのは、幾つかの理由があります。

..  It requires more resources than your local machine can provide
    There are dependencies to cloud services, APIs, or networking configurations that can’t be emulated
    Testing and validating requires large amounts of data or network traffic

* アプリケーションがローカルマシンが提供する以上のリソースを必要とする
* アプリケーションがクラウドサービス、API、ネットワーク設定と、エミュレートできない依存関係がある
* テストや検証に大規模データやネットワークトラフィックが必要となる

.. Often, this means you need to rely on continuous integration pipelines or staging environments to verify code changes. This introduces a time-consuming and cumbersome workflow where you must commit, push, build, test, and deploy your code in order to see them running.

度々、これらが意味するところ、コードの変更を確認するには、継続的インテグレーションのパイプラインやステージング環境に依存する必要があります。これらにより、コードが動くところを見るためには、コミット、プッシュ、構築、テスト、デプロイするたびに時間を浪費して、かつ、厄介なワークフローになっています。

.. Combining local and remote
.. _combining-local-and-remote:

ローカルとリモートの組み合わせ
==============================

.. One solution to this problem is to integrate local services with a remote development cluster. In practice, this means starting a service on your development machine using docker run, and allowing that local service to communicate with the development cluster over the network. The remote development cluster hosts workloads that represent the production environment.

この問題に対する解決策の1つが、リモートデプロイ用のクラスタとローカルサービスとの統合です。実際の所これが意味するのは、自分の開発マシン上で ``docker run`` を使ってサービスを開始し、ローカルのサービスがネットワークを通して開発クラスタと通信できるようになります。リモート開発クラスタは、プロダクション環境に相当するワークロードを負担（ホスト）します。

.. A development environment that lets you combine containers running locally with remote resources helps simplify and speed up the inner loop. There are several tools available, commercial and open-source, that you can use to enable a hybrid local-and-remote development environment. For example:

開発環境は、ローカルで実行しているコンテナとリモートでのリソースを連結できるので、内部ループの簡素化とスピードアップに役立ちます。それには商用やオープンソースで複数のツールが利用可能です。それらを使い、ローカルとリモート間でハイブリッドな開発環境に使えるでしょう。以下は例です。

..  Telepresence
    CodeZero
    Gefyra
    kubefwd
    ktunnel

* `Telepresence <https://app.getambassador.io/auth/realms/production/protocol/openid-connect/auth?client_id=docker-docs&response_type=code&redirect_uri=https%3A%2F%2Fapp.getambassador.io&utm_source=docker-docs&utm_medium=dockerwebsite&utm_campaign=Docker%26TP>`_
* `CodeZero <https://www.codezero.io/>`_
* `Gefyra <https://gefyra.dev/>`_
* `kubefwd <https://kubefwd.com/>`_
* `ktunnel <https://github.com/omrikiei/ktunnel>`_

.. Telepresence
.. _telepresence:

Telepresence
=====================

.. Telepresence is an open-source CNCF project that helps you integrate local services with a remote Kubernetes cluster. Telepresence works by running a traffic manager pod in Kubernetes, and Telepresence client daemons on developer workstations. The traffic manager acts as a two-way network proxy that can intercept connections and route traffic between the cluster and containers running on developer machines.

Telepresence はオープンソースの CNCF プロジェクトであり、リモートの Kubernetes クラスタとローカルサービスを統合するのに役立ちます。Telepresence は Kubernetes 内でトラフィックマネージャ（traffic manager）ポッドとして機能し、Telepresence クライアントは開発ワークステーション上のデーモンです。トラフィックマネージャは2種類のネットワークプロキシとして機能します。開発ワークステーション上で実行しているコンテナとクラスタとの間で、接続を受け付けたりトラフィックを経路付けしたりします。

   .. image:: ./images/telepresence-architecture.png
      :width: 90%
      :alt: Telepresence のハイレベルアーキテクチャ


.. You have a few options for how the local containers can integrate with the cluster:

ローカルコンテナをクラスタと統合するには、複数のオプションがあります。

..    No intercepts
    The most basic integration involves no intercepts at all. Simply establishing a connection between the container and the cluster. This enables the container to access cluster resources, such as APIs and databases.

* :ruby:`傍受 <intercepts>` （捕捉）なし

   * 最も基本的な統合では、一切傍受しません。コンテナとクラスタ間の通信をシンプルに確立するだけです。これにより、コンテナは API やデータベースといったクラスタリソースにアクセスできるようになります。

..    Global intercepts
    You can set up global intercepts for a service. This means all traffic for a service will be re-routed from Kubernetes to your local container.

* :ruby:`グローバル傍受 <global intercepts>`

   * サービスに対してグローバル傍受をセットアップできます。これが意味するのは、サービスに対する全てのトラフィックが、ローカルコンテナから Kubernetes へと :ruby:`再経路付け <re-routed>` されます。

..    Personal intercepts
    The more advanced alternative to global intercepts is personal intercepts. Personal intercepts let you define conditions for when a request should be routed to your local container. The conditions could be anything from only routing requests that include a specific HTTP header, to requests targeting a specific route of an API.

* :ruby:`パーソナル傍受 <personal intercepts>` 

   * グローバル傍受よりも更に高度な方法がパーソナル傍受です。パーソナル傍受により、ローカルのコンテナに対するリクエストがあるとき、経路付けをすべきとする条件を定義できるようにします。条件として設定できるのは経路付けリクエストのみであり、これには特定の HTTP ヘッダ、特定の API への経路に対するリクエストが含まれます。

.. Telepresence seamlessly integrates with Docker and it’s available for you to try today. Check out the following docs to learn more:

Telepresence は Docker とシームレスに統合しており、今日から試せます。更に学ぶには以下のドキュメントを御覧ください。

..  Telepresence extension for Docker Desktop
    Telepresence in Docker mode
    Telepresence for Docker Compose


* `Telepresence extension for Docker Desktop <https://www.getambassador.io/docs/telepresence/latest/docker/extension?utm_source=docker-docs&utm_medium=dockerwebsite&utm_campaign=Docker-TP>`_
* `Telepresence in Docker mode <https://www.getambassador.io/docs/telepresence/latest/docker/cli?utm_source=docker-docs&utm_medium=dockerwebsite&utm_campaign=Docker-TP>`_
* `Telepresence for Docker Compose <https://www.getambassador.io/docs/telepresence/latest/docker/compose?utm_source=docker-docs&utm_medium=dockerwebsite&utm_campaign=Docker-TP>`_


.. Docker × Ambassador

Docker × Ambassador
------------------------------

.. Sharing a development cluster with a large team can be both a blessing and a curse. Because your teammates are connected to the cluster, you’re able to see what they’re working on. But they can also accidentally step on your intercepts of shared services. Ambassador Labs, creators of Telepresence, run a subscription platform that helps teams share the cluster. You can identify all the intercepts you have running on a service. Each developer can generate an authenticated preview URL to share during code review.

大規模チームとの開発クラスタの共有は、恵みにも呪いにもなります。あなたのチームメイトがクラスタに接続すると、あなたは彼らが何をしているのか見えるようになるからです。しかし、彼らも意図せずあなたの共有サービスを傍受する可能性があります。Telepresence の開発者が作った Ambassador Labs は、チームがクラスタを共有するのに役立つサブスクリプションプラットフォームを運営しています。サービス上で実行している全ての傍受を識別できます。各開発者はコードレビュー中に共有できる、認証されたプレビュー URL を生成できます。

.. Docker and Ambassador Labs are working together to make running a hybrid local-remote development environment easy and seamless. You can now connect your Docker ID to Ambassador Cloud to sign in and use Telepresence. To get started:

Docker と Ambassador Labs はローカルとリモートのハイブリッドな開発環境を、簡単かつシームレスにできるようにするため協働しています。Ambassador Cloud にサインインして Telepresence を使うには、自分の Docker ID で接続できます。始めるには：

..  Go to the Docker × Ambassador page.
    Sign in using your Docker ID.
    Authorize the Ambassador Cloud app.

1. `Docker × Ambassador page  <https://app.getambassador.io/auth/realms/production/protocol/openid-connect/auth?client_id=docker-docs&response_type=code&redirect_uri=https%3A%2F%2Fapp.getambassador.io&utm_source=docker-docs&utm_medium=dockerwebsite&utm_campaign=Docker%26TP>`_ ページに移動します。
2. 自分の Docker ID にサインインします。
3. Ambassador Cloud アプリを認証します。

.. This takes you to a step-by-step guide on setting up Telepresence, connecting to a development cluster, and creating intercepts.

Telepresence のセットアップ、開発クラスタに接続し、それから傍受の作成について、手順を追って説明します。


.. seealso::

   Using Kubernetes for remote development
      https://docs.docker.com/develop/remote-development/


