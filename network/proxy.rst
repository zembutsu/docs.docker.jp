.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/network/proxy/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/network/proxy.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Jul 1, 2021 9bc2f59d53bb01c16409b180b3a57d31f6acf02a
.. ---------------------------------------------------------------------------

.. Configure Docker to use a proxy server
.. _configure-docker-to-use-a-proxy-server:

========================================
プロキシサーバを使うように Docker を設定
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. If your container needs to use an HTTP, HTTPS, or FTP proxy server, you can configure it in different ways:

コンテナで HTTP、HTTPS、FTP プロキシサーバが必要な場合、異なる方法で設定できます。

..    In Docker 17.07 and higher, you can configure the Docker client to pass proxy information to containers automatically.

* Docker 17.07 以上では、 :ref:`Docker クライアントを設定 <proxy-configure-the-docker-client>` して、自動的にコンテナにプロキシ情報を渡せます。

..    In Docker 17.06 and earlier versions, you must set the appropriate environment variables within the container. You can do this when you build the image (which makes the image less portable) or when you create or run the container.

* Docker 17.06 以下のバージョンでは、コンテナ内で適切な :ruby:`環境変数 <proxy-use-environment-variables>` の設定が必要です。そのためには、イメージ構築時（イメージの :ruby:`移植性 <portable>` が下がります）か、コンテナの作成もしくは実行時に行います。

.. Configure the Docker client
.. _proxy-configure-the-docker-client:
Docker クライアントの設定
==============================

.. On the Docker client, create or edit the file ~/.docker/config.json in the home directory of the user that starts containers. Add JSON similar to the following example. Substitute the type of proxy with httpsProxy or ftpProxy if necessary, and substitute the address and port of the proxy server. You can also configure multiple proxy servers simultaneously.

1. Docker クライアント上では、ユーザのホームディレクトリ内で ``~/.docker/config.json`` ファイルを作成・編集します。以下の例のような JSON を追加します。必要があれば、プロキシのタイプとして ``httpsProxy`` や ``ftpProxy`` に置き換えます。さらに、プロキシサーバのアドレスやポート番号も置き換えます。また、同時に複数のプロキシサーバも設定できます。

   .. You can optionally exclude hosts or ranges from going through the proxy server by setting a noProxy key to one or more comma-separated IP addresses or hosts. Using the * character as a wildcard for hosts and using CIDR notation for IP addresses is supported as shown in this example:

   オプションでホストや範囲をプロキシサーバの設定を通して除外できます。 ``noProxy`` キーの設定で、1つまたは複数のカンマ区切りの IP アドレスやホストを追加します。 以下の例にあるように、ホストと IP アドレスの CIDR 記法を使う時に、 ``*`` 文字の利用がサポートされています。

   .. code-block:: json

      {
       "proxies":
       {
         "default":
         {
           "httpProxy": "http://192.168.1.12:3128",
           "httpsProxy": "http://192.168.1.12:3128",
           "noProxy": "*.test.example.com,.example2.com,127.0.0.0/8"
         }
       }
      }

   .. Save the file.
   ファイルを保存します。

..    When you create or start new containers, the environment variables are set automatically within the container.

2. 新しいコンテナの作成もしくは起動時に、環境変数はコンテナ内へ自動的に設定されます。

.. Use environment variables
.. _proxy-use-environment-variables:
環境変数を使う
====================

.. Set the environment variables manually
.. _proxy-set-the-environment-variables-manually:
環境変数を手動で設定
------------------------------

.. When you build the image, or using the --env flag when you create or run the container, you can set one or more of the following variables to the appropriate value. This method makes the image less portable, so if you have Docker 17.07 or higher, you should configure the Docker client instead.

イメージの構築時、あるいは、コンテナの作成・実行時に ``--env`` フラグを使う場合、以下の1つまたは複数の変数と、適切な値を指定できます。この手法はイメージの移植性を減少します。そのため、 Docker 17.07 以上であれば、 :ref:`Docker クライアントの設定 <proxy-configure-the-docker-client>` を使うべきです。

.. list-table::
   :header-rows: 1

   * - 変数
     - Dockerfile 例
     - ``docker run`` 例
   * - ``HTTP_PROXY``
     - ``ENV HTTP_PROXY="http://192.168.1.12:3128"``
     - ``--env HTTP_PROXY="http://192.168.1.12:3128"``
   * - ``HTTPS_PROXY``
     - ``ENV HTTPS_PROXY="https://192.168.1.12:3128"``
     - ``--env HTTPS_PROXY="https://192.168.1.12:3128"``
   * - ``FTP_PROXY``
     - ``ENV FTP_PROXY="ftp://192.168.1.12:3128"``
     - ``--env FTP_PROXY="ftp://192.168.1.12:3128"``
   * - ``NO_PROXY``
     - ``ENV NO_PROXY="*.test.example.com,.example2.com"``
     - ``--env NO_PROXY="*.test.example.com,.example2.com"``




.. seealso:: 

   Configure Docker to use a proxy server
      https://docs.docker.com/network/proxy/
