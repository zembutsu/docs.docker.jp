.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/samples/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/samples/index.md
.. check date: 2020/06/14
.. Commits on Sep 4, 2019 00411a8db2b9071df763673597e953470540398f
.. -----------------------------------------------------------------------------

.. Samples

.. _samples:

=======================================
サンプル
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:


.. Tutorial labs

.. _samples-tutorial-labs:

チュートリアル・ラボ
==============================

.. Learn how to develop and ship containerized applications, by walking through a sample that exhibits canonical practices. These labs are from the Docker Labs repository.

公開されている標準的プラクティスのサンプルを通して、コンテナ化したアプリケーションをどのようにして開発・移動をするか学びましょう。各ラボの出典は `Docker Labs リポジトリ <https://github.com/docker/labs/tree/master>`_ です。

* `Docker for Beginners <https://github.com/docker/labs/tree/master/beginner/>`_ （初心者向け Docker ）
   * 良い「Docker 101」コースです。

* `Docker Swarm mode <https://github.com/docker/labs/tree/master/swarm-mode>`_
   * swarm という、Docker 対応の Docker Engine ネイティブなクラスタ管理

* `Configuring developer tools and programming languages <https://github.com/docker/labs/tree/master/developer-tools/README.md>`_ （開発ツールとプログラミング言語の設定）
   * Docker で共通する開発ツールやプログラミング言語の設定方法

* `Live Debugging Java with Docker <https://github.com/docker/labs/tree/master/developer-tools/java-debugging>`_ （Docker による Java ライブデバッグ）
   * Java 開発者は、コンテナ内でコードをライブで実行、テスト、デバッグしながら開発できる環境を Docker でできます。

* `Docker for Java Developers <https://github.com/docker/labs/tree/master/developer-tools/java/>`_ （Java 開発者のための Docker）
   * Java 開発者向けの、 Docker による初級レベルかつ自己ペースのハンズオンワークショップです。

* `Live Debugging a Node.js application in Docker <https://github.com/docker/labs/tree/master/developer-tools/nodejs-debugging>`_ （Docker による Node.js アプリケーションのライブデバッグ）
   * Node 開発者は、コンテナ内でコードをライブで実行、テスト、デバッグしながら開発できる環境を Docker でできます。

* `Dockerizing a Node.js application <https://github.com/docker/labs/tree/master/developer-tools/nodejs/porting/>`_ （Node.js アプリケーションの Docker 化）
   * シンプルな Node.js アプリケーションでチュートリアルは始まり、Docker 化に必要なステップの詳細と、スケーラビリティを確保します。

* `Docker for ASP.NET and Windows containers <https://github.com/docker/labs/tree/master/windows/readme.md>`_ （ASP.NET と Windows コンテナ用の Docker）
   * Docker は Windows コンテナもサポートしています。ASP.NET 、 SQL Server 等を実行する方法を、チュートリアルで学びましょう。

* `Docker Security <https://github.com/docker/labs/tree/master/security/README.md>`_ （Docker セキュリティ）
   * Docker セキュリティ機能の活用方法

* `Building a 12-factor application with Docker <https://github.com/docker/labs/tree/master/12factor>`_ （12-factor アプリケーションを Docker で構築）
   * Heroku の "クラウドネイティブ・アプリケーションのための 12 要素" に合致するアプリケーションを Docker を使って作成


.. Sample applications:

.. _samples-sample-applications:

サンプルアプリケーション
==============================

* `apt-cacher-ng <https://docs.docker.com/engine/examples/apt-cacher-ng/>`_
   * Docker 化した apt-cacher-ng インスタンスを実行

* `.Net Core application <https://docs.docker.com/engine/examples/dotnetcore/>`_
   * Docker 化した ASP.NET Core アプリケーションを実行

* `ASP.NET Core + SQL Server on Linux <https://docs.docker.com/compose/aspnet-mssql-compose/>`_
   * Docker 化した ASP.NET Core + SQL サーバ環境を実行

* `CouchDB <https://docs.docker.com/engine/examples/couchdb_data_volumes/>`_
   * Docker 化した Couch DB インスタンスを実行

* `Django + PostgreSQL <https://docs.docker.com/compose/django/>`_
   * Docker 化した Django + PostgreSQL 環境を実行

* `PostgreSQL <https://docs.docker.com/engine/examples/postgresql_service/>`_
   * Docker 化した PostgreSQL インスタンスを実行

* `Rails + PostgreSQL <https://docs.docker.com/compose/rails/>`_
   * Docker 化した Rails + PostgreSQL 環境を実行

* `Riak <https://docs.docker.com/engine/examples/running_riak_service/>`_
   * Docker 化した Riak インスタンスを実行

* `SSHd <https://docs.docker.com/engine/examples/running_ssh_service/>`_
   * Docker 化した SSHd インスタンスを実行

.. Library references

.. _samples-library-references:

ライブラリ・リファレンス
==============================

.. The following table provides a list of popular official Docker images. For detailed documentation, select the specific image name.

以下は人気の公式 Docker イメージです。詳細なドキュメントは、各イメージ名をクリックして表示します。

* `adminer <https://hub.docker.com/_/adminer>`_
   * 1つの PHP ファイルによるデータベース管理

* `adoptopenjdk <https://hub.docker.com/_/adoptopenjdk>`_
   * AdoptOpenJDK によって構築された、 OpenJDK + HotSpot and OpenJDK + Eclipse OpenJ9 バイナリの公式イメージ

* `aerospike <https://hub.docker.com/_/aerospike>`_
   * Aerospike とは、フラッシュと RAM 向けに最適化された、信頼性のある高性能な分散データベース

* `alpine <https://hub.docker.com/_/alpine>`_
   * Alpine Linux をベースにし、パッケージ・インデックス一式で構成される最小の Docker イメージで、容量は 5 MB のみ！

* `alt <https://hub.docker.com/_/alt>`_
   * ALT Linux の公式ビルド

* `amazoncorretto <https://hub.docker.com/_/amazoncorretto>`_
   * Corretto は、コストのかからない、 Open Java Development Kit (OpenJDK) のプロダクション対応ディストリビューション

* `amazonlinux <https://hub.docker.com/_/amazonlinux>`_
   * Amazon Linux はアプリケーションに対して安定、安全、高性能な実行環境を提供

* `arangodb <https://hub.docker.com/_/arangodb>`_
   * ドキュメント、グラフ、キーバリュー向けの柔軟なデータモデルを持つ分散データベース

* `backdrop <https://hub.docker.com/_/backdrop>`_
   * 小中のビジネスおよび非営利向けの包括的 CMS

* `bash <https://hub.docker.com/_/bash>`_
   * GNU Bourne Again SHELL プロジェクトの Bash

* `bonita <https://hub.docker.com/_/bonita>`_
   * Bontia はオープンソースのビジネスプロセス管理とワークフロー・スイート

* `buildpack-deps <https://hub.docker.com/_/buildpack-deps>`_
   * Gems のような、様々なモジュールのインストールに使える、共通の依存関係をビスドする集まり

* `busybox <https://hub.docker.com/_/busybox>`_
   * Busybox ベースイメージ

* `cassandra <https://hub.docker.com/_/cassandra>`_
   * Apache Cassandra はオーブンソースの分散ストレージシステム

* `centos <https://hub.docker.com/_/centos>`_
   * CentOS の公式ビルド

* `chronograf <https://hub.docker.com/_/chronograf>`_
   * Chronograf  は infuxDB の時系列データを可視化するツール

* `cirros <https://hub.docker.com/_/cirros>`_
   * CirrOS はクラウド上での実行に特化した小さな OS

* `clearlinux <https://hub.docker.com/_/clearlinux>`_
   * インテルアーキテクチャ用の Clear Linux OS の公式 docker ビルド

* `clefos <https://hub.docker.com/_/clefos>`_
   * ClefOS はクラウド上での実行に特化した小さな OS

* `clojure <https://hub.docker.com/_/clojure>`_
   * Clojure は JVM 上で動作する Lisp の派生

* `composer <https://hub.docker.com/_/composer>`_
   * Composer は PHP で書かれた PHP 用の依存関係マネージャ

* `consul <https://hub.docker.com/_/consul>`_
   * Consul はデータセンタ・ランタイムで、サービス・ディスカバリ、設定、オーケストレーションを提供

* `convertigo <https://hub.docker.com/_/convertigo>`_
   * Convertigo はモバイル・アプリケーション開発のためのオープンソース MBaaS/MADP プラットフォームかつバックエンド

* `couchbase <https://hub.docker.com/_/couchbase>`_
   * Couchbase Server は分散アーキテクチャを持つ NoSQL ドキュメント・データベース

* `couchdb <https://hub.docker.com/_/couchdb>`_
   * CouchDB はドキュメント用 JSON を使うデータベースで、 HTTP API と JavaScript の宣言型インデックス

* `crate <https://hub.docker.com/_/crate>`_
   * CrateDB は分散 SQL データベースで、リアルタイムに大量のマシンデータを扱う

* `crux <https://hub.docker.com/_/crux>`_
   * CRUX は熟練した Linux ユーザが対象の、軽量な Linux ディストリビューション

* `debian <https://hub.docker.com/_/debian>`_
   * Debian は全て自由かつオープンソース・ソフトウェアによって構成される Linux ディストリビューション

* `docker <https://hub.docker.com/_/docker>`_
   * Docker in Docker！（Docker で Docker を動かす）

* `drupal <https://hub.docker.com/_/drupal>`_
   * Drupal は数百万のウェブサイトやアプリケーションを支える、オープンソースのコンテント管理プラットフォーム

* `eclipse-mosquitto <https://hub.docker.com/_/eclipse-mosquitto>`_
   * Eclipse Mosquitto はオープンソースのメッセージ・ブローカで、MQTT バージョン 5、3.1.1 と 3.1 を実装

* `eggdrop <https://hub.docker.com/_/eggdrop>`_
   * Eggdrop の公式 Docker イメージで、 IRC で最も古くから開発がアクティブなボット

* `elasticsearch <https://hub.docker.com/_/elasticsearch>`_
   * Elasticsearch は強力なオープンソースの検索および解析エンジンで、データを簡単に探索できる

* `elixir <https://hub.docker.com/_/elixir>`_
   * Elixir は動的で機能的な言語で、スケーラブルでメンテナンス可能なアプリケーション向け

* `erlang <https://hub.docker.com/_/erlang>`_
   * Erlang はプログラミング言語で、大規模にスケールする高可用性システムを構築するのに使う

* `euleros <https://hub.docker.com/_/euleros>`_
   * EulerOS の公式リリース

* `express-gateway <https://hub.docker.com/_/express-gateway>`_
   * Express Gateway の公式 Docker イメージで、API とマイクロサービス用の API ゲートウェイ

* `fedora <https://hub.docker.com/_/fedora>`_
   * Fedora の公式 Docker ビルド

* `flink <https://hub.docker.com/_/flink>`_
   * Apache Flink は強力なオープンソースの分散システム、かつ、バッチ処理フレームワーク

* `fluentd <https://hub.docker.com/_/fluentd>`_
   * Fluentd はオープンソースのデータコレクタで、ログ記録レイヤを統合する用途

* `fsharp <https://hub.docker.com/_/fsharp>`_
   * F# はマルチパラダイム言語で、機能性、継承、オブジェクト指向スタイルを包括

* `gazebo <https://hub.docker.com/_/gazebo>`_
   * Gazebo はロボットのシミュレーション用途のオープンソース・プロジェクトで、物理およびレンダリングに特化

* `gcc <https://hub.docker.com/_/gcc>`_
   * GNU コンパイラ・コレクションは複数の言語をサポートするコンパイリング・システム

* `geonetwork <https://hub.docker.com/_/geonetwork>`_
   * GeoNetwork は参照型リソースに特化した FOSS カタログ

* `ghost <https://hub.docker.com/_/ghost>`_
   * Ghost は JavaScript で書かれた自由かつオープンソースのブログ記述プラットフォーム

* `golang <https://hub.docker.com/_/golang>`_
   * Go（Go言語）は汎用的な、高レベル、インタラクティブなプログラミング言語

* `gradle <https://hub.docker.com/_/gradle>`_
   * Gradle は構築ツールで、構築の自動化と複数言語の開発サポート員特化

* `groovy <https://hub.docker.com/_/groovy>`_
   * Apache Groovy は Java プラットフォーム向けに複数の切り口がある言語

* `haproxy <https://hub.docker.com/_/haproxy>`_
   * HAProxy は信頼性がある高性能 TCP/HTTP ロードバランサ

* `haskell <https://hub.docker.com/_/haskell>`_
   * Haskell は高度で純粋に機能的なプログラミング言語

* `haxe <https://hub.docker.com/_/haxe>`_
   * Haxe は複数のコンパイルを対象にした、モダンで、高レベルな、静的型プログラミング言語

* `hello-world <https://hub.docker.com/_/hello-world>`_
   * Hello World!（Docker 化の最小例）

* `httpd <https://hub.docker.com/_/httpd>`_
   * Apache HTTPD サーバ・プロジェクト

* `hylang <https://hub.docker.com/_/hylang>`_
   * Hy は Lisp の派生で、Python の抽象化構文ツリーに変換して表現

* `ibmjava <https://hub.docker.com/_/ibmjava>`_
   * 公式 IBM(R) SDK, Java(TM) テクノロジーエディションの Docker イメージ

* `influxdb <https://hub.docker.com/_/influxdb>`_
   * InfluxDB はオープンソースの時系列データベースで、用途はメトリクス、イベント、解析

* `irssi <https://hub.docker.com/_/irssi>`_
   * irssi は未来の IRC クライアント

* `jetty <https://hub.docker.com/_/jetty>`_
   * Jetty はウェブサーバと javax.servlet コンテナを提供

* `jobber <https://hub.docker.com/_/jobber>`_
   * Jobber は cron の代替で、適切なステータス報告とエラーハンドリングをする

* `joomla <https://hub.docker.com/_/joomla>`_
   * Jommla はオープンソースのコンテント管理システム

* `jruby <https://hub.docker.com/_/jruby>`_
   * jRuby（http://www.jruby.org）は JVM 上の Ruby（ http://www.ruby-lang.org ）実装

* `julia <https://hub.docker.com/_/julia>`_
   * Julia はテクニカル・コンピューティング用の高レベル、高パフォーマンスな動的プログラミング言語

* `kaazing-gateway <https://hub.docker.com/_/kaazing-gateway>`_
   * Kaazing Gateway の公式ビルド

* `kapacitor <https://hub.docker.com/_/kapacitor>`_
   * Kapacitor は時系列データのプロセッシング、モニタリング、アラーティングのためのオープンソースのフレームワーク

* `kibana <https://hub.docker.com/_/kibana>`_
   * Kibana は構造化・非構造化にかかわらず様々なデータをまとめ、Elasticsearch でインデックス化します

* `known <https://hub.docker.com/_/known>`_
   * ブログを書き、ソーシャルで会う。Known はソーシャル・パブリッシング・プラットフォームです

* `kong <https://hub.docker.com/_/kong>`_
   * API とマイクロサービスのためのクラウドネイティブ API ゲートウェイ＆サービス

* `lightstreamer <https://hub.docker.com/_/lightstreamer>`_
   * Lightstreamer はリアルタイムのメッセージングサーバで、インターネットに最適化

* `logstash <https://hub.docker.com/_/logstash>`_
   * Logstash はイベントとログを管理するツール

* `mageia <https://hub.docker.com/_/mageia>`_
   * 公式 Mageia ベースイメージ

* `mariadb <https://hub.docker.com/_/mariadb>`_
   * MariaDB は MySQL をフォークし、GNU GPL 配下を維持し続けるためコミュニティによって開発

* `matomo <https://hub.docker.com/_/matomo>`_
   * Matomo は先駆的なオープンソースの解析プラットフォームで、パワフルな解析を提供

* `maven <https://hub.docker.com/_/maven>`_
   * Apache maven はソフトウェアのプロジェクト管理と理解のためのツール

* `mediawiki <https://hub.docker.com/_/mediawiki>`_
   * MediaWiki は PHP で書かれたオープンソース wiki パッケージで、自由に使えるソフトウェア

* `memcached <https://hub.docker.com/_/memcached>`_
   * 自由に使える＆オープンソースの、高性能、分散メモリ・オブジェクト・キャッシュ・システム

* `mongo-express <https://hub.docker.com/_/mongo-express>`_
   * Web ベースの MongoDB 管理インターフェイスで、Node.js と express で記述

* `mongo <https://hub.docker.com/_/mongo>`_
   * MongoDB ドキュメント・データベースは高可用性と簡単なスケーラビリティを提供

* `mono <https://hub.docker.com/_/mono>`_
   * Mono は Microsoft の .NET フレームワークのオープンソースによる実装

* `mysql <https://hub.docker.com/_/mysql>`_
   * MySQL は広範囲で利用されている、オープンソースのリレーショナル・データベース管理システム（RDBMS）

* `nats-streaming <https://hub.docker.com/_/nats-streaming>`_
   * NATS Streaming はオープンソースの、高性能な、クラウドネイティブなメッセージング・ストリーミング・システム

* `nats <https://hub.docker.com/_/nats>`_
   * NATS はオープンソースの、高性能な、クラウドネイティブなメッセージング・システム

* `neo4j <https://hub.docker.com/_/neo4j>`_
   * Neo4j は高スケーラブルで堅牢なネイティブ・グラフ・データベース

* `neurodebian <https://hub.docker.com/_/neurodebian>`_
   * NeuroDebian は 神経科学研究ソフトウエアで、Debian 、Ubuntu 、その他派生向け

* `nextcloud <https://hub.docker.com/_/nextcloud>`_
   * 全てのデータのための安全なホーム

* `nginx <https://hub.docker.com/_/nginx>`_
   * Nginx の公式ビルド

* `node <https://hub.docker.com/_/node>`_
   * Node.js は JavaScript をベースとしたプラットフォームで、サーバサイドとネットワーキング・アプリケーション向け

* `notary <https://hub.docker.com/_/notary>`_
   * Notary Server と協調的書名を扱う書名（signer cooperatively handle signing）と notary リポジトリの配布

* `nuxeo <https://hub.docker.com/_/nuxeo>`_
   * Nuxeo はオープンソースのコンテント管理プラットフォームで、完全にカスタマイズ可能

* `odoo <https://hub.docker.com/_/odoo>`_
   * Odoo（以前は OpenERP という名称）はオープンソースのビジネスアプリ・スイート

* `open-liberty <https://hub.docker.com/_/open-liberty>`_
   * 公式 Open Liberty イメージ

* `openjdk <https://hub.docker.com/_/openjdk>`_
   * OpenJDK は Java プラットフォーム Standard Edition のオープンソース実装

* `opensuse <https://hub.docker.com/_/opensuse>`_
   * 廃止 - openSUSE プロジェクトによる現在のイメージは opensuse/leap と opensuse/tumbleweed を参照

* `oraclelinux <https://hub.docker.com/_/oraclelinux>`_
   * Oracle Linux の公式 Docker ビルド

* `orientdb <https://hub.docker.com/_/orientdb>`_
   * OrientDB はマルチ・モデルのオープンソース NoSQL DBMS で、グラフとドキュメントを組み合わせたもの

* `percona <https://hub.docker.com/_/percona>`_
   * Percona Server は MySQL リレーショナル・データベース管理のフォークで、Percona によって作られた

* `perl <https://hub.docker.com/_/perl>`_
   * Perl は高レベル、汎用的、インタプリタ型の、動的プログラミング言語

* `photon <https://hub.docker.com/_/photon>`_
   * Photon OS はオープンソースの最小 Linux コンテナホスト

* `php-zendserver <https://hub.docker.com/_/php-zendserver>`_
   * Zend Server は統合 PHP アプリケーション・プラットフォームで、ウェブとモバイルアプリケーションの両方向け

* `php <https://hub.docker.com/_/php>`_
   * ウェブ開発用に設計された PHP スクリプティング言語で、汎用的にも使えるよう提供

* `plone <https://hub.docker.com/_/plone>`_
   * Phone は自由に使えるオープンソースのコンテント管理システムで、Zope 上で構築

* `postfixadmin <https://hub.docker.com/_/postfixadmin>`_
   * Postfix Admin は Postfix メールサーバ用のウェブベースの管理インターフェース

* `postgres <https://hub.docker.com/_/postgres>`_
   * PostgreSQL オブジェクト関連データベース・システムは信頼性とデータの完全性を提供

* `pypy <https://hub.docker.com/_/pypy>`_
   * PyPy は高速で、 Python 言語の実装を忠実に置き換えたもの

* `python <https://hub.docker.com/_/python>`_
   * Python はインタプリタ型の、インタラクティブで、オブジェクト指向のオープンソース・プログラミング言語

* `r-base <https://hub.docker.com/_/r-base>`_
   * R は統計学的計算とグラフのためのシステム

* `rabbitmq <https://hub.docker.com/_/rabbitmq>`_
   * RabbitMQ はオープンソースのマルチ・プロトコロウのメッセージブローカー

* `rakudo-star <https://hub.docker.com/_/rakudo-star>`_
   * Rakudo Perl 6、もしくはシンプルに Rakudo は、Perl 6 プログラミング言語のコンパイラ

* `rapidoid <https://hub.docker.com/_/rapidoid>`_
   * Rapidoid は高性能 HTTP サーバとモダンな Java ウェブフレームワーク / アプリケーションコンテナ

* `redis <https://hub.docker.com/_/redis>`_
   * Redis はオープンソースのキーバリューストアで、データ構造サーバを機能として扱う

* `redmine <https://hub.docker.com/_/redmine>`_
   * Redmine は柔軟なプロジェクト管理ウェブアプリケーションで、Ruby on Rails フレームワークを用いて記述

* `registry <https://hub.docker.com/_/registry>`_
   * Docker イメージの保管・配布をする、Docker Registry 2.0 の実装

* `rethinkdb <https://hub.docker.com/_/rethinkdb>`_
   * RethinkDB はオープンソースのドキュメント・データベースで、リアルタイム・アプリの構築とスケールを簡単にする

* `rocket.chat <https://hub.docker.com/_/rocket.chat>`_
   * 完全にオープンソースのチャット・ソリューション

* `ros <https://hub.docker.com/_/ros>`_
   * Robot Operating System（ROS）はロボットアプリケーションを構築するためのオープンソースのプロジェクト

* `ruby <https://hub.docker.com/_/ruby>`_
   * Ruby はオープンソースのプログラミング言語で、動的でリフレクティブで、オブジェクト指向であり、汎用的

* `rust <https://hub.docker.com/_/rust>`_
   * Rust は安全、速度、一貫性に焦点をあてたシステムプログラミング言語

* `sapmachine <https://hub.docker.com/_/sapmachine>`_
   * 公式 SapMachine Docker イメージ

* `scratch <https://hub.docker.com/_/scratch>`_
   * 中身がないイメージ（emply image）であると明示します。特にイメージ構築時 "FROM scratch" として指定

* `sentry <https://hub.docker.com/_/sentry>`_
   * Sentry はリアルタイムの、プラットフォームに依存しないエラーのログ記録と統合プラットフォーム

* `silverpeas <https://hub.docker.com/_/silverpeas>`_
   * Silverpeas はターンキーかつオープンソースの共同作業およびソーシャルネットワーキング・プラットフォーム

* `sl <https://hub.docker.com/_/sl>`_
   * Scientific Linux (SL) の公式コンテナ

* `solr <https://hub.docker.com/_/solr>`_
   * Solr は人気のある非常に高速なオープンソースのエンタープライズ検索プラットフォームで、 Apache ライセンス(TM) 上で構築

* `sonarqube <https://hub.docker.com/_/sonarqube>`_
   * SonarQube はコード品質を継続的に調査するための、オープンソースのプラットフォーム

* `sourcemage <https://hub.docker.com/_/sourcemage>`_
   * SourceMage はオープンソースをベースとし、カスタマイズによる最大限の柔軟さがある GNU/Linux ディストリビューション

* `spiped <https://hub.docker.com/_/spiped>`_
   * Spiped は対象暗号化（symmetrically encrypted）とソケット間における認証パイプを作成するユーティリティ

* `storm <https://hub.docker.com/_/storm>`_
   * Apache Storm は自由に使えるオープンソースとして配布されている、リアルタイム計算システム

* `swarm <https://hub.docker.com/_/swarm>`_
   * Swarm とは Docker ネイティブのクラスタリング・システム

* `swift <https://hub.docker.com/_/swift>`_
   * Swift は高性能なシステムプログラミング言語。Swift を詳しく学ぶには swift.org を訪問

* `swipl <https://hub.docker.com/_/swipl>`_
   * SWI-Prolog は包括的なフリー Prolog 環境を提供

* `teamspeak <https://hub.docker.com/_/teamspeak>`_
   * TeamSpeak はインターネット経由での音声コミュニケーション品質に対するソフトウェア

* `telegraf <https://hub.docker.com/_/telegraf>`_
   * Telegraf はメトリクスを収集するエージェントと、メトリクスを InfluxDB や他のアウトプットに書き出す

* `thrift <https://hub.docker.com/_/thrift>`_
   * Thrift は IDL からクライアントとサービスを生成するフレームワーク

* `tomcat <https://hub.docker.com/_/tomcat>`_
   * Apache Tomcat はオープンソースで実装した Java サーブレットと JavaServer Pages 技術

* `tomee <https://hub.docker.com/_/tomee>`_
   * Apache TomEE は全て Java EE で認定された最大のスタック

* `traefik <https://hub.docker.com/_/traefik>`_
   * Traefic はクラウドネイティブのエッジ・ルータ

* `ubuntu <https://hub.docker.com/_/ubuntu>`_
   * Ubuntu は自由に使えるソフトウェアを基盤とする  Debian がベースの Linux オペレーティングシステム

* `varnish <https://hub.docker.com/_/varnish>`_
   * Varnish は HTTP アクセラレータで、コンテンツが重たい動的なウェブサイトだけでなく API も対象に設計

* `vault <https://hub.docker.com/_/vault>`_
   * Vault は統合インターフェースと厳密なアクセス制御を経由し、シークレット（機微情報）に安全にアクセスできるようにするツール

* `websphere-liberty <https://hub.docker.com/_/websphere-liberty>`_
   * Liberty イメージ開発者向けの公式 IBM WebSphere アプリケーションサーバ

* `wordpress <https://hub.docker.com/_/wordpress>`_
   * WordPress は豊富な機能を持つコンテント管理システムで、プラグインやウィジェットやテーマを活用できる

* `xwiki <https://hub.docker.com/_/xwiki>`_
   * XWiki は高度なオープンソースのエンタープライズ Wiki 

* `yourls <https://hub.docker.com/_/yourls>`_
   * YOURLS は自分で URL を短くできる PHP スクリプト群

* `znc <https://hub.docker.com/_/znc>`_
   * ZNC は高度な IRC バウンサー

* `zookeeper <https://hub.docker.com/_/zookeeper>`_
   * Apache ZooKeeper は高信頼性分散コーディネーションのためのオープンソースのサーバ


.. seealso::

   Samples
      https://docs.docker.com/samples/


