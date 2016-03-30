.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/drivers/digital-ocean/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/drivers/digital-ocean.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/drivers/digital-ocean.md
.. check date: 2016/03/09
.. Commits on Mar 3, 2016 17c6578583e61b144eb6071a900b589a3a9d26eb
.. ----------------------------------------------------------------------------

.. Digital Ocean

.. _driver-digital-ocean:

=======================================
Digital Ocean
=======================================

.. Create Docker machines on Digital Ocean.

`Digital Ocean <https://www.digitalocean.com/>`_ 上に Docker マシンを作成します。

.. You need to create a personal access token under “Apps & API” in the Digital Ocean Control Panel and pass that to docker-machine create with the --digitalocean-access-token option.

Digital Ocean のコントロール・パネルにある「Apps & API」から、パーソナル・アクセス・トークンを作成する必要があります。それから ``docker-machine create`` に ``--digitalocean-access-token`` オプションで渡します。

.. code-block:: bash

   $ docker-machine create --driver digitalocean --digitalocean-access-token=aa9399a2175a93b17b1c86c807e08d3fc4b79876545432a629602f61cf6ccd6b test-this

.. Options:

オプション：

..    --digitalocean-access-token: required Your personal access token for the Digital Ocean API.
    --digitalocean-image: The name of the Digital Ocean image to use.
    --digitalocean-region: The region to create the droplet in, see Regions API for how to get a list.
    --digitalocean-size: The size of the Digital Ocean droplet (larger than default options are of the form 2gb).
    --digitalocean-ipv6: Enable IPv6 support for the droplet.
    --digitalocean-private-networking: Enable private networking support for the droplet.
    --digitalocean-backups: Enable Digital Oceans backups for the droplet.
    --digitalocean-userdata: Path to file containing User Data for the droplet.

* ``--digitalocean-access-token`` : **必須** Digital Ocean API 用のパーソナル・アクセス・トークン。
* ``--digitalocean-image`` : Digital Ocean イメージ用の名前。
* ``--digitalocean-region`` : ドロップレットを作成するリージョンの指定です。詳細一覧は `Region API <https://developers.digitalocean.com/documentation/v2/#regions>`_ を参照。
* ``--digitalocean-size`` : Digital Ocean ドロップレットのサイズ（ デフォルトの ``2gb`` 以上より大きいもの ）。
* ``--digitalocean-ipv6`` : ドロップレットで IPv6 を有効化。
* ``--digitalocean-private-networking`` : ドロップレットのプライベート・ネットワーク対応を有効化。
* ``--digitalocean-backups`` : ドロップレットのバックアップを有効化。
* ``--digitalocean-userdata`` : ドロップレット用のユーザ・データを含むファイルのパス。
* ``--digitalocean-ssh-user`` : SSH ユーザ名。
* ``--digitalocean-ssh-port`` : SSH ポート番号。
* ``--digitalocean-ssh-key-fingerprint`` : 新しい SSH 鍵を作らず、既存の鍵を使います。詳細は `SSH Keys のページ <https://developers.digitalocean.com/documentation/v2/#ssh-keys>`_ をご覧ください。

.. The DigitalOcean driver will use ubuntu-15-10-x64 as the default image.

DigitalOcean ドライバは、 ``ubuntu-15-10-x64`` をデフォルトのイメージとして使います。

利用可能な環境変数とデフォルト値は以下の通りです。

.. list-table::
   :header-rows: 1
   
   * - コマンドライン・オプション
     - 環境変数
     - デフォルト値
   * - ``--digitalocean-access-token``
     - ``DIGITALOCEAN_ACCESS_TOKEN``
     - -
   * - ``--digitalocean-image``
     - ``DIGITALOCEAN_IMAGE``
     - ``ubuntu-15-10-x64``
   * - ``--digitalocean-region``
     - ``DIGITALOCEAN_REGION``
     - ``nyc3``
   * - ``--digitalocean-size``
     - ``DIGITALOCEAN_SIZE``
     - ``512mb``
   * - ``--digitalocean-ipv6``
     - ``DIGITALOCEAN_IPV6``
     - ``false``
   * - ``--digitalocean-private-networking``
     - ``DIGITALOCEAN_PRIVATE_NETWORKING``
     - ``false``
   * - ``--digitalocean-backups``
     - ``DIGITALOCEAN_BACKUPS``
     - ``false``
   * - ``--digitalocean-userdata``
     - ``DIGITALOCEAN_USERDATA``
     - 
   * - ``--digitalocean-ssh-user``
     - ``DIGITALOCEAN_SSH_USER``
     - ``root``
   * - ``--digitalocean-ssh-port``
     - ``DIGITALOCEAN_SSH_PORT``
     - ``22``
   * - ``--digitalocean-ssh-key-fingerprint``
     - ``DIGITALOCEAN_SSH_KEY_FINGERPRINT``
     - 

.. seealso:: 

   Digial Ocean
      https://docs.docker.com/machine/drivers/digital-ocean/
