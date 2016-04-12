.. -*- coding: utf-8 -*-
.. https://docs.docker.com/windows/step_two/
.. doc version: 1.10
.. check date: 2016/4/10
.. -----------------------------------------------------------------------------

.. Learn about images & containers

.. _learn-about-images-containers:

========================================
イメージとコンテナを学ぶ
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Engine provides the core Docker technology that enables images and containers. As the last step in your installation, you ran the Engine docker run hello-world command. With this one command, you completed the core tasks to using Engine. The command you ran had three parts.

Docker Engine は Docker の中心となる技術を提供します。これはイメージとコンテナを扱う技術です。先ほどのステップでインストールを終えていますので、 ``docker run hello-world`` コマンドを実行できます。このコマンドを１つ実行するだけで、Engine を使う上で中心となるタスクをこなします。コマンドは３つのパーツに分かれています。

.. image:: /tutimg/container_explainer.png
   :scale: 60%
   :alt: docker run hello-world

.. A container is a stripped-to-basics version of a Linux operating system. An image is software you load into a container. When you ran the command, the Engine:

コンテナとは Linux オペレーティング・システムを基盤としています。イメージとはコンテナの中に取り込むソフトウェアです。コマンドを実行すると、Engine は以下の処理を行います。

..    checked to see if you had the hello-world software image
    downloaded the image from the Docker Hub (more about the hub later)
    loaded the image into the container and “ran” it

* ``hello-world`` ソフトウェアのイメージを持っているかどうか確認します。
* Docker Hub （詳しくは後ほど説明）からイメージをダウンロードします。
* コンテナにイメージを読み込み「実行」します。

.. Depending on how it was built, an image might run a simple, single command and then exit. This is what Hello-World did.

イメージが何を実行するかは、どのように構築されたかに依存します。ここでは ``Hello-World`` を表示するという単純なコマンドを実行しています。

.. A Docker image, though, is capable of much more. An image can start software as complex as a database, wait for you (or someone else) to add data, store the data for later use, and then wait for the next person.

Docker イメージによっては、様々な処理ができます。データベースのような複雑なソフトウェアも、イメージを使って実行できます。あなた（もしくは誰かが）データを追加するのに待つ必要はなく、保管したデータを使えますし、次の人もすぐに利用できます。

.. Who built the hello-world software image though? In this case, Docker did but anyone can. Docker Engine lets people (or companies) create and share software through Docker images. Using Docker Engine, you don’t have to worry about whether your computer can run the software in a Docker image — a Docker container can always run it.

``hello-world`` ソフトウェアのイメージは、誰が作ったのでしょうか？ これは Docker が作りましたが、誰でも作れます。Docker Engine は人々（あるいは会社）が作成したソフトウェアを、 Docker イメージを通して共有できるようにします。 Docker Engine を使えば、Docker イメージ内のソフトウェアを実行するため、どのコンピュータを使えば良いのか迷う必要がなくなります。Docker コンテナは、どこでも実行できるのです。

.. Where to go next

次はどこへ行きますか
====================

.. See, that was quick wasn’t it? Now, you are ready to do some really fun stuff with Docker. Go on to the next part to find and run the whalesay image.

ほら、迅速でしょう。これで Docker を使って何か面白いことをする準備が整いました。次の :doc:`step_three` に進みましょう。

.. seealso:: 

   Learn about images & containers
      https://docs.docker.com/windows/step_two/
