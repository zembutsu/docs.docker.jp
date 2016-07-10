.. Docker-docs-ja documentation master file, created by
   sphinx-quickstart on Sat Nov  7 10:06:34 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. doc version: 1.12
.. check date: 2016/04/14
.. -----------------------------------------------------------------------------

.. Welcome to Docker-docs-ja's documentation!

Docker ドキュメント日本語化プロジェクト
==========================================

* :doc:`about`
* :doc:`guide`
* :doc:`pdf-download`

.. attention::

  Docker 1.12 RC 向けにドキュメントの改訂作業中です。最新安定版の ``v1.11`` については `アーカイブ <http://docs.docker.jp/v1.11/>`_ をご覧ください。

.. Welcome to the Docker Documentation

Docker ドキュメントへようこそ
==========================================


* :doc:`Docker for Mac </docker-for-mac/index>`

   Mac 上で全ての Docker ツールを実行するために、OS X サンドボックス・セキュリティ・モデルを使うネイティブなアプリケーションです。

* :doc:`Docker for Windows </docker-for-windows/index>`

   Windows コンピュータ上で全ての Docker ツールを実行するためのネイティブ Windows アプリケーションです。

* :doc:`Docker for Linux </engine/installation/linux/index>`

   コンピュータにインストール済みの Linux ディストリビューション上に Docker をインストールします。

* :doc:`Docker Engine （エンジン）</engine/installation/index>`

   Docker イメージを作成し、Docker コンテナを実行します。
   v.1.12.0-rc1 以降は、Engine の :doc:`swarm モード </engine/swarm/index>` にコンテナのオーケストレーション機能が含まれます。

* :doc:`Docker Compose （コンポーズ） </compose/overview>`

   複数のコンテナを使うアプリケーションを定義します。

* :doc:`Docker Hub （ハブ） </docker-hub/overview>`

   イメージの管理と構築のためのホステッド・レジストリ・サービスです。

* :doc:`Docker Cloud （クラウド） </docker-cloud/overview>`

   ホスト上にDocker イメージの構築、テスト、デプロイするホステッド・サービスです。

* :doc:`Docker Trusted Registry （トラステッド・レジストリ） </docker-trusted-registry/overview>`

   [DTR] でイメージの保管と署名をします。

* :doc:`Docker Universal Control Plane （ユニバーサル・コントロール・プレーン） </ucp/overview>`

   [UCP] はオンプレミス上の Docker ホストのクラスタを１台から管理します。

* :doc:`Docker Machine （マシン） </machine/overview>`

   ネットワークまたはクラウド上へ自動的にコンテナをプロビジョニングします。Windows、Mac OS X、Linux で使えます。


----

Doc v1.12 RC 目次
====================

.. toctree::
   :caption: Docker を始めましょう - 導入ガイド
   :maxdepth: 1

   windows/toc.rst
   mac/toc.rst
 
.. toctree::
   :caption: Docker Engine
   :maxdepth: 2

   engine/toc.rst

.. toctree::
   :caption: Docker Compose
   :maxdepth: 2

   compose/toc.rst

.. toctree::
   :caption: Docker Hub
   :maxdepth: 2

   docker-hub/index.rst

.. toctree::
   :caption: Docker Machine
   :maxdepth: 2

   machine/index.rst

.. toctree::
   :caption: Docker Toolbox
   :maxdepth: 2

   Docker Toolbox <toolbox/index.rst>

.. toctree::
   :caption: コンポーネント・プロジェクト
   :maxdepth: 2

   registry/toc.rst
   swarm/toc.rst


About
==============================

.. toctree::
   :maxdepth: 3
   :caption: Docker について

   release-notes.rst
   engine/reference/glossary.rst
   about.rst
   guide.rst
   pdf-download.rst


Docs archive
====================

.. toctree::
   :maxdepth: 1
   :caption: Docs アーカイブ
   
   v1.11 <http://docs.docker.jp/v1.11/>
   v1.10 <http://docs.docker.jp/v1.10/>
   v1.9 <http://docs.docker.jp/v1.9/>


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

