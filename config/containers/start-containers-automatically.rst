.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/start-containers-automatically/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/start-containers-automatically.md
   doc version: 20.10
.. check date: 2022/04/26
.. Commits on Nov 27, 2021 42b9fec12a4d3840f32c2a810077a06e8101a6dc
.. ---------------------------------------------------------------------------

.. Start containers automatically

.. _start-containers-automatically:

=======================================
コンテナを自動的に開始
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker provides restart policies to control whether your containers start automatically when they exit, or when Docker restarts. Restart policies ensure that linked containers are started in the correct order. Docker recommends that you use restart policies, and avoid using process managers to start containers.

Docker は :ref:`再起動ポリシー（restart policy） <restart-policies-restart>` の指定により、たとえ終了したり Docker が再起動しても、自動的にコンテナを起動するように制御します。再起動ポリシーにより、つながっているコンテナが正しい順番で起動できるようにします。Docker が推奨するのは、再起動ポリシーを利用することであり、プロセス・マネージャによるコンテナの起動は避けるべきです。

.. Restart policies are different from the --live-restore flag of the dockerd command. Using --live-restore allows you to keep your containers running during a Docker upgrade, though networking and user input are interrupted.

再起動ポリシーは ``dockerd`` コマンドの ``--live-restore`` フラグとは異なります。 ``--live-restore`` は、Docker の更新中、ネットワーク機能やユーザからの入力が中断されたとしても、コンテナを実行し続けるように指定するためです。


.. Use a restart policy

.. _use-a-restart-policy:

再起動ポリシーを使う
==============================

.. To configure the restart policy for a container, use the --restart flag when using the docker run command. The value of the --restart flag can be any of the following:

コンテナに対する再起動ポリシーを設定するには、 ``docker run`` コマンドで ``--restart`` フラグを使います。 ``--restart`` の値は、以下のいずれかです。

.. Flag 	Description
   no 	Do not automatically restart the container. (the default)
   on-failure 	Restart the container if it exits due to an error, which manifests as a non-zero exit code.  Optionally, limit the number of times the Docker daemon attempts to restart the container using the `:max-retries` option. 
   always 	Always restart the container if it stops. If it is manually stopped, it is restarted only when Docker daemon restarts or the container itself is manually restarted. (See the second bullet listed in restart policy details)
   unless-stopped 	Similar to always, except that when the container is stopped (manually or otherwise), it is not restarted even after Docker daemon restarts.

.. list-table::
   :header-rows: 1

   * - フラグ
     - 説明
   * - ``no``
     - コンテナを自動的に再起動しません（デフォルトです）。
   * - ``on-failure:[max-retries]`` )
     - 終了コードがゼロ以外をエラーとみなし、エラーが発生時にコンテナを再起動します。コンテナに対するオプションで ``:max-retries`` を指定すると、Docker デーモンを再起動しようとする回数を制限します。
   * - ``always``
     - コンテナが停止すると常に再起動します。もしも手動でコンテナを停止した場合、再起動するのはDocker デーモンの再起動時やコンテナ自身を手動で再起動する時です（ :ref:`再起動ポリシー詳細 <restart-policy-details>` の２つめのリストをご覧ください）。
   * - ``unless-stopped``
     - ``always`` に似ていますが、コンテナの（手動または他の理由による）停止時は除外します。Docker デーモンを再起動しても再起動しません。


.. The following example starts a Redis container and configures it to always restart unless it is explicitly stopped or Docker is restarted.

以下の例は Redis コンテナを起動し、明示的にコンテナを停止をしなければ、Docker の再起動時も含め、常に Redis コンテナを再起動する設定です。明示的に停止すると、Docker を再起動しても Redis コンテナは起動しません。

.. code-block:: bash

   $ docker run -d --restart unless-stopped redis

.. This command changes the restart policy for an already running container named redis.

このコマンドは、 ``redis`` という名前で既に実行しているコンテナの、再起動ポリシーを変更します。

.. code-block:: bash

   $ docker update --restart unless-stopped redis

.. And this command will ensure all currently running containers will be restarted unless stopped.

そして、このコマンドは全ての実行中のコンテナに対して、明示的に停止しなければ再起動するようにします。

   $ docker update --restart unless-stopped $(docker ps -q)


.. Restart policy details

.. _restart-policy-details:

再起動ポリシーの詳細
------------------------------

.. Keep the following in mind when using restart policies:

再起動ポリシーの利用時は、以下の点を忘れないでください。

..    A restart policy only takes effect after a container starts successfully. In this case, starting successfully means that the container is up for at least 10 seconds and Docker has started monitoring it. This prevents a container which does not start at all from going into a restart loop.

* 再起動ポリシーが適用されるのは、コンテナの起動に成功した時のみです。この起動に成功という意味は、コンテナが少なくとも 10 秒起動し、Docker がコンテナの開始を開始してからです。これはコンテナが起動しないことで、再起動のループに陥らないようにするためです。

..    If you manually stop a container, its restart policy is ignored until the Docker daemon restarts or the container is manually restarted. This is another attempt to prevent a restart loop.

* 手動でコンテナを停止すると、Docker デーモンを再起動するか、コンテナを手動で再起動するまで再起動ポリシーを無視します。これは再起動ループを防ぐための側面を持ちます。

..    Restart policies only apply to containers. Restart policies for swarm services are configured differently. See the flags related to service restart.

* 再起動ポリシーを適用できるのはコンテナのみです。swarm サービスに対する再起動ポリシーの設定とは異なります。 :doc:`サービス再起動に関連するフラグ </engine/reference/commandline/service_create>` をご覧ください。


.. Use a process manager

.. _use-a-process-manager:

プロセス・マネージャの使用
==============================

.. If restart policies don’t suit your needs, such as when processes outside Docker depend on Docker containers, you can use a process manager such as upstart, systemd, or supervisor instead.

Docker コンテナと Docker 外のプロセスに依存する場合のように、再起動ポリシーの必要性がなければ、これにかわって `upstart <http://upstart.ubuntu.com/>`_  、 `systemd <https://freedesktop.org/wiki/Software/systemd/>`_ 、 `supervisor <http://supervisord.org/>`_ のようなプロセス・マネージャを利用できます。

..    Warning
    Do not try to combine Docker restart policies with host-level process managers, because this creates conflicts.

.. warning::

   Docker 再起動ポリシーとホストレベルのプロセス・マネージャの同時利用は、設定上の競合を引き起こすため、同時に使わないでください。

.. To use a process manager, configure it to start your container or service using the same docker start or docker service command you would normally use to start the container manually. Consult the documentation for the specific process manager for more details.

プロセス・マネージャを使うには、 ``docker start`` や ``docker service`` コマンドでコンテナやサービスを起動するのと同じように、コンテナを手動で通常どおり起動するように設定します。詳細については、それぞれのプロセス・マネージャのドキュメントを参照ください。


.. Using a process manager inside containers

.. _using-a-process-manager-inside-containers:

プロセス・マネージャの中でコンテナを使う
----------------------------------------

.. Process managers can also run within the container to check whether a process is running and starts/restart it if not.

プロセス・マネージャも、その中でコンテナのプロセスが実行しているかどうかを確認し、実行していなければ起動や再起動が行えます。


..    Warning
..    These are not Docker-aware and just monitor operating system processes within the container. Docker does not recommend this approach, because it is platform-dependent and even differs within different versions of a given Linux distribution.

.. warning::

   これは Docker からは関知できず、オペレーティングシステムのプロセスの中にコンテナが単に存在するだけです。このアプローチを Docker は推奨していません。理由はプラットフォームに依存するのと、Linux ディストリビューションのバージョンによって対処方法が異なるからです。


.. seealso:: 

   Start containers automatically
      https://docs.docker.com/config/containers/start-containers-automatically/
