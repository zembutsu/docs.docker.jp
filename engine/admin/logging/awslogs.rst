.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/logging/awslogs/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/logging/awslogs.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/logging/awslogs.md
.. check date: 2016/06/13
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------------------

.. Amazon CloudWatch Logs logging driver

=========================================
Amazon CloudWatch Logs ロギング・ドライバ
=========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The awslogs logging driver sends container logs to Amazon CloudWatch Logs. Log entries can be retrieved through the AWS Management Console or the AWS SDKs and Command Line Tools.

``awslogs`` ロギングドライバは、コンテナのログを `Amazon CloudWatch ログ <https://aws.amazon.com/cloudwatch/details/#log-monitoring>`_ に送信します。ログのエントリは、 `AWS マネジメント・コンソール <https://console.aws.amazon.com/cloudwatch/home#logs:>`_ や `AWS SDK やコマンドライン・ツール <http://docs.aws.amazon.com/cli/latest/reference/logs/index.html>`_ を通して確認できます。

.. Usage

.. _awslogs-usage:

使い方
==========

.. You can configure the default logging driver by passing the --log-driver option to the Docker daemon:

デフォルトのロギング・ドライバを指定するには、Docker デーモンで ``--log-driver`` オプションを使います。

.. code-block:: bash

   docker daemon --log-driver=awslogs

.. You can set the logging driver for a specific container by using the --log-driver option to docker run:

特定のコンテナに対するロギング・ドライバの指定は、 ``docker run`` で ``--log-driver`` オプションを使います。

.. code-block:: bash

   docker run --log-driver=awslogs ...

.. Amazon CloudWatch Logs options

.. _amazon-cloudwatch-logs-options:

Amazon CloudWatch ログのオプション
========================================

.. You can use the --log-opt NAME=VALUE flag to specify Amazon CloudWatch Logs logging driver options.

Amazon CloudWatch Logs ロギング・ドライバのオプションを指定するには、 ``--log-opt NAME=VALUE`` フラグを使います。

.. awslogs-region

awslogs-region
--------------------

.. You must specify a region for the awslogs logging driver. You can specify the region with either the awslogs-region log option or AWS_REGION environment variable:

``awslogs`` ロギング・ドライバを使うには、リージョンの指定が必須です。リージョンを指定するにはログのオプションで ``awslogs-region`` を指定するか、環境変数 ``AWS_REGION`` を使います。

.. code-block:: bash

   docker run --log-driver=awslogs --log-opt awslogs-region=us-east-1 ...

.. awslogs-group

awslogs-group
--------------------

.. You must specify a log group for the awslogs logging driver. You can specify the log group with the awslogs-group log option:

`log group <http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/WhatIsCloudWatchLogs.html>`_ を使う場合は、 ``awslogs-group`` ログ・オプションを指定します。 ``awslogs-group`` ログ・オプションで log group を指定します。

.. code-block:: bash

   docker run --log-driver=awslogs --log-opt awslogs-region=us-east-1 --log-opt awslogs-group=myLogGroup ...

.. awslogs-stream

awslogs-stream
--------------------

.. To configure which log stream should be used, you can specify the awslogs-stream log option. If not specified, the container ID is used as the log stream.

`log stream <http://docs.aws.amazon.com/AmazonCloudWatch/latest/DeveloperGuide/WhatIsCloudWatchLogs.html>`_ を使う場合は、 ``awslogs-stream`` ログ・オプションを指定します。指定しなければ、コンテナ ID がログ・ストリームのために使われます。

..    Note: Log streams within a given log group should only be used by one container at a time. Using the same log stream for multiple containers concurrently can cause reduced logging performance.

.. note::

   ログ・ストリームに使うログ・グループはコンテナごとに指定すべきです。複数のコンテナが同じログ・ストリームを並行して使用すると、ログ記録性能が低下します。

.. Credentials

認証情報
-----------

.. You must provide AWS credentials to the Docker daemon to use the awslogs logging driver. You can provide these credentials with the AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_SESSION_TOKEN environment variables, the default AWS shared credentials file (~/.aws/credentials of the root user), or (if you are running the Docker daemon on an Amazon EC2 instance) the Amazon EC2 instance profile.

Docker デーモンが ``awslogs`` ロギング・ドライバを使う時は、 AWS の認証情報（credentials）の指定が必要です。認証情報とは環境変数 ``AWS_ACCESS_KEY_ID`` 、 ``AWS_SECRET_ACCESS_KEY`` 、 ``AWS_SESSION_TOKEN``  です。デフォルトは AWS 共有認証ファイル（ root ユーザであれば ``~/.aws/credentials`` ）か、（Amazon EC2 インスタンス上で Docker デーモンを実行するのであれば）Amazon EC2 インスタンス・プロファイルです。

.. Credentials must have a policy applied that allows the logs:CreateLogStream and logs:PutLogEvents actions, as shown in the following example.

認証情報には、次の例のように ``logs:CreateLogStream`` と ``logs:PutLogEvents`` の各アクションに対するポリシー追加が必要です。

.. code-block:: json

   {
     "Version": "2012-10-17",
     "Statement": [
       {
         "Action": [
           "logs:CreateLogStream",
           "logs:PutLogEvents"
         ],
         "Effect": "Allow",
         "Resource": "*"
       }
     ]
   }


.. seealso:: 

   Amazon CloudWatch Logs logging driver
      https://docs.docker.com/engine/admin/logging/awslogs/

