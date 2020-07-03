.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/logging/gcplogs/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/logging/gcplogs.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/logging/gcplogs.md
.. check date: 2016/07/09
.. Commits on Jul 4, 2016 644a7426cc31c338fedb6574d2b88d1cc2f43a08
.. -------------------------------------------------------------------

.. Google Cloud logging driver

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _google-cloud-logging-driver:

=======================================
Google Cloud ロギング・ドライバ
=======================================

.. The Google Cloud Logging driver sends container logs to Google Cloud Logging.

Google Cloud ロギング・ドライバはコンテナのログを `Google Cloud Logging <https://cloud.google.com/logging/docs/>`_  に送ります。

.. Usage

使い方
==========

.. You can configure the default logging driver by passing the --log-driver option to the Docker daemon:

デフォルトのロギング・ドライバを設定するには、Docker デーモンに ``--log-driver`` オプションを使います。

.. code-block:: bash

   docker daemon --log-driver=gcplogs

.. You can set the logging driver for a specific container by using the --log-driver option to docker run:

ロギング・ドライバをコンテナに指定するには ``docker run`` のオプションで ``--log-driver`` を指定します。

.. code-block:: bash

   docker run --log-driver=gcplogs ...

.. This log driver does not implement a reader so it is incompatible with docker logs.

このログ・ドライバを実装すると、 ``docker logs`` コマンドでログを参照できません。

.. If Docker detects that it is running in a Google Cloud Project, it will discover configuration from the instance metadata service. Otherwise, the user must specify which project to log to using the --gcp-project log option and Docker will attempt to obtain credentials from the Google Application Default Credential. The --gcp-project takes precedence over information discovered from the metadata server so a Docker daemon running in a Google Cloud Project can be overridden to log to a different Google Cloud Project using --gcp-project.

Docker が Google Cloud プロジェクトを検出すると、 `インスタンス・メタデータ・サービス <https://cloud.google.com/compute/docs/metadata>`_ 上で設定を見つけられるようになります。あるいは、ユーザがプロジェクトのログを記録するには ``--gcp-project`` ログ・オプションを指定し、Docker が `Google Application Default Credential <https://developers.google.com/identity/protocols/application-default-credentials>`_ から証明書を得る必要があります。 `--gcp-project` はメタデータ・サーバによって発見される情報よりも優先します。そのため、Google Cloud Project で動いている Docker デーモンのログは、 ``--gcp-project`` を使って異なったプロジェクトに出力できます。

.. gcplogs options

gpclogs オプション
====================

.. You can use the --log-opt NAME=VALUE flag to specify these additional Google Cloud Logging driver options:

Google Cloud ロギング・ドライバのオプションは、``--log-opt 名前=値`` の形式で指定できます。

.. Option 	Required 	Description
   gcp-project 	optional 	Which GCP project to log to. Defaults to discovering this value from the GCE metadata service.
   gcp-log-cmd 	optional 	Whether to log the command that the container was started with. Defaults to false.
   labels 	optional 	Comma-separated list of keys of labels, which should be included in message, if these labels are specified for container.
   env 	optional 	Comma-separated list of keys of environment variables, which should be included in message, if these variables are specified for container.

.. list-table::
   :header-rows: 1
   
   * - オプション
     - 必須
     - 説明
   * - ``gcp-poject``
     - オプション
     - どの GCP プロジェクトにログを記録するか指定。デフォルトは GCE メタデータ・サービスを経由して確認された値。
   * - ``gcp-log-cmd``
     - オプション
     - コンテナ起動時、どこにログ記録コマンドがあるか指定。デフォルトは false 。
   * - ``lables``
     - オプション
     - ラベルをコンテナに指定する場合、メッセージを含むラベルのキー一覧をカンマ区切りで。
   * - ``env``
     - オプション
     - 環境変数をコンテナに指定する場合、メッセージに含める環境変数があれば、キーの一覧をカンマ区切りで指定。

.. If there is collision between label and env keys, the value of the env takes precedence. Both options add additional fields to the attributes of a logging message.

``label`` と ``env`` キーの間で衝突があれば、 ``env`` が優先されます。いずれのオプションもロギング・メッセージの追加フィールドの属性に追加します。

.. Below is an example of the logging options required to log to the default logging destination which is discovered by querying the GCE metadata server.

以下は、 GCE メタデータ・サーバで発見されたデフォルトのログ送信先を使うために必要なオプション指定の例です。

.. code-block:: bash

   docker run --log-driver=gcplogs \
       --log-opt labels=location
       --log-opt env=TEST
       --log-opt gcp-log-cmd=true
       --env "TEST=false"
       --label location=west
       your/application

.. This configuration also directs the driver to include in the payload the label location, the environment variable ENV, and the command used to start the container.

また、この設定ではラベル ``location`` 、環境変数 ``ENV`` 、コンテナ起動時に使うコマンドの引数も指定しています。

.. seealso:: 

   Google Cloud logging driver
      https://docs.docker.com/engine/admin/logging/gcplogs/
