.. -*- coding: utf-8 -*-
.. https://docs.docker.com/linux/step_one/
.. doc version: 1.10
.. check date: 2016/4/13
.. -----------------------------------------------------------------------------

.. Install Docker

.. _install-docker-linx:

==================================================
Docker のインストール
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This installation procedure is written for users who are unfamiliar with package managers. If you are comfortable with package managers, prefer not to use curl, or have problems installing and want to troubleshoot, please use our apt and yum repositories instead for your installation.

以下のインストール手順はパッケージ・マネージャに不慣れな方向けです。パッケージ・マネージャに使い慣れているのであれば、 ``curl`` の使用がインストールやトラブルシューティング上の問題になるかもしれません。その場合は ``apt`` や ``yum`` の :doc:`リポジトリを使うインストール方法 </engine/installation/index>` をご覧ください。

..    Log into your Ubuntu installation as a user with sudo privileges.

1. インストールする Ubuntu 環境に ``sudo`` 権限を持つユーザでログインします。

..    Verify that you have curl installed.

2. ``curl`` がインストールされているかを確認します。

.. code-block:: bash

   $ which curl

..    If curl isn’t installed, install it after updating your manager:

もしも ``curl`` が入っていなければ、マネージャのパッケージ情報を更新後、インストールします。

.. code-block:: bash

   $ sudo apt-get update
   $ sudo apt-get install curl 

..    Get the latest Docker package.

3. 最新の Docker パッケージを取得します。

.. code-block:: bash

   $ curl -fsSL https://get.docker.com/ | sh

..    The system prompts you for your sudo password. Then, it downloads and installs Docker and its dependencies.

``sudo`` パスワードの入力を求めるシステム・プロンプトが表示します。入力したら、 Docker と依存関係があるパッケージのダウンロードとインストールが始まります。

..        Note: If your company is behind a filtering proxy, you may find that the apt-key command fails for the Docker repo during installation. To work around this, add the key directly using the following:

.. note::

   社内環境が制限されたプロキシ配下の場合、 Docker リポジトリのインストール中に ``apt-key`` コマンドの実行に失敗するかもしれません。正常に動かすためには、以下のように直接キーを追加します。

.. code-block:: bash

   $ curl -fsSL https://get.docker.com/gpg | sudo apt-key add -

..    Verify docker is installed correctly.

4. ``docker`` のインストールが正常かどうかを確認します。

.. code-block:: bash

   $ docker run hello-world
   Unable to find image 'hello-world:latest' locally
   latest: Pulling from library/hello-world
   535020c3e8ad: Pull complete
   af340544ed62: Pull complete
   Digest: sha256:a68868bfe696c00866942e8f5ca39e3e31b79c1e50feaee4ce5e28df2f051d5c
   Status: Downloaded newer image for hello-world:latest
   
   Hello from Docker.
   This message shows that your installation appears to be working correctly.
   
   To generate this message, Docker took the following steps:
    1. The Docker Engine CLI client contacted the Docker Engine daemon.
    2. The Docker Engine daemon pulled the "hello-world" image from the Docker Hub.
    3. The Docker Engine daemon created a new container from that image which runs the
       executable that produces the output you are currently reading.
    4. The Docker Engine daemon streamed that output to the Docker Engine CLI client, which sent it
       to your terminal.
   
   To try something more ambitious, you can run an Ubuntu container with:
    $ docker run -it ubuntu bash
   
   Share images, automate workflows, and more with a free Docker Hub account:
    https://hub.docker.com
   
   For more examples and ideas, visit:
    https://docs.docker.com/userguide/


.. Where to go next

次は何をしますか
====================

.. At this point, you have successfully installed Docker. Leave the terminal window open. Now, go to the next page to read a very short introduction Docker images and containers.

以上で Docker のインストールが完了しました。画面は開いたままにします。次は :doc:`step_two` に進みます。

.. seealso:: 

   Install Docker for Windows
      https://docs.docker.com/linux/step_one/
