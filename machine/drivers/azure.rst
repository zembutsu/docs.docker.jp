.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/drivers/azure/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/drivers/azure.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/drivers/azure.md
.. check date: 2016/03/09
.. Commits on Dec 8, 2015 db9ca3c3b7844d8711b0dfd4decc30f0bd9bdcae
.. ----------------------------------------------------------------------------

.. Microsoft Azure

.. _driver-microsoft-azure:

=======================================
Microsoft Azure
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Create machines on Microsoft Azure.

`Microsoft Azure <http://azure.microsoft.com/>`_ 上にマシンを作成します。

.. You need to create a subscription with a cert. Run these commands and answer the questions:

証明書（cert）を使ってサブスクリプションを作成する必用があります。これらのコマンドを実行し、問い合わせに回答します。

.. code-block:: bash

   $ openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout mycert.pem -out mycert.pem
   $ openssl pkcs12 -export -out mycert.pfx -in mycert.pem -name "My Certificate"
   $ openssl x509 -inform pem -in mycert.pem -outform der -out mycert.cer

.. Go to the Azure portal, go to the “Settings” page (you can find the link at the bottom of the left sidebar - you need to scroll), then “Management Certificates” and upload mycert.cer.

Azure ポータルに移動し、「Settings」ページに移動します（左スライド・バーの下の方にリンクがあります。スクロールが必要かもしれません）。それから「Management Certificates」で ``mycert.cer`` からアップロードします。

.. Grab your subscription ID from the portal, then run docker-machine create with these details:

ポータルから自分のサブスクリプション ID を取得し、次のように ``docker-machine create`` の詳細を実行します。

.. code-block:: bash

   $ docker-machine create -d azure --azure-subscription-id="SUB_ID" --azure-subscription-cert="mycert.pem" A-VERY-UNIQUE-NAME

.. The Azure driver uses the b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-15_10-amd64-server-20151116.1-en-us-30GB image by default. Note, this image is not available in the Chinese regions. In China you should specify b549f4301d0b4295b8e76ceb65df47d4__Ubuntu-15_10-amd64-server-20151116.1-en-us-30GB.

Azure ドライバは、デフォルトで ``b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-15_10-amd64-server-20151116.1-en-us-30GB`` イメージを使います。なお、このイメージは中国リージョンでは利用できません。中国リージョンは ``b549f4301d0b4295b8e76ceb65df47d4__Ubuntu-15_10-amd64-server-20151116.1-en-us-30GB`` をご利用ください。

.. You may need to machine ssh in to the virtual machine and reboot to ensure that the OS is updated.

OS を確実に更新するためには、仮想マシンに SSH でログインし、再起動する必要があるでしょう。

.. Options:

オプション：

..    --azure-docker-port: Port for Docker daemon.
    --azure-image: Azure image name. See How to: Get the Windows Azure Image Name
    --azure-location: Machine instance location.
    --azure-password: Your Azure password.
    --azure-publish-settings-file: Azure setting file. See How to: Download and Import Publish Settings and Subscription Information
    --azure-size: Azure disk size.
    --azure-ssh-port: Azure SSH port.
    --azure-subscription-id: required Your Azure subscription ID (A GUID like d255d8d7-5af0-4f5c-8a3e-1545044b861e).
    --azure-subscription-cert: required Your Azure subscription cert.
    --azure-username: Azure login user name.

* ``--azure-docker-port`` :  Docker デーモンのポート番号。
* ``--azure-image`` :  Azure イメージ名です。詳細は `How to: Get the Windows Azure Image Name <https://msdn.microsoft.com/en-us/library/dn135249%28v=nav.70%29.aspx>`_ を参照。
* ``--azure-location`` :  マシン・インスタンスの場所。
* ``--azure-password`` :  Azure パスワード。
* ``--azure-publish-settings-file`` :  Azure 設定ファイル。詳細は `How to: Download and Import Publish Settings and Subscription Information <https://msdn.microsoft.com/en-us/library/dn385850%28v=nav.70%29.aspx>`_ を参照。
* ``--azure-size`` :  Azure ディスク容量。
* ``--azure-ssh-port`` :  Azure SSH ポート番号。
* ``--azure-subscription-id`` :  **必須** Azure サブスクリプション ID （GUID は ``d255d8d7-5af0-4f5c-8a3e-1545044b861e`` のようなものです ）.
* ``--azure-subscription-cert`` :  **必須** Azure サブスクリプション証明書（cert）。
* ``--azure-username`` :  Azure ログイン・ユーザ名。

利用可能な環境変数とデフォルト値は以下の通りです。

.. list-table::
   :header-rows: 1
   
   * - コマンドライン・オプション
     - 環境変数
     - デフォルト値
   * - ``--azure-docker-port``
     - -
     - ``2376``
   * - ``--azure-image``
     - ``AZURE_IMAGE``
     - *Ubuntu 15.10 x64*
   * - ``--azure-location``
     - ``AZURE_LOCATION``
     - ``West US``
   * - ``--azure-password``
     - -
     - -
   * - ``--azure-publish-settings-file``
     - ``AZURE_PUBLISH_SETTINGS_FILE``
     - -
   * - ``--azure-size``
     - ``AZURE_SIZE``
     - ``Small``
   * - ``--azure-ssh-port``
     - -
     - ``22``
   * - ``--azure-subscription-cert``
     - ``AZURE_SUBSCRIPTION_CERT``
     - -
   * - ``--azure-subscription-id``
     - ``AZURE_SUBSCRIPTION_ID``
     - -
   * - ``--azure-username``
     - -
     - ``ubuntu``

.. seealso:: 

   Microsoft Azure
      https://docs.docker.com/machine/drivers/azure/

