.. -*- coding: utf-8 -*-
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/_includes/install-script.md
.. ----------------------------------------------------------------------------

.. Install using the convenience script

.. _convenience-scripts:

便利なスクリプトを使ったインストール
----------------------------------------

.. Docker provides convenience scripts at [get.docker.com](https://get.docker.com/)
   and [test.docker.com](https://test.docker.com/) for installing stable and
   testing versions of Docker CE into development environments quickly and
   non-interactively. The source code for the scripts is in the
   [`docker-install` repository](https://github.com/docker/docker-install).
   **Using these scripts is not recommended for production
   environments**, and you should understand the potential risks before you use
   them:

Docker では `get.docker.com <https://get.docker.com/>`_ と `test.docker.com <https://test.docker.com/>`_ において便利なスクリプトを提供しています。
これは Docker CE の安定版あるいはテスト版を、開発機にすばやく対話形式をとらずにインストールするものです。
このスクリプトのソースコードは ``docker-install`` `リポジトリ <https://github.com/docker/docker-install>`_ にあります。
このスクリプトを本番環境において利用することはお勧めしません。
またこのスクリプトの潜在的リスクについては、十分理解した上で利用してください。

.. - The scripts require `root` or `sudo` privileges in order to run. Therefore,
     you should carefully examine and audit the scripts before running them.
   - The scripts attempt to detect your Linux distribution and version and
     configure your package management system for you. In addition, the scripts do
     not allow you to customize any installation parameters. This may lead to an
     unsupported configuration, either from Docker's point of view or from your own
     organization's guidelines and standards.
    The scripts install all dependencies and recommendations of the package manager without asking for confirmation. This may install a large number of packages, depending on the current configuration of your host machine.
    Do not use the convenience script if Docker has already been installed on the host machine using another mechanism.

* スクリプトを実行するには ``root`` 権限か ``sudo`` が必要です。
  したがって十分に内容を確認してからスクリプトを実行するようにしてください。
* スクリプトは自動的に情報取得を行い、利用している Linux ディストリビューション、そのバージョン、そしてパッケージ管理システムの設定を行います。
  なおこのスクリプトは、インストール時にパラメータを受け渡すような設定はできないものになっています。
  このことから時には、不適切な設定となる場合があります。
  それは Docker の観点の場合もあれば、開発現場のガイドラインや標準に対しての場合もあります。
* スクリプトを実行すると、パッケージ・マネージャが示す依存関係や推奨パッケージを、すべて自動的にインストールします。これにより、ホストマシン上の設定によっては、非常に多くのパッケージや依存関係のインストールが行われる場合があります。
* 既にホスト・マシン上で別の手法による Docker をインストール済みの環境では、この便利なスクリプトは使用しないでください。

.. This example uses the script at get.docker.com to install the latest stable release of Docker CE on Linux. To install the latest testing version, use test.docker.com instead. In each of the commands below, replace each occurrence of get with test.

次の例は Linux に Docker CE の最新安定版リリースのインストールに、 `get.docker.com`_ のスクリプトを使います。最新テスト版を使いたい場合は、代わりに `test.docker.com`_ を指定します。その場合はコマンド中の ``get`` を ``test`` に置き換えて実行します。

.. warning::

   スクリプトを実行する前に、インターネットからダウンロードしたスクリプトをご確認ください。

.. code-block:: bash

   $ curl -fsSL get.docker.com -o get-docker.sh
   $ sudo sh get-docker.sh
   
   <output truncated>
   
   If you would like to use Docker as a non-root user, you should now consider
   adding your user to the "docker" group with something like:
   
     sudo usermod -aG docker your-user
   
   Remember that you will have to log out and back in for this to take effect!
   
   WARNING: Adding a user to the "docker" group will grant the ability to run
            containers which can be used to obtain root privileges on the
            docker host.
            Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
            for more information.

.. Docker CE is installed. It starts automatically on DEB-based distributions. On RPM-based distributions, you need to start it manually using the appropriate systemctl or service command. As the message indicates, non-root users are not able to run Docker commands by default.

これで Docker CE をインストールしました。 ``DEB`` をベースとしたディストリビューションでは、自動的に開始します。 ``RPM`` ベースのディストリビューションでは、適切な ``systemctl`` や ``service`` コマンドを使い、手動で実行する必要があります。メッセージが表示されているように、デフォルトでは root ではないユーザは Docker コマンドを実行できません。

.. Upgrade Docker after using the convenience script

便利なスクリプトを使った後の Docker アップグレード
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. If you installed Docker using the convenience script, you should upgrade Docker using your package manager directly. There is no advantage to re-running the convenience script, and it can cause issues if it attempts to re-add repositories which have already been added to the host machine.

便利なスクリプトを使って Docker をインストールしている場合は、パッケージ・マネージャをとして直接アップグレードを試みるべきでしょう。便利なスクリプトを再度実行する利点は何らありません。また、スクリプトの再実行により、ホストマシン上に既に追加されているリポジトリを再追加するため、何か問題となる可能性があります。
