.. -*- coding: utf-8 -*-
.. Docker-docs-ja documentation master file, created by
   sphinx-quickstart on Sat Nov  7 10:06:34 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
.. -----------------------------------------------------------------------------
.. URL: https://docs.docker.com/
   doc version: 1.13
      https://github.com/docker/docker.github.io/blob/master/index.md
.. check date: 2017/01/14
.. Commits on Jan 11, 2017 443d84ec3463016e703df9b64b40a672ee8ed460
.. -----------------------------------------------------------------------------

.. Welcome to Docker-docs-ja's documentation!

Docker ドキュメント日本語化プロジェクト
==========================================

* :doc:`about` ... はじめての方へ、このサイトや翻訳について
* :doc:`guide`
* :doc:`pdf-download` （バージョンが少し古いです）

.. attention::

  * Docker `1.1`3  向けにドキュメントの改訂作業中です。古いバージョンについては `アーカイブ <http://docs.docker.jp/v1.12/>`_ をご覧ください。
  * Docker のドキュメントは常に変わり続けています。最新の情報については `公式ドキュメント <https://docs.docker.com/>`_ をご覧ください。

.. Docker Documentation

.. _docker-documentation:

Docker ドキュメント
==========================================

.. Docker provides a way to run applications securely isolated in a container, packaged with all its dependencies and libraries. Because your application can always be run with the environment it expects right in the build image, testing and deployment is simpler than ever, as your build will be fully portable and ready to run as designed in any environment. And because containers are lightweight and run without the extra load of a hypervisor, you can run many applications that all rely on different libraries and environments on a single kernel, each one never interfering with the other. This allows you to get more out of your hardware by shifting the “unit of scale” for your application from a virtual or physical machine, to a container instance.

Docker が提供するのは、アプリケーションをコンテナ内で安全に隔てた状態で実行するための手法であり、コンテナでは全ての依存関係やライブラリをパッケージ化しています。これにより、皆さんのアプリケーションを常に同じ環境で実行可能となります。イメージの構築・テスト・開発を従来よりも確実に簡単にできるようにし、構築したものはどこでも移動できるようにし、あらゆる環境で設計した通りに実行できる状態を整えます。なぜならば、コンテナは軽量であり、実行にあたっては外部のハイパーバイザの処理が不要だからです。そして、アプリケーションごとに依存するライブラリや環境を相互に影響を与えないよう１つのカーネル上で実行できるため、多くのアプリケーションが実行可能になります。その結果、アプリケーションの「スケール単位」は仮想・物理マシンのハードウェアによるものから、コンテナ・インスタンスへと変化をもたらすでしょう。

.. Typical Docker Platform Workflow

.. _typical-docker-platform-workflow:

Docker プラットフォームの典型的な作業の流れ
--------------------------------------------------

..    Get your code and its dependencies into Docker containers:
.        Write a Dockerfile that specifies the execution environment and pulls in your code.
..        If your app depends on external applications (such as Redis, or MySQL), simply find them on a registry such as Docker Hub, and refer to them in a Docker Compose file, along with a reference to your application, so they’ll run simultaneously.
..            Software providers also distribute paid software via the Docker Store.
..        Build, then run your containers on a virtual host via Docker Machine as you develop.

1. コードと依存関係を Docker :doc:`コンテナ <engine/getstarted/step_two>` に入れます。

  * :doc:`Dockerfile を作成 <engine/getstarted/step_four>` し、コードの実行環境や必要なものを指定します。
  * もしアプリケーションが外部のアプリケーション（たとえば Reds や MySQL）と連携する場合は、シンプルに :doc:`Docker Hub のようなリポジトリを検索し <docker-hub/repos>` 、 :doc:`Docker Compose ファイル  <compose/overview>` を参照し、皆さんのアプリケーションの参考にしていただくと、同様に動作するようになります。

    * また、有償ソフトウェアは `Docker Store <https://store.docker.com/>`_ で配布されています。

  * 皆さんの開発環境でコンテナの構築と実行をするには、 :doc:`Docker Machine <machine/overview>` を通した仮想ホスト上で行います。

..    Configure networking and storage for your solution, if needed.

2. 必要に応じて :doc:`ネットワーク <engine/tutorials/networkingcontainers>` や :doc:`ストレージ <engine/tutorials/dockervolumes>` を設定します。

..     Upload builds to a registry (ours, yours, or your cloud provider’s), to collaborate with your team.

3. 成果物をレジストリ（ :doc:`私たちの <engine/tutorials/dockerrepos>` 、 :doc:`皆さん自身の <docker-trusted-registry/index>` 、あるいはクラウド・プロバイダが提供する場所 ）にアップロードし、チームの皆さんと共同で作業します。

..     If you’re gonna need to scale your solution across multiple hosts (VMs or physical machines), plan for how you’ll set up your Swarm cluster and scale it to meet demand.
        Note: Use Universal Control Plane and you can manage your Swarm cluster using a friendly UI!

4. 複数のホスト上（仮想マシンや物理マシン）にスケールする必要性を検討しているならば、 :doc:`Swarm クラスタの構築方法 <engine/swarm/key-concepts/>` や、:doc:`必要に応じたスケール <engine/swarm/swarm-tutorial/>` をご検討ください。

  * メモ： :doc:`Universal Control Plane <ucp/overview>` を使えば、自分の Swarm クラスタを扱いやすいユーザ・インターフェースを通して管理できます！

..    Finally, deploy to your preferred cloud provider (or, for redundancy, multiple cloud providers) with Docker Cloud. Or, use Docker Datacenter, and deploy to your own on-premise hardware.

5. 最終的には :doc:`Docker Cloud <docker-cloud/overview>` で任意のクラウド・プロバイダ（あるいは冗長化のため複数のクラウド・プロバイダ）にデプロイします。あるいは、:doc:`Docker Datacenter <https://www.docker.com/products/docker-datacenter>`_ を使えば自分らのオンプレミス・ハードウェア上にもデプロイできます。


.. Components:

.. _components:

構成要素
==========


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

Doc v1.13 RC 目次
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

図版は `GitHub リポジトリ元 <https://github.com/docker/docker.github.io>`_ で Apache License v2 に従って配布されているデータを使っているか、配布されているデータを元に日本語化した素材を使っています。

Docs archive
====================

.. toctree::
   :maxdepth: 1
   :caption: Docs アーカイブ
   
   v1.12 <http://docs.docker.jp/v1.12/>
   v1.11 <http://docs.docker.jp/v1.11/>
   v1.10 <http://docs.docker.jp/v1.10/>
   v1.9 <http://docs.docker.jp/v1.9/>


Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

