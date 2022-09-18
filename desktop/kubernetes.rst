.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/kubernetes/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/kubernetes.md
.. check date: 2022/09/17
.. Commits on Jun 22, 2022 f55713644649680eb8000f660c99400d27f4afdc
.. -----------------------------------------------------------------------------

.. Deploy on Kubernetes
.. _desktop-deploy-on-kubernetes:

=======================================
Kubernetes にデプロイ
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. Docker Desktop includes a standalone Kubernetes server and client, as well as Docker CLI integration that runs on your machine.

Docker Desktop には :ruby:`単独 <standalone>` の Kubernetes サーバとクライアントが入っているだけでなく、マシン上で実行できる Docker CLI 統合も入っています。

.. The Kubernetes server runs locally within your Docker instance, is not configurable, and is a single-node cluster. It runs within a Docker container on your local system, and is only for local testing.

Docker 内部でローカルの Kubernetes サーバを実行するのは、設定が不要な１つのノードだけのクラスタです。 Kubernetes はローカルシステム上で Docker コンテナ内で実行しますが、ローカルのテスト専用です。

.. Enabling Kubernetes allows you to deploy your workloads in parallel, on Kubernetes, Swarm, and as standalone containers. Enabling or disabling the Kubernetes server does not affect your other workloads.

Kubernetes の有効化により、 Kubernetes、 Swarm に対し、ワークロードを並列にスタンドアロン コンテナとしてデプロイできます。

.. Enable Kubernetes
.. _desktop-enable-kubernetes:

Kubernetes 有効化
====================

.. To enable Kubernetes in Docker Desktop:

Docker Desktop で Kubernetes を有効化するには：

..  From the Docker Dashboard, select the Setting icon, or Preferences icon if you use a macOS.
    Select Kubernetes from the left sidebar.
    Next to Enable Kubernetes, select the checkbox.
    Select Apply & Restart to save the settings and then click Install to confirm. This instantiates images required to run the Kubernetes server as containers, and installs the /usr/local/bin/kubectl command on your machine.

1. Docker ダッシュボードから **Setting** アイコンをクリックするか、 macOS を使う場合は **Preferences** アイコンをクリックする。
2. 左のサイドバーから **Kubernetes** を選択する。
3. **Enable Kubernetes** の横にあるチェックボックスを選ぶ。
4. 設定を保存するには **Apply & Restart** をクリックし、確認のために **Install** をクリックする。これで Kubernetes サーバをコンテナとして実行するために必要なイメージがインスタンス化されます。そして、マシン上に ``/usr/local/bin/kubectl`` をインストールします。

.. By default, Kubernetes containers are hidden from commands like docker ps, because managing them manually is not supported. Most users do not need this option. To see these internal containers, select Show system containers (advanced).

デフォルトでは、 Kubernetes コンテナは ``docker ps`` のようなコマンドから隠されているため、手動での操作はサポートされていません。多くのユーザはこのオプションが不要です。これら内部コンテナを見るには、 **Show system containers (advaonced)** を選びます。

.. When Kubernetes is enabled and running, an additional status bar in the Dashboard footer and Docker menu displays.

Kubernetes を有効化して実行すると、ダッシュボードのフッタと Docker メニューに追加ステータスバーが表示されます。

..    Note
    Docker Desktop does not upgrade your Kubernetes cluster automatically after a new update. To upgrade your Kubernetes cluster to the latest version, select Reset Kubernetes Cluster.

.. note::

   Docker Desktop を新しく更新しても、Kubernetes クラスタは自動的に更新されません。Kubernetes クラスタを最新版に更新するには、 **Reset Kubernetes Cluster** を選びます。

.. Use the kubectl command
.. _desktop-use-the-kubectl-command:

kubectl コマンドを使う
==============================

.. Kubernetes integration provides the Kubernetes CLI command at /usr/local/bin/kubectl on Mac and at C:\>Program Files\Docker\Docker\Resources\bin\kubectl.exe on Windows. This location may not be in your shell’s PATH variable, so you may need to type the full path of the command or add it to the PATH.

Kubernetes 統合により、Kubernetes CLI コマンドが Mac では ``/usr/local/bin/kubectl`` 、 Windows では ``C:\>Program Files\Docker\Docker\Resources\bin\kubectl.exe`` が提供されます。この場所が自分のシェルの ``PATH`` 環境変数に入っていない場合がありますので、コマンドを実行するにはフルパスを指定するか、コマンドへのパスを ``PATH`` に追加します。

.. The kubectl binary is not automatically packaged with Docker Desktop for Linux. To install the kubectl command for Linux, see Kubernetes documentation. It should be installed at /usr/local/bin/kubectl.

Docker Desktop for Linux では、パッケージに kubectl バイナリは入っていません。Linux で kubectl コマンドをインストールするには、 `Kubernetes のドキュメント <https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/>`_ をご覧ください。インストール先は ``/usr/local/bin/kubectl`` にすべきです。

.. If you have already installed kubectl and it is pointing to some other environment, such as minikube or a GKE cluster, ensure you change the context so that kubectl is pointing to docker-desktop:

既に ``kubectl`` をインストール済みで、 ``minikube`` や GKE クラスタのような他の環境を示している場合は、コンテクストを切り替えて ``kubectl`` が ``docker-desktop`` を示すようにします。

.. code-block:: bash

   $ kubectl config get-contexts
   $ kubectl config use-context docker-desktop

..   Note
    Run the kubectl command in a CMD or PowerShell terminal, otherwise kubectl config get-contexts may return an empty result.

   CMD や PowerShell ターミナルで ``kubectl`` コマンドを実行しても、 ``kubectl config get-contexts`` は何も応答しないでしょう。

   ..    If you are using a different terminal and this happens, you can try setting the kubeconfig environment variable to the location of the .kube/config file.
   
   他のターミナルを使う場合でもこの状況になるのなら、 ``.kube/config`` ファイルで ``kubeconfig`` 環境変数の設定を試みてください。

.. If you installed kubectl using Homebrew, or by some other method, and experience conflicts, remove /usr/local/bin/kubectl.

Homebrew を使うか他の手法で ``kubectl`` をインストールし、競合する場合は ``/usr/local/bin/kubectl`` を削除します。

.. You can test the command by listing the available nodes:

利用可能なノードを一覧表示して、コマンドをテストできます。

.. code-block:: bash

   $ kubectl get nodes
   
   NAME                 STATUS    ROLES     AGE       VERSION
   docker-desktop       Ready     master    3h        v1.19.7

.. For more information about kubectl, see the kubectl documentation.

``kubectl`` についての情報は、 `kubectl ドキュメント <https://kubernetes.io/docs/reference/kubectl/overview/>`_ をご覧ください。

.. Disable Kubernetes
.. _desktop-disable-kubernetes:

Kubernetes の無効化
==============================

.. To disable Kubernetes in Docker Desktop:

Docker Desktop で Kubernetes を無効化するには、次のように実行します：

..    From the Docker Dashboard, select the Setting icon, or Preferences icon if you use a macOS.
    Select Kubernetes from the left sidebar.
    Next to Enable Kubernetes, clear the checkbox
    Select Apply & Restart to save the settings.This stops and removes Kubernetes containers, and also removes the /usr/local/bin/kubectl command.

1. Docker ダッシュボードから **Setting** アイコンをクリックするか、 macOS を使う場合は **Preferences** アイコンをクリックする。
2. 左のサイドバーから **Kubernetes** を選択する。
3. **Enable Kubernetes** の横にあるチェックボックスをクリアする。
4. 設定を保存するには **Apply & Restart** をクリックします。これで Kubernetes コンテナを停止・削除して、それからマシン上に ``/usr/local/bin/kubectl`` を削除します。

.. seealso::

   Deploy on Kubernetes
      https://docs.docker.com/desktop/kubernetes/
