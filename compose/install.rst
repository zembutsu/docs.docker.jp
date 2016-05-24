.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/install/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/install.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/install.md
.. check date: 2016/04/28
.. Commits on Mar 18, 2016 50fe014ba9f6af3dc75cb5f5548dcf0c9825cd05
.. -------------------------------------------------------------------

.. Install Docker Compose

.. _install-docker-compose:

=======================================
Docker Compose のインストール
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can run Compose on OS X, Windows and 64-bit Linux. To install it, you’ll need to install Docker first.

Compose は OS X、Windows、64-bit Linux で実行可能です。Compose をインストールするには、まず Docker のインストールが必要です。

.. To install Compose, do the following:

Compose のインストールは、次のように実行します。

..    Install Docker Engine version 1.7.1 or greater:
        Mac OS X installation (Toolbox installation includes both Engine and Compose)
        Ubuntu installation
        other system installations

1. Docker Engine 1.7.1 以上をインストールします。

   * :doc:`Mac OS X へのインストール </engine/installation/mac>`  （Toolbox のインストールに、Engine と Compose が含まれます）
   * :doc:`Ubuntu へのインストール </engine/installation/linux/ubuntulinux>`
   * :doc:`その他システムへのインストール </engine/installation/index>`

.. Mac OS X users are done installing. Others should continue to the next step.
.. 2. Mac OS X ユーザと Windows ユーザはインストールが完了しています。他の環境は次のステップに進みます。

.. The Docker Toolbox installation includes both Engine and Compose, so Mac and Windows users are done installing. Others should continue to the next step.

2. Docker Toolbox を使えば、 Engine と Compose の両方をインストールします。そのため、 Mac および Windows ユーザは、これでインストール完了です。次のステップに進んでも構いません。

.. Go to the Compose repository release page on GitHub.

3. `GitHub 上にある Compose リポジトリのリリース・ページ <https://github.com/docker/compose/releases>`_ に移動します。

.. Follow the instructions from the release page and run the curl command, which the release page specifies, in your terminal.

4. リリース・ページの指示に従い、ターミナル上で ``curl`` コマンドを実行します。

.. Note: If you get a “Permission denied” error, your /usr/local/bin directory probably isn’t writable and you’ll need to install Compose as the superuser. Run sudo -i, then the two commands below, then exit.

.. note::

   もし "Permission denied" エラーが表示される場合は、``/usr/local/bin`` ディレクトリに対する書き込み権限がありません。その場合は Compose をスーパーユーザで実行する必要があります。``sudo -i`` を実行し、２つのコマンドを実行してから ``exit`` します。

次の例は、コマンドの書式に関する説明です。

.. code-block:: bash

   curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

.. If you have problems installing with curl, see Alternative Install Options.

``curl`` でのインストールに問題がある場合は、 :ref:`alternative-install-option` をご覧ください。

.. Apply executable permissions to the binary:

5. バイナリに対して実行権限を追加します。

.. code-block:: bash

   $ chmod +x /usr/local/bin/docker-compose

.. Optionally, install command completion for the bash and zsh shell.

6. オプションで、``bash`` や ``zsh`` シェルの :doc:`コマンドライン補完 </compose/completion>` をインストールします。

.. Test the installation.

7. インストールを確認します。

.. code-block:: bash

   $ docker-compose --version
   docker-compose version: 1.6.2

.. Alternative install options

.. _alternative-install-option:

他のインストール方法
==============================

.. Install using pip

pip でインストール
--------------------

.. Compose can be installed from pypi using pip. If you install using pip it is highly recommended that you use a virtualenv because many operating systems have python system packages that conflict with docker-compose dependencies. See the virtualenv tutorial to get started.

Compose は `pypi <https://pypi.python.org/pypi/docker-compose>`_ から ``pip`` を使いインストールできます。インストールに ``pip`` を使う場合、 `virtualenv <https://virtualenv.pypa.io/en/latest/>`_ の利用を強く推奨します。これは多くのオペレーティング・システム上の Python システム・パッケージと、docker-compose の依存性に競合する可能性があるためです。詳しくは `virtualenv チュートリアル（英語） <http://docs.python-guide.org/en/latest/dev/virtualenvs/>`_ をご覧ください。

.. code-block:: bash

   $ pip install docker-compose

.. Note: pip version 6.0 or greater is required.

.. note::

   pip バージョン 6.0 以上が必要です。

.. Install as a container

コンテナとしてインストール
------------------------------

.. Compose can also be run inside a container, from a small bash script wrapper. To install compose as a container run:

Compose コンテナの中でも、小さな bash スクリプトのラッパーを通することが可能です。Compose をコンテナとして実行・インストールするには、次のようにします。

.. code-block:: bash

   $ curl -L https://github.com/docker/compose/releases/download/1.6.2/run.sh > /usr/local/bin/docker-compose
   $ chmod +x /usr/local/bin/docker-compose


.. Master builds

マスターのビルド
====================

.. If you’re interested in trying out a pre-release build you can download a binary from https://dl.bintray.com/docker-compose/master/. Pre-release builds allow you to try out new features before they are released, but may be less stable.

リリース直前（プレリリース）のビルドに興味があれば、バイナリを https://dl.bintray.com/docker-compose/master/ からダウンロードできます。プレリリース版のビルドにより、リリース前に新機能を試せますが、安定性に欠けるかもしれません。

.. Upgrading

アップグレード方法
====================

.. If you’re upgrading from Compose 1.2 or earlier, you’ll need to remove or migrate your existing containers after upgrading Compose. This is because, as of version 1.3, Compose uses Docker labels to keep track of containers, and so they need to be recreated with labels added.

Compose 1.2 以前からアップグレードする場合、Compose を更新後、既存のコンテナの削除・移行が必要です。これは Compose バージョン 1.3 がコンテナ追跡用に Docker ラベルを用いているためであり、ラベルを追加したものへと置き換える必要があります。

.. If Compose detects containers that were created without labels, it will refuse to run so that you don’t end up with two sets of them. If you want to keep using your existing containers (for example, because they have data volumes you want to preserve) you can use compose 1.5.x to migrate them with the following command:

Compose は作成されたコンテナにラベルがないことを検出したら、実行を拒否し、処理停止と表示します。既存のコンテナを Compose 1.5.x 以降も使い続けたい場合（たとえば、コンテナにデータ・ボリュームがあり、使い続けたい場合）は、次のコマンドで移行できます。

.. code-block:: bash

   $ docker-compose migrate-to-labels

.. Alternatively, if you’re not worried about keeping them, you can remove them. Compose will just create new ones.

あるいは、コンテナを持ち続ける必要がなければ、削除できます。Compose は新しいコンテナを作成します。

.. code-block:: bash

   $ docker rm -f -v myapp_web_1 myapp_db_1 ...

.. Unistallation

アンインストール方法
====================

.. To uninstall Docker Compose if you installed using curl:

``curl`` を使って Docker Compose をインストールした場合は、次のように削除します。

.. code-block:: bash

   $ rm /usr/local/bin/docker-compose

.. To uninstall Docker Compose if you installed using pip:

``pip`` を使って Docker Compose をインストールした場合は、次のように削除します。

.. code-block:: bash

   $ pip uninstall docker-compose

.. Note: If you get a “Permission denied” error using either of the above methods, you probably do not have the proper permissions to remove docker-compose. To force the removal, prepend sudo to either of the above commands and run again.

.. note::

   もし "Permission denied" エラーが表示される場合は、コマンドを実行する前に、``docker-compose`` を削除するための適切な権限が必要です。強制的に削除するには ``sudo`` をあらかじめ実行してから、再度先ほどのコマンドを実行します。

.. Where to go next

次はどこへ行きますか
====================

.. 
    User guide
    Getting Started
    Get started with Django
    Get started with Rails
    Get started with WordPress
    Command line reference
    Compose file reference

* :doc:`ユーザガイド <index>`
* :doc:`gettingstarted`
* :doc:`django`
* :doc:`rails`
* :doc:`wordpress`
* :doc:`reference/index`
* :doc:`compose-file`

.. seealso:: 

   Install Docker Compose
      https://docs.docker.com/compose/install/
