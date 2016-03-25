.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/drivers/gce/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/drivers/gce.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/drivers/gce.md
.. check date: 2016/03/09
.. Commits on Jan 11, 2016 52bd740ad353a6b1a582668f4da76b8b38a9c89f
.. ----------------------------------------------------------------------------

.. Google Compute Engine

.. _driver-google-compute-engine:

=======================================
Google Compute Engine
=======================================

.. Create machines on Google Compute Engine. You will need a Google account and a project id. See https://cloud.google.com/compute/docs/projects for details on projects.

`Google Compute Engine <https://cloud.google.com/compute/>`_ 上にマシンを作成します。Google アカウントとプロジェクト ID が必要になるでしょう。プロジェクトの詳細については https://cloud.google.com/compute/docs/projects をご覧ください。

.. Credentials

証明書（Credentials）
==============================

.. The Google driver uses Application Default Credentials to get authorization credentials for use in calling Google APIs.

Google ドライバは Google API を呼び出して使うために、 `Application Default Credentials <https://developers.google.com/identity/protocols/application-default-credentials>`_ を用いて認証を行います。

.. So if docker-machine is used from a GCE host, authentication will happen automatically via the built-in service account. Otherwise, install gcloud and get through the oauth2 process with gcloud auth login.

そのため、 ``docker-machine`` を GCE ホストから使う場合、サービス・アカウントに組み込まれている認証情報が自動的に使われます。あるいは、 `gcloud をインストール <https://cloud.google.com/sdk/>`_ し、 ``gcloud auth login`` で oauth2 プロセスを通すこともできます。

.. Example

例
==========

.. To create a machine instance, specify --driver google, the project id and the machine name.

マシン・インスタンスを作成するには、 ``--driver google`` 、プロジェクト ID 、マシン名を指定します。

.. code-block:: bash

   $ gcloud auth login
   $ docker-machine create --driver google --google-project PROJECT_ID vm01
   $ docker-machine create --driver google \
     --google-project PROJECT_ID \
     --google-zone us-central1-a \
     --google-machine-type f1-micro \
     vm02

.. Options

オプション
==========

..    --google-project: required The id of your project to use when launching the instance.
        --google-zone: The zone to launch the instance.
        --google-machine-type: The type of instance.
        --google-machine-image: The absolute URL to a base VM image to instantiate.
        --google-username: The username to use for the instance.
        --google-scopes: The scopes for OAuth 2.0 to Access Google APIs. See Google Compute Engine Doc.
        --google-disk-size: The disk size of instance.
        --google-disk-type: The disk type of instance.
        --google-address: Instance’s static external IP (name or IP).
        --google-preemptible: Instance preemptibility.
        --google-tags: Instance tags (comma-separated).
        --google-use-internal-ip: When this option is used during create it will make docker-machine use internal rather than public NATed IPs. The flag is persistent in the sense that a machine created with it retains the IP. It’s useful for managing docker machines from another machine on the same network e.g. while deploying swarm.

* ``--google-project`` : **必須** インスタンスを起動するとき似使うプロジェクト ID。
* ``--google-zone`` : インスタンスを起動するゾーン。
* ``--google-machine-type`` : インスタンスの種類。
* ``--google-machine-image`` : インスタンスに使うベース VM イメージ用の絶対 URL 。
* ``--google-username`` : インスタンスに使うユーザ名。
* ``--google-scopes`` : Google API にアクセスする OAuth 2.0 の範囲（scope）。詳細は `Google Compute Engine のドキュメント <https://cloud.google.com/storage/docs/authentication>`_ 。
* ``--google-disk-size`` : インスタンスのディスク容量。
* ``--google-disk-type`` : インスタンスのディスク種類。
* ``--google-address`` : インスタンスの静的な外部 IP （名前か IP ）
* ``--google-preemptible`` : インスタンスの先行取得（preemptibility） 。
* ``--google-tags`` : インスタンスのタグ（カンマ区切り）。
* ``--google-use-internal-ip`` : 作成時にこのオプションを指定すると、docker-machine はパブリックの NAT 化された IP ではなく内部の IP を使う。フラグは常に一貫しており、マシン作成時の IP アドレスを保持します。これは Swarm をデプロイするなど、同じネットワーク上の複数のマシンを Docker Machine で管理するときに便利です。

.. The GCE driver will use the ubuntu-1510-wily-v20151114 instance image unless otherwise specified. To obtain a list of image URLs run:

GCE ドライバは、イメージの指定がなければ ``ubuntu-1510-wily-v20151114`` インスタンス・イメージを使います。イメージの一覧を取得するには、次のコマンドを実行します。

.. code-block:: bash

   gcloud compute images list --uri

利用可能な環境変数とデフォルト値は以下の通りです。

.. list-table::
   :header-rows: 1

   * - コマンドライン・オプション
     - 環境変数
     - デフォルト値
   * - ``--google-project``
     - ``GOOGLE_PROJECT``
     - -
   * - ``--google-zone``
     - ``GOOGLE_ZONE``
     - ``us-central1-a``
   * - ``--google-machine-type``
     - ``GOOGLE_MACHINE_TYPE``
     - ``f1-standard-1``
   * - ``--google-machine-image``
     - ``GOOGLE_MACHINE_IMAGE``
     - ``ubuntu-1510-wily-v20151114``
   * - ``--google-username``
     - ``GOOGLE_USERNAME``
     - ``docker-user``
   * - ``--google-scopes``
     - ``GOOGLE_SCOPES``
     - ``devstorage.read_only,logging.write``
   * - ``--google-disk-size``
     - ``GOOGLE_DISK_SIZE``
     - ``10``
   * - ``--google-disk-type``
     - ``GOOGLE_DISK_TYPE``
     - ``pd-standard``
   * - ``--google-address``
     - ``GOOGLE_ADDRESS``
     - -
   * - ``--google-preemptible``
     - ``GOOGLE_PREEMPTIBLE``
     - -
   * - ``--google-tags``
     - ``GOOGLE_TAGS``
     - -
   * - ``--google-use-internal-ip``
     - ``GOOGLE_USE_INTERNAL_IP``
     - -
