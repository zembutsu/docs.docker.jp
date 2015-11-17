.. http://docs.docker.com/engine/userguide/dockerrepos/

.. _dockerrepos:

.. Store images on Docker Hub

=======================================
Docker Hub にイメージを保管する
=======================================

.. So far you’ve learned how to use the command line to run Docker on your local host. You’ve learned how to pull down images to build containers from existing images and you’ve learned how to create your own images.

これまではローカル・ホスト上の Docker を、コマンドラインで操作する方法を学びました。 :doc:`イメージを取得 <usingdocker>` し、既存のイメージからコンテナを構築する方法と、 :doc:`自分自身でイメージを作成する <dockerimages>` 方法を学びました。

.. Next, you’re going to learn how to use the Docker Hub to simplify and enhance your Docker workflows.

次は `Docker Hub <https://hub.docker.com/>`_ を簡単に使い、Docker のワークフローを拡張しましょう。

.. The Docker Hub is a public registry maintained by Docker, Inc. It contains images you can download and use to build containers. It also provides authentication, work group structure, workflow tools like webhooks and build triggers, and privacy tools like private repositories for storing images you don’t want to share publicly.

`Docker Hub <https://hub.docker.com/>`_ は Docker 社が管理する公開（パブリックな）レジストリです。ここには、ダウンロードしてコンテナ構築に使えるイメージが置かれています。また、自動化や、ワークグループの仕組み、ウェブフック（webhooks）や構築トリガ（build triggers）のようなワークフロー・ツール、一般には共有したくないイメージを保管するプライベート・レポジトリのようなプライバシー・ツールを提供します。

.. Docker Commands and Docker Hub

Docker コマンドと Docker Hub
==============================

.. Docker itself provides access to Docker Hub services via the docker search, pull, login, and push commands. This page will show you how these commands work.

Docker は、自分自身が Docker Hub のサービスに ``docker search`` 、 ``pull`` 、 ``login`` 、 ``push`` コマンドを通して接続する機能を提供します。

.. Account creation and login

アカウントの作成とログイン
------------------------------

.. Typically, you’ll want to start by creating an account on Docker Hub (if you haven’t already) and logging in. You can create your account directly on Docker Hub, or by running:

例によって、Docker Hub を使い始めるには（未作成であれば）アカウントを作成し、ログインします。 `Docker Hub 上で <https://hub.docker.com/account/signup/>`_ アカウントを作成するか、次のように実行します。

.. code-block:: bash

   $ docker login

.. This will prompt you for a user name, which will become the public namespace for your public repositories. If your user name is available, Docker will prompt you to enter a password and your e-mail address. It will then automatically log you in. You can now commit and push your own images up to your repos on Docker Hub.

このプロンプトでは、ユーザ名を入力します。これは、公開の名前空間（ネームスペース）であり、自分の公開レポジトリとして表示します。もしユーザ名が利用可能であれば、Docker はパスワードとメールアドレスの入力を促すプロンプトを表示します。あとは、自動的にログインします。あとは、自分自身のイメージのコミットや、Docker Hub 上の自分のレポジトリにイメージを送信できます。

..    Note: Your authentication credentials will be stored in the ~/.docker/config.json authentication file in your home directory.

.. note::

   自分の認証に関する情報は、自分のホームディレクトリの ``/.docker/config.json`` に保管されます。

.. Searching for images

イメージの検索
====================

.. You can search the Docker Hub registry via its search interface or by using the command line interface. Searching can find images by image name, user name, or description:

（ブラウザの）検索インターフェースかコマンドライン・インターフェースを通して、 `Docker Hub <https://hub.docker.com/>`_ レジストリを検索できます。イメージの検索は、イメージ名、ユーザ名、説明文に対して可能です。

.. code-block:: bash

   $ docker search centos
   NAME           DESCRIPTION                                     STARS     OFFICIAL   AUTOMATED
   centos         The official build of CentOS                    1223      [OK]
   tianon/centos  CentOS 5 and 6, created using rinse instea...   33
   ...

.. There you can see two example results: centos and tianon/centos. The second result shows that it comes from the public repository of a user, named tianon/, while the first result, centos, doesn’t explicitly list a repository which means that it comes from the trusted top-level namespace for Official Repositories. The / character separates a user’s repository from the image name.

ここでは ``centos`` と ``tianon/centos`` という、２つの結果が表示されました。後者は ``tianon/`` という名前のユーザによるパブリック・ポジトリです。１つめの結果 ``centos`` とは明確に異なったレポジトリです。１つめの ``centos`` は、 `公式レポジトリ <https://docs.docker.com/docker-hub/official_repos/>`_ としての信頼されるべきトップ・レベルの名前空間です。文字列 ``/`` により、イメージ名とユーザのレポジトリ名を区別します。

.. Once you’ve found the image you want, you can download it with docker pull <imagename>:

欲しいイメージが見つかれば、 ``docker pull <イメージ名>`` によってダウンロードできます。

.. code-block:: bash

   $ docker pull centos
   Using default tag: latest
   latest: Pulling from library/centos
   f1b10cd84249: Pull complete
   c852f6d61e65: Pull complete
   7322fbe74aa5: Pull complete
   Digest: sha256:90305c9112250c7e3746425477f1c4ef112b03b4abe78c612e092037bfecc3b7
   Status: Downloaded newer image for centos:latest

.. You now have an image from which you can run containers.

これで、この入手したイメージをから、コンテナを実行可能です。

... Specific Version or Latest

バージョンの指定と最新版
------------------------------

.. Using docker pull centos is equivalent to using docker pull centos:latest. To pull an image that is not the default latest image you can be more precise with the image that you want.

``docker pull centos`` の実行は、``docker pull centos:latest`` の実行と同等です。イメージを取得するにあたり、標準の最新（latest）イメージをダウンロードするのではなく、より適切なイメージを正確に指定可能です。

.. For example, to pull version 5 of centos use docker pull centos:centos5. In this example, centos5 is the tag labeling an image in the centos repository for a version of centos.

例えば、 ``centos`` のバージョン 5 を取得するには、``docker pull centos:centos5`` を使います。この例では、 ``centos5`` が ``centos`` レポジトリにおける ``centos`` のバージョンのイメージを、タグでラベル付けしたものです。

.. To find a list of tags pointing to currently available versions of a repository see the Docker Hub registry.

レポジトリにおいて現在利用可能なタグの一覧を確認するには、 `Docker Hub <https://hub.docker.com/>`_ レジストリをご覧ください。


.. Contributing to Docker Hub

Docker Hub への貢献
====================

.. Anyone can pull public images from the Docker Hub registry, but if you would like to share your own images, then you must register first.

誰でも `Docker Hub <https://hub.docker.com/>`_ レジストリから公開イメージを取得（pull）できますが、自分自身のレジストリをイメージを共有したい場合、まず登録が必要です。

.. Pushing a repository to Docker Hub

Docker Hub にレポジトリの送信
==============================

.. In order to push a repository to its registry, you need to have named an image or committed your container to a named image as we saw here.

レポジトリを対象のレジストリに送信（push）するためには、イメージに名前を付けるか、 :doc:`こちら <dockerimages>` で見たように、コンテナにイメージ名をつけてコミットする必要があります。

.. Now you can push this repository to the registry designated by its name or tag.

それからこのレポジトリを、レジストリが表す名前やタグで送信できます。

.. code-block:: bash

   $ docker push yourname/newimage

.. The image will then be uploaded and available for use by your team-mates and/or the community.

対象のイメージをアップロードすると、あなたの同僚やコミュニティにおいても利用可能になります。

.. Deatures of Docker Hub

Docker Hub の機能
====================

.. Let’s take a closer look at some of the features of Docker Hub. You can find more information here.

それでは、Docker Hub のいくつかの機能について、詳細をみていきましょう。より詳しい情報は :doc:`こちら </docker-hub/index.rst>` からご覧いただけます。

..    Private repositories
    Organizations and teams
    Automated Builds
    Webhooks

* プライベート・レポジトリ
* 組織とチーム
* 自動構築
* ウェブフック

.. Private repositories

プライベート・レポジトリ
------------------------------

.. Sometimes you have images you don’t want to make public and share with everyone. So Docker Hub allows you to have private repositories. You can sign up for a plan here.

イメージを一般公開せず、だれとも共有したくない場合があります。そのような時は Docker Hub のプライベート・レポジトリが利用出来ます。サインアップや料金プランは、 `こちらを <https://registry.hub.docker.com/plans/>`_ ご覧ください。

.. Organizations and teams

組織とチーム
--------------------

.. One of the useful aspects of private repositories is that you can share them only with members of your organization or team. Docker Hub lets you create organizations where you can collaborate with your colleagues and manage private repositories. You can learn how to create and manage an organization here.

プライベート・レポジトリの便利な機能の１つは、組織やチームにおける特定メンバーとのみ共有することです。Docker Hub 上で組織（organization）を作り、同僚と協力しながらプライベート・レポジトリの管理が可能です。組織の作成や管理方法については `こちら <https://registry.hub.docker.com/account/organizations/>`_ をご覧ください。

.. Automated Builds

自動構築
------------------------------

.. Automated Builds automate the building and updating of images from GitHub or Bitbucket, directly on Docker Hub. It works by adding a commit hook to your selected GitHub or Bitbucket repository, triggering a build and update when you push a commit.

自動構築（Automated Build）とは、 `GItHub <https://www.github.com/>`_ や `Bitbucket <http://bitbucket.com/>`_ のイメージが更新されると、Docker Hub が直接、構築や更新をします。これは、選択した GitHub か Bitbucket レポジトリに対するコミットをきっかけ（フック）とするもので、コミットをプッシュ（push）したのをトリガとして構築・更新を行います。

.. To setup an Automated Build

自動構築のセットアップ
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1. `Docker Hub アカウント <https://hub.docker.com/>`_ を作成してログインします。
2. `Linked Accounts & Services <https://hub.docker.com/account/authorized-services/>`_ （アカウントとサービスのリンク）から自分の GitHub もしくは Bitbucket アカウントをリンクします。
3. `自動構築の設定 <https://hub.docker.com/add/automated-build/github/orgs/>`_ を行います。
4. 選択した GitHub もしくは BitHubket プロジェクト上で、構築内容を ``Dockerfile`` にまとめます。
5. 必要があれば構築時のブランチを指定します（デフォルトは ``master`` ブランチです）。
6. 自動構築名を指定します。
7. 構築時に追加するオプションの Docker タグを指定します。
8. ``Dockerfile`` の場所を指定します。デフォルトは ``/`` です。

.. Once the Automated Build is configured it will automatically trigger a build and, in a few minutes, you should see your new Automated Build on the Docker Hub Registry. It will stay in sync with your GitHub and Bitbucket repository until you deactivate the Automated Build.

自動構築の設定を有効化しておけば、ビルドをトリガとして数分後に自動構築が始まります。自動ビルドの状態は `Docker Hub <https://hub.docker.com/>`_  レジストリ上で見られます。GitHub や Bitbucket レポジトリの同期が終わるまで、自動ビルドを無効化できません。

.. To check the output and status of your Automated Build repositories, click on a repository name within the “Your Repositories” page. Automated Builds are indicated by a check-mark icon next to the repository name. Within the repository details page, you may click on the “Build Details” tab to view the status and output of all builds triggered by the Docker Hub.

レポジトリの自動構築状態や出力を確認したい場合は、自分の `レポジトリ一覧ページ <https://hub.docker.com/>`_ に移動し、対象のレポジトリ名をクリックします。自動構築が有効な場合は、レポジトリ名の下に "automated build" と表示されます。レポジトリの詳細ページに移動し、"Build details" タブをクリックすると、Docker Hub 上における構築状態や、全ての構築トリガが表示されます。

.. Once you’ve created an Automated Build you can deactivate or delete it. You cannot, however, push to an Automated Build with the docker push command. You can only manage it by committing code to your GitHub or Bitbucket repository.

自動構築が完了すると、無効化や設定の削除が可能になります。ここで注意すべきは、``docker push`` コマンドを使って push しても、自動構築を行いません。自動構築の管理対象は、あくまでも GitHub と Bitbucket レポジトリに対してコードをコミットした時のみです。

.. You can create multiple Automated Builds per repository and configure them to point to specific Dockerfile’s or Git branches.

レポジトリ毎に複数の自動構築を設定したり、特定の Dockerfile や Git ブランチの指定も可能です。

.. Build triggers

構築のトリガ
^^^^^^^^^^^^^^^^^^^^

.. Automated Builds can also be triggered via a URL on Docker Hub. This allows you to rebuild an Automated build image on demand.

Docker Hub の URL を経由しても、自動構築のトリガにできます。これにより、イメージを必要に応じて自動的に再構築することが可能です。

.. Webhooks

ウェブフック
--------------------

.. Webhooks are attached to your repositories and allow you to trigger an event when an image or updated image is pushed to the repository. With a webhook you can specify a target URL and a JSON payload that will be delivered when the image is pushed.

ウェブフック（webhook）とは、レポジトリに対して設定するものです。トリガとなるのは、イメージに対するイベントの発生や、更新されたイメージがレポジトリに送信された時です。ウェブフックは特定の URL と JSON ペイロードで指定でき、イメージが送信（push）されると適用されます。

.. See the Docker Hub documentation for more information on webhooks

:doc:`ウェブフックの詳細 </docker-hub/repos.rst#webhooks>` については、Docker Hub のドキュメントをご覧ください。

.. Next steps

次のステップ
===================

.. Go and use Docker!

さぁ Docker を使いましょう！
