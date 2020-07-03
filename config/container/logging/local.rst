.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/logging/local/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/logging/local.md
   doc version: 19.03
.. check date: 2020/07/03
.. Commits on Apr 8, 2020 b0f90615659ac1319e8d8a57bb914e49d174242e
.. -------------------------------------------------------------------

.. Log Tags

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Local File logging driver

.. _local-file-logging-driver:

=======================================
ローカルファイル・ロギング・ドライバ
=======================================

.. The local logging driver captures output from container’s stdout/stderr and writes them to an internal storage that is optimized for performance and disk use.

``local`` ロギング・ドライバはコンテナの標準出力（stderr）・標準エラー出力（stderr）を取り込み、それらを内部ストレージに書き込みます。ストレージは性能とディスク使用のために最適化されています。

.. By default, the local driver preserves 100MB of log messages per container and uses automatic compression to reduce the size on disk. The 100MB default value is based on a 20M default size for each file and a default count of 5 for the number of such files (to account for log rotation).

デフォルトでは、 ``local`` ドライバはコンテナごとに 100MB のログ・メッセージを維持し、ディスク上の容量を減らすために自動的に圧縮を使います。100MB のデフォルトの値とは、各ファイルのデフォルトサイズが 20M で、かつ、これらのファイル数がデフォルトでは 5 だからです（ログをローテーションする回数分です）。

..  Note
    The local logging driver uses file-based storage. The file-format and storage mechanism are designed to be exclusively accessed by the Docker daemon, and should not be used by external tools as the implementation may change in future releases.

.. note::

   ``local`` ロギング・ドライバは、ファイルをベースとするストレージを使います。ファイル形式とストレージ機能は Docker デーモンのみが排他的にアクセスするよう設計されています。そのため、今後のリリースでの実装の影響を避けるため、外部のツールからは使われるべきではありません。


.. Usage

使い方
==========

.. To use the local driver as the default logging driver, set the log-driver and log-opt keys to appropriate values in the daemon.json file, which is located in /etc/docker/ on Linux hosts or C:\ProgramData\docker\config\daemon.json on Windows Server. For more about configuring Docker using daemon.json, see daemon.json.

``local`` ドライバをデフォルトのロギング・ドライバとして使うためには、 ``daemon.json`` ファイルで ``log-driver`` と ``log-opt`` キーに適切な値を設定します。ファイルは Linux ホスト上では ``/etc/docker`` にあり、 Windows Server 上では ``C:\ProgramData\docker\config\daemon.json`` にあります。 ``daemon.json`` を使って Docker を設定する方法は、 :ref:`daemon.json <daemon-configuration-file>` をご覧ください。

.. The following example sets the log driver to local and sets the max-size option.

以下の例は、ログドライバを ``local`` に設定し、 ``max-size`` オプションを指定しています。

.. code-block:: json

   {
     "log-driver": "local",
     "log-opts": {
       "max-size": "10m"
     }
   }

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

.. The local logging driver supports the following logging options:

``local`` ロギング・ドライバは以下のロギング・オプションをサポートしています。

.. list-table::
   :header-rows: 1

   * - オプション
     - 説明
     - サンプル値
   * - ``max-size``
     - ログファイルが回される前の、最大サイズです。整数値と容量を表す単位（ ``k`` 、 ``m`` 、 ``g`` ）を追加します。デフォルトは 20m です。
     - ``--log-opt max-size=10m``
   * - ``max-file``
     - 存在する最大のログファイル数です。ログへの追記がファイルを超過すると、ログを回しはじめ、古いファイルは削除します。整数値で指定します。デフォルトは 5 です。
     - ``--log-opt max-file=3``
   * - ``compress``
     - ログファイルの回転時に圧縮するかどうか切り替えます。デフォルトは圧縮が有効です。
     - ``--log-opt compress=false``

.. This example starts an alpine container which can have a maximum of 3 log files no larger than 10 megabytes each.

以下の例は、 ``alpine`` コンテナの開始にあたり、最大で3つのログファイルと、それぞれ10メガバイトを越えないように指定しています。

.. code-block:: bash

   $ docker run -it --log-driver local --log-opt max-size=10m --log-opt max-file=3 alpine ash


.. seealso:: 

   Local File logging driver
      https://docs.docker.com/config/containers/logging/local/
