.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/registry/configuration/
.. SOURCE: -
   doc version: 1.10
.. check date: 2016/03/12
.. -------------------------------------------------------------------

.. Registry Configuration Reference

.. _registry-configuration-reference:

========================================
Registry 設定リファレンス
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The Registry configuration is based on a YAML file, detailed below. While it comes with sane default values out of the box, you are heavily encouraged to review it exhaustively before moving your systems to production.

Registry の設定は YAML 形式のファイルをベースとしており、詳細は以下をご覧ください。特に気にしなくても適切な初期値が設定されています。そのため、システムをプロダクションに移行する場合、多大なレビューをしなくても良いでしょう。

.. Override specific configuration options

.. _override-specific-configuration-options:

設定オプションの上書き指定
==============================

.. In a typical setup where you run your Registry from the official image, you can specify a configuration variable from the environment by passing -e arguments to your docker run stanza, or from within a Dockerfile using the ENV instruction.

Registry の 一般的なセットアップは公式イメージを使う方法です。 ``docker run`` を実行する時、 ``-e`` オプションを使うことで環境変数を通した設定が可能となります。あるいは、 Dockerfile の中で ``ENV`` 命令を使うこともできます。

.. To override a configuration option, create an environment variable named REGISTRY_variable where variable is the name of the configuration option and the _ (underscore) represents indention levels. For example, you can configure the rootdirectory of the filesystem storage backend:

設定オプションを上書きするには、 ``REGISTRY_変数``  の ``変数`` にあたる設定オプションを使います。そして ``_`` （アンダースコア）は階層レベルを表します。例えば、``filesystem`` ストレージ・バックエンドの  ``rootdirecty`` を次のように指定しているとします。

.. code-block:: yaml

   storage:
     filesystem:
       rootdirectory: /var/lib/registry

.. To override this value, set an environment variable like this:

これを環境変数で上書きするには、次の形式で実行します。

.. code-block:: bash

   REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/somewhere

.. This variable overrides the /var/lib/registry value to the /somewhere directory.

この指定を行うと、``/var/lib/registry`` の値は ``/somewhere`` ディレクトリに上書きします。

..     NOTE: It is highly recommended to create a base configuration file with which environment variables can be used to tweak individual values. Overriding configuration sections with environment variables is not recommended.

.. note::

   細かな値を調整するためには、環境変数を記述した設定ファイルをベースに（registry コンテナを）起動するのを強く推奨します。環境変数で設定を変更するのは推奨されない手法です。

.. Overriding the entire configuration file

.. _overriding-the-enter-configuration-file:

設定ファイルの項目を上書き
==============================

.. If the default configuration is not a sound basis for your usage, or if you are having issues overriding keys from the environment, you can specify an alternate YAML configuration file by mounting it as a volume in the container.

デフォルトの設定では（Registryのコンテナ用）イメージが実行できないか、あるいは環境変数の指定で問題が起こるかもしれません。そのような場合はコンテナのボリュームとして別の設定用 YAML ファイルを指定できます。

.. Typically, create a new configuration file from scratch, and call it config.yml, then:

一般的には、新しい設定ファイルはスクラッチで作成（ゼロから作成）します。それが ``config.yml`` であれば、次のように実行します。

.. code-block:: bash

   docker run -d -p 5000:5000 --restart=always --name registry \
     -v `pwd`/config.yml:/etc/docker/registry/config.yml \
     registry:2

.. You can (and probably should) use this as a starting point.

次のファイルが `スタート地点（のサンプル設定用） <https://github.com/docker/distribution/blob/master/cmd/registry/config-example.yml>`_ として利用可能です（あるいは、使うべきでしょう）。

.. List of configuration options

.. _list-of-configuration-options:

設定オプションの一覧
====================

..  This section lists all the registry configuration options. Some options in the list are mutually exclusive. So, make sure to read the detailed reference information about each option that appears later in this page.

このセクションでは Registry 設定オプションの一覧を紹介します。オプションによっては相互に排他（どちらか１つしか指定不可）の場合があります。そのため、このページ後半にある各オプションのリファレンス詳細をご確認ください。

.. code-block:: yaml

   version: 0.1
   log:
     level: debug
     formatter: text
     fields:
       service: registry
       environment: staging
     hooks:
       - type: mail
         disabled: true
         levels:
           - panic
         options:
           smtp:
             addr: mail.example.com:25
             username: mailuser
             password: password
             insecure: true
           from: sender@example.com
           to:
             - errors@example.com
   loglevel: debug # deprecated: use "log"
   storage:
     filesystem:
       rootdirectory: /var/lib/registry
     azure:
       accountname: accountname
       accountkey: base64encodedaccountkey
       container: containername
     gcs:
       bucket: bucketname
       keyfile: /path/to/keyfile
       rootdirectory: /gcs/object/name/prefix
     s3:
       accesskey: awsaccesskey
       secretkey: awssecretkey
       region: us-west-1
       bucket: bucketname
       encrypt: true
       secure: true
       v4auth: true
       chunksize: 5242880
       rootdirectory: /s3/object/name/prefix
     rados:
       poolname: radospool
       username: radosuser
       chunksize: 4194304
     swift:
       username: username
       password: password
       authurl: https://storage.myprovider.com/auth/v1.0 or https://storage.myprovider.com/v2.0 or https://storage.myprovider.com/v3/auth
       tenant: tenantname
       tenantid: tenantid
       domain: domain name for Openstack Identity v3 API
       domainid: domain id for Openstack Identity v3 API
       insecureskipverify: true
       region: fr
       container: containername
       rootdirectory: /swift/object/name/prefix
     oss:
       accesskeyid: accesskeyid
       accesskeysecret: accesskeysecret
       region: OSS region name
       endpoint: optional endpoints
       internal: optional internal endpoint
       bucket: OSS bucket
       encrypt: optional data encryption setting
       secure: optional ssl setting
       chunksize: optional size valye
       rootdirectory: optional root directory
     inmemory:  # This driver takes no parameters
     delete:
       enabled: false
     redirect:
       disable: false
     cache:
       blobdescriptor: redis
     maintenance:
       uploadpurging:
         enabled: true
         age: 168h
         interval: 24h
         dryrun: false
       readonly:
         enabled: false
   auth:
     silly:
       realm: silly-realm
       service: silly-service
     token:
       realm: token-realm
       service: token-service
       issuer: registry-token-issuer
       rootcertbundle: /root/certs/bundle
     htpasswd:
       realm: basic-realm
       path: /path/to/htpasswd
   middleware:
     registry:
       - name: ARegistryMiddleware
         options:
           foo: bar
     repository:
       - name: ARepositoryMiddleware
         options:
           foo: bar
     storage:
       - name: cloudfront
         options:
           baseurl: https://my.cloudfronted.domain.com/
           privatekey: /path/to/pem
           keypairid: cloudfrontkeypairid
           duration: 3000
   reporting:
     bugsnag:
       apikey: bugsnagapikey
       releasestage: bugsnagreleasestage
       endpoint: bugsnagendpoint
     newrelic:
       licensekey: newreliclicensekey
       name: newrelicname
       verbose: true
   http:
     addr: localhost:5000
     prefix: /my/nested/registry/
     host: https://myregistryaddress.org:5000
     secret: asecretforlocaldevelopment
     tls:
       certificate: /path/to/x509/public
       key: /path/to/x509/private
       clientcas:
         - /path/to/ca.pem
         - /path/to/another/ca.pem
     debug:
       addr: localhost:5001
     headers:
       X-Content-Type-Options: [nosniff]
   notifications:
     endpoints:
       - name: alistener
         disabled: false
         url: https://my.listener.com/event
         headers: <http.Header>
         timeout: 500
         threshold: 5
         backoff: 1000
   redis:
     addr: localhost:6379
     password: asecret
     db: 0
     dialtimeout: 10ms
     readtimeout: 10ms
     writetimeout: 10ms
     pool:
       maxidle: 16
       maxactive: 64
       idletimeout: 300s
   health:
     storagedriver:
       enabled: true
       interval: 10s
       threshold: 3
     file:
       - file: /path/to/checked/file
         interval: 10s
     http:
       - uri: http://server.to.check/must/return/200
         headers:
           Authorization: [Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==]
         statuscode: 200
         timeout: 3s
         interval: 10s
         threshold: 3
     tcp:
       - addr: redis-server.domain.com:6379
         timeout: 3s
         interval: 10s
         threshold: 3
   proxy:
     remoteurl: https://registry-1.docker.io
     username: [username]
     password: [password]
   compatibility:
     schema1:
       signingkeyfile: /etc/registry/key.json
       disablesignaturestore: true

.. In some instances a configuration option is optional but it contains child options marked as required. This indicates that you can omit the parent with all its children. However, if the parent is included, you must also include all the children marked required.

設定オプションのいくつかは **オプション** ですが、子オプションの中には **必須** な場合があります。つまり子オプションによっては元のオプションを省略できます。しかしながら、親に含まれていても、それが子オプションでも **必須** になっている場合があります。

.. version

.. _registry-version:

version
==========

.. code-block:: yaml

   version: 0.1

.. The version option is required. It specifies the configuration’s version. It is expected to remain a top-level field, to allow for a consistent version check before parsing the remainder of the configuration file.

``version`` オプションは **必須** です。これは設定ファイルのバージョンを指定します。トップ・レベルのフィールドに書くべきです。これは、以降の設定ファイルを処理する前に、バージョン確認を行えるようにするためです。

.. log

.. _registry-log:

log
==========

.. The log subsection configures the behavior of the logging system. The logging system outputs everything to stdout. You can adjust the granularity and format with this configuration section.

``log`` サブセクションはロギング・システムの動作を設定します。ロギング・システムは全ての標準出力の情報を書き出します。このセクションで、必要に応じてログの粒度や形式を指定できミズ会う。

.. code-block:: bash

   log:
     level: debug
     formatter: text
     fields:
       service: registry
       environment: staging

.. Parameter 	Required 	Description
   level 	no 	Sets the sensitivity of logging output. Permitted values are error, warn, info and debug. The default is info.
   formatter 	no 	This selects the format of logging output. The format primarily affects how keyed attributes for a log line are encoded. Options are text, json or logstash. The default is text.
   fields 	no 	A map of field names to values. These are added to every log line for the context. This is useful for identifying log messages source after being mixed in other systems.

.. list-table::
   :header-rows: 1
   
   * - パラメータ
     - 必須
     - 説明
   * - ``level``
     - いいえ
     - ログ出力のレベル（度合い）を設定します。利用可能な値は ``error`` 、 ``warn`` 、 ``info`` 、 ``debug`` です。デフォルトは ``info`` です。
   * - ``formatter``
     - いいえ
     - ログの出力形式を指定します。ログの各行をどのような形式で出力するかを決めます。オプションは ``text`` 、 ``json`` 、``logstash`` です。デフォルトは ``text`` です。
   * - ``fields``
     - いいえ
     - フィールド名を値に割り当て（マップ）します。ログ内容の各行に追加します。これが役立つのは、複数のシステムを混在させるとき、元になった環境を識別する場合です。

.. hooks

.. _registry-hooks:

hooks
==========

.. code-block:: yaml

   hooks:
     - type: mail
       levels:
         - panic
       options:
         smtp:
           addr: smtp.sendhost.com:25
           username: sendername
           password: password
           insecure: true
         from: name@sendhost.com
         to:
           - name@receivehost.com

.. The hooks subsection configures the logging hooks’ behavior. This subsection includes a sequence handler which you can use for sending mail, for example. Refer to loglevel to configure the level of messages printed.

``hooks`` サブセクションは、ログをフックする挙動を指定します。このサブセクション例ではシーケンス・ハンドラを指定し、メールを送信する命令を設定しています。出力されるメッセージのレベルについては ``loglevel`` をご覧ください。

.. loglevel

.. _registry-loglevel:

loglevel
==========

..    DEPRECATED: Please use log instead.

.. warning::

   廃止予定：代わりに :ref:`registry-log` をご覧ください。

.. code-block:: yaml

   loglevel: debug

.. Permitted values are error, warn, info and debug. The default is info.

ここでは ``error`` 、 ``warn`` 、 ``info`` 、 ``debug`` を指定できます。デフォルトは ``info`` です。

.. storage

.. _registry-storage:

storage
==========

.. code-block:: yaml

   storage:
     filesystem:
       rootdirectory: /var/lib/registry
     azure:
       accountname: accountname
       accountkey: base64encodedaccountkey
       container: containername
     gcs:
       bucket: bucketname
       keyfile: /path/to/keyfile
       rootdirectory: /gcs/object/name/prefix
     s3:
       accesskey: awsaccesskey
       secretkey: awssecretkey
       region: us-west-1
       bucket: bucketname
       encrypt: true
       secure: true
       v4auth: true
       chunksize: 5242880
       rootdirectory: /s3/object/name/prefix
     rados:
       poolname: radospool
       username: radosuser
       chunksize: 4194304
     swift:
       username: username
       password: password
       authurl: https://storage.myprovider.com/auth/v1.0 or https://storage.myprovider.com/v2.0 or https://storage.myprovider.com/v3/auth
       tenant: tenantname
       tenantid: tenantid
       domain: domain name for Openstack Identity v3 API
       domainid: domain id for Openstack Identity v3 API
       insecureskipverify: true
       region: fr
       container: containername
       rootdirectory: /swift/object/name/prefix
     oss:
       accesskeyid: accesskeyid
       accesskeysecret: accesskeysecret
       region: OSS region name
       endpoint: optional endpoints
       internal: optional internal endpoint
       bucket: OSS bucket
       encrypt: optional data encryption setting
       secure: optional ssl setting
       chunksize: optional size valye
       rootdirectory: optional root directory
     inmemory:
     delete:
       enabled: false
     cache:
       blobdescriptor: inmemory
     maintenance:
       uploadpurging:
         enabled: true
         age: 168h
         interval: 24h
         dryrun: false
     redirect:
       disable: false

.. The storage option is required and defines which storage backend is in use. You must configure one backend; if you configure more, the registry returns an error. You can choose any of these backend storage drivers:

ストレージのバックエンドに何を使うか定義する storage オプションは **必須** です。バックエンドに指定できるのは１つだけです。複数指定してもエラーになります。バックエンド・ストレージのドライバには、以下の項目が指定可能です。

.. filesystem 	Uses the local disk to store registry files. It is ideal for development and may be appropriate for some small-scale production applications. See the driver's reference documentation.
.. azure 	Uses Microsoft's Azure Blob Storage. See the driver's reference documentation.
.. gcs 	Uses Google Cloud Storage. See the driver's reference documentation.
.. rados 	Uses Ceph Object Storage. See the driver's reference documentation.
.. s3 	Uses Amazon's Simple Storage Service (S3). See the driver's reference documentation.
.. swift 	Uses Openstack Swift object storage. See the driver's reference documentation.
.. oss 	Uses Aliyun OSS for object storage. See the driver's reference documentation.

* ``filesystem`` : ローカルのディスク上にレジストリ用ファイルを保存します。開発環境や小規模のプロダクションに理想的でしょう。詳細は :doc:`ドライバのリファレンス・ドキュメント </registry/storage-drivers/filesystem>` をご覧ください。
* ``azure`` : Microsoft Azure Blob ストレージを使います。詳細は :doc:`ドライバのリファレンス・ドキュメント </registry/storage-drivers/azure>` をご覧ください。
* ``rados`` : Ceph オブジェクト・ストレージを使います。詳細は :doc:`ドライバのリファレンス・ドキュメント </registry/storage-drivers/rados>` をご覧ください。
* ``s3`` : Amazon の Simple Storage Service (S3) を使います。詳細は :doc:`ドライバのリファレンス・ドキュメント </registry/storage-drivers/s3>` をご覧ください。
* ``swift`` : OpenStack Swift ストレージ・ドライバを使います。詳細は :doc:`ドライバのリファレンス・ドキュメント </registry/storage-drivers/swift>` をご覧ください。
* ``oss`` : Aliyun Oss をオブジェクト・ストレージに使います。詳細は :doc:`ドライバのリファレンス・ドキュメント </registry/storage-drivers/oss>` をご覧ください。

.. For purely tests purposes, you can use the inmemory storage driver. If you would like to run a registry from volatile memory, use the filesystem driver on a ramdisk.

純粋なテスト用途であれば、 ``inmemory`` （イン・メモリ） :doc:`ストレージ・ドライバ </registry/storage-drivers/inmemory>` を指定できます。これはレジストリを揮発性メモリ上で実行するものであり、RAM ディスク上で ``filesystem`` :doc:`ドライバ </registry/storage-drivers/inmemory>`  を使います。

.. If you are deploying a registry on Windows, be aware that a Windows volume mounted from the host is not recommended. Instead, you can use a S3, or Azure, backing data-store. If you do use a Windows volume, you must ensure that the PATH to the mount point is within Windows’ MAX_PATH limits (typically 255 characters). Failure to do so can result in the following error message:

Registry を Windows にデプロイする場合は、ホスト上の Windows ボリュームのマウントは推奨されていないことにご注意ください。その代わり、 S3 や Azure といったデータストアを使えます。Windows ボリュームを使うのであれば、マウントポイントの ``PATH`` は Windows の ``MAX_PATH`` 上限（通常は 255 文字）以内に収める必要があります。失敗すると、次のようなメッセージが表示されます。

.. code-block:: bash

   mkdir /XXX protocol error and your registry will not function properly.

.. Maintenance

.. _registry-maintenance:

maintenance
--------------------

.. Currently upload purging and read-only mode are the only maintenance functions available. These and future maintenance functions which are related to storage can be configured under the maintenance section.

現時点では、メンテナンス機能としてアップロード・パージング（upload purging）とリードオンリー・モードが利用できます。これらはストレージに関連するメンテナンス機能を提供するもので、maintenance セクション以下で設定します。

.. Upload Purging

アップロード・パージング
------------------------------

.. Upload purging is a background process that periodically removes orphaned files from the upload directories of the registry. Upload purging is enabled by default. To configure upload directory purging, the following parameters must be set.

``uploadpurging`` で指定するアップロード・パージング（upload purging）とは、Registry のアップロード対象のディレクトリから孤立したファイルを定期的に削除する処理です。デフォルトでアップロード・パージングは有効化されています。アップロード・ディレクトリのパージングを競ってするには、以下のパラメータ指定が必要です。

.. Parameter 	Required 	Description
.. enabled 	yes 	Set to true to enable upload purging. Default=true.
.. age 	yes 	Upload directories which are older than this age will be deleted. Default=168h (1 week)
.. interval 	yes 	The interval between upload directory purging. Default=24h.
.. dryrun 	yes 	dryrun can be set to true to obtain a summary of what directories will be deleted. Default=false.

.. list-table:
   :header-rows: 1
   
   * - パラメータ
     - 必須
     - 説明
   * - ``enabled``
     - はい
     - true にするとアップロード・パージングを有効化します。デフォルトは true です。
   * - ``age``
     - はい
     - アップロード・ディレクトリ上にある一定期間を過ぎた古いファイルを削除します。デフォルトは 168h （１週）です。
   * - ``interval``
     - はい
     - アップロード・ディレクトリをパージする間隔です。デフォルトは 24h です。
   * - ``dryrun``
     - はい
     - dryrun （ドライ・ラン）を true にすると、ディレクトリの何を削除しようとしているか表示します。デフォルトは false です。

.. Note: age and interval are strings containing a number with optional fraction and a unit suffix: e.g. 45m, 2h10m, 168h (1 week).

.. note::

   ``age`` と ``interval`` の文字列にはオプションで単位を指定できます。例： 45m（45分）、2h10m（２時間10分）、168h（168時間＝１週間）

.. Read-only mode

.. _registry-read-only-mode:

リードオンリー・モード
------------------------------

.. If the readonly section under maintenance has enabled set to true, clients will not be allowed to write to the registry. This mode is useful to temporarily prevent writes to the backend storage so a garbage collection pass can be run. Before running garbage collection, the registry should be restarted with readonly’s enabled set to true. After the garbage collection pass finishes, the registry may be restarted again, this time with readonly removed from the configuration (or set to false).

``maintenance`` 以下の ``readonly`` セクションにある ``enabled`` を ``true`` に指定すると、クライアントから Registry へアップロードできなくなります。この処理はバックエンド・ストレージ上の整理をするとき、一時的に読み込み専用にしたい場合に便利です。整理を始める前に、Registry はリードオンリー設定の ``enabled`` を ``true`` に指定します。整理が終われば Registry を再起動します。この時に設定ファイルから ``readonly``  を消します（あるいは false の値を指定します）。

.. delete

.. _registry-delete:

delete
----------

.. Use the delete subsection to enable the deletion of image blobs and manifests by digest. It defaults to false, but it can be enabled by writing the following on the configuration file:

``delete`` サブセクションはダイジェストを使ってイメージのかたまりとマニフェストを削除するために使います。デフォルトは false ですが、設定ファイルに次のような設定を書くと有効化できます。

.. code-block:: yaml

   delete:
     enabled: true

.. cache

.. _registry-cache:

cache
----------

.. Use the cache subsection to enable caching of data accessed in the storage backend. Currently, the only available cache provides fast access to layer metadata. This, if configured, uses the blobdescriptor field.

``cache`` サブセクションを使うとストレージ・バックエンドにアクセスするデータをキャッシュ可能にします。現時点で提供しているのは、レイヤのメタデータへのアクセスを早くするためのキャッシュのみです。設定するには ``blobdescriptor`` フィールドを使います。

.. You can set blobdescriptor field to redis or inmemory. The redis value uses a Redis pool to cache layer metadata. The inmemory value uses an in memory map.

``blobdescriptor`` フィールドには ``redis`` か ``inmemory`` を指定できます。値を ``redis`` にすると、レイヤ・メタデータのキャッシュに Redis プールを使います。値を ``inmemory`` にするとメモリを割り当てます。

..    NOTE: Formerly, blobdescriptor was known as layerinfo. While these are equivalent, layerinfo has been deprecated, in favor or blobdescriptor.

.. note::

   ``blobdescriptor`` は、以前の ``layerinfo`` です。これらは同じものです。 ``layerinfo`` は廃止され、 ``blobdescriptor`` に移行しました。

.. redirect

.. _registry-redirect:

redirect
----------

.. The redirect subsection provides configuration for managing redirects from content backends. For backends that support it, redirecting is enabled by default. Certain deployment scenarios may prefer to route all data through the Registry, rather than redirecting to the backend. This may be more efficient when using a backend that is not co-located or when a registry instance is doing aggressive caching.

``redirect`` サブセクションはコンテント・バックエンドからのリダイレクトを管理する設定です。バックエンドがサポートしていれば、このリダイレクトはデフォルトで有効化されています。あるデプロイ・シナリオにおいて、全てのデータをバックエンドにリダイレクトするよりも、レジストリを通したほうが望ましい場合があります。バックエンドが同じ場所にない場合、あるいはレジストリ・インスタンスがキャッシュを必要としている場合には、より効果的にバックエンドを活用できる場合があるでしょう。

.. Redirects can be disabled by adding a single flag disable, set to true under the redirect section:

リダイレクトを無効化するには、 ``redirect`` セクション下にある ``disable`` に ``true``  フラグをセットするだけです。

.. code-block:: yaml

   redirect:
     disable: true

.. auth

.. _registry-auth:

auth
==========

.. code-block:: yaml

   auth:
     silly:
       realm: silly-realm
       service: silly-service
     token:
       realm: token-realm
       service: token-service
       issuer: registry-token-issuer
       rootcertbundle: /root/certs/bundle
     htpasswd:
       realm: basic-realm
       path: /path/to/htpasswd

.. The auth option is optional. There are currently 3 possible auth providers, silly, token and htpasswd. You can configure only one auth provider.

``auth`` オプションは *オプションです*** 。認証（auth）プロバイダとして ``silly``  ・ ``token`` ・ ``htpasswd`` の３種類を現時点では利用可能です。 ``auth`` プロバイダに指定できるのは、いずれか１つだけです。

.. silly

.. _registry-silly:

silly
----------

.. The silly auth is only for development purposes. It simply checks for the existence of the Authorization header in the HTTP request. It has no regard for the header’s value. If the header does not exist, the silly auth responds with a challenge response, echoing back the realm, service, and scope that access was denied for.

``silly`` 認証は開発用途向けのみです。HTTP リクエストの中に ``Authorization`` が存在するかどうかのみ確認します。ヘッダの内容については確認しません。ヘッダが存在しなければ、 ``silly`` 認証はチャレンジ・レスポンスを応答し、強制的に realm または service を拒否した状態を返します。

.. The following values are used to configure the response:

応答には以下の値を設定できます。

.. Parameter 	Required 	Description
   realm 	yes 	The realm in which the registry server authenticates.
   service 	yes 	The service being authenticated.

.. list-table::
   :header-rows: 1
   
   * - パラメータ
     - 必須
     - 説明
   * - ``realm``
     - はい
     - レジストリ・サーバ認証は realm 
   * - ``service``
     - はい
     - サービスが認証された状態

.. token

.. _registry-token:

token
----------

.. Token based authentication allows the authentication system to be decoupled from the registry. It is a well established authentication paradigm with a high degree of security.

トークンをベースとした認証を使うことで、認証システムを Registry から切り離せます。高度なセキュリティを考慮した認証の枠組みを実現します。

.. Parameter 	Required 	Description
   realm 	yes 	The realm in which the registry server authenticates.
   service 	yes 	The service being authenticated.
   issuer 	yes 	The name of the token issuer. The issuer inserts this into the token so it must match the value configured for the issuer.
   rootcertbundle 	yes 	The absolute path to the root certificate bundle. This bundle contains the public part of the certificates that is used to sign authentication tokens.

.. list-table::
   :header-rows: 1
   
   * - パラメータ
     - 必須
     - 説明
   * - ``realm``
     - はい
     - レジストリ・サーバ認証は realm 
   * - ``service``
     - はい
     - サービスが認証された状態
   * - ``issuer``
     - はい
     - トークン発行者（issue）の名前。発行者はこれをトークンの中に入れます。つまり、発行者が指定した値を一致する必要があります。
   * - ``rootcertbundle``
     - はい
     - ルート証明書群の絶対パスを指定します。ここには証明書の公開部分が含まれるもので、認証トークンの署名用に使います。

.. For more information about Token based authentication configuration, see the specification.

トークンをベースとした認証設定の更に詳しい情報は、 :doc:`specification </registry/spec/auth/token>` をご覧ください。

.. htpasswd

.. _registry-htpasswd:

htpasswd
----------

.. The htpasswd authentication backed allows one to configure basic auth using an Apache htpasswd file. Only bcrypt format passwords are supported. Entries with other hash types will be ignored. The htpasswd file is loaded once, at startup. If the file is invalid, the registry will display an error and will not start.

*htpasswd* 認証はバックエンドの認証に `Apache の httpd ファイル <https://httpd.apache.org/docs/2.4/programs/htpasswd.html>`_ を使ったベーシック認証を使います。 ``bcrypt`` 形式のパスワードのみサポートしています。ハッシュ・タイプのエントリは無視します。htpasswd ファイルは起動時に読み込みます。もしファイルが無効であれば、Registry はエラーを表示し、起動しません。

..    WARNING: This authentication scheme should only be used with TLS configured, since basic authentication sends passwords as part of the http header.

.. warning::

   この認証方式は TLS 設定と一緒に使用すべきです。何故なら、ベーシック認証はパスワード情報を http ヘッダの一部として送信するからです。

.. Parameter 	Required 	Description
   realm 	yes 	The realm in which the registry server authenticates.
   path 	yes 	Path to htpasswd file to load at startup.

.. list-table::
   :header-rows: 1
   
   * - パラメータ
     - 必須
     - 説明
   * - ``realm``
     - はい
     - レジストリ・サーバ認証は realm 
   * - ``service``
     - はい
     - サービスが認証された状態


.. middleware

.. _registry-middleware:

middleware
==========

.. The middleware option is optional. Use this option to inject middleware at named hook points. All middleware must implement the same interface as the object they’re wrapping. This means a registry middleware must implement the distribution.Namespace interface, repository middleware must implement distribution.Repository, and storage middleware must implement driver.StorageDriver.

``middleware`` オプションは **オプション** です。このオプションはフック・ポイント（hook point）に投入するミドルウェアの名前指定に使います。全てのミドルウェアはラッピング可能なオブジェクトとして、同じインターフェースを使って実行する必要があります。つまりレジストリのミドルウェアは ``distribution.Namespace`` インターフェースとして実行する必要があり、リポジトリのミドルウェアは必ず ``distribution.Repository`` として実行する必要があり、また、ストレージ/ミドルウェアは ``driver.StorageDriver`` として実行する必要があります。

.. Currently only one middleware, cloudfront, a storage middleware, is supported in the registry implementation.

現時点でレジストリの実装上サポートされているのは ``cloudfront`` です。これは唯一利用可能なストレージ・ミドルウェアです。

.. code-block:: yaml

   middleware:
     registry:
       - name: ARegistryMiddleware
         options:
           foo: bar
     repository:
       - name: ARepositoryMiddleware
         options:
           foo: bar
     storage:
       - name: cloudfront
         options:
           baseurl: https://my.cloudfronted.domain.com/
           privatekey: /path/to/pem
           keypairid: cloudfrontkeypairid
           duration: 3000

.. Each middleware entry has name and options entries. The name must correspond to the name under which the middleware registers itself. The options field is a map that details custom configuration required to initialize the middleware. It is treated as a map[string]interface{}. As such, it supports any interesting structures desired, leaving it up to the middleware initialization function to best determine how to handle the specific interpretation of the options.

各ミドルウェアのエントリは ``name`` と ``options`` エントリを持っています。 ``name`` は必須であり、ミドルウェア自身を登録するための名前に相当します。 ``options`` フィールドはミドルウェアの初期化時に何らかの設定が必要な場合、その詳細を指定します。ここでは ``map[文字列]interface{}`` の形式です。あるいは、必要であれば任意の構造の利用もサポートされています。どのような手法が望ましいかあ、実装するオプションの指定次第です。

.. cloudfront

.. _registry-cloudfront:

.. Parameter 	Required 	Description
   baseurl 	yes 	SCHEME://HOST[/PATH] at which Cloudfront is served.
   privatekey 	yes 	Private Key for Cloudfront provided by AWS.
   keypairid 	yes 	Key pair ID provided by AWS.
   duration 	no 	Duration for which a signed URL should be valid.

.. list-table::
   :header-rows: 1
   
   * - パラメータ
     - 必須
     - 説明
   * - ``baseurl``
     - はい
     - Cloudfront が提供する ``SCHEME://ホスト[/パス]``
   * - ``privatekey``
     - はい
     - AWS の Cloudfront が提供する秘密鍵
   * - ``keypairid``
     - はい
     - AWS が提供するキーペア ID
   * - ``duration``
     - いいえ
     - 署名した URL が無効になるまでの期間

.. reporting

.. _registry-reporting:

reporting
==========

.. code-block:: yaml

   reporting:
     bugsnag:
       apikey: bugsnagapikey
       releasestage: bugsnagreleasestage
       endpoint: bugsnagendpoint
     newrelic:
       licensekey: newreliclicensekey
       name: newrelicname
       verbose: true

.. The reporting option is optional and configures error and metrics reporting tools. At the moment only two services are supported, New Relic and Bugsnag, a valid configuration may contain both.

``reporting`` オプションは **オプション** であり、エラーやメトリクスを報告するツールを設定します。現時点でサポートされているのは `New Relic <http://newrelic.com/>`_ と `Bugsnag <http://bugsnag.com/>`_ です。それぞれに必要なオプション項目があります。

.. bugsnag

.. Parameter 	Required 	Description
   apikey 	yes 	API Key provided by Bugsnag
   releasestage 	no 	Tracks where the registry is deployed, for example, production,staging, or development.
   endpoint 	no 	Specify the enterprise Bugsnag endpoint.

.. list-table::
   :header-rows: 1
   
   * - パラメータ
     - 必須
     - 説明
   * - ``apikey``
     - はい
     - Bugsnag が提供する API 鍵
   * - ``releasestage``
     - いいえ
     - レジストリの状態を追跡します。例： ``production`` 、 ``staging`` 、 ``development``
   * - ``endpoint``
     - いいえ
     - enterprise Bugsnag のエンドポイントを指定

.. newrelic

.. Parameter 	Required 	Description
   licensekey 	yes 	License key provided by New Relic.
   name 	no 	New Relic application name.
   verbose 	no 	Enable New Relic debugging output on stdout.

.. list-table::
   :header-rows: 1
   
   * - パラメータ
     - 必須
     - 説明
   * - ``licensekey``
     - はい
     - New Relic が提供するライセンス・キー
   * - ``name``
     - いいえ
     - New Relic のアプリケーション名
   * - ``verbose``
     - いいえ
     - デバッグ用の出力を標準出力に表示

.. http

.. _registry-http:

http
==========

.. code-block:: yaml

   http:
        addr: localhost:5000
        net: tcp
        prefix: /my/nested/registry/
        host: https://myregistryaddress.org:5000
        secret: asecretforlocaldevelopment
        tls:
          certificate: /path/to/x509/public
          key: /path/to/x509/private
          clientcas:
            - /path/to/ca.pem
            - /path/to/another/ca.pem
        debug:
          addr: localhost:5001
        headers:
          X-Content-Type-Options: [nosniff]

(以下ToDo)

The http option details the configuration for the HTTP server that hosts the registry.
Parameter 	Required 	Description
addr 	yes 	The address for which the server should accept connections. The form depends on a network type (see net option): HOST:PORT for tcp and FILE for a unix socket.
net 	no 	The network which is used to create a listening socket. Known networks are unix and tcp. The default empty value means tcp.
prefix 	no 	If the server does not run at the root path use this value to specify the prefix. The root path is the section before v2. It should have both preceding and trailing slashes, for example /path/.
host 	no 	This parameter specifies an externally-reachable address for the registry, as a fully qualified URL. If present, it is used when creating generated URLs. Otherwise, these URLs are derived from client requests.
secret 	yes 	A random piece of data. This is used to sign state that may be stored with the client to protect against tampering. For production environments you should generate a random piece of data using a cryptographically secure random generator. This configuration parameter may be omitted, in which case the registry will automatically generate a secret at launch.

WARNING: If you are building a cluster of registries behind a load balancer, you MUST ensure the secret is the same for all registries.
tls

The tls struct within http is optional. Use this to configure TLS for the server. If you already have a server such as Nginx or Apache running on the same host as the registry, you may prefer to configure TLS termination there and proxy connections to the registry server.
Parameter 	Required 	Description
certificate 	yes 	Absolute path to x509 cert file
key 	yes 	Absolute path to x509 private key file.
clientcas 	no 	An array of absolute paths to a x509 CA file
debug

The debug option is optional . Use it to configure a debug server that can be helpful in diagnosing problems. The debug endpoint can be used for monitoring registry metrics and health, as well as profiling. Sensitive information may be available via the debug endpoint. Please be certain that access to the debug endpoint is locked down in a production environment.

The debug section takes a single, required addr parameter. This parameter specifies the HOST:PORT on which the debug server should accept connections.
headers

The headers option is optional . Use it to specify headers that the HTTP server should include in responses. This can be used for security headers such as Strict-Transport-Security.

The headers option should contain an option for each header to include, where the parameter name is the header’s name, and the parameter value a list of the header’s payload values.

Including X-Content-Type-Options: [nosniff] is recommended, so that browsers will not interpret content as HTML if they are directed to load a page from the registry. This header is included in the example configuration files.
notifications

notifications:
  endpoints:
    - name: alistener
      disabled: false
      url: https://my.listener.com/event
      headers: <http.Header>
      timeout: 500
      threshold: 5
      backoff: 1000

The notifications option is optional and currently may contain a single option, endpoints.
endpoints

Endpoints is a list of named services (URLs) that can accept event notifications.
Parameter 	Required 	Description
name 	yes 	A human readable name for the service.
disabled 	no 	A boolean to enable/disable notifications for a service.
url 	yes 	The URL to which events should be published.
headers 	yes 	Static headers to add to each request. Each header's name should be a key underneath headers, and each value is a list of payloads for that header name. Note that values must always be lists.
timeout 	yes 	An HTTP timeout value. This field takes a positive integer and an optional suffix indicating the unit of time. Possible units are:

    ns (nanoseconds)
    us (microseconds)
    ms (milliseconds)
    s (seconds)
    m (minutes)
    h (hours)

If you omit the suffix, the system interprets the value as nanoseconds.
threshold 	yes 	An integer specifying how long to wait before backing off a failure.
backoff 	yes 	How long the system backs off before retrying. This field takes a positive integer and an optional suffix indicating the unit of time. Possible units are:

    ns (nanoseconds)
    us (microseconds)
    ms (milliseconds)
    s (seconds)
    m (minutes)
    h (hours)

If you omit the suffix, the system interprets the value as nanoseconds.
redis

redis:
  addr: localhost:6379
  password: asecret
  db: 0
  dialtimeout: 10ms
  readtimeout: 10ms
  writetimeout: 10ms
  pool:
    maxidle: 16
    maxactive: 64
    idletimeout: 300s

Declare parameters for constructing the redis connections. Registry instances may use the Redis instance for several applications. The current purpose is caching information about immutable blobs. Most of the options below control how the registry connects to redis. You can control the pool’s behavior with the pool subsection.

It’s advisable to configure Redis itself with the allkeys-lru eviction policy as the registry does not set an expire value on keys.
Parameter 	Required 	Description
addr 	yes 	Address (host and port) of redis instance.
password 	no 	A password used to authenticate to the redis instance.
db 	no 	Selects the db for each connection.
dialtimeout 	no 	Timeout for connecting to a redis instance.
readtimeout 	no 	Timeout for reading from redis connections.
writetimeout 	no 	Timeout for writing to redis connections.
pool

pool:
  maxidle: 16
  maxactive: 64
  idletimeout: 300s

Configure the behavior of the Redis connection pool.
Parameter 	Required 	Description
maxidle 	no 	Sets the maximum number of idle connections.
maxactive 	no 	sets the maximum number of connections that should be opened before blocking a connection request.
idletimeout 	no 	sets the amount time to wait before closing inactive connections.
health

health:
  storagedriver:
    enabled: true
    interval: 10s
    threshold: 3
  file:
    - file: /path/to/checked/file
      interval: 10s
  http:
    - uri: http://server.to.check/must/return/200
      headers:
        Authorization: [Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==]
      statuscode: 200
      timeout: 3s
      interval: 10s
      threshold: 3
  tcp:
    - addr: redis-server.domain.com:6379
      timeout: 3s
      interval: 10s
      threshold: 3

The health option is optional. It may contain preferences for a periodic health check on the storage driver’s backend storage, and optional periodic checks on local files, HTTP URIs, and/or TCP servers. The results of the health checks are available at /debug/health on the debug HTTP server if the debug HTTP server is enabled (see http section).
storagedriver

storagedriver contains options for a health check on the configured storage driver’s backend storage. enabled must be set to true for this health check to be active.
Parameter 	Required 	Description
enabled 	yes 	"true" to enable the storage driver health check or "false" to disable it.
interval 	no 	The length of time to wait between repetitions of the check. This field takes a positive integer and an optional suffix indicating the unit of time. Possible units are:

    ns (nanoseconds)
    us (microseconds)
    ms (milliseconds)
    s (seconds)
    m (minutes)
    h (hours)

If you omit the suffix, the system interprets the value as nanoseconds. The default value is 10 seconds if this field is omitted.
threshold 	no 	An integer specifying the number of times the check must fail before the check triggers an unhealthy state. If this filed is not specified, a single failure will trigger an unhealthy state.
file

file is a list of paths to be periodically checked for the existence of a file. If a file exists at the given path, the health check will fail. This can be used as a way of bringing a registry out of rotation by creating a file.
Parameter 	Required 	Description
file 	yes 	The path to check for the existence of a file.
interval 	no 	The length of time to wait between repetitions of the check. This field takes a positive integer and an optional suffix indicating the unit of time. Possible units are:

    ns (nanoseconds)
    us (microseconds)
    ms (milliseconds)
    s (seconds)
    m (minutes)
    h (hours)

If you omit the suffix, the system interprets the value as nanoseconds. The default value is 10 seconds if this field is omitted.
http

http is a list of HTTP URIs to be periodically checked with HEAD requests. If a HEAD request doesn’t complete or returns an unexpected status code, the health check will fail.
Parameter 	Required 	Description
uri 	yes 	The URI to check.
headers 	no 	Static headers to add to each request. Each header's name should be a key underneath headers, and each value is a list of payloads for that header name. Note that values must always be lists.
statuscode 	no 	Expected status code from the HTTP URI. Defaults to 200.
timeout 	no 	The length of time to wait before timing out the HTTP request. This field takes a positive integer and an optional suffix indicating the unit of time. Possible units are:

    ns (nanoseconds)
    us (microseconds)
    ms (milliseconds)
    s (seconds)
    m (minutes)
    h (hours)

If you omit the suffix, the system interprets the value as nanoseconds.
interval 	no 	The length of time to wait between repetitions of the check. This field takes a positive integer and an optional suffix indicating the unit of time. Possible units are:

    ns (nanoseconds)
    us (microseconds)
    ms (milliseconds)
    s (seconds)
    m (minutes)
    h (hours)

If you omit the suffix, the system interprets the value as nanoseconds. The default value is 10 seconds if this field is omitted.
threshold 	no 	An integer specifying the number of times the check must fail before the check triggers an unhealthy state. If this filed is not specified, a single failure will trigger an unhealthy state.
tcp

tcp is a list of TCP addresses to be periodically checked with connection attempts. The addresses must include port numbers. If a connection attempt fails, the health check will fail.
Parameter 	Required 	Description
addr 	yes 	The TCP address to connect to, including a port number.
timeout 	no 	The length of time to wait before timing out the TCP connection. This field takes a positive integer and an optional suffix indicating the unit of time. Possible units are:

    ns (nanoseconds)
    us (microseconds)
    ms (milliseconds)
    s (seconds)
    m (minutes)
    h (hours)

If you omit the suffix, the system interprets the value as nanoseconds.
interval 	no 	The length of time to wait between repetitions of the check. This field takes a positive integer and an optional suffix indicating the unit of time. Possible units are:

    ns (nanoseconds)
    us (microseconds)
    ms (milliseconds)
    s (seconds)
    m (minutes)
    h (hours)

If you omit the suffix, the system interprets the value as nanoseconds. The default value is 10 seconds if this field is omitted.
threshold 	no 	An integer specifying the number of times the check must fail before the check triggers an unhealthy state. If this filed is not specified, a single failure will trigger an unhealthy state.
Proxy

proxy:
  remoteurl: https://registry-1.docker.io
  username: [username]
  password: [password]

Proxy enables a registry to be configured as a pull through cache to the official Docker Hub. See mirror for more information. Pushing to a registry configured as a pull through cache is currently unsupported.
Parameter 	Required 	Description
remoteurl 	yes 	The URL of the official Docker Hub
username 	no 	The username of the Docker Hub account
password 	no 	The password for the official Docker Hub account

To enable pulling private repositories (e.g. batman/robin) a username and password for user batman must be specified. Note: These private repositories will be stored in the proxy cache’s storage and relevant measures should be taken to protect access to this.
Compatibility

compatibility:
  schema1:
    signingkeyfile: /etc/registry/key.json
    disablesignaturestore: true

Configure handling of older and deprecated features. Each subsection defines a such a feature with configurable behavior.
Schema1
Parameter 	Required 	Description
signingkeyfile 	no 	The signing private key used for adding signatures to schema1 manifests. If no signing key is provided, a new ECDSA key will be generated on startup.
disablesignaturestore 	no 	Disables storage of signatures attached to schema1 manifests. By default signatures are detached from schema1 manifests, stored, and reattached when the manifest is requested. When this is true, the storage is disabled and a new signature is always generated for schema1 manifests using the schema1 signing key. Disabling signature storage will cause all newly uploaded signatures to be discarded. Existing stored signatures will not be removed but they will not be re-attached to the corresponding manifest.
Example: Development configuration

The following is a simple example you can use for local development:

version: 0.1
log:
  level: debug
storage:
    filesystem:
        rootdirectory: /var/lib/registry
http:
    addr: localhost:5000
    secret: asecretforlocaldevelopment
    debug:
        addr: localhost:5001

The above configures the registry instance to run on port 5000, binding to localhost, with the debug server enabled. Registry data storage is in the /var/lib/registry directory. Logging is in debug mode, which is the most verbose.

A similar simple configuration is available at config-example.yml. Both are generally useful for local development.
Example: Middleware configuration

This example illustrates how to configure storage middleware in a registry. Middleware allows the registry to serve layers via a content delivery network (CDN). This is useful for reducing requests to the storage layer.

Currently, the registry supports Amazon Cloudfront. You can only use Cloudfront in conjunction with the S3 storage driver.
Parameter 	Description
name 	The storage middleware name. Currently cloudfront is an accepted value.
disabled 	Set to false to easily disable the middleware.
options: 	A set of key/value options to configure the middleware.

    baseurl: The Cloudfront base URL.
    privatekey: The location of your AWS private key on the filesystem.
    keypairid: The ID of your Cloudfront keypair.
    duration: The duration in minutes for which the URL is valid. Default is 20.

The following example illustrates these values:

middleware:
    storage:
        - name: cloudfront
          disabled: false
          options:
             baseurl: http://d111111abcdef8.cloudfront.net
             privatekey: /path/to/asecret.pem
             keypairid: asecret
             duration: 60

    Note: Cloudfront keys exist separately to other AWS keys. See the documentation on AWS credentials for more information.

