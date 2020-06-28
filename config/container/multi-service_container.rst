.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/multi-service_container/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/multi-service_container.md
   doc version: 1.12
.. check date: 2016/06/27
.. Commits on Apr 8, 2020 727941ffdd6430562e09314d3199b56f2de666df
.. ---------------------------------------------------------------------------

.. Run multiple services in a container

.. _run-multiple-services-in-a-container:

=======================================
コンテナ内で複数のサービスを実行
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. A container’s main running process is the ENTRYPOINT and/or CMD at the end of the Dockerfile. It is generally recommended that you separate areas of concern by using one service per container. That service may fork into multiple processes (for example, Apache web server starts multiple worker processes). It’s ok to have multiple processes, but to get the most benefit out of Docker, avoid one container being responsible for multiple aspects of your overall application. You can connect multiple containers using user-defined networks and shared volumes.

コンテナでメインとして実行するプロセスは、 ``Dockerfile`` の最後に書かれている ``ENTRYPOINT`` か ``CMD`` か、あるいは両方によって指定します。一般的に推奨するのは、1つのサービスごとにコンテナを使い、懸念事項の領域を分ける方法です。サービスは複数のプロセスにフォークする場合があります（たとえば、Apache ウェブサーバ派、複数のワーカ・プロセスと共に起動します）。複数のプロセスを持つ必要があるならば、1つのコンテナがアプリケーション全体における複数の役割を持ったとしても、Docker の利点から外れることがないようにする必要があります。ユーザ定義ネットワークと、共有ボリュームを使い、複数のコンテナ間を接続できます。

.. The container’s main process is responsible for managing all processes that it starts. In some cases, the main process isn’t well-designed, and doesn’t handle “reaping” (stopping) child processes gracefully when the container exits. If your process falls into this category, you can use the --init option when you run the container. The --init flag inserts a tiny init-process into the container as the main process, and handles reaping of all processes when the container exits. Handling such processes this way is superior to using a full-fledged init process such as sysvinit, upstart, or systemd to handle process lifecycle within your container.

コンテナのメイン・プロセスは、コンテナが開始する全てのプロセスを管理する責任があります。いくつかの場合、メイン・プロセスが適切に設計されていない場合があり、その場合はコンテナが停止しても、子プロセスを丁寧に「reaping」（停止）できない可能性があります。この類のプロセス失敗に対しては、コンテナ実行時に ``--init`` オプションを使って対応できます。 ``--init`` フラグは、メインプロセスとして小さな初期化プロセスをとしてコンテナに挿入することができ、コンテナの終了時に全てのプロセスの終了を扱います。各プロセスを ``sysvinit``  、 ``upstart`` 、 ``systemd`` のようなスーパーバイザを使うのと同じ方法で、コンテナ内のプロセス・ライフライムを扱えるようにもできます。

.. If you need to run more than one service within a container, you can accomplish this in a few different ways.

コンテナ内で複数のサービスを実行する必要があれば、いくつかの異なった方法で達成できます。

..    Put all of your commands in a wrapper script, complete with testing and debugging information. Run the wrapper script as your CMD. This is a very naive example. First, the wrapper script:

* ラッパー・スクリプト（wrapper script）で、テストやデバッグ情報も含む全てのコマンドを記述する方法です。このラッパー・スクリプトを ``CMD`` として指定します。これはとても良く使われる手法です。まず、以下がラッパー・スクリプトです。

   .. code-block:: bash
   
      #!/bin/bash
   
      # Start the first process
      ./my_first_process -D
      status=$?
      if [ $status -ne 0 ]; then
        echo "Failed to start my_first_process: $status"
        exit $status
      fi
   
      # Start the second process
      ./my_second_process -D
      status=$?
      if [ $status -ne 0 ]; then
        echo "Failed to start my_second_process: $status"
        exit $status
      fi
   
      # Naive check runs checks once a minute to see if either of the processes exited.
      # This illustrates part of the heavy lifting you need to do if you want to run
      # more than one service in a container. The container exits with an error
      # if it detects that either of the processes has exited.
      # Otherwise it loops forever, waking up every 60 seconds
   
      while sleep 60; do
        ps aux |grep my_first_process |grep -q -v grep
        PROCESS_1_STATUS=$?
        ps aux |grep my_second_process |grep -q -v grep
        PROCESS_2_STATUS=$?
        # If the greps above find anything, they exit with 0 status
        # If they are not both 0, then something is wrong
        if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
         echo "One of the processes has already exited."
         exit 1
        fi
      done

..    Next, the Dockerfile:

   次は Dockerfile です。

   ::
   
      FROM ubuntu:latest
      COPY my_first_process my_first_process
      COPY my_second_process my_second_process
      COPY my_wrapper_script.sh my_wrapper_script.sh
      CMD ./my_wrapper_script.sh

..    If you have one main process that needs to start first and stay running but you temporarily need to run some other processes (perhaps to interact with the main process) then you can use bash’s job control to facilitate that. First, the wrapper script:

* 1つのメイン・プロセスは一番初めに起動して、実行し続ける必要があるものの、一時的に他のプロセス（メインプロセスとやりとしるする場合もあるでしょう）も実行する必要がある場合は、bash のジョブ・コントロールでこれらを調整できます。まずはラッパー・スクリプトです。

   .. code-block:: bash
   
      #!/bin/bash
        
      # turn on bash's job control
      set -m
        
      # Start the primary process and put it in the background
      ./my_main_process &
        
      # Start the helper process
      ./my_helper_process
        
      # the my_helper_process might need to know how to wait on the
      # primary process to start before it does its work and returns
        
        
      # now we bring the primary process back into the foreground
      # and leave it there
      fg %1
   
   ::
   
      FROM ubuntu:latest
      COPY my_main_process my_main_process
      COPY my_helper_process my_helper_process
      COPY my_wrapper_script.sh my_wrapper_script.sh
      CMD ./my_wrapper_script.sh

..    Use a process manager like supervisord. This is a moderately heavy-weight approach that requires you to package supervisord and its configuration in your image (or base your image on one that includes supervisord), along with the different applications it manages. Then you start supervisord, which manages your processes for you. Here is an example Dockerfile using this approach, that assumes the pre-written supervisord.conf, my_first_process, and my_second_process files all exist in the same directory as your Dockerfile.

* ``supervisord``  のようなプロセス・マネージャを使う方法です。これは、どちらかといえば重量級のアプローチです。イメージの中にはアプリケーションを管理するものだけでなく、 ``supervisord`` のパッケージを入れる必要があります。 ``supervisord`` を起動すると、あなたにかわってプロセスを管理します。以下の Dockerfile 例はこのアプローチを使ったもので、あらかじめ ``supervisord.conf`` と ``my_first_processs`` と ``my_second_process`` ファイルを記述し、全てが Dockerifle と同じディレクトリにあるものと想定しています。

   ::
   
      FROM ubuntu:latest
      RUN apt-get update && apt-get install -y supervisor
      RUN mkdir -p /var/log/supervisor
      COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
      COPY my_first_process my_first_process
      COPY my_second_process my_second_process
      CMD ["/usr/bin/supervisord"]



.. seealso:: 

   Run multiple services in a container
      https://docs.docker.com/config/containers/multi-service_container/
