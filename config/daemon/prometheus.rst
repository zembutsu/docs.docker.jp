.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/daemon/prometheus/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/daemon/prometheus.md
   doc version: 19.03
.. check date: 2020/06/23
.. Commits on May 30, 2020 ba553cfd47bd9c8ef100f242dce270e2c840ab29
.. ---------------------------------------------------------------------------

.. Collect Docker metrics with Prometheus

.. _collect-docker-metrics-with-prometheus:

=======================================
Docker メトリクスを Prometheus で収集
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Prometheus is an open-source systems monitoring and alerting toolkit. You can configure Docker as a Prometheus target. This topic shows you how to configure Docker, set up Prometheus to run as a Docker container, and monitor your Docker instance using Prometheus.

`Prometheus <https://prometheus.io/>`_ はオープンソースのシステム監視と通知ツールキットです。Docker を Prometheus のターゲットに設定できます。このトピックで紹介するのは、Prometheus を Docker コンテナとして実行するようセットアップする方法と、Prometheus を使って Docker そのものを監視します。

..    Warning: The available metrics and the names of those metrics are in active development and may change at any time.

.. warning::

   利用可能なメトリクスとこれらメトリクス名は、アクティブな開発下にあるため、いつでも変わる可能性があります。

.. Currently, you can only monitor Docker itself. You cannot currently monitor your application using the Docker target.

現時点では、Docker 自身のみを監視できます。Docker ターゲットを使ってアプリケーションの監視は現在できません。

.. Configure Docker

Docker の設定
====================

.. To configure the Docker daemon as a Prometheus target, you need to specify the metrics-address. The best way to do this is via the daemon.json, which is located at one of the following locations by default. If the file does not exist, create it.

Docker デーモンを Prometheus ターゲットとして設定するには、 ``metrics-address`` を指定する必要があります。この指定にベストな方法は ``damon.json`` を経由するもので、デフォルトでそれぞれ以下の場所にあります。もしもファイルが無ければ作成します。

..  Linux: /etc/docker/daemon.json
    Windows Server: C:\ProgramData\docker\config\daemon.json
    Docker Desktop for Mac / Docker Desktop for Windows: Click the Docker icon in the toolbar, select Preferences, then select Daemon. Click Advanced.

* **Linux,** : ``/etc/docker/daemon.json``
* **Windows Server** : ``C:\ProgramData\docker\config\daemon.json``
* **Docker Desktop for Mac / Docker Desktop for Windows** : ツールバー上の Docker アイコンをクリックし、 **Preferences** を選び、 **Daemon** を選び、 **Advanced** をクリック

.. If the file is currently empty, paste the following:

もしもファイルが無ければ、以下の内容をペーストします。

::

   {
     "metrics-addr" : "127.0.0.1:9323",
     "experimental" : true
   }

.. If the file is not empty, add those two keys, making sure that the resulting file is valid JSON. Be careful that every line ends with a comma (,) except for the last line.

ファイルが空でなければ、これら2つのキーを追加し、結果的に有効な JSON ファイルになることを確認島須。最後の行を除き、各行の最後はカンマ（ ``,`` ）で区切りますので、注意してください。

.. Save the file, or in the case of Docker Desktop for Mac or Docker Desktop for Windows, save the configuration. Restart Docker.

ファイルを保存します。あるいは Docker Desktop for Mac や Docker Desktop for Windows であれば設定を保存します。それから、Docker を再起動します。

.. Docker now exposes Prometheus-compatible metrics on port 9323.

以上で Docker はポート 9323 上で Prometheus 互換のメトリクスを出力します。

.. Configure and run Prometheus

.. _configure-and-run-prometheus:

Prometheus の設定と実行
==============================

.. Prometheus runs as a Docker service on a Docker swarm.

Prometheus は Docker Swarm 上の Docker サービスとして実行します。

..    Prerequisites
        One or more Docker engines are joined into a Docker swarm, using docker swarm init on one manager and docker swarm join on other managers and worker nodes.
        You need an internet connection to pull the Prometheus image.

.. note::

   事前準備
   
   1. １つまたは複数の Docker Engine を Docker swarm に参加するため、マネージャでは ``docker swarm init`` を使い、他のマネージャとワーカ・ノードは ``docker swarm join`` を使う。
   2. Prometheus イメージの取得のためには、インターネット接続が必要。

.. Copy one of the following configuration files and save it to /tmp/prometheus.yml (Linux or Mac) or C:\tmp\prometheus.yml (Windows). This is a stock Prometheus configuration file, except for the addition of the Docker job definition at the bottom of the file. Docker Desktop for Mac and Docker Desktop for Windows need a slightly different configuration.

以下の設定ファイルを、（Linux か Mac は） ``/tmp/prometheus.yml`` に保存するか、（WIndows は） ``C:\tmp\prometheus.yml`` に保存。これは Prometheus 設定ファイルのストックであり、ファイルの末尾に Docker ジョブ定義がなければ追加します。Docker Desktop for Mac と Docker Desktop for Windows の場合は、少々設定ファイルが変わります。

..  Docker for Linux
    Docker Desktop for Mac
    Docker Desktop for Windows


* Docker for Linux

::

   # my global config
   global:
     scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
     evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
     # scrape_timeout is set to the global default (10s).
   
     # Attach these labels to any time series or alerts when communicating with
     # external systems (federation, remote storage, Alertmanager).
     external_labels:
         monitor: 'codelab-monitor'
   
   # Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
   rule_files:
     # - "first.rules"
     # - "second.rules"
   
   # A scrape configuration containing exactly one endpoint to scrape:
   # Here it's Prometheus itself.
   scrape_configs:
     # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
     - job_name: 'prometheus'
   
       # metrics_path defaults to '/metrics'
       # scheme defaults to 'http'.
   
       static_configs:
         - targets: ['localhost:9090']
   
     - job_name: 'docker'
            # metrics_path defaults to '/metrics'
            # scheme defaults to 'http'.
   
       static_configs:
         - targets: ['localhost:9323']


* Docker Desktop for Mac

::

   # my global config
   global:
     scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
     evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
     # scrape_timeout is set to the global default (10s).
   
     # Attach these labels to any time series or alerts when communicating with
     # external systems (federation, remote storage, Alertmanager).
     external_labels:
         monitor: 'codelab-monitor'
   
   # Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
   rule_files:
     # - "first.rules"
     # - "second.rules"
   
   # A scrape configuration containing exactly one endpoint to scrape:
   # Here it's Prometheus itself.
   scrape_configs:
     # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
     - job_name: 'prometheus'
   
       # metrics_path defaults to '/metrics'
       # scheme defaults to 'http'.
   
       static_configs:
         - targets: ['host.docker.internal:9090'] # Only works on Docker Desktop for Mac
   
     - job_name: 'docker'
            # metrics_path defaults to '/metrics'
            # scheme defaults to 'http'.
   
       static_configs:
         - targets: ['docker.for.mac.host.internal:9323']

* Docker Desktop for Windows

::

   # my global config
   global:
     scrape_interval:     15s # Set the scrape interval to every 15 seconds. Default is every 1 minute.
     evaluation_interval: 15s # Evaluate rules every 15 seconds. The default is every 1 minute.
     # scrape_timeout is set to the global default (10s).
   
     # Attach these labels to any time series or alerts when communicating with
     # external systems (federation, remote storage, Alertmanager).
     external_labels:
         monitor: 'codelab-monitor'
   
   # Load rules once and periodically evaluate them according to the global 'evaluation_interval'.
   rule_files:
     # - "first.rules"
     # - "second.rules"
   
   # A scrape configuration containing exactly one endpoint to scrape:
   # Here it's Prometheus itself.
   scrape_configs:
     # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
     - job_name: 'prometheus'
   
       # metrics_path defaults to '/metrics'
       # scheme defaults to 'http'.
   
       static_configs:
         - targets: ['host.docker.internal:9090'] # Only works on Docker Desktop for Windows
   
     - job_name: 'docker'
            # metrics_path defaults to '/metrics'
            # scheme defaults to 'http'.
   
       static_configs:
         - targets: ['192.168.65.1:9323']


.. Next, start a single-replica Prometheus service using this configuration.

次は、この設定を使い、レプリカ１つの Prometheus サービスを起動します。

..     Docker for Linux
    Docker Desktop for Mac
    Docker Desktop for Windows or Windows Server


* Docker for Linux

.. code-block:: bash

   $ docker service create --replicas 1 --name my-prometheus \
       --mount type=bind,source=/tmp/prometheus.yml,destination=/etc/prometheus/prometheus.yml \
       --publish published=9090,target=9090,protocol=tcp \
       prom/prometheus

* Docker Desktop for Mac

.. code-block:: bash

   $ docker service create --replicas 1 --name my-prometheus \
       --mount type=bind,source=/tmp/prometheus.yml,destination=/etc/prometheus/prometheus.yml \
       --publish published=9090,target=9090,protocol=tcp \
       prom/prometheus

* Docker Desktop for Windows or Windows Server

.. code-block:: bash

   PS C:\> docker service create --replicas 1 --name my-prometheus
       --mount type=bind,source=C:/tmp/prometheus.yml,destination=/etc/prometheus/prometheus.yml
       --publish published=9090,target=9090,protocol=tcp
       prom/prometheus

.. Verify that the Docker target is listed at http://localhost:9090/targets/.

Docker ターゲットが  http://localhost:9090/targets/ の一覧にあるのを確認します。

.. Prometheus targets page

.. You can’t access the endpoint URLs directly if you use Docker Desktop for Mac or Docker Desktop for Windows.

もしも Docker Desktop for Mac や Docker Desktop for Windows を使っている場合は、このエンドポイント URL に直接アクセスできません。

.. Use Prometheus

Prometheus を使う
====================

.. Create a graph. Click the Graphs link in the Prometheus UI. Choose a metric from the combo box to the right of the Execute button, and click Execute. The screenshot below shows the graph for engine_daemon_network_actions_seconds_count.

グラフを作成します。 Prometheus UI の **Graphs**  のリンクをクリックします。**Execute**  ボタンの右側にあるコンボボックスからメトリックを選択し、 **Execute** をクリックします。以下のスクリーンショットは、 ``engine_daemon_network_actions_seconds_count`` に対するグラフです。

.. Prometheus engine_daemon_network_actions_seconds_count report

.. The above graph shows a pretty idle Docker instance. Your graph might look different if you are running active workloads.

この上のグラフが表すのは、Docker インスタンスが多少アイドル状態です。アクティブな処理を実行中であれば、グラフは異なったものになるでしょう。

.. To make the graph more interesting, create some network actions by starting a service with 10 tasks that just ping Docker non-stop (you can change the ping target to anything you like):

グラフをもっと面白くするために、10 タスクを持つサービスを起動し、Docker にノンストップで ping を実行し（ping のターゲットは任意に選べます）ネットワークのアクションを作成しましょう。

.. code-block:: bash

   $ docker service create \
     --replicas 10 \
     --name ping_service \
     alpine ping docker.com

.. Wait a few minutes (the default scrape interval is 15 seconds) and reload your graph.

少々待つと（デフォルトでは再読込間隔は 15 秒です）、グラフを再読込します。

.. Prometheus engine_daemon_network_actions_seconds_count report

.. When you are ready, stop and remove the ping_service service, so that you are not flooding a host with pings for no reason.

準備ができたら、 ``ping_service`` の停止と削除をします。ホスト上で ping の洪水を起こしてよい理由はありません。

.. code-block:: bash

   $ docker service remove ping_service

.. Wait a few minutes and you should see that the graph falls back to the idle level.

少々待つと、グラフが元のレベルにまで戻るのが見えるでしょう。



.. Next steps

次のステップ
====================

..  Read the Prometheus documentation
    Set up some alerts

* `Prometheus ドキュメント <https://prometheus.io/docs/introduction/overview/>`_ を読む
* `アラート <https://prometheus.io/docs/alerting/overview/>`_ のセットアップ


.. seealso:: 

   Collect Docker metrics with Prometheus
      https://docs.docker.com/config/daemon/systemd/
