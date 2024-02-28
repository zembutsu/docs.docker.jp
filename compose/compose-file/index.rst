.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/compose-file/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/compose-file/index.md
.. check date: 2022/07/19
.. Commits on Jul 19, 2022 7f199a6d107a98faa1becc85f681b80b2c1f7be7
.. -------------------------------------------------------------------

.. Compose specification
.. _compose-specification:

==============================
Compose Specification（仕様）
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The Compose file is a YAML file defining services, networks, and volumes for a Docker application. The latest and recommended version of the Compose file format is defined by the Compose Specification. The Compose spec merges the legacy 2.x and 3.x versions, aggregating properties across these formats and is implemented by Compose 1.27.0+.

Compose ファイルとは、Docker アプリケーション用のサービス、ネットワーク、ボリュームを定義した `YAML ファイル <https://yaml.org/>`_ です。最新かつ推奨される Compose ファイル形式のバージョンは、 `Compose Specification <https://github.com/compose-spec/compose-spec/blob/master/spec.md>`_ で定義されています。Compose の仕様は、古いバージョン 2.x と 3.x を１つにまとめ、各フォーマット間が :ruby:`持っている属性 <property>` を統合したものが、 **Compose 1.27.0 以上** から実装されています。

.. Status of this document
.. _compose-status-of-this-document:

この文章の状態
====================

.. This document specifies the Compose file format used to define multi-containers applications. Distribution of this document is unlimited.

このドキュメントで定めるのは、複数コンテナのアプリケーションを定義するために使う Compose ファイル形式についての仕様です。このドキュメントの配布に制限はありません。

.. The key words “MUST”, “MUST NOT”, “REQUIRED”, “SHALL”, “SHALL NOT”, “SHOULD”, “SHOULD NOT”, “RECOMMENDED”, “MAY”, and “OPTIONAL” in this document are to be interpreted as described in RFC 2119.

このドキュメントにおけるキーワード「 :ruby:`しなければならない <MUST>` 」「 :ruby:`してはならない <MUST NOT>` 」「 :ruby:`することになる <SHALL>` 」「 :ruby:`することはない <SHALL NOT>` 」「 :ruby:`する必要がある <SHOULD>` 」「 :ruby:`しないほうがよい <SHOULD NOT>` 」「 :ruby:`推奨される <RECOMMENDED>` 」「 :ruby:`してもよい <MAY>` 」「 :ruby:`選択できる <OPTIONAL>` 」の解釈に対する説明は `RFC 2119 <https://tools.ietf.org/html/rfc2119>`_ にあります。


.. Requirements and optional attributes
.. _requirements-and-optional-attributes:

動作条件とオプションの属性
==============================

.. The Compose specification includes properties designed to target a local OCI container runtime, exposing Linux kernel specific configuration options, but also some Windows container specific properties, as well as cloud platform features related to resource placement on a cluster, replicated application distribution and scalability.

Compose 仕様には、Linux カーネル固有で設定オプションを公開するような、ローカルの `OCI <https://opencontainers.org/>`_ コンテナ ランタイムを対象に設計された :ruby:`属性 <property>` を含みます。しかし、いくつかの Windows コンテナ固有の属性だけでなく、同様にクラスタ上でのリソース配置、複製したアプリケーションの分散と :ruby:`拡張性 <scalability>` といった、クラウド プラットフォームに関連する機能もあります。

.. We acknowledge that no Compose implementation is expected to support all attributes, and that support for some properties is Platform dependent and can only be confirmed at runtime. The definition of a versioned schema to control the supported properties in a Compose file, established by the docker-compose tool where the Compose file format was designed, doesn’t offer any guarantee to the end-user attributes will be actually implemented.

私たちが認識しているのは、 **全ての** 属性をサポートする Compose の実装は一切期待されておらず、また、いくつかの属性はプラットフォームに依存し、実行時にのみ確認できることです。バージョン化された枠組みの定義とは、 Compose ファイル形式が設計された `docker-compose <https://github.com/docker/compose>`_ ツールによって確立されたもので、 Compose ファイル内でサポートしている属性を制御するためでした。そのため、エンドユーザに属する実装が、実際に行えるかどうかを保証しません。

.. The specification defines the expected configuration syntax and behavior, but - until noted - supporting any of those is OPTIONAL.

この仕様が定義するのは、想定している設定情報の構文と挙動ですが、特に注記がなければ、これらをサポートするかどうかは :ruby:`選択可能 <OPTIONAL>` です。

.. A Compose implementation to parse a Compose file using unsupported attributes SHOULD warn user. We recommend implementors to support those running modes:

Compose の実装では、Compose ファイルで :ruby:`サポート外 <unsupported>` の属性を解析しようとすると、ユーザに対して警告を :ruby:`する必要があります <SHOULD>` 。私たちが推奨する実装は、以下の実行モデルのサポートです：

..  default: warn user about unsupported attributes, but ignore them
    strict: warn user about unsupported attributes and reject the compose file
    loose: ignore unsupported attributes AND unknown attributes (that were not defined by the spec by the time implementation was created)

* デフォルト：サポート外の属性はユーザに警告するが、それらを無視
* :ruby:`厳密 <strict>` ：サポート外の属性をユーザに警告し、compose ファイルを :ruby:`拒否 <reject>`
* :ruby:`緩い <loose>` ：サポート外および未知の属性を無視する（未知の属性とは、仕様で定義されていない実装によって作成された場合）

.. The Compose application model
.. _the-compose-application-model:

Compose のアプリケーション モデル
========================================

.. The Compose specification allows one to define a platform-agnostic container based application. Such an application is designed as a set of containers which have to both run together with adequate shared resources and communication channels.

Compose の :ruby:`仕様 <specification>` とは、 :ruby:`プラットフォームに依存しない <platform-agnostic>` コンテナを基礎とするアプリケーションを定義できるようにするための仕様です。このアプリケーションの設計では、複数のコンテナが相互に動作できるよう、適切にリソースと通信チャネルを確保します。

.. Computing components of an application are defined as Services. A Service is an abstract concept implemented on platforms by running the same container image (and configuration) one or more times.

アプリケーションの :ruby:`計算コンポーネント <computing component>` は、 :ref:`サービス（services） <services-top-level-element>` によって定義されます。サービスとはプラットフォーム上に実装される抽象的な概念で、同じコンテナ イメージ（と設定）を何度も実行できるものです。

.. Services communicate with each other through Networks. In this specification, a Network is a platform capability abstraction to establish an IP route between containers within services connected together. Low-level, platform-specific networking options are grouped into the Network definition and MAY be partially implemented on some platforms.

サービスは :ref:`ネットワーク（networks） <networks-top-level-element>` を通して相互に通信します。この仕様では、ネットワークとは :ruby:`プラットフォーム機能の抽象化 <platform capability abstraction>` であり、サービス内のコンテナが一緒に接続できるよう IP 経路を確立します。下位のレベルでは、プラットフォーム固有のネットワーク機能のオプションを、ネットワークの定義内でグループ化されていますが、いくつかのプラットフォームでは部分的に実装する :ruby:`可能性があります <MAY>` 。

.. Services store and share persistent data into Volumes. The specification describes such a persistent data as a high-level filesystem mount with global options. Actual platform-specific implementation details are grouped into the Volumes definition and MAY be partially implemented on some platforms.

サービスは :ref:`ボリューム（volumes） <volumes-top-level-element>` 内に :ruby:`保持するデータ <persistent data>` の保存と共有をします。仕様では、グローバルのオプションを使い、上位レベルのファイルシステムへマウントするように、保持するデータを記述します。実際のプラットフォーム固有の実装詳細は、ボリューム定義内にグループ化されていますが、いくつかのプラットフォームでは部分的に実装する :ruby:`可能性があります <MAY>` 。

.. Some services require configuration data that is dependent on the runtime or platform. For this, the specification defines a dedicated concept: Configs. From a Service container point of view, Configs are comparable to Volumes, in that they are files mounted into the container. But the actual definition involves distinct platform resources and services, which are abstracted by this type.

いくつかのサービスは、ランタイムやプラットフォームに依存する :ruby:`設定情報 <configuration>` データを必要とします。このため、仕様では :ref:`設定情報（configs） <configs-top-level-element>` という、専用の概念を定義しています。サービス用コンテナの視点からすると、コンテナ内にファイルをマウントするため、 :ruby`設定情報 <configs>` はボリュームに似ています。しかし、実際の定義では、このタイプで抽象化されたプラットフォーム固有のリソースとサービスを含みます。

.. A Secret is a specific flavor of configuration data for sensitive data that SHOULD NOT be exposed without security considerations. Secrets are made available to services as files mounted into their containers, but the platform-specific resources to provide sensitive data are specific enough to deserve a distinct concept and definition within the Compose specification.

:ref:`機微情報（secrets） <secrets-top-level-element>` は、セキュリティの考慮なしに公開 :ruby:`しないほうがよい <SHOULD NOT>` （細心の注意を払うべき）センシティブなデータのための、特別な設定情報です。機微情報はサービス内のコンテナに対してファイルをマウントして利用できます。プラットフォーム固有の機微データを提供するリソースがある場合にも、Compose 仕様内で明確な概念と定義に値するための、十分な指定があります。

.. Distinction within Volumes, Configs and Secret allows implementations to offer a comparable abstraction at service level, but cover the specific configuration of adequate platform resources for well identified data usages.

volumes、configs、secret 内を区別すると、サービスレベルでも同等の抽象化された実装が行えますが、プラットフォーム固有のリソースにおける明確なデータ仕様用途に対しては、その（固有のリソースに）特化した設定で扱います。

.. A Project is an individual deployment of an application specification on a platform. A project’s name is used to group resources together and isolate them from other applications or other installation of the same Compose specified application with distinct parameters. A Compose implementation creating resources on a platform MUST prefix resource names by project and set the label com.docker.compose.project.

**プロジェクト（project）** は、個々のアプリケーション仕様をプラットフォーム上に展開したものです。プロジェクトの名前は、リソースを一緒に扱うグループのために使われたり、他のアプリケーションとは分離されたり、同じ Compose 仕様のアプリケーションでありながら、特定のパラメータを持つ他のものをインストールします。プラットフォーム上の Compose 実装は、プロジェクトごとにリソース名を前につけ、ラベル ``com.docker.compose.project`` を :ruby:`付けなければいけません。 <MUST>` 

.. Project name can be set explicitly by top-level name attribute. Compose implementation MUST offer a way for user to set a custom project name and override this name, so that the same compose.yaml file can be deployed twice on the same infrastructure, without changes, by just passing a distinct name.

プロジェクト名は、トップレベルの ``name`` 属性で明示できます。Compose 実装では、ユーザが任意のプロジェクト名の指定と、この名前を上書きできるように :ruby:`しなければなりません <MUST>` 。つまり、異なる名前を渡すだけで、同じ ``compose.yaml`` ファイルを元にしながら、変更のない同じ構造を２つデプロイできます。

.. Illustrative example
.. _compose-file-illustrative-example:

説明例
==========

.. The following example illustrates Compose specification concepts with a concrete example application. The example is non-normative.

以下の例では、具体的なアプリケーション例を使い Compose 仕様の概要を説明します。この例は規範的ではありません。

.. Consider an application split into a frontend web application and a backend service.

フロントエンド ウェブアプリケーションとバックエンド サービスに分かれたアプリケーションを考えます。

.. The frontend is configured at runtime with an HTTP configuration file managed by infrastructure, providing an external domain name, and an HTTPS server certificate injected by the platform’s secured secret store.

フロントエンドは、基盤によって管理されている HTTP 設定ファイルを使い、実行時に設定をします。設定とは、外部でのドメイン名と、プラットフォームの安全な :ruby:`機微情報 <シークレット>` ストアから投入された HTTPS サーバ証明書です。

.. The backend stores data in a persistent volume.

バックエンドは :ruby:`持続型ボリューム <persistent volume>` にデータを保管します。

.. Both services communicate with each other on an isolated back-tier network, while frontend is also connected to a front-tier network and exposes port 443 for external usage.

どちらのサービスも隔離された後方ネットワーク上で互いに通信します。一方、フロントエンドも前方ネットワークに接続し、外部から使うためにポート 443 を公開します。

   .. image:: ./images/compose-sample.png
      :alt: Compose 例

.. The example application is composed of the following parts:

このアプリケーション例では、以下のパーツを組み込んでいます。

..  2 services, backed by Docker images: webapp and database
    1 secret (HTTPS certificate), injected into the frontend
    1 configuration (HTTP), injected into the frontend
    1 persistent volume, attached to the backend
    2 networks

* 2つのサービス、 Docker イメージを元にしている： ``webapp`` と ``database``
* 1つの機微情報（HTTPS 証明書）、フロントエンドに投入
* 1つの設定情報（HTTP）、フロントエンドに投入
* 1つの持続型ボリューム、バックエンドに :ruby:`取り付け <attached>`
* 2つのネットワーク

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       ports:
         - "443:8043"
       networks:
         - front-tier
         - back-tier
       configs:
         - httpd-config
       secrets:
         - server-certificate
   
     backend:
       image: awesome/database
       volumes:
         - db-data:/etc/data
       networks:
         - back-tier
   
   volumes:
     db-data:
       driver: flocker
       driver_opts:
         size: "10GiB"
   
   configs:
     httpd-config:
       external: true
   
   secrets:
     server-certificate:
       external: true
   
   networks:
     # これらオブジェクトを定義するには、存在するだけで十分
     front-tier: {}
     back-tier: {}

.. This example illustrates the distinction between volumes, configs and secrets. While all of them are all exposed to service containers as mounted files or directories, only a volume can be configured for read+write access. Secrets and configs are read-only. The volume configuration allows you to select a volume driver and pass driver options to tweak volume management according to the actual infrastructure. Configs and Secrets rely on platform services, and are declared external as they are not managed as part of the application lifecycle: the Compose implementation will use a platform-specific lookup mechanism to retrieve runtime values.

この例では、 volumes 、 configs 、 secrets 間の違いを示します。これらはすべて、サービス用コンテナに対してファイルやディレクトリをマウントしているように見えますが、ボリュームのみ読み込みと書き込みの作業ができます。secrets と configs は読み込み専用です。実際の基盤にしたがってボリューム管理を調整するには、ボリュームの設定情報によって、ボリュームドライバを選択したり、ドライバにオプションを渡せたりします。configs と secrets はプラットフォーム上のサービスに依存します。また、これらはアプリケーションのライフサイクルとして管理されないため、 ``external`` と宣言します。つまり、 Compose の実装では、プラットフォーム固有の :ruby:`調査 <lookup>` メカニズムを使用して、ランタイム値を取得します。

.. Compose file
.. _compose-spec-compose-file:

Compose ファイル
====================

.. The Compose file is a YAML file defining version (DEPRECATED), services (REQUIRED), networks, volumes, configs and secrets. The default path for a Compose file is compose.yaml (preferred) or compose.yml in working directory. Compose implementations SHOULD also support docker-compose.yaml and docker-compose.yml for backward compatibility. If both files exist, Compose implementations MUST prefer canonical compose.yaml one.

Compose ファイルとは `YAML <http://yaml.org/>`_ ファイルであり、 :ref:`version <version-top-level-element>` （非推奨）、 :ref:`services <services-top-level-element>` （必須）、 :ref:`networks <networks-top-level-element>` 、 :ref:`volumes <volumes-top-level-element>` 、 :ref:`configs <configs-top-level-element>` 、 :ref:`secrets <secrets-top-level-element>` を定義します。作業ディレクトリ内での、Compose ファイルのデフォルトのパスは ``compose.yaml`` （推奨）か ``compose.yml`` です。Compose 実装は、下位互換性のために ``docker-compose.yaml`` と ``docker-compose.yml`` もサポート :ruby:`すべきです。 <SHOULD>` 両方のファイルが存在する場合、 Compose 実装は標準である ``compose.yaml`` を優先 :ruby:`しなければいけません <MUST>` 。

.. Multiple Compose files can be combined together to define the application model. The combination of YAML files MUST be implemented by appending/overriding YAML elements based on Compose file order set by the user. Simple attributes and maps get overridden by the highest order Compose file, lists get merged by appending. Relative paths MUST be resolved based on the first Compose file’s parent folder, whenever complimentary files being merged are hosted in other folders.

アプリケーション モデルを定義するために、複数の Compose ファイルを一緒に組み合わせられます。YAML ファイルの結合にあたっては、ユーザによって指定された Compose ファイルの順番に基づき、 YAML 要素の追加と上書きを実装 :ruby:`しなければいけません <MUST>` 。単一の属性と :ruby:`マップ <map>` は、最上位の Compose ファイルによって上書きされます。また、リストでは追加されたものを統合します。統合される補完ファイルが他のフォルダ内に置かれている場合、常に相対パスは **1つめの** Compose ファイルの親ディレクトリを基準に解決 :ruby:`しなければいけません <MUST>` 。

.. As some Compose file elements can both be expressed as single strings or complex objects, merges MUST apply to the expanded form.

いくつかの Compose ファイル要素は、単一文字列か複雑なオブジェクトとして表記できるため、統合する場合は拡張形式を適用 :ruby:`しなければいけません <MUST>` 。

.. Profiles
.. _compose-spec-profiles:

profiles
----------

.. Profiles allow to adjust the Compose application model for various usages and environments. A Compose implementation SHOULD allow the user to define a set of active profiles. The exact mechanism is implementation specific and MAY include command line flags, environment variables, etc.

profiles によって、様々な用途や環境にあわせて Compose アプリケーション モデルを調整できます。Compose 実装は、ユーザがアクティブな profiles のセットを定義できるように :ruby:`すべきです <SHOULD>` 。厳密な仕組みは個別の実装次第であり、コマンドラインのフラグ、環境変数等も :ruby:`含められます <MAY>` 。

.. The Services top-level element supports a profiles attribute to define a list of named profiles. Services without a profiles attribute set MUST always be enabled. A service MUST be ignored by the Compose implementation when none of the listed profiles match the active ones, unless the service is explicitly targeted by a command. In that case its profiles MUST be added to the set of active profiles. All other top-level elements are not affected by profiles and are always active.

サービスのトップレベル要素は、 ``profiles`` 属性をサポートし、 profiles 名の一覧を定義します。 ``profiles`` 属性セットの無いサービスは、常に有効に :ruby:`しなければいけません <MUST>` 。 ``profiles`` に一致するアクティブな profiles が存在しなければ、サービスがコマンドで対象を明示されていない限り、サービスは Compose 実装によって無視 :ruby:`されなければいけません <MUST>` 。その場合、その porifles をアクティブな profiles のセットに追加 :ruby:`しなければいけません <MUST>` 。これ以外すべてのトップレベル要素は profiles の影響を受けず、常に機能します。

.. References to other services (by links, extends or shared resource syntax service:xxx) MUST not automatically enable a component that would otherwise have been ignored by active profiles. Instead the Compose implementation MUST return an error.

他のサービスへの参照（ ``links`` 、 ``extends`` 、共有リソース構文 ``service:xxx`` ）は、アクティブな profiles によって無視されたコンポーネントを自動的に有効化 :ruby:`してはいけません <MUST>` 。そのかわり、 Compose 実装はエラーを :ruby:`返さなければなりません <MUST>` 。

.. Illustrative example
.. _compose-spec-profiles-example:

説明例
^^^^^^^^^^

.. code-block:: yaml

   services:
     foo:
       image: foo
     bar:
       image: bar
       profiles:
         - test
     baz:
       image: baz
       depends_on:
         - bar
       profiles:
         - test
     zot:
       image: zot
       depends_on:
         - bar
       profiles:
         - debug

..    Compose application model parsed with no profile enabled only contains the foo service.

* profiles を有効にしないで構文解析された Compose アプリケーション モデルには、 ``foo`` サービスしか含みません。

..     If profile test is enabled, model contains the services bar and baz which are enabled by the test profile and service foo which is always enabled.

* profiles で ``test`` を有効化する場合、モデルに含まれるサービスは ``test`` profile によって有効化される  ``bar`` と ``baz`` のサービスと、サービス ``foo`` は常に有効です。

..     If profile debug is enabled, model contains both foo and zot services, but not bar and baz and as such the model is invalid regarding the depends_on constraint of zot.

* profiles で ``debug`` を有効化する場合、モデルに含まれるサービスは ``foo`` と ``zot`` の両方ですが、 ``bar`` と ``baz`` や ``zot`` の ``depends_on`` 条件があるようなモデルも無効です。

..     If profiles debug and test are enabled, model contains all services: foo, bar, baz and zot.

* profiles ``debug`` と ``test`` を有効化する場合、モデルには全てのサービスを含みます。つまり、 ``foo`` 、 ``bar`` 、 ``baz`` 、 ``zot`` です。

..     If Compose implementation is executed with bar as explicit service to run, it and the test profile will be active even if test profile is not enabled by the user.

*  ``bar`` を起動するサービスとして明示して Compose 実装を実行する場合、「ユーザによって」 ``test`` profile を有効にしていない場合でも、``bar`` と ``tst`` をサービスとして実行します。

..     If Compose implementation is executed with baz as explicit service to run, the service baz and the profile test will be active and bar will be pulled in by the depends_on constraint.

* ``baz`` を起動するサービスとして明示して Compose 実装を実行する場合、サービス ``baz`` と ``test`` profile が有効になり、 ``depends_on`` 強制によって ``bar`` も実行されます。

..     If Compose implementation is executed with zot as explicit service to run, again the model will be invalid regarding the depends_on constraint of zot since zot and bar have no common profiles listed.

* ``zot`` を起動するサービスとして明示して Compose 実装を実行する場合、 ``zot`` と ``bar`` に共通する ``profiles`` が一覧にないため、 ``zot`` の  ``depends_on`` 強制についてのモデルは無効になります。

..     If Compose implementation is executed with zot as explicit service to run and profile test enabled, profile debug is automatically enabled and service bar is pulled in as a dependency starting both services zot and bar.

* ``zot`` を起動するサービスとして明示し、 profile ``test`` を有効にして Compose 実装を実行する場合、profile ``debug`` が自動的に有効になり、サービス ``zot`` と ``bar`` の両方は依存関係があるため、 ``bar`` が実行されます。

.. Version top-level element
.. _version-top-level-element:

version トップレベル要素
==============================

.. Top-level version property is defined by the specification for backward compatibility but is only informative.

トップレベルの ``version`` 属性は、下位互換性のために仕様で定義されていますが、情報を参考にするためだけです。

.. A Compose implementation SHOULD NOT use this version to select an exact schema to validate the Compose file, but prefer the most recent schema at the time it has been designed.

Compose 実装は、 Compose ファイルの検証にあたり、正確なスキームを選ぶためにこの version を使う :ruby:`べきではありません <SHOULD NOT>` 。そうではなく、 Compose ファイルが設計された時点での最新のスキーマを優先すべきです。

.. Compose implementations SHOULD validate whether they can fully parse the Compose file. If some fields are unknown, typically because the Compose file was written with fields defined by a newer version of the specification, Compose implementations SHOULD warn the user. Compose implementations MAY offer options to ignore unknown fields (as defined by “loose” mode).

Comopse 実装は Compose ファイルを完全に構文解析できるかどうかを検証 :ruby:`すべきです <SHOULD>` 。もしも一部に未知のフィールドがある場合、通常、その Compose ファイルは新しいバージョンの仕様によって定義されたフィールドで書かれているため、 Compose 実装はユーザに警告 :ruby:`すべき <SHOULD>` です。Compose 実装は未知のフィールドを無視するオプションを :ruby:`提供してもよいです <MAY>` （「 :ref:`loose <compose-spec-requirements-and-optional-attributes>` 」モードによって定義されます）。

.. Name top-level element
.. _name-top-level-element:

name トップレベル要素
==============================

.. Top-level name property is defined by the specification as project name to be used if user doesn’t set one explicitly. Compose implementations MUST offer a way for user to override this name, and SHOULD define a mechanism to compute a default project name, to be used if the top-level name element is not set.

トップレベルの ``name`` 属性は、ユーザが明示的に設定しない場合に使われる、プロジェクト名として仕様で定義されています。Compose 実装では、ユーザこの名前を上書きする方法を提供 :ruby:`しなければいけません <MUST>` 。また、トップレベルの ``name`` 要素が設定されない場合、デフォルトのプロジェクト名を :ruby:`決定する <compute>` 仕組みを定義 :ruby:`すべきです <SHOULD>` 。

.. Whenever project name is defined by top-level name or by some custom mechanism, it MUST be exposed for interpolation and environment variable resolution as COMPOSE_PROJECT_NAME

トップレベルの ``name`` や何らかの特別な仕組みによってプロジェクト名が定義される場合は、ただちに :ref:`補完 <compose-spec-interpolation>` で変数展開したり、環境変数 ``COMPOSE_PROJECT_NAME`` として解決できるように :ruby:`すべき <MUST>` です。

.. code-block:: yaml

   services:
     foo:
       image: busybox
       environment:
         - COMPOSE_PROJECT_NAME
       command: echo "I'm running ${COMPOSE_PROJECT_NAME}"

.. Services top-level element
.. _services-top-level-element:

services トップレベル要素
==============================

.. A Service is an abstract definition of a computing resource within an application which can be scaled/replaced independently from other components. Services are backed by a set of containers, run by the platform according to replication requirements and placement constraints. Being backed by containers, Services are defined by a Docker image and set of runtime arguments. All containers within a service are identically created with these arguments.

:ruby:`サービス <service>` とはアプリケーション内の :ruby:`計算資源 <computing resource>` に対する抽象的な定義であり、他の :ruby:`コンポーネント <構成要素>` からは独立して :ruby:`スケール <拡大・縮小>` や置き換えができます。サービスはコンテナの集まりによって支えられ、 :ruby:`複製の要件 <replication requirements>` と :ruby:`配置の制約 <placement constraints>` に照らしながらプラットフォームによって実行されます。コンテナによって支えられているサービスは、 Docker イメージとランタイム引数のセットで定義されます。サービス内のすべてのコンテナは、これらの引数により完全に同じように作成されます。

.. A Compose file MUST declare a services root element as a map whose keys are string representations of service names, and whose values are service definitions. A service definition contains the configuration that is applied to each container started for that service.

Compose ファイルでは、 :ruby:`マップ <map>` として ``services`` ルート要素を宣言する :ruby:`必要があります <MUST>` 。マップとは、キーがサービス名を表す文字列で、値がサービスを定義します。サービス定義には、サービス用に起動する各コンテナに適用する設定情報も含みます。

.. Each service MAY also include a Build section, which defines how to create the Docker image for the service. Compose implementations MAY support building docker images using this service definition. If not implemented the Build section SHOULD be ignored and the Compose file MUST still be considered valid.

各サービスには build セクションも :ruby:`含めてもよく <MAY>` 、サービス用の Docker イメージの作成方法を定義します。Compose 実装は、このサービス定義を使っての Docker イメージの構築をサポート :ruby:`してもよいです <MAY>` 。build セクションを実装しない場合、このセクションを無視 :ruby:`すべきで <SHOULD>` すが、Compose ファイルでは有効のままにする :ruby:`必要があります <MUST>` 。

.. Build support is an OPTIONAL aspect of the Compose specification, and is described in detail in the Build support documentation.

build のサポートは、 Compose 仕様において :ruby:`選択できる <OPTIONAL>` 項目です。これは、 :doc:`build サポート <build>` ドキュメントに詳細な説明があります。

.. Each Service defines runtime constraints and requirements to run its containers. The deploy section groups these constraints and allows the platform to adjust the deployment strategy to best match containers’ needs with available resources.

各サービスは、サービスを実行する :ruby:`ランタイム制約 <runtime constraint>` と必要条件を定義します。 ``deploy`` セクションは、これらの制約をグループ化できます。さらに、プラットフォームは利用可能なリソースと、コンテナが必要なリソースを一致させるよう、 :ruby:`デプロイ方針 <deployment strategy>` を調整できるようにします。

.. Deploy support is an OPTIONAL aspect of the Compose specification, and is described in detail in the Deployment support documentation. If not implemented the Deploy section SHOULD be ignored and the Compose file MUST still be considered valid.

deploy のサポートは Compose 仕様において :ruby:`選択できる <OPTIONAL>` 項目です。これは :doc:`deployment サポート <deploy>` ドキュメントに詳細な説明があります。deploy セクションを実装しない場合、このセクションを無視 :ruby:`すべきで <SHOULD>` すが、Compose ファイルでは有効のままにする :ruby:`必要があります <MUST>` 

.. build
.. _compose-spec-build:

build
----------

.. build specifies the build configuration for creating container image from source, as defined in the Build support documentation.

``build`` 、はソースからコンテナ イメージを作成するための :ruby:`構築情報 <build configuration>` を指定します。これは :doc:`build サポート <compose-file/build>` 

.. blkio_config
.. _compose-spec-blkio_config:

blkio_config
^^^^^^^^^^^^^^^^^^^^

.. blkio_config defines a set of configuration options to set block IO limits for this service.

``blkio_config`` が定義するのは、サービスに対するブロック IO を制限するオプション設定の集まりです。

.. code-block:: yaml

   services:
     foo:
       image: busybox
       blkio_config:
          weight: 300
          weight_device:
            - path: /dev/sda
              weight: 400
          device_read_bps:
            - path: /dev/sdb
              rate: '12mb'
          device_read_iops:
            - path: /dev/sdb
              rate: 120
          device_write_bps:
            - path: /dev/sdb
              rate: '1024k'
          device_write_iops:
            - path: /dev/sdb
              rate: 30

.. device_read_bps, device_write_bps
.. _compose-spec-device_read_bps-device_write_bps:

device_read_bps、 device_write_bps
````````````````````````````````````````

.. Set a limit in bytes per second for read / write operations on a given device. Each item in the list MUST have two keys:

特定のデバイス上で、読み書き処理に対する制限を、1秒あたりのバイト数で指定します。リスト内の各項目は、2つのキーを持つ :ruby:`必要があります <MUST>` 。

..  path: defining the symbolic path to the affected device.
    rate: either as an integer value representing the number of bytes or as a string expressing a byte value.

* ``path`` ：影響があるデバイスへのシンボリック パスを定義
* ``rate`` ：バイト数を表す整数値、あるいは、バイト値を表現する文字列のどちらか

.. device_read_iops, device_write_iops
.. _compose-spec-device_read_iops-device_write_iops:

device_read_iops、 device_write_iops
````````````````````````````````````````

.. Set a limit in operations per second for read / write operations on a given device. Each item in the list MUST have two keys:

特定のデバイス上で、読み書きに対する制限を、1秒あたりの処理回数で指定します。リストの各項目は、2つのキーを持つ :ruby:`必要があります <MUST>` 。

..  path: defining the symbolic path to the affected device.
    rate: as an integer value representing the permitted number of operations per second.

* ``path`` ：影響があるデバイスへのシンボリック パスを定義
* ``rate`` ：1秒あたりに許可する処理回数を、整数値で示す

.. weight
.. _compose-spec-weight:

weight
``````````

.. Modify the proportion of bandwidth allocated to this service relative to other services. Takes an integer value between 10 and 1000, with 500 being the default.

他のサービスと比較し、このサービスに割り当てる帯域の比率を調整します。 10 から 1000 までの整数値をとり、デフォルトは 500 になります。

.. weight_device
.. _compose-spec-weight_device:

weight_device
````````````````````

.. Fine-tune bandwidth allocation by device. Each item in the list must have two keys:

デバイスに対する帯域を微調整します。各アイテムの値は2つのキーを持つ必要があります。リストの各項目は、2つのキーを持つ :ruby:`必要があります <MUST>` 。

..  path: defining the symbolic path to the affected device.
    weight: an integer value between 10 and 1000.

* ``path`` ：影響があるデバイスへのシンボリック パスを定義
* ``weight`` ： 10 から 1000 までの整数値

.. cpu_count
.. _compose-spec-cpu_count:

cpu_count
----------

.. cpu_count defines the number of usable CPUs for service container.

``cpu_count`` はサービス用コンテナで利用できる CPU の下図を定義します。

.. cpu_percent
.. _compose-spec-cpu_percent:

cpu_percent
--------------------

.. cpu_percent defines the usable percentage of the available CPUs.

利用可能な CPU で使用する割合を定義します。

.. cpu_shares
.. _compose-spec-cpu_share:

cpu_shares
----------

.. cpu_shares defines (as integer value) service container relative CPU weight versus other containers.

``cpu_shares`` はサービス用コンテナに対し、他のコンテナからの相対 CPU ウエイトを（整数値で）定義します。

.. cpu_period
.. _compose-spec-cpu_period:

cpu_period
----------

.. cpu_period allow Compose implementations to configure CPU CFS (Completely Fair Scheduler) period when platform is based on Linux kernel.

プラットフォームが Linux カーネルを基盤としている場合、 ``cpu_period`` は CPU CFS ( Complete Fair Scheduler , 完全公平スケジューラ ) 期間の設定を Compose 実装が行えるようにします。

.. cpu_quota
.. _compose-spec-cpu_quota:

cpu_quota
----------

.. cpu_quota allow Compose implementations to configure CPU CFS (Completely Fair Scheduler) quota when platform is based on Linux kernel.

プラットフォームが Linux カーネルを基盤としている場合、 ``cpu_period`` は CPU CFS ( Complete Fair Scheduler , 完全公平スケジューラ ) クォータの設定を Compose 実装が行えるようにします。

.. cpu_rt_runtime
.. _compose-spec-cpu_rt-runtime:

cpu_rt_runtime
--------------------

.. cpu_rt_runtime configures CPU allocation parameters for platform with support for realtime scheduler. Can be either an integer value using microseconds as unit or a duration.

``cpu_rt_runtime`` は、リアルタイム スケジューラをサポートするプラットフォームに対し、 CPU 割り当てパラメータを設定します。マイクロ秒の単位を整数値で指定するか、 ref:`期間 <compose-spec-specifying-durations>` のどちらかで指定します。

.. code-block:: yaml

   cpu_rt_runtime: '400ms'
   cpu_rt_runtime: 95000`

.. cpu_rt_period:
.. _compose-spec-cpu_rt_period

cpu_rt_period
--------------------

.. cpu_rt_period configures CPU allocation parameters for platform with support for realtime scheduler. Can be either an integer value using microseconds as unit or a duration.

``cpu_rt_period`` は、リアルタイム スケジューラをサポートするプラットフォームに対し、 CPU 割り当てパラメータを設定します。マイクロ秒の単位を整数値で指定するか、 ref:`期間 <compose-spec-specifying-durations>` のどちらかで指定します。

.. code-block:: yaml

   cpu_rt_period: '1400us'
   cpu_rt_period: 11000`

.. cpus
.. _compose-spec-cpus:

cpus
----------

.. DEPRECATED: use deploy.reservations.cpus

*非推奨： :ref:`deploy.reservations.cpu <compose-file-deploy-cpus>` をお使います。*

.. cpus define the number of (potentially virtual) CPUs to allocate to service containers. This is a fractional number. 0.000 means no limit.

``cpu`` はサービス用コンテナに割り当てる （ことが期待できる仮想の）CPU 数を定義します。

.. cpuset
.. _compose-spec-cpuset:

cpuset
----------

.. cpuset defines the explicit CPUs in which to allow execution. Can be a range 0-3 or a list 0,1

``cpuset`` は実行を許可する CPU を明示する定義です。 ``0-3`` のような範囲、または ``0,1`` のようなリストです。

.. cap_add
.. _compose-spec-cap_add:

cap_add
----------

.. cap_add specifies additional container capabilities as strings.

``cap_add`` は文字列でコンテナ `ケーパビリティ <http://man7.org/linux/man-pages/man7/capabilities.7.html>`_ の追加を指定します。

.. code-block:: yaml

   cap_add:
     - ALL

.. cap_drop
.. _compose-spec-cap_drop:

cap_drop
----------

.. cap_drop specifies container capabilities to drop as strings.

``cap_add`` は文字列でコンテナ `ケーパビリティ <http://man7.org/linux/man-pages/man7/capabilities.7.html>`_ を落とす指定をします。


.. code-block:: yaml

   cap_drop:
     - NET_ADMIN
     - SYS_ADMIN

.. cgroup_parent
.. _compose-spec-cgroup_parent:

cgroup_parent
--------------------

.. cgroup_parent specifies an OPTIONAL parent cgroup for the container.

``cgroup_parent`` は、コンテナに対する親 `cgroup <http://man7.org/linux/man-pages/man7/cgroups.7.html>`_ を :ruby:`オプションで <OPTIONAL>` 指定できます。

.. code-block:: yaml

   cgroup_parent: m-executor-abcd

.. command
.. _compose-spec-command:

command
----------

.. command overrides the default command declared by the container image (i.e. by Dockerfile’s CMD).

``command`` はコンテナ イメージによって宣言済み（例： Dockerfile の ``CMD`` ）のデフォルト コマンドを上書きします。

.. code-block:: yaml

   command: bundle exec thin -p 3000

.. The command can also be a list, in a manner similar to Dockerfile:

コマンドはリストにもでき、 :ref:`Dockerfile <cmd>` の書き方に似ています。

.. code-block:: yaml

   command: [ "bundle", "exec", "thin", "-p", "3000" ]

.. configs
.. _compose-spec-cofigs:

configs
----------

.. configs grant access to configs on a per-service basis using the per-service configs configuration. Two different syntax variants are supported.

``configs`` は、サービスごとの ``configs`` :ruby:`設定情報 <configuration>` を元に、サービスごとの設定へのアクセスを許可します。2つの異なる構文形式がサポートされています。

.. Compose implementations MUST report an error if config doesn’t exist on platform or isn’t defined in the configs section of this Compose file.

Compose の実装は、プラットフォーム上に :ruby:`設定 <config>` が存在しないか、この Compose ファイルの ``configs`` セクションで定義されていなければ、エラーを :ruby:`報告しなければいけません <MUST>` 。

.. There are two syntaxes defined for configs. To remain compliant to this specification, an implementation MUST support both syntaxes. Implementations MUST allow use of both short and long syntaxes within the same document.

configs を定義する構文は2つあります。この実装に従い続ける限り、実装は両方の構文をサポート :ruby:`しなければいけません <MUST>` 。また、同じドキュメント内で、短い構文と長い構文の、両方の使用を許可するように実装 :ruby:`しなければいけません <MUST>` 。

.. Short syntax
.. _compose-spec-configs-short-syntax:

短い構文
^^^^^^^^^^

.. The short syntax variant only specifies the config name. This grants the container access to the config and mounts it at /<config_name> within the container. The source name and destination mount point are both set to the config name.

:ruby:`短い構文 <short syntax>` 形式では、 :ruby:`設定名 <config name>` のみ指定します。これにより、コンテナは :ruby:`設定情報 <config>` にアクセスできるようになり、コンテナ内で ``/<設定名>`` としてマウントします。ソース名とマウントポイント先は、どちらも :ruby:`設定情報 <config>` の名前です。

.. The following example uses the short syntax to grant the redis service access to the my_config and my_other_config configs. The value of my_config is set to the contents of the file ./my_config.txt, and my_other_config is defined as an external resource, which means that it has already been defined in the platform. If the external config does not exist, the deployment MUST fail.

以下の例では短い構文を使い、 ``redis`` サービスに対して ``my_config`` と ``my_other_config`` 設定情報へのアクセスを許可します。 ``my_config`` の値は ``./my_config.txt`` ファイルの中に設定されます。そして、 ``my_other_config`` は外部リソースとして定義されており、つまり、既にプラットフォーム内で定義済みを意味します。外部の設定情報が存在しなければ、デプロイは :ruby:`失敗しなければいけません <MUST>` 。

.. code-block:: yaml

   services:
     redis:
       image: redis:latest
       configs:
         - my_config
   configs:
     my_config:
       file: ./my_config.txt
     my_other_config:
       external: true

.. Long syntax
.. _compose-spec-configs-short-syntax:

長い構文
----------

.. The long syntax provides more granularity in how the config is created within the service’s task containers.

長い構文により、より詳細な  :ruby:`設定情報 <config>` をサービスのタスク コンテナ内で作成できるようになります。

..  source: The name of the config as it exists in the platform.
    target: The path and name of the file to be mounted in the service’s task containers. Defaults to /<source> if not specified.
    uid and gid: The numeric UID or GID that owns the mounted config file within the service’s task containers. Default value when not specified is USER running container.
    mode: The permissions for the file that is mounted within the service’s task containers, in octal notation. Default value is world-readable (0444). Writable bit MUST be ignored. The executable bit can be set.

* ``source`` ：プラットフォーム内に存在する設定情報の名前
* ``target`` ：サービス用タスクコンテナ内にマウントする、ファイルのパスと名前
* ``uid`` と ``gid`` ：サービス用タスクコンテナ内にマウントする、設定ファイルを所有する UID か GID を示す整数
* ``mode`` ：サービス用タスクコンテナ内にマウントする、ファイルに対する `パーミッション <https://web.archive.org/web/20220310140126/http://permissions-calculator.org/>`_ を8進数で指定。デフォルト値は誰でも読み込み可能（ ``0444`` ）。書き込み可能なビットは :ruby:`無視しなければいけません <MUST>` 。実行可能ビットは設定できます。

.. The following example sets the name of my_config to redis_config within the container, sets the mode to 0440 (group-readable) and sets the user and group to 103. The redis service does not have access to the my_other_config config.

以下の例は ``my_config`` という名前の設定情報をコンテナ内の ``redis_config`` に設定し、モードを ``0440`` （グループ読み込み可能）とし、ユーザとグループを ``103`` に設定します。この ``redis`` サービスは、 ``my_other_config`` 設定に対してアクセスできない。

.. code-block:: yaml

   services:
     redis:
       image: redis:latest
       configs:
         - source: my_config
           target: /redis_config
           uid: "103"
           gid: "103"
           mode: 0440
   configs:
     my_config:
       external: true
     my_other_config:
       external: true

.. You can grant a service access to multiple configs, and you can mix long and short syntax.

サービスに対し、複数の設定情報へのアクセスを許可できます。また、長い形式と短い形式を混在できます。

.. container_name
.. _compose-spec-container_name:

container_name
--------------------

.. container_name is a string that specifies a custom container name, rather than a generated default name.

``container_name`` は、デフォルトで生成される名前ではなく、任意のコンテナ名を指定する文字列です。

.. code-block:: yaml

   container_name: my-web-container

.. Compose implementation MUST NOT scale a service beyond one container if the Compose file specifies a container_name. Attempting to do so MUST result in an error.

Compose ファイルで ``container_name`` を指定している場合、Compose 実装は、コンテナ1つよりも多くにサービスをスケール :ruby:`させてはいけません <MUST NOT>` 。

.. If present, container_name SHOULD follow the regex format of [a-zA-Z0-9][a-zA-Z0-9_.-]+

指定するには、 ``container_name`` は正規表現の形式 ``[a-zA-Z0-9][a-zA-Z0-9_.-]+`` に :ruby:`従うべきです <SHOULD>` 。

.. credential_spec
.. _compose-spec-credential_spec:

credential_spec
--------------------

.. credential_spec configures the credential spec for a managed service account.

``credential_spec`` は、マネージド サービス アカウント用の :ruby:`認証情報仕様 <credential spec>` を設定します。

.. Compose implementations that support services using Windows containers MUST support file: and registry: protocols for credential_spec. Compose implementations MAY also support additional protocols for custom use-cases.

Windows コンテナーを使うサービスをサポートする Compose 実装では、credential_spec のために ``file:`` と ``registry:`` プロトコルのサポートが :ruby:`必須です <MUST>` 。また、 Compose 実装では、任意の利用例に応じた追加プロトコルをサポート :ruby:`してもよいです <MAY>` 。

.. The credential_spec must be in the format file://<filename> or registry://<value-name>.

``credential_spec`` は ``file://<ファイル名>`` か ``registry://<値の名前>`` の形式にする必要があります。

.. code-block:: yaml

   credential_spec:
     file: my-credential-spec.json

.. When using registry:, the credential spec is read from the Windows registry on the daemon’s host. A registry value with the given name must be located in:

``registry:`` を使う場合、 デーモンのホスト上にある Windows レジストリから、 :ruby:`認証情報仕様 <credential spec>` を読み込みます。レジストリの値は、以下の場所に置く必要があります。


.. code-block:: yaml

   HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Virtualization\Containers\CredentialSpecs

.. The following example loads the credential spec from a value named my-credential-spec in the registry:

以下の例は、レジストリ内の ``my-credential-spec`` という名前の値から、 :ruby:`認証情報仕様 <credential spec>` を読み込みます。

.. code-block:: yaml

   credential_spec:
     registry: my-credential-spec

.. Example gMSA configuration
.. _compose-spec-example-gmsa-configuration

gMSA 設定情報の例
^^^^^^^^^^^^^^^^^^^^

.. When configuring a gMSA credential spec for a service, you only need to specify a credential spec with config, as shown in the following example:

サービスに対して gMSA 認証情報を設定する場合、必要なのは以下の例にあるように、 ``config`` で認証情報仕様を指定するだけです。

.. code-block:: yaml

   services:
     myservice:
       image: myimage:latest
       credential_spec:
         config: my_credential_spec
   
   configs:
     my_credentials_spec:
       file: ./my-credential-spec.json|

.. depends_on
.. _compose-spec-depends_on:

depends_on
----------

.. depends_on expresses startup and shutdown dependencies between services.

``depends_on`` はサービス間の起動順番と終了順番の依存関係を表します。

.. Short syntax
.. _compose-spec-dpends_on-short-syntax:

短い構文
^^^^^^^^^^

.. The short syntax variant only specifies service names of the dependencies. Service dependencies cause the following behaviors:

短い構文の形式は、依存関係があるサービス名のみ指定します。サービスの依存関係によって、次の挙動をもたらします。

..  Compose implementations MUST create services in dependency order. In the following example, db and redis are created before web.
    Compose implementations MUST remove services in dependency order. In the following example, web is removed before db and redis.

* Compose 実装は、依存関係のある順番でサービスを作成する :ruby:`必要があります <MUST>` 。以下の例では、 ``web`` の前に ``db`` と ``redis`` が作成されます。
* Comopse 実装は、依存関係のある順番でサービスを削除する :ruby:`必要があります <MUST>` 。以下の例では、 ``db`` と ``redis`` の前に ``web`` が削除されます。

.. Simple example:
簡単な例：

.. code-block:: yaml

   services:
     web:
       build: .
       depends_on:
         - db
         - redis
     redis:
       image: redis
     db:
       image: postgres

.. Compose implementations MUST guarantee dependency services have been started before starting a dependent service. Compose implementations MAY wait for dependency services to be “ready” before starting a dependent service.

Compose 実装は、依存先のサービスが起動する前に、依存元のサービスを確実に :ruby:`起動しなくてはいけません <MUST>` Compsoe 実装は、依存先のサービスが起動する前に、依存元のサービスを「 :ruby:`待機状態 <ready>` 」になるまで待つ :ruby:`ことができます <MAY>` 。

.. Long syntax
.. _compose-spec-dpends_on-long-syntax:

長い構文
^^^^^^^^^^

.. The long form syntax enables the configuration of additional fields that can’t be expressed in the short form.

長い構文の形式は、短い形式では指定できない追加のフィールドも設定可能になります。

..    condition: condition under which dependency is considered satisfied
        service_started: is an equivalent of the short syntax described above
        service_healthy: specifies that a dependency is expected to be “healthy” (as indicated by healthcheck) before starting a dependent service.
        service_completed_successfully: specifies that a dependency is expected to run to successful completion before starting a dependent service.

* ``condition`` ：依存関係を満たしているとみなす状態

  * ``service_started`` ：前述の短い構文のものと同等
  * ``service_healthy`` ：依存先のサービスを起動する前に、依存元のサービスが「 :ruby:`正常 <healthy>` 」（ :ref:`healthcheck <compose-spec-healthcheck>` で示す）な状態を指定
  * ``service_completed_successfully`` ：依存先のサービスを起動する前に、依存元のサービスは正常に実行済みの状態を指定

.. Service dependencies cause the following behaviors:

サービスの依存関係は、次のような挙動になります。

..    Compose implementations MUST create services in dependency order. In the following example, db and redis are created before web.
    Compose implementations MUST wait for healthchecks to pass on dependencies marked with service_healthy. In the following example, db is expected to be “healthy” before web is created.
    Compose implementations MUST remove services in dependency order. In the following example, web is removed before db and redis.

* Compose 実装は、依存関係のある順番でサービスを作成する :ruby:`必要があります <MUST>` 。以下の例では、 ``web`` の前に ``db`` と ``redis`` が作成されます。
* Compose 実装は、依存元のサービスが ``service_healthy`` で示すヘルスチェックを通過するまで待つ :ruby:`必要があります <MUST>` 。以下の例では、 ``db`` が 「 :ruby:`正常 <healthy>` 」な状態になった後、 ``web`` が作成されます。
* Comopse 実装は、依存関係のある順番でサービスを削除する :ruby:`必要があります <MUST>` 。以下の例では、 ``db`` と ``redis`` の前に ``web`` が削除されます。

.. Simple example:
簡単な例：

.. code-block:: yaml

   services:
     web:
       build: .
       depends_on:
         db:
           condition: service_healthy
         redis:
           condition: service_started
     redis:
       image: redis
     db:
       image: postgres

.. Compose implementations MUST guarantee dependency services have been started before starting a dependent service. Compose implementations MUST guarantee dependency services marked with service_healthy are “healthy” before starting a dependent service.

Compose 実装は、依存元のサービスが起動する前に、依存先のサービスを確実に起動する :ruby:`必要があります <MUST>` 。Compose 実装は、依存元のサービスが起動する前に、依存先のサービスの ``service_healthy`` （サービス正常性）が確実に「 :ruby:`正常 <healthy>` 」になるようにする :ruby:`必要があります <MUST>` 。

.. deploy
.. _compose-spec-deploy:

deploy
----------

.. deploy specifies the configuration for the deployment and lifecycle of services, as defined here.

``deploy`` は、 :doc:`こちら <deploy>` で定義されている通り、サービスの展開とライフサイクルの設定情報を指定します。

.. device_cgroup_rules
.. _compose-spec-device_cgroup_rules:

device_cgroup_rules
--------------------

.. device_cgroup_rules defines a list of device cgroup rules for this container. The format is the same format the Linux kernel specifies in the Control Groups Device Whitelist Controller.

``device_cgroup_rules`` は、このコンテナに対するデバイス cgroup ルールの一覧を定義します。書式は `Control Groups Device Whitelist Controller <https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v1/devices.html>`_ にある Linux カーネルが指定する書式と同じです。

.. code-block:: yaml

   device_cgroup_rules:
     - 'c 1:3 mr'
     - 'a 7:* rmw'

.. devices
.. _compose-spec-devices:

devices
----------

.. devices defines a list of device mappings for created containers in the form of HOST_PATH:CONTAINER_PATH[:CGROUP_PERMISSIONS].

``devices`` は、作成したコンテナにマッピングするデバイスの一覧を ``HOST_PATH:CONTAINER_PATH[:CGROUP_PERMISSIONS]`` の形式で定義します。

.. code-block:: yaml

   devices:
     - "/dev/ttyUSB0:/dev/ttyUSB0"
     - "/dev/sda:/dev/xvda:rwm"

.. dns
.. _compose-spec-dns:

dns
----------

.. dns defines custom DNS servers to set on the container network interface configuration. Can be a single value or a list.

``dns`` は、コンテナのネットワーク インターフェース設定に、任意の DNS サーバを定義します。

.. code-block:: yaml

   dns: 8.8.8.8

.. code-block:: yaml

   dns:
     - 8.8.8.8
     - 9.9.9.9

.. dns_opt
.. _compose-spec-dns_opt:

dns_opt
----------

.. dns_opt list custom DNS options to be passed to the container’s DNS resolver (/etc/resolv.conf file on Linux).

``dns_opt`` は、コンテナの DNS レゾルバに対して渡す、任意のオプションのリストです。

.. code-block:: yaml

   dns_opt:
     - use-vc
     - no-tld-query

.. dns_search
.. _compose-spec-dns_search:

dns_search
----------

.. dns defines custom DNS search domains to set on container network interface configuration. Can be a single value or a list.

``dns_search`` は、コンテナのネットワーク インタフェース設定に、任意の DNS 検索ドメインを定義します。単一の値、もしくはリストで設定できます。

.. code-block:: yaml

   dns_search: example.com

.. code-block:: yaml

   dns_search:
     - dc1.example.com
     - dc2.example.com

.. domainname
.. _compose-spec-domainname:

domainname
----------

.. domainname declares a custom domain name to use for the service container. MUST be a valid RFC 1123 hostname.

``domainname`` では、サービス用コンテナが使う任意のドメイン名を宣言します。これは有効な RFC 1123 ホスト名の :ruby:`必要があります <MUST>` 。

.. entrypoint
.. _compose-spec-entrypoint:

entrypoint
----------

.. entrypoint overrides the default entrypoint for the Docker image (i.e. ENTRYPOINT set by Dockerfile). Compose implementations MUST clear out any default command on the Docker image - both ENTRYPOINT and CMD instruction in the Dockerfile - when entrypoint is configured by a Compose file. If command is also set, it is used as parameter to entrypoint as a replacement for Docker image’s CMD

``entrypoint`` は Docker イメージのデフォルト entrypoint （つまり、 Dockerfile の ``ENTRYPOINT`` 設定）を上書きします。Compose 実装は、 Docker イメージ内のあらゆるデフォルトコマンドを除去する :ruby:`必要があります <MUST>` 。コマンドとは Dockerfile 内の ``ENTRYPOINT`` と ``CMD`` の両命令であり、 Compose ファイルでは ``entrypoint`` で設定します。もしも ``command`` が設定されている場合、これが Docker イメージの ``CMD`` を置き換え、 ``entrypoint`` のパラメータとして使われます。

.. code-block:: yaml

   entrypoint: /code/entrypoint.sh

.. The entrypoint can also be a list, in a manner similar to Dockerfile:

entrypoint はリストにもでき、書き方は :ref:`Dockerfile <cmd>` と似ています。

.. code-block:: yaml

   entrypoint:
     - php
     - -d
     - zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20100525/xdebug.so
     - -d
     - memory_limit=-1
     - vendor/bin/phpunit

.. env_file
.. _compose-spec-env_file:

env_file
----------

.. env_file adds environment variables to the container based on file content.

``env_file`` はファイルの内容をもとに、コンテナへ環境変数を追加します。

.. code-block:: yaml

   env_file: .env

.. env_file can also be a list. The files in the list MUST be processed from the top down. For the same variable specified in two env files, the value from the last file in the list MUST stand.

``env_file`` はリストにもできます。ファイル内のリストは、上から下へと処理する :ruby:`必要があります <MUST>` 。2つの env ファイルで同じ変数が指定されると、リスト内で最も直近の値を有効に :ruby:`しなければいけません <MUST>` 。

.. code-block:: yaml

   env_file:
     - ./a.env
     - ./b.env

.. Relative path MUST be resolved from the Compose file’s parent folder. As absolute paths prevent the Compose file from being portable, Compose implementations SHOULD warn users when such a path is used to set env_file.

相対パス、は Compose ファイルの親フォルダを基準に解決する :ruby:`必要があります <MUST>` 。絶対パスを避ければ Compose ファイルが :ruby:`移動できるようになるため <being portable>` 、Compose 実装では ``env_file`` に絶対パスが使われていれば、 :ruby:`警告すべきです <SHOULD>` 。

.. Environment variables declared in the environment section MUST override these values – this holds true even if those values are empty or undefined.

:ref:`environment <compose-spec-environment>` セクションで宣言された環境変数は、これらの値を上書き :ruby:`すべきです <MUST>` 。つまり、 ``env_file`` を使って定義された変数の値が、空白もしくは未定義だとしても、保持し続けます。

.. Env_file format
.. _compose-spec-env_file-format:

env_file 形式
^^^^^^^^^^^^^^^^^^^^

.. Each line in an env file MUST be in VAR[=[VAL]] format. Lines beginning with # MUST be ignored. Blank lines MUST also be ignored.

env_file の各行は ``変数[=[値]]`` の形式である :ruby:`必要があります <MUST>` 。 ``#`` で始まる行は無視する :ruby:`必要があります <MUST>` 。

.. The value of VAL is used as a raw string and not modified at all. If the value is surrounded by quotes (as is often the case for shell variables), the quotes MUST be included in the value passed to containers created by the Compose implementation.

``値`` の値は、そのままの文字列として使われ、加工は一切行われません。値が引用符で囲まれた場合（通常、シェル変数を扱う場合）、Compose 実装によって作成されるコンテナに対し、引用符を **含めて** 渡す :ruby:`必要があります <MUST>` 。

.. VAL MAY be omitted, in such cases the variable value is empty string. =VAL MAY be omitted, in such cases the variable is unset.

``値`` は省略する :ruby:`ことができます <MAY>` 。たとえば、変数の値が、空白の文字列の場合です。 ``=値`` は省略する :ruby:`ことができます <MAY>` 。たとえば変数の値を **unset** する場合です。


.. code-block:: yaml

   # Rails/Rack 環境変数を設定
   RACK_ENV=development
   VAR="quoted"

.. environment
.. _compose-spec-environment:

environment
--------------------

.. environment defines environment variables set in the container. environment can use either an array or a map. Any boolean values; true, false, yes, no, SHOULD be enclosed in quotes to ensure they are not converted to True or False by the YAML parser.

``environment`` は、コンテナ内での環境変数を定義します。 ``environment`` は配列とマップのどちらかを使えます。あらゆるブール値、true、false、yes、no は、YAML パーサによって True や False に変換されないようにするため、引用符で囲むように :ruby:`すべきです <SHOULD>` 。

.. Environment variables MAY be declared by a single key (no value to equals sign). In such a case Compose implementations SHOULD rely on some user interaction to resolve the value. If they do not, the variable is unset and will be removed from the service container environment.

環境変数の値は、1つのキーで宣言 :ruby:`する場合があります <MAY>` （イコール記号と値がないもの）。このような場合、 Compose 実装は値を解決するため、何らかのユーザとのやりとりに頼る :ruby:`べきです <SHOULD>` 。そうしなければ、変数は unset され、サービス用コンテナ環境から削除されます。

.. Map syntax:
マップ形式の構文：

.. code-block:: yaml

   environment:
     RACK_ENV: development
     SHOW: "true"
     USER_INPUT:

.. Array syntax:
配列形式の構文：

.. code-block:: yaml

   environment:
     - RACK_ENV=development
     - SHOW=true
     - USER_INPUT

.. When both env_file and environment are set for a service, values set by environment have precedence.

サービスに対して ``env_file`` と ``environment`` の両方がある場合、 ``environment`` の値が優先されます。

.. expose
.. _compose-spec-expose:

expose
----------

.. expose defines the ports that Compose implementations MUST expose from container. These ports MUST be accessible to linked services and SHOULD NOT be published to the host machine. Only the internal container ports can be specified.

``expose`` では、 Compose 実装がコンテナから公開 :ruby:`しなければいけない <MUST>` ポートを定義します。これらのポートは、つながっているサービスへ接続 :ruby:`する必要があり <MUST>` ますが、ホストマシン上には公開 :ruby:`しないほうがよい <SHOULD NOT>` ものです。内部のコンテナ用ポートのみ指定できます。

.. code-block:: yaml

   expose:
     - "3000"
     - "8000"

.. extends
.. _compose-spec-extends:

extends
----------

.. Extend another service, in the current file or another, optionally overriding configuration. You can use extends on any service together with other configuration keys. The extends value MUST be a mapping defined with a required service and an optional file key.

現在のファイルや他のファイルからサービスを :ruby:`拡張 <extend>` し、オプションで設定を上書きします。他の設定情報のキーと一緒に、あらゆるサービスで ``extends`` を使えます。 ``extends`` の値はマップで定義する :ruby:`する必要があり <MUST>` 、 ``service`` キーは必須で、 ``file`` キーはオプションです。

.. code-block:: yaml

   extends:
     file: common.yml
     service: webapp

.. If supported Compose implementations MUST process extends in the following way:

Compose 実装がサポートする場合は、以下の方法で ``extends`` を処理する :ruby:`必要があります <MUST>` 。

..     service defines the name of the service being referenced as a base, for example web or database.
    file is the location of a Compose configuration file defining that service.

* ``service`` ベース（元になるもの）として参照されるサービスの名前を定義します。たとえば ``web`` や ``database`` です。
* ``file`` は対象サービス向けの Compose 設定情報ファイルの場所です。

.. Restrictions
.. _compose-spec-extends-restrictions:

制限事項
^^^^^^^^^^

.. The following restrictions apply to the service being referenced:

参照されるサービスには、以下の制限が適用されます。

..  Services that have dependencies on other services cannot be used as a base. Therefore, any key that introduces a dependency on another service is incompatible with extends. The non-exhaustive list of such keys is: links, volumes_from, container mode (in ipc, pid, network_mode and net), service mode (in ipc, pid and network_mode), depends_on.
    Services cannot have circular references with extends

* 他のサービスと依存関係を持つサービスは、他のサービスからのベースとして使えません。つまり、他のサービスに依存しているキーは、 ``extends`` と互換性がありません。このようなキーの網羅的ではない一覧： ``links`` 、 ``volumes_from`` 、 ``container`` モード（ ``ipd`` 、 ``pid`` 、 ``network_mode`` 、 ``net`` ）、 ``service`` モード（ ``ipc`` 、 ``pid`` 、 ``network_mode`` 、 ``depends_on ）。
- サービスは ``extends`` で :ruby:`循環参照 <circular reference>` できません。

.. Compose implementations MUST return an error in all of these cases.

Compose 実装は、これ以外のケースでエラーを返す :ruby:`必要があります <MUST>` 。

.. Finding referenced service
.. _compose-sepc-extends-finding-referenced-service:

参照されているサービスを探す
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. file value can be:

``file`` の値とは：

..  Not present. This indicates that another service within the same Compose file is being referenced.
    File path, which can be either:
        Relative path. This path is considered as relative to the location of the main Compose file.
        Absolute path.

* 存在しない場合。これは同じ Comopse ファイル内の別のサービスが参照されているのを示します。
* 以下どちらかのファイルパスです。

  * 相対パス。このパスはメインの Compose がある場所からの相対パスとみなします。
  * 絶対パス。

.. Service denoted by service MUST be present in the identified referenced Compose file. Compose implementations MUST return an error if:

``service`` によって示すサービスは、参照用として指定された Compose ファイルに存在する :ruby:`必要があります <MUST>` 。Compose 実装は、以下の場合にエラーを :ruby:`返さなければいけません <MUST>` 。

..  Service denoted by service was not found
    Compose file denoted by file was not found

* ``service`` で示されたサービスが見つからない
* ``file`` で示された Compose ファイルが見つからない

.. Merging service definitions
.. _compose-spec-merging-service-definitions:

サービス定義の統合
^^^^^^^^^^^^^^^^^^^^

.. Two service definitions (main one in the current Compose file and referenced one specified by extends) MUST be merged in the following way:

2つのサービス定義（1つは *main* で現在の Compose ファイル、もう1つは ``extends`` で指定した *referenced* として参照されるもの）は、以下の方法で統合する :ruby:`必要があります <MUST>` 

..  Mappings: keys in mappings of main service definition override keys in mappings of referenced service definition. Keys that aren’t overridden are included as is.
    Sequences: items are combined together into an new sequence. Order of elements is preserved with the referenced items coming first and main items after.
    Scalars: keys in main service definition take precedence over keys in the referenced one.

* :ruby:`マッピング <mapping>`： *main* サービス定義のマッピング内のキーは、 *referenced* サービス定義のマッピング内のキーを上書きします。上書きされないキーは、そのまま含まれたままです（残ったままです）。
* :ruby:`シーケンス <sequence>`：アイテムは結合され、新しいシーケンスになります。要素の順番は、 *referenced* アイテムが最初で、次に *main* アイテムが続きます。
* :ruby:`スカラー <scalar>`： *main* サービス内の定義は、 *referenced* サービス定義内のキーよりも優先されます。


.. Mappings
.. _compose-spec-mappings:

:ruby:`マッピング <mappings>`
``````````````````````````````

.. The following keys should be treated as mappings: build.args, build.labels, build.extra_hosts, deploy.labels, deploy.update_config, deploy.rollback_config, deploy.restart_policy, deploy.resources.limits, environment, healthcheck, labels, logging.options, sysctls, storage_opt, extra_hosts, ulimits.

次のキーがマッピングとして扱われるでしょう： ``build.args`` 、 ``build.labels`` 、 ``build.extra_hosts`` 、 ``deploy.labels`` 、 ``deploy.update_config`` 、 ``deploy.rollback_config`` 、 ``deploy.restart_policy`` 、 ``deploy.resources.limits`` 、 ``environment`` 、 ``healthcheck`` 、 ``labels`` 、 ``logging.options`` 、 ``sysctls`` 、 ``storage_opt`` 、 ``extra_hosts`` 、 ``ulimits.`` 。

.. One exception that applies to healthcheck is that main mapping cannot specify disable: true unless referenced mapping also specifies disable: true. Compose implementations MUST return an error in this case.

``healthcheck`` に対しては例外が適用されます。 *referenced* マッピングで ``disable: true`` を指定しない限り、 *main* マッピングでも ``disable: true`` を指定できません。Compose 実装は、このような場合にエラーを返す :ruby:`必要があります <MUST>` 。

.. For example, the input below:

たとえば、以下のような入力があります。

.. code-block:: yaml

   services:
     common:
       image: busybox
       environment:
         TZ: utc
         PORT: 80
     cli:
       extends:
         service: common
       environment:
         PORT: 8080

.. Produces the following configuration for the cli service. The same output is produced if array syntax is used.

以下の設定で ``cli`` サービスを生成します。配列形式を使うと、同じ出力が生成されます。

.. code-block:: yaml

   environment:
     PORT: 8080
     TZ: utc
   image: busybox

.. Items under blkio_config.device_read_bps, blkio_config.device_read_iops, blkio_config.device_write_bps, blkio_config.device_write_iops, devices and volumes are also treated as mappings where key is the target path inside the container.

``blkio_config.device_read_bps`` 、 `` blkio_config.device_read_iops`` 、 `` blkio_config.device_write_bps`` 、 `` blkio_config.device_write_iops`` 、 `` devices and volumes`` 以下のアイテムも、キーとしてコンテナ内のパスが対象にあれば、マッピングとして扱われます。

.. For example, the input below:

たとえば、以下のような入力があります。

.. code-block:: yaml

   services:
     common:
       image: busybox
       volumes:
         - common-volume:/var/lib/backup/data:rw
     cli:
       extends:
         service: common
       volumes:
         - cli-volume:/var/lib/backup/data:ro

.. Produces the following configuration for the cli service. Note that mounted path now points to the new volume name and ro flag was applied.

以下の設定で ``cli`` サービスを生成します。注意点として、マウントされたパスは新しいボリューム名を指し示し、 ``ro`` フラグが適用されます。

.. code-block:: yaml

   image: busybox
   volumes:
   - cli-volume:/var/lib/backup/data:ro

.. If referenced service definition contains extends mapping, the items under it are simply copied into the new merged definition. Merging process is then kicked off again until no extends keys are remaining.

*referenced* サービスの定義が ``extends`` マッピングを含む場合は、新しい統合された定義に対し、アイテム以下がシンプルにコピーされます。統合の処理は ``extends`` キーが存在しなくなるまで、繰り返し行われます。

.. For example, the input below:

たとえば、以下のような入力があります。

.. code-block:: yaml

   services:
      base:
         image: busybox
         user: root
      common:
         image: busybox
         extends:
            service: base
      cli:
         extends:
            service: common

.. Produces the following configuration for the cli service. Here, cli services gets user key from common service, which in turn gets this key from base service.

以下の設定で ``cli`` サービスを生成します。ここでは、 ``cli`` サービスは ``common`` サービスから ``user`` キーを取得します。サービスは ``base`` サービスからこのキーを取得します。

.. code-block:: yaml

   image: busybox
   user: root

.. Sequences
.. _compose-spec-sequences:

:ruby:`シーケンス <sequences>`
``````````````````````````````

.. The following keys should be treated as sequences: cap_add, cap_drop, configs, deploy.placement.constraints, deploy.placement.preferences, deploy.reservations.generic_resources, device_cgroup_rules, expose, external_links, ports, secrets, security_opt. Any duplicates resulting from the merge are removed so that the sequence only contains unique elements.

以下のキーはシーケンスとして扱われるべきです：``cap_add`` 、 ``cap_drop`` 、 ``configs`` 、 ``deploy.placement.constraints`` 、 ``deploy.placement.preferences`` 、 ``deploy.reservations.generic_resources`` 、 ``device_cgroup_rules`` 、 ``expose`` 、 ``external_links`` 、 ``ports`` 、 ``secrets`` 、 ``security_opt`` 。統合の結果、重複した結果は削除されるため、シーケンスに含まれるのはユニークな（重複しない）要素のみです。

.. For example, the input below:

たとえば、以下のような入力があります。

.. code-block:: yaml

   services:
     common:
       image: busybox
       security_opt:
         - label:role:ROLE
     cli:
       extends:
         service: common
       security_opt:
         - label:user:USER

.. Produces the following configuration for the cli service.

以下の設定で ``cli`` サービスを生成します。

.. code-block:: yaml

   image: busybox
   security_opt:
   - label:role:ROLE
   - label:user:USER

.. In case list syntax is used, the following keys should also be treated as sequences: dns, dns_search, env_file, tmpfs. Unlike sequence fields mentioned above, duplicates resulting from the merge are not removed.

リスト形式を使う場合、以下のキーはシーケンスとしても扱われるべきです： ``dns`` 、 ``dns_search`` 、 ``env_file`` 、 ``tmpfs`` 。先述したシーケンスのフィールドとは異なり、統合の結果、重複したものは削除されます。

.. Scalars
.. _compose-spec-scalars:

:ruby:`スカラー <scalars>`
``````````````````````````````

.. Any other allowed keys in the service definition should be treated as scalars.

その他のサービス内で許可されたキーは、スカラーとして扱われるべきです。

.. external_links
.. _compose-spec-external_links:

external_links
--------------------

.. external_links link service containers to services managed outside this Compose application. external_links define the name of an existing service to retrieve using the platform lookup mechanism. An alias of the form SERVICE:ALIAS can be specified.

``external_links`` は、この Compose アプリケーションの外で管理されているサービスと、サービスコンテナを :ruby:`接続 <link>` します。 ``external_links`` で定義するのは、プラットフォームの検索機能を使って受け取る、既存のサービス名です。 ``サービス:別名`` 形式で :ruby:`別名 <alias>` も指定できます。

.. code-block:: yaml

   external_links:
     - redis
     - database:mysql
     - database:postgresql

.. extra_hosts
.. _compose-spec-extra-hosts:

extra_hosts
--------------------

.. extra_hosts adds hostname mappings to the container network interface configuration (/etc/hosts for Linux). Values MUST set hostname and IP address for additional hosts in the form of HOSTNAME:IP.

``extra_hosts`` はコンテナのネットワーク インタフェース設定（ Linux は ``/etc/hosts`` ）に対して、ホスト名のマッピングを追加します。値には、ホスト名と IP アドレスを ``ホスト名:IP`` の形式で指定する :ruby:`必要があります <MUST>` 。

.. code-block:: yaml

   extra_hosts:
     - "somehost:162.242.195.82"
     - "otherhost:50.31.209.229"

.. Compose implementations MUST create matching entry with the IP address and hostname in the container’s network configuration, which means for Linux /etc/hosts will get extra lines:

Compose 実装は、コンテナのネットワーク設定内に IP アドレスとホスト名に一致するエントリを :ruby:`作成しなくてはいけません <MUST>` 。つまり、 Linux の場合は ``/etc/hosts`` に次のような行が追加されるのを意味します。

.. code-block:: yaml

   162.242.195.82  somehost
   50.31.209.229   otherhost

.. group_add
.. _compose-spec-group_add:

group_add
----------

.. group_add specifies additional groups (by name or number) which the user inside the container MUST be a member of.

``group_add`` は、コンテナイアのユーザが所属する :ruby:`必要がある <MUST>` 追加グループ（名前または番号）を指定します。

.. An example of where this is useful is when multiple containers (running as different users) need to all read or write the same file on a shared volume. That file can be owned by a group shared by all the containers, and specified in group_add.

便利な例は、共有ボリューム上の同じファイルを（異なるユーザとして実行している）複数のコンテナから読み書きする場合です。対象のファイルを所有するのは、全てのコンテナ内で共通しているグループと、 ``group_add`` で指定されたグループです。

.. code-block:: yaml

   services:
     myservice:
       image: alpine
       group_add:
         - mail

.. Running id inside the created container MUST show that the user belongs to the mail group, which would not have been the case if group_add were not declared.

作成されたコンテナ内で ``id`` を実行すると、ユーザは ``mail`` グループとして :ruby:`表示されなければいけません <MUST>` 。 ``group_add`` で宣言されていない場合は、このようになりません。

.. healthcheck
.. _compose-spec-healthcheck:

healthcheck
--------------------

.. healthcheck declares a check that’s run to determine whether or not containers for this service are “healthy”. This overrides HEALTHCHECK Dockerfile instruction set by the service’s Docker image.

``healthcheck`` で定義するのは、このサービスが「 :ruby:`正常 <healthy>` 」かどうかを決めるために実行する調査についてです。これは、サービスの Docker イメージで設定する :ref:`HEALTHCHECK Dockerfile 命令 <builder-healthcheck>` を上書きします。

.. code-block:: yaml

   healthcheck:
     test: ["CMD", "curl", "-f", "http://localhost"]
     interval: 1m30s
     timeout: 10s
     retries: 3
     start_period: 40s

.. interval, timeout and start_period are specified as durations.

``interval` 、 ``timeout`` 、 ``start_period`` は :ref:`期間を指定 <compose-spec-specifying-durations>` します。

.. test defines the command the Compose implementation will run to check container health. It can be either a string or a list. If it’s a list, the first item must be either NONE, CMD or CMD-SHELL. If it’s a string, it’s equivalent to specifying CMD-SHELL followed by that string.

``test`` で定義するコマンドのは、 Compose 実装がコンテナが正常かどうかを確認するために実行するものです。コマンドは文字列もしくはリストです。リストの場合、1番目の項目は ``NONE`` 、 ``CMD`` 、 ``CMD-SHELL`` のどちらかである必要があります。文字列の場合は ``CMD-SHELL`` を指定したのと同じになり、以降に文字列が続きます。

.. code-block:: yaml

   # ローカルのウェブアプリをたたく
   test: ["CMD", "curl", "-f", "http://localhost"]

.. Using CMD-SHELL will run the command configured as a string using the container’s default shell (/bin/sh for Linux). Both forms below are equivalent:

``CMD-SHELL`` を使うと、コンテナのデフォルトシェル（ Linux の場合は ``/bin/sh`` ）を使い、文字をコマンドとして扱い実行します。以下はどちらも同じ処理内容です。

.. code-block:: yaml

   test: ["CMD-SHELL", "curl -f http://localhost || exit 1"]

.. code-block:: yaml

   test: curl -f https://localhost || exit 1

.. NONE disable the healthcheck, and is mostly useful to disable Healthcheck set by image. Alternatively the healthcheck set by the image can be disabled by setting disable: true:

``NONE`` はヘルスチェックを無効にします。多くの場合、イメージによって設定されているヘルスチェックの無効化に役立ちます。あるいは、 ``disable: true`` の設定によっても、イメージのヘルスチェックを無効化できます。

.. code-block:: yaml

   healthcheck:
     disable: true

.. hostname
.. _compose-spec-hostname:

hostname
----------

hostname declares a custom host name to use for the service container. MUST be a valid RFC 1123 hostname.

``hostname`` は、サービス用コンテナに対して任意のホスト名を宣言します。有効な RFC 1123 ホスト名の :ruby:`必要があります <MUST>` 。

.. image
.. _compose-spec-image:

image
---------

.. image specifies the image to start the container from. Image MUST follow the Open Container Specification addressable image format, as [<registry>/][<project>/]<image>[:<tag>|@<digest>].

``image`` は、コンテナの元になるイメージを指定します。イメージは :ruby:`オープンコンテナ仕様 <Open Container Specification>` の `アドレス可能なイメージ形式（addressable image format） <https://github.com/opencontainers/org/blob/master/docs/docs/introduction/digests.md>`_ に従う :ruby:`必要があります <MUST>` 。形式は ``[<registry>/][<project>/]<image>[:<tag>|@<digest>]`` です。

.. code-block:: yaml

       image: redis
       image: redis:5
       image: redis@sha256:0ed5d5928d4737458944eb604cc8509e245c3e19d02ad83935398bc4b991aac7
       image: library/redis
       image: docker.io/library/redis
       image: my_private.registry:5000/redis

.. If the image does not exist on the platform, Compose implementations MUST attempt to pull it based on the pull_policy. Compose implementations with build support MAY offer alternative options for the end user to control precedence of pull over building the image from source, however pulling the image MUST be the default behavior.

もしもイメージがプラットフォーム上に存在しなければ、 Compose 実装は ``pull_policy`` をもとに :ruby:`取得 <pull>` を :ruby:`試みなくてはいけません <MUST>` 。構築をサポートする Compose 実装は、エンドユーザに対し、ソースからイメージを構築する時、 :ruby:`手元に寄せる <pull over>` 優先順位を制御する代替オプションを :ruby:`提供してもよい <MAY>` ですが、イメージの取得はデフォルトの挙動になる :ruby:`必要があります <MUST>` 。

.. image MAY be omitted from a Compose file as long as a build section is declared. Compose implementations without build support MUST fail when image is missing from the Compose file.

Compose ファイルで ``build`` セクションを宣言する場合、 ``image`` は :ruby:`省略しても構いません <MAY>` 。構築をサポートしない Compose 実装の場合、 Compose ファイルに ``image`` がなければ失敗 :ruby:`しなければいけません <MUST>` 。

.. init
.. _compose-spec-init:

init
----------

.. init run an init process (PID 1) inside the container that forwards signals and reaps processes. Set this option to true to enable this feature for the service.

``init`` はコンテナ内で init プロセス（ PID 1 ）として実行するものです。これは（コンテナが受け取った）シグナルを転送し、プロセスとして処理できるようにします。サービスでこの機能を有効かするには、オプションで ``true`` に設定します。

.. code-block:: yaml

   services:
     web:
       image: alpine:latest
       init: true

.. The init binary that is used is platform specific.

この init バイナリは、プラットフォームが指定のものを使います。

.. ipc
.. _compose-spec-ipc:

ipc
----------

.. ipc configures the IPC isolation mode set by service container. Available values are platform specific, but Compose specification defines specific values which MUST be implemented as described if supported:

``ipc`` はサービス用コンテナによって設定される IPC isolation モードを設定します。利用できる値はプラットフォーム固有ですが、 Compose 仕様では、サポートする場合は以下どちらかの手段によって値を決めるよう定義しなければいけません。

..  shareable which gives the container own private IPC namespace, with a possibility to share it with other containers.
    service:{name} which makes the container join another (shareable) container’s IPC namespace.

* ``shareable`` はコンテナ自身のプライベート IPC 名前空間に与えますが、他のコンテナからも共有できる可能性があります。 ``service:{name}`` のコンテナには、他の（共有可能な）コンテナの IP 名前空間から接続できます。

.. code-block:: yaml

       ipc: "shareable"
       ipc: "service:[service name]"

.. isolation
.. _compose-spec-isolation:

isolation
----------

.. isolation specifies a container’s isolation technology. Supported values are platform-specific.

``isolation`` はコンテナの :ruby:`分離 <isolation>` 技術を指定します。サポートされる値は、プラットフォームに固有のものです。

.. labels
.. _compose-spec-labels:

labels
----------

.. labels add metadata to containers. You can use either an array or a map.

``labels`` はコンテナにメタデータを追加します。 :ruby:`配列形式 <array>` か :ruby:`マップ形式 <map>` を使えます。

.. It’s recommended that you use reverse-DNS notation to prevent your labels from conflicting with those used by other software.

使っているソフトウェアと他のソフトウェアの衝突を避けるため、逆引き DNS 記法の使用を推奨します。

.. code-block:: yaml

   labels:
     com.example.description: "Accounting webapp"
     com.example.department: "Finance"
     com.example.label-with-empty-value: ""

.. code-block:: yaml

   labels:
     - "com.example.description=Accounting webapp"
     - "com.example.department=Finance"
     - "com.example.label-with-empty-value"

.. Compose implementations MUST create containers with canonical labels:

Compose 実装は、作成するコンテナが、 :ruby:`基準となる <canonical>` ラベルを持つ :ruby:`必要があります <MUST>` 。

..  com.docker.compose.project set on all resources created by Compose implementation to the user project name
    com.docker.compose.service set on service containers with service name as defined in the Compose file

* ``com.docker.compose.project`` Compose 実装によって作成された全てのリソースを、 :ruby:`ユーザ プロジェクト名 <user project name>` に設定する。
* ``com.docker.compose.service`` サービス用コンテナを、 Compose ファイルで定義されたサービス名を使って設定する。

.. The com.docker.compose label prefix is reserved. Specifying labels with this prefix in the Compose file MUST result in a runtime error.

``com.docker.compose`` ラベルのプレフィクスは予約済みです。Compose ファイルにこのプレフィクスがあれば、結果ランタイムエラーとする :ruby:`必要があります <MUST>` 。

.. links
.. _compose-spec-links:

links
----------

.. links defines a network link to containers in another service. Either specify both the service name and a link alias (SERVICE:ALIAS), or just the service name.

``links`` は、他のサービス内にあるコンテナへのネットワーク :ruby:`接続 <link>` を定義します。サービス名と :ruby:`リンク別名 <link alias>` の両方を指定（ ``サービス:別名`` ）するか、サービス名のみ指定します。

.. code-block:: yaml

   web:
     links:
       - db
       - db:database
       - redis

.. Containers for the linked service MUST be reachable at a hostname identical to the alias, or the service name if no alias was specified.

リンクされたサービスのコンテナは、別名と同じホスト名で、あるいは別名の指定が無い場合はサービス名で到達可能に :ruby:`しなければいけません <MUST>` 。

.. Links are not required to enable services to communicate - when no specific network configuration is set, any service MUST be able to reach any other service at that service’s name on the default network. If services do declare networks they are attached to, links SHOULD NOT override the network configuration and services not attached to a shared network SHOULD NOT be able to communicate. Compose implementations MAY NOT warn the user about this configuration mismatch.

サービス間で通信できるようにするためには、 links は必須ではありません。たとえば、ネットワーク設定の指定が無くても、あらゆるサービスは、 ``default`` ネットワーク上では、サービス名を使って他のサービスに到達できるように :ruby:`しなければいけません <MUST>` 。サービスでも接続先ネットワークを定義する場合、 ``links`` でネットワーク設定を上書き :ruby:`すべきではなく <SHOULD NOT>` 、また、共有ネットワークに接続していないサービスは通信 :ruby:`できないようにすべきです <SHOULD NOT>` 。

.. Links also express implicit dependency between services in the same way as depends_on, so they determine the order of service startup.

また、 links は :ref:`depends_on <compose-spec-depends_on>` と同じように、サービス間での暗黙的な依存関係を表しますので、サービスの起動順番を決めます。


.. logging
.. _compose-spec-logging:

logging
----------

.. logging defines the logging configuration for the service.

``logging`` はサービスの :ruby:`ログ記録 <logging>` 設定を定義します。

.. code-block:: yaml

   logging:
     driver: syslog
     options:
       syslog-address: "tcp://192.168.0.42:123"

.. The driver name specifies a logging driver for the service’s containers. The default and available values are platform specific. Driver specific options can be set with options as key-value pairs.

``driver`` 名は、サービス用コンテナのログ記録ドライバを指定します。デフォルトかつ利用可能な値は、プラットフォーム固有です。ドライバ固有のオプションは、 ``options`` にキーバリューのペアで指定できます。

.. network_mode
.. _compose-spec-network_mode:

network_mode
--------------------

.. network_mode set service containers network mode. Available values are platform specific, but Compose specification define specific values which MUST be implemented as described if supported:

``network_mode`` は、サービス コンテナのネットワーク モードを設定します。利用可能な値はプラットフォーム固有ですが、サポートする場合、 Compose 仕様では以下のように値を実装 :ruby:`しなければいけません <MUST>` 。

..  none which disable all container networking
    host which gives the container raw access to host’s network interface
    service:{name} which gives the containers access to the specified service only

* ``none`` 全てのコンテナ ネットワーク機能を無効化
* ``host`` コンテナはホスト側のネットワーク インタフェースに直接アクセスできるようにする
* ``service:{名前}` コンテナを特定のサービスのみ接続できるようにする

.. code-block:: yaml

       network_mode: "host"
       network_mode: "none"
       network_mode: "service:[service name]"

.. networks
.. _compose-spec-networks:

networks
----------

.. networks defines the networks that service containers are attached to, referencing entries under the top-level networks key.

``networks`` はサービス コンテナを :ruby:`接続する <attached>` ネットワークを定義し、 :ref:`トップレベルの「networks」キー <networks-top-level-element>` 以下のエントリを参照します。

.. code-block:: yaml

   services:
     some-service:
       networks:
         - some-network
         - other-network

.. aliases
.. _compose-spec-aliases:

aliases
^^^^^^^^^^

.. aliases declares alternative hostnames for this service on the network. Other containers on the same network can use either the service name or this alias to connect to one of the service’s containers.

``aliases`` は、このサービスに対してサービス上で別のホスト名を宣言します。同じネットワーク上にある他のコンテナは、サービス名か、この :ruby:`別名 <aliases>` かのどちらかを使ってサービス用コンテナに接続できます。

.. Since aliases are network-scoped, the same service can have different aliases on different networks.

``aliases`` は :ruby:`ネットワーク内が範囲 <network-scoped>` です。そのため、異なるネットワーク上では、同じサービスに対して異なる別名を持たせられます。

..  Note: A network-wide alias can be shared by multiple containers, and even by multiple services. If it is, then exactly which container the name resolves to is not guaranteed.

.. note::

   :ruby:`ネットワーク外の別名 <network-wide alias>` であれば、複数のコンテナだけでなく、複数のサービスによっても共有できます。その場合（複数のサービスで共有される場合）、その別名がどのコンテナに名前解決されるかの保証はありません。

.. The general format is shown here:

一般的な形式は、以下の通りです：

.. code-block:: yaml

   services:
     some-service:
       networks:
         some-network:
           aliases:
             - alias1
             - alias3
         other-network:
           aliases:
             - alias2

.. In the example below, service frontend will be able to reach the backend service at the hostname backend or database on the back-tier network, and service monitoring will be able to reach same backend service at db or mysql on the admin network.

次の例では、サービス ``frontend`` は、 ``back-tier`` ネットワーク上にある、ホスト名 ``backend`` か ``database`` で ``backend`` サービスに対して到達可能です。また、サービス ``monitoring`` は、同じ ``admin`` ネットワーク上にある ``backend`` サービスに対して、 ``backend`` か ``mysql`` で到達可能です

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       networks:
         - front-tier
         - back-tier
   
     monitoring:
       image: awesome/monitoring
       networks:
         - admin
   
     backend:
       image: awesome/backend
       networks:
         back-tier:
           aliases:
             - database
         admin:
           aliases:
             - mysql
   
   networks:
     front-tier:
     back-tier:
     admin:

.. ipv4_address, ipv6_address
.. _compose-spec--ipv4_address-ipv6_address

ipv4_address 、 ipv6_address
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Specify a static IP address for containers for this service when joining the network.

このサービスがネットワークに接続する時、コンテナに対する固定 IP アドレスを指定します。

.. The corresponding network configuration in the top-level networks section MUST have an ipam block with subnet configurations covering each static address.

:ref:`トップレベルの networks セクション <compose-spec-networks>` 内にある ``ipam`` ブロックで、各固定アドレスを扱うサブネット設定が必要です。

.. code-block:: yaml

   services:
        frontend:
          image: awesome/webapp
          networks:
            front-tier:
              ipv4_address: 172.16.238.10
              ipv6_address: 2001:3984:3989::10
   
   networks:
     front-tier:
       ipam:
         driver: default
         config:
           - subnet: "172.16.238.0/24"
           - subnet: "2001:3984:3989::/64"

.. link_local_ips
.. _compose-spec-link_local_ips:

link_local_ips
^^^^^^^^^^^^^^^^^^^^

.. link_local_ips specifies a list of link-local IPs. Link-local IPs are special IPs which belong to a well known subnet and are purely managed by the operator, usually dependent on the architecture where they are deployed. Implementation is Platform specific.

``link_local_ips`` はリンクローカル IP アドレスのリストを指定します。リンクローカル IP アドレスとは、既知のサブネットに所属し、作業者によって純粋に管理される特別な IP アドレスで、通常はデプロイされるアーキテクチャに依存します。実装はプラットフォーム固有のものです。

.. Example:

例：

.. code-block:: yaml

   services:
     app:
       image: busybox
       command: top
       networks:
         app_net:
           link_local_ips:
             - 57.123.22.11
             - 57.123.22.13
   networks:
     app_net:
       driver: bridge

.. priority
.. _compose-spec-priority:

priority
^^^^^^^^^^

.. priority indicates in which order Compose implementation SHOULD connect the service’s containers to its networks. If unspecified, the default value is 0.

``priority`` は、 Compose 実装がサービス用コンテナをネットワークに接続 :ruby:`すべき <SHOULD>` 順番を示します。指定が無ければ、デフォルトの値は 0 です。

.. In the following example, the app service connects to app_net_1 first as it has the highest priority. It then connects to app_net_3, then app_net_2, which uses the default priority value of 0.

以下の例では、app サービスは第一に接続するのは、高い優先度を持つ ``app_net_1`` です。それから ``app_net_3`` に接続し、さらにデフォルト優先度の値 0 を使う ``app_net_2`` に接続します。

.. code-block:: yaml

   services:
     app:
       image: busybox
       command: top
       networks:
         app_net_1:
           priority: 1000
         app_net_2:
   
         app_net_3:
           priority: 100
   networks:
     app_net_1:
     app_net_2:
     app_net_3:

.. mac_address
.. _compose-spec-mac_address:

mac_address
--------------------

.. mac_address sets a MAC address for service container.

``mac_address`` はサービス コンテナに MAC アドレスを設定します。

.. mem_limit
.. _compose-spec-mem_limit

mem_limit
----------

.. DEPRECATED: use deploy.limits.memory
非推奨： :ref:`deploy.limits.memory <compose-spec-deploy-memory>` を使います。


.. mem_reservation
.. _compose-spec-mem_reservation

mem_reservation
--------------------

.. DEPRECATED: use deploy.reservations.memory
非推奨： :ref:`deploy.reservations.memory <compose-spec-deploy-memory>` を使います。

.. mem_swappiness
.. _compose-spec-mem_swappiness

mem_swappiness
--------------------

.. mem_swappiness defines as a percentage (a value between 0 and 100) for the host kernel to swap out anonymous memory pages used by a container.

``mem_swappiness`` は、ホスト kernel がコンテナで使用される :ruby:`無名メモリ <anonymous memory>` のスワップアウトを百分率（0～100の値）で定義します。

..   a value of 0 turns off anonymous page swapping.
    a value of 100 sets all anonymous pages as swappable.

* 0 の値は、無名メモリ ページ のスワップを無効にする
* 100 の値は、全ての無名メモリ ページをスワップ可能にする

.. Default value is platform specific.

デフォルトの値はプラットフォーム固有のものです。

.. memswap_limit
.. _compose-spec-memswap_limit:

memswap_limit
--------------------

.. memswap_limit defines the amount of memory container is allowed to swap to disk. This is a modifier attribute that only has meaning if memory is also set. Using swap allows the container to write excess memory requirements to disk when the container has exhausted all the memory that is available to it. There is a performance penalty for applications that swap memory to disk often.

``memswap_limit`` は、ディスクへのスワップを許可するコンテナのメモリ容量を定義します。これは ``memory`` も設定されている場合のみ変更可能な属性です。スワップを使うと、コンテナが利用可能な全てのメモリを使い尽くした時、コンテナは要求されない余分なメモリをディスクに書き込めます。ディスクに対するスワップメモリが頻発するアプリケーションは、パフォーマンスが低下します。

..  If memswap_limit is set to a positive integer, then both memory and memswap_limit MUST be set. memswap_limit represents the total amount of memory and swap that can be used, and memory controls the amount used by non-swap memory. So if memory=”300m” and memswap_limit=”1g”, the container can use 300m of memory and 700m (1g - 300m) swap.
    If memswap_limit is set to 0, the setting MUST be ignored, and the value is treated as unset.
    If memswap_limit is set to the same value as memory, and memory is set to a positive integer, the container does not have access to swap. See Prevent a container from using swap.
    If memswap_limit is unset, and memory is set, the container can use as much swap as the memory setting, if the host container has swap memory configured. For instance, if memory=”300m” and memswap_limit is not set, the container can use 600m in total of memory and swap.
    If memswap_limit is explicitly set to -1, the container is allowed to use unlimited swap, up to the amount available on the host system.

* ``memswap_limit`` に整数値を設定する場合、 ``memory`` と ``memswap_limit`` の両方を設定 :ruby:`しなくてはいけません。` 。 ``memswap_limit`` は利用可能な全メモリ容量とスワップを表し、 ``memory`` はスワップしないで使うメモリ容量を制御します。そのため、 ``memory`` が 300m と ``memswap_limit`` が 1g の場合、コンテナは 300m のメモリと 700m（1g - 300m）のスワップを利用できます。
* ```memswap_limit`  を 0 に設定する場合、設定は無視 :ruby:`しなければいけません` 。そして値は :ruby:`未定義 <unset>` として扱われます。
* ``memswap_limit`` を ``memory`` と同じ値に設定する場合かつ ``memory`` を整数値に設定する場合、コンテナはスワップにアクセスしません。 :ref:`コンテナがスワップをしないようにする` をご覧ください。
* ``memswap_limit`` が未定義で、かつ、 ``memory`` が設定されている場合、ホスト コンテナにスワップメモリが設定されていれば、コンテナは ``memory`` 設定と同じ容量のスワップを利用できます。たとえば、 ``memory`` が 300m で ``memswap_limit`` が設定されていなければ、コンテナはメモリとスワップで合計 600m 利用できます。
* ``memswap_limit`` を -1 に明示すると、ホストシステム上で利用可能な上限まで、コンテナが無制限にスワップを利用できます。

.. oom_kill_disable
.. _compose-spec-oom_kill_disable:

oom_kill_disable
--------------------

.. If oom_kill_disable is set Compose implementation MUST configure the platform so it won’t kill the container in case of memory starvation.

``oom_kill_disable`` を設定する場合、 Compose 実装は、メモリ不足が発生してもコンテナを :ruby:`強制停止 <kill>` しないよう、プラットフォームを調整する :ruby:`必要があります <MUST>` 。

.. oom_score_adj
.. _compose-spec-oom_score_adj:

oom_score_adj
--------------------

.. oom_score_adj tunes the preference for containers to be killed by platform in case of memory starvation. Value MUST be within [-1000,1000] range.

``oom_score_adj`` はメモリ不足が発生した場合、プラットフォームによって :ruby:`強制停止 <kill>` されるコンテナの優先度を調整します。値は [-1000,1000] の範囲内の :ruby:`必要があります <MUST>` 。

.. pid
.. _compose-spec-pid:

pid
----------

.. pid sets the PID mode for container created by the Compose implementation. Supported values are platform specific.

``pid`` は Compose 実装によって作成されるコンテナの PID モードを設定します。サポートされている値は、プラットフォーム固有のものです。

.. pids_limit
.. _compose-spec-pids_limit:

pids_limit
----------

.. DEPRECATED: use deploy.reservations.pids
非推奨： :ref:`deploy.reservations.pids <compose-spec-deploy-pids>` を使います。

.. pids_limit tunes a container’s PIDs limit. Set to -1 for unlimited PIDs.

``pids_limit`` はコンテナの PID の上限を調整します。-1 に設定すると、PID を無制限にします。

.. code-block:: yaml

   pids_limit: 10

.. platform
.. _compose-spec-platform:

platform
----------

.. platform defines the target platform containers for this service will run on, using the os[/arch[/variant]] syntax. Compose implementation MUST use this attribute when declared to determine which version of the image will be pulled and/or on which platform the service’s build will be performed.

``platform`` は、このサービスを実行するための :ruby:`対象プラットフォーム コンテナ <target platform containers>` を定義します。定義には ``os[/arch[/variant]]`` 構文を使います。Compose 実装は、どのバージョンのイメージを取得するかを決める場合や、どのプラットフォームでサービスの構築を実行するかを決める場合に、宣言時にこの属性を使う :ruby:`必要があります <MUST>` 。

.. code-block:: yaml

   platform: osx
   platform: windows/amd64
   platform: linux/arm64/v8

.. ports
.. _compose-spec-ports:

ports
----------

.. Exposes container ports. Port mapping MUST NOT be used with network_mode: host and doing so MUST result in a runtime error.

コンテナのポートを :ruby:`公開 <expose>` します。 ``network_mode: host`` を使う場合は、ポートマッピングを :ruby:`使ってはいけません <MUST>` 。また、使った結果にはランタイムエラーに :ruby:`しなければいけません <MUST>` 。

.. Short syntax
.. _compose-spec-ports-short-syntax:

短い形式
^^^^^^^^^^

.. The short syntax is a colon-separated string to set host IP, host port and container port in the form:

短い形式はコロン記号で区切られた文字列で、ホスト IP 、ホスト側ポート、コンテナ側ポートを ``[ホスト:]コンテナ[/プロトコル]`` の形式で設定します。

.. [HOST:]CONTAINER[/PROTOCOL] where:

..  HOST is [IP:](port | range)
    CONTAINER is port | range
    PROTOCOL to restrict port to specified protocol. tcp and udp values are defined by the specification, Compose implementations MAY offer support for platform-specific protocol names.

* ``ホスト`` は ``[IP:](ポート番号|範囲)``
* ``コンテナ`` は ``ポート番号|範囲``
* ``プロトコル`` は指定したプロトコルにポートを制限します。仕様では ``tcp`` と ``udp`` の値が定義されており、 Compose 実装ではプラットフォーム固有のプロトコル名をサポートする場合が :ruby:`あります <MAY>` 。

.. Host IP, if not set, MUST bind to all network interfaces. Port can be either a single value or a range. Host and container MUST use equivalent ranges.

ホスト IP の指定がなければ、全てのネットワークインタフェースを :ruby:`バインド <bind>` する必要があります。ポートには単一の値か範囲のどちらかを指定できます。ホストとコンテナでは、同じ範囲を使う :ruby:`必要があります <MUST>` 。

.. Either specify both ports (HOST:CONTAINER), or just the container port. In the latter case, the Compose implementation SHOULD automatically allocate any unassigned host port.

両方のポート（ ``ホスト:コンテナ`` ）を指定するか、コンテナのポートだけを指定するかのどちらかです。後者の場合、Compose 実装は自動的に未割り当てのホスト側ポートを割り当てる :ruby:`べきです <SHOULD>`。 ``ホスト:コンテナ`` の場合、 `yaml base-60 float <https://yaml.org/type/float.html>`_ との衝突を避けるため、常に（引用符で囲まれた）文字列で :ruby:`指定すべき <SHOULD>` です。

.. HOST:CONTAINER SHOULD always be specified as a (quoted) string, to avoid conflicts with yaml base-60 float.

.. Samples:

例：

.. code-block:: yaml

   ports:
     - "3000"
     - "3000-3005"
     - "8000:8000"
     - "9090-9091:8080-8081"
     - "49100:22"
     - "127.0.0.1:8001:8001"
     - "127.0.0.1:5000-5010:5000-5010"
     - "6060:6060/udp"

..  Note: Host IP mapping MAY not be supported on the platform, in such case Compose implementations SHOULD reject the Compose file and MUST inform the user they will ignore the specified host IP.

.. note::

   ホスト IP の :ruby:`割り当て <mapping>` は、プラットフォーム上ではサポート :ruby:`されない場合もあり <MAY NOT>` 、そのような場合に Compose 実装は Compose ファイルを拒否 :ruby:`すべきであり <SHOULD>` 、ユーザに対して指定したホスト IP を無視すると通知する :ruby:`必要があります <MUST>` 。

.. Long syntax
.. _compose-spec-ports-long-syntax:

長い形式
^^^^^^^^^^

.. The long form syntax allows the configuration of additional fields that can’t be expressed in the short form.

長い形式の構文は、短い形式では表現できない追加フィールドで調整をできるようにします。

..  target: the container port
    published: the publicly exposed port. Can be set as a range using syntax start-end, then actual port SHOULD be assigned within this range based on available ports.
    host_ip: the Host IP mapping, unspecified means all network interfaces (0.0.0.0)
    protocol: the port protocol (tcp or udp), unspecified means any protocol
    mode: host for publishing a host port on each node, or ingress for a port to be load balanced.

* ``target`` ：コンテナ側ポート
* ``published`` ：パブリックに :ruby:`公開される <exposed>` ポート。構文 ``start-end`` を使って範囲を指定できます。実際のポートは、この利用可能なポート範囲にもとづいて :ruby:`割り当てられるべきです <SHOULD>` 。
* ``host_ip`` ：ホスト IP を割り当て。未指定は全てのネットワークインタフェース（ ``0.0.0.0`` ）を意味する
* ``protocol`` ：ポートのプロトコル（ ``tcp`` か ``udp`` ）。未定義はあらゆるプロトコルを意味する
* ``mode`` ： ``host`` は各ノード上のホスト側ポートで公開。または、 ``ingress`` は負荷分散されたポートで公開。

.. code-block:: yaml

   ports:
     - target: 80
       host_ip: 127.0.0.1
       published: 8080
       protocol: tcp
       mode: host
   
     - target: 80
       host_ip: 127.0.0.1
       published: 8000-9000
       protocol: tcp
       mode: host

.. privileged
.. _compose-spec-privileged:

privileged
----------

.. privileged configures the service container to run with elevated privileges. Support and actual impacts are platform-specific.

``privileged`` 設定は、昇格した権限でサービスコンテナを実行します。サポートおよび実際の影響は、プラットフォーム固有です。

.. profiles
.. _compose-spec-profiles:

profiles
----------

.. profiles defines a list of named profiles for the service to be enabled under. When not set, service is always enabled.

``profiles`` は、サービスが有効な状態にするための、名前付き profile のリストを定義します。設定がなければ、サービスは常に有効です。

.. If present, profiles SHOULD follow the regex format of [a-zA-Z0-9][a-zA-Z0-9_.-]+.

存在する場合は、 ``profiles`` は正規表現の形式 ``[a-zA-Z0-9][a-zA-Z0-9_.-]+`` に :ruby:`従うべきです <SHOULD>` 。

.. pull_policy
.. _compose-spec-pull_policy:

pull_policy
--------------------

.. pull_policy defines the decisions Compose implementations will make when it starts to pull images. Possible values are:

``pull_policy`` は、 Compose 実装がイメージ取得を開始する時の挙動を定義します。有効な値は次の通りです。

..  always: Compose implementations SHOULD always pull the image from the registry.
    never: Compose implementations SHOULD NOT pull the image from a registry and SHOULD rely on the platform cached image. If there is no cached image, a failure MUST be reported.
    missing: Compose implementations SHOULD pull the image only if it’s not available in the platform cache. This SHOULD be the default option for Compose implementations without build support. if_not_present SHOULD be considered an alias for this value for backward compatibility
    build: Compose implementations SHOULD build the image. Compose implementations SHOULD rebuild the image if already present.

* ``always`` ：Compose 実装は、常にレジストリからイメージを :ruby:`取得すべき <SHOULD>` です。
* ``never`` ：Compose 実装は、常にレジストリからイメージを :ruby:`取得すべきではありません <SHOULD NOT>` 。そして、プラットフォームでキャッシュされたイメージに :ruby:`頼るべき <SHOULD>` です。もしもキャッシュされたイメージがなければ、失敗を報告する :ruby:`必要があります <MUST>` 。
* ``missing`` ：Compose 実装は、プラットフォームのキャッシュからイメージを利用できない場合のみ、取得 :ruby:`すべきです <SHOULD>` 。これは、構築をサポートしていない Compose 実装では、デフォルトのオプションと :ruby:`すべきです <SHOULD>` 。 ``if_not_present`` は、この値が後方互換性のための別名と :ruby:`考えるべきです <SHOULD>` 。
* ``build`` ：Compose 実装がイメージを :ruby:`構築 <build>` :ruby:`すべきです <SHOULD>` 。Compose 実装は、イメージが既に存在していても再構築 :ruby:`すべきです <SHOULD>` 。

.. If pull_policy and build both presents, Compose implementations SHOULD build the image by default. Compose implementations MAY override this behavior in the toolchain.

もしも ``pull_policy`` と ``build`` の両方がある場合、 Compose 実装はデフォルトでイメージを構築 :ruby:`すべきです <SHOULD>` 。Compose 実装は、ツールチェーンの中では、この挙動を :ruby:`上書きしても構いません <MAY>` 。

.. read_only
.. _compose-spec-read_only:

read_only
----------

.. read_only configures service container to be created with a read-only filesystem.
``read_only`` 設定は、読み込み専用のファイルシステムでサービス コンテナを作成します。

.. restart
.. _compose-sepc-restart:

restart
----------

.. restart defines the policy that the platform will apply on container termination.

``restart`` は、コンテナの終了時に、プラットフォームが適用するポリシーを定義します。

..  no: The default restart policy. Does not restart a container under any circumstances.
    always: The policy always restarts the container until its removal.
    on-failure: The policy restarts a container if the exit code indicates an error.
    unless-stopped: The policy restarts a container irrespective of the exit code but will stop restarting when the service is stopped or removed.

* ``no`` ：デフォルトの再起動ポリシーです。どのような状況下でも、コンテナを再起動しません。
* ``always`` ：コンテナを削除するまで、常に再起動するポリシーです。
* ``on-failure`` ：コンテナの終了コードがエラーを示す場合、コンテナを再起動するポリシーです。
* ``unless-stopped`` ：コンテナの終了コードにかかわらず再起動しますが、サービスが停止もしくは削除する場合は再起動処理を行いません。

.. code-block:: yaml

       restart: "no"
       restart: always
       restart: on-failure
       restart: unless-stopped

.. runtime
.. _compose-spec-runtime:

runtime
----------

.. runtime specifies which runtime to use for the service’s containers.

``runtime`` はサービス用コンテナに使うランタイムを指定します。

.. The value of runtime is specific to implementation. For example, runtime can be the name of an implementation of OCI Runtime Spec, such as “runc”.

``runtime`` の値は、実装を指定します。たとえば、 ``runtime`` の値には、 "runc"  のような `OCI ランタイム仕様（OCI Runtime Spec）を実装 <https://github.com/opencontainers/runtime-spec/blob/master/implementations.md>`_ する名前です。

.. code-block:: yaml

   web:
     image: busybox:latest
     command: true
     runtime: runc

.. scale
.. _compose-spec-scale:

scale
----------

.. DEPRECATED: use deploy/replicas
非推奨： :ref:`deploy/replicas <compose-spec-deploy-replicas>` を使います。

.. scale specifies the default number of containers to deploy for this service.

``scale`` は、このサービスをデプロイするデフォルトのコンテナ数を指定します。

.. secrets
.. _compose-spec-secrets:

secrets
----------

.. secrets grants access to sensitive data defined by secrets on a per-service basis. Two different syntax variants are supported: the short syntax and the long syntax.

``secrets`` は、サービス単位を元にする ref:`シークレット（secrets） <compose-spec-secrets>`_によって定義する機微データ（ :ruby:`センシティブ データ <sensitive data>` ）へのアクセスを許可します。短い形式と長い形式の、2つの異なる形式がサポートされています。

.. Compose implementations MUST report an error if the secret doesn’t exist on the platform or isn’t defined in the secrets section of this Compose file.

プラットフォーム上にシークレットが存在しない場合、あるいは、この Compose ファイルの ``secrets`` セクション内での定義がない場合、Compose 実装はエラーを報告する :ruby:`必要があります <MUST>` 。

.. Short syntax
.. _compose-spec-secrets-short-syntax:

短い形式
^^^^^^^^^^

.. The short syntax variant only specifies the secret name. This grants the container access to the secret and mounts it as read-only to /run/secrets/<secret_name> within the container. The source name and destination mountpoint are both set to the secret name.

短い形式の記述では、シークレット名のみ指定します。これは、コンテナに対してシークレットに対するアクセスを許可し、コンテナ内の ``/run/secrets/<シークレット名>`` を読み込み専用としてマウントします。ソース名とマウントポイント先は、どちらもシークレット名で設定されます。

.. The following example uses the short syntax to grant the frontend service access to the server-certificate secret. The value of server-certificate is set to the contents of the file ./server.cert.

以下の例は、短い構文を使い、 ``frontend`` サービスに対して ``server-certificate`` シークレットに対するアクセスを許可します。 ``server-certificate`` の値は ``./server.cert`` ファイルの内容を設定します。

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       secrets:
         - server-certificate
   secrets:
     server-certificate:
       file: ./server.cert

.. Long syntax
.. _compose-spec-secret-long-syntax:

長い形式
^^^^^^^^^^

.. The long syntax provides more granularity in how the secret is created within the service’s containers.

長い形式は、サービスコンテナ内で作成されるシークレットをどのように作成するか、より細かく指定します。

..  source: The name of the secret as it exists on the platform.
    target: The name of the file to be mounted in /run/secrets/ in the service’s task containers. Defaults to source if not specified.
    uid and gid: The numeric UID or GID that owns the file within /run/secrets/ in the service’s task containers. Default value is USER running container.
    mode: The permissions for the file to be mounted in /run/secrets/ in the service’s task containers, in octal notation. Default value is world-readable permissions (mode 0444). The writable bit MUST be ignored if set. The executable bit MAY be set.

* ``source`` ：プラットフォームに存在するシークレット名です。
* ``target`` ：サービス用タスク コンテナ内の、 ``/run/secrets/`` にマウントするファイル名です。
* ``uid`` と ``gid`` ：サービス用タスク コンテナ内の、 ``/run/secrets/`` 内のファイルを所有する UID や GID の整数値です。
* ``mode`` ： サービス用タスク コンテナ内の、``/run/secrets`` にマウントするファイルの `https://web.archive.org/web/20220310140126/http://permissions-calculator.org/ <パーミッション>`_ を8進数で指定します。もしも書き込み可能なビットが設定されても、無視する :ruby:`必要があります <MUST>` 。実行可能ビットは設定しても :ruby:`構いません <MAY>` 。

.. The following example sets the name of the server-certificate secret file to server.crt within the container, sets the mode to 0440 (group-readable) and sets the user and group to 103. The value of server-certificate secret is provided by the platform through a lookup and the secret lifecycle not directly managed by the Compose implementation.

以下の例は、コンテナ内の ``server.crt`` ファイルに ``server-sertificate`` という名前のシークレットを作成します。このファイルのモードを ``0440`` に設定し、ユーザとグループを ``103`` にします。シークレット ``server-certificate`` の値には、プラットフォームを通して検索したものが提供されますので、シークレットのライフサイクルは Compose 実装によって直接管理されません。

.. code-block:: yaml

   services:
     frontend:
       image: awesome/webapp
       secrets:
         - source: server-certificate
           target: server.cert
           uid: "103"
           gid: "103"
           mode: 0440
   secrets:
     server-certificate:
       external: true

.. Services MAY be granted access to multiple secrets. Long and short syntax for secrets MAY be used in the same Compose file. Defining a secret in the top-level secrets MUST NOT imply granting any service access to it. Such grant must be explicit within service specification as secrets service element.

サービスには複数のシークレットに対してアクセス権限を与えても :ruby:`構いません <MAY>` 。同じ Compose ファイル内で、短い形式と長い形式のシークレットを同時に使っても :ruby:`構いません <MAY>` 。シークレットをトップレベルの ``secret`` 内で定義し、あらゆるサービスに許可するように :ruby:`意図してはいけません <MUST NOT>` 。このような権限の許可は、 Compose 仕様内では :ref:`secrets <compose-spec-secrets>` サービス要素として明示する必要があります。

.. security_opt
.. _compose-spec-security_opt:

security_opt
--------------------

.. security_opt overrides the default labeling scheme for each container.

``security_opt`` は各コンテナのデフォルト :ruby:`ラベリング スキーマ <labeling scheme>` を上書きします。

.. code-block:: yaml

   security_opt:
     - label:user:USER
     - label:role:ROLE

.. shm_size
.. _compose-spec-shm_size

shm_size
----------

.. shm_size configures the size of the shared memory (/dev/shm partition on Linux) allowed by the service container. Specified as a byte value.

``shm_size`` は、サービス コンテナが利用できる共有メモリ（ Linux 上では ``/dev/shm`` パーティション）の容量を設定します。 :ref:`バイト値 <compose-spec-specifying-byte-values>` で指定します。

.. stdin_open
.. _comopse-spec-stdin_open:

stdin_open
----------

.. stdin_open configures service containers to run with an allocated stdin.

``stdin_open`` は、サービス コンテナに標準入力を割り当てて実行するよう設定します。

.. stop_grace_period
.. _compose-spec-stop_grace_period:

stop_grace_period
--------------------

.. stop_grace_period specifies how long the Compose implementation MUST wait when attempting to stop a container if it doesn’t handle SIGTERM (or whichever stop signal has been specified with stop_signal), before sending SIGKILL. Specified as a duration.

``stop_grace_period`` は、 Compose 実装がコンテナを停止しようとする時、 SIGTERM で処理できない場合（または、 ``stop_signal`` を停止シグナルとして指定していても）、 SIGKILL を送信する前にどれだけ待機する :ruby:`必要がある <MUST>` かを設定します。これは :ref:`期間 <compose-spec-specifying-durations>` で指定します。

.. code-block:: yaml

       stop_grace_period: 1s
       stop_grace_period: 1m30s

.. Default value is 10 seconds for the container to exit before sending SIGKILL.

コンテナに SIGKILL を送信して停止するまでは、デフォルトで 10 秒です。

.. stop_signal
.. _compose-spec-stop_signal:

stop_signal
--------------------

.. stop_signal defines the signal that the Compose implementation MUST use to stop the service containers. If unset containers are stopped by the Compose Implementation by sending SIGTERM.

``stop_signal`` はシグナルを定義します。これは Compose 実装がサービス コンテナを停止するために使う :ruby:`必要があります <MUST>` 。設定のないコンテナは、 Compose 実装によって ``SIGTERM`` の送信がサポートされます。

.. code-block:: yaml

   stop_signal: SIGUSR1

.. storage_opt
.. _compose-spec-storage_opt:

storage_opt
--------------------

.. storage_opt defines storage driver options for a service.

``storage_opt`` は、サービスに対してストレージ ドライバのオプションを定義します。

.. code-block:: yaml

   storage_opt:
     size: '1G'

.. sysctls
.. _compose-spec-sysctls:

sysctls
----------

.. sysctls defines kernel parameters to set in the container. sysctls can use either an array or a map.

``sysctls`` はコンテナ内に設定する kernel パラメータを定義します。 ``sysctls` は配列形式かマップ形式のどちらかを使えます。

.. code-block:: yaml

   sysctls:
     net.core.somaxconn: 1024
     net.ipv4.tcp_syncookies: 0

.. code-block:: yaml

   sysctls:
     - net.core.somaxconn=1024
     - net.ipv4.tcp_syncookies=0

.. You can only use sysctls that are namespaced in the kernel. Docker does not support changing sysctls inside a container that also modify the host system. For an overview of supported sysctls, refer to configure namespaced kernel parameters (sysctls) at runtime.

sysctls が使えるのは kernel 内の :ruby:`名前空間 <namespace>` のみです。Docker はホストシステム上も変更するコンテナ内の sysctls の変更をサポートしません。サポートしている sysctls については :ref:`configure-namespaced-kernel-parameters-at-runtime` を参照ください。


.. tmpfs
.. _compose-spec-tmpfs:

tmpfs
----------

.. tmpfs mounts a temporary file system inside the container. Can be a single value or a list.

``tmpfs`` はコンテナ内に一時的なファイルシステムをマウントします。単一の値、もしくはリスト形式です。

.. code-block:: yaml

   tmpfs: /run

.. code-block:: yaml

   tmpfs:
     - /run
     - /tmp

.. tty
.. _compose-spec-tty:

tty
----------

.. tty configure service container to run with a TTY.

``tty`` は、サービス コンテナに TTY を使って実行するよう設定します。

.. ulimits
.. _compose-spec-ulimits:

ulimits
----------

.. ulimits overrides the default ulimits for a container. Either specifies as a single limit as an integer or soft/hard limits as a mapping.

``ulimits`` はコンテナのデフォルト ulimits を上書きします。単一の :ruby:`制限 <limit>` を整数値で指定するか、マップ形式でソフト/ハード :ruby:`制限 <limit>` のどちらかを指定します。

.. code-block:: yaml

   ulimits:
     nproc: 65535
     nofile:
       soft: 20000
       hard: 40000

.. user
.. _compose-spec-user:

user
----------

.. user overrides the user used to run the container process. Default is that set by image (i.e. Dockerfile USER), if not set, root.

``user`` は、コンテナのプロセスを実行するために使うユーザを上書きします。デフォルトはイメージで指定されたもの（例： Dockerfile の ``USER`` ）が使われますが、設定が無ければ ``root`` です。

.. userns_mode
.. _compose-spec-userns_mode:

userns_mode
--------------------

.. userns_mode sets the user namespace for the service. Supported values are platform specific and MAY depend on platform configuration

``userns_mode`` はサービスに対するユーザ名前空間を設定します。サポートしている値はプラットフォーム固有であり、プラットフォームの設定に依存する :ruby:`場合があります <MAY>` 。

.. code-block:: yaml

   userns_mode: "host"

.. volumes
.. _compose-spec-volumes:

volumes
----------

.. volumes defines mount host paths or named volumes that MUST be accessible by service containers.

``volumes`` は、サービス コンテナがアクセスできるようにする :ruby:`必要がある <MUST>` 、 ホスト上のパスか :ruby:`名前付きボリューム <named volume>` を定義します。

.. If the mount is a host path and only used by a single service, it MAY be declared as part of the service definition instead of the top-level volumes key.

マウントがホスト上のパスで、かつ、単一の値の場合は、サービス定義の一部ではなくトップレベルの ``volume`` キーで宣言しても :ruby:`構いません <MAY>` 。

.. To reuse a volume across multiple services, a named volume MUST be declared in the top-level volumes key.

複数のコンテナを横断してボリュームを再利用するには、 :ref:`トップレベルの「volumes」キー <volumes-top-level-element>` 内で名前付きボリュームを宣言する :ruby:`必要があります <MUST>` 。

.. This example shows a named volume (db-data) being used by the backend service, and a bind mount defined for a single service

この例が表すのは、 ``backend`` サービスによって使われる名前付きボリューム（ ``db-data`` ）と、この1つのサービスに対する :ruby:`バインド マウント <bind mount>` を定義します。

.. code-block:: yaml

   services:
     backend:
       image: awesome/backend
       volumes:
         - type: volume
           source: db-data
           target: /data
           volume:
             nocopy: true
         - type: bind
           source: /var/run/postgres/postgres.sock
           target: /var/run/postgres/postgres.sock
   
   volumes:
     db-data:

.. Short syntax
.. _compose-spec-volumes-shorts-syntax:

短い形式
^^^^^^^^^^

.. The short syntax uses a single string with colon-separated values to specify a volume mount (VOLUME:CONTAINER_PATH), or an access mode (VOLUME:CONTAINER_PATH:ACCESS_MODE).

短い形式は、コロン区切りの値を持つ単一文字列を使い、ボリュームマウント（ ``VOLUME:CONTAINER_PASS`` ）や、アクセスモード（VOLUME:CONTAINER_PATH:ACCESS_MODE） を指定します。

..  VOLUME: MAY be either a host path on the platform hosting containers (bind mount) or a volume name
    CONTAINER_PATH: the path in the container where the volume is mounted
    ACCESS_MODE: is a comma-separated , list of options and MAY be set to:
        rw: read and write access (default)
        ro: read-only access
        z: SELinux option indicates that the bind mount host content is shared among multiple containers
        Z: SELinux option indicates that the bind mount host content is private and unshared for other containers

* ``VOLUME`` ：コンテナをホスティングするプラットフォーム上のホストパス（バインド マウント）かボリューム名のどちらかを :ruby:`指定できます <MAY>`
* ``CONTAINER_PATH`` ：ボリュームがマウントされるコンテナ内のパス
* ``ACCESS_MODE`` ：これはコンマ記号 ``,`` で区切られたリストで、次の値が :ruby:`設定できます <MAY>` ：

   * `rw``` ： :ruby:`読み込み <read>` と :ruby:`書き込み <write>` のアクセス（デフォルト）
   * ``ro`` ： :ruby:`読み込み専用 <read-only>` のアクセス
   * ``z`` ：SELinux オプションを示すもので、バインド マウントするホストの内容が、複数のコンテナ間で共有する
   * ``Z`` ：SELinux オプションを示すもので、バインド マウントするホストの内容がプライベートであり、他のコンテナとは共有しない

..    Note: The SELinux re-labeling bind mount option is ignored on platforms without SELinux.

.. note::

   SELinux の :ruby:`再ラベル <re-labeling>` バインド マウント オプションは、SELinux の無いプラットフォームでは無視されます。

..    Note: Relative host paths MUST only be supported by Compose implementations that deploy to a local container runtime. This is because the relative path is resolved from the Compose file’s parent directory which is only applicable in the local case. Compose Implementations deploying to a non-local platform MUST reject Compose files which use relative host paths with an error. To avoid ambiguities with named volumes, relative paths SHOULD always begin with . or ...

.. note::

   相対ホスト パスが Compose 実装によってサポートする :ruby:`必要がある <MUST>` のは、ローカルのコンテナランタイムにデプロイする場合のみです。これは、相対パスとみなすのは Compose ファイルの親ディレクトリのためであり、ローカルでの実行時にのみ適用されるからです。 Compose 実装によるローカル以外へのデプロイでは、 Compose が相対ホストパスを扱えないため、エラーを出して拒否する :ruby:`必要があります <MUST>` 。この曖昧さを名前付きボリュームで防止するには、相対パスの指定を常に ``.`` や ``..`` で :ruby:`指定すべき <SHOULD>` です。

.. Long syntax
.. _compose-spec-volumes-long-syntax:

長い形式
^^^^^^^^^^

.. The long form syntax allows the configuration of additional fields that can’t be expressed in the short form.

長い形式の構文は、短い形式では表現できない追加フィールドの設定を行えるようにします。

..  type: the mount type volume, bind, tmpfs or npipe
    source: the source of the mount, a path on the host for a bind mount, or the name of a volume defined in the top-level volumes key. Not applicable for a tmpfs mount.
    target: the path in the container where the volume is mounted
    read_only: flag to set the volume as read-only
    bind: configure additional bind options
        propagation: the propagation mode used for the bind
        create_host_path: create a directory at the source path on host if there is nothing present. Do nothing if there is something present at the path. This is automatically implied by short syntax for backward compatibility with docker-compose legacy.
        selinux: the SELinux re-labeling option z (shared) or Z (private)
    volume: configure additional volume options
        nocopy: flag to disable copying of data from a container when a volume is created
    tmpfs: configure additional tmpfs options
        size: the size for the tmpfs mount in bytes (either numeric or as bytes unit)
    consistency: the consistency requirements of the mount. Available values are platform specific

* ``type`` ：マウントの :ruby:`型 <type>` で ``volume`` 、 ``bind`` 、 ``tmpfs`` 、 ``npine`` です。
* ``source`` ：マウント元で、バインドマウントするホスト上のパスか、 :ref:`トップレベル「volumes」キー <compose-spec-volumes-top-level-element>` で定義されるボリュームの名前です。
* ``target`` ：ボリュームがマウントされるコンテナ内のパスです。
* ``read_only`` ：ボリュームを読み込み専用に設定するフラグです。
* ``bind`` ：追加のバインド オプションを設定します。

   * ``propagation`` ：バインドに :ruby:`伝搬モード <propagation mode>` を使います。
   * ``create_host_path`` ：何も指定がなければ、ホスト上のソースパスにディレクトリを作成します。パス上に同様のパスが存在している場合は、何もしません。これは、過去の docker-compose との後方互換正のため、短い構文では自動的に処理されます。
   * ``selinux`` ： SELinux の :ruby:`再ラベル <re-labeing>` オプション ``z`` （共有）か ``Z`` （プライベート）を指定します。

* ``volume`` ：追加のボリューム オプションを設定します。

   * ``nocopy`` ：ボリュームを作成する場合、コンテナからのデータのコピーを無効化するフラグです。

* ``tmpfs`` ：追加の tmpfs オプションを指定します。

   * ``size`` ：tmpfs マウント用の容量をバイトで（整数値またはバイト単位として）指定します。

* ``consistency`` ：マウントには :ruby:`一貫性 <onsistency>` を必要とします。利用可能な値は、プラットフォームに固有のものです。

.. volumes_from
.. _compose-sepc-volumes-from:

volumes_from
--------------------

.. volumes_from mounts all of the volumes from another service or container, optionally specifying read-only access (ro) or read-write (rw). If no access level is specified, then read-write MUST be used.

``volumes_from`` は、他のサービスやコンテナから全てのボリュームをマウントします。オプションで読み込み専用のアクセス（ro）や読み書き（rw）を指定します。アクセスレベルの指定が無ければ、読み書きを使う :ruby:`必要があります <MUST>` 。

.. String value defines another service in the Compose application model to mount volumes from. The container: prefix, if supported, allows to mount volumes from a container that is not managed by the Compose implementation.

文字列の値には、 Compose アプリケーション モデル内にある別のサービスを定義します。 ``container:`` プレフィクスをサポートする場合、コンテナからのボリュームをマウントできるようにしますが、  Compose 実装によっては管理されません。

.. code-block:: yaml

   volumes_from:
     - service_name
     - service_name:ro
     - container:container_name
     - container:container_name:rw

.. working_dir
.. _compose-spec-working-dir:

working_dir
--------------------

.. working_dir overrides the container’s working directory from that specified by image (i.e. Dockerfile WORKDIR).

``working_dir`` は、イメージで定義（例： Dockerfile の ``WORKDIR`` ）されたコンテナ用の :ruby:`作業ディレクトリ <working directory>` を上書きします。

.. Networks top-level element
.. _networks-top-level-element:

``networks`` トップレベル :ruby:`要素 <element>`
============================================================

.. Networks are the layer that allow services to communicate with each other. The networking model exposed to a service is limited to a simple IP connection with target services and external resources, while the Network definition allows fine-tuning the actual implementation provided by the platform.

networks （ネットワーク）はサービスが相互に通信できるようにするためのレイヤです。サービスに対して公開するネットワーク機能モデルとは、対象サービスと外部リソース間でのシンプルな IP 接続に限定されます。ただし、ネットワーク定義により、プラットフォームが提供する実際の実装を微調整できます。

.. Networks can be created by specifying the network name under a top-level networks section. Services can connect to networks by specifying the network name under the service networks subsection

トップレベルの ``networks`` セクション下でネットワーク名を定義すると、ネットワークが作成されます。サービスの ``networks`` サブセクションで指定されたネットワークにも、サービスは接続できます。

.. In the following example, at runtime, networks front-tier and back-tier will be created and the frontend service connected to the front-tier network and the back-tier network.

以下の例では、実行時にネットワーク ``front-tier`` と ``back-tier`` が作成され、それから ``forntend`` サービスは ``front-tier`` ネットワークと ``back-tier`` ネットワークに接続します。

.. code-block:: bash

   services:
        frontend:
          image: awesome/webapp
          networks:
            - front-tier
            - back-tier
      
      networks:
        front-tier:
        back-tier:

.. driver
.. _compose-spec-networks-driver:

driver
----------

.. driver specifies which driver should be used for this network. Compose implementations MUST return an error if the driver is not available on the platform.

``driver`` は、このネットワークに使うべきドライバを指定します。 Compose 実装はプラットフォーム上でドライバが利用できなければ、エラーを返す :ruby:`必要があります <MUST>` 。

.. code-block:: yaml

   driver: overlay

.. Default and available values are platform specific. Compose specification MUST support the following specific drivers: none and host

デフォルトかつ利用可能なボリュームは、プラットフォーム固有です。 Compose 仕様は、以下のドライバ ``none`` と ``host`` を指定するようにサポートする :ruby:`必要があります <MUST>` 。

..  host use the host’s networking stack
    none disable networking

* ``host`` はホスト側のネットワーク スタックを使用
* ``none`` はネットワーク無効化

.. host or none
.. _compose-spec-networks-host-none:

``host`` や ``none``
^^^^^^^^^^^^^^^^^^^^

.. The syntax for using built-in networks such as host and none is different, as such networks implicitly exists outside the scope of the Compose implementation. To use them one MUST define an external network with the name host or none and an alias that the Compose implementation can use (hostnet or nonet in the following examples), then grant the service access to that network using its alias.

``host`` と ``none`` では、内蔵ネットワークを扱う構文は異なります。これらネットワークは、暗黙的に Compose 実装の範囲外となるためです。これらのうち1つを使う場合、 ``host`` か ``name`` で外部ネットワークと :ruby:`別名 <alias>` を定義する :ruby:`必要があり <MUST>` 、Compose 実装は使用する :ruby:`別名 <alias>` を定義し、サービスはネットワークに対して :ruby:`別名 <alias>` を使って接続を許可するようにします。

.. code-block:: yaml

   services:
     web:
       networks:
         hostnet: {}
   
   networks:
     hostnet:
       external: true
       name: host

.. code-block:: yaml

   services:
     web:
       ...
       networks:
         nonet: {}
   
   networks:
     nonet:
       external: true
       name: none

.. driver_opts
.. _compose-sepc-networks-driver_opts

driver_opts
--------------------

.. driver_opts specifies a list of options as key-value pairs to pass to the driver for this network. These options are driver-dependent - consult the driver’s documentation for more information. Optional.

``driver_opts`` は、このネットワーク用ドライバに渡すオプションのリストを、キーバリューの組み合わせで定義します。このオプションはドリア場に依存します。そのため、詳細情報はドライバのドキュメントをご確認ください。これはオプションの項目です。

.. code-block:: yaml

   driver_opts:
     foo: "bar"
     baz: 1

.. attachable
.. _compose-spec-networks-attachable:

attachable
----------

.. If attachable is set to true, then standalone containers SHOULD be able attach to this network, in addition to services. If a standalone container attaches to the network, it can communicate with services and other standalone containers that are also attached to the network.

``attachable`` を ``true`` に設定すると、スタンドアロン コンテナはサービスに加え、このネットワークに :ruby:`接続 <attach>` できるように :ruby:`すべきです <SHOULD>` 。スタンドアロン コンテナがネットワークへ接続する時に、そのネットワークに接続している他のサービスやスタンドアロン コンテナとも通信できます。

.. code-block:: bash

   networks:
     mynet1:
       driver: overlay
       attachable: true

.. enable_ipv6
.. _compose-spec-networks-enable_ipv6:

enable_ipv6
--------------------

.. enable_ipv6 enable IPv6 networking on this network.

``enable_ipv6`` は、このネットワーク上で IPv6 ネットワーク機能を有効化します。

.. ipam
.. _compose-spec-networks-ipam:

ipam
----------

.. ipam specifies custom a IPAM configuration. This is an object with several properties, each of which is optional:

``ipam`` は任意の IPAM 設定を指定します。これには複数の属性を持つオブジェクトがありますが、どれもオプションです。

..  driver: Custom IPAM driver, instead of the default.
    config: A list with zero or more configuration elements, each containing:
        subnet: Subnet in CIDR format that represents a network segment
        ip_range: Range of IPs from which to allocate container IPs
        gateway: IPv4 or IPv6 gateway for the master subnet
        aux_addresses: Auxiliary IPv4 or IPv6 addresses used by Network driver, as a mapping from hostname to IP
    options: Driver-specific options as a key-value mapping.


* ``driver`` ：デフォルトに替わる、任意の IPAM ドライバです。
* ``config`` ：ゼロ、もしくは、次の内容を含む複数の設定要素のリストです。

   * ``subnet`` ：ネットワークセグメントを表す CIDR 形式のサブネット
   * ``ip_range`` ：コンテナに割り当て可能な IP アドレスの範囲
   * ``gateway`` ：マスタサブネットのための IPv4 または IPv6 ゲートウエイ
   * ``aux_addresses`` ：ネットワーク ドライバによって使われる外部の IPv4 または IPv6 アドレスで、ホスト名から IP アドレスにマッピングする

* ``options`` ：ドライバ固有のオプションをキーバリューのマップとして指定

.. A full example:

完全な例です：

.. code-block:: yaml

   ipam:
     driver: default
     config:
       - subnet: 172.28.0.0/16
         ip_range: 172.28.5.0/24
         gateway: 172.28.5.254
         aux_addresses:
           host1: 172.28.1.5
           host2: 172.28.1.6
           host3: 172.28.1.7
     options:
       foo: bar
       baz: "0"

.. internal
.. _compose-spec-netowrks-internal:

internal
----------

.. By default, Compose implementations MUST provides external connectivity to networks. internal when set to true allow to create an externally isolated network.

デフォルトでは、 Compose 仕様はネットワークに対する外部への接続性を提供する :ruby:`必要があります <MUST>` 。 ``internal`` を ``true``に設定する場合は、外部の :ruby:`分離された <isolated>` ネットワークを作成できるようになります。

.. labels
.. _compose-spec-networks-labels:

labels
----------

.. Add metadata to containers using Labels. Can use either an array or a dictionary.

ラベルを使ってコンテナにメタデータを追加します。配列形式もしくは辞書形式のどちらかを利用できます。

.. Users SHOULD use reverse-DNS notation to prevent labels from conflicting with those used by other software.

他のソフトウェアが使っているラベルとの重複を防ぐため、ユーザは逆引き DNS 記法を :ruby:`使うべきです <SHOULD>` 。

.. code-block:: yaml

   labels:
     com.example.description: "Financial transaction network"
     com.example.department: "Finance"
     com.example.label-with-empty-value: ""

.. code-block:: yaml

   labels:
     - "com.example.description=Financial transaction network"
     - "com.example.department=Finance"
     - "com.example.label-with-empty-value"

.. Compose implementations MUST set com.docker.compose.project and com.docker.compose.network labels.

Compose 実装はラベル ``com.docker.compose.project`` と ``com.docker.compose.network`` を指定する :ruby:`必要があります <MUST>` 。

.. external
.. _compose-spec-networks-external:

external
----------

.. If set to true, external specifies that this network’s lifecycle is maintained outside of that of the application. Compose Implementations SHOULD NOT attempt to create these networks, and raises an error if one doesn’t exist.

``external`` を ``true`` に設定した場合、このネットワークのライフサイクルは、対象アプリケーションの外で管理されます。Compose 実装はこれらネットワークを作成しようと :ruby:`すべきではなく <SHOULD NOT>` 、存在しなければエラーを返します。

.. In the example below, proxy is the gateway to the outside world. Instead of attempting to create a network, Compose implementations SHOULD interrogate the platform for an existing network simply called outside and connect the proxy service’s containers to it.

以下の例では、 ``proxy`` は外の世界へのゲートウェイです。ネットワークの作成を試みるのではなく、 Compose 実装はプラットフォームに対して ``outside`` という名前で既存ネットワークに存在しているかどうかを単純に尋ね、 ``proxy`` サービスのコンテナがそこに接続できるようにします。

.. code-block:: yaml

   services:
        proxy:
          image: awesome/proxy
          networks:
            - outside
            - default
        app:
          image: awesome/app
          networks:
            - default
      
      networks:
        outside:
          external: true

.. name
.. _compose-spec-networks-name:

name
----------

.. name sets a custom name for this network. The name field can be used to reference networks which contain special characters. The name is used as is and will not be scoped with the project name.

``name`` は、このネットワークに対して任意の名前を設定します。name フィールドは、特別な文字を含むネットワークの参照にも使えます。この名前はそのまま使われるだけであり、プロジェクト名の範囲では使われ **ません** 。

.. code-block:: yaml

   networks:
     network1:
       name: my-app-net

.. It can also be used in conjunction with the external property to define the platform network that the Compose implementation should retrieve, typically by using a parameter so the Compose file doesn’t need to hard-code runtime specific values:

プラットフォームのネットワークを定義するため、 ``external`` 属性と組み合わせての利用も可能です。これは、 Compose 実装では、 Compose がランタイム固有の値を :ruby:`ハードコード <hard-code>` する必要がないようにするため、通常はパラメータを使って取得すべきです。

.. code-block:: yaml

   networks:
     network1:
       external: true
       name: "${NETWORK_ID}"

.. Volumes top-level element
.. _volumes-top-level-element:

``volumes`` トップレベル :ruby:`要素 <element>`
==================================================

.. Volumes are persistent data stores implemented by the platform. The Compose specification offers a neutral abstraction for services to mount volumes, and configuration parameters to allocate them on infrastructure.

ボリューム（ ``volumes`` ）とはプラットフォームによって実装される :ruby:`持続的データストア <persistent data store>` です。Compose 仕様では、サービスがボリュームをマウントするための中立的な中立化と、それらを :ruby:`基盤上 <infrastructure>` に割り当てるための設定パラメータを提供します。

.. The volumes section allows the configuration of named volumes that can be reused across multiple services. Here’s an example of a two-service setup where a database’s data directory is shared with another service as a volume named db-data so that it can be periodically backed up:

``voluems`` セクションは、複数のサービスを横断して再利用できる :ruby:`名前付きボリューム <named volume>` の設定ができます。こちらは2つのサービスをセットアップする例で、データベースのデータディレクトリは ``db-data`` という名前のボリュームとして他のサービスから共有されます。そのため、バックアップ用途にも使えるでしょう。

.. code-block:: yaml

   services:
     backend:
       image: awesome/database
       volumes:
         - db-data:/etc/data
   
     backup:
       image: backup-service
       volumes:
         - db-data:/var/lib/backup/data
   
   volumes:
     db-data:

.. An entry under the top-level volumes key can be empty, in which case it uses the platform’s default configuration for creating a volume. Optionally, you can configure it with the following keys:

トップレベルの ``volumes`` キー以下のエントリは空っぽにできます。ボリュームの作成にあたり、プラットフォームのデフォルト設定を使う場合に、そのようにします。オプションで、以下のキーを使って設定できます。

.. driver
.. _compose-spec-volumes-driver:

driver
----------

.. Specify which volume driver should be used for this volume. Default and available values are platform specific. If the driver is not available, the Compose implementation MUST return an error and stop application deployment.

このボリュームが使うべきボリュームドライバを指定します。デフォルトの値や利用可能な値は、プラットフォーム固有です。ドライバが利用できない場合は、 Compose 実装はエラーを返してアプリケーションのデプロイを中止する :ruby:`必要があります <MUST>` 。

.. code-block:: yaml

   driver: foobar

.. driver_opts
.. _compose-spec-volumes-driver_opts

driver_opts
--------------------

.. driver_opts specifies a list of options as key-value pairs to pass to the driver for this volume. Those options are driver-dependent.

``driver_opts`` は、このボリュームのドライバに渡すオプションのリストを、キーバリューの組み合わせで指定します。それぞれのオプションは、ドライバに依存します。

.. code-block:: yaml

   volumes:
     example:
       driver_opts:
         type: "nfs"
         o: "addr=10.40.0.199,nolock,soft,rw"
         device: ":/docker/example"

.. external
.. _compose-spec-volumes-external

external
----------

.. If set to true, external specifies that this volume already exist on the platform and its lifecycle is managed outside of that of the application. Compose implementations MUST NOT attempt to create these volumes, and MUST return an error if they do not exist.

``external`` を ``true`` に設定した場合、このボリュームのライフサイクルは、対象アプリケーションの外で管理されます。Compose 実装はこれらボリュームを作成 :ruby:`しようとしてはいけません <MUST NOT>` 。また、存在しなければエラーを返す :ruby:`必要があります <MUST>` 。

.. In the example below, instead of attempting to create a volume called {project_name}_db-data, Compose looks for an existing volume simply called db-data and mounts it into the backend service’s containers.

以下の例では、 ``{project_name}_db-data`` という名前のボリューム作成を試みるのではなく、 Compose はシンプルに ``db-data`` という名前の既存ボリュームを探し、それを ``backend`` サービスのコンテナにマウントします。

.. code-block:: yaml

   services:
     backend:
       image: awesome/database
       volumes:
         - db-data:/etc/data
   
   volumes:
     db-data:
       external: true

.. labels
.. _compose-spec-volumes-labels:

labels
----------

.. labels are used to add metadata to volumes. You can use either an array or a dictionary.

ラベルはボリュームにメタデータを追加するために使います。配列形式もしくは辞書形式のどちらかを利用できます。

.. It’s recommended that you use reverse-DNS notation to prevent your labels from conflicting with those used by other software.

他のソフトウェアが使っているラベルとの重複を防ぐため、ユーザは逆引き DNS 記法を :ruby:`使うべきです <SHOULD>` 。

.. code-block:: yaml

   labels:
     com.example.description: "Database volume"
     com.example.department: "IT/Ops"
     com.example.label-with-empty-value: ""

.. code-block:: yaml

   labels:
     - "com.example.description=Database volume"
     - "com.example.department=IT/Ops"
     - "com.example.label-with-empty-value"

.. Compose implementation MUST set com.docker.compose.project and com.docker.compose.volume labels.

Compose 実装はラベル ``com.docker.compose.project`` と ``com.docker.compose.network`` を指定する :ruby:`必要があります <MUST>` 。

.. name
.. _compose-spec-volumes-name:

name
----------

.. name set a custom name for this volume. The name field can be used to reference volumes that contain special characters. The name is used as is and will not be scoped with the stack name.

``name`` は、このボリュームに対して任意の名前を設定します。name フィールドは、特別な文字を含むボリュームの参照にも使えます。この名前はそのまま使われるだけであり、スタック名の範囲では使われ **ません ** 。

.. code-block:: yaml

   volumes:
     data:
       name: "my-app-data"

.. It can also be used in conjunction with the external property. Doing so the name of the volume used to lookup for actual volume on platform is set separately from the name used to refer to it within the Compose file:

``external`` 属性と組み合わせての利用も可能です。この場合、プラットフォーム上で実際のボリュームを探すためのボリューム名は、Compose ファイル内で参照するための名前とは別に設定されます。

.. code-block:: yaml

   volumes:
     db-data:
       external:
         name: actual-name-of-volume

.. This make it possible to make this lookup name a parameter of a Compose file, so that the model ID for volume is hard-coded but the actual volume ID on platform is set at runtime during deployment:

次のようにすると、 Compose ファイルのパラメータで名前を探せるようになるため、ボリューム用のモデル ID を :ruby:`ハードコード <hard-code>` する必要がなくなり、デプロイを処理する間に、プラットフォーム上での実際のボリューム ID が設定されます。

.. code-block:: yaml

   volumes:
     db-data:
       external:
         name: ${DATABASE_VOLUME}

.. Configs top-level element
.. _configs-top-level-element:

``configs`` ドップレベル :ruby:`要素 <element>` 
==================================================

.. Configs allow services to adapt their behaviour without the need to rebuild a Docker image. Configs are comparable to Volumes from a service point of view as they are mounted into service’s containers filesystem. The actual implementation detail to get configuration provided by the platform can be set from the Configuration definition.

設定情報（ ``configs`` ）によって、 サービスに対して挙動を適用するにあたり、Docker イメージの再構築を不要にします。 configs はサービス用コンテナのファイルシステムへマウントされるため、サービスの観点からはボリュームに相当します。プラットフォームから取得する実際の実装詳細は、この設定情報の定義で設定できます。

.. When granted access to a config, the config content is mounted as a file in the container. The location of the mount point within the container defaults to /<config-name> in Linux containers and C:\<config-name> in Windows containers.

設定情報にアクセスを許可すると、設定情報の内容が、コンテナ内ではファイルとしてマウントされます。コンテナ内のマウントポイントの場所は、 Linux コンテナでのデフォルトは ``</config-name>``  であり、 Windows コンテナーの場合は ``C:\<config-name>`` です。

.. By default, the config MUST be owned by the user running the container command but can be overridden by service configuration. By default, the config MUST have world-readable permissions (mode 0444), unless service is configured to override this.

デフォルトでは、設定情報はコンテナのコマンドを実行するユーザによって所有される :ruby:`必要があり <MUST>` が、サービス設定では上書きできません。デフォルトの設定情報は、サービスが設定を上書きしない限り、誰もが読み込みできるパーミッション（モード 0444） を持ちます。

.. Services can only access configs when explicitly granted by a configs subsection.

``configs`` のサブセクションで、サービスがアクセスできる設定情報を明示的に許可できます。

.. The top-level configs declaration defines or references configuration data that can be granted to the services in this application. The source of the config is either file or external.

トップレベルの ``configs`` 宣言による定義や参照される設定情報データは、このアプリケーションの（他の）サービス上からも参照できるようになります。設定情報の元になるのは ``file`` か ``external`` です。

..  file: The config is created with the contents of the file at the specified path.
    external: If set to true, specifies that this config has already been created. Compose implementation does not attempt to create it, and if it does not exist, an error occurs.
    name: The name of config object on Platform to lookup. This field can be used to reference configs that contain special characters. The name is used as is and will not be scoped with the project name.

* ``file`` ：指定されたパスにあるファイルの内容から、設定情報を作成します。
* ``external`` ：設定情報が既に作成されている場合、設定を true にして指定します。Compose 実装は作成を試みません。また、存在しなければエラーを起こします。
* ``name`` ：プラットフォームで探す設定情報の名前です。このフィールドは特別な文字を含む設定情報も参照できます。名前はそのまま使いますが、プロジェクト名の範囲外では使われ **ません** 。

.. In this example, http_config is created (as <project_name>_http_config) when the application is deployed, and my_second_config MUST already exist on Platform and value will be obtained by lookup.

この例では、アプリケーションのデプロイ時に  ``http_config`` が  ``<project_name>_http_config`` として作成されます。そして ``my_second_config`` は既存のプラットフォーム上に存在し、その値を探して得られる :ruby:`必要があります <MUST>` 。

.. In this example, server-http_config is created as <project_name>_http_config when the application is deployed, by registering content of the httpd.conf as configuration data.

この例では、アプリケーションのデプロイ時に  ``server-http_config`` が（ ``<project_name>_http_config`` として）作成されます。このとき、 ``httpd.conf`` の内容は設定情報のデータ内容が登録されます。

.. code-block:: yaml

   configs:
     http_config:
       file: ./httpd.conf

.. Alternatively, http_config can be declared as external, doing so Compose implementation will lookup http_config to expose configuration data to relevant services.

あるいは、 ``httpd_config`` は外部（external）としての宣言もできます。そのような場合、 Compose 実装は対象サービスで公開されている設定情報データから ``http_config`` を探します。

.. code-block:: yaml

   configs:
     http_config:
       external: true

.. External configs lookup can also use a distinct key by specifying a name. The following example modifies the previous one to lookup for config using a parameter HTTP_CONFIG_KEY. Doing so the actual lookup key will be set at deployment time by interpolation of variables, but exposed to containers as hard-coded ID http_config.

外部設定を探すにあたり、明確にキーを ``name`` で指定しての利用もできます。以下の例は先の例を編集したもので、パラメータ ``HTTP_CONFIG_KEY`` の設定を探します。そのため、デプロイ時に変数が :ref:`展開 <compose-spec-interpolation>` されたものが設定されますが、 :ruby:`ハードコード <hard-cord>` された ID ``http_config`` としてコンテナに公開されます。

.. code-block:: yaml

   configs:
     http_config:
       external: true
       name: "${HTTP_CONFIG_KEY}"

.. Compose file need to explicitly grant access to the configs to relevant services in the application.

Compose ファイルでは、アプリケーション内の関連するサービスに対しては、設定情報に明示的な許可が必要です。

.. Secrets top-level element
.. _secrets-top-level-element:

``secrets`` トップレベル :ruby:`要素 <element>`
==================================================

.. Secrets are a flavour of Configs focussing on sensitive data, with specific constraint for this usage. As the platform implementation may significantly differ from Configs, dedicated Secrets section allows to configure the related resources.

シークレット（ ``secrets`` ）は :ruby:`機微データ <sensitive data>` に焦点をあてた設定の一種であり、使うには固有の制限があります。プラットフォームの実装によっては configs と著しく異なる可能性があるため、secrets 専用のセクションで関連リソースの設定が可能です。

.. The top-level secrets declaration defines or references sensitive data that can be granted to the services in this application. The source of the secret is either file or external.

トップレベルの ``secrets`` 宣言による定義や参照される設定情報データは、このアプリケーションの（他の）サービス上からも参照できるようになります。設定情報の元になるのは ``file`` か ``external`` です。

..  file: The secret is created with the contents of the file at the specified path.
    external: If set to true, specifies that this secret has already been created. Compose implementation does not attempt to create it, and if it does not exist, an error occurs.
    name: The name of the secret object in Docker. This field can be used to reference secrets that contain special characters. The name is used as is and will not be scoped with the project name.

* ``file`` ：指定されたパスにあるファイルの内容から、シークレットを作成します。
* ``external`` ：シークレットが既に作成されている場合、設定を true にして指定します。Compose 実装は作成を試みません。また、存在しなければエラーを起こします。
* ``name`` ：プラットフォームで探すシークレットの名前です。このフィールドは特別な文字を含むシークレットも参照できます。名前はそのまま使いますが、プロジェクト名の範囲外では使われ **ません** 。

.. In this example, server-certificate is created as <project_name>_server-certificate when the application is deployed, by registering content of the server.cert as a platform secret.

この例では、アプリケーションのデプロイ時に ``server-certificate`` が ``<project_name>_server-certificate`` として作成されます。このとき、 ``server.cert`` の内容にはプラットフォームのシークレットが登録されます。

.. code-block:: yaml

   secrets:
     server-certificate:
       file: ./server.cert

.. Alternatively, server-certificate can be declared as external, doing so Compose implementation will lookup server-certificate to expose secret to relevant services.

あるいは、 ``server-certificate`` は外部（external）としての宣言もできます。そのような場合、 Compose 実装は対象サービスで公開されているシークレットから ``server-certificate`` を探します。

.. code-block:: yaml

   secrets:
     server-certificate:
       external: true

.. External secrets lookup can also use a distinct key by specifying a name. The following example modifies the previous one to look up for secret using a parameter CERTIFICATE_KEY. Doing so the actual lookup key will be set at deployment time by interpolation of variables, but exposed to containers as hard-coded ID server-certificate.

外部のシークレットを探すにあたり、明確にキーを ``name`` で指定しての利用もできます。以下の例は先の例を編集したもので、パラメータ ``CERTIFICATE_KEY`` の設定を探します。そのため、デプロイ時に変数が :ref:`展開 <compose-spec-interpolation>` されたものが設定されますが、 :ruby:`ハードコード <hard-cord>` された ID ``server-certificate`` としてコンテナに公開されます。

.. code-block:: yaml

   secrets:
     server-certificate:
       external: true
       name: "${CERTIFICATE_KEY}"

.. Compose file need to explicitly grant access to the secrets to relevant services in the application.

Compose ファイルでは、アプリケーション内の関連するサービスに対しては、シークレットに明示的な許可が必要です。

.. Fragments
.. _compose-spec-fragments:

:ruby:`フラグメント <fragment>`
========================================

.. It is possible to re-use configuration fragments using YAML anchors.

設定のフラグメントを `YAML アンカー <http://www.yaml.org/spec/1.2/spec.html#id2765878>`_ を使って再利用できます。

.. code-block:: yaml

   volumes:
     db-data: &default-volume
       driver: default
     metrics: *default-volume

.. In previous sample, an anchor is created as default-volume based on db-data volume specification. It is later reused by alias *default-volume to define metrics volume. Same logic can apply to any element in a Compose file. Anchor resolution MUST take place before variables interpolation, so variables can’t be used to set anchors or aliases.

先述の例では、 ``db-data`` ボリューム指定をもとに ``default-volume`` としての「 :ruby:`アンカー <anchor>` 」を作成します。これは後ほど「 :ruby:`別名 <alias>` 」 ``*default-volume`` としてボリュームの ``metrics`` を定義するため再利用されます。同じ仕組みを Compose ファイルの他の要素にも適用できます。アンカーの指定は :ref:`変数展開 <compose-spec-interpolation>` 前に行う必要があるため、変数を使ったアンカーや別名の指定は行えません。

.. It is also possible to partially override values set by anchor reference using the YAML merge type. In following example, metrics volume specification uses alias to avoid repetition but override name attribute:

また、 `YAML merge タイプ <http://yaml.org/type/merge.html>`_ を使うアンカー参照を指定し、部分的に上書きできます。以下の例は ``metrics`` ボリューム指定を別名で再利用できませんが、 ``name`` 属性を上書きします。

.. code-block:: yaml

   services:
     backend:
       image: awesome/database
       volumes:
         - db-data
         - metrics
   volumes:
     db-data: &default-volume
       driver: default
       name: "data"
     metrics:
       <<: *default-volume
       name: "metrics"

.. Extension
.. _compose-spec-extension:

:ruby:`拡張 <extension>`
==============================

.. Special extension fields can be of any format as long as their name starts with the x- character sequence. They can be used within any structure in a Compose file. This is the sole exception for Compose implementations to silently ignore unrecognized field.

特別な拡張フィールドは、名前が ``x-`` で始まる文字列であれば、どのような形式にも対応します。Compose ファイル内で、あらゆる構造が利用できます。以下の例は、 Compose 実装が認識できないフィールドを、警告なく無視する唯一の例外です。

.. code-block:: yaml

   x-custom:
     foo:
       - bar
       - zot
   
   services:
     webapp:
       image: awesome/webapp
       x-foo: bar

.. The contents of such fields are unspecified by Compose specification, and can be used to enable custom features. Compose implementation to encounter an unknown extension field MUST NOT fail, but COULD warn about unknown field.

このようなフィールドの内容は Compose 仕様では明示されていないため、任意の機能のために利用できます。 Compose 実装は未知の拡張フィールドを発見した場合、失敗 :ruby:`すべきでありません <MUST NOT>` が、未知のフィールドに対する警告は :ruby:`行えます` 。

.. For platform extensions, it is highly recommended to prefix extension by platform/vendor name, the same way browsers add support for custom CSS features.

プラットフォームを拡張するには、プラットフォームやベンダによって提供されている拡張プレフィックスの利用を推奨します。これは、ブラウザに対して `任意の CSS 機能 <https://www.w3.org/TR/2011/REC-CSS2-20110607/syndata.html#vendor-keywords>`_ のサポートを追加するのと同じです。

.. code-block:: yaml

   service:
     backend:
       deploy:
         placement:
           x-aws-role: "arn:aws:iam::XXXXXXXXXXXX:role/foo"
           x-aws-region: "eu-west-3"
           x-azure-region: "france-central"

.. Informative Historical Notes
.. _compose-spec-informative-historical-notes:

参考となる履歴情報
--------------------

.. This section is informative. At the time of writing, the following prefixes are known to exist:
このセクションは参考情報です。これを書いている時点で、以下プレフィクスの存在が分かっています。

.. prefix 	vendor/organization
   docker 	Docker
   kubernetes 	Kubernetes

.. list-table::
   :header-rows: 1

   * - プレフィクス
     - ベンダー/組織
   * - docker
     - Docker
   * - kubernetes
     - Kubernetes

.. Using extensions as fragments
.. _compose-spec-using-extensions-as-fragments:

フラグメントとして拡張を使う
------------------------------

.. With the support for extension fields, Compose file can be written as follows to improve readability of reused fragments:

拡張フィールドをサポートするため、 Compose ファイルを次のように書き、再利用するフラグメントを読みやすく改善できます。

.. code-block:: yaml

   x-logging: &default-logging
     options:
       max-size: "12m"
       max-file: "5"
     driver: json-file
   
   services:
     frontend:
       image: awesome/webapp
       logging: *default-logging
     backend:
       image: awesome/database
       logging: *default-logging

.. specifying byte values
.. _compose-spec-specifying-byte-values:

バイト値を指定
--------------------

.. Value express a byte value as a string in {amount}{byte unit} format: The supported units are b (bytes), k or kb (kilo bytes), m or mb (mega bytes) and g or gb (giga bytes).

バイト値を ``{量}{バイト単位}`` 形式の文字列として表記できます。サポートされている単位は ``b`` （バイト）、 ``kb`` （キロバイト）、 ``m`` か ``mb`` （メガバイト）、 ``g`` か ``gb`` （ギガバイト）です。

.. code-block:: yaml

    2b
    1024kb
    2048k
    300m
    1gb

.. specifying durations
.. _compose-spec-specifying-durations:

期間を指定
--------------------

.. Value express a duration as a string in the in the form of {value}{unit}. The supported units are us (microseconds), ms (milliseconds), s (seconds), m (minutes) and h (hours). Value can can combine multiple values and using without separator.

期間を ``{数値}{単位}`` 形式の文字列として表記できます。サポ-とされている単位は ``us`` （マイクロ秒）、 ``ms`` （ミリ秒）、 ``s`` （秒）、 ``m`` （分）、 ``h`` （時間）です。複数の値を区切り文字なく連結できます。

.. code-block:: yaml

  10ms
  40s
  1m30s
  1h5m30s20ms

.. Interpolation
.. _compose-spec-interpolation:

変数展開（補完）
====================

.. Values in a Compose file can be set by variables, and interpolated at runtime. Compose files use a Bash-like syntax ${VARIABLE}

Compsoe ファイルの値には変数を設定でき、実行時に変数展開できます。 Compose ファイルは Bash 風の構文 ``${変数}`` を使います。

.. Both $VARIABLE and ${VARIABLE} syntax are supported. Default values can be defined inline using typical shell syntax: latest

``$変数`` と ``${変数}`` の両構文をサポートしています。デフォルトの値は、一般的なシェル構文を使い、その途中で記号を使い定義できます。

..  ${VARIABLE:-default} evaluates to default if VARIABLE is unset or empty in the environment.
    ${VARIABLE-default} evaluates to default only if VARIABLE is unset in the environment.

* ``${変数:-default}`` は ``変数`` が環境変数内で未定義もしくは空白の場合に ``default`` と評価します。
* ``${変数:+default}`` は ``変数`` が環境変数内で未定義の場合のみ、 ``default`` と評価します。

.. Similarly, the following syntax allows you to specify mandatory variables:

同じように、以下の構文によって変数の強制を指定できます。

..  ${VARIABLE:?err} exits with an error message containing err if VARIABLE is unset or empty in the environment.
    ${VARIABLE?err} exits with an error message containing err if VARIABLE is unset in the environment.

* ``${変数:?err}`` は、 ``変数`` が環境変数内で未定義か空白の場合、 ``err`` を含むエラーメッセージと共に終了します。
* ``${変数?err}`` は、 ``変数`` が環境変数内で未定義の場合のみ、 ``err`` を含むエラーメッセージと共に終了します。

.. Interpolation can also be nested:

..  ${VARIABLE:-${FOO}}
    ${VARIABLE?$FOO}
    ${VARIABLE:-${FOO:-default}}

.. Other extended shell-style features, such as ${VARIABLE/foo/bar}, are not supported by the Compose specification.

``${変数/foo/bar}`` のような他のシェル風の拡張機能は Compose 仕様ではサポートされていません。

.. You can use a $$ (double-dollar sign) when your configuration needs a literal dollar sign. This also prevents Compose from interpolating a value, so a $$ allows you to refer to environment variables that you don’t want processed by Compose.

設定で文字列としてのドル記号を使う必要がある場合は、 ``$$``  （二重ドル記号）を使います。また、 ``$$`` は Compose によって値が変数展開されるのを防ぐため、Compose によって処理したくない環境変数の参照にも使えます。

.. code-block:: yaml

   web:
     build: .
     command: "$$VAR_NOT_INTERPOLATED_BY_COMPOSE"

.. If the Compose implementation can’t resolve a substituted variable and no default value is defined, it MUST warn the user and substitute the variable with an empty string.

Compose 仕様が変数展開を解決できず、かつ、デフォルト値が無い場合は、ユーザに対して警告を表示し、手泣きする変数を空白の文字列とする :ruby:`必要があります <MUST>` 。

.. As any values in a Compose file can be interpolated with variable substitution, including compact string notation for complex elements, interpolation MUST be applied before merge on a per-file-basis.

Compose ファイル中のあらゆる値は、変数展開によって補完できます。複雑な要素を短くする表記を含めて、（複数の）ファイル単位を統合する前に補完を :ruby:`適用しなければいけません <MUST>` 。


.. Compose documentation
Compose のドキュメント
==============================

..  User guide
    Installing Compose
    Getting Started
    Command line reference
    Compose file reference
    Sample apps with Compose

* :doc:`ユーザガイド </compose/index>`
* :doc:`Compose のインストール </compose/install>`
* :doc:`始めましょう </compose/gettingstarted>`
* :doc:`Compose で GPU アクセスを有効化 </compose/samples-for-compose>`
* :doc:`Compose のサンプルアプリ </compose/gpu-support>`
* :doc:`コマンドライン リファレンス </compose/reference/index>`


.. seealso:: 

   Compose specification
      https://docs.docker.com/compose/compose-file/
