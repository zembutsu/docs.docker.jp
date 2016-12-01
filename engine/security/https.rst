.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/security/https/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/security/https.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/security/https.md
.. check date: 2016/06/14
.. Commits on Jun 2, 2016 c1be45fa38e82054dcad606d71446a662524f2d5
.. -------------------------------------------------------------------

.. Protect the Docker daemon socket

=======================================
Docker デーモンのソケットを守る
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. By default, Docker runs via a non-networked Unix socket. It can also optionally communicate using an HTTP socket.

デフォルトでは、ネットワークを通さない Unix ソケットで Docker を操作します。オプションで HTTP ソケットを使った通信も可能です。

.. If you need Docker to be reachable via the network in a safe manner, you can enable TLS by specifying the tlsverify flag and pointing Docker’s tlscacert flag to a trusted CA certificate.

Docker をネットワーク上で安全な方法で使う必要があるなら、TLS を有効にすることもできます。そのためには、 ``tlsverify`` フラグの指定と、 ``tlscacert`` フラグで信頼できる CA 証明書を  Docker に示す必要があります。

.. In the daemon mode, it will only allow connections from clients authenticated by a certificate signed by that CA. In the client mode, it will only connect to servers with a certificate signed by that CA.

デーモン・モードでは、その CA で署名された証明書を使うクライアントのみ接続可能にします。クライアント・モードでは、その CA で署名されたサーバのみ接続可能にします。

..    Warning: Using TLS and managing a CA is an advanced topic. Please familiarize yourself with OpenSSL, x509 and TLS before using it in production.

.. warning::

   TLS と CA の管理は高度なトピックです。プロダクションで使う前に、自分自身で OpenSSL、x509、TLS に慣れてください。

..    Warning: These TLS commands will only generate a working set of certificates on Linux. Mac OS X comes with a version of OpenSSL that is incompatible with the certificates that Docker requires.

.. warning::

   各 TLS コマンドは Linux 上で作成された証明書のセットのみ利用可能です。Mac OS X は Docker デーモンが必要な OpenSSL のバージョンと互換性がありません。

.. Create a CA, server and client keys with OpenSSL

OpenSSL で CA （サーバとクライアントの鍵）を作成
==================================================

..    Note: replace all instances of $HOST in the following example with the DNS name of your Docker daemon’s host.

.. note::

   以下の例にある ``$HOST`` は、自分の Docker デーモンが動いている DNS ホスト名に置き換えてください。

.. First generate CA private and public keys:

まず、CA 秘密鍵と公開鍵を作成します。

.. code-block:: bash

   $ openssl genrsa -aes256 -out ca-key.pem 4096
   Generating RSA private key, 4096 bit long modulus
   ............................................................................................................................................................................................++
   ........++
   e is 65537 (0x10001)
   Enter pass phrase for ca-key.pem:
   Verifying - Enter pass phrase for ca-key.pem:
   $ openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem
   Enter pass phrase for ca-key.pem:
   You are about to be asked to enter information that will be incorporated
   into your certificate request.
   What you are about to enter is what is called a Distinguished Name or a DN.
   There are quite a few fields but you can leave some blank
   For some fields there will be a default value,
   If you enter '.', the field will be left blank.
   -----
   Country Name (2 letter code) [AU]:
   State or Province Name (full name) [Some-State]:Queensland
   Locality Name (eg, city) []:Brisbane
   Organization Name (eg, company) [Internet Widgits Pty Ltd]:Docker Inc
   Organizational Unit Name (eg, section) []:Sales
   Common Name (e.g. server FQDN or YOUR name) []:$HOST
   Email Address []:Sven@home.org.au

.. Now that we have a CA, you can create a server key and certificate signing request (CSR). Make sure that “Common Name” (i.e., server FQDN or YOUR name) matches the hostname you will use to connect to Docker:

これで CA を手に入れました。サーバ鍵（server key）と証明書署名要求（CSR; certificate signing request）を作成しましょう。接続先の Docker ホスト名が **Common Name** （例：サーバの FQDN や自分自身の名前）に一致しているのを確認します。

..    Note: replace all instances of $HOST in the following example with the DNS name of your Docker daemon’s host.

.. note::

   以下の例にある ``$HOST`` は、自分の Docker デーモンが動いている DNS ホスト名に置き換えてください。

.. code-block:: bash

   $ openssl genrsa -out server-key.pem 4096
   Generating RSA private key, 4096 bit long modulus
   .....................................................................++
   .................................................................................................++
   e is 65537 (0x10001)
   $ openssl req -subj "/CN=$HOST" -sha256 -new -key server-key.pem -out server.csr

.. Next, we’re going to sign the public key with our CA:

次に公開鍵を CA で署名しましょう。

.. Since TLS connections can be made via IP address as well as DNS name, they need to be specified when creating the certificate. For example, to allow connections using 10.10.10.20 and 127.0.0.1:

TLS 接続は DNS 名と同様に、IP アドレスでも通信可能にできます。その場合は、証明書に情報を追加する必要があります。例えば、 ``10.10.10.20`` と ``127.0.0.1`` を使う場合は次のようにします。

.. code-block:: bash

   $ echo subjectAltName = IP:10.10.10.20,IP:127.0.0.1 > extfile.cnf
   
   $ openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \
  -CAcreateserial -out server-cert.pem -extfile extfile.cnf
   Signature ok
   subject=/CN=your.host.com
   Getting CA Private Key
   Enter pass phrase for ca-key.pem:

.. For client authentication, create a client key and certificate signing request:

クライアント認証用に、クライアント鍵と証明書署名要求を作成します。

.. code-block:: bash

   $ openssl genrsa -out key.pem 4096
   Generating RSA private key, 4096 bit long modulus
   .........................................................++
   ................++
   e is 65537 (0x10001)
   $ openssl req -subj '/CN=client' -new -key key.pem -out client.csr

.. To make the key suitable for client authentication, create an extensions config file:

クライアント認証用の鍵を実装するには、追加設定ファイルを作成します。

.. code-block:: bash

   $ echo extendedKeyUsage = clientAuth > extfile.cnf

.. Now sign the public key:

次は公開鍵に署名します。

.. code-block:: bash

   $ openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem \
     -CAcreateserial -out cert.pem -extfile extfile.cnf
   Signature ok
   subject=/CN=client
   Getting CA Private Key
   Enter pass phrase for ca-key.pem:

.. After generating cert.pem and server-cert.pem you can safely remove the two certificate signing requests:

``cert.pem`` と ``server-cert.pem`` を生成したら、証明書署名要求を安全に削除できます。

.. code-block:: bash

   $ rm -v client.csr server.csr

..    With a default umask of 022, your secret keys will be world-readable and writable for you and your group.

デフォルトの ``umask`` は 022 のため、秘密鍵は自分と同じグループから読み書き可能です。

..    In order to protect your keys from accidental damage, you will want to remove their write permissions. To make them only readable by you, change file modes as follows:

何らかのアクシデントから自分の鍵を守るため、書き込みパーミッションを削除します。自分だけしか読み込めないようにするには、ファイルモードを次のように変更します。

.. code-block:: bash

   $ chmod -v 0400 ca-key.pem key.pem server-key.pem

.. Certificates can be world-readable, but you might want to remove write access to prevent accidental damage:

証明書は誰でも読み込めても問題ありませんが、予期しないアクシデントによる影響を避けるため、書き込み権限を削除します。

.. code-block:: bash

   $ chmod -v 0444 ca.pem server-cert.pem cert.pem

.. Now you can make the Docker daemon only accept connections from clients providing a certificate trusted by our CA:

あとは Docker デーモンを、自分たちの CA を使って署名した信頼できるクライアントしか接続できないようにします。

.. code-block:: bash

   $ docker daemon --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem \
     -H=0.0.0.0:2376

.. To be able to connect to Docker and validate its certificate, you now need to provide your client keys, certificates and trusted CA:

これは Docker に接続する時、証明書の認証を必要とするものです。認証には先ほどのクライアント鍵、証明書、信頼できる CA を使います。

..     Note: replace all instances of $HOST in the following example with the DNS name of your Docker daemon’s host.

.. note:

   以下の例にある ``$HOST`` は、自分の Docker デーモンが動いている DNS ホスト名に置き換えてください。


.. code-block:: bash

   $ docker --tlsverify --tlscacert=ca.pem --tlscert=cert.pem --tlskey=key.pem \
     -H=$HOST:2376 version

..    Note: Docker over TLS should run on TCP port 2376.

.. note:
   Docker ove TLS は、TCP ポート 2376 で実行すべきです。

..    Warning: As shown in the example above, you don’t have to run the docker client with sudo or the docker group when you use certificate authentication. That means anyone with the keys can give any instructions to your Docker daemon, giving them root access to the machine hosting the daemon. Guard these keys as you would a root password!

.. warning::

   上記の例では ``docker`` クライアントの実行に ``sudo`` が不要か、あるいは認証に使うユーザが ``docker`` グループに属しています。つまり、鍵を使ってDocker デーモンにアクセス可能にするとは、デーモンを動かしているマシンの root 権限を与えるのを意味します。これらの鍵は root パスワード同様に保護してください！

.. Secure by default

デフォルトで安全に
====================

.. If you want to secure your Docker client connections by default, you can move the files to the .docker directory in your home directory -- and set the DOCKER_HOST and DOCKER_TLS_VERIFY variables as well (instead of passing -H=tcp://$HOST:2376 and --tlsverify on every call).

Docker クライアントの接続をデフォルトで安全にしたい場合は、自分のホームディレクトリ直下の ``.docker`` ディレクトリにファイルを移動できます。そして、環境変数 ``DOCKER_HOST`` と ``DOCKER_TLS_VERIFY`` を使います（ 毎回 ``-H=tcp://$HOST;2376`` や ``--tlsverify`` を実行する代わりになります ）。

.. code-block:: bash

   $ mkdir -pv ~/.docker
   $ cp -v {ca,cert,key}.pem ~/.docker
   $ export DOCKER_HOST=tcp://$HOST:2376 DOCKER_TLS_VERIFY=1

.. Docker will now connect securely by default:

こうしておけば、デフォルトで Docker は安全に接続しています。

.. code-block:: bash

   $ docker ps

.. Other modes

他のモード
==========

.. If you don’t want to have complete two-way authentication, you can run Docker in various other modes by mixing the flags.

双方向認証を有効にしたくない場合、他のフラグと組みあわせて Docker を実行できます。

.. Daemon modes

デーモン・モード
--------------------

..    tlsverify, tlscacert, tlscert, tlskey set: Authenticate clients
    tls, tlscert, tlskey: Do not authenticate clients

* ``tlsverify`` 、 ``tlscacert`` 、 ``lscert`` 、 ``tlskey`` をセット：クライアントを認証する
* ``tls`` 、``tlscert`` 、``tlskey`` ：クライアントを認証しない

.. Client modes

クライアント・モード
--------------------

..    tls: Authenticate server based on public/default CA pool
    tlsverify, tlscacert: Authenticate server based on given CA
    tls, tlscert, tlskey: Authenticate with client certificate, do not authenticate server based on given CA
    tlsverify, tlscacert, tlscert, tlskey: Authenticate with client certificate and authenticate server based on given CA

* ``tls``：サーバをベースとした公開/デフォルト CA プールで認証
* ``tlsverify`` 、 ``tlscacert`` ：サーバをベースとした CA 認証
* ``tls`` 、``tlscert`` 、 ``tlskey`` ：クライアント認証を使い、サーバ側を指定した CA では認証しない
* ``tlsverify`` 、``tlscacert`` 、 ``tlscert`` 、 ``tlskey`` ：クライアント証明書と、サーバ側で指定した CA で認証する

.. If found, the client will send its client certificate, so you just need to drop your keys into ~/.docker/{ca,cert,key}.pem. Alternatively, if you want to store your keys in another location, you can specify that location using the environment variable DOCKER_CERT_PATH.

クライアントがクライアント証明書を送信したら、自分の鍵を ``~/.docker/{ca,cert,key}.pem`` に移動します。あるいは、別の場所に保管し、環境変数 ``DOCKER_CERT_PATH`` でも指定できます。

.. code-block:: bash

   $ export DOCKER_CERT_PATH=~/.docker/zone1/
   $ docker --tlsverify ps

.. Connecting to the secure Docker port using curl

``curl`` を使って Docker ポートに安全に接続
--------------------------------------------------

.. To use curl to make test API requests, you need to use three extra command line flags:

``curl`` を API リクエストのテストに使うには、コマンドラインで３つの追加フラグが必要です。

.. code-block:: bash

   $ curl https://$HOST:2376/images/json \
     --cert ~/.docker/cert.pem \
     --key ~/.docker/key.pem \
     --cacert ~/.docker/ca.pem


関連情報
==========

..    Using certificates for repository client verification
    Use trusted images

* :doc:`certificates`
* :doc:`trust/index`

.. seealso:: 

   Protect the Docker daemon socket
      https://docs.docker.com/engine/security/https/
