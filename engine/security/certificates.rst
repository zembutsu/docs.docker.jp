.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/security/certificates/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/security/certificates.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/security/certificates.md
.. check date: 2016/06/14
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. -------------------------------------------------------------------

.. Using certificates for repository client verification

.. _using-certificates-for-repository-client-verification:

==================================================
証明書をリポジトリのクライアント認証に使用
==================================================

.. In Running Docker with HTTPS, you learned that, by default, Docker runs via a non-networked Unix socket and TLS must be enabled in order to have the Docker client and the daemon communicate securely over HTTPS. TLS ensures authenticity of the registry endpoint and that traffic to/from registry is encrypted.

:doc:`Docker を HTTPS で動かす <https>` 方法を学びました。デフォルトでは Docker はネットワークで使えない Unix ソケットについてと、Docker クライアントとデーモンが安全に通信できるように、 HTTPS 上で TLS を有効化すべきという内容でした。TLS はレジストリのエンドポイントにおける認証を確実なものとし、かつ、レジストリからあるいはレジストリへの通信を暗号化します。

.. This article demonstrates how to ensure the traffic between the Docker registry (i.e., a server) and the Docker daemon (i.e., a client) traffic is encrypted and a properly authenticated using certificate-based client-server authentication.

このページでは、Docker レジストリ（例：サーバ）と Docker デーモン（例：クライアント）間でのトラフィックを暗号化する方法と、証明書をベースとしたクライアント・サーバ認証の仕方を扱います。

.. We will show you how to install a Certificate Authority (CA) root certificate for the registry and how to set the client TLS certificate for verification.

認証局（CA; Certificate Authority）のルート証明書をレジストリに設定する方法と、クライアント側で TLS 証明書を使って認証する方法を紹介します。

.. Understanding the configuration

.. _understanding-the-configuration:

設定の理解
==========

.. A custom certificate is configured by creating a directory under /etc/docker/certs.d using the same name as the registry’s hostname (e.g., localhost). All *.crt files are added to this directory as CA roots.

任意の証明書を使うように設定するには、 ``/etc/docker/certs.d`` ディレクトリの下に、レジストリのホスト名と同じ名前のディレクトリ（例： ``localhost`` ）を作成します。このディレクトリを CA ルートとして、全ての ``*.crt`` ファイルを追加します。

..    Note: In the absence of any root certificate authorities, Docker will use the system default (i.e., host’s root CA set).

.. note::

   認証に関する root 証明書が足りなければ、Docker はシステムのデフォルトを使います（例： ホスト側のルート CA セット）。

.. The presence of one or more <filename>.key/cert pairs indicates to Docker that there are custom certificates required for access to the desired repository.

任意のリポジトリにアクセスするには、Docker が１つ以上の ``<ファイル名>.key/cert`` のセットを認識する必要があります。

..    Note: If there are multiple certificates, each will be tried in alphabetical order. If there is an authentication error (e.g., 403, 404, 5xx, etc.), Docker will continue to try with the next certificate.

.. note::

   複数の証明書があれば、アルファベット順で処理を行います。もし、認証エラー（例： 403、404、5xx、等）があれば、次の証明書で処理を試みます。

.. The following illustrates a configuration with multiple certs:

以下は、複数の証明書がある場合の設定です。

.. code-block:: bash

       /etc/docker/certs.d/        <-- 証明書のディレクトリ
       └── localhost               <-- ホスト名
          ├── client.cert          <-- クライアントの証明書（certificate）
          ├── client.key           <-- クライアント鍵
          └── localhost.crt        <-- 認証局によるレジストリ証明書への署名

.. The preceding example is operating-system specific and is for illustrative purposes only. You should consult your operating system documentation for creating an os-provided bundled certificate chain.

なお、この例は典型的なオペレーティング・システム上で使う場合を想定したものです。OS が提供する証明書チェーン作成に関するドキュメントを確認すべきでしょう。

.. Creating the client certificates

.. _creating-the-client-certificates:

クライアント証明書の作成
==============================

.. You will use OpenSSL’s genrsa and req commands to first generate an RSA key and then use the key to create the certificate.

まず、OpenSSL の ``genrsa`` と ``req`` コマンドを使って RSA 鍵を生成し、それを証明書の作成に使います。

.. code-block:: bash

   $ openssl genrsa -out client.key 4096
   $ openssl req -new -x509 -text -key client.key -out client.cert

..    Note: These TLS commands will only generate a working set of certificates on Linux. The version of OpenSSL in Mac OS X is incompatible with the type of certificate Docker requires.

.. note::

   これらの TLS コマンドが生成する証明書は、Linux 上で動作するものです。Mac OS X に含まれている OpenSSL のバージョンでは、Docker が必要とする証明書のタイプと互換性はありません。

.. Troubleshooting tips

上手くいかない場合の確認点
==============================

.. The Docker daemon interprets `.crt files as CA certificates and .cert files as client certificates. If a CA certificate is accidentally given the extension .cert instead of the correct .crt extension, the Docker daemon logs the following error message:

Docker デーモンは ``.crt`` ファイルを CA 証明書として認識し、 ``.cert`` ファイルをクライアント証明書として認識します。CA 証明書が正しい ``.crt`` 拡張子ではなく ``.cert`` 拡張子になれば、Docker デーモンは次のようなエラーメッセージをログに残します。

.. code-block:: bash

   Missing key KEY_NAME for client certificate CERT_NAME. Note that CA certificates should use the extension .crt.

.. Related Information

関連情報
==========

..    Use trusted images
    Protect the Docker daemon socket

* :doc:`trust/index`
* :doc:`https`

