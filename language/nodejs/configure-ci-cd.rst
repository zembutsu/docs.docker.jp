.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/nodejs/configure-ci-cd/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/language/nodejs/configure-ci-cd.md
.. check date: 2022/09/30
.. Commits on Sep 29, 2022 561118ec5b1f1497efad536545c0b39aa8026575
.. -----------------------------------------------------------------------------

.. Configure CI/CD for your application
.. _nodejs-configure-ci-cd-for-your-application:

========================================
アプリケーションに CI/CD を設定
========================================

.. This page guides you through the process of setting up a GitHub Action CI/CD pipeline with Docker containers. Before setting up a new pipeline, we recommend that you take a look at Ben’s blog on CI/CD best practices .

このページでは、 Docker コンテナを使う GitHub Actions CI/CD パイプラインのセットアップ手順を説明します。新しいパイプラインを設定する前に、 `Ben のブログ <https://www.docker.com/blog/best-practices-for-using-docker-hub-for-ci-cd/>`_ にある CI/CD ベストプラクティスをご覧になるのを推奨します。

.. This guide contains instructions on how to:

このガイドには、以下の方法の手順を含みます：

..  Use a sample Docker project as an example to configure GitHub Actions
    Set up the GitHub Actions workflow
    Optimize your workflow to reduce the number of pull requests and the total build time, and finally,
    Push only specific versions to Docker Hub.

1. サンプル Docker プロジェクトを例に GitHub Actions を設定する
2. GitHub Actions ワークフローをセットアップする
3. pull リクエストを減らすようワークフローを最適化し、採取的に合計構築時間を減らす
4. 特定のバージョンのみ Docker Hub に送信する

.. Set up a Docker project
.. _nodejs-ci-ci-set-up-a-docker-project:

Docker プロジェクトのセットアップ
========================================

.. Let’s get started. This guide uses a simple Docker project as an example. The SimpleWhaleDemo repository contains an Nginx alpine image. You can either clone this repository, or use your own Docker project.

それでは始めましょう。このガイドでは例としてシンプルな Docker プロジェクトを使います。 `SimpleWhaleDemo <https://github.com/usha-mandya/SimpleWhaleDemo>`_ リポジトリは Nginx alpine イメージを含みます。このリポジトリを複製するか、自分の Docker プロジェクトを使います。

.. image:: /ci-cd/images/simplewhaledemo.png
   :width: 60%
   :alt: SimpleWhaleDemo

.. Before we start, ensure you can access Docker Hub from any workflows you create. To do this:

始める前に、作成するあらゆるワークフローが `Docker Hub <https://hub.docker.com/>`_ にアクセスできるようにします。そのためには：

..  Add your Docker ID as a secret to GitHub. Navigate to your GitHub repository and click Settings > Secrets > New secret.
    Create a new secret with the name DOCKER_HUB_USERNAME and your Docker ID as value.
    Create a new Personal Access Token (PAT). To create a new token, go to Docker Hub Settings and then click New Access Token.
    Let’s call this token simplewhaleci.
    New access token
    Now, add this Personal Access Token (PAT) as a second secret into the GitHub secrets UI with the name DOCKER_HUB_ACCESS_TOKEN.
    GitHub Secrets

1. 自分の Docker ID をシークレットとして GitHub に追加します。自分の GitHub リポジトリに移動し、 **Settings** > **Secrets** > **New secret**  をクリックします。

2. ``DOCKER_HUB_USERNAME`` という名前で新しいシークレットを作成し、値として自分の Docker ID を入れます。

3. 新しい :ruby:`パーソナル アクセス トークン <Personal Access Token>` （PAT）を作成します。 `Docker Hub Settings <https://hub.docker.com/settings/security>`_ に移動し、 **New Access Token** をクリックします。

4. このトークンを **simplewhaleci** と呼びましょう。

   .. image:: /ci-cd/images/github-access-token.png
      :width: 60%
      :alt: New access token

5. それから GitHub secrets UI で、この :ruby:`パーソナル アクセス トークン <Personal Access Token>` （PAT）を2番目のシークレットとして ``DOCKER_HUB_ACCESS_TOKEN`` という名前の値に追加します。

   .. image:: /ci-cd/images/github-secrets.png
      :width: 60%
      :alt: New access token

.. Set up the GitHub Actions workflow
.. _nodejs-set-up-the-github-actions-workflow:

GitHub Actions ワークフローのセットアップ
==================================================

.. In the previous section, we created a PAT and added it to GitHub to ensure we can access Docker Hub from any workflow. Now, let’s set up our GitHub Actions workflow to build and store our images in Hub. We can achieve this by creating two Docker actions in the YAML file below:

前のセクションでは、GitHub のあらゆるワークフローが Docker Hub にアクセスできるようにするため、 PAT を作成して追加しました。次は、 GitHub Actions ワークフローをセットアップし、イメージの構築と Hub への保存をします。これを達成するには、2つの Docker Actions を以下の YAML ファイルで作成します。

..  The first action enables us to log in to Docker Hub using the secrets we stored in the GitHub Repository.
    The second one is the build and push action.

1. 1つめのアクションは、 GitHub リポジトリ内に保存したシークレットを使い、 Docker Hub にログインできるようにします。
2. 2つめのアクションは、構築と送信をします。

.. In this example, let us set the push flag to true as we also want to push. We’ll then add a tag to specify to always go to the latest version. Lastly, we’ll echo the image digest to see what was pushed.

この例では、 push（送信）フラグを ``true`` に設定し、送信もします。それから、常に :ruby:`最新 <latest>` バージョンに移動するよう指定するタグを追加します。最後に、何が送信されたか見るために、イメージのダイジェスト値を表示します。

.. To set up the workflow:

ワークフローをセットアップするには：

..  Go to your repository in GitHub and then click Actions > New workflow.
    Click set up a workflow yourself and add the following content:

1. 自分の GitHub リポジトリに移動し、 **Actions** > **New workflow** をクリックします。
2. **set up a workflow yourself** をクリックし、以下の内容を追加します。

.. First, we will name this workflow:

まず、このワークフローに名前を付けます。

.. code-block:: yaml

   name: CI to Docker Hub

.. Then, we will choose when we run this workflow. In our example, we are going to do it for every push against the master branch of our project:

それから、このワークフローをいつ実行するかを選びます。私たちの例では、プロジェクトの master ブランチに対する全ての push に対して実行するようにします。

.. code-block:: yaml

   on:
     push:
       branches: [ master ]

..     Note
    The branch name may be main or master. Verify the name of the branch for your repository and update the configuration accordingly.

.. note::

   ブランチ名は ``main`` か ``master`` でしょう。自分のリポジトリにあるブランチ名を確認し、設定を適切に書き換えてください。

.. Now, we need to specify what we actually want to happen within our action (what jobs), we are going to add our build one and select that it runs on the latest Ubuntu instances available:

次は Actions 内で実際に何が起こるか（何の仕事をするか）を指定する必要があるため、build を追加し、利用可能な最新の Ubuntu インスタンスで実行するのを選択しました。

.. code-block:: yaml

   jobs:
   
     build:
       runs-on: ubuntu-latest

.. Now, we can add the steps required. The first one checks-out our repository under $GITHUB_WORKSPACE, so our workflow can access it. The second is to use our PAT and username to log into Docker Hub. The third is the Builder, the action uses BuildKit under the hood through a simple Buildx action which we will also setup

次は、必要な steps を追加できます。1つめは、 ``$GITHUB_WORKSPACE`` 以下のリポジトリを調べ、ワークフローがアクセスできるようにします。2つめは、PAT とユーザ名を使い Docker Hub へログインします。3つめは Builder で、このアクションが簡単な Buildx アクションを通して BuildKit を使えるようにセットアップもします。

.. code-block:: bash

       steps:
   
         - name: Check Out Repo 
           uses: actions/checkout@v2
   
         - name: Login to Docker Hub
           uses: docker/login-action@v1
           with:
             username: ${{ secrets.DOCKER_HUB_USERNAME }}
             password: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}
   
         - name: Set up Docker Buildx
           id: buildx
           uses: docker/setup-buildx-action@v1
   
         - name: Build and push
           id: docker_build
           uses: docker/build-push-action@v2
           with:
             context: ./
             file: ./Dockerfile
             push: true
             tags: ${{ secrets.DOCKER_HUB_USERNAME }}/simplewhale:latest
   
         - name: Image digest
           run: echo ${{ steps.docker_build.outputs.digest }}

.. Now, let the workflow run for the first time and then tweak the Dockerfile to make sure the CI is running and pushing the new image changes:

これで、ワークフローを初めて実行すると、調整した Dockerfile で CI を実行し、新しいイメージの変更が push されているのをかくにんします。

.. CI to Docker Hub

.. image:: /ci-cd/images/ci-to-hub.png
   :width: 60%
   :alt: Docker Hub への CI

.. Optimizing the workflow
.. _nodejs-optimizing-the-workflow:

ワークフローの最適化
====================

.. Next, let’s look at how we can optimize the GitHub Actions workflow through build cache. This has two main advantages:

次は、構築キャッシュを通して GitHub Actions ワークフローをどのようにして最適化できるか見ていきます。これには2つの主な利点があります：


..  Build cache reduces the build time as it will not have to re-download all of the images, and
    It also reduces the number of pulls we complete against Docker Hub. We need to make use of GitHub cache to make use of this.

1. 構築キャッシュはイメージ全てを再ダウンロードする必要がないため、構築回数を減らします。さらに、
2. Docker Hub から取得する回数も減らします。これを実現するには GitHub cache を使えるようにする必要があります。

.. Let us set up a Builder with a build cache. First, we need to set up cache for the builder. In this example, let us add the path and keys to store this under using GitHub cache for this.

構築キャッシュを使うよう builder をセットアップしましょう。まず、builder 用のキャッシュをセットアップする必要があります。この例では、 GitHub キャッシュを使うために保存するパスとキーを追加します。

.. code-block:: yaml

         - name: Cache Docker layers
           uses: actions/cache@v2
           with:
             path: /tmp/.buildx-cache
             key: ${{ runner.os }}-buildx-${{ github.sha }}
             restore-keys: |
               ${{ runner.os }}-buildx-

.. And lastly, after adding the builder and build cache snippets to the top of the Actions file, we need to add some extra attributes to the build and push step. This involves:

そして遂に、 builder と :ruby:`構築キャッシュ断片 <build cache snippet>` を Actions ファイルの先頭に追加したら、build と push ステップのために追加属性を加える必要があります。こちらを含みます。

.. code-block:: yaml

         - name: Login to Docker Hub
           uses: docker/login-action@v1
           with:
             username: ${{ secrets.DOCKER_HUB_USERNAME }}
             password: ${{ secrets.DOCKER_HUB_ACCESS_TOKEN }}
         - name: Build and push
           id: docker_build
           uses: docker/build-push-action@v2
           with:
             context: ./
             file: ./Dockerfile
             builder: ${{ steps.buildx.outputs.name }}
             push: true
             tags: ${{ secrets.DOCKER_HUB_USERNAME }}/simplewhale:latest
             cache-from: type=local,src=/tmp/.buildx-cache
             cache-to: type=local,dest=/tmp/.buildx-cache
         - name: Image digest
           run: echo ${{ steps.docker_build.outputs.digest }}

.. Now, run the workflow again and verify that it uses the build cache.

これで、再びワークフローを実行し、構築キャッシュがワークフローで使われるのを確認します。

.. Push tagged versions to Docker Hub
.. _nodejs-push-tagged-versions-to-docker-hub:

Docker Hub にタグ付けされたバージョンを送信
==================================================

.. Earlier, we learnt how to set up a GitHub Actions workflow to a Docker project, how to optimize the workflow by setting up a builder with build cache. Let’s now look at how we can improve it further. We can do this by adding the ability to have tagged versions behave differently to all commits to master. This means, only specific versions are pushed, instead of every commit updating the latest version on Docker Hub.

これまで学んだのは、 Docker プロジェクトに対して GitHub Actions ワークフローをセットアップする方法や、構築キャッシュを builder で使うようにセットアップしてワークフローを最適化する方法でした。それでは更に改良する方法を見ていきましょう。master に対するすべてのコミットではなく、タグ付けされたバージョンのみ追加できるようにします。つまり、コミットするたびに毎回 Docker Hub に送信するのではなく、指定したバージョンのみ送信できます。

.. You can consider this approach to have your commits go to a local registry to then use in nightly tests. By doing this, you can always test what is latest while reserving your tagged versions for release to Docker Hub.

この手法は、ローカルのレジストリに対してコミットし、これを夜間テストで使うために考えられます。これをするには、Docker Hub にタグ付けされたバージョンがリリースされた時、常に指定された最新版かどうかを確認します。

.. This involves two steps:

2つのステップで、この改良をします：

..  Modifying the GitHub workflow to only push commits with specific tags to Docker Hub
    Setting up a GitHub Actions file to store the latest commit as an image in the GitHub registry

1. 指定したタグでのコミットのみ Docker Hub へ送信するよう、GitHub ワークフローを変更
2. GitHub レジストリ内への最新のコミットをイメージとして保存するよう、GitHub Actions ファイルをセットアップ

.. First, let us modify our existing GitHub workflow to only push to Hub if there’s a particular tag. For example:

まず、既存の GitHub ワークフローを変更し、特定のタグがある場合のみ Hub に送信するようにします。例：

.. code-block:: yaml

   on:
     push:
       tags:
         - "v*.*.*"

.. This ensures that the main CI will only trigger if we tag our commits with V.n.n.n. Let’s test this. For example, run the following command:

コミットに ``V.n.n.n.`` のタグがある場合のみをトリガとして、メイン CI が動作するのを確認します。そのためには、たとえば以下のコマンドを実行します。

.. code-block:: bash

   $ git tag -a v1.0.2
   $ git push origin v1.0.2

.. Now, go to GitHub and check your Actions

次は、 GitHub に移動し Actions を確認します。

.. Push tagged version

.. image:: /ci-cd/images/push-tagged-version.png
   :width: 60%
   :alt: タグ付けされたバージョンを送信

.. Now, let’s set up a second GitHub action file to store our latest commit as an image in the GitHub registry. You may want to do this to:

次は、2つめの GitHub Action ファイルを編集し、GitHub レジストリ内に最新のコミットのみイメージとして保存するようにします。これをするには、次のように設定するでしょう。

..  Run your nightly tests or recurring tests, or
    To share work in progress images with colleagues.

1. 夜間テストや再帰テストの実行。または、
2. 作業中イメージを同僚に共有

.. Let’s clone our previous GitHub action and add back in our previous logic for all pushes. This will mean we have two workflow files, our previous one and our new one we will now work on. Next, change your Docker Hub login to a GitHub container registry login:

先ほどの GItHub Action を複製し、すべての push する前の手順に戻しましょう。つまり、2つのワークフローを用意します。1つは先ほどのもので、新しいものは今から作ります。次に、GitHub コンテナレジストリにログインするため、Docker Hub ログインを書き換えます。

.. code-block:: yaml

           if: github.event_name != 'pull_request'
           uses: docker/login-action@v1
           with:
             registry: ghcr.io
             username: ${{ github.actor }}
             password: ${{ secrets.GITHUB_TOKEN }}

.. To authenticate against the GitHub Container Registry, use the GITHUB_TOKEN for the best security and experience.

`GitHub Container Registry <https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry>`_ へ認証するには、最高のセキュリティと経験から ``GITHUB_TOKEN`` を使います。

.. You may need to manage write and read access of GitHub Actions for repositories in the container settings.

リポジトリ内のコンテナ設定に `GitHub Actions の読み書き権限の管理 <https://docs.github.com/en/packages/managing-github-packages-using-github-actions-workflows/publishing-and-installing-a-package-with-github-actions#upgrading-a-workflow-that-accesses-ghcrio>`_ が必要な場合があります。

.. You can also use a personal access token (PAT) with the appropriate scopes. Remember to change how the image is tagged. The following example keeps ‘latest’ as the only tag. However, you can add any logic to this if you prefer:

`適切な範囲 <https://docs.github.com/en/packages/getting-started-with-github-container-registry/migrating-to-github-container-registry-for-docker-images#authenticating-with-the-container-registry>`_ で `パーソナルアクセストークン（PAT） <https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token>`_ を使う場合もあります。イメージのタグ付け変更を思い出してください。以下の例は「latest」のみ唯一のタグとして保持します。しかしながら、任意のものへと書き換えできます。

.. code-block:: yaml

     tags: ghcr.io/${{ github.repository_owner }}/simplewhale:latest

.. Update tagged images

.. image:: /ci-cd/images/ghcr-logic.png
   :width: 60%
   :alt: タグ付けされたイメージの更新

.. Now, we will have two different flows: one for our changes to master, and one for our pull requests. Next, we need to modify what we had before to ensure we are pushing our PRs to the GitHub registry rather than to Docker Hub.

これで、2つの異なるフローができました：1つは変更を master に送り、もう1つは pull request のためです。次に、Docker Hub ではなく GitHub に Pull Request を送信するよう、以前のものを買い換える必要があります。

.. Next steps
.. _nodejs-ci-cd-next-steps:

次のステップ
====================

.. In this module, you have learnt how to set up GitHub Actions workflow to an existing Docker project, optimize your workflow to improve build times and reduce the number of pull requests, and finally, we learnt how to push only specific versions to Docker Hub. You can also set up nightly tests against the latest tag, test each PR, or do something more elegant with the tags we are using and make use of the Git tag for the same tag in our image.

この章では、既存の DOcker プロジェクトに GitHub Actions ワークフローをセットアップする方法、構築回数と pull request 数を減らすようワークフローの最適化、そして最後に、特定のバージョンのみ Docker Hub に送信する方法を説明しました。また、 latest タグに対して夜間テストをしたり、各 PR のテスト、タグを使ってより洗練された何かを実行したりイメージ内のタグに Git タグを同じものも使用するようにセットアップできます。

.. You can also consider deploying your application. For detailed instructions, see:

アプリケーションのデプロイも検討できます。詳細な手順は、こちらをご覧ください：

.. Deploy your app

:doc:`アプリのデプロイ <deploy>`

.. Feedback
.. _nodejs-ci-cd-feedback:

フィードバック
====================

.. Help us improve this topic by providing your feedback. Let us know what you think by creating an issue in the Docker Docs GitHub repository. Alternatively, create a PR to suggest updates.

フィードバックを通し、このトピックの改善を支援ください。考えがあれば、 `Docker Docs <https://github.com/docker/docs/issues/new?title=[Node.js%20docs%20feedback]>`_ GitHub リポジトリに issue を作成して教えてください。あるいは、更新の提案のために `RP を作成 <https://github.com/docker/docs/pulls>`_ してください。

.. seealso::

   Configure CI/CD for your application
      https://docs.docker.com/language/nodejs/configure-ci-cd/
