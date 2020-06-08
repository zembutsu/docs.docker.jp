.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-for-mac/mutagen-caching/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/mutagen-caching.md
.. check date: 2020/06/08
.. Commits on May 26, 2020 135a21401e0573fa6cfea8484d9f888388997c99
.. -----------------------------------------------------------------------------

.. Mutagen-based caching

.. _mutagen-based-caching:

=======================================
Mutagen ベースのキャッシュ
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:


.. Docker Desktop for Mac on Edge has a new file sharing feature which performs a continuous two-way sync of files between the host and containers using Mutagen. This feature is ideal for app development where:

Docker Desktop for Mac の Edge 版には、新しいファイル共有機能があります。これは `Mutagen <https://mutagen.io/>`_ を使い、ホストとコンテナ間において、双方向の継続的な同期を処理します。この機能は次のようなアプリケーション開発において理想的です：

..    the source code tree is quite large
    the source is edited on Mac
    the source is compiled and run interactively inside Linux containers.

* ソースコードツリーが非常に大きい場合
* Mac 上でソースを編集する場合
* ソースコードをコンパイルし、Linux コンテナ内とで相互に実行する場合

.. This page contains an example to show how the Mutagen feature should be used to sync files between the host and containers. It also gives some best practices to maximize performance.

このページでは、ホストとコンテナ感でファイルを同期するために、どのようにして Mutagen 機能を使うのかを説明します。また、パフォーマンスを最大化するための、いくつかのベストプラクティスも提供します。

..    Important
    After completing the caching process, you must delete and re-create any containers which will make use of the cached directories.

.. important::
   キャッシュプロセス（caching process）を完了したあとで、キャッシュしたディレクトリを使うには、あらゆるコンテナの削除と再作成が必須です。

.. A simple React app

.. _a-simple-react-app:

シンプルな React アプリ
==============================

.. The following example bootstraps a simple React app with npx and configures Docker Desktop to sync the source code between the host and a development container.

以下の例で扱うのは、シンプルな  :code:`npx` を使うReact アプリで、Docker Desktop でソースコードをホストと開発コンテナ間で共有するように設定しています。

.. First, create a directory which will contain the app:

まず、アプリに含むためのディレクトリを作成します：

.. code-block:: bash

   $ mkdir ~/workspace/my-app

.. Next, enable the two-way file sync feature in Docker Desktop:
    From the Docker Desktop menu, click Preferences > Resources > File sharing.
    Type the new directory name in the bottom of the list and press the enter key.
    Click on the toggle next to the directory name.
    Click Apply & Restart for the changes to take effect.

次に、Docker Desktop で双方向のファイル同期機能（two-way file sync）を有効化します。

1. Docker Desktop メニューから、 **Preferences > Resources > File sharing** をクリックします。
2. 一覧の下で新しいディレクトリ名を入力し、エンターキーを押します。
3.  ディレクトリ名の横にあるトグルをクリックする。
4.  設定を有効化するために **Apply & Restart** をクリックする。

.. When Docker Desktop has restarted, the File sharing page looks like this:

Docker Desktop を再起動すると、 **File sharing**  ページはこのようになります：

.. Caching with mutagen is "Ready"

＜図＞

.. Run the following command to start a container and bootstrap the app with npx:

以下のコマンドを実行してコンテナを起動し、 :code:`npx` を含むアプリケーションのコンテナを開始します。


.. code-block:: bash

   $ docker run -it -v ~/workspace/my-app:/my-app -w /my-app -p 3000:3000 node:lts bash
   root@95441305251a:/my-app# npx create-react-app app
   root@95441305251a:/my-app# cd app
   root@95441305251a:/my-app# npm start

.. Once the development webserver has started, open https://localhost:3000/ in your browser and observe the app is running.

開発用のウェブサーバが起動すると、ウェブブラウｚで https://localhost:3000 を開き、アプリケーションが動いているかどうか確認します。

.. Return to the File sharing page in the UI and observe the status of the cache toggle located next to the directory name. The status will be updated as file changes are detected and then synchronized between the host and the containers.

ユーザーインターフェースの **File sharing** ページに戻り、ディレクトリ名の隣に cache toggle のステータスが表示されます。このステータスはファイル変更を検出すると変わり、その後にホストとコンテナ間で同期します。

.. Wait until the text says Ready and then open the source code in your IDE on the host. Edit the file src/App.js, save the changes and observe the change on the webserver.

文字列が **Ready**  になるまで待ったのち、ホスト上の IDE でソースコードを開きます。ファイル :code:`src/App.js` を編集し、変更を保存した後、ウェブサーバ上から変わったかどうかを確認します。

.. As you edit code on the host, the changes are detected and transferred to the container for testing. Changes inside the container (for example, the creation of build artifacts) are detected and transferred back to the host.

ホスト上のコードを編集したため、変更が検出され、テスト用のコンテナに転送されます。コンテナ内の変更が検出されれば（たとえば、ビルド成果物の生成）、ホスト側に送り返します。


.. Avoiding synchronizing a subdirectory

.. _avoiding-synchronizing-a-subdirectory:

サブディレクトリの同期を防止
==============================

.. Although two-way file sync is suitable for many types of files, sometimes containers can generate lots of data which doesn’t require copying to the host, for example, debug logs.

双方向のファイル同期は、大部分の種類のファイルにとって便利です。しかし、ログからのデバッグなど、ホスト上でのコピーが不要なデータを生成するようなコンテナもあります。

.. If your project has a subdirectory that doesn’t need to be continuously copied back to the host, then use a named docker volume to bypass the sync.

プロジェクト上で、ホスト側と継続的に同期する必要がないサブディレクトリがある場合は、同期を回避する名前付き Docker ボリュームを使います。

.. First create a volume using:

まず、使用するボリュームを作成します：

.. code-block:: bash

   $ docker volume create donotsyncme
   donotsyncme

.. Use the volume for the subdirectory you want to avoid syncing:

同期をしたくないサブディレクトリのために、ボリュームを使います：

.. code-block:: bash

   $ docker run -it -v ~/workspace/my-app:/my-app -v donotsyncme:/my-app/dontsyncme -w /my-app -p 3000:3000 node:lts bash

.. Docker Desktop will sync all changes written by the app to /my-app to the host, except changes written to /my-app/dontsyncme which will be written to the named volume instead.

Docker Desktop はホスト上の :code::code:`/my-app` にアプリケーションによって変更された書き込みを、すべて同期しようとします。しかし、 名前付きボリューム :code:`/my-app/donotsyncme`  に書き込まれた変更処理は除外します。


.. Best practices

.. _mutagen-best-practices:

ベストプラクティス
====================

.. To achieve maximum performance when you enable two-way file sync:

双方向ファイル同期を有効にするにあたり、最大のパフォーマンスを発揮するには：

..    Avoid wasting disk space and CPU by minimising the size of the synchronized directories. For example, synchronize a project directory like ~/my-app, but never sync a large directory like /Users or /Volumes.
    Remember that the files will be copied inside the container and therefore must fit within the Docker.qcow2 or Docker.raw file.
    For every volume you want to sync in docker run -v or in docker-compose.yml, ensure either the directory itself or a parent/grandparent/... directory is listed in Preferences > Resources > File sharing.
    Note in particular that if only a child directory is listed on the File sharing page, then the whole docker run -v may bypass the two-way sync and be slower.
    Avoid changing the same files from both the host and containers. If changes are detected on both sides, the host takes precedence and the changes in the containers will be discarded.
    After completing the caching process, you must delete and re-create any containers which will make use of the cached directories.

* 無駄なディスク容量と CPU を避けるため、同期するディレクトリは最小化する。たとえば、 :code:`~/my-app`  のようなプロジェクトのディレクトを同期するべきであり、 :code:`/Users` や :code:`/Volumes` のような大きなディレクトリは絶対に同期しない。各ファイルはコンテナ内にコピーされるのを忘れないでください。つまり、 :code:`Docker.qcow2` または :code:`Docker.raw` ファイル内に収まる必要があります。
* 同期したいディレクトリは、それぞれ :code:`docker run -v`  や :code:`docker-compose.yml` で指定します。そして、各ディレクトリないし親ディレクトリ、親の親ディレクトリが **Preferences > Resources > File sharing** の一覧にあるかどうか確認します。 特に、**File sharing** ページ上に子ディレクトリしかない場合、 :code:`docker run -v` 全体で双方向同期が回避され、遅くなります。
* ホストとコンテナの両方で同じファイルを編集するのを避けます。両方で変更が検出されると、ホスト側が優先され、変更によってコンテナ側は破棄されます。
* キャッシュ・プロセスの動作後は、キャッシュしたディレクトリを再利用するには、コンテナの削除・再作成が必須です。


.. Feedback

.. _mutagen-feedback:

フィードバック
====================

.. Your feedback is very important to us. Let us know your feedback by creating an issue in the Docker Desktop for Mac GitHub repository with the Mutagen label.

皆さんのフィードバックは私たちにとり非常に重要です。 `Docker Desktop for Mac GitHub <https://github.com/docker/for-mac/issues>`_  レポジトリで、 **Mutagen**  ラベルを付けた issue を作成してください。

.. seealso::

   Mutagen-based caching
      https://docs.docker.com/docker-for-mac/mutagen-caching/
