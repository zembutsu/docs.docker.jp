.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/run/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/reference/run.md
   doc version: 1.10
      https://github.com/docker/compose/commits/master/docs/reference/run.md
.. check date: 2016/03/07
.. Commits on Jan 7, 2016 4e75ed42319b372ac79c7b8762c5fec794afa841
.. -------------------------------------------------------------------

.. run

.. _compose-run:

=======================================
run
=======================================

.. code-block:: bash

   Usage: run [options] [-e KEY=VAL...] SERVICE [COMMAND] [ARGS...]
   
   Options:
   -d                    Detached mode: Run container in the background, print
                             new container name.
   --name NAME           Assign a name to the container
   --entrypoint CMD      Override the entrypoint of the image.
   -e KEY=VAL            Set an environment variable (can be used multiple times)
   -u, --user=""         Run as specified username or uid
   --no-deps             Don't start linked services.
   --rm                  Remove container after run. Ignored in detached mode.
   -p, --publish=[]      Publish a container's port(s) to the host
   --service-ports       Run command with the service's ports enabled and mapped to the host.
   -T                    Disable pseudo-tty allocation. By default `docker-compose run` allocates a TTY.

.. Runs a one-time command against a service. For example, the following command starts the web service and runs bash as its command.

サービスに対して１回コマンドを実行します。例えば、次のコマンドは ```web`` サービスを開始するためのコマンドで、サービス内で ``bash`` としてコマンドを実行します。

.. code-block:: bash

   $ docker-compose run web bash

.. Commands you use with run start in new containers with the same configuration as defined by the service’ configuration. This means the container has the same volumes, links, as defined in the configuration file. There two differences though.

``run`` コマンドを使うと、サービスの設定ファイルで定義された通りに、同じ設定の新しいコンテナを開始します。つまり、コンテナは設定ファイル上で定義された同じボリュームとリンクを持ちます。ただ、ここでは２つの違いがあります。

.. First, the command passed by run overrides the command defined in the service configuration. For example, if the web service configuration is started with bash, then docker-compose run web python app.py overrides it with python app.py.

１つは、 ``run`` コマンドの指定は、サービス設定ファイル上での定義を上書きします。たとえば、 ``web`` サービスは ``bash`` で開始する設定だとしても、 ``docker-compose run web python app.py`` を実行すると、 ``python app.py`` で上書きします。

.. The second difference is the docker-compose run command does not create any of the ports specified in the service configuration. This prevents the port collisions with already open ports. If you do want the service’s ports created and mapped to the host, specify the --service-ports flag:

２つめの違いとして、 ``docker-compose run`` コマンドはサービス設定ファイルで指定したポートを作成しません。これは、既に開いているポートとの衝突を避けるためです。サービス用のポートを作成し、ホスト側に割り当てるには、 ``--service-ports`` フラグを使います。

.. code-block:: bash

   $ docker-compose run --service-ports web python manage.py shell

.. Alternatively manual port mapping can be specified. Same as when running Docker’s run command - using --publish or -p options:

別の方法として、手動でポートの割り当てを設定することも可能です。同様に Docker で ``run`` コマンドを使うときに、 ``--publish`` または ``-p`` オプションを使います。

.. code-block:: bash

   $ docker-compose run --publish 8080:80 -p 2022:22 -p 127.0.0.1:2021:21 web python manage.py shell

.. If you start a service configured with links, the run command first checks to see if the linked service is running and starts the service if it is stopped. Once all the linked services are running, the run executes the command you passed it. So, for example, you could run:

リンク機能を使ってサービスを開始する場合、 ``run`` コマンドはリンク先のサービスが実行中かどうかをまず確認し、サービスが停止していれば起動します。全てのリンク先のサービスが起動したら、指定したコマンドで ``run`` 命令が実行されます。例えば、次のように実行できます。

.. code-block:: bash

   $ docker-compose run db psql -h db -U docker

.. This would open up an interactive PostgreSQL shell for the linked db container.

これはリンクしている ``db`` コンテナに対して、PostgreSQL シェルで操作をします。

.. If you do not want the run command to start linked containers, specify the --no-deps flag:

``run`` コマンドを実行するとき、リンクしているコンテナを起動したくない場合は ``--no-deps`` フラグを使います。

.. code-block:: bash

   $ docker-compose run --no-deps web python manage.py shell

.. seealso:: 

   run
      https://docs.docker.com/compose/reference/run/
