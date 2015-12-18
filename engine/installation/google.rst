.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/installation/google/
.. doc version: 1.9
.. check date: 2015/12/18
.. -----------------------------------------------------------------------------

.. Google Cloud Platform

==============================
Google Cloud Platform
==============================

.. QuickStart with Container-optimized Google Compute Engine images

コンテナに最適化した Google Compute Engine イメージのクイックスタート
======================================================================

..    Go to Google Cloud Console and create a new Cloud Project with Compute Engine enabled

1. `Google Cloud コンソール <https://cloud.google.com/console>`_ に移動し、 `Compute Engine を有効 <https://developers.google.com/compute/docs/signup>`_ にして新しいクラウド・プロジェクトを開始します。

..    Download and configure the Google Cloud SDK to use your project with the following commands:

2. `Google Cloud SDK <https://developers.google.com/cloud/sdk>`_ をダウンロード・設定するために、プロジェクトで次のコマンドを実行します。

.. code-block:: bash

   $ curl -sSL https://sdk.cloud.google.com | bash
   $ gcloud auth login
   $ gcloud config set project <google-cloud-project-id>

..    Start a new instance using the latest Container-optimized image: (select a zone close to you and the desired instance size)

3. 最新の `コンテナ最適化イメージ <https://developers.google.com/compute/docs/containers#container-optimized_google_compute_engine_images>`_ を使って新しいインスタンスを起動します（近いゾーンと希望のインスタンス・サイズを選びます）。

.. code-block:: bash

   $ gcloud compute instances create docker-playground \
     --image container-vm \
     --zone us-central1-a \
     --machine-type f1-micro

..    Connect to the instance using SSH:

4. インスタンスに SSH で接続します。

.. code-block:: bash

   $ gcloud compute ssh --zone us-central1-a docker-playground
   docker-playground:~$ sudo docker run hello-world

..    Hello from Docker. This message shows that your installation appears to be working correctly. …

Docker から Hello メッセージが表示されます。メッセージが表示されれば、インストールが正常に行われたと分かります。

.. Read more about deploying Containers on Google Cloud Platform.

詳細については `Google Cloud Platform 上でコンテナのデプロイ <https://developers.google.com/compute/docs/containers>`_ をお読みください。

