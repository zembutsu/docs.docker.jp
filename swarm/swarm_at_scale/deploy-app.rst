.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/swarm_at_scale/deploy-app/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/swarm_at_scale/deploy-app.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/swarm_at_scale/deploy-app.md
.. check date: 2016/05/26
.. Commits on Apr 29, 2016 d2c9f8bc9a674a4f215afe3651a09ee5c42c713c
.. -------------------------------------------------------------------

.. Deploy the application

.. _deploy-the-application:

==============================
アプリケーションのデプロイ
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You’ve deployed the load balancer, the discovery backend, and a Swarm cluster so now you can build and deploy the voting application itself. You do this by starting a number of “dockerized applications” running in containers.

これまで :doc:`ロードバランサ、ディスカバリ・バックエンド、Swarm クラスタをデプロイ <deploy-infra>` しました。次は投票アプリケーションをデプロイしましょう。ここで「Docker化したアプリケーション」を起動し始めます。

.. The diagram below shows the final application configuration including the overlay container network, voteapp.

次の図は最終的なアプリケーション設定であり、 ``voteapp`` オーバレイ・コンテナ・ネットワークも含みます。

.. image:: ../images/final-result.png
   :scale: 60%

.. In this procedure you will connect containers to this network. The voteapp network is available to all Docker hosts using the Consul discovery backend. Notice that the interlock, nginx, consul, and swarm manager containers on are not part of the voteapp overlay container network.

この手順ではコンテナをネットワークに接続します。この ``voteapp`` ネットワークは Consul ディスカバリ・バックエンドを使う全ての Docker ホスト上で利用可能です。 ``interlock`` 、 ``nginx`` 、 ``consul`` 、 ``swarm manager`` コンテナは ``voteapp`` オーバレイ・コンテナ・ネットワークの一部なのでご注意ください。

.. Task 1. Set up volume and network

.. _task1-set-up-volume-and-network:

タスク１：ボリュームとネットワークのセットアップ
==================================================

.. This application relies on both an overlay container network and a container volume. The Docker Engine provides these two features. You’ll create them both on the Swarm manager instance.

このアプリケーションはオーバレイ・コンテナ・ネットワークとコンテナ・ボリュームに依存します。Docker Engine は２つの機能を提供します。Swarm ``manager`` インスタンス上でどちらも作成可能です。

..    Direct your local environmen to the Swarm manager host.

1. ローカル環境を Swarm ``manager`` ホストに向けます。

.. code-block:: bash

   $ eval $(docker-machine env manager)

..    You can create the network on an cluster node at the network is visible on them all.

クラスタ・ノード上でネットワークを作成したら、ネットワーク全体で参照可能になります。

..    Create the voteapp container network.

2. ``voteapp`` コンテナ・ネットワークを作成します。

.. code-block:: bash

   $ docker network create -d overlay voteapp

..    Switch to the db store.

3. db ストアに切り替えます。

.. code-block:: bash

   $ eval $(docker-machine env dbstore)

..    Verify you can see the new network from the dbstore node.

4. db ストア・ノードで新しいネットワークを確認します。

.. code-block:: bash

   $ docker network ls
   NETWORK ID          NAME                DRIVER
   e952814f610a        voteapp             overlay
   1f12c5e7bcc4        bridge              bridge
   3ca38e887cd8        none                null
   3da57c44586b        host                host

..    Create a container volume called db-data.

5. ``db-data`` という名称のコンテナ・ボリュームを作成します。

.. code-block:: bash

   $ docker volume create --name db-data

.. Task 2. Start the containerized microservices

.. _task2-start-the-containerized-microservices:

タスク２：コンテナ化したマイクロサービスの起動
==================================================

.. At this point, you are ready to start the component microservices that make up the application. Some of the application’s containers are launched from existing images pulled directly from Docker Hub. Other containers are launched from custom images you must build. The list below shows which containers use custom images and which do not:

この時点で、マイクロサービスのコンポーネントを起動し、アプリケーションを起動する準備が整いました。アプリケーション・コンテナによっては、Docker Hub にある既存イメージを直接ダウンロードして実行できます。その他、自分でカスタマイズしたイメージを実行したい場合は、構築する必要があります。以下はどのコンテナがカスタム・イメージを使っているか、使っていないかの一覧です。

..    Load balancer container: stock image (ehazlett/interlock)
    Redis containers: stock image (official redis image)
    Postgres (PostgreSQL) containers: stock image (official postgres image)
    Web containers: custom built image
    Worker containers: custom built image
    Results containers: custom built image

* ロードバランサ・コンテナ：既存イメージ（ ``ehazlett/interlock`` ）
* Redis コンテナ：既存イメージ（公式  ``redis`` イメージ）
* Postgres (PostgreSQL) コンテナ：既存イメージ（公式 ``postgres`` イメージ）
* Web コンテナ：カスタム構築イメージ
* Worker コンテナ：カスタム構築イメージ
* Results コンテナ：カスタム構築イメージ

.. You can launch these containers from any host in the cluster using the commands in this section. Each command includs a -Hflag so that they execute against the Swarm manager.

このセクションではクラスタ上のホストに対して、コマンドでこれらのコンテナを起動します。 Swarm マネージャに対して命令するためには、各コマンドで ``-H`` フラグを使います。

.. The commands also all use the -e flag which is a Swarm constraint. The constraint tells the manager to look for a node with a matching function label. You set established the labels when you created the nodes. As you run each command below, look for the value constraint.

コマンドには ``-e`` も含みます。これは Swarm に制限（constraint）を指定するためです。制限はマネージャに対して、function（機能）のラベルに一致するノードの指定で使います。ラベルはノード作成時に設定します。以降のコマンド実行時に、制約の値を確認します。

..    Start a Postgres database container.

1. Postgres データベース・コンテナを起動します。

.. code-block:: bash

   $ docker -H $(docker-machine ip manager):3376 run -t -d \
   -v db-data:/var/lib/postgresql/data \
   -e constraint:com.function==dbstore \
   --net="voteapp" \
   --name db postgres:9.4

..    Start the Redis container.

2. Redis コンテナを起動します。

.. code-block:: bash

   $ docker -H $(docker-machine ip manager):3376 run -t -d \
   -p 6379:6379 \
   -e constraint:com.function==dbstore \
   --net="voteapp" \
   --name redis redis

..    The redis name is important so don’t change it.

``redis`` の名前は重要なため、変更しないでください。

..    Start the worker application

3. ワーカ・アプリケーションを起動します。

.. code-block:: bash

   $ docker -H $(docker-machine ip manager):3376 run -t -d \
   -e constraint:com.function==worker01 \
   --net="voteapp" \
   --net-alias=workers \
   --name worker01 docker/example-voting-app-worker

..    Start the results application.

4. results アプリケーションを起動します。

.. code-block:: bash

   $ docker -H $(docker-machine ip manager):3376 run -t -d \
   -p 80:80 \
   --label=interlock.hostname=results \
   --label=interlock.domain=myenterprise.com \
   -e constraint:com.function==dbstore \
   --net="voteapp" \
   --name results-app docker/example-voting-app-result-app

..    Start voting application twice, on each frontend node.

5. 各フロントエンド・ノード上に、２つの投票アプリケーションを起動します。

.. code-block:: bash

   $ docker -H $(docker-machine ip manager):3376 run -t -d \
   -p 80:80 \
   --label=interlock.hostname=vote \
   --label=interlock.domain=myenterprise.com \
   -e constraint:com.function==frontend01 \
   --net="voteapp" \
   --name voting-app01 docker/example-voting-app-voting-app

..    And again on the other frontend node.

そして、別のフロントエンド・ノード上で実行します。

.. code-block:: bash

   $ docker -H $(docker-machine ip manager):3376 run -t -d \
   -p 80:80 \
   --label=interlock.hostname=vote \
   --label=interlock.domain=myenterprise.com \
   -e constraint:com.function==frontend02 \
   --net="voteapp" \
   --name voting-app02 docker/example-voting-app-voting-app

.. Task 3. Check your work and update /etc/hosts

.. _task3-check-your-work-and-update-etc-hosts:

タスク３：作業内容の確認と /etc/hosts の更新
==================================================

.. In this step, you check your work to make sure the Nginx configuration recorded the containers correctly. You’ll update your local systems /etc/hosts file to allow you to take advantage of the loadbalancer.

このステップでは、 Nginx コンテナの設定が適切に行われているかを確認します。ロードバランサの動作確認のため、ローカルの ``/etc/hosts`` ファイルを変更します。

..     Change to the loadbalancer node.

1. ``loadbalancer`` ノードに変更します。

.. code-block:: bash

   $ eval $(docker-machine env loadbalancer)

..    Check your work by reviewing the configuration of nginx.

2. nginx の設定を表示し、内容を確認します。

.. code-block:: bash

   $ docker exec interlock cat /etc/conf/nginx.conf
   ... 出力を省略 ...
   
   upstream results.myenterprise.com {
       zone results.myenterprise.com_backend 64k;
   
       server 192.168.99.111:80;
   
   }
   server {
       listen 80;
   
       server_name results.myenterprise.com;
   
       location / {
           proxy_pass http://results.myenterprise.com;
       }
   }
   upstream vote.myenterprise.com {
       zone vote.myenterprise.com_backend 64k;
   
       server 192.168.99.109:80;
       server 192.168.99.108:80;
   
   }
   server {
       listen 80;
   
       server_name vote.myenterprise.com;
   
       location / {
           proxy_pass http://vote.myenterprise.com;
       }
   }
   
   include /etc/conf/conf.d/*.conf;
   }

.. The http://vote.myenterprise.com site configuration should point to either frontend node. Requests to http://results.myenterprise.com go just to the single dbstore node where the example-voting-app-result-app is running.

``http://vote.myenterprise.com`` サイトの設定は、どちらかのフロントエンド・ノードを指し示します。 ``http://results.myenterprise.com`` にリクエストしたら、 ``example-voting-app-result-app`` が稼働している ``dbstore`` ノードに移動します。

..    On your local host, edit /etc/hosts file add the resolution for both these sites.

1. ローカルホスト上で ``/etc/hosts`` ファイルを編集し、これらサイトの名前解決の行を追加します。

..    Save and close the /etc/hosts file.

2. ``/etc/hosts`` ファイルを保存して閉じます。

..    Restart the nginx container.

3. ``nginx`` コンテナの再起動。

..    Manual restart is required because the current Interlock server is not forcing an Nginx configuration reload.

現在の Interlock サーバの設定が Nginx の設定を反映していません。そのため、手動で再起動の必要があります。

.. code-block:: bash

   $ docker restart nginx

.. Task 4. Test the application

.. _task4-test-the-application:

タスク４：アプリケーションのテスト
========================================

.. Now, you can test your application.

これでアプリケーションをテストできます。

..    Open a browser and navigate to the http://vote.myenterprise.com site.

1. ブラウザを開き、サイト ``http://vote.myenterprise.com`` に移動します。

..    You should see something similar to the following:

投票ページ「Cats vs Dogs!」が画面に表示されます。

..    Click on one of the two voting options.

2. ２つの選択肢のうち、どちらかに投票します。

..    Navigate to the http://results.myenterprise.com site to see the results.

3. サイト ``http://results.myenterprise.com`` に移動し、結果を表示します。

..    Try changing your vote.

4. 他の選択肢に投票します。

..    You’ll see both sides change as you switch your vote.

投票した結果が画面上に表示されます。

.. Extra Credit: Deployment with Docker Compose

追加作業：Docker Compose でデプロイ
========================================

.. Up to this point, you’ve deployed each application container individually. This can be cumbersome espeically because their are several different containers and starting them is order dependent. For example, that database should be running before the worker.

これまでは、各アプリケーションのコンテナを個々に起動しました。しかし、複数コンテナの起動や依存関係の順番に従った起動は、とても煩雑です。例えば、データベースはワーカが起動する前に動いているべきでしょう。

.. Docker Compose let’s you define your microservice containers and their dependencies in a Compose file. Then, you can use the Compose file to start all the containers at once. This extra credit

Docker Compose はマイクロサービス・コンテナと依存関係を Compose ファイルで定義します。そして、Compose ファイルを使って全てのコンテナを一斉に起動します。これは追加作業（extra credit）です。

..    Before you begin, stop all the containers you started.

1. 始める前に、起動した全てのコンテナを停止します。

..    a. Set the host to the manager.

a. （作業対象の）ホストをマネージャに向けます。

.. code-block:: bash

   $ DOCKER_HOST=$(docker-machine ip manager):3376

..    b. List all the application continers on the Swarm.

b. Swarm 上のアプリケーション全てを一覧します。

..    c. Stop and remove each container.

c. 各コンテナを停止・削除します。

..    Try to create Compose file on your own by reviewing the tasks in this tutorial.

2. このチュートリアルに従って、自分で Compose ファイルの作成を試みます。

..    The version 2 Compose file format is the best to use. Translate each docker run command into a service in the docker-compose.yml file. For example, this command:

Compose ファイルはバージョン２形式を使うのがベストです。各 ``docker run`` コマンドを ``docker-compose.yml``  ファイル内のサービスに置き換えます。例えば、次のコマンドがあります。

.. code-block:: bash

   $ docker -H $(docker-machine ip manager):3376 run -t -d \
   -e constraint:com.function==worker01 \
   --net="voteapp" \
   --net-alias=workers \
   --name worker01 docker/example-voting-app-worker

..    Becomes this in a Compose file.

これは、次の Compose ファイルに書き換え可能です。

.. code-block:: bash

   worker:
     image: docker/example-voting-app-worker
     networks:
       voteapp:
         aliases:
         - workers

..    In general, Compose starts services in reverse order they appear in the file. So, if you want a service to start before all the others, make it the last service in the file file. This applciation relies on a volume and a network, declare those at the bottom of the file.

通常、 Compose はファイルに現れる逆順でサービスの起動を試みます。そのため、あるサービスを他のサービスよりも前に実行するには、ファイル中の最後尾にサービスを記述する必要があります。アプリケーションがボリュームやネットワークを使う場合は、ファイルの末尾で宣言します。

..    Check your work against this result file

3. 結果が `ファイル <https://docs.docker.com/swarm/swarm_at_scale/docker-compose.yml>`_ と一致しているか確認します。

..    When you are satisifed, save the docker-compose.yml file to your system.

4. 問題が無ければ、システム上に ``docker-compose.yml``  ファイルを保存します。

..    Set DOCKER_HOST to the Swarm manager.

5. ``DOCKER_HOST`` を Swarm マネージャに向けます。

.. code-block:: bash

   $ DOCKER_HOST=$(docker-machine ip manager):3376

..    In the same directory as your docker-compose.yml file, start the services.

6. ``docker-compose.yml`` と同じディレクトリで、サービスを起動します。

.. code-block:: bash

   $ docker-compose up -d
   Creating network "scale_voteapp" with the default driver
   Creating volume "scale_db-data" with default driver
   Pulling db (postgres:9.4)...
   worker01: Pulling postgres:9.4... : downloaded
   dbstore: Pulling postgres:9.4... : downloaded
   frontend01: Pulling postgres:9.4... : downloaded
   frontend02: Pulling postgres:9.4... : downloaded
   Creating db
   Pulling redis (redis:latest)...
   dbstore: Pulling redis:latest... : downloaded
   frontend01: Pulling redis:latest... : downloaded
   frontend02: Pulling redis:latest... : downloaded
   worker01: Pulling redis:latest... : downloaded
   Creating redis
   Pulling worker (docker/example-voting-app-worker:latest)...
   dbstore: Pulling docker/example-voting-app-worker:latest... : downloaded
   frontend01: Pulling docker/example-voting-app-worker:latest... : downloaded
   frontend02: Pulling docker/example-voting-app-worker:latest... : downloaded
   worker01: Pulling docker/example-voting-app-worker:latest... : downloaded
   Creating scale_worker_1
   Pulling voting-app (docker/example-voting-app-voting-app:latest)...
   dbstore: Pulling docker/example-voting-app-voting-app:latest... : downloaded
   frontend01: Pulling docker/example-voting-app-voting-app:latest... : downloaded
   frontend02: Pulling docker/example-voting-app-voting-app:latest... : downloaded
   worker01: Pulling docker/example-voting-app-voting-app:latest... : downloaded
   Creating scale_voting-app_1
   Pulling result-app (docker/example-voting-app-result-app:latest)...
   dbstore: Pulling docker/example-voting-app-result-app:latest... : downloaded
   frontend01: Pulling docker/example-voting-app-result-app:latest... : downloaded
   frontend02: Pulling docker/example-voting-app-result-app:latest... : downloaded
   worker01: Pulling docker/example-voting-app-result-app:latest... : downloaded
   Creating scale_result-app_1

..    Use the docker ps command to see the containers on the Swarm cluster.

7. ``docker ps`` コマンドで Swarm クラスタ上のコマンドを確認します。

.. code-block:: bash

   $ docker -H $(docker-machine ip manager):3376 ps
   CONTAINER ID        IMAGE                                  COMMAND                  CREATED             STATUS              PORTS                            NAMES
   b71555033caa        docker/example-voting-app-result-app   "node server.js"         6 seconds ago       Up 4 seconds        192.168.99.104:32774->80/tcp     frontend01/scale_result-app_1
   cf29ea21475d        docker/example-voting-app-worker       "/usr/lib/jvm/java-7-"   6 seconds ago       Up 4 seconds                                         worker01/scale_worker_1
   98414cd40ab9        redis                                  "/entrypoint.sh redis"   7 seconds ago       Up 5 seconds        192.168.99.105:32774->6379/tcp   frontend02/redis
   1f214acb77ae        postgres:9.4                           "/docker-entrypoint.s"   7 seconds ago       Up 5 seconds        5432/tcp                         frontend01/db
   1a4b8f7ce4a9        docker/example-voting-app-voting-app   "python app.py"          7 seconds ago       Up 5 seconds        192.168.99.107:32772->80/tcp     dbstore/scale_voting-app_1

..    When you started the services manually, you had a voting-app instances running on two frontend servers. How many do you have now?

サービスを手動で起動した時は、 ``voting-app`` インスタンスは２つのフロントエンド・ノード上で動作していました。今回はいくつ起動していますか？

..    Scale your application up by adding some voting-app instances.

8. アプリケーションをスケールするため、``voting-app`` インスタンスを追加します。

.. code-block:: bash

   $ docker-compose scale voting-app=3
   Creating and starting 2 ... done
   Creating and starting 3 ... done

..     After you scale up, list the containers on the cluster again.

スケールアップ後は、クラスタ上のコンテナ一覧を再び表示します。

..    Change to the loadbalancer node.

9. ``loadbalancer`` ノードに変更します。

.. code-block:: bash

   $ eval $(docker-machine env loadbalancer)

..    Restart the Nginx server.

10. Nginx サーバを再起動します。

.. code-block:: bash

   $ docker restart nginx

..    Check your work again by visiting the http://vote.myenterprise.com and http://results.myenterprise.com again.

11. ``http://vote.myenterprise.com`` と ``http://results.myenterprise.com`` を再び表示して、投票の動作を確認します。

..    You can view the logs on an indvidual container.

12. 各コンテナのログを表示できます。

.. code-block:: bash

   $ docker logs scale_voting-app_1
    * Running on http://0.0.0.0:80/ (Press CTRL+C to quit)
    * Restarting with stat
    * Debugger is active!
    * Debugger pin code: 285-809-660
   192.168.99.103 - - [11/Apr/2016 17:15:44] "GET / HTTP/1.0" 200 -
   192.168.99.103 - - [11/Apr/2016 17:15:44] "GET /static/stylesheets/style.css HTTP/1.0" 304 -
   192.168.99.103 - - [11/Apr/2016 17:15:45] "GET /favicon.ico HTTP/1.0" 404 -
   192.168.99.103 - - [11/Apr/2016 17:22:24] "POST / HTTP/1.0" 200 -
   192.168.99.103 - - [11/Apr/2016 17:23:37] "POST / HTTP/1.0" 200 -
   192.168.99.103 - - [11/Apr/2016 17:23:39] "POST / HTTP/1.0" 200 -
   192.168.99.103 - - [11/Apr/2016 17:23:40] "POST / HTTP/1.0" 200 -
   192.168.99.103 - - [11/Apr/2016 17:23:41] "POST / HTTP/1.0" 200 -
   192.168.99.103 - - [11/Apr/2016 17:23:43] "POST / HTTP/1.0" 200 -
   192.168.99.103 - - [11/Apr/2016 17:23:44] "POST / HTTP/1.0" 200 -
   192.168.99.103 - - [11/Apr/2016 17:23:46] "POST / HTTP/1.0" 200 -

.. This log shows the activity on one of the active voting application containers.

このログは、ある投票アプリケーション・コンテナの状況を表示しています。


.. Next steps

次のステップ
====================

.. Congratulations. You have successfully walked through manually deploying a microservice-based application to a Swarm cluster. Of course, not every deployment goes smoothly. Now that you’ve learned how to successfully deploy an application at scale, you should learn what to consider when troubleshooting large applications running on a Swarm cluster.

おめでとうございます。マイクロサービスをベースとしたアプリケーションを Swarm クラスタ上に手動でデプロイできました。もちろん、全てが上手く行くとは限りません。どのようにスケールするアプリケーションをデプロイするかを学びましたので、次は :doc:`Swarm クラスタ上で大規模アプリケーション実行時のトラブルシューティング <troubleshoot>` を学ぶべきでしょう。

.. seealso:: 

   Deploy the application
      https://docs.docker.com/swarm/swarm_at_scale/deploy-app/

