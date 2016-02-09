.. -*- coding: utf-8 -*-
.. https://docs.docker.com/registry/deploying/
.. doc version: 1.9
.. check date: 2016/01/08

.. Deploying a registry server

.. _deploying-a-registry-server:

========================================
レジストリ・サーバのデプロイ
========================================

.. You need to install Docker version 1.6.0 or newer.

:doc:`Docker 1.6.0 以上のインストール </engine/installation/index>` が必要です。

.. Running on localhost

.. registry-running-on-localhost:

ローカルホストでレジストリを実行
========================================

.. Start your registry:

レジストリを開始します。

.. code-block:: bash

   docker run -d -p 5000:5000 --restart=always --name registry registry:2

.. You can now use it with docker.

これで Docker と使えるようになりました。

.. Get any image from the hub and tag it to point to your registry:

Docker Hub からイメージを手に入れ、自分のレジストリ上にタグ付けします。

.. code-block:: bash

   docker pull ubuntu && docker tag ubuntu localhost:5000/ubuntu

.. … then push it to your registry:

… それからイメージに送信します。

.. code-block:: bash

   docker push localhost:5000/ubuntu

.. … then pull it back from your registry:

… そして、レジストリから取得し直します。

.. code-block:: bash

   docker pull localhost:5000/ubuntu

.. To stop your registry, you would:

レジストリを停止するには、次のようにします。

.. code-block:: bash

   docker stop registry && docker rm -v registry

.. Storage

.. _registry-storage:

ストレージ
==========

.. By default, your registry data is persisted as a docker volume on the host filesystem. Properly understanding volumes is essential if you want to stick with a local filesystem storage.

デフォルトでは、ホスト・ファイルシステム上の :doc:`docker volume </engine/userguide/dockervolumes>` にレジストリのデータが保管されます。ローカル・ファイルシステムをストレージに使う場合は、ボリュームに対する適切な理解が必要です。

.. Specifically, you might want to point your volume location to a specific place in order to more easily access your registry data. To do so you can:

特に、レジストリのデータにより簡単にアクセスするため、ボリュームの場所を指定する場合があるでしょう。それには、次のように実行します。

.. code-block:: bash

   docker run -d -p 5000:5000 --restart=always --name registry \
     -v `pwd`/data:/var/lib/registry \
     registry:2

.. Alternatives

.. registry-storage-alternatives:

代替手段
----------

.. You should usually consider using another storage backend instead of the local filesystem. Use the storage configuration options to configure an alternate storage backend.

ローカル・ファイルシステムの替わりに、`他のストレージ・バックエンド <https://github.com/docker/distribution/blob/master/docs/storagedrivers.md>`_ の利用を考えても良いでしょう。 `ストレージの設定オプション <https://github.com/docker/distribution/blob/master/docs/configuration.md#storage>`_ で別のストレージ・バックエンドを設定できます。

.. Using one of these will allow you to more easily scale your registry, and leverage your storage redundancy and availability features.

これらのストレージを使うと、レジストリのスケールを簡単にし、ストレージの冗長性と可用性機能を活用できます。

.. Running a domain registry

.. _running-a-domain-registry:

ドメイン・レジストリの実行
==============================

.. While running on localhost has its uses, most people want their registry to be more widely available. To do so, the Docker engine requires you to secure it using TLS, which is conceptually very similar to configuring your web server with SSL.

``localhost`` 上で実行するだけでなく、多くの人はレジストリを広く使いたいと思うでしょう。実現するには、Docker エンジンで TLS を使って安全にする必要があります。TLS の概念はウェブサーバに SSL 設定をするのと非常に似ています。

.. Get a certificate

.. _get-a-certificate:

証明書の取得
--------------------

.. Assuming that you own the domain myregistrydomain.com, and that its DNS record points to the host where you are running your registry, you first need to get a certificate from a CA.

ここでは自分のドメインを ``myregistrydomain.com`` であると想定し、対象のレジストリ上のホストに対して DNS レコードが示されているものとします。まずは CA から証明書（certificate）を取得します。

.. Create a certs directory:

``certs`` ディレクトリを作成します。

.. code-block:: bash

   mkdir -p certs

.. Then move and/or rename your crt file to: certs/domain.crt, and your key file to: certs/domain.key.

それから、自分の crt ファイルを ``certs/domain.crt`` に移動・名称変更し、自分の鍵ファイルを ``certs/domain.key`` とします。

.. Make sure you stopped your registry from the previous steps, then start your registry again with TLS enabled:

次のステップに進む前にレジストリを停止します。それから、レジストリを TLS を有功にして再起動します。

.. code-block:: bash

   docker run -d -p 5000:5000 --restart=always --name registry \
     -v `pwd`/certs:/certs \
     -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
     -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
     registry:2

.. You should now be able to access your registry from another docker host:

これで他の Docker ホストから、レジストリに対して接続できるようになります。

.. code-block:: bash

   docker pull ubuntu
   docker tag ubuntu myregistrydomain.com:5000/ubuntu
   docker push myregistrydomain.com:5000/ubuntu
   docker pull myregistrydomain.com:5000/ubuntu

.. Gotcha

.. _ca-gotcha:

補足
----------

.. A certificate issuer may supply you with an intermediate certificate. In this case, you must combine your certificate with the intermediate’s to form a certificate bundle. You can do this using the cat command:

証明書の発行機関は *中間証明書（intermediate certificate）* を提供する場合があります。このような場合、証明書と中間証明書を１つのファイル形式にまとめる必要があります。作業は ``cat`` コマンドで行えます。

.. code-block:: bash

   cat domain.crt intermediate-certificates.pem > certs/domain.crt

.. Alternatives

.. _ca-alternatives:

別の方法
----------

.. While rarely advisable, you may want to use self-signed certificates instead, or use your registry in an insecure fashion. You will find instructions here.

まれにしかアドバイスしませんが、自己証明書を使いたい場合や、安全ではない方法でレジストリを動かしたいかもしれません。詳細は :doc:`こちら <insecure>` をご覧ください。

.. Load Balancing Considerations

.. _load-balancing-considerations:

負荷分散の検討
====================

.. One may want to use a load balancer to distribute load, terminate TLS or provide high availability. While a full load balancing setup is outside the scope of this document, there are a few considerations that can make the process smoother.

ロードバランサを使った負荷の分散を行う手法は、TLS を無効化しますが、高い可用性を提供します。負荷分散の設定の全般については、このドキュメントの範囲外です。ここでは手順をスムーズに進めるための検討事項を扱います。

.. The most important aspect is that a load balanced cluster of registries must share the same resources. For the current version of the registry, this means the following must be the same:

最も重要な点は、ロードバランサへのクラスタ登録には、同じ共通リソースが登録されている必要があります。つまり、現時点のレジストリのバージョンでは、以下の項目が同じでなくてはいけません。

..    Storage Driver
    HTTP Secret
    Redis Cache (if configured)

* ストレージ・ドライバ
* HTTP ソケット
* Redis キャッシュ（設定した場合は）

.. If any of these are different, the registry will have trouble serving requests. As an example, if you’re using the filesystem driver, all registry instances must have access to the same filesystem root, which means they should be in the same machine. For other drivers, such as s3 or azure, they should be accessing the same resource, and will likely share an identical configuration. The HTTP Secret coordinates uploads, so also must be the same across instances. Configuring different redis instances will work (at the time of writing), but will not be optimal if the instances are not shared, causing more requests to be directed to the backend.

もしも何かが違うと、レジストリはリクエストの処理で問題を起こします。たとえば、ファイルシステム・ドライバを使うときは、全てのレジストリ・インスタンスは同じファイルシステムのルートにアクセスできる必要があります。つまり、同じマシン上に存在する必要性を意味します。s3 や azure のような別のドライバの場合は、同じリソースにアクセスできるようにすべきであり、個々の設定を共有することになります。 *HTTP ソケット* コーディネートのアップロードを、同じインスタンス間で行う必要もあります。異なった redis インスタンスを設定しても動作しますが（この記事を書いている時点では）、最適ではありません。インスタンスが共有されないことで、バックエンドに対する多くの直接リクエストが発生するかもしれません。

.. Getting the headers correct is very important. For all responses to any request under the “/v2/” url space, the Docker-Distribution-API-Version header should be set to the value “registry/2.0”, even for a 4xx response. This header allows the docker engine to quickly resolve authentication realms and fallback to version 1 registries, if necessary. Confirming this is setup correctly can help avoid problems with fallback.

正常なヘッダを得ることは非常に重要です。全てのレスポンスに対するリクエストは「/v2/」url スペースの下で行われます。 ``Docker-Distribution-API-Version`` ヘッダに対する値は「registry/2.0」のような値であり、これは 4xx 系ノレスポンスと同等です。このヘッダにより、Docker エンジンは迅速に認証領域を確認でき、必要があればバージョン１のレジストリを無効化できます。

.. In the same train of thought, you must make sure you are properly sending the X-Forwarded-Proto, X-Forwarded-For and Host headers to their “client-side” values. Failure to do so usually makes the registry issue redirects to internal hostnames or downgrading from https to http.

一連の考えに於いて、ユーザは ``X-Forwarded-Proto, X-Forwarded-For`` と ``Hosts`` ヘッダに「クライアント側」の値を適切に送る必要があります。これがうまくいかないと、レジストリは内部のホスト名に対してリダイレクトされるか、https から http へといったダウングレードされてしまうでしょう。

.. A properly secured registry should return 401 when the “/v2/” endpoint is hit without credentials. The response should include a WWW-Authenticate challenge, providing guidance on how to authenticate, such as with basic auth or a token service. If the load balancer has health checks, it is recommended to configure it to consider a 401 response as healthy and any other as down. This will secure your registry by ensuring that configuration problems with authentication don’t accidentally expose an unprotected registry. If you’re using a less sophisticated load balancer, such as Amazon’s Elastic Load Balancer, that doesn’t allow one to change the healthy response code, health checks can be directed at “/”, which will always return a 200 OK response.

適切に安全に設定されたレジストリであれば、「/v2/」エンドポイントに証明書なくアクセスしようとしても、「401」を返します。この応答には ``WWW-Authenticate`` チャレンジを含んでおり、ベーシック認証やトークン・サービスといった認証のガイドラインを提供します。ロードバランサがヘルスチェックを持っていれば、401 レスポンスは正常であり、そのほかはダウンしているとみなすような設定をすることを推奨します。レジストリに対する設定を確実に行わないと、認証の問題によってレジストリが保護されず、晒されてしまう問題が起こり得ます。もしも Amazon の Elastic Load Balancer のような洗練されていないロードバランサを使う場合は、正常を示すレスポンス・コードを変更できません。ヘルスチェックは直接「/」をチェックするので、常に ``200 OK`` レスポンスを返すためです。

. . Restricting access

.. restricting-access:

アクセス制限
====================

.. Except for registries running on secure local networks, registries should always implement access restrictions.

安全なローカルのネットワーク上でレジストリを動かす場合を除き、レジストリは常にアクセス制御を実装したほうが良いでしょう。

.. Native basic auth

.. _native-basic-auth:

内蔵のベーシック認証
--------------------

.. The simplest way to achieve access restriction is through basic authentication (this is very similar to other web servers’ basic authentication mechanism).

アクセス制限を行うのに一番簡単な方法は、ベーシック認証を通す方法です（これはウェブサーバのベーシック認証の仕組みと非常に似ています）。

..    Warning: You cannot use authentication with an insecure registry. You have to configure TLS first for this to work.

.. warning::

   安全ではないレジストリ（insecure registry）では認証が **使えません** 。動作のためには :ref:`TLS の設定を第一に <running-a-domain-registry>`  行う必要があります。

.. First create a password file with one entry for the user “testuser”, with password “testpassword”:

まずはパスワード・ファイルを作成し、ユーザ「testuesr」、パスワード「testpasswrod」のエントリを1行追加します。

.. code-block:: bash

   mkdir auth
   docker run --entrypoint htpasswd registry:2 -Bbn testuser testpassword > auth/htpasswd

.. Make sure you stopped your registry from the previous step, then start it again:

次の手順に進む前に、レジストリを一度停止します。それから再起動します。

.. code-block:: bash

   docker run -d -p 5000:5000 --restart=always --name registry \
     -v `pwd`/auth:/auth \
     -e "REGISTRY_AUTH=htpasswd" \
     -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
     -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
     -v `pwd`/certs:/certs \
     -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
     -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
     registry:2

.. You should now be able to:

これで、次のように実行できます。

.. code-block:: bash

   docker login myregistrydomain.com:5000

.. And then push and pull images as an authenticated user.

あとは、認証されたユーザがイメージの送信・受信ができます。

.. Gotcha

.. _access-gotcha:

捕捉
----------

.. Seeing X509 errors is usually a sign you are trying to use self-signed certificates, and failed to configure your docker daemon properly.

X509 エラーが表示されるのは、たいて自己署名した証明書を使おうとしている場合です。 :doc:`docker デーモンを適切に設定する <insecure>` のに失敗しています。

.. Alternatives

.. _access-alternatives:

別の方法
----------

..    You may want to leverage more advanced basic auth implementations through a proxy design, in front of the registry. You will find examples of such patterns in the recipes list.

1. レジストリの前にプロキシがあるよう設計されたネットワークでも、ベーシック認証を通過できるようにしたいと思うでしょう。このようなパターンには、 :doc:`レシピ例 <recipes>` をご覧ください。

..    Alternatively, the Registry also supports delegated authentication, redirecting users to a specific, trusted token server. That approach requires significantly more investment, and only makes sense if you want to fully configure ACLs and more control over the Registry integration into your global authorization and authentication systems.

2. あるいは、レジストリが delegated 認証をサポートしている場合は、特定のユーザを信頼されたトークンを持つサーバに転送します。この手法は投資がとりわけ必要であり、完全に ACL を設定したい場合や、認証システム全体と認証システムを通してレジストリを統合したい場合に役立つでしょう。

.. You will find background information here, and configuration information here.

:doc:`バックグラウンドの情報についてはこちら </registry/spec/auth/token>` から、:ref:`設定情報の詳細はこちら <configuration-auth>` から参照できます。

.. Beware that you will have to implement your own authentication service for this to work, or leverage a third-party implementation.

認証サービスやサードパーティー製の機能を活用するには、自分自身で実装する必要があるのをご注意ください。

.. Managing with Compose

.. _managing-with-compose:

Dockre Compose で管理
==============================

.. As your registry configuration grows more complex, dealing with it can quickly become tedious.

レジストリの設定がより複雑になると、非常に退屈なものになってしまいます。

.. It’s highly recommended to use Docker Compose to facilitate operating your registry.

レジストリの操作を簡単にするのに、 :doc:`Docker Compose </compose/index>` を使うことを推奨します。

.. Here is a simple docker-compose.yml example that condenses everything explained so far:

以下は簡単な ``docker-compose.yml`` 例であり、必要なもの全てが凝縮されています。

.. code-block:: yaml

   registry:
     restart: always
     image: registry:2
     ports:
       - 5000:5000
     environment:
       REGISTRY_HTTP_TLS_CERTIFICATE: /certs/domain.crt
       REGISTRY_HTTP_TLS_KEY: /certs/domain.key
       REGISTRY_AUTH: htpasswd
       REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
       REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
     volumes:
       - /path/data:/var/lib/registry
       - /path/certs:/certs
       - /path/auth:/auth

..     Warning: replace /path by whatever directory that holds your certs and auth folder from above.

.. warning::

   ``/path`` のディレクトリ部分は、先ほど ``certs`` と ``auth`` を置いた場所に置き換えてください。

.. You can then start your registry with a simple

レジストリの起動はとてもシンプルです。

.. code-block:: bash

   docker-compose up -d

.. Next

次へ
==========

.. You will find more specific and advanced informations in the following sections:

以下のセクションで、より詳細かつ高度な情報をご覧いただけます。

..    Configuration reference
    Working with notifications
    Advanced “recipes”
    Registry API
    Storage driver model
    Token authentication

* :doc:`index`
* :doc:`notifications`
* :doc:`recipes`
* :doc:`spec/api`
* :doc:`storagedrivers`
* :doc:`spec/auth/tokens`

