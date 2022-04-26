.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/orchestration/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/get-started/orchestration.md
   doc version: 20.10
.. check date: 2022/04/26
.. Commits on Apr 12, 2022 461c6935c4745e50d2ca9f479b225157897c0f45
.. -----------------------------------------------------------------------------

.. Orchestration

.. _production-orchestration:

=======================================
オーケストレーション
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The portability and reproducibility of a containerized process provides an opportunity to move and scale our containerized applications across clouds and datacenters. Containers effectively guarantee that those applications run the same way anywhere, allowing us to quickly and easily take advantage of all these environments. Additionally, as we scale our applications up, we need some tooling to help automate the maintenance of those applications, enable the replacement of failed containers automatically, and manage the rollout of updates and reconfigurations of those containers during their lifecycle.

コンテナ化したプロセスのポータビリティ（移植性）と再利用性が意味するのは、コンテナ化アプリケーションに対し、クラウドやデータセンタを横断して移動およびスケールする機会を提供します。コンテナの効率性を確保するのは、各アプリケーションをどこでも同じ手法によって実行することであり、様々な環境において素早く簡単に利用できるようになります。さらに、アプリケーションのスケールアップをするとき、各アプリケーションの維持を自動的に助けてくれるので、障害の発生したコンテナを自動的に置き換えることも可能です。さらに、更新のロールアウト管理と各コンテナの再設定も、ライフサイクルに含められます。

.. Tools to manage, scale, and maintain containerized applications are called orchestrators, and the most common examples of these are Kubernetes and Docker Swarm. Development environment deployments of both of these orchestrators are provided by Docker Desktop, which we’ll use throughout this guide to create our first orchestrated, containerized application.

ツールは、コンテナ化アプリケーションを管理・スケール・メンテナンスするためのもので、これらを *オーケストレータ（orchestrator） * と呼びます。そして、最もオーケストレータとして例示されるのが *Kubernetes* と *Docker Swarm* です。これらのオーケストレータを使った開発環境のデプロイに、 Docker Desktop が対応しています。このガイドでは、初めてオーケストレートするコンテナ化アプリケーションを作成する場所として、Docker Desktop を使います。

.. The advanced modules teach you how to:

高度な内容を通し、あなたに次の方法を教えます：

..    Set up and use a Kubernetes environment on your development machine
    Set up and use a Swarm environment on your development machine


1. :doc:`開発マシン上で、 Kubernetes 環境のセットアップと利用 <kube-deploy>`
2. :doc:`開発マシン上で、 Docker Swarm のセットアップと利用 <swarm-deploy>`

.. Enable Kubernetes

.. _enable-kubernetes:

Kubernetes の有効化
====================

.. Docker Desktop will set up Kubernetes for you quickly and easily. Follow the setup and validation instructions appropriate for your operating system:

Docker Desktop は Kubernetes を素早く簡単にセットアップします。以下のセットアップと様々な手順は、適切なオペレーティングシステムを選んでください。

..  Mac
    Windows

Mac
----------

..    After installing Docker Desktop, you should see a Docker icon in your menu bar. Click on it, and navigate to Preferences > Kubernetes.

1. Docker Desktop をインストールしたら、メニューバー上に Docker アイコンが見えるでしょう。それをクリックし、 **Preferences > Kubernetes** を選びます。

..    Check the checkbox labeled Enable Kubernetes, and click Apply & Restart. Docker Desktop will automatically set up Kubernetes for you. You’ll know that Kubernetes has been successfully enabled when you see a green light beside ‘Kubernetes running’ in the Preferences menu.

2. **Enable Kubernetes**  とラベルのついたチェックボックスにチェックを入れ、 **Apply & Restart** をクリックします。Docker Desktop は自動的に Kubernetes をセットアップします。設定上のメニューで「Kubernetes running」と横に緑のライトが付いていれば、Kubernetes は正常に有効化されたことが分かります。

..    In order to confirm that Kubernetes is up and running, create a text file called pod.yaml with the following content:

3. Kubernetes が起動して動いているのを確認するためには、 ``pod.yaml``  と名前の付いたテキストファイルを作成し、以下の内容を記述します。

::

   apiVersion: v1
   kind: Pod
   metadata:
     name: demo
   spec:
     containers:
     - name: testpod
       image: alpine:latest
       command: ["ping", "8.8.8.8"]

..    This describes a pod with a single container, isolating a simple ping to 8.8.8.8.

これは pod 内に１つのコンテナが隔離された状態で、シンプルに 8.8.8.8 に対して ping を実行します。

..    In a terminal, navigate to where you created pod.yaml and create your pod:

4. それからターミナル上で、 ``pod.yaml`` を作成した場所に移動し、pod を作成します。

.. code-block:: bash

   $ kubectl apply -f pod.yaml

..    Check that your pod is up and running:

5. ポッドが起動して動いているかどうか調べます。

.. code-block:: bash

   $ kubectl get pods

..    You should see something like:

次のような表示が見えます：

.. code-block:: bash

   NAME      READY     STATUS    RESTARTS   AGE
   demo      1/1       Running   0          4s

..    Check that you get the logs you’d expect for a ping process:

6. ログを取得し、 ping プロセスの動作が期待通りかどうかを確認します。

.. code-block:: bash

   $ kubectl logs demo

..    You should see the output of a healthy ping process:

このように正常な ping プロセスが見えるでしょう。

.. code-block:: bash

   PING 8.8.8.8 (8.8.8.8): 56 data bytes
   64 bytes from 8.8.8.8: seq=0 ttl=37 time=21.393 ms
   64 bytes from 8.8.8.8: seq=1 ttl=37 time=15.320 ms
   64 bytes from 8.8.8.8: seq=2 ttl=37 time=11.111 ms
   ...

..    Finally, tear down your test pod:

7. 最後に、テスト pod を解体（tear down）します。

.. code-block:: bash

   $ kubectl delete -f pod.yaml



Windows
----------

..    After installing Docker Desktop, you should see a Docker icon in your menu bar. Click on it, and navigate to Preferences > Kubernetes.

1. Docker Desktop をインストールしたら、メニューバー上に Docker アイコンが見えるでしょう。それをクリックし、 **Preferences > Kubernetes** を選びます。

..    Check the checkbox labeled Enable Kubernetes, and click Apply & Restart. Docker Desktop will automatically set up Kubernetes for you. You’ll know that Kubernetes has been successfully enabled when you see a green light beside ‘Kubernetes running’ in the Preferences menu.

2. **Enable Kubernetes**  とラベルのついたチェックボックスにチェックを入れ、 **Apply & Restart** をクリックします。Docker Desktop は自動的に Kubernetes をセットアップします。設定上のメニューで「Kubernetes running」と横に緑のライトが付いていれば、Kubernetes は正常に有効化されたことが分かります。

..    In order to confirm that Kubernetes is up and running, create a text file called pod.yaml with the following content:

3. Kubernetes が起動して動いているのを確認するためには、 ``pod.yaml``  と名前の付いたテキストファイルを作成し、以下の内容を記述します。

::

   apiVersion: v1
   kind: Pod
   metadata:
     name: demo
   spec:
     containers:
     - name: testpod
       image: alpine:latest
       command: ["ping", "8.8.8.8"]

..    This describes a pod with a single container, isolating a simple ping to 8.8.8.8.

これは pod 内に１つのコンテナが隔離された状態で、シンプルに 8.8.8.8 に対して ping を実行します。

..    In a terminal, navigate to where you created pod.yaml and create your pod:

4. それから PowerShell 上で、 ``pod.yaml`` を作成した場所に移動し、pod を作成します。

.. code-block:: bash

   $ kubectl apply -f pod.yaml

..    Check that your pod is up and running:

5. ポッドが起動して動いているかどうか調べます。

.. code-block:: bash

   $ kubectl get pods

..    You should see something like:

次のような表示が見えます：

.. code-block:: bash

   NAME      READY     STATUS    RESTARTS   AGE
   demo      1/1       Running   0          4s

..    Check that you get the logs you’d expect for a ping process:

6. ログを取得し、 ping プロセスの動作が期待通りかどうかを確認します。

.. code-block:: bash

   $ kubectl logs demo

..    You should see the output of a healthy ping process:

このように正常な ping プロセスが見えるでしょう。

.. code-block:: bash

   PING 8.8.8.8 (8.8.8.8): 56 data bytes
   64 bytes from 8.8.8.8: seq=0 ttl=37 time=21.393 ms
   64 bytes from 8.8.8.8: seq=1 ttl=37 time=15.320 ms
   64 bytes from 8.8.8.8: seq=2 ttl=37 time=11.111 ms
   ...

..    Finally, tear down your test pod:

7. 最後に、テスト pod を解体（tear down）します。

.. code-block:: bash

   $ kubectl delete -f pod.yaml

Enable Docker Swarm

Docker Swarm の有効化
==============================

.. Docker Desktop runs primarily on Docker Engine, which has everything you need to run a Swarm built in. Follow the setup and validation instructions appropriate for your operating system:

Docker Desktop の Docker Engine に対して、実行に必要なすべてを内蔵 Swarm で優先処理するようにします。オペレーティングシステムにあわせて、適切なセットアップと手順に従ってください。

..  Mac
    Windows

Mac
----------

..    Open a terminal, and initialize Docker Swarm mode:

1. ターミナルを開き、Docker Swarm モードを初期化します。

.. code-block:: bash

   $ docker swarm init

..    If all goes well, you should see a message similar to the following:

全てうまくいけば、以下のようなメッセージを表示します：

.. code-block:: bash

   Swarm initialized: current node (tjjggogqpnpj2phbfbz8jd5oq) is now a manager.
   
   To add a worker to this swarm, run the following command:
   
       docker swarm join --token SWMTKN-1-3e0hh0jd5t4yjg209f4g5qpowbsczfahv2dea9a1ay2l8787cf-2h4ly330d0j917ocvzw30j5x9 192.168.65.3:2377
   
   To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

..    Run a simple Docker service that uses an alpine-based filesystem, and isolates a ping to 8.8.8.8:

2. シンプルな Docker サービスを起動します。alpine をベースとしたファイルシステムを使い、8.8.8.8 に対する ping を隔離（isolate）します。

.. code-block:: bash

   $ docker service create --name demo alpine:3.5 ping 8.8.8.8

..    Check that your service created one running container:

3. 確認のため、コンテナを１つ実行するサービスを作成します。

.. code-block:: bash

   $ docker service ps demo

..    You should see something like:

以下のような表示があります：

.. code-block:: bash

   ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
   463j2s3y4b5o        demo.1              alpine:latest       docker-desktop      Running             Running 8 seconds ago

..    Check that you get the logs you’d expect for a ping process:

4. ログを取得し、ping プロセスが期待通りに動いているのを確認します。

.. code-block:: bash

   $ docker service logs demo

..    You should see the output of a healthy ping process:

次のような正常な ping プロセスが見えるでしょう。

.. code-block:: bash

   demo.1.463j2s3y4b5o@docker-desktop    | PING 8.8.8.8 (8.8.8.8): 56 data bytes
   demo.1.463j2s3y4b5o@docker-desktop    | 64 bytes from 8.8.8.8: seq=0 ttl=37 time=13.005 ms
   demo.1.463j2s3y4b5o@docker-desktop    | 64 bytes from 8.8.8.8: seq=1 ttl=37 time=13.847 ms
   demo.1.463j2s3y4b5o@docker-desktop    | 64 bytes from 8.8.8.8: seq=2 ttl=37 time=41.296 ms
   ...

..    Finally, tear down your test service:

5. 最後にテストサービスを解体します。

    $ docker service rm demo



Windows
----------

..    Open a powershell, and initialize Docker Swarm mode:

1. PowerShell を開き、Docker Swarm モードを初期化します。

.. code-block:: bash

   $ docker swarm init

..    If all goes well, you should see a message similar to the following:

全てうまくいけば、以下のようなメッセージを表示します：

.. code-block:: bash

   Swarm initialized: current node (tjjggogqpnpj2phbfbz8jd5oq) is now a manager.
   
   To add a worker to this swarm, run the following command:
   
       docker swarm join --token SWMTKN-1-3e0hh0jd5t4yjg209f4g5qpowbsczfahv2dea9a1ay2l8787cf-2h4ly330d0j917ocvzw30j5x9 192.168.65.3:2377
   
   To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.

..    Run a simple Docker service that uses an alpine-based filesystem, and isolates a ping to 8.8.8.8:

2. シンプルな Docker サービスを起動します。alpine をベースとしたファイルシステムを使い、8.8.8.8 に対する ping を隔離（isolate）します。

.. code-block:: bash

   $ docker service create --name demo alpine:3.5 ping 8.8.8.8

..    Check that your service created one running container:

3. 確認のため、コンテナを１つ実行するサービスを作成します。

.. code-block:: bash

   $ docker service ps demo

..    You should see something like:

以下のような表示があります：

.. code-block:: bash

   ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
   463j2s3y4b5o        demo.1              alpine:latest       docker-desktop      Running             Running 8 seconds ago

..    Check that you get the logs you’d expect for a ping process:

4. ログを取得し、ping プロセスが期待通りに動いているのを確認します。

.. code-block:: bash

   $ docker service logs demo

..    You should see the output of a healthy ping process:

次のような正常な ping プロセスが見えるでしょう。

.. code-block:: bash

   demo.1.463j2s3y4b5o@docker-desktop    | PING 8.8.8.8 (8.8.8.8): 56 data bytes
   demo.1.463j2s3y4b5o@docker-desktop    | 64 bytes from 8.8.8.8: seq=0 ttl=37 time=13.005 ms
   demo.1.463j2s3y4b5o@docker-desktop    | 64 bytes from 8.8.8.8: seq=1 ttl=37 time=13.847 ms
   demo.1.463j2s3y4b5o@docker-desktop    | 64 bytes from 8.8.8.8: seq=2 ttl=37 time=41.296 ms
   ...

..    Finally, tear down your test service:

5. 最後にテストサービスを解体します。

   $ docker service rm demo


.. Conclusion

まとめ
==========

.. At this point, you’ve confirmed that you can run simple containerized workloads in Kubernetes and Swarm. The next step will be to write the Kubernetes yaml that describes how to run and manage these containers on Kubernetes.

この時点で、Kubernetes と Swarm でシンプルなコンテナ化ワークロードの実行を確認しました。次のステップでは、 Kubernetes 上でコンテナを実行・管理する方法を Kubernetes yaml に書きます。

.. On to deploying to Kubernetes >>

* :doc:`Kubernetes へのデプロイに続く <kube-deploy>`

.. To learn how to write the stack file to help you run and manage containers on Swarm, see Deploying to Swarm.

Swarm 上でコンテナの実行と管理に役立つ stack ファイルを書く方法について学ぶには、 :doc:`swarm-deploy` をご覧ください。


.. CLI references

CLI リファレンス
====================

.. Further documentation for all CLI commands used in this article are available here:

この記事で使った CLI コマンドのすべての詳細ドキュメントは、以下にあります。

* `kubectl apply <https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#apply>`
* `kubectl get <https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#get>`_
* `kubectl logs <https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#logs>`_
* `kubectl delete <https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands#delete>`_
* :doc:`docker swarm init </engine/reference/commandline/swarm_init>`
* :doc:`docker service * </engine/reference/commandline/service>`


.. seealso:: 
   Orchestration
     https://docs.docker.com/get-started/orchestration/


