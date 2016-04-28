.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/drivers/openstack/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/drivers/openstack.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/drivers/openstack.md
.. check date: 2016/04/28
.. Commits on Jan 26, 2016 75f138949aa465dd4b3da1df75abba44ff197cdf
.. ----------------------------------------------------------------------------

.. OpenStack

.. _driver-openstack:

=======================================
OpenStack
=======================================

.. Create machines on OpenStack

`OpenStack <http://www.openstack.org/software/>`_  上にマシンを作成します。

.. code-block:: bash

   $ docker-machine create --driver openstack vm

.. Mandatory:

必須オプション：

..    --openstack-auth-url: Keystone service base URL.
    --openstack-flavor-id or --openstack-flavor-name: Identify the flavor that will be used for the machine.
    --openstack-image-id or --openstack-image-name: Identify the image that will be used for the machine.

* ``--openstack-auth-url`` : Keystone サービス・ベース URL。
* ``--openstack-flavor-id`` または ``--openstack-flavor-name`` : マシンとして使用する flavor の指定。
* ``--openstack-image-id`` または ``--openstack-image-name`` : マシンとして使用するイメージの指定。

.. Options:

オプション：

..    --openstack-active-timeout: The timeout in seconds until the OpenStack instance must be active.
    --openstack-availability-zone: The availability zone in which to launch the server.
    --openstack-domain-name or --openstack-domain-id: Domain to use for authentication (Keystone v3 only).
    --openstack-endpoint-type: Endpoint type can be internalURL, adminURL on publicURL. If is a helper for the driver to choose the right URL in the OpenStack service catalog. If not provided the default id publicURL
    --openstack-floatingip-pool: The IP pool that will be used to get a public IP can assign it to the machine. If there is an IP address already allocated but not assigned to any machine, this IP will be chosen and assigned to the machine. If there is no IP address already allocated a new IP will be allocated and assigned to the machine.
    --openstack-insecure: Explicitly allow openstack driver to perform “insecure” SSL (https) requests. The server’s certificate will not be verified against any certificate authorities. This option should be used with caution.
    --openstack-ip-version: If the instance has both IPv4 and IPv6 address, you can select IP version. If not provided 4 will be used.
    --openstack-net-name or --openstack-net-id: Identify the private network the machine will be connected on. If your OpenStack project project contains only one private network it will be use automatically.
    --openstack-password: User password. It can be omitted if the standard environment variable OS_PASSWORD is set.
    --openstack-region: The region to work on. Can be omitted if there is only one region on the OpenStack.
    --openstack-sec-groups: If security groups are available on your OpenStack you can specify a comma separated list to use for the machine (e.g. secgrp001,secgrp002).
    --openstack-username: User identifier to authenticate with.
    --openstack-ssh-port: Customize the SSH port if the SSH server on the machine does not listen on the default port.
    --openstack-ssh-user: The username to use for SSH into the machine. If not provided root will be used.
    --openstack-tenant-name or --openstack-tenant-id: Identify the tenant in which the machine will be created.

* ``--openstack-active-timeout`` : OpenStack インスタンスがアクティブになるまでの、タイムアウトの秒数を指定。
* ``--openstack-availability-zone`` : サーバを起動する availability zone の指定。
* ``--openstack-domain-name or --openstack-domain-id`` :  認証に使うドメイン名の指定（Keystone v3 のみ）
* ``--openstack-endpoint-type`` : エンドポイント・タイプとして ``internalURL`` 、 ``publicURL`` 上の ``adminURL`` を指定します。OpenStack サービス・カタログ上で適切なドライバを選択すると便利です。指定しなければ、デフォルトの ID ``publicURL`` が指定されます。
* ``--openstack-floatingip-pool`` : マシンに割り当てるパブリック IP に使用するための IP プールを指定。IP アドレスが作成されていてもマシンに割り当てられていなければ、マシン用に割り当てる。割り当て可能な IP アドレスが無ければ、新しく作成してマシンに割り当てる。
* ``--openstack-keypair-name`` : 既存の Nova キーペアを使う指定をする。
* ``--openstack-insecure`` :  OpenStack ドライバが「insecure（非安全）」SSL (https)リクエストを処理できるのを明示します。サーバの証明書において証明書の権限を確認しません。このオプションは注意を払って遣うべきです。
* ``--openstack-ip-version`` : IPv4 か IPv6 アドレスのどちらかのバージョンを選びます。何も指定されなければ、 ``4`` が使われます。
* ``--openstack-net-name`` または ``--openstack-net-id`` : マシンに接続するプライベートなネットワークを指定します。OpenStack プロジェクトにプライベート・ネットワークがあれば、自動的に使われます。
* ``--openstack-password`` : ユーザ・パスワード。環境変数 ``OS_PASSWORD`` が設定されれば、そちらから流用します。
* ``--openstack-private-key-file`` : ``--openstack-keypair-name`` と同時に使い、キーペアに対応するプライベート・キーを関連づける。
* ``--openstack-region`` : 実行するリージョンを指定します。OpenStack 上に１つのリージョンしかなければ、そちらを使います。
* ``--openstack-sec-groups`` : OpenStack 上でセキュリティ・グループが利用可能であれば、マシンが使う環境をカンマ区切りで指定できる（例： ``secgrp001,secgrp002`` ）。
* ``--openstack-username`` : 認証時に識別するユーザ名。
* ``--openstack-ssh-port`` : マシン上の SSH サーバがデフォルトのポートをリッスンしないとき、SSH ポート番号を指定。
* ``--openstack-ssh-user`` : SSH でマシンに入るユーザ名を指定。指定されなければ、 ``root`` が使われる。
* ``--openstack-tenant-name`` または ``--openstack-tenant-id`` : マシンを作成するテナントを指定。

.. Environment variables and default values:

利用可能な環境変数とデフォルト値は以下の通りです。

.. list-table::
   :header-rows: 1
   
   * - コマンドライン・オプション
     - 環境変数
     - デフォルト値
   * - ``--openstack-active-timeout``
     - ``OS_ACTIVE_TIMEOUT``
     - ``200``
   * - ``--openstack-auth-url``
     - ``OS_AUTH_URL``
     - -
   * - ``--openstack-availability-zone``
     - ``OS_AVAILABILITY_ZONE``
     - -
   * - ``--openstack-domain-id``
     - ``OS_DOMAIN_ID``
     - -
   * - ``--openstack-domain-name``
     - ``OS_DOMAIN_NAME``
     - -
   * - ``--openstack-endpoint-type``
     - ``OS_ENDPOINT_TYPE``
     - ``publicURL``
   * - ``--openstack-flavor-id``
     - ``OS_FLAVOR_ID``
     - -
   * - ``--openstack-flavor-name``
     - ``OS_FLAVOR_NAME``
     - -
   * - ``--openstack-floatingip-pool``
     - ``OS_FLOATINGIP_POOL``
     - -
   * - ``--openstack-image-id``
     - ``OS_IMAGE_ID``
     - -
   * - ``--openstack-image-name``
     - ``OS_IMAGE_NAME``
     - -
   * - ``--openstack-insecure``
     - ``OS_INSECURE``
     - ``false``
   * - ``--openstack-ip-version``
     - ``OS_IP_VERSION``
     - ``4``
   * - ``--openstack-keypair-name``
     - ``OS_KEYPAIR_NAME``
     - -
   * - ``--openstack-net-id``
     - ``OS_NETWORK_ID``
     - -
   * - ``--openstack-net-name``
     - ``OS_NETWORK_NAME``
     - -
   * - ``--openstack-password``
     - ``OS_PASSWORD``
     - -
   * - ``--openstack-private-key-file``
     - ``OS_PRIVATE_KEY_FILE``
     - -
   * - ``--openstack-region``
     - ``OS_REGION_NAME``
     - -
   * - ``--openstack-sec-groups``
     - ``OS_SECURITY_GROUPS``
     - -
   * - ``--openstack-ssh-port``
     - ``OS_SSH_PORT``
     - ``22``
   * - ``--openstack-ssh-user``
     - ``OS_SSH_USER``
     - ``root``
   * - ``--openstack-tenant-id``
     - ``OS_TENANT_ID``
     - -
   * - ``--openstack-tenant-name``
     - ``OS_TENANT_NAME``
     - -
   * - ``--openstack-username``
     - ``OS_USERNAME``
     - -

.. seealso:: 

   OpenStack
      https://docs.docker.com/machine/drivers/openstack/
