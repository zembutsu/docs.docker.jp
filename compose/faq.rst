.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/faq/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/faq.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/faq.md
.. check date: 2016/04/28
.. Commits on Mar 3, 2016 aa7b862f4c7f10337fc0b586d70aae5392b51f6c
.. -------------------------------------------------------------------

.. Frequently asked questions

.. _compose-faq:

==============================
よくある質問と回答
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. If you don’t see your question here, feel free to drop by #docker-compose on freenode IRC and ask the community.

あなたの質問がここになければ、freenode IRC の ``#docker-compose`` にあるコミュニティに、質問を気軽に投げてください。

.. Can I control service startup order?

.. _can-i-control-service-startup-order:

サービスの起動順番を制御できますか？
========================================

.. Yes - see Controlling startup order.

はい、詳細は :doc:`startup-order` をご覧ください。

.. Why do my services take 10 seconds to recreate or stop?

サービスの再作成や停止に10秒かかるのはどうして？
==================================================

.. Compose stop attempts to stop a container by sending a SIGTERM. It then waits for a default timeout of 10 seconds. After the timeout, a SIGKILL is sent to the container to forcefully kill it. If you are waiting for this timeout, it means that your containers aren’t shutting down when they receive the SIGTERM signal.

Compose の停止（stop）とはコンテナに ``SIGTERM`` を送信して停止することです。 :doc:`デフォルトのタイムアウトは 10 秒間です </compose/reference/stop>` 。タイムアウトしたら、コンテナを強制停止するために ``SIGKILL`` を送信します。タイムアウトで待っているとは、つまり、コンテナが ``SIGTERM`` シグナルを受信しても停止しないのを意味します。

.. There has already been a lot written about this problem of processes handling signals in containers.

これはコンテナが `プロセスのシグナルをどう扱うか（英語） <https://medium.com/@gchudnov/trapping-signals-in-docker-containers-7a57fdda7d86>`_ の問題で言及されています。

.. To fix this problem, try the following:

この問題を解決するには、以下のことを試してください。

..    Make sure you’re using the JSON form of CMD and ENTRYPOINT in your Dockerfile.

* Dockerfile の ``CMD`` と ``ENTRYPOINT``  命令で JSON 形式を使用する。

.. For example use ["program", "arg1", "arg2"] not "program arg1 arg2". Using the string form causes Docker to run your process using bash which doesn’t handle signals properly. Compose always uses the JSON form, so don’t worry if you override the command or entrypoint in your Compose file.

たとえば、 ``["program", "arg1", "arg2"]`` の形式を使うのであり、 ``"program arg1 arg2"`` の形式を使いません。後者の文字列で指定すると、Docker はプロセスの実行に ``bash`` を使います。すると Docker は適切にシグナルを扱えません。 Compose では常に JSON 形式を使っていれば、Compose ファイル上のコマンドやエントリを書き換える心配は不要です。

..    If you are able, modify the application that you’re running to add an explicit signal handler for SIGTERM.

* 可能であれば、アプリケーションが ``SIGTERM`` シグナルを確実に扱えるように書き換えます。

..    If you can’t modify the application, wrap the application in a lightweight init system (like s6) or a signal proxy (like dumb-init or tini). Either of these wrappers take care of handling SIGTERM properly.

* アプリケーションを書き換え不可能な場合は、アプリケーションを（ `s6 <http://skarnet.org/software/s6/>`_ のような）軽量な init システムを使うか、あるいはシグナルを（ `dumb-init <https://github.com/Yelp/dumb-init>`_ や `tini <https://github.com/krallin/tini>`_ などで）プロキシします。いずれかのラッパーを使い、 ``SIGTERM`` シグナルを適切に扱います。

.. How do I run multiple copies of a Compose file on the same host?

同一ホスト上で Compose ファイルをコピーして、複数実行するには？
===============================================================

.. Compose uses the project name to create unique identifiers for all of a project’s containers and other resources. To run multiple copies of a project, set a custom project name using the -p command line option or the COMPOSE_PROJECT_NAME environment variable.

Compose での作成時は、プロジェクト名をユニークな識別子として使います。これはプロジェクト内の全てのコンテナや他のリソースに使います。プロジェクトをコピーして複数実行するには、 ``-p`` :doc:`コマンドライン・オプション </compose/reference/overview>` を使って任意のプロジェクト名を指定するか、あるいは ``COMPOSE_PROJECT_NAME`` :ref:`環境変数 <compose-project-name>` を使います。

.. What’s the difference between up, run, and start?

``up`` ・ ``run`` ・ ``start`` の違いは何ですか？
==================================================

.. Typically, you want docker-compose up. Use up to start or restart all the services defined in a docker-compose.yml. In the default “attached” mode, you’ll see all the logs from all the containers. In “detached” mode (-d), Compose exits after starting the containers, but the containers continue to run in the background.

一般的には ``docker-compose up`` が使われるでしょう。 ``up`` を使うと ``docker-compose.yml`` ファイル中で定義したサービスの開始または再起動を行います。デフォルトは「アタッチド」モードであり、全てのコンテナのログが画面上に表示されます。「デタッチド」モード（ ``-d`` ）では、Compose はコンテナを実行すると終了しますが、コンテナは後ろで動き続けます。

.. The docker-compose run command is for running “one-off” or “adhoc” tasks. It requires the service name you want to run and only starts containers for services that the running service depends on. Use run to run tests or perform an administrative task such as removing or adding data to a data volume container. The run command acts like docker run -ti in that it opens an interactive terminal to the container and returns an exit status matching the exit status of the process in the container.

``docker-compose run`` コマンドは「ワンオフ」（one-off；１つだけ、偶発的） または「アドホック」（adhoc；臨時）なタスクの実行に使います。実行するにはサービス名の指定が必要であり、特定のサービス用のコンテナを起動し、かつ依存関係のあるコンテナも起動します。 ``run`` の利用時は、テストの実行であったり、データ・ボリューム・コンテナに対するデータの追加・削除といった管理タスクです。 ``run`` コマンドは実際には ``docker run -ti`` を処理しており、コンテナに対してインタラクティブなターミナルを開き、コンテナのプロセスが終了すると、その時点の該当する終了コードを返します。

.. The docker-compose start command is useful only to restart containers that were previously created, but were stopped. It never creates new containers.

``docker-compose start`` コマンドは既に作成済みのコンテナの再起動には便利です。しかし止まっているコンテナを起動するだけであり、新しいコンテナは作成しません。

.. Can I use json instead of yaml for my Compose file?

Compose ファイルには、YAML の代わりに JSON を使えますか？
============================================================

.. Yes. Yaml is a superset of json so any JSON file should be valid Yaml. To use a JSON file with Compose, specify the filename to use, for example:

はい、 `YAML は JSON のスーパーセットです <http://stackoverflow.com/a/1729545/444646>`_  。そのため、あらゆる JSON ファイルは有効な YAML でもあります。Compose ファイルに JSON を使いたい場合は、ファイル名で（ ``.json`` を ）指定します。実行例：

.. code-block:: bash

   docker-compose -f docker-compose.json up

.. How do I get Compose to wait for my database to be ready before starting my application?

データベースが起動するのを待ってからアプリケーションを起動するには？
======================================================================

.. Unfortunately, Compose won’t do that for you but for a good reason.

残念ながら、正統な理由がなければ Compose はそのように処理できません。

.. The problem of waiting for a database to be ready is really just a subset of a much larger problem of distributed systems. In production, your database could become unavailable or move hosts at any time. The application needs to be resilient to these types of failures.

データベースが準備するまで待たせることにより、分散システムにおいて非常に大きな問題となる可能性があります。プロダクション環境においては、データベースが使えなくなるか、あるいは他のホストに移動する場合があるでしょう。アプリケーションは、この種の障害に対する回復力を必要とします。

.. To handle this, the application would attempt to re-establish a connection to the database after a failure. If the application retries the connection, it should eventually be able to connect to the database.

そのためには、アプリケーションがデータベースとの通信ができなくなっても、再度接続を試みるでしょう。もしアプリケーションのリトライが失敗したら、データベースに対する接続性は失われたと考えるべきです。

.. To wait for the application to be in a good state, you can implement a healthcheck. A healthcheck makes a request to the application and checks the response for a success status code. If it is not successful it waits for a short period of time, and tries again. After some timeout value, the check stops trying and report a failure.

アプリケーションが正常になるまで待つためには、ヘルスチェックを実装する必要があります。ヘルスチェックはアプリケーションに対してリクエストを送り、ステータス・コードの応答が正常化どうかを確認します。もし成功しなければ、短時間待った後、再試行します。何度もタイムアウトをするようであれば、チェックを停止し、失敗を報告します。

.. If you need to run tests against your application, you can start by running a healthcheck. Once the healthcheck gets a successful response, you can start running your tests.

もしアプリケーションに対する実行テストが必要であれば、ヘルスチェックを実行できます。ヘルスチェックの応答が正常であれば、テストを実行可能になります。

.. Should I include my code with COPY/ADD or a volume?

コードを入れるには ``COPY`` か ``ADD``  ですか、それともボリュームですか？
==========================================================================

.. You can add your code to the image using COPY or ADD directive in a Dockerfile. This is useful if you need to relocate your code along with the Docker image, for example when you’re sending code to another environment (production, CI, etc).

コードをイメージにコピーするには、 ``Dockerfile`` の ``COPY`` または ``ADD`` 命令が使えます。これは Docker イメージのコードを置き換える場合に便利です。たとえば、コードを別の環境（プロダクション、CI 、等）に送りたい場合です。

.. You should use a volume if you want to make changes to your code and see them reflected immediately, for example when you’re developing code and your server supports hot code reloading or live-reload.

コードを変更したい場合、すぐに反映したい場合は ``volume`` を使うべきでしょう。たとえば、コードをデプロイする場面で、サーバがホット・コード・リロードやライブ・リロードをサポートしている場合です。

.. There may be cases where you’ll want to use both. You can have the image include the code using a COPY, and use a volume in your Compose file to include the code from the host during development. The volume overrides the directory contents of the image.

両方の命令を使いたい場合があるかもしれません。開発環境上において、イメージに対してコードを追加する場合は ``COPY`` を使い、Compose ファイルにコードを含める場合は ``volume`` を使えます。ボリュームを使えばイメージの中にあるディレクトリの情報を上書きします。

.. Where can I find example compose files?

Compose ファイルのサンプルはありますか？
========================================

.. There are many examples of Compose files on github.

`GitHub 上に Compose ファイルのサンプルがたくさん <https://github.com/search?q=in%3Apath+docker-compose.yml+extension%3Ayml&type=Code>`_ あります。

.. Compose documentation

Compose ドキュメント
====================

* :doc:`install`
* :doc:`django`
* :doc:`rails`
* :doc:`wordpress`
* :doc:`reference/index`
* :doc:`compose-file`

.. seealso:: 

   Frequently asked questions
      https://docs.docker.com/compose/faq/

