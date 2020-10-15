.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/part2/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/get-started/part2.md
.. check date: 2020/06/16
.. Commits on May 22, 2020 ba08845b64d6b9f4387148ab878b1e7dafaaf50f
.. -----------------------------------------------------------------------------

.. Build and run your image

.. _build-and-run-your-image:

========================================
イメージの構築と実行
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Prerequisites

.. _part2-prerequisites:

必要条件
==========

.. Work through the orientation and setup in Part 1.

* :doc:`Part 1 <index>` の概要とセットアップを一通り読んでください。

.. Introduction

.. _part2-introduction:
=========
はじめに
==========

.. It’s time to begin building an app the Docker way. We’ll start at the bottom of the hierarchy of such an app, which is a container, which we cover on this page. Above this level is a service, which defines how containers behave in production, covered in Part 3. Finally, at the top level is the stack, defining the interactions of all the services, covered in Part 5.

Docker を使い、アプリケーションを作り始めましょう。コンテナを用いたアプリケーション階層の底部を、このページから始めます。このレベルの上位にあるのがサービスであり、プロダクションにおけるコンテナの挙動を定義します。こちらは :doc:`Part3 <part3>` で扱います。最終的にはスタックの頂上、つまり、 :doc:`Part5 <part5>` で扱うすべてのサービスの挙動を定義します。

..    Stack
    Services
    Container (you are here)

* スタック ``Stack``
* サービス ``Services``
* コンテナ（今ここにいます）

.. Your new development environment

.. _your-new-development-environment:

新しい開発環境
====================

.. In the past, if you were to start writing a Python app, your first order of business was to install a Python runtime onto your machine. But, that creates a situation where the environment on your machine has to be just so in order for your app to run as expected; ditto for the server that runs your app.

Python アプリケーションを書き始めるにあたり、自分のマシン上に Python ランタイムをインストールするのが、これまでは一番初めの仕事でした。しかし、サーバ上でもアプリケーションが期待する通りに問題なく動作するには、マシンと同じ環境を作成しなくてはいけません。

.. With Docker, you can just grab a portable Python runtime as an image, no installation necessary. Then, your build can include the base Python image right alongside your app code, ensuring that your app, its dependencies, and the runtime, all travel together.

Docker であれば、移動可能な Python ランタイムをイメージ内に収容しているため、インストールは不要です。そして、ベース Python イメージにはアプリのコードも一緒に構築できますし、アプリを確実に動かすための依存関係やランタイムも全て運べます。

.. These portable images are defined by something called a Dockerfile.

移動可能なイメージは ``Dockerfile`` と呼ばれるモノで定義します。

.. Define a container with a Dockerfile

.. _define-a-container-with-a-dockerfile:

``Dockerfile`` でコンテナの定義
========================================

.. Dockerfile will define what goes on in the environment inside your container. Access to resources like networking interfaces and disk drives is virtualized inside this environment, which is isolated from the rest of your system, so you have to map ports to the outside world, and be specific about what files you want to “copy in” to that environment. However, after doing that, you can expect that the build of your app defined in this Dockerfile will behave exactly the same wherever it runs.

``Dockerfile`` では、コンテナ内の環境で何をするかを定義します。ネットワーク・インターフェースとディスク・ドライバのようなリソースは、システム上の他の環境からは隔離された環境内に仮想化されています。このようなリソースに接続するには、ポートを外の世界にマッピング（割り当て）する必要がありますし、どのファイルを環境に「複製」（copy in）するか指定する必要もあります。しかしながら、これらの作業を ``Dockerfile`` における構築時の定義で済ませておけば、どこで実行しても同じ挙動となります。

.. Dockerfile

はじめに
==============================

.. Now that you’ve set up your development environment, you can begin to develop containerized applications. In general, the development workflow looks like this:

これまで開発環境のセットアップを整えましたので、コンテナ化アプリケーションの開発を始められるようになりました。一般的に、開発ワークフローとは以下のようなものです。

..    Create and test individual containers for each component of your application by first creating Docker images.
..    Assemble your containers and supporting infrastructure into a complete application.
..    Test, share, and deploy your complete containerized application.

1. アプリケーションの各コンポーネントに対する個々ののコンテナを Docker イメージから作成し、作成およびテストします。
2. コンテナと支える基盤（インフラ）を組み合わせ、アプリケーションを完成します。
3. 完全したコンテナ化アプリケーションをテスト、共有、デプロイします。

.. In this stage of the tutorial, let’s focus on step 1 of this workflow: creating the images that your containers will be based on. Remember, a Docker image captures the private filesystem that your containerized processes will run in; you need to create an image that contains just what your application needs to run.

このチュートリアルの段階では、ワークフローの手順1にフォーカスします。ここでは、コンテナのベースとなるイメージを作成します。Docker イメージが扱うプライベート・ファイルシステムとは、コンテナ化したプロセスを実行する場所だと忘れないでください。つまり、アプリケーションを実行するために必要な何かを含むイメージを作成する必要があります。

.. Set up

.. _part2-setup:

セットアップ
==============================

.. Let us download the node-bulletin-board example project. This is a simple bulletin board application written in Node.js.

それでは ``node-bulletin-board`` プロジェクト例をダウンロードしましょう。これは Node.js で書かれたシンプルな掲示板アプリケーションです。

..  Git
    Windows (without Git)
    Mac or Linux (without Git)

Git
^^^^^^^^^

.. If you are using Git, you can clone the example project from GitHub:

Git を使用しているのであれば、GitHub からプロジェクト例をクローンできます：

.. code-block:: bash

   git clone https://github.com/dockersamples/node-bulletin-board
   cd node-bulletin-board/bulletin-board-app

Windows （Git 無し）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. If you are using a Windows machine and prefer to download the example project without installing Git, run the following commands in PowerShell:

Windows マシンを使用中で、Git をインストールせずにプロジェクト例をダウンロードしたい場合は、PowerShell 上で以下のコマンドを実行します。

.. code-block:: bash

   curl.exe -LO https://github.com/dockersamples/node-bulletin-board/archive/master.zip
   tar.exe xf master.zip
   cd node-bulletin-board-master\bulletin-board-app

Mac or Linux （Git 無し）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. If you are using a Mac or a Linux machine and prefer to download the example project without installing Git, run the following commands in a terminal:

Mac あるいは Linux マシンを使用中で、Git をインストールせずにプロジェクト例をダウンロードしたい場合は、ターミナル上で以下のコマンドを実行します。

.. code-block:: bash

   curl -LO https://github.com/dockersamples/node-bulletin-board/archive/master.zip
   unzip master.zip
   cd node-bulletin-board-master/bulletin-board-app

.. Define a container with Dockerfile

.. _define-a-container-with-dockerfile:

Dockerfile でコンテナを定義
==============================

.. After downloading the project, take a look at the file called Dockerfile in the bulletin board application. Dockerfiles describe how to assemble a private filesystem for a container, and can also contain some metadata describing how to run a container based on this image.

プロジェクトのダウンロード後は、掲示板アプリケーション内にある ``Dockerfile`` （ドッカーファイル）と呼ぶファイルを見ます。Dockerfile にはコンテナに対するプライベート・ファイルシステムを、どのようにして構成するかの記述があります。また、このイメージをベースとして、コンテナをどのようにして実行するかといった、複数のメタデータも含められます。

.. For more information about the Dockerfile used in the bulletin board application, see Sample Dockerfile.

掲示板アプリケーションの Dockerfile が、どのように使われているかの情報は :ref:`サンプル Dockerfile` をご覧ください。


.. Build and test your image

.. _build-and-test-your-image:

イメージの構築とテスト
==============================

.. Now that you have some source code and a Dockerfile, it’s time to build your first image, and make sure the containers launched from it work as expected.

これでソースコードと Dockerfile を準備しましたので、初めてのイメージを構築（ビルド）する時です。そして、コンテナが期待通りに動作するかどうか確かめましょう。

.. Make sure you’re in the directory node-bulletin-board/bulletin-board-app in a terminal or PowerShell using the cd command. Run the following command to build your bulletin board image:

ターミナルまたは PowerShell で ``cd`` コマンドを使い、 ``node-bulletin-board/bulletin-board-app`` ディレクトリに移動します。掲示板イメージを構築するためには、以下のコマンドを実行します。

.. code-block:: bash

   docker build --tag bulletinboard:1.0 .

.. You’ll see Docker step through each instruction in your Dockerfile, building up your image as it goes. If successful, the build process should end with a message Successfully tagged bulletinboard:1.0.

Docker を見ると、Dockerfile 中の命令ごとに、命令したとおりにイメージを構築しています。成功すると、 ``Successfully tagged bulletinboard:1.0`` というメッセージを表示して構築処理が終了します。

..    Windows users:
..    This example uses Linux containers. Make sure your environment is running Linux containers by right-clicking on the Docker logo in your system tray, and clicking Switch to Linux containers. Don’t worry - all the commands in this tutorial work the exact same way for Windows containers.
..    You may receive a message titled ‘SECURITY WARNING’ after running the image, noting the read, write, and execute permissions being set for files added to your image. We aren’t handling any sensitive information in this example, so feel free to disregard the warning in this example.

.. note::

   Windows 利用者の方へ：この例は Linux コンテナを使います。環境が Linux コンテナとして動作しているのを確認するため、システムトレイ上の Docker ロゴを右クリックし、 **Switch to Linux containers** （Linux コンテナへ切り替え）をクリックします。心配しないでください、このチュートリアルで実行するすべてのコマンドは、Windows コンテナとしても同様に機能します。イメージの実行後、「 SECURITY WARNING’」（セキュリティ警告）のタイトルがついたメッセージを表示し、イメージに対してファイル追加時に、読み書き実行権限の設定を確認する場合があります。今回の例では、センシティブな情報（機微情報）を扱っていませんので、この警告は無視して構いません。

.. Run your image as a container

.. _run-your-image-as-a-container:

コンテナとしてイメージを実行
==============================

..    Run the following command to start a container based on your new image:

1. 以下のコマンドを実行し、作成した新しいイメージをベースとするコンテナを起動します。

.. code-block:: bash

   docker run --publish 8000:8080 --detach --name bb bulletinboard:1.0

..    There are a couple of common flags here:
        --publish asks Docker to forward traffic incoming on the host’s port 8000 to the container’s port 8080. Containers have their own private set of ports, so if you want to reach one from the network, you have to forward traffic to it in this way. Otherwise, firewall rules will prevent all network traffic from reaching your container, as a default security posture.
        --detach asks Docker to run this container in the background.
        --name specifies a name with which you can refer to your container in subsequent commands, in this case bb.

ここではいくつかのフラグを指定しています：

*  ``--publish``ホストのポート 8000 に入ってくるトラフィックを、コンテナのポート 8080 に転送するよう Docker に依頼します。コンテナは、自身で一連のプライベートなポート を持っています。そのため、ネットワーク側から到達したい場合は、この方法でトラフィックを転送する必用があります。そうしなければ、ファイアウォールのルールは、デフォルトのセキュリティ方針により、コンテナに到達する全てのネットワーク・トラフィックを拒否します。
*  ``--detach`` このコンテナをバックグラウンドで実行するよう、Docker に依頼します。
* ``--name`` 続くコマンドで、コンテナを参照できる名前を指定します。今回の例では ``bb`` です。

..    Visit your application in a browser at localhost:8000. You should see your bulletin board application up and running. At this step, you would normally do everything you could to ensure your container works the way you expected; now would be the time to run unit tests, for example.

2. アプリケーションに接続するため、ブラウザで ``localhost:8000`` で開きます。そうすると、掲示板アプリケーションが稼働しているのが見えるでしょう。この段階で、コンテナがすべて期待通りに動作しているのを確認できるでしょう。つまり、これでユニットテスト等を実行できるようになります。

..    Once you’re satisfied that your bulletin board container works correctly, you can delete it:

3. 掲示板コンテナが正しく動作するのに満足したら、コンテナを削除できます。

.. code-block:: bash

   docker rm --force bb

..    The --force option stops a running container, so it can be removed. If you stop the container running with docker stop bb first, then you do not need to use --force to remove it.


``--force`` オプションは、実行中のコンテナを停止します。しかし、コンテナの削除は行いません。最初にコンテナを ``docker stop bb``  で停止したら、次は ``--force`` を使って削除する必要があります。

.. Conclusion

.. _part2-conclusion:

まとめ
==========

.. At this point, you’ve successfully built an image, performed a simple containerization of an application, and confirmed that your app runs successfully in its container. The next step will be to share your images on Docker Hub, so they can be easily downloaded and run on any destination machine.

これまでの時点で、イメージ構築、アプリケーションをシンプルにコンテナ化して処理、コンテナ内でアプリケーションが正常に実行できることに成功しました。次のステップでは `Docker Hub <https://hub.docker.com/>`_ 上にイメージを共有します。これにより、ダウンロードが簡単になり、配布先のあらゆるマシン上で実行可能になります。

.. On to Part 3 >>

* :doc:`Part 3 へ <part3>`

.. _part2-sample-dockerfile:

.. Sample Dockerfile

サンプル Dockerfile
====================

.. Writing a Dockerfile is the first step to containerizing an application. You can think of these Dockerfile commands as a step-by-step recipe on how to build up your image. The Dockerfile in the bulletin board app looks like this:

Dockerfile を書くことは、アプリケーションをコンテナ化する第一のステップです。それぞれの Dockerfile 命令が、イメージをどのように構築するかの１つ１つのレシピ（手順）と考えてください。

::

   # 親イメージとして公式イメージを使う
   FROM node:current-slim
   
   # 作業用（working）ディレクトリを指定
   WORKDIR /usr/src/app
   
   # ホスト上のファイルを現在の場所にコピー
   COPY package.json .
   
   # イメージのファイルシステム内でコマンドを実行
   RUN npm install
   
   # 実行時、コンテナが特定のポートをリッスンするよう Docker に通知
   EXPOSE 8080
   
   # コンテナ内で指定したコマンドを実行
   CMD [ "npm", "start" ]
   
   # 残りのソースコードをホスト上からイメージのファイルシステム上にコピー
   COPY . .

.. The dockerfile defined in this example takes the following steps:

サンプルの Dockerfile 定義は、以下の手順を踏みます：

..    Start FROM the pre-existing node:current-slim image. This is an official image, built by the node.js vendors and validated by Docker to be a high-quality image containing the Node.js Long Term Support (LTS) interpreter and basic dependencies.
    Use WORKDIR to specify that all subsequent actions should be taken from the directory /usr/src/app in your image filesystem (never the host’s filesystem).
    COPY the file package.json from your host to the present location (.) in your image (so in this case, to /usr/src/app/package.json)
    RUN the command npm install inside your image filesystem (which will read package.json to determine your app’s node dependencies, and install them)
    COPY in the rest of your app’s source code from your host to your image filesystem.

* ``FROM`` では既存の ``node:surrent-slim`` イメージで始めます。これは公式イメージ（ `official image` ）であり、node.js ベンダーとよって構築され、Docker が認定した高品質なイメージであり、Node.js 長期間サポート（LTS）インタプリタと基本的な依存関係を含みます。
* ``WORKDIR`` を使い、以降に続く処理すべてを、イメージのファイルシステムで（決してホスト上ではありません）指定したディレクトリ ``/usr/src/app`` 内で行うよう指定します。
* ``COPY``  は ``package.json`` をホスト上からイメージ内の現在の場所（ ``.``）にコピーします（今回の例では、 ``/usr/src/app/package.json`` にコピーします）。
* ``RUN`` はイメージ・ファイルシステム内で ``npm install`` コマンドを実行します（これにより、 ``package.json`` を読み込み、アプリケーションの node 依存会計を解決するため、必要なものをインストールします ）。
* ``COPY`` によって、残りのアプリケーション・ソースコードをホストからイメージのファイルシステムへコピーします。

.. You can see that these are much the same steps you might have taken to set up and install your app on your host. However, capturing these as a Dockerfile allows you to do the same thing inside a portable, isolated Docker image.

これらを見ると、ホスト上でアプリケーションをセットアップしてインストールするのと、ほぼ同じ手順であるのが分かるでしょう。しかしながら、Dockerfile でこれらを処理すると、ポータブルで隔離された Docker イメージ内で同じ事を行えます。

.. The steps above built up the filesystem of our image, but there are other lines in your Dockerfile.

先ほどの手順では、私たちのイメージ上でファイルシステムを構築しました。これに続き、Dockerfile に他の命令も追加できます。

.. The CMD directive is the first example of specifying some metadata in your image that describes how to run a container based on this image. In this case, it’s saying that the containerized process that this image is meant to support is npm start.

``CMD`` 命令はイメージにメタデータ（metadata）をを指定する初めての例です。この命令は、このイメージをベースに起動するコンテナが、どのように実行するかを記述します。今回の例では、 このイメージがコンテナ化したプロセスとして、 ``npm start``  をサポートするよう意図しています。

.. The EXPOSE 8080 informs Docker that the container is listening on port 8080 at runtime.

``EXPOSE 8080``  はコンテナ実行時にポート 8080  をリッスンするよう Docker に伝えます。

.. What you see above is a good way to organize a simple Dockerfile; always start with a FROM command, follow it with the steps to build up your private filesystem, and conclude with any metadata specifications. There are many more Dockerfile directives than just the few you see above. For a complete list, see the Dockerfile reference.

これまで見てきたように、シンプルな Dockerfile の編集は良い方法です。常に ``FROM``  命令で始まり、以降のステップでプライベートなファイルシステムを組み上げ、メタデータの指定で締めくくります。ここで取り上げた他にも、Dockerfile には更に多くの命令があります。詳細な一覧は :doc:`Dockerfile リファレンス </engine/reference/builder>` をご覧ください。

.. CLI references

.. _part2-cli-references:

CLI リファレンス
====================

.. Further documentation for all CLI commands used in this article are available here:

この記事で扱った全ての CLI コマンドに関する詳しいDockerは、こちらにあります。

..  docker image
    docker container
    Dockerfile reference

* :doc:`/engine/reference/commandline/image`
* :doc:`/engine/reference/commandline/container`
* :doc:`Dockerfile リファレンス </engine/reference/builder>` 

   docker build -t friendlyname .               # このディレクトリ内にある DockerFile でイメージ作成
   docker run -p 4000:80 friendlyname  # "friendlyname" の実行にあたり、ポート 4000 を 80 に割り当て
   docker run -d -p 4000:80 friendlyname                            # 同じですが、デタッチド・モード
   docker container ls                                                  # 全ての実行中コンテナを表示
   docker container ls -a                                       # 停止中も含めて全てのコンテナを表示
   docker container stop <hash>                                       # 指定したコンテナを丁寧に停止
   docker container kill <hash>                               # 指定したコンテナを強制シャットダウン
   docker container rm <hash>                                   # マシン上から指定したコンテナを削除
   docker container rm $(docker container ls -a -q)                           # 全てのコンテナを削除
   docker image ls -a                                               # マシン上の全てのイメージを表示
   docker image rm <image id>                                       # マシン上の特定のイメージを削除
   docker image rm $(docker image ls -a -q)                         # マシン上の全てのイメージを削除
   docker login                                       # CLI セッションで Docker の認証を行いログイン
   docker tag <image> username/repository:tag      # レジストリにアップロードする <image> にタグ付け
   docker push username/repository:tag                                  # タグ付けしたイメージを送信
   docker run username/repository:tag                               # レジストリにあるイメージを実行

.. seealso::

   Build and run your image
      https://docs.docker.com/get-started/part2/


