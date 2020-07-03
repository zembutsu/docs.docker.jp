.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/logging/logentries/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/logging/logentries.md
   doc version: 19.03
.. check date: 2020/07/03
.. Commits on Feb 2, 2018 1b343beca4aaab8b183eefa89867b6bf64505be5
.. -------------------------------------------------------------------

.. Log Tags

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Logentries logging driver

.. _logentries logging driver:

=======================================
Logentries ロギング・ドライバ
=======================================

.. The logentries logging driver sends container logs to the Logentries server.

``logentries`` ロギング・ドライバは、コンテナのログを `Logentries <https://logentries.com/>`_ サーバに送信します。

.. Usage

使い方
==========

.. Some options are supported by specifying --log-opt as many times as needed:

複数のオプションをサポートしているため、必要があれば ``--log-opt`` を何度も指定します。

..  logentries-token: specify the logentries log set token
    line-only: send raw payload only

* ``logentries-token`` ：logentries ログセットのトークンを指定
* ``line-only`` ：raw ペイロードのみ送信

.. Configure the default logging driver by passing the --log-driver option to the Docker daemon:

Docker デーモンに対して ``--log-driver`` オプションを指定し、デフォルトのロギング・ドライバを指定します。

.. code-block:: bash

   $ dockerd --log-driver=logentries

.. To set the logging driver for a specific container, pass the --log-driver option to docker run:

特定のコンテナに対してロギング・ドライバを指定するには、 ``docker run`` 時に ``--log-driver`` オプションを付けます。

.. code-block:: bash

   $ docker run --log-driver=logentries ...

.. Before using this logging driver, you need to create a new Log Set in the Logentries web interface and pass the token of that log set to Docker:

このロギング・ドライバを使う前に、Logentries ウェブインターフェースで新しいログセットを作成し、Docker に対してログセットのトークンを渡します。

.. code-block:: bash

   $ docker run --log-driver=logentries --log-opt logentries-token=abcd1234-12ab-34cd-5678-0123456789ab

.. Options

オプション
==========

.. Users can use the --log-opt NAME=VALUE flag to specify additional Logentries logging driver options.

ユーザは ``--log-opt NAME=VALUE`` フラグを使い、Logentries ロギング・ドライバの追加オプションを指定できます。

logentries-token
--------------------

.. You need to provide your log set token for logentries driver to work:

logentries トライバが機能するよう、ログセットのトークンを指定する必要があります。

.. code-block:: bash

   $ docker run --log-driver=logentries --log-opt logentries-token=abcd1234-12ab-34cd-5678-0123456789ab

line-only
--------------------

.. You could specify whether to send log message wrapped into container data (default) or to send raw log line

ログメッセージをコンテナ内のデータにラップするか（デフォルト）、raw ログ行を送信するか指定します。

.. code-block:: bash

   $ docker run --log-driver=logentries --log-opt logentries-token=abcd1234-12ab-34cd-5678-0123456789ab --log-opt line-only=true



.. seealso:: 

   Logentries logging driver
      https://docs.docker.com/config/containers/logging/logentries/
