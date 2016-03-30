.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/registry/recipes/nginx/
.. SOURCE: -
   doc version: 1.10
.. check date: 2016/03/12
.. -------------------------------------------------------------------

.. Authenticating proxy with nginx

.. _authenticating-proxy-with-nginx:

========================================
Nginx を認証プロキシとして使う
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Use-case

使用例
==========

.. People already relying on an apache proxy to authenticate their users to other services might want to leverage it and have Registry communications tunneled through the same pipeline.

皆さんの中には、サービスを使うユーザの認証のために Apache のプロキシ機能を利用しているケースもあるでしょう。そして、そうなら更に活用したいと思うかもしれません。Registry で同じ処理系（パイプライン）を通して通信させることができます。

.. Usually, that includes enterprise setups using LDAP/AD on the backend and a SSO mechanism fronting their internal http portal.

エンタープライズの環境であれば、通常はバックエンドに LDAP やアクティブ・ディレクトリを使うか、内部の http ポータルで SSO （シングル・サインオン）の仕組みを使うでしょう。

.. Alternatives

あるいは
----------

.. If you just want authentication for your registry, and are happy maintaining users access separately, you should really consider sticking with the native basic auth registry feature.

自分の Registry に認証が必要になったときや、ユーザのアクセスを分けてメンテナンスを楽にしたい場合は、内部実装されている :ref:`ベーシック認証レジストリ機能 <native-basic-auth>` の利用を検討するでしょう。

.. Solution

解決策
----------

.. With the method presented here, you implement basic authentication for docker engines in a reverse proxy that sits in front of your registry.

この課題に対応するため、ここでは Docker Engine にリバース・プロキシを通したベーシック認証機能を実装します。これには Registry の前にリバース・プロキシをおきます。

.. While we use a simple htpasswd file as an example, any other apache authentication backend should be fairly easy to implement once you are done with the example.

今回のサンプルでは簡単な htpasswd ファイルを使います。もしも他の Apache 認証バックエンドの実装になれているのであれば、今回のサンプル同様、簡単に実装できるでしょう。

.. We also implement push restriction (to a limited user group) for the sake of the example. Again, you should modify this to fit your mileage.

また、push を制限（ユーザやグループの制限）する実装も可能です。そのような場合も、このサンプルを目的に合わせて書き換えるだけで実現できるでしょう。


.. Gotchas

捕捉
----------

.. While this model gives you the ability to use whatever authentication backend you want through the secondary authentication mechanism implemented inside your proxy, it also requires that you move TLS termination from the Registry to the proxy itself.

このモデルは、自分が使いたい何らかのバックエンド機構をプロキシとして使えることをも意味します。また、その場合には自分自身で Registry をプロキシの TLS 末端に移動する必要があります。

.. Furthermore, introducing an extra http layer in your communication pipeline will make it more complex to deploy, maintain, and debug, and will possibly create issues. Make sure the extra complexity is required.

それだけではありません。何らかの http 通信パイプラインを導入することで、更に複雑なデプロイ、メンテナンス、デバッグなど、様々な問題に対処できるでしょう。そのためには、外部との互換性が必要になります。

.. For instance, Amazon’s Elastic Load Balancer (ELB) in HTTPS mode already sets the following client header:

例えば、Amazon Elastic Load Balancer (ELB) の HTTPS 状態では、既に以下のヘッダが追加されています。

::

   X-Real-IP
   X-Forwarded-For
   X-Forwarded-Proto

.. So if you have an nginx sitting behind it, should remove these lines from the example config below:

そのため、この背後に Nginx を設定する場合は、サンプル設定から以下の設定を削除する必要があるでしょう。

::

   X-Real-IP         $remote_addr; # pass on real client's IP
   X-Forwarded-For   $proxy_add_x_forwarded_for;
   X-Forwarded-Proto $scheme;

.. Otherwise nginx will reset the ELB’s values, and the requests will not be routed properly. For more information, see #970.

Nginx が ELB の設定をリセットすると、正常に動作しなくなる場合があります。詳しい情報は `#970 <https://github.com/docker/distribution/issues/970>`_ をご覧ください。

.. Setting things up

セットアップ
====================

.. Read again the requirements.

:ref:`registry-requirements` をもう一度お読みください。

.. Ready?

準備はできましたか？

.. Run the following script:

--

必要なディレクトリを作成します。

.. code-block:: bash

   mkdir -p auth
   mkdir -p data

メインで使う Nginx 設定ファイルを作成します。

.. code-block:: bash

   cat <<EOF > auth/nginx.conf
   events {
       worker_connections  1024;
   }
   
   http {
     
     upstream docker-registry {
       server registry:5000;
     }
   
     ## Set a variable to help us decide if we need to add the
     ## 'Docker-Distribution-Api-Version' header.
     ## The registry always sets this header.
     ## In the case of nginx performing auth, the header will be unset
     ## since nginx is auth-ing before proxying.
     map \$upstream_http_docker_distribution_api_version \$docker_distribution_api_version {
       'registry/2.0' '';
       default registry/2.0;
     }
   
     server {
       listen 443 ssl;
       server_name myregistrydomain.com;
   
       # SSL
       ssl_certificate /etc/nginx/conf.d/domain.crt;
       ssl_certificate_key /etc/nginx/conf.d/domain.key;
     
       # Recommendations from https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html
       ssl_protocols TLSv1.1 TLSv1.2;
       ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
       ssl_prefer_server_ciphers on;
       ssl_session_cache shared:SSL:10m;
     
       # disable any limits to avoid HTTP 413 for large image uploads
       client_max_body_size 0;
     
       # required to avoid HTTP 411: see Issue #1486 (https://github.com/docker/docker/issues/1486)
       chunked_transfer_encoding on;
     
       location /v2/ {
         # Do not allow connections from docker 1.5 and earlier
         # docker pre-1.6.0 did not properly set the user agent on ping, catch "Go *" user agents
         if (\$http_user_agent ~ "^(docker\/1\.(3|4|5(?!\.[0-9]-dev))|Go ).*\$" ) {
           return 404;
         }
     
         # To add basic authentication to v2 use auth_basic setting.
         auth_basic "Registry realm";
         auth_basic_user_file /etc/nginx/conf.d/nginx.htpasswd;
     
         ## If $docker_distribution_api_version is empty, the header will not be added.
         ## See the map directive above where this variable is defined.
         add_header 'Docker-Distribution-Api-Version' \$docker_distribution_api_version always;
     
         proxy_pass                          http://docker-registry;
         proxy_set_header  Host              \$http_host;   # required for docker client's sake
         proxy_set_header  X-Real-IP         \$remote_addr; # pass on real client's IP
         proxy_set_header  X-Forwarded-For   \$proxy_add_x_forwarded_for;
         proxy_set_header  X-Forwarded-Proto \$scheme;
         proxy_read_timeout                  900;
       }
     }
   }
   EOF

.. Now create a password file for “testuser” and “testpassword”

次は「testuser」と「testpassword」を使うパスワード・ファイルを作成します。

.. code-block:: bash

   docker run --rm --entrypoint htpasswd registry:2 -bn testuser testpassword > auth/nginx.htpasswd

.. Copy over your certificate files

証明書用のファイルをコピーします。

.. code-block:: bash

   cp domain.crt auth
   cp domain.key auth

.. Now create your compose file

Compose ファイルを新規作成します。

.. code-block:: bash

   cat <<EOF > docker-compose.yml
   nginx:
     image: "nginx:1.9"
     ports:
       - 5043:443
     links:
       - registry:registry
     volumes:
       - ./auth:/etc/nginx/conf.d
       - ./auth/nginx.conf:/etc/nginx/nginx.conf:ro
   
   registry:
     image: registry:2
     ports:
       - 127.0.0.1:5000:5000
     volumes:
       - `pwd`./data:/var/lib/registry
   EOF


.. Starting and stopping

開始と停止
==========

.. Now, start your stack:

それでは、スタックを起動しましょう。

.. code-block:: bash

   docker-compose up -d

.. Login with a “push” authorized user (using testuserpush and testpasswordpush), then tag and push your first image:

「push」するために認証されたユーザ（ ``testuserpush`` と ``testpasswordpush`` を使います）でログインします。それから皆さんのイメージをタグ付けして push します。

.. code-block:: bash

   docker login -p=testuser -u=testpassword -e=root@example.ch myregistrydomain.com:5043
   docker tag ubuntu myregistrydomain.com:5043/test
   docker push myregistrydomain.com:5043/test
   docker pull myregistrydomain.com:5043/test

.. seealso:: 

   Authenticating proxy with nginx
      https://docs.docker.com/registry/nginx/

