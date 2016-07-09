.. -*- coding: utf-8 -*-
.. https://docs.docker.com/linux/step_six/
.. doc version: 1.10
.. check date: 2016/4/13
.. -----------------------------------------------------------------------------

.. Tag, push, and pull your image

.. _tag-push-and-pull-your-image-linux:

========================================
イメージのタグ付け、送信、取得
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. In this section, you tag and push your docker-whale image to your newly created repository. When you are done, you test the repository by pulling your new image.

このセクションでは ``docker-whale`` イメージにタグを付け、先ほど作成した自分のリポジトリにイメージを送信します。作業が後は、自分の新しいイメージをリポジトリから取得できるか確認します。

.. Step 1: Tag and push the image

.. _step-1-tag-and-push-the-image-linux:

ステップ１：イメージのタグ付けと送信
========================================

.. Go back to your terminal.

1. ターミナルに戻ります。

.. List the images you currently have:

2. 手元にあるイメージの一覧を表示します。

.. code-block:: bash

   $ docker images
   REPOSITORY           TAG          IMAGE ID            CREATED             VIRTUAL SIZE
   docker-whale         latest       7d9495d03763        38 minutes ago      273.7 MB
   <none>               <none>       5dac217f722c        45 minutes ago      273.7 MB
   docker/whalesay      latest       fb434121fc77        4 hours ago         247 MB
   hello-world          latest       91c95931e552        5 weeks ago         910 B

..    Find the IMAGE ID for your docker-whale image.

3. ``docker-whale`` イメージの ``イメージ ID`` を確認します。

..    In this example, the id is 7d9495d03763.

この例の ID は ``7d9495d03763`` です。

..    Notice that currently, the REPOSITORY shows the repo name docker-whale but not the namespace. You need to include the namespace for Docker Hub to associate it with your account. The namespace is the same as your Docker Hub account name. You need to rename the image to YOUR_DOCKERHUB_NAME/docker-whale.

現時点の ``REPOSITORY`` にあるリポジトリ名は ``docker-whale`` ですが、名前空間（namespace）がありません。名前空間は Docker Hub 上の自分のアカウントに関連付いています。この名前空間は自分の Docker Hub アカウント名と同じです。そのため、イメージを ``自分のアカウント名/docker-whale`` に名称変更する必要があります。

..    Use IMAGE ID and the docker tag command to tag your docker-whale image.

4. ``docker tag`` コマンドと ``イメージ ID`` を指定し、  ``docker-whale``  イメージをタグ付けします。

..    The command you type looks like this:

入力するコマンドには、次の意味があります。

.. image:: /tutimg/tagger.png

..    Of course, your account name will be your own. So, you type the command with your image’s ID and your account name and press RETURN.

もちろん、アカウント名は自分自身のものです。そのため、イメージ ID やアカウント名は自分のものを入力し、リターンキーを押します。

.. code-block:: bash

   $ docker tag 7d9495d03763 maryatdocker/docker-whale:latest

..    Type the docker images command again to see your newly tagged image.

5. ``docker images`` コマンドをもう一度実行して、新しくタグ付けされたイメージがあるかどうか確認します。

.. code-block:: bash

   $ docker images
   REPOSITORY                  TAG       IMAGE ID        CREATED          VIRTUAL SIZE
   maryatdocker/docker-whale   latest    7d9495d03763    5 minutes ago    273.7 MB
   docker-whale                latest    7d9495d03763    2 hours ago      273.7 MB
   <none>                      <none>    5dac217f722c    5 hours ago      273.7 MB
   docker/whalesay             latest    fb434121fc77    5 hours ago      247 MB
   hello-world                 latest    91c95931e552    5 weeks ago      910 B

..    Use the docker login command to log into the Docker Hub from the command line.

6. コマンドライン上で ``docker login`` コマンドを使い Docker Hub にログインします。

..    The format for the login command is:

ログインコマンドの書式は次の通りです。

.. code-block:: bash

   docker login --username=yourhubusername --email=youremail@company.com

..    When prompted, enter your password and press enter. So, for example:

入力を促すプロンプトが表示されたら、パスワードを入力してエンターを押します。実行例：

.. code-block:: bash

   $ docker login --username=maryatdocker --email=mary@docker.com
   Password:
   WARNING: login credentials saved in C:\Users\sven\.docker\config.json
   Login Succeeded

..    Type the docker push command to push your image to your new repository.

7. ``docker push`` コマンドを実行し、自分のイメージをリポジトリに送信します。

.. code-block:: bash

   $ docker push maryatdocker/docker-whale
       The push refers to a repository [maryatdocker/docker-whale] (len: 1)
       7d9495d03763: Image already exists
       c81071adeeb5: Image successfully pushed
       eb06e47a01d2: Image successfully pushed
       fb434121fc77: Image successfully pushed
       5d5bd9951e26: Image successfully pushed
       99da72cfe067: Image successfully pushed
       1722f41ddcb5: Image successfully pushed
       5b74edbcaa5b: Image successfully pushed
       676c4a1897e6: Image successfully pushed
       07f8e8c5e660: Image successfully pushed
       37bea4ee0c81: Image successfully pushed
       a82efea989f9: Image successfully pushed
       e9e06b06e14c: Image successfully pushed
       Digest: sha256:ad89e88beb7dc73bf55d456e2c600e0a39dd6c9500d7cd8d1025626c4b985011

..    Return to your profile on Docker Hub to see your new image.

8. 自分の Docker Hub のプロフィールページに戻ります。新しいイメージの情報が表示されています。

.. image:: /tutimg/new_image.png
   :scale: 60%

.. Step 2: Pull your new image

.. _step-2-pull-your-new-image-linux:

ステップ２：新しいイメージの取得
========================================

.. In this last section, you’ll pull the image you just pushed to hub. Before you do that though, you’ll need to remove the original image from your local machine. If you left the original image on your machine. Docker would not pull from the hub — why would it? The two images are identical.

最後のセクションでは、Docker Hub に送信(push)したイメージを取得(pull)します。作業を進める前に、これまでローカルマシン上で作成したオリジナルのイメージを削除します。マシン上にオリジナルのイメージを残しておいたままでは、Docker は Docker Hub からイメージを取得しません。これは両方のイメージが同じと認識されるためです。

..    Place your cursor at the prompt in your erminal window.

1. ターミナルのウインドウ上のプロンプトに、カーソルを合わせます。

..    Type docker images to list the images you currently have on your local machine.

2. ``docker images`` を入力し、ローカルマシン上にあるイメージの一覧を表示します。

.. code-block:: bash

   $ docker images
   REPOSITORY                  TAG       IMAGE ID        CREATED          VIRTUAL SIZE
   maryatdocker/docker-whale   latest    7d9495d03763    5 minutes ago    273.7 MB
   docker-whale                latest    7d9495d03763    2 hours ago      273.7 MB
   <none>                      <none>    5dac217f722c    5 hours ago      273.7 MB
   docker/whalesay             latest    fb434121fc77    5 hours ago      247 MB
   hello-world                 latest    91c95931e552    5 weeks ago      910 B

..    To make a good test, you need to remove the maryatdocker/docker-whale and docker-whale images from your local system. Removing them forces the next docker pull to get the image from your repository.

テストを正しく行うため、ローカルのシステム上から ``maryatdocker/docker-whale``  と ``docker-whale`` イメージを削除します。次の ``docker pull`` コマンドを実行する前に、リポジトリからイメージを削除します。

..    Use the docker rmi to remove the maryatdocker/docker-whale and docker-whale images.

3. ``docker rmi`` コマンドを使い、 ``maryatdocker/docker-whale`` と ``docker-whale`` イメージを削除します。

..    You can use an ID or the name to remove an image.

イメージを削除するにはイメージ ID かイメージ名を使います。

.. code-block:: bash

   $ docker rmi -f 7d9495d03763
   $ docker rmi -f docker-whale

..    Pull and load a new image from your repository using the docker run command.

4. ``docker run`` コマンドを使い、リポジトリから新しいイメージの取得と読み込みます。

..    The command you type should include your username from Docker Hub.

コマンド実行時、ユーザ名には Docker Hub 上の自分の名前を指定します。

.. code-block:: bash

   docker run 自分のユーザ名/docker-whale

..    Since the image is no longer available on your local system, Docker downloads it.

イメージがローカルホスト上にないため、Docker はイメージをダウンロードします。

.. code-block:: bash

    $ docker run maryatdocker/docker-whale
   Unable to find image 'maryatdocker/docker-whale:latest' locally
   latest: Pulling from maryatdocker/docker-whale
   eb06e47a01d2: Pull complete
   c81071adeeb5: Pull complete
   7d9495d03763: Already exists
   e9e06b06e14c: Already exists
   a82efea989f9: Already exists
   37bea4ee0c81: Already exists
   07f8e8c5e660: Already exists
   676c4a1897e6: Already exists
   5b74edbcaa5b: Already exists
   1722f41ddcb5: Already exists
   99da72cfe067: Already exists
   5d5bd9951e26: Already exists
   fb434121fc77: Already exists
   Digest: sha256:ad89e88beb7dc73bf55d456e2c600e0a39dd6c9500d7cd8d1025626c4b985011
   Status: Downloaded newer image for maryatdocker/docker-whale:latest
    ________________________________________
   / Having wandered helplessly into a      \
   | blinding snowstorm Sam was greatly     |
   | relieved to see a sturdy Saint Bernard |
   | dog bounding toward him with the       |
   | traditional keg of brandy strapped to  |
   | his collar.                            |
   |                                        |
   | "At last," cried Sam, "man's best      |
   \ friend -- and a great big dog, too!"   /
    ----------------------------------------
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

.. You’ve done a lot, you’ve done all of the following fundamental Docker tasks.

これで Docker の基本的なタスクを扱う全てが終了しました。

..    installed Docker
    run a software image in a container
    located an interesting image on Docker Hub
    run the image on your own machine
    modified an image to create your own and run it
    create a Docker Hub account and repository
    pushed your image to Docker Hub for others to share

* Docker をインストールする。
* コンテナでソフトウェアのイメージを実行する。
* Docker Hub 上で興味あるイメージをさがす。
* 自分のマシン上でイメージを実行する。
* 実行するイメージに対する変更を加え、イメージを作成する。
* Docker Hub 上のアカウントとリポジトリの作成。
* 他の人と共有できるよう、 Docker Hub にイメージを送信。

.. Tweet your accomplishment!

`完了したことを Tweet しましょう！ <https://twitter.com/intent/tweet?button_hashtag=dockerdocs&text=Just%20ran%20a%20container%20with%20an%20image%20I%20built.%20Find%20it%20on%20%23dockerhub.%20Build%20your%20own%3A%20http%3A%2F%2Fgoo.gl%2FMUi7cA>`_

.. You’ve only scratched the surface of what Docker can do. Go to the next page to learn more.

Docker ができることを詳しく知りたくありませんか。次のページから :doc:`より詳しく学びましょう <last_page>` 。

.. seealso:: 

   Tag, push, and pull your image
      https://docs.docker.com/linux/step_six/

