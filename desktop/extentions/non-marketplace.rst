.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/extensions/non-marketplace/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/extensions/non-marketplace.md
.. check date: 2022/09/19
.. Commits on Sep 8, 2022 8bce7328f1d7f6df2ccd508d2f2970c244ebc10f
.. -----------------------------------------------------------------------------

.. Non-Marketplace extensions
.. _desktop-non-marketplace-extensions:

==================================================
マーケットプレイス外の拡張
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Install an extension not available in the Marketplace
.. _desktop-install-an-extension-not-available-in-the-marketplace:

マーケットプレイスで利用できない拡張のインストール
==================================================

..  Warning
    Docker Extensions that are not in the Marketplace haven’t gone through Docker’s review process. Extensions can install binaries, invoke commands and access files on your machine. Installing them is at your own risk.

.. warning::

   マーケットプレイスにない Docker 拡張は Docker によるレビュー手続きを経ていません。拡張はバイナリでインストールでき、マシン上でコマンド実行とファイルへのアクセスができるようになります。自分自身の責任でインストールしてください。
 
.. The Extensions Marketplace is the trusted and official place to install extensions from within Docker Desktop. These extensions have gone through a review process by Docker. However, other extensions can also be installed in Docker Desktop if you trust the extension author.

Extensions マーケットプレイスは、 Docker Desktop 内から拡張をインストールするために信頼できる公式な場所です。これらの拡張は、 Docker によるレビュー手続きを経ています。しかし、拡張の作者を信頼するのであれば、他の拡張も Docker Desktop にインストールできます。

.. Given the nature of a Docker Extension (i.e. a Docker image) you can find other places where users have their extension’s source code published. For example on GitHub, GitLab or even hosted in image registries like DockerHub or GHCR. You can install an extension that has been developed by the community or internally at your company from a teammate. You are not limited to installing extensions just from the Marketplace.

Docker 拡張の（ Docker イメージのような）性質により、拡張のソースコードを公開している場所が見つかるでしょう。たとえば、 GitHub、 GitLab だけでなく、DockerHub や GHCR のようなイメージレジストリに置かれています。コミュニティによって開発された拡張や、社内の同僚が内部的に作った拡張をインストールできます。拡張のインストールは、マーケットプレイスのみに制限されません。

..  Note
    Ensure the option Allow only extensions distributed through the Docker Marketplace is disabled. Otherwise, this prevents any extension not listed in the Marketplace, via the Extension SDK tools from, being installed. You can change this option in Settings, or Preferences if you use macOS.

.. note::

   **Allow only extensions distributed through the Docker Marketplace** （Docker マーケットプレイスで配布される拡張のみ許可）のオプションを無効化してください。そうしなければ、Extension SDK ツールを経由し、マーケットプレイス外の拡張がインストールできません。このオプション変更は **Settings** か、 macOS の場合は **Preferences** で行います。

.. To install an extension which is not present in the Marketplace, you can use the Extensions CLI that is bundled with Docker Desktop.

マーケットプレイスにない拡張をインストールするには、 Docker Desktop に同梱されている Extensions CLI が使えます。

.. In a terminal, type docker extension install IMAGE[:TAG] to install an extension by its image reference and optionally a tag. Use the -f or --force flag to avoid interactive confirmation.

拡張をインストールするには、ターミナル内で ``docker extension install IMAGE[:TAG]`` を入力し、参照するイメージやオプションでタグを設定します。 ``-f``` や ``--force`` フラグで双方向の確認を抑制します。

.. Go to the Docker Dashboard to see the new extension installed.

Docker ダッシュボードに移動し、インストール済みの新しい拡張を確認しましょう。

.. List installed extensions
.. _desktop-list-installed-extensions:

インストール済み拡張の一覧
==============================

.. Regardless whether the extension was installed from the Marketplace or manually by using the Extensions CLI, you can use the docker extension ls command to display the list of extensions installed. As part of the output you’ll see the extension ID, the provider, version, the title and whether it runs a backend container or has deployed binaries to the host, for example:

マーケットプレイスからインストールした拡張か、 Extensions CLI を使って手動でインストールした拡張かにかかわらず、インストール済みの拡張一覧は ``docker extension ls`` コマンドを使って表示できます。出力の一部で確認できるのは、拡張 ID、提供者、バージョン、タイトル、バックエンドコンテナをどこで実行しているかや、ホスト上にデプロイされたバイナリです。例：

.. code-block:: yaml

   $ docker extension ls
   ID                  PROVIDER            VERSION             UI                    VM                  HOST
   john/my-extension   John                latest              1 tab(My-Extension)   Running(1)          -

.. Go to the Docker Dashboard, click on Add Extensions and on the Installed tab to see the new extension installed. Notice that an UNPUBLISHED label displays which indicates that the extension has not been installed from the Marketplace.

Docker ダッシュボードに移動し、 **Add Extensions** をクリックし、 **Installed** タブで新しい拡張をインストールできます。 ``UNPUBLISHED`` ラベルの表示は、マーケットプレイスからインストールしていない拡張ですのでご注意ください。


.. Update an extension
.. _desktop-update-an-extension:

拡張の更新
====================

.. To update an extension which is not present in the Marketplace, in a terminal type docker extension update IMAGE[:TAG] where the TAG should be different from the extension that is already installed.

マーケットプレイスに存在しない拡張を更新するには、ターミナルで ``docker extension update IMAGE[:TAG]`` を入力し、 ``TAG`` にはインストール済みの拡張とは異なるものを指定します。

.. For instance, if you installed an extension with docker extension install john/my-extension:0.0.1, you can update it by running docker extension update john/my-extension:0.0.2. Go to the Docker Dashboard to see the new extension updated.

たとえば、拡張を ``docker extension install john/my-extension:0.0.1`` でインストール済みの場合、更新するには ``docker extension install john/my-extension:0.0.1`` を実行します。Docker ダッシュボードに移動し、更新された新しい拡張を確認します。

..    Note
    Extensions that have not been installed through the Marketplace will not receive update notifications from Docker Desktop.

.. note::

   マーケットプレイスを通してインストールしていない拡張は、 Docker Desktop 上で更新の通知を受け取れません。

.. Uninstall an extension
.. _desktop-uninstall-an-extension:

拡張のアンインストール
==============================

.. To uninstall an extension which is not present in the Marketplace, you can either navigate to the Installed tab in the Marketplace and select the Uninstall button, or from a terminal type docker extension uninstall IMAGE[:TAG].

マーケットプレイスにない拡張をアンインストールするには、マーケットプレイス内の **Installed** タブに移動し、 **Uninstall** ボタンを選びます。あるいは、ターミナルで ``docker extension uninstall IMAGE[:TAG]`` を入力します。


.. seealso::

   Non-Marketplace extensions
      https://docs.docker.com/desktop/extensions/non-marketplace/
