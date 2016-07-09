.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/host_integration/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/host_integration.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/host_integration.md
.. check date: 2016/07/09
.. Commits on Jul 1, 2016 48744e03e951c7ab4be180fbf6c1f56108512efa
.. ---------------------------------------------------------------------------

.. Automatically start containers

.. _host_integration-automatically-start-containers:

=======================================
コンテナの自動起動
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. As of Docker 1.2, restart policies are the built-in Docker mechanism for restarting containers when they exit. If set, restart policies will be used when the Docker daemon starts up, as typically happens after a system boot. Restart policies will ensure that linked containers are started in the correct order.

Docker 1.2 から :ref:`再起動ポリシー <restart-policies-restart>` が Docker の機能に組み込まれました。これはコンテナ終了時に再起動するための仕組みです。再起動ポリシーを設定しておけば、Docker デーモンの起動時、典型的なのはシステムの起動時に自動的にコンテナを開始します。リンクされたコンテナであっても、再起動ポリシーは適切な順番で起動します。

.. If restart policies don’t suit your needs (i.e., you have non-Docker processes that depend on Docker containers), you can use a process manager like upstart, systemd or supervisor instead.

必要に応じて再起動ポリシーを使わないでください（例：Docker ではないプロセスが Docker コンテナに依存する場合）。そのような場合は、再起動ポリシーの代わりに `upstart <http://upstart.ubuntu.com/>`_ 、 `systemd <http://freedesktop.org/wiki/Software/systemd/>`_ 、 `supervisor <http://supervisord.org/>`_  といったプロセス・マネージャをお使いください。

.. Using a process manager

.. _host_integration-using-a-process-manager:

プロセス・マネージャを使う場合
==============================

.. Docker does not set any restart policies by default, but be aware that they will conflict with most process managers. So don’t set restart policies if you are using a process manager.

デフォルトの Docker は再起動ポリシーを設定しません。しかし、多くのプロセス・マネージャと衝突を引き起こす可能性については知っておいてください。もしプロセス・マネージャを使うのであれば、再起動ポリシーを使わない方が良いでしょう。

.. When you have finished setting up your image and are happy with your running container, you can then attach a process manager to manage it. When you run docker start -a, Docker will automatically attach to the running container, or start it if needed and forward all signals so that the process manager can detect when a container stops and correctly restart it.

イメージのセットアップが完了したら、コンテナを実行できるようになり満足でしょう。この実行をプロセス・マネージャに委ねられます。 ``docker start -a`` を実行したら、Docker は自動的に実行中のコンテナにアタッチします。そして、実行後は必要に応じて全てのシグナルを転送しますので、コンテナの停止をプロセス・マネージャが検出したら、適切に再起動するでしょう。

.. Here are a few sample scripts for systemd and upstart to integrate with Docker.

以下では systemd と upstart を Docker と連携する例を紹介します。

.. Examples

.. _host_integration-examples:

例
==========

.. The examples below show configuration files for two popular process managers, upstart and systemd. In these examples, we’ll assume that we have already created a container to run Redis with --name=redis_server. These files define a new service that will be started after the docker daemon service has started.

この例では２つの有名なプロセス・マネージャ、upstart と systemd 向けの設定ファイルを扱います。これらの例では、既に作成しているコンテナ ``--name=redis_server`` を使って Redis を起動するのを想定しています。これらのファイルは新しいサービスを定義し、docker サービスが起動した後で自動的に起動するものです。

.. upstart

.. _host_integration-upstart:

upstart
----------

.. code-block:: bash

   description "Redis container"
   author "Me"
   start on filesystem and started docker
   stop on runlevel [!2345]
   respawn
   script
     /usr/bin/docker start -a redis_server
   end script

.. systemd

.. _host_integration-systemd:

systemd
----------

.. code-block:: bash

   [Unit]
   Description=Redis container
   Requires=docker.service
   After=docker.service
   
   [Service]
   Restart=always
   ExecStart=/usr/bin/docker start -a redis_server
   ExecStop=/usr/bin/docker stop -t 2 redis_server
   
   [Install]
   WantedBy=default.target

.. If you need to pass options to the redis container (such as --env), then you’ll need to use docker run rather than docker start. This will create a new container every time the service is started, which will be stopped and removed when the service is stopped.

redis コンテナに（ ``--env`` のような）オプションを渡したい場合は、 ``docker run`` に代わって ``docker start`` を使う必要があります。次の例は、起動したコンテナのサービスが停止、または、サービス停止によってコンテナが削除されたとしても、新しいコンテナを毎回作成します。

.. code-block:: bash

   [Service]
   ...
   ExecStart=/usr/bin/docker run --env foo=bar --name redis_server redis
   ExecStop=/usr/bin/docker stop -t 2 redis_server
   ExecStopPost=/usr/bin/docker rm -f redis_server
   ...

.. seealso:: 

   Automatically start containers
      https://docs.docker.com/engine/admin/host_integration/
