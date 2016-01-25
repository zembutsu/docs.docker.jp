.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/drivers/soft-layer/
.. doc version: 1.9
.. check date: 2016/01/23
.. -----------------------------------------------------------------------------

.. IBM Softlayer

.. _driver-ibm-softlayer:

=======================================
IBM SoftLayer
=======================================

.. Create machines on Softlayer.

`SoftLayer <http://softlayer.com/>`_ 上にマシンを作成します。

.. You need to generate an API key in the softlayer control panel. Retrieve your API key

SoftLayer コントロール・パネルで API を生成する必要があります。 `API Key を取得するには（英語） <http://knowledgelayer.softlayer.com/procedure/retrieve-your-api-key>`_ 。

.. Options:

オプション：

..    --softlayer-memory: Memory for host in MB.
    --softlayer-disk-size: A value of 0 will set the SoftLayer default.
    --softlayer-user: required Username for your SoftLayer account, api key needs to match this user.
    --softlayer-api-key: required API key for your user account.
    --softlayer-region: SoftLayer region.
    --softlayer-cpu: Number of CPUs for the machine.
    --softlayer-hostname: Hostname for the machine.
    --softlayer-domain: required Domain name for the machine.
    --softlayer-api-endpoint: Change SoftLayer API endpoint.
    --softlayer-hourly-billing: Specifies that hourly billing should be used, otherwise monthly billing is used.
    --softlayer-local-disk: Use local machine disk instead of SoftLayer SAN.
    --softlayer-private-net-only: Disable public networking.
    --softlayer-image: OS Image to use.
    --softlayer-public-vlan-id: Your public VLAN ID.
    --softlayer-private-vlan-id: Your private VLAN ID.

* ``--softlayer-memory`` : ホストのメモリを MB 単位で指定。
* ``--softlayer-disk-size`` : ``0`` の値を指定すると、SoftLayer のデフォルトを使用。
* ``--softlayer-user`` : **必須** SoftLayer アカウントのユーザ名であり、API キーと一致する必要がある。
* ``--softlayer-api-key`` : **必須** ユーザ・アカウント用の API キー。
* ``--softlayer-region`` : SoftLayer のリージョン。
* ``--softlayer-cpu`` : マシンで使う CPU 数。
* ``--softlayer-hostname`` : マシンのホスト名。
* ``--softlayer-domain`` : **必須** マシンのドメイン名。
* ``--softlayer-api-endpoint`` : SoftLayer API エンドポイントの変更。
* ``--softlayer-hourly-billing`` : 時間単位（hourly）課金を指定すべき。そうしなければ、月単位で課金される。
* ``--softlayer-local-disk`` : SoftLayer SAN のかわりに、ローカル・マシンを使う。
* ``--softlayer-private-net-only`` : パブリック・ネットワークを無効化する。
* ``--softlayer-image`` : 使用する OS イメージ。
* ``--softlayer-public-vlan-id`` : パブリック VLAN ID 。
* ``--softlayer-private-vlan-id`` : プライベート VLAN ID 。

.. The SoftLayer driver will use UBUNTU_LATEST as the image type by default.

SoftLayer ドライバは、デフォルトで ``UBUNTU_LATEST`` イメージ・タイプを使います。

利用可能な環境変数とデフォルト値は以下の通りです。

.. list-table::
   :header-rows: 1
   
   * - コマンドライン・オプション
     - 環境変数
     - デフォルト値
   * - ``--softlayer-memory``
     - ``SOFTLAYER_MEMORY``
     - ``1024``
   * - ``--softlayer-disk-size``
     - ``SOFTLAYER_DISK_SIZE``
     - ``0``
   * - ``--softlayer-user``
     - ``SOFTLAYER_USER``
     - -
   * - ``--softlayer-api-key``
     - ``SOFTLAYER_API_KEY``
     - -
   * - ``--softlayer-region``
     - ``SOFTLAYER_REGION``
     - ``dal01``
   * - ``--softlayer-cpu``
     - ``SOFTLAYER_CPU``
     - ``1``
   * - ``--softlayer-hostname``
     - ``SOFTLAYER_HOSTNAME``
     - ``docker``
   * - ``--softlayer-domain``
     - ``SOFTLAYER_DOMAIN``
     - -
   * - ``--softlayer-api-endpoint``
     - ``SOFTLAYER_API_ENDPOINT``
     - ``api.softlayer.com/rest/v3``
   * - ``--softlayer-hourly-billing``
     - ``SOFTLAYER_HOURLY_BILLING``
     - ``false``
   * - ``--softlayer-local-disk``
     - ``SOFTLAYER_LOCAL_DISK``
     - ``false``
   * - ``--softlayer-private-net-only``
     - ``SOFTLAYER_PRIVATE_NET``
     - ``false``
   * - ``--softlayer-image``
     - ``SOFTLAYER_IMAGE``
     - ``UBUNTU_LATEST``
   * - ``--softlayer-public-vlan-id``
     - ``SOFTLAYER_PUBLIC_VLAN_ID``
     - ``0``
   * - ``--softlayer-private-vlan-id``
     - ``SOFTLAYER_PRIVATE_VLAN_ID``
     - ``0``


