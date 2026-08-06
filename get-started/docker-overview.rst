.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/docker-overview/
   doc version: 27.0
.. SOURCE: https://github.com/docker/docs/blob/main/content/get-started/docker-overview.md
.. check date: 2024/12/30
.. Commits on Sep 10, 2024 6e4790e2912429d3e06e461d60732a7a5dba3c2a
.. -----------------------------------------------------------------------------

.. Docker Overview
.. _docker-overview:

=======================================
Docker とは何か？
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker is an open platform for developing, shipping, and running applications. Docker enables you to separate your applications from your infrastructure so you can deliver software quickly. With Docker, you can manage your infrastructure in the same ways you manage your applications. By taking advantage of Docker's methodologies for shipping, testing, and deploying code, you can significantly reduce the delay between writing code and running it in production.

Docker はアプリケーションを開発（developing）、移動（shipping）、実行（running）するためのオープンなプラットフォームです。Docker はインフラストラクチャ [#infractructure]_ とアプリケーションを切り離すため、ソフトウェアを短時間で提供できます。Docker があれば、アプリケーションを管理するのと同じ方法で、インフラも管理できます。テストやコードをデプロイに Docker 的な手法を活用すると、コードの記述からプロダクション（実行環境）で動かすまでにかかる時間を大幅に短縮できます。

.. [#infractructure] 訳者注：インフラ（infrastructure）とは、サーバやネットワークなど計算資源の基盤となるもの。

.. The Docker platform
.. _the-docker-platform:

Docker プラットフォーム
==============================

.. Docker provides the ability to package and run an application in a loosely isolated environment called a container. The isolation and security lets you run many containers simultaneously on a given host. Containers are lightweight and contain everything needed to run the application, so you don't need to rely on what's installed on the host. You can share containers while you work, and be sure that everyone you share with gets the same container that works in the same way.

Docker は、コンテナ（container）という緩やかに隔離された環境 [#isolated]_ （isolated environment）で、アプリケーションのパッケージ化と実行をする機能を提供します。この分離と安全性により、実行するホスト上で多くのコンテナを同時に実行できるようにします。コンテナは軽量であり、アプリケーションの実行に必要な全てが入っているため、ホスト上で何をインストールしていようが関係ありません。作業中でも手軽にコンテナを共有できますので、あなたが共有したコンテナを使う全ての人が、同じコンテナを、同じ方法で、確実に動作できるようにします。

.. [#isolated] 隔離された環境とは "isolated environment" の訳。隔離されて離された環境というよりも、部屋の中を仕切るようなイメージが近いです。

.. Docker provides tooling and a platform to manage the lifecycle of your containers:

Docker は、コンテナのライフサイクル（全過程）を管理するツールとプラットフォームを提供します。

.. 
    Develop your application and its supporting components using containers.
    The container becomes the unit for distributing and testing your application.
    When you’re ready, deploy your application into your production environment, as a container or an orchestrated service. This works the same whether your production environment is a local data center, a cloud provider, or a hybrid of the two.

* コンテナを利用して、アプリケーションとそれをサポートするコンポーネント [#component]_ を開発。
* コンテナは、アプリケーションの配布とテストをする単位。
* 準備ができたら実環境（運用環境）にアプリケーションをデプロイします。デプロイの単位は、１つのコンテナか、あるいはオーケストレーション（orchestrated [#orchestrated]_ ）された１つのサービスです。あなたの実環境は、構内のデータセンタやクラウドプロバイダや、あるいは両者の組み合わせ（ハイブリッド）でも動作します。

.. [#component] このコンポーネントとは、Docker をとりまく各種ツール群やサービスです。
.. [#orchestrated] 原文は "orchestrated service" 。複数台のサーバ上で、サービスを一斉かつ自動的に制御する動作です。

.. What can I use Docker for?
.. _what-can-i-use-docker-for:

Docker は何に使えますか？
========================================

.. Fast, consistent delivery of your applications
.. _fast-consistent-delivery-of-your-applications:

素早く一貫性を保つアプリケーションのデリバリ
--------------------------------------------------

.. Docker streamlines the development lifecycle by allowing developers to work in standardized environments using local containers which provide your applications and services. Containers are great for continuous integration and continuous delivery (CI/CD) workflows.

Docker は開発のライフサイクルを効率化します。開発するアプリケーションやサービスがローカルなコンテナ内に実現でき、開発者は標準化された環境により作業が進められるからです。コンテナを使った開発は、継続的インテグレーション (continuous integration; CI) や継続的開発 (continuous delivery; CD) のワークフローに適しています。

.. Consider the following example scenario:

次のような利用場面を考えましょう。

..  Your developers write code locally and share their work with their colleagues using Docker containers.
    They use Docker to push their applications into a test environment and execute automated and manual tests.
    When developers find bugs, they can fix them in the development environment and redeploy them to the test environment for testing and validation.
    When testing is complete, getting the fix to the customer is as simple as pushing the updated image to the production environment.

* 開発者がローカルでコードを書き、仲間とその作業を共有するために Docker コンテナを使います。
* Docker によりアプリケーションをテスト環境に投入し、自動および手動のテストを実行します。
* 開発者がバグを発見したら、開発環境においてこれを修正して、アプリケーションをテスト環境に再デプロイし、テスト確認を行います。
* テストが完了します。この後にユーザが修正版を利用できるようにするのと、更新済イメージを本番環境へ投入するのは同じく容易です。

.. Responsive deployment and scaling
.. _responsive-deployment-and-scaling:

迅速なデプロイとスケーリング
----------------------------------------

.. Docker’s container-based platform allows for highly portable workloads. Docker containers can run on a developer’s local laptop, on physical or virtual machines in a data center, on cloud providers, or in a mixture of environments.

Docker によるコンテナベースのプラットフォームは、処理負荷の高度な分散を考慮しています。Docker コンテナは、開発者のノートパソコン上で実行できるだけでなく、データセンタの物理マシンや仮想マシン、クラウドプロバイダ、そしてさまざまな環境の組み合わせにおいて実行可能です。

.. Docker’s portability and lightweight nature also make it easy to dynamically manage workloads, scaling up or tearing down applications and services as business needs dictate, in near real time.

Docker の可搬性（ポータビリティ）と軽量な特性は、次の項目を容易に実現します。それは処理負荷を動的に管理できるため、ビジネスシーンでの要求に応じてアプリケーションのスケールアップや提供終了を簡単に、しかもほぼリアルタイムで行えます。

.. Running more workloads on the same hardware
.. _running-more-workloads-on-the-same-hardware:

同じハードウェア上で負荷の高い処理を実行
----------------------------------------

.. Docker is lightweight and fast. It provides a viable, cost-effective alternative to hypervisor-based virtual machines, so you can use more of your server capacity to achieve your business goals. Docker is perfect for high density environments and for small and medium deployments where you need to do more with fewer resources.

Docker は軽量かつ高速です。ハイパーバイザ・ベースの仮想マシンに取って変わる、実用的で費用対効果の高いものです。したがってサーバ性能をフルに活用してビジネス目標を達成できます。Docker は高度に処理集中する環境に適しており、さらには中小規模の、より少ないリソースの中でのシステム構築にも適しています。

.. Docker architecture
.. _docker-architecture:

Docker のアーキテクチャ
==============================

.. Docker uses a client-server architecture. The Docker client talks to the Docker daemon, which does the heavy lifting of building, running, and distributing your Docker containers. The Docker client and daemon can run on the same system, or you can connect a Docker client to a remote Docker daemon. The Docker client and daemon communicate using a REST API, over UNIX sockets or a network interface. Another Docker client is Docker Compose, that lets you work with applications consisting of a set of containers.

Docker はクライアント・サーバ型のアーキテクチャを採用しています。Docker *クライアント* は Docker デーモンに処理を依頼します。このデーモンは、Docker コンテナの構築、実行、配布という複雑な仕事をこなします。Docker クライアントとデーモンは同一システム上で動かすのも *可能* ですが、別のシステム上であっても、Docker クライアントからリモートにある Docker デーモンへのアクセスが可能です。Docker クライアントとデーモンの間の通信には REST API が利用され、UNIX ソケットまたはネット・ワークインターフェースを介して行われます。他にも Docker クライアントには Docker Compose があり、コンテナ一式で構成されるアプリケーションを操作します。

.. image:: /assets/images/architecture.png
   :alt: Docker アーキテクチャ図

.. The Docker daemon

Docker デーモン
--------------------

.. The Docker daemon (dockerd) listens for Docker API requests and manages Docker objects such as images, containers, networks, and volumes. A daemon can also communicate with other daemons to manage Docker services.

Docker デーモン（ ``dockerd`` ）は Docker API リクエストを受け付け、イメージ、コンテナ、ネットワーク、ボリュームといった Docker オブジェクトを管理します。また、Docker サービスを管理するため、他のデーモンとも通信を行います。

.. The Docker client

Docker クライアント
--------------------

.. The Docker client (docker) is the primary way that many Docker users interact with Docker. When you use commands such as docker run, the client sends these commands to dockerd, which carries them out. The docker command uses the Docker API. The Docker client can communicate with more than one daemon.

Docker クライアント（ ``docker`` ）は Docker とのやりとりを行うために、たいていのユーザが利用するものです。``docker run`` のようなコマンドが実行されると、Docker クライアントは ``dockerd`` にそのコマンドを伝えます。そして ``dockerd`` はその内容を実現します。``docker`` コマンドは Docker API を利用しています。Docker クライアントは複数のデーモンと通信できます。

.. _overview-docker-desktop:

Docker デスクトップ
--------------------

.. Docker Desktop is an easy-to-install application for your Mac, Windows or Linux environment that enables you to build and share containerized applications and microservices. Docker Desktop includes the Docker daemon (dockerd), the Docker client (docker), Docker Compose, Docker Content Trust, Kubernetes, and Credential Helper. For more information, see Docker Desktop.

Docker デスクトップは Mac や Windows や Linux 環境へ簡単にインストールできるアプリケーションです。これを使えば、 :ruby:`コンテナ化 <containerlized>` したアプリケーションとマイクロサービスを構築・共有できるようになります。Docker デスクトップに含まれるのは Docker デーモン（ ``dockerd`` ）、Docker クライアント（ ``docker`` ）、Docker Compose、Docker Content Trust、Kubernetes、 :ruby:`Credential Helper <認証情報ヘルパー>` です。詳しい情報は :doc:`Docker Desktop </desktop/index>` をご覧ください。


.. _docker-registries:

Docker レジストリ
--------------------

.. A Docker registry stores Docker images. Docker Hub is a public registry that anyone can use, and Docker looks for images on Docker Hub by default. You can even run your own private registry.

Docker レジストリは Docker イメージを保管します。Docker Hub は公開レジストリであり、誰でも利用できます。また  Docker はデフォルトで Docker Hub のイメージを探す設定です。独自にプライベート・レジストリを運用できます。

.. When you use the docker pull or docker run commands, Docker pulls the required images from your configured registry. When you use the docker push command, Docker pushes your image to your configured registry.

``docker pull`` や ``docker run`` コマンドを使うと、必要とするイメージを設定されたレジストリから取得します。 ``docker push`` コマンドを使えば、イメージを指定したレジストリに送信します。

.. Docker objects
.. _overview-docker-objects:

Docker オブジェクト
--------------------

.. When you use Docker, you are creating and using images, containers, networks, volumes, plugins, and other objects. This section is a brief overview of some of those objects.

Docker の利用時は、イメージ、コンテナ、ネットワーク、ボリューム、プラグインや、その他のオブジェクトを作成・利用します。このセクションは各オブジェクトの概要を説明します。

.. Images

イメージ
^^^^^^^^^^

.. An image is a read-only template with instructions for creating a Docker container. Often, an image is based on another image, with some additional customization. For example, you may build an image which is based on the ubuntu image, but installs the Apache web server and your application, as well as the configuration details needed to make your application run.

イメージ（ ``image`` ）とは、Docker コンテナを作成する命令が入った読み込み専用のテンプレートです。通常イメージは、他のイメージをベースにしてそれをカスタマイズして利用します。たとえば ``ubuntu`` イメージをベースとするイメージを作ったとします。そこには Apache ウェブ・サーバや自開発したアプリケーションといったものをインストールするかもしれません。さらにアプリケーション実行に必要となる詳細な設定も加えるでしょう。

.. You might create your own images or you might only use those created by others and published in a registry. To build your own image, you create a Dockerfile with a simple syntax for defining the steps needed to create the image and run it. Each instruction in a Dockerfile creates a layer in the image. When you change the Dockerfile and rebuild the image, only those layers which have changed are rebuilt. This is part of what makes images so lightweight, small, and fast, when compared to other virtualization technologies.

イメージは作ろうと思えば作れ、他の方が作ってレジストリに公開されているイメージも使えます。イメージを自分で作る場合は Dockerfile というファイルを生成します。このファイルの文法は単純なものであり、そこにはイメージを生成して実行するまでの手順が定義されます。Dockerfile 内の個々の命令ごとに、イメージ内にはレイヤというものが生成されます。Dockerfile の内容を書き換えると、イメージが再構築されるときには、変更がかかったレイヤのみが再生成されます。他の仮想化技術に比べて Dockerイメージというものが軽量、小さい、早いを実現できているのも、そういった部分があるからです。

コンテナ
^^^^^^^^^^

.. A container is a runnable instance of an image. You can create, start, stop, move, or delete a container using the Docker API or CLI. You can connect a container to one or more networks, attach storage to it, or even create a new image based on its current state.

コンテナとは、イメージが実行状態となった実体（インスタンス）です。コンテナに対する生成、開始、停止、移動、削除は Docker API や CLI を使って行われます。コンテナは、複数のネットワークへの接続、ストレージの追加を行え、さらには現時点の状態にもとづいた新たなイメージの生成もできます。

.. By default, a container is relatively well isolated from other containers and its host machine. You can control how isolated a container’s network, storage, or other underlying subsystems are from other containers or from the host machine.

デフォルトでは、コンテナは他のコンテナやホストマシンとは、程よく分離されています。コンテナに属するネットワーク、ストレージ、基盤となるサブシステムなどを、いかにして他のコンテナやホストマシンから切り離すか、その程度は制御できます。

.. A container is defined by its image as well as any configuration options you provide to it when you create or start it. When a container is removed, any changes to its state that are not stored in persistent storage disappear.

コンテナはイメージによって定義されるものです。またこれを生成、実行するために設定したオプションによっても定義されます。コンテナを削除すると、その時点での状態に対して変更がかかっていたとしても、永続的なストレージに保存されていないものは消失します。

.. Example docker run command
.. _overview-example-docker-run-command:

``docker run`` コマンドの例
++++++++++++++++++++++++++++++

.. The following command runs an ubuntu container, attaches interactively to your local command-line session, and runs /bin/bash.

次のコマンドは ``ubuntu`` コンテナを実行し、ローカルのコマンドライン処理のセッションを結びつけます。そして ``/bin/bash`` を実行します。

.. code-block:: console

    $ docker run -i -t ubuntu /bin/bash

.. When you run this command, the following happens (assuming you are using the default registry configuration):

このコマンドを実行すると、以下のようになります（デフォルトのレジストリ設定を使用している想定です）。

..    If you do not have the ubuntu image locally, Docker pulls it from your configured registry, as though you had run docker pull ubuntu manually.

1. ``ubuntu`` イメージがローカルになければ、Docker は設定されているレジストリからイメージを取得します。この動作は手動で ``docker pull ubuntu`` を実行するのと同じです。

..    Docker creates a new container, as though you had run a docker container create command manually.

2. Docker は新しいコンテナを作成します。これは手動で ``docker create`` コマンドを実行するのと同じです。

..    Docker allocates a read-write filesystem to the container, as its final layer. This allows a running container to create or modify files and directories in its local filesystem.

3. Docker はコンテナに対して読み書き可能なファイルシステムを、最後のレイヤとして割り当てます。このため、実行中のコンテナは、コンテナ内のローカルなファイルシステムで、ファイルやディレクトリの生成や変更ができます。

..    Docker creates a network interface to connect the container to the default network, since you did not specify any networking options. This includes assigning an IP address to the container. By default, containers can connect to external networks using the host machine’s network connection.

4. Docker はネットワーク・インターフェースを生成し、コンテナをデフォルト・ネットワークに接続します。これは、ネットワークのオプションを一切指定していないからです。この処理には、コンテナに対する IP アドレスの割り当ても含みます。デフォルトでは、コンテナが外部ネットワークに接続するには、ホストマシンのネットワーク接続を利用します。

..    Docker starts the container and executes /bin/bash. Because the container is running interactively and attached to your terminal (due to the -i and -t flags), you can provide input using your keyboard while the output is logged to your terminal.

5. Docker はコンテナを起動し、 ``/bin/bash`` を実行します。コンテナは（ ``-i`` と ``-t`` のフラグにより）対話的に、かつターミナルに接続して実行しているため、手元のキーボードを使って入力でき、その間の出力はターミナル上に表示されます。

..    When you type exit to terminate the /bin/bash command, the container stops but is not removed. You can start it again or remove it.

6. ``exit`` を入力すると、 ``/bin/bash`` コマンドは終了します。コンテナは停止状態となりますが、削除はされません。コンテナは再起動や削除できます。


.. The underlying technology

基礎となる技術
====================

.. Docker is written in the Go programming language and takes advantage of several features of the Linux kernel to deliver its functionality. Docker uses a technology called namespaces to provide the isolated workspace called the container. When you run a container, Docker creates a set of namespaces for that container.

Docker は `Go プログラミング言語 <https://golang.org/>`_ で書かれており、Linux カーネルの機能をうまく活用して、さまざまな機能性を実現しています。Docker は ``namespaces`` （名前区間）技術を使い、「 :ruby:`コンテナ <container>` 」と呼ぶ :ruby:`隔離された作業空間 <isolated workspace>` を準備します。

.. These namespaces provide a layer of isolation. Each aspect of a container runs in a separate namespace and its access is limited to that namespace.

名前空間はいくつもの隔離状態を作り出します。コンテナ内のさまざまな処理は、隔離された名前空間内で実行され、それぞれへのアクセスはその名前空間内に限定されます。


.. Next steps

次のステップ
====================

.. 
    Install Docker
    Get started with Docker

* :doc:`get-docker`
* :doc:`introduction/index`

.. seealso:: 

   What is Docker?
      https://docs.docker.com/get-started/docker-overview/



