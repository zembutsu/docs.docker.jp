.. -*- coding: utf-8 -*-
.. https://docs.docker.com/linux/step_two/
.. doc version: 1.10
.. check date: 2016/4/13
.. -----------------------------------------------------------------------------

.. Learn about images & containers

.. _learn-about-images-containers-linux:

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

.. A container is a stripped-to-basics version of a Linux operating system. An image is software you load into a container. When you ran the command, the Engine Software:

コンテナを基礎まで剥がしていくと、そこには Linux オペレーティング・システムがあります。イメージとはコンテナ内に積み込むソフトウェアです。コマンドを実行すると、Engine のソフトウェアは次の処理をしました。

..    checked to see if you had the hello-world software image
    downloaded the image from the Docker Hub (more about the hub later)
    loaded the image into the container and “ran” it

* ``hello-world`` ソフトウェアのイメージを持っているかどうか確認。
* Docker Hub （詳しくは後述）からイメージをダウンロード。
* コンテナにイメージを載せて（読み込んで）「実行」する。

.. Depending on how it was built, an image might run a simple, single command and then exit. This is what Hello-World did.

イメージが何を実行するかは、イメージがどのように構築されたかに依ります。このイメージは ``Hello-World`` を表示する単純なコマンドを持ちます。

.. A Docker image, though, is capable of much more. An image can start software as complex as a database, wait for you (or someone else) to add data, store the data for later use, and then wait for the next person.

Docker イメージ次第で様々な処理ができます。データベースのような複雑なソフトウェアでも、イメージを使って実行できます。あなた（もしくは誰かが）データを追加するのに待つ必要はなく、保管したデータを使えます。さらに、次の人もすぐに使えるのです。

.. Who built the hello-world software image though? In this case, Docker did but anyone can. Docker Engine lets people (or companies) create and share software through Docker images. Using Docker Engine, you don’t have to worry about whether your computer can run the software in a Docker image — a Docker container can always run it.

さて、``hello-world`` ソフトウェアのイメージは、誰が作ったのでしょうか。このイメージは Docker が作りましたが、イメージそのものは誰でも作れます。Docker Engine は人々（あるいは会社）が作成したソフトウェアを、 Docker イメージを通して共有できるようにします。 Docker イメージ内のソフトウェアをどのコンピュータで実行すべきか、Docker Engine を使えば迷う必要がありません。なぜなら Docker コンテナをどこでも実行できるからです。

.. Where to go next

次は何をしますか
====================

.. See, that was quick wasn’t it? Now, you are ready to do some really fun stuff with Docker. Go on to the next part to find and run the whalesay image.

ご覧の通り、迅速だとは思いませんか。これで Docker を使って面白いことをする準備が整いました。次の :doc:`step_three` に進みましょう。

.. seealso:: 

   Learn about images & containers
      https://docs.docker.com/linux/step_two/
