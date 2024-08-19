.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/dev-environments/create-compose-dev-env/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/dev-environments/create-compose-dev-env.md
.. check date: 2022/09/18
.. Commits on Jul 1, 2022 1645a61593f79996a3191a2c6f37ada885fe62b7
.. -----------------------------------------------------------------------------

.. Create a Compose Dev Environment
.. _create-a-compose-dev-environment:

==================================================
Compose Dev Environment の作成
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Use Dev Environments to collaborate on any Docker Compose-based projects.

Dev Environment を使い、 Docker Compose をベースとしたプロジェクトをコラボレーションします。

.. As with a simple Dev Environment, you can create a Compose Dev Environment from a:

シンプルな Dev Environment として、以下より Compose Dev Environment を作成できます：

..   Git repository
    Branch or tag of a Git repository
    Subfolder of a Git repository
    Local folder

* Git リポジトリ
* Git リポジトリのブランチやタグ
* Git リポジトリのサブフォルダ
* ローカルフォルダ

..  Note
    When cloning a Git repository using SSH, ensure you’ve added your SSH key to the ssh-agent. To do this, open a terminal and run ssh-add <path to your private ssh key>.

.. note::

   SSH を使って Git リポジトリをクローンする場合、自分の SSH 鍵を ssh-agent に追加する必要があります。そのためには、ターミナルを開き ``ssh-add <path to your private ssh key>`` を実行します。

.. Create a Compose Dev Environment
.. _create-a-compose-dev-environment:

Compose Dev Environment を作成
========================================

.. The example below, taken from the compose-dev-env project from the Docker Samples GitHub repository, demonstrates how to create a Compose Dev Environment from a Git repository.

例として、 `Docker Samples <https://github.com/dockersamples/compose-dev-env>`_ GitHub リポジトリにあるシンプルな ``compose-dev-env`` プロジェクトを使って、 Git リポジトリから Compose  Dev Environment を作成する方法を紹介します。

..  Note
   If you want to create a Compose Dev Environment from a subdirectory of a Git repo, you need to define your own compose file in a .docker folder located in your subdirectory as currently, Dev Environments is not able to detect the main language of the subdirectory.
   For more information on how to configure, see the React application with a Spring backend and a MySQL database sample or the Go server with an Nginx proxy and a Postgres database sample.

.. note::

   Git リポジトリのサブディレクトリから Compose Dev Environment を作成したい場合、現時点では、 Dev Environment はサブディレクトリの主な言語を検出できません。自分のベースイメージか、サブディレクトリ内の .docker フォルダ内にある compose ファイルで定義する必要があります。

   設定の仕方についての詳しい情報は、 `React application with a Spring backend and a MySQL database sample <https://github.com/docker/awesome-compose/tree/master/react-java-mysql>`_ や `Go server with an Nginx proxy and a Postgres database sample <https://github.com/docker/awesome-compose/tree/master/nginx-golang-postgres>`_ をご覧ください。

..     From Dev Environments, select Create. The Create a Dev Environment dialog displays.

1. **Dev Environment** から **Create** をクリックします。 **Create a Dev Environment** ダイアルログが表示されます。

..    Click Get Started and then copy https://github.com/dockersamples/compose-dev-env.git and add it to the Enter the Git Repository field on the Existing Git repo tab.

2. **Get Stated** をクリックし、 ``https://github.com/dockersamples/compose-dev-env.git`` をコピーし、それを **Existing Dev Environment** の **Enter the Git Repository** フィールドに追加します。

..    Click Continue. This initializes the project, clones the Git code, and builds the Compose application. This:
        Builds local images for services that are defined in the Compose file
        Pulls images required for other services
        Creates volumes and networks
        Starts the Compose stack

3. **Continue** をクリックします。これはプロジェクトを初期化し、 Git コードをクローンし、 Compose アプリケーションを構築します。これは：

   * Compose ファイル内で定義したサービスのローカルイメージを構築
   * 他のサービスが必要なイメージの取得
   * ボリュームとネットワークの作成
   * Compose スタックの起動

.. Once your application is up and running, you can check by opening http://localhost:8080 in your browser.

アプリケーションが起動して実行中になれば、ブラウザで http://localhost:8080 を開いて確認できます。

.. The time taken to start the Compose application depends on how your application is configured, whether the images have been built, and the number of services you have defined, for example.

Compose アプリケーションの起動にかかる時間は、アプリケーション設定の仕方に依存します。たとえば、イメージの構築にかかる時間や、定義したサービスの数によります。

.. Note that VS Code doesn’t open directly, unlike a simple Dev Environment, as there are multiple services configured. You can hover over a service and then click on the Open in VS Code button to open a specific service in VS Code. This stops the existing container and creates a new container which allows you to develop and update your service in VS Code.

シンプルな Dev Environment とは異なり複数のサービスが設定されているため、 VS Code では直接開けませんのでご注意ください。 VS Code 内で特定のサービスを開くには、サービスの上にマウスカーソルを移動し、 **Open in VS Code** ボタンをクリックします。これは、 VS Code 内でサービスの開発や更新をできるようにするため、既存のコンテナは停止し、新しいコンテナが作成されます。

.. You can now update your service and test it against your Compose application.

これで、Compose アプリケーションに対してサービスの更新やテストが行えます。

.. Set up your own Compose Dev Environment
.. _set-up-your-own-compose-dev-environment:

自分の Compose Dev Environment をセットアップ
==================================================

.. To set up a Dev Environment for your own Compose-based project, there are additional configuration steps to tell Docker Desktop how to build, start, and use the right Dev Environment image for your services.

自分の Compose ベースのプロジェクトに Dev Environment をセットアップするには、 Docker Desktop に構築、起動、実行の仕方、サービスが Dev Environment で使う正しいメージを伝える追加設定のステップがいくつかあります。

.. Dev Environments use an additional docker-compose.yaml file located in the .docker directory at the root of your project. This file allows you to define the image required for a dedicated service, the ports you’d like to expose, along with additional configuration options dedicated to Dev Environments coming in the future.

Dev Environment は、自分のプロジェクトのルート以下の ``.docker`` ディレクトリ内にある追加 ``docker-compose.yaml`` ファイルを使います。このファイルによって、専用サービス用に必要なイメージの定義や、公開したいポートだけでなく、今後の Dev Environments で追加されるオプションも扱えるようにします。

.. Take a detailed look at the docker-compose.yaml file used in the compose-dev-env sample project.

`compose-dev-env <https://github.com/dockersamples/compose-dev-env/blob/main/.docker/docker-compose.yaml>`_ サンプルプロジェクトで使われている ``docker-compose.yaml`` ファイルの詳細をみてみましょう。

.. code-block:: yaml

   version: "3.7"
   services:
     backend:
       build:
         context: backend
         target: development
       secrets:
         - db-password
       depends_on:
         - db
     db:
       image: mariadb
       restart: always
       healthcheck:
         test: [ "CMD", "mysqladmin", "ping", "-h", "127.0.0.1", "--silent" ]
         interval: 3s
         retries: 5
         start_period: 30s
       secrets:
         - db-password
       volumes:
         - db-data:/var/lib/mysql
       environment:
         - MYSQL_DATABASE=example
         - MYSQL_ROOT_PASSWORD_FILE=/run/secrets/db-password
       expose:
         - 3306
     proxy:
       build: proxy
       ports:
         - 8080:80
       depends_on:
         - backend
   volumes:
     db-data:
   secrets:
     db-password:
       file: db/password.txt

.. In the yaml file, the build context backend specifies that that the container should be built using the development stage (target attribute) of the Dockerfile located in the backend directory (context attribute)

yaml ファイル内では、構築コンテクスト ``backend`` の指定があります。指定されているのは、コンテナは ``backend`` ディレクトリ（ ``context`` 属性）内にある Dockerfile の、 ``development`` ステージ（ ``target`` 属性）を使って構築されます。

.. The development stage of the Dockerfile is defined as follows:

Dockerfile の ``development`` ステージの定義は、以下の通りです：

.. code-block:: dockerfile

   FROM golang:1.16-alpine AS build
   WORKDIR /go/src/github.com/org/repo
   COPY . .
   
   RUN go build -o server .
   
   FROM build AS development
   RUN apk update \
       && apk add git
   CMD ["go", "run", "main.go"]
   
   FROM alpine:3.12
   EXPOSE 8000
   COPY --from=build /go/src/github.com/org/repo/server /server
   CMD ["/server"]

.. The developmenttarget uses a golang:1.16-alpine image with all dependencies you need for development. You can start your project directly from VS Code and interact with the others applications or services such as the database or the frontend.

``development`` ターゲットは、開発に必要な全ての依存関係で ``golang:1.16-alpine`` イメージを使います。 VS Code からプロジェクトを直接起動でき、データベースやフロントエンドのような、他のアプリケーションやサービスとやりとりできます。

.. In the example, the Docker Compose files are the same. However, they could be different and the services defined in the main Compose file may use other targets to build or directly reference other images.

この例では、 Docker Compose ファイルは同じです。ですが、異なるファイルも指定でき、メインの Compose ファイルで定義されたサービスは、他のターゲットを使ったイメージの構築や、他のイメージを直接参照できます。

.. What’s next?

次はどうしますか？
====================

.. Learn how to share your Dev Environment

:doc:`Dev Environment を共有 <share>` する方法を学びます。

.. seealso::

   Create a Compose Dev Environment
      https://docs.docker.com/desktop/dev-environments/create-compose-dev-env/
