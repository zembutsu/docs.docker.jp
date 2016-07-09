.. -*- coding: utf-8 -*-
.. https://docs.docker.com/linux/step_three/
.. doc version: 1.11
.. check date: 2016/5/5
.. -----------------------------------------------------------------------------

.. Find and run the whalesay image

.. _find-and-run-the-whalesay-image-linux:

========================================
whalesay イメージの検索と実行
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. People all over the world create Docker images. You can find these images by browsing the Docker Hub. In this next section,  you’ll do just that to find the image to use in the rest of this getting started.

世界中の皆さんが Docker イメージを作成しています。公開されたイメージは Docker Hub 上で閲覧できます。このセクションではイメージを探し出し、そのイメージを使い始めましょう。

.. Step 1: Locate the whalesay image

.. _step-1-locate-the-whalesay-image-linux:

ステップ１：whalesay イメージを探す
========================================

..    Open your browser and browse to the Docker Hub.

1. ブラウザを起動し、 `Docker Hub を開きます <https://hub.docker.com/>`_ 。

.. image:: /tutimg/browse_and_search.png
   :scale: 60%
   :alt: 開いて検索

..    The Docker Hub contains images from individuals like you and official images from organizations like RedHat, IBM, Google, and a whole lot more.

Docker Hub には皆さんのような個人で作成したイメージと、何らかの組織、例えば Red Hat、IBM、Google 等が作成した公式イメージ（オフィシャル・イメージ）があります。

..    Click Browse & Search.

2. 検索フォーム ``Search`` をクリックします。

..    The browser opens the search page.

.. ブラウザで検索ページを開きます。

..    Enter the word whalesay in the search bar.

3. 検索バーに ``whalesay`` と入力します（訳者注： whalesay とは whale say = 鯨が話す、という意味です）。

.. image:: /tutimg/image_found.png
   :scale: 60%

..    Click on the docker/whalesay image in the results.

.. 検索結果にある docker/whalesay イメージをクリックします。

..    The browser displays the repository for the whalesay image.

ブラウザは whalesay イメージのリポジトリを表示します。

.. image:: /tutimg/whale_repo.png
   :scale: 60%

..    Each image repository contains information about an image. It should include information such as what kind of software the image contains and how to use it. You may notice that the whalesay image is based on a Linux distribution called Ubuntu. In the next step, you run the whalesay image on your machine.

各イメージのリポジトリにはイメージに関する情報を掲載していいます。この中には、イメージにどのような種類のソフトウェアが入っているかや、使い方の説明があるでしょう。この時点で覚えておくのは、 whalesay イメージとは Ubuntu と呼ばれる Linux ディストリビューションをベースにしていることです。次のステップでは、自分のマシン上で whalesay イメージを実行しましょう。

.. Step 2: Run the whalesay image

.. _step-2-run-the-whalesay-image-linux:

ステップ２：whaysay イメージの実行
==================================

.. Put your cursor in your terminal window at the $ prompt.

1. ターミナル・ウインドウの ``$`` プロンプトにカーソルを移動します。

..    Type the docker run docker/whalesay cowsay boo command and press RETURN.

2. ``docker run docker/whalesay cowsay boo`` コマンドを入力し、リターンキーを押します。

..    This command runs the whalesay image in a container. Your terminal should look like the following:

これはコンテナ内の whalesay イメージにあるコマンドを実行します。ターミナル上では、次のように表示されるでしょう。

.. code-block:: bash

   $ docker run docker/whalesay cowsay boo
   Unable to find image 'docker/whalesay:latest' locally
   latest: Pulling from docker/whalesay
   e9e06b06e14c: Pull complete
   a82efea989f9: Pull complete
   37bea4ee0c81: Pull complete
   07f8e8c5e660: Pull complete
   676c4a1897e6: Pull complete
   5b74edbcaa5b: Pull complete
   1722f41ddcb5: Pull complete
   99da72cfe067: Pull complete
   5d5bd9951e26: Pull complete
   fb434121fc77: Already exists
   Digest: sha256:d6ee73f978a366cf97974115abe9c4099ed59c6f75c23d03c64446bb9cd49163
   Status: Downloaded newer image for docker/whalesay:latest
    _____
   < boo >
    -----
       \
        \
         \     
                       ##        .            
                 ## ## ##       ==            
              ## ## ## ##      ===            
          /""""""""""""""""___/ ===        
     ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~   
          \______ o          __/            
           \    \        __/             
             \____\______/   

..    The first time you run a software image, the docker command looks for it on your local system. If the image isn’t there, then docker gets it from the hub.

``docker`` コマンドを手元（ローカル）のシステム上でソフトウェア・イメージを初めて実行しました。イメージが手元になければ、 ``docker`` は Docker Hub から取得します。

..    While still in the terminal, type docker images command and press RETURN.

3. ターミナルを開いたまま ``docker images`` コマンドを入力し、リターンキーを押します。

..    The command lists all the images on your local system. You should see docker/whalesay in the list.

このコマンドは手元のシステム上にある全イメージを表示します。イメージの一覧に ``docker/whalesay`` イメージが見えるでしょう。

.. code-block:: bash

   $ docker images
   REPOSITORY           TAG         IMAGE ID            CREATED            VIRTUAL SIZE
   docker/whalesay      latest      fb434121fc77        3 hours ago        247 MB
   hello-world          latest      91c95931e552        5 weeks ago        910 B

..    When you run an image in a container, Docker downloads the image to your computer. This local copy of the image saves you time. Docker only downloads the image again if the image’s source changes on the hub. You can, of course, delete the image yourself. You’ll learn more about that later. Let’s leave the image there for now because we are going to use it later.

コンテナ内でイメージの実行時、Docker は手元のコンピュータ上にイメージをダウンロードします。イメージのコピーを手元に作成するため、以降の作業で時間を節約します。Docker が再びイメージをダウンロードするのは、 Docker Hub 上の元イメージに変更が加わった時のみです。もちろん、イメージは自分で削除もできます。詳細は後ほど学びます。この後でもイメージを使うため、今はこのままにしておきます。

..    Take a moment to play with the whalesay container a bit.

4. もう少し whalesay コンテナで遊んでみましょう。

..    Try running the whalesay image again with a word or phrase. Try a long or short phrase. Can you break the cow?

``whalesay`` イメージを再度使いますが、今度は言葉を換えてみましょう。長い、もしくは短いフレーズに置き換えます。何かを話せたでしょうか。

.. code-block:: bash

   $ docker run docker/whalesay cowsay boo-boo
        _________
       < boo-boo >
        ---------
           \
            \
             \     
                           ##        .            
                     ## ## ##       ==            
                  ## ## ## ##      ===            
              /""""""""""""""""___/ ===        
         ~~~ {~~ ~~~~ ~~~ ~~~~ ~~ ~ /  ===- ~~~   
              \______ o          __/            
               \    \        __/             
                 \____\______/   

.. Where to go next

次は何をしますか
====================

.. On this page, you learned to search for images on Docker Hub. You used your command line to run an image. You learned that running an image copies it on your computer. Now, you are ready to create your own Docker image. Go on to the next part to build your own image.

このページでは Docker Hub 上のイメージを探す方法を学びました。コマンドを使ってイメージを実行しました。そして、自分のコンピュータ上にイメージをコピーし、実行する方法を学びました。次は自分で Docker イメージを作りましょう。次の :doc:`step_four` に進みます。

.. seealso:: 

   Find and run the whalesay image
      https://docs.docker.com/linux/step_three/
