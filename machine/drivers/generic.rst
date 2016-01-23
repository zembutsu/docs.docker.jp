.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/drivers/generic/
.. doc version: 1.9
.. check date: 2016/01/23
.. -----------------------------------------------------------------------------

.. Generic

.. _driver-generic:

=======================================
汎用ドライバ(generic)
=======================================

.. Create machines using an existing VM/Host with SSH.

既存の仮想マシン/ホストを、SSH 経由で Docker Machine が扱えるマシンにします。

.. This is useful if you are using a provider that Machine does not support directly or if you would like to import an existing host to allow Docker Machine to manage.

これが役立つのは、Docker Machine のプロバイダがサポートされていない場合や、既存の Docker ホスト環境を Docker Machine で管理できるよう移行する場合です。

.. The driver will perform a list of tasks on create:

作成時、ドライバは以下の処理を行います。

..    If docker is not running on the host, it will be installed automatically.
    It will generate certificates to secure the docker daemon
    The docker daemon will be restarted, thus all running containers will be stopped.

* ホスト上で docker が動いていなければ、自動的にインストールを行う。
* docker デーモンを安全にする証明書を生成する。
* docker デーモンを再起動するため、実行中のコンテナは全て停止される。

.. Options:

オプション：

..    --generic-ip-address: required IP Address of host.
    --generic-ssh-key: Path to the SSH user private key.
    --generic-ssh-user: SSH username used to connect.
    --generic-ssh-port: Port to use for SSH.

* ``--generic-ip-address`` : **必須** ホストの IP アドレス
* ``--generic-ssh-key`` : SSH ユーザのプライベート鍵のパス
* ``--generic-ssh-user`` : 接続に使う SSH ユーザ名
* ``--generic-ssh-port`` : SSH に使うポート番号

..    Note: You must use a base operating system supported by Machine.

.. note::

   Docker Machine がサポートしているベース・オペレーティング・システムを使う必要があります。

利用可能な環境変数とデフォルト値は以下の通りです。

.. list-table::
   :header-rows: 1
   
   * - コマンドライン・オプション
     - 環境変数
     - デフォルト値
   * - ``--generic-ip-address``
     - ``GENERIC_IP_ADDRESS``
     - -
   * - ``--generic-ssh-key``
     - ``GENERIC_SSH_KEY``
     - （ ``ssh-agent`` に従う ）
   * - ``--generic-ssh-user``
     - ``GENERIC_SSH_USER``
     - ``root``
   * - ``--generic-ssh-port``
     - ``GENERIC_SSH_PORT``
     - ``22``

.. Interaction with SSH Agents

.. _interaction-with-ssh-agents:

SSH エージェントとの通信
==============================

.. When an SSH identity is not provided (with the --generic-ssh-key flag), the SSH agent (if running) will be consulted. This makes it possible to easily use password-protected SSH keys.

SSH 認証情報の指定（ ``--generic-ssh-key`` フラグを使う ）がなければ、 SSH エージェントは（実行中であれば）訊ねます。つまり、パスワードで保護された SSH 鍵を簡単に使えるようにします。

.. Note that this usage is only supported if you’re using the external SSH client, which is the default behaviour when the ssh binary is available. If you’re using the native client (with --native-ssh), using the SSH agent is not yet supported.

ただしサポートされているのは、外部の SSH クライアント、ここでは ``ssh`` バイナリが実行できるデフォルトの挙動が扱える場合のみです。ネイティブ・クライアントを使う場合（ ``--native-ssh`` ）は、まだ SSH エージェントの利用をサポートしていませんのでご注意ください。