.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/login/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/login.md
   doc version: 1.10
      https://github.com/docker/docker/commits/master/docs/reference/commandline/login.md
.. check date: 2016/02/19
.. -------------------------------------------------------------------

.. login

=======================================
login
=======================================

.. code-block:: bash

   Usage: docker login [OPTIONS] [SERVER]
   
   Register or log in to a Docker registry server, if no server is
   specified "https://index.docker.io/v1/" is the default.
   
     -e, --email=""       Email
     --help               Print usage
     -p, --password=""    Password
     -u, --username=""    Username
   
.. If you want to login to a self-hosted registry you can specify this by adding the server name.

自分でホストしているレジストリにログインするには、サーバ名を指定します。

.. example:

例：

.. code-block:: bash

   $ docker login localhost:8080

.. docker login requires user to use sudo or be root, except when:

``docker login`` の実行には ``sudo`` か ``root`` になる必要があります。ただし次の場合は除外します。

..    connecting to a remote daemon, such as a docker-machine provisioned docker engine.
..    user is added to the docker group. This will impact the security of your system; the docker group is root equivalent. See Docker Daemon Attack Surface for details.

1. ``docker-machine`` を使って ``docker engine`` を自動設定したようなリモート・デーモンに接続時。
2. ``docker`` グループに追加されたユーザ。システム上のセキュリティ・リスクになります。 ``docker`` グループは ``root`` と同等のためです。詳細は :ref:`Docker デーモンが直面する攻撃 <docker-daemon-attack-surface>` をご覧ください。

.. You can log into any public or private repository for which you have credentials. When you log in, the command stores encoded credentials in $HOME/.docker/config.json on Linux or %USERPROFILE%/.docker/config.json on Windows.

証明書（credential）があれば、あらゆるパブリックないしプライベートなリポジトリにログインできます。ログインすると、コマンドは符号化（エンコード）した証明書を Linux であれば ``$HOME/.docker/config.json`` に、Windows であれば ``%USERPROFILE%/.docker/config.json`` に保管します。

..    Note: When running sudo docker login credentials are saved in /root/.docker/config.json.

.. note::

   ``sudo docker login`` を実行すると、証明書は ``/root/.docker/config.json`` に保管されます。

.. seealso:: 

   login
      https://docs.docker.com/engine/reference/commandline/login/
