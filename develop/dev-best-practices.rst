.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/dev-best-practices/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/develop/index.md
.. check date: 2020/06/18
.. Commits on Aug 23, 2020 9cd60d843e5a3391a483a148033505e5879176fb
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

コンテナやサービスを開始するにあたり、小さなイメージはネットワーク越しの取得をより早くし、メモリへの読み込みもより速くします。以下にあるのは経験に基づく、イメージを小さくし続けるためのルールです。

..    Start with an appropriate base image. For instance, if you need a JDK, consider basing your image on the official openjdk image, rather than starting with a generic ubuntu image and installing openjdk as part of the Dockerfile.

* 適切なベースイメージで始めましょう。たとえば、 JDK が必要なら、一般的な ``ubuntu``  イメージに ``openjdk`` をインストールするのではなく、公式 ``openjdk`` イメージをベースにするのを検討します。

..    Use multistage builds. For instance, you can use the maven image to build your Java application, then reset to the tomcat image and copy the Java artifacts into the correct location to deploy your app, all in the same Dockerfile. This means that your final image doesn’t include all of the libraries and dependencies pulled in by the build, but only the artifacts and the environment needed to run them.

..        If you need to use a version of Docker that does not include multistage builds, try to reduce the number of layers in your image by minimizing the number of separate RUN commands in your Dockerfile. You can do this by consolidating multiple commands into a single RUN line and using your shell’s mechanisms to combine them together. Consider the following two fragments. The first creates two layers in the image, while the second only creates one.


* :doc:`マルチステージ・ビルドを使います </develop/develop-images/multistage-build>` 。たとえば、 Java アプリケーションを構築するにあたり ``maven`` イメージを使えるとします。その時、アプリをデプロイするためには、 ``tomcat`` イメージをリセットし、Java アーティファクトを適切な場所にコピーします。これらすべてが、同じ Dockerifle 中の命令としてあります。これが意味するのは、最終イメージには構築時に取得した全てのライブラリや依存関係は含みませんが、アーティファクトと実行に必要な環境変数のみが入っています。

   * もしも使用中の Docker がマルチステージ・ビルドに対応していないバージョンであれば、イメージのレイヤ数を減らすため、Dockerfile 中でバラバラの ``RUN`` 命令の数を最小化します。この作業時に、シェルの仕組みを使って複数の ``RUN`` 命令を1つにまとめられます。以下にある1つめのイメージには２つのレイヤがありますが、2つめのイメージは１つのレイヤしかありません。
   
   .. code-block:: bash
   
      RUN apt-get -y update
      RUN apt-get install -y python
   
   .. code-block:: bash
   
      RUN apt-get -y update && apt-get install -y python

..    If you have multiple images with a lot in common, consider creating your own base image with the shared components, and basing your unique images on that. Docker only needs to load the common layers once, and they are cached. This means that your derivative images use memory on the Docker host more efficiently and load more quickly.

* もしも、複数のイメージで共通している箇所が多いようであれば、共通コンポーネントが入った :doc:`ベース・イメージ </develop/develop-images/baseimages>` を作成し、それを自分が使う独自イメージのベースにするように検討します。Docker は共通のレイヤを一度読み込む必要がありますが、それらのレイヤはキャッシュされます。つまり、Docker ホスト上で派生するイメージが使うメモリは効率的になり、かつ処理が素早くなります。

..    To keep your production image lean but allow for debugging, consider using the production image as the base image for the debug image. Additional testing or debugging tooling can be added on top of the production image.

* プロダクション用のイメージは、スリムにし続ける必要があります。しかし、デバッグ可能にするため、プロダクション用イメージをベース・イメージにした、デバッグ用のイメージ作成を検討します。テストやデバッグ用のツールの追加は、プロダクション用イメージの上に追加できるでしょう。

..    When building images, always tag them with useful tags which codify version information, intended destination (prod or test, for instance), stability, or other information that is useful when deploying the application in different environments. Do not rely on the automatically-created latest tag.

* イメージの構築時、常に分かりやすいタグを付けます。タグには、バージョン情報の明示、展開先の対象（たとえば ``prod`` や ``test`` ）、安定性、あるいはその他の情報が、様々なアプリケーションをデプロイする時に役立ちます。


.. Where and how to persist application data

.. _where-and-how-to-persist-application-data:

アプリケーション・データの保持はどこで、どのように
==================================================

..  Avoid storing application data in your container’s writable layer using storage drivers. This increases the size of your container and is less efficient from an I/O perspective than using volumes or bind mounts.
    Instead, store data using volumes.
    One case where it is appropriate to use bind mounts is during development, when you may want to mount your source directory or a binary you just built into your container. For production, use a volume instead, mounting it into the same location as you mounted a bind mount during development.
    For production, use secrets to store sensitive application data used by services, and use configs for non-sensitive data such as configuration files. If you currently use standalone containers, consider migrating to use single-replica services, so that you can take advantage of these service-only features.


.. Use CI/CD for testing and deployment

.. _use ci/cd for testing and deployment:

テストとデプロイのために CI/CD を使う
========================================

..    When you check in a change to source control or create a pull request, use Docker Hub or another CI/CD pipeline to automatically build and tag a Docker image and test it.

* ソースコントロールに対する変更処理、あるいはプルリクエスト作成を処理する時、 `Docker Hub <https://docs.docker.com/docker-hub/builds/>`_ や他の CI/CD パイプラインを使い、Docker イメージの自動構築やタグ付け、テストを行えます。

..    Take this even further with by requiring your development, testing, and security teams to sign images before they are deployed into production. This way, before an image is deployed into production, it has been tested and signed off by, for instance, development, quality, and security teams.

* プロダクションにデプロイする前に、開発、テスト、セキュリティチームが  :doc:`イメージへの署名 </engine/reference/commandline/trust>` が必要となるでしょう。その場合は、イメージをプロダクションにデプロイする前に、たとえば開発、品質およびセキュリティチームによって、イメージのテストを署名をします。


.. Differences in development and production environments

.. _differences-in-development-and-production-environments:

開発環境とプロダクション環境の違い
========================================

.. Development 	Production
.. Use bind mounts to give your container access to your source code. 	Use volumes to store container data.
.. Use Docker Desktop for Mac or Docker Desktop for Windows. 	Use Docker Engine, if possible with userns mapping for greater isolation of Docker processes from host processes.
.. Don’t worry about time drift. 	Always run an NTP client on the Docker host and within each container process and sync them all to the same NTP server. If you use swarm services, also ensure that each Docker node syncs its clocks to the same time source as the containers.

.. list-table::
   :header-rows: 1


   * - 開発
     - プロダクション
   * - バインド・マウントを使い、コンテナがソースコードにアクセスできるようにする
     - ボリュームを使い、コンテナ・データを保管する
   * - Docker Desktop for Mac や Docker Desktop for Windows を使う
     - Docker Engine を使い、可能であれば Docker プロセスをホスト側プロセスと大きく隔離するため、 :doc:`userns マッピング </engine/security/userns-remap>` を使う
   * - 時刻のズレを気にする必要はない
     - 各コンテナのプロセス内と Docker ホスト上では、常に NTP クライアントを実行し、同じ NTP サーバと全て同期する。また、コンテナと同様、 Docker の各ノードも同じ時刻のソースを使って同期する


.. seealso::

   Docker development best practices
      https://docs.docker.com/develop/dev-best-practices/


