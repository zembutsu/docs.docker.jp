.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/dev-best-practices/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/develop/index.md
.. check date: 2022/04/25
.. Commits on Apr 22, 2022 75adef65ddf2547319451495e1ca3b8a4ce174a9
.. -----------------------------------------------------------------------------

.. Docker development best practices
.. _docker-development-best-practices:

========================================
Docker 開発ベストプラクティス
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. The following development patterns have proven to be helpful for people building applications with Docker. If you have discovered something we should add, let us know.

以下の開発パターンは、Docker でアプリケーションを構築する皆さんに役立つように実績があるものです。皆さんも何かを発見されたら、私たちが追加しますので `お知らせください <https://github.com/docker/docker.github.io/issues/new>`_ 。

.. How to keep your images small
.. _how-to-keep-your-images-small:

イメージを小さく保ち続ける方法
==============================

.. Small images are faster to pull over the network and faster to load into memory when starting containers or services. There are a few rules of thumb to keep image size small:

コンテナやサービスを開始するにあたり、小さなイメージはネットワークを経由した取得をより早く、メモリへの読み込みもより速くします。以下は、イメージを小さくし続けるためにの、経験に基づくルールです。

..    Start with an appropriate base image. For instance, if you need a JDK, consider basing your image on the official openjdk image, rather than starting with a generic ubuntu image and installing openjdk as part of the Dockerfile.

* 適切なベースイメージで始めましょう。たとえば、 JDK が必要なら、一般的な ``ubuntu``  イメージに ``openjdk`` をインストールするのではなく、公式 ``openjdk`` イメージを基盤とするのを検討します。

..    Use multistage builds. For instance, you can use the maven image to build your Java application, then reset to the tomcat image and copy the Java artifacts into the correct location to deploy your app, all in the same Dockerfile. This means that your final image doesn’t include all of the libraries and dependencies pulled in by the build, but only the artifacts and the environment needed to run them.

* :doc:`マルチステージ・ビルドを使います </develop/develop-images/multistage-build>` 。たとえば、 Java アプリケーションの構築で ``maven`` イメージを使うなら、アプリのデプロイには、 ``tomcat`` イメージをリセットし、Java の成果物を適切な場所にコピーします。これらすべてが、同じ Dockerifle 中の命令にあります。つまり、最終イメージには構築時に取得した全てのライブラリや依存関係は含みませんが、成果物と実行に必要な環境変数のみが入っています。

..        If you need to use a version of Docker that does not include multistage builds, try to reduce the number of layers in your image by minimizing the number of separate RUN commands in your Dockerfile. You can do this by consolidating multiple commands into a single RUN line and using your shell’s mechanisms to combine them together. Consider the following two fragments. The first creates two layers in the image, while the second only creates one.


   * もしも使用中の Docker がマルチステージ・ビルドに対応していないバージョンであれば、イメージのレイヤ数を減らすため、Dockerfile 中でバラバラの ``RUN`` 命令の数を最小化します。この作業時に、シェルの仕組みを使って複数の ``RUN`` 命令を1つにまとめられます。以下にある1つめのイメージには２つのレイヤがありますが、2つめのイメージは１つのレイヤしかありません。
   
   .. code-block:: bash
   
      RUN apt-get -y update
      RUN apt-get install -y python
   
   .. code-block:: bash
   
      RUN apt-get -y update && apt-get install -y python

..    If you have multiple images with a lot in common, consider creating your own base image with the shared components, and basing your unique images on that. Docker only needs to load the common layers once, and they are cached. This means that your derivative images use memory on the Docker host more efficiently and load more quickly.

* 複数のイメージで共通している部分が多いなら、共通の要素が入った :doc:`ベース・イメージ </develop/develop-images/baseimages>` を作成し、それを自分が使うイメージの基盤にするように検討しましょう。Docker は共通のレイヤーを一度読み込む必要がありますが、読み込んだあとは、それらのレイヤーはキャッシュされます。つまり、派生したイメージが Docker ホスト上で使うメモリは、効率的に、かつ処理が素早くなります。

..    To keep your production image lean but allow for debugging, consider using the production image as the base image for the debug image. Additional testing or debugging tooling can be added on top of the production image.

* 本番環境用のイメージは、スリムにし続ける必要があります。しかし、デバッグできるようにするため、本番環境用のイメージをベース イメージにした、デバッグ用のイメージ作成を検討します。テストやデバッグ用のツールの追加は、本番環境用イメージの上に追加できるでしょう。

..    When building images, always tag them with useful tags which codify version information, intended destination (prod or test, for instance), stability, or other information that is useful when deploying the application in different environments. Do not rely on the automatically-created latest tag.

* イメージの構築時、常に分かりやすいタグを付けます。タグには、バージョン情報の明示、デプロイ先の対象（たとえば ``prod`` や ``test`` ）、安定性、あるいはその他の情報が、様々なアプリケーションをデプロイする時に役立ちます。

.. Where and how to persist application data
.. _where-and-how-to-persist-application-data:

アプリケーションのデータ保持はどこで、どのように
==================================================

..  Avoid storing application data in your container’s writable layer using storage drivers. This increases the size of your container and is less efficient from an I/O perspective than using volumes or bind mounts.
    Instead, store data using volumes.
    One case where it is appropriate to use bind mounts is during development, when you may want to mount your source directory or a binary you just built into your container. For production, use a volume instead, mounting it into the same location as you mounted a bind mount during development.
    For production, use secrets to store sensitive application data used by services, and use configs for non-sensitive data such as configuration files. If you currently use standalone containers, consider migrating to use single-replica services, so that you can take advantage of these service-only features.

* :doc:`ストレージ ドライバ </storage/storagedriver/select-storage-driver>` を使って、コンテナの書き込み可能なレイヤにアプリケーションのデータを保管するのは **避けてください** 。入出力を効率化する観点からは、ボリュームやバインド マウントを使えば、コンテナの容量を小さくできます。
* データの保管はコンテナ内ではなく :doc:`ボリューム </storage/volume>` を使います。
* １つの例として、開発中であれば :doc:`バインド マウント </storage/bind-mounts>` の利用が適切です。ソースコードのあるディレクトリのマウントや、バイナリだけをコンテナ内に入れたい場合があるでしょう。本番環境では、かわりにボリュームを使い、開発中にバインド マウントしていた同じ場所を、ボリュームとしてマウントします。
* 本番環境では、 :doc:`シークレット（secret） </engine/swarm/secret>` を使い、サービスが使う、注意をはらうべき（センシティブな）アプリケーション データを保管します。また、設定ファイルのような注意を必要としないデータの保管には :doc:`構成情報（config） </engine/swarm/configs>` を使います。スタンドアロン コンテナを使っている場合は、１つの :ruby:`レプリカ サービス <replica service>` への移行を検討しましょう。そうすると、サービスのみが利用できる機能を活用できるようになります。


.. Use CI/CD for testing and deployment
.. _use-ci-cd-for-testing-and-deployment:

テストとデプロイに CI/CD を使う
========================================

..    When you check in a change to source control or create a pull request, use Docker Hub or another CI/CD pipeline to automatically build and tag a Docker image and test it.

* ソースコード管理による変更の確認や、プルリクエストの作成時、 `Docker Hub <https://docs.docker.com/docker-hub/builds/>`_ や他の CI/CD パイプラインを使い、Docker イメージの自動構築やタグ付け、テストが行えます。

.. Take this even further by requiring your development, testing, and security teams to sign images before they are deployed into production. This way, before an image is deployed into production, it has been tested and signed off by, for instance, development, quality, and security teams.

* さらに推進するには、開発、テスト、セキュリティチームに対し、本番環境ににデプロイする前に、 :doc:`イメージへの署名 </engine/reference/commandline/trust>` を求めます。この方法であれば、イメージを本番環境へデプロイする前に、たとえば開発、品質およびセキュリティチームによって、イメージのテストや署名がされています。。

.. Differences in development and production environments
.. _differences-in-development-and-production-environments:

開発環境と本番環境の違い
========================================

.. Development 	Production
.. Use bind mounts to give your container access to your source code. 	Use volumes to store container data.
.. Use Docker Desktop for Mac or Docker Desktop for Windows. 	Use Docker Engine, if possible with userns mapping for greater isolation of Docker processes from host processes.
.. Don’t worry about time drift. 	Always run an NTP client on the Docker host and within each container process and sync them all to the same NTP server. If you use swarm services, also ensure that each Docker node syncs its clocks to the same time source as the containers.

.. list-table::
   :header-rows: 1

   * - 開発環境
     - 本番環境
   * - バインド マウントを使い、コンテナがソースコードにアクセスできるようにする
     - ボリュームを使い、コンテナのデータを保管する
   * - Docker Desktop for Mac や Docker Desktop for Windows を使う
     - Docker Engine を使い、可能であれば Docker プロセスをホスト側プロセスと大きく分けるため、 :doc:`userns マッピング </engine/security/userns-remap>` を使う
   * - 時刻のズレを気にする必要はない
     - 各コンテナのプロセス内と Docker ホスト上では、常に NTP クライアントを実行し、同じ NTP サーバと全て同期する。また、コンテナと同様、 Docker の各ノードも同じ NTP サーバを使い、時刻を同期する


.. seealso::

   Docker development best practices
      https://docs.docker.com/develop/dev-best-practices/


