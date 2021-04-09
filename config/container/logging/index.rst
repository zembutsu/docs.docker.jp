.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/logging/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/logging/index.md
   doc version: 19.03
.. check date: 2020/07/01
.. Commits on Apr 23, 2020 b0f90615659ac1319e8d8a57bb914e49d174242e
.. ---------------------------------------------------------------------------

.. View logs for a container or service

.. _view-logs-for-a-container-or-service:

=======================================
コンテナやサービスのログを表示
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The docker logs command shows information logged by a running container. The docker service logs command shows information logged by all containers participating in a service. The information that is logged and the format of the log depends almost entirely on the container’s endpoint command.

``docker logs`` コマンドは、実行中のコンテナによって記録された（logged）情報を表示します。 ``docker service logs``  コマンドは、サービスに対する全てのコンテナによって記録された情報を表示します。

.. By default, docker logs or docker service logs shows the command’s output just as it would appear if you ran the command interactively in a terminal. UNIX and Linux commands typically open three I/O streams when they run, called STDIN, STDOUT, and STDERR. STDIN is the command’s input stream, which may include input from the keyboard or input from another command. STDOUT is usually a command’s normal output, and STDERR is typically used to output error messages. By default, docker logs shows the command’s STDOUT and STDERR. To read more about I/O and Linux, see the Linux Documentation Project article on I/O redirection.

デフォルトでは、 ``service log`` や ``docker service logs`` はコマンドの出力を表示しますが、あたかもターミナルでコマンドをインタラクティブに実行したかのように表示します。UNIX と Linux コマンドは、たいていはコマンドの実行時に I/O ストリームを開きます。この I/O ストリームとは、 ``STDIN`` 、 ``STDOUT`` 、``STDERR`` と呼びます。 ``STDIN`` はコマンドの入力ストリームであり、キーボードからの入力や他のコマンドからの入力を含みます。 ``STDOUT``  はたいていコマンドの通常出力であり、 ``STDERR`` は典型的にエラーメッセージを出力するために表示します。デフォルトでは、 ``docker logs`` はコマンドの ``STDOUT`` と ``SDNERR`` を表示します。 I/O および Linux に関して詳しく知るには、 `Linux Documentation Project にある I/O redirection の記事（英語） <http://www.tldp.org/LDP/abs/html/io-redirection.html>`_ をご覧ください。

.. In some cases, docker logs may not show useful information unless you take additional steps.

いくつかのケースにおいて、 ``docker logs`` では追加の手順を踏まないと、役に立つ情報を表示できないかもしれません。

..    If you use a logging driver which sends logs to a file, an external host, a database, or another logging back-end, docker logs may not show useful information.

* :doc:`ロギング・ドライバ </config/containers/logging/configure>` を使うと、ログをファイルに送信したり、外部のホストや、データベース、その他のロギング・バックエンドに送るため、 ``docker logs`` コマンドの結果が見づらい情報になる可能性があります。

..    If your image runs a non-interactive process such as a web server or a database, that application may send its output to log files instead of STDOUT and STDERR.

* もしも、ウェブサーバやデータベースのような、イメージがインタラクディヴではないプロセスを実行しようとすると、アプリケーションは ``STDOUT`` や ``STDERR`` のかわりにログファイルへと出力をする場合があります。

.. In the first case, your logs are processed in other ways and you may choose not to use docker logs. In the second case, the official nginx image shows one workaround, and the official Apache httpd image shows another.

1つめのケースでは、ログは他の手段によって処理されるため、 ``docker logs`` を使わない方が良いでしょう。2つめのケースでは、公式の ``nginx`` イメージは1つの回避策しかなく、公式の Apache ``httpd`` イメージは他にも選択肢があります。

.. The official nginx image creates a symbolic link from /var/log/nginx/access.log to /dev/stdout, and creates another symbolic link from /var/log/nginx/error.log to /dev/stderr, overwriting the log files and causing logs to be sent to the relevant special device instead. See the Dockerfile.

公式 ``nginx`` イメージは ``/var/log/nginx/access.log`` からのシンボリック・リンクを ``/dev/stdout`` に作成します。また、 ``/var/log/nginx/error.log`` から ``/dev/stderr`` へのシンボリック・リンクを作成します。このログファイルを上書きする指定により、ログは対象となる特別なデバイスに対して送信されます。この設定は `Dockerfile <https://github.com/nginxinc/docker-nginx/blob/8921999083def7ba43a06fabd5f80e4406651353/mainline/jessie/Dockerfile#L21-L23>`_ をご覧ください。

.. The official httpd driver changes the httpd application’s configuration to write its normal output directly to /proc/self/fd/1 (which is STDOUT) and its errors to /proc/self/fd/2 (which is STDERR). See the Dockerfile.

公式 ``httpd`` イメージは、 ``httpd`` アプリケーションの設定を変更し、通常の出力を ``/proc/self/fd/1`` （つまり ``STDOUT``） にします。また、エラーは ``/proc/self/fd/2`` （つまり ``STDERR`` ）にします。詳細は `Dockerfile <https://github.com/docker-library/httpd/blob/b13054c7de5c74bbaa6d595dbe38969e6d4f860c/2.2/Dockerfile#L72-L75>`__ をご覧ください。


.. Next steps

次のステップ
====================

..    Configure logging drivers.
    Write a Dockerfile.

* :doc:`ロギング・ドライバ <config/containers/logging/configure>` の設定
* :doc:`Dockerifle </engine/reference/builder` を書く



.. seealso:: 

   View logs for a container or service
      https://docs.docker.com/config/containers/logging/
