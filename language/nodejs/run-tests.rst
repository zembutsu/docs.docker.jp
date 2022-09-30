.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/language/nodejs/run-tests/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/language/nodejs/run-tests.md
.. check date: 2022/09/30
.. Commits on Sep 29, 2022 561118ec5b1f1497efad536545c0b39aa8026575
.. -----------------------------------------------------------------------------

.. Use containers for development
.. _nodejs-use-containers-for-development:

========================================
開発にコンテナを使う
========================================

.. Prerequisites
.. _nodejs-run-tests-prerequisites:

事前準備
==========

.. Work through the steps to build an image and run it as a containerized application in Use your container for development.

:doc:`develop` でイメージ構築をし、それコンテナ化アプリケーションとして実行します。

.. Introduction
.. _nodejs-run-tests-introduction:

概要
==========

.. Testing is an essential part of modern software development. Testing can mean a lot of things to different development teams. There are unit tests, integration tests and end-to-end testing. In this guide we take a look at running your unit tests in Docker.

現代的なソフトウェア開発において、テストは必要不可欠です。テストとは開発チームによって様々な意味を持ちます。単体テスト、統合テスト、エンドツーエンドテストがあります。このガイドとは Docker での単体テスト実行をみていきます。

.. Create a test
.. _nodejs-run-tests-create-a-test:

テストの作成
====================

.. Let’s define a Mocha test in a ./test directory within our application.

アプリケーション内の ``./test`` ディレクトリ内で Mocha テストを定義しましょう。

.. code-block:: bash

   $ mkdir -p test

.. Save the following code in ./test/test.js.

以下のコードを ``./test/test.js`` に保存します。

.. code-block:: js

   var assert = require('assert');
   describe('Array', function() {
     describe('#indexOf()', function() {
       it('should return -1 when the value is not present', function() {
         assert.equal([1, 2, 3].indexOf(4), -1);
       });
     });
   });

.. Running locally and testing the application
.. _nodejs-run-tests-running-locally-and-testing-the-application:

ローカルで実行とアプリケーションのテスト
--------------------------------------------------

.. Let’s build our Docker image and confirm everything is running properly. Run the following command to build and run your Docker image in a container.

Docker イメージを構築し、全てが正しく動くのを確認しましょう。コンテナで Docker イメージを構築および実行するには、次のコマンドを実行します。

.. code-block:: bash

   $ docker-compose -f docker-compose.dev.yml up --build

.. Now let’s test our application by POSTing a JSON payload and then make an HTTP GET request to make sure our JSON was saved correctly.

次は、JSON ペイロードを POST してアプリケーションをテストし、 HTTP GET リクエストを使って JSON が正しく保存されているのを確認します。

.. code-block:: bash

   $ curl --request POST \
     --url http://localhost:8000/test \
     --header 'content-type: application/json' \
     --data '{"msg": "testing"}'

.. Now, perform a GET request to the same endpoint to make sure our JSON payload was saved and retrieved correctly. The “id” and “createDate” will be different for you.

それから、同じエンドポイントに対して GET リクエストを処理し、保存された JSON ペイロードが正しく取得できるのを確認します。「id」と「createDate」は、みなさんのものとは違うでしょう。

.. code-block:: bash

   $ curl http://localhost:8000/test
   
   {"code":"success","payload":[{"msg":"testing","id":"e88acedb-203d-4a7d-8269-1df6c1377512","createDate":"2020-10-11T23:21:16.378Z"}]}

.. Install Mocha
.. _nodejs-run-tests-install-mocha:

Mocha のインストール
====================

.. Run the following command to install Mocha and add it to the developer dependencies:

Mocha をインストールするため以下のコマンドを実行し、これを開発者の依存関係に追加します：

.. code-block:: bash

   $ npm install --save-dev mocha

.. Update package.json and Dockerfile to run tests
.. _nodejs-run-tests-update-package.json-and-dockerfile-to-run-tests:

テストを実行するため package.json と Dockerfile を更新
============================================================

.. Okay, now that we know our application is running properly, let’s try and run our tests inside of the container. We’ll use the same docker run command we used above but this time, we’ll override the CMD that is inside of our container with npm run test. This will invoke the command that is in the package.json file under the “script” section. See below.

それでは、次はアプリケーションが正しく動作しているかどうかを知るため、コンテナ内でテストを実行してみましょう。先ほどと同じ docker run コマンドを使いますが、今回はコンテナ内で npm run test を実行するため CMD を上書きします。これにより、 package.json ファイルの「script」セクションにあるコマンドが実行されます。以下をご覧ください。

.. code-block:: js

   {
   ...
     "scripts": {
       "test": "mocha ./**/*.js",
       "start": "nodemon --inspect=0.0.0.0:9229 server.js"
     },
   ...
   }

.. Below is the Docker command to start the container and run tests:

以下の Docker コマンドはコンテナを起動し、テストを実行します：

.. code-block:: bash

   $ docker-compose -f docker-compose.dev.yml run notes npm run test
   Creating node-docker_notes_run ... 
   
   > node-docker@1.0.0 test /code
   > mocha ./**/*.js
   
   
   
     Array
       #indexOf()
         ✓ should return -1 when the value is not present
   
   
     1 passing (11ms)

.. Multi-stage Dockerfile for testing
.. _nodejs-run-tests-multi-stage-dockerfile-for-testing:

テスト用のマルチステージ Dockerfile
----------------------------------------

.. In addition to running the tests on command, we can run them when we build our image, using a multi-stage Dockerfile. The following Dockerfile will run our tests and build our production image.

コマンドにテスト実行を追加するだけでなく、マルチステージ Dockerfile を使い、イメージ構築時にもテストを実行できます。以下の Dockerfile はテストを実行し、プロダクションのイメージを構築します。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   FROM node:14.15.4 as base
   
   WORKDIR /code
   
   COPY package.json package.json
   COPY package-lock.json package-lock.json
   
   FROM base as test
   RUN npm ci
   COPY . .
   CMD [ "npm", "run", "test" ]
   
   FROM base as prod
   RUN npm ci --production
   COPY . .
   CMD [ "node", "server.js" ]

.. We first add a label as base to the FROM node:14.15.4 statement. This allows us to refer to this build stage in other build stages. Next we add a new build stage labeled test. We will use this stage for running our tests.

まず、 ``FROM node:14.15.4`` 命令に ``as base`` ラベルを追加します。これにより、この名前で以降の構築ステージから参照できるようになります。次は、 test とラベルが付けられた新しいイメージを追加します。テストを実行するために、このステージを使います。

.. Now let’s rebuild our image and run our tests. We will run the same docker build command as above but this time we will add the --target test flag so that we specifically run the test build stage.

それでは、イメージを再構築し、テストを実行しましょう。先述と同じ docker build コマンドを実行しますが、今回は ``--target test`` フラグを付けますので、test 構築ステージのみ処理します。

.. code-block:: bash

   $ docker build -t node-docker --target test .
   [+] Building 66.5s (12/12) FINISHED
    => [internal] load build definition from Dockerfile                                                                                                                 0.0s
    => => transferring dockerfile: 662B                                                                                                                                 0.0s
    => [internal] load .dockerignore
    ...
     => [internal] load build context                                                                                                                                    4.2s
    => => transferring context: 9.00MB                                                                                                                                  4.1s
    => [base 2/4] WORKDIR /code                                                                                                                                         0.2s
    => [base 3/4] COPY package.json package.json                                                                                                                        0.0s
    => [base 4/4] COPY package-lock.json package-lock.json                                                                                                              0.0s
    => [test 1/2] RUN npm ci                                                                                                                                            6.5s
    => [test 2/2] COPY . .

.. Now that our test image is built, we can run it in a container and see if our tests pass.

これでイメージが構築されましたので、コンテナを実行できるようになり、テストに合格したかどうか分かります。

.. code-block:: bash

   $ docker run -it --rm -p 8000:8000 node-docker
   
   > node-docker@1.0.0 test /code
   > mocha ./**/*.js
   
   
   
     Array
       #indexOf()
         ✓ should return -1 when the value is not present
   
   
     1 passing (12ms)
   

.. I’ve truncated the build output but you can see that the Mocha test runner completed and all our tests passed.

構築時の出力を省略しましたが、 Mocha テストランナーが完了し、全てのテストに合格したのが分かります。

.. This is great but at the moment we have to run two docker commands to build and run our tests. We can improve this slightly by using a RUN statement instead of the CMD statement in the test stage. The CMD statement is not executed during the building of the image but is executed when you run the image in a container. While with the RUN statement, our tests will be run during the building of the image and stop the build when they fail.

現時点でこれは素晴らしいのですが、テストのために build と run という2つの docker コマンドを実行しました。test ステージ内の CMD 命令を RUN 命令に変えると若干改善できます。CMD 命令はイメージの構築中は実行されませんが、コンテナとしてイメージを実行する時に（CMD命令で指定したコマンドを）実行します。RUN 命令では、テストをイメージの構築中に実行し、失敗した場合は構築を停止します。

.. Update your Dockerfile with the highlighted line below.

 Dockerfile の以下でハイライトされた行を更新します。

.. code-block:: dockerfile
   :emphasize-lines: 12

   # syntax=docker/dockerfile:1
   FROM node:14.15.4 as base
   
   WORKDIR /code
   
   COPY package.json package.json
   COPY package-lock.json package-lock.json
   
   FROM base as test
   RUN npm ci
   COPY . .
   RUN npm run test
   
   FROM base as prod
   RUN npm ci --production
   COPY . .
   CMD [ "node", "server.js" ]

.. Now to run our tests, we just need to run the docker build command as above.

それでは、テストを実行するため、先ほどと同じ docker build コマンドを実行する必要があります。

.. code-block:: bash

   $ docker build -t node-docker --target test .
   [+] Building 8.9s (13/13) FINISHED
    => [internal] load build definition from Dockerfile      0.0s
    => => transferring dockerfile: 650B                      0.0s
    => [internal] load .dockerignore                         0.0s
    => => transferring context: 2B
   
   > node-docker@1.0.0 test /code
   > mocha ./**/*.js
   
   
   
     Array
       #indexOf()
         ✓ should return -1 when the value is not present
   
   
     1 passing (9ms)
   
   Removing intermediate container beadc36b293a
    ---> 445b80e59acd
   Successfully built 445b80e59acd
   Successfully tagged node-docker:latest

.. I’ve truncated the output again for simplicity but you can see that our tests are run and passed. Let’s break one of the tests and observe the output when our tests fail.

シンプルにするため再び出力を一部省略しましたが、テストを実行して合格したのが分かります。テストの1つを失敗するようにし、テストが失敗するのを確認しましょう。

.. Open the test/test.js file and change line 5 as follows.

test/test.js ファイルを開き、5行目を以下のように変更します。

.. code-block:: js

     1	var assert = require('assert');
     2	describe('Array', function() {
     3	  describe('#indexOf()', function() {
     4	    it('should return -1 when the value is not present', function() {
     5	      assert.equal([1, 2, 3].indexOf(3), -1);
     6	    });
     7	  });
     8	});

.. Now, run the same docker build command from above and observe that the build fails and the failing testing information is printed to the console.

これで、先ほどと同じ docker build コマンドを実行すると、構築が失敗し、コンソール上にはテスト失敗に関係する情報を表示するのが見えるでしょう。

.. code-block:: bash

   $ docker build -t node-docker --target test .
   Sending build context to Docker daemon  22.35MB
   Step 1/8 : FROM node:14.15.4 as base
    ---> 995ff80c793e
   ...
   Step 8/8 : RUN npm run test
    ---> Running in b96d114a336b
   
   > node-docker@1.0.0 test /code
   > mocha ./**/*.js
   
   
   
     Array
       #indexOf()
         1) should return -1 when the value is not present
   
   
     0 passing (12ms)
     1 failing
   
     1) Array
          #indexOf()
            should return -1 when the value is not present:
   
         AssertionError [ERR_ASSERTION]: 2 == -1
         + expected - actual
   
         -2
         +-1
         
         at Context.<anonymous> (test/test.js:5:14)
         at processImmediate (internal/timers.js:461:21)
   
   
   
   npm ERR! code ELIFECYCLE
   npm ERR! errno 1
   npm ERR! node-docker@1.0.0 test: `mocha ./**/*.js`
   npm ERR! Exit status 1
   ...


.. Next steps
.. _nodejs-run-tests-next-steps:

次のステップ
====================

.. In this module, we took a look at running tests as part of our Docker image build process.

この章では、 Docker イメージの構築過程の一部としてテストを実行する方法を説明しました。

.. In the next module, we’ll take a look at how to set up a CI/CD pipeline using GitHub Actions. See:

次の章では、GitHub Actions を使って CI/CD パイプラインのセットアップ方法を説明します。

.. Configure CI/CD

:doc:`CI/CD の設定 <configure-ci-cd>`

.. Feedback
.. _nodejs-run-tests-feedback:

フィードバック
====================

.. Help us improve this topic by providing your feedback. Let us know what you think by creating an issue in the Docker Docs GitHub repository. Alternatively, create a PR to suggest updates.

フィードバックを通し、このトピックの改善を支援ください。考えがあれば、 `Docker Docs <https://github.com/docker/docs/issues/new?title=[Node.js%20docs%20feedback]>`_ GitHub リポジトリに issue を作成して教えてください。あるいは、更新の提案のために `RP を作成 <https://github.com/docker/docs/pulls>`_ してください。

.. seealso::

   Run your Tests using Node.js and Mocha frameworks
      https://docs.docker.com/language/nodejs/run-tests/
