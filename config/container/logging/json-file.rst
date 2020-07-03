.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/logging/json-file/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/logging/json-file.md
   doc version: 19.03
.. check date: 2020/07/03
.. Commits on Apr 8, 2020 b0f90615659ac1319e8d8a57bb914e49d174242e
.. -------------------------------------------------------------------

.. Log Tags

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. JSON File logging driver

.. _json-file-logging-driver:

=======================================
JSON ファイル・ロギング・ドライバ
=======================================

.. By default, Docker captures the standard output (and standard error) of all your containers, and writes them in files using the JSON format. The JSON format annotates each line with its origin (stdout or stderr) and its timestamp. Each log file contains information about only one container.

デフォルトでは、 Docker は全てのコンテナの標準出力（と標準エラー）を取り込み、それらを JSON 形式のファイルに書き込みます。JSON 形式では、各行に参照元（ ``stdout`` か ``stderr`` ）とタイムスタンプを追記します。各ログファイルに含む情報は、1つのコンテナに対してのみです。

.. code-block:: json

   {"log":"Log line is here\n","stream":"stdout","time":"2019-01-01T11:11:11.111111111Z"}

.. Usage

使い方
==========

.. To use the json-file driver as the default logging driver, set the log-driver and log-opts keys to appropriate values in the daemon.json file, which is located in /etc/docker/ on Linux hosts or C:\ProgramData\docker\config\ on Windows Server. For more information about configuring Docker using daemon.json, see daemon.json.

``json-file`` ドライバをデフォルトのロギング・ドライバとして使うためには、 ``daemon.json`` ファイルで ``log-driver`` と ``log-opt`` キーに適切な値を設定します。ファイルは Linux ホスト上では ``/etc/docker`` にあり、 Windows Server 上では ``C:\ProgramData\docker\config\daemon.json`` にあります。 ``daemon.json`` を使って Docker を設定する方法は、 :ref:`daemon.json <daemon-configuration-file>` をご覧ください。

.. The following example sets the log driver to json-file and sets the max-size and max-file options.

以下の例は、ログドライバを ``json-file`` に設定し、 ``max-size`` オプションを指定しています。

.. code-block:: json

   {
     "log-driver": "json-file",
     "log-opts": {
       "max-size": "10m"
     }
   }

..  Note
    log-opts configuration options in the daemon.json configuration file must be provided as strings. Boolean and numeric values (such as the value for max-file in the example above) must therefore be enclosed in quotes (").

.. note::

   ``daemon.json`` 設定ファイルの ``log-opts`` 設定は、文字列として指定する必要があります。論理値および整数値（先の例にある ``max-file`` の値）は、引用符（ ``"`` ）で囲む必要があります。


.. Restart Docker for the changes to take effect for newly created containers. Existing containers do not use the new logging configuration.

設定を変えるには Docker を再起動し、それ以後作成するコンテナに対して有効になります。既存のコンテナは新しいログ設定は適用されません。

.. You can set the logging driver for a specific container by using the --log-driver flag to docker container create or docker run:

特定のコンテナに対してのみロギング・ドライバを指定したい場合は、 ``--log-driver`` フラグを ``docker container create`` か ``docker run`` で指定します。

.. code-block:: bash

   $ docker run \
         --log-driver local --log-opt max-size=10m \
         alpine echo hello world

.. Options

オプション
----------

.. The json-file logging driver supports the following logging options:

``json-file`` ロギング・ドライバは以下のロギング・オプションをサポートしています。

.. list-table::
   :header-rows: 1

   * - オプション
     - 説明
     - サンプル値
   * - ``max-size``
     - ログファイルが回される前の、最大サイズです。整数値と容量を表す単位（ ``k`` 、 ``m`` 、 ``g`` ）を追加します。デフォルトは 20m です。デフォルトは -1（無制限）です。
     - ``--log-opt max-size=10m``
   * - ``max-file``
     - 存在する最大のログファイル数です。ログへの追記がファイルを超過すると、ログを回しはじめ、古いファイルは削除します。 **この設定が max-size もまた設定されている時に効果が出ます。** 整数値で指定します。デフォルトは 1 です。
     - ``--log-opt max-file=3``
   * - ``lables``
     - Docker デーモンの開始時に適用します。デーモンが受け付けるログに関連するラベルを、カンマ区切りで指定します。 :doc:`ログとタグのオプション <log_tags>` を使います。
     - ``--log-opt labels=production_status,geo``
   * - ``env``
     - Docker デーモンの開始時に適用します。デーモンが受け付けるログに関連する環境変数を、カンマ区切りで指定します。 :doc:`ログとタグのオプション <log_tags>` を使います。
     - ``--log-opt env=os,customer``
   * - ``env-regex``
     - Docker デーモンの開始時に適用します。デーモンが受け付けるログに関連する環境変数を、正規表現で指定します。 :doc:`ログとタグのオプション <log_tags>` を使います。
     - ``--log-opt env-regex=^(os|customer).``
   * - ``compress``
     - ログファイルの回転時に圧縮するかどうか切り替えます。デフォルトは圧縮が無効です。
     - ``--log-opt compress=true``

.. This example starts an alpine container which can have a maximum of 3 log files no larger than 10 megabytes each.

以下の例は、 ``alpine`` コンテナの開始にあたり、最大で3つのログファイルと、それぞれ10メガバイトを越えないように指定しています。

.. code-block:: bash

   $ docker run -it --log-driver local --log-opt max-size=10m --log-opt max-file=3 alpine ash


.. seealso:: 

   JSON File logging driver
      https://docs.docker.com/config/containers/logging/json-file/
