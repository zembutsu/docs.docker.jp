.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/extend/examples/couchbase/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/examples/couchbase.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/examples/couchbase.md
.. check date: 2016/06/13
.. Commits on May 27, 2016 ee7696312580f14ce7b8fe70e9e4cbdc9f83919f
.. ---------------------------------------------------------------

.. Dockerizing a Couchbase service

.. _dockerizing-a-couchbase-service:

========================================
Couchbase サービスの Docker 化
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This example shows how to start a Couchbase server using Docker Compose, configure it using its REST API, and query it.

この例では Docker Compose を使い `Couchbase <http://couchbase.com/>`_ サーバを起動し、 `REST API <http://developer.couchbase.com/documentation/server/4.0/rest-api/rest-endpoints-all.html>`_ を使えるように設定し、結果を確認します。

.. Couchbase is an open source, document-oriented NoSQL database for modern web, mobile, and IoT applications. It is designed for ease of development and Internet-scale performance.

Couchbase はオープンソースです。そして、最近のウェブ、モバイル、IoT アプリケーション向けのドキュメント指向 NoSQL データベースです。簡単な開発とインターネットで性能をスケールできるように設計されています。

.. Start Couchbase server

.. _start-couchbase-server:

Couchbase サーバの起動
==============================

.. Couchbase Docker images are published at Docker Hub.

Couchbase Docker イメージは `Docker Hub <https://hub.docker.com/_/couchbase/>`_ 上で公開されています。

.. Start Couchbase server as:

Couchbase サーバは次のように起動します：

.. code-block:: bash

   docker run -d --name db -p 8091-8093:8091-8093 -p 11210:11210 couchbase

.. The purpose of each port exposed is explained at Couchbase Developer Portal - Network Configuration.

各ポートを公開する理由は、  `Couchbase Developer Portal - Network Configuration <http://developer.couchbase.com/documentation/server/4.1/install/install-ports.html>`_ をご覧ください。

.. Logs can be seen as:

ログには次のように表示されます：

.. code-block:: bash

   docker logs db
   Starting Couchbase Server -- Web UI available at http://<ip>:8091

..    Note: The examples on this page assume that the Docker Host is reachable on 192.168.99.100. Substitute 192.168.99.100 with the actual IP address of your Docker Host. If you’re running Docker using Docker machine, you can obtain the IP address of the Docker host using docker-machine ip <MACHINE-NAME>.

.. note::

   このページの例では、接続先の Docker ホストの IP アドレスは ``192.168.99.100`` を前提にしています。 ``192.168.88.100`` は実際の Docker ホストの IP アドレスに置き換えてください。Docker Machine で Docker を実行している場合は、次のコマンドで IP アドレスを確認できます。
   
   .. code-block:: bash
   
      docker-machine ip <マシン名>

.. The logs show that Couchbase console can be accessed at http://192.168.99.100:8091. The default username is Administrator and the password is password.

Couchbase コンソールには ``http://192.168.99.100:8091`` でアクセスできます。デフォルトがユーザ名が ``Administrator`` 、パスワードが ``password`` です。

.. Configure Couchbase Docker container

.. _configure-couchbase-docker-container:

Couchbase Docker コンテナの設定
========================================

.. By default, Couchbase server needs to be configured using the console before it can be used. This can be simplified by configuring it using the REST API.

通常は Couchbase サーバを使う前にコンソール上での設定が必要です。これを REST API を使えば簡単に設定できます。

.. Configure memory for Data and Index service

Data と Index サービスのメモリ設定
----------------------------------------

.. Data, Query and Index are three different services that can be configured on a Couchbase instance. Each service has different operating needs. For example, Query is CPU intensive operation and so requires a faster processor. Index is disk heavy and so requires a faster solid state drive. Data needs to be read/written fast and so requires more memory.

Couchbase インスタンス上では、Data ・ Query ・ Index は別々のサービスです。各サービスは別々の設定が必要です。例えば、Query は CPU の処理が集中するため、より速い CPU が必要です。 Index はディスクが重いため、速い SSD が必要です。Data は読み書きを速くするため、より多くのメモリが必要です。

.. Memory needs to be configured for Data and Index service only.

メモリが必要になる設定は Data と Index サービスのみです。

.. code-block:: bash

   curl -v -X POST http://192.168.99.100:8091/pools/default -d memoryQuota=300 -d indexMemoryQuota=300
   * Hostname was NOT found in DNS cache
   *   Trying 192.168.99.100...
   * Connected to 192.168.99.100 (192.168.99.100) port 8091 (#0)
   > POST /pools/default HTTP/1.1
   > User-Agent: curl/7.37.1
   > Host: 192.168.99.100:8091
   > Accept: */*
   > Content-Length: 36
   > Content-Type: application/x-www-form-urlencoded
   >
   * upload completely sent off: 36 out of 36 bytes
   < HTTP/1.1 401 Unauthorized
   < WWW-Authenticate: Basic realm="Couchbase Server Admin / REST"
   * Server Couchbase Server is not blacklisted
   < Server: Couchbase Server
   < Pragma: no-cache
   < Date: Wed, 25 Nov 2015 22:48:16 GMT
   < Content-Length: 0
   < Cache-Control: no-cache
   <
   * Connection #0 to host 192.168.99.100 left intact

.. The command shows an HTTP POST request to the REST endpoint /pools/default. The host is the IP address of the Docker machine. The port is the exposed port of Couchbase server. The memory and index quota for the server are passed in the request.

これは REST エンドポイント ``/pools/default`` に HTTP POST リクエストを送信した結果です。ホストとは Docker Machine の IP アドレスです。ポートは Couchbase サーバによって公開されているものです。サーバに対して、メモリとインデクスに対する制限（quota）をリクエストしています。

.. Configure Data, Query, and Index services

.. _configure-data-query-and-index-services:

Data・Query・index サービスの設定
========================================

.. All three services, or only one of them, can be configured on each instance. This allows different Couchbase instances to use affinities and setup services accordingly. For example, if Docker host is running a machine with solid-state drive then only Data service can be started.

３つの全サービス、または、１つに対しての設定が可能です。これにより、それぞれのアフィニティ（ハードウェア要件等）、サービスを適切にセットアップします。例えば、Data サービスが開始できるのは、Docker ホストが SSD マシン上で動作している場所といった指定です。

.. code-block:: bash

   curl -v http://192.168.99.100:8091/node/controller/setupServices -d 'services=kv%2Cn1ql%2Cindex'
   * Hostname was NOT found in DNS cache
   *   Trying 192.168.99.100...
   * Connected to 192.168.99.100 (192.168.99.100) port 8091 (#0)
   > POST /node/controller/setupServices HTTP/1.1
   > User-Agent: curl/7.37.1
   > Host: 192.168.99.100:8091
   > Accept: */*
   > Content-Length: 26
   > Content-Type: application/x-www-form-urlencoded
   >
   * upload completely sent off: 26 out of 26 bytes
   < HTTP/1.1 200 OK
   * Server Couchbase Server is not blacklisted
   < Server: Couchbase Server
   < Pragma: no-cache
   < Date: Wed, 25 Nov 2015 22:49:51 GMT
   < Content-Length: 0
   < Cache-Control: no-cache
   <
   * Connection #0 to host 192.168.99.100 left intact

.. The command shows an HTTP POST request to the REST endpoint /node/controller/setupServices. The command shows that all three services are configured for the Couchbase server. The Data service is identified by kv, Query service is identified by n1ql and Index service identified by index.

これは REST エンドポイント ``/node/controller/setupServices`` に HTTP POST リクエストを送信した結果です。コマンドの結果は、Couchbase サーバ用に３つのサービスが設定されています。 Data サービスは ``kv`` 、Query サービスは ``n1ql`` 、Index サービスは ``index`` なのが分かります。

.. Setup credentials for the Couchbase server

.. _setup-credentials-for-the-couchbase-server:

Couchbase サーバの認証情報をセットアップ
--------------------------------------------------

.. Sets the username and password credentials that will subsequently be used for managing the Couchbase server.

あとで Couchbase サーバを管理するため、ユーザ名とパスワードの認証情報を設定します。

.. code-block:: bash

   curl -v -X POST http://192.168.99.100:8091/settings/web -d port=8091 -d username=Administrator -d password=password
   * Hostname was NOT found in DNS cache
   *   Trying 192.168.99.100...
   * Connected to 192.168.99.100 (192.168.99.100) port 8091 (#0)
   > POST /settings/web HTTP/1.1
   > User-Agent: curl/7.37.1
   > Host: 192.168.99.100:8091
   > Accept: */*
   > Content-Length: 50
   > Content-Type: application/x-www-form-urlencoded
   >
   * upload completely sent off: 50 out of 50 bytes
   < HTTP/1.1 200 OK
   * Server Couchbase Server is not blacklisted
   < Server: Couchbase Server
   < Pragma: no-cache
   < Date: Wed, 25 Nov 2015 22:50:43 GMT
   < Content-Type: application/json
   < Content-Length: 44
   < Cache-Control: no-cache
   <
   * Connection #0 to host 192.168.99.100 left intact
   {"newBaseUri":"http://192.168.99.100:8091/"}

.. The command shows an HTTP POST request to the REST endpoint /settings/web. The user name and password credentials are passed in the request.

これは REST エンドポイント ``/settings/web`` に HTTP POST リクエストを送信した結果です。ユーザ名とパスワードの認証情報がリクエスト中に含まれています。

.. Install sample data

.. _install-sample-data:

サンプル・データのインストール
------------------------------

.. The Couchbase server can be easily load some sample data in the Couchbase instance.

Couchbase サーバは couchbase インスタンス内で簡単にサンプル・データを読み込めます。

.. code-block:: bash

   curl -v -u Administrator:password -X POST http://192.168.99.100:8091/sampleBuckets/install -d '["travel-sample"]'
   * Hostname was NOT found in DNS cache
   *   Trying 192.168.99.100...
   * Connected to 192.168.99.100 (192.168.99.100) port 8091 (#0)
   * Server auth using Basic with user 'Administrator'
   > POST /sampleBuckets/install HTTP/1.1
   > Authorization: Basic QWRtaW5pc3RyYXRvcjpwYXNzd29yZA==
   > User-Agent: curl/7.37.1
   > Host: 192.168.99.100:8091
   > Accept: */*
   > Content-Length: 17
   > Content-Type: application/x-www-form-urlencoded
   >
   * upload completely sent off: 17 out of 17 bytes
   < HTTP/1.1 202 Accepted
   * Server Couchbase Server is not blacklisted
   < Server: Couchbase Server
   < Pragma: no-cache
   < Date: Wed, 25 Nov 2015 22:51:51 GMT
   < Content-Type: application/json
   < Content-Length: 2
   < Cache-Control: no-cache
   <
   * Connection #0 to host 192.168.99.100 left intact
   []

.. The command shows an HTTP POST request to the REST endpoint /sampleBuckets/install. The name of the sample bucket is passed in the request.

これは REST エンドポイント ``/sampleBuckets/install`` に HTTP POST リクエストを送信した結果です。サンプル・バケット名をリクエスト中に指定します。

.. Congratulations, you are now running a Couchbase container, fully configured using the REST API.

おつかれさまでした。Couchbase コンテナの設定を、全て REST API を使って行いました。

.. Query Couchbase using CBQ

.. _query-couchbase-using-cbq:

CBQ を使って Couchbase に問い合わせ
----------------------------------------

.. CBQ, short for Couchbase Query, is a CLI tool that allows to create, read, update, and delete JSON documents on a Couchbase server. This tool is installed as part of the Couchbase Docker image.

`CBQ <http://developer.couchbase.com/documentation/server/4.1/cli/cbq-tool.html>`_ は Couchbase への問い合わせを省略するコマンドライン・ツールです。これは Couchbase サーバに対して JSON ドキュメントの作成・読み込み・更新・削除が可能です。ツールは Couchbase Docker イメージに同梱されています。

.. Run CBQ tool:

CBQ ツールの実行：

.. code-block:: bash

   docker run -it --link db:db couchbase cbq --engine http://db:8093
   Couchbase query shell connected to http://db:8093/ . Type Ctrl-D to exit.
   cbq>

.. --engine parameter to CBQ allows to specify the Couchbase server host and port running on the Docker host. For host, typically the host name or IP address of the host where Couchbase server is running is provided. In this case, the container name used when starting the container, db, can be used. 8093 port listens for all incoming queries.

``--engine`` パラメータは、 CBQ に Docker ホスト上で動いている Couchbase サーバのホストとポートを指定します。ホストとは、通常、Couchbase サーバを実行しているホストの名前もしくは IP アドレスです。今回の例では、コンテナを起動時に指定したコンテナ名 ``db``  とポート ``8093``  が全てのクエリを受け付けます。

.. Couchbase allows to query JSON documents using N1QL. N1QL is a comprehensive, declarative query language that brings SQL-like query capabilities to JSON documents.

Couchbase には `N1QL <http://developer.couchbase.com/documentation/server/4.1/n1ql/n1ql-language-reference/index.html>`_ を使う JSON ドキュメントで問い合わせます。N1QL は包括的な宣言型クエリ言語であり、JSON ドキュメントに SQL のような機能を持たせます。

.. Query the database by running a N1QL query:

N1QL クエリを使ってデータベースに問い合わせます：

.. code-block:: bash

   cbq> select * from `travel-sample` limit 1;
   {
       "requestID": "97816771-3c25-4a1d-9ea8-eb6ad8a51919",
       "signature": {
           "*": "*"
       },
       "results": [
           {
               "travel-sample": {
                   "callsign": "MILE-AIR",
                   "country": "United States",
                   "iata": "Q5",
                   "icao": "MLA",
                   "id": 10,
                   "name": "40-Mile Air",
                   "type": "airline"
               }
           }
       ],
       "status": "success",
       "metrics": {
           "elapsedTime": "60.872423ms",
           "executionTime": "60.792258ms",
           "resultCount": 1,
           "resultSize": 300
       }
   }

.. Couchbase Web Console

.. _couchbase-web-console:

Couchbase ウェブ・コンソール
==============================

.. Couchbase Web Console is a console that allows to manage a Couchbase instance. It can be seen at:

`Couchbase ウェブ・コンソール <http://developer.couchbase.com/documentation/server/4.1/admin/ui-intro.html>`_ は Couchbase インスタンスを管理できるコンソールです。次の URL で表示します。

http://192.168.99.100:8091/

.. Make sure to replace the IP address with the IP address of your Docker Machine or localhost if Docker is running locally.

この IP アドレスの部分は Docker Machine の IP アドレスか、ローカルで動かしている場合は ``localhost`` です。

.. seealso:: 

   Quickstart Docker Engine
      https://docs.docker.com/engine/quickstart/
