.. H-*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/use-desktop/images/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/use-desktop/images.md
.. check date: 2022/09/15
.. Commits on Jul 28, 2022 4ff46f1e450d03d18e713aca60064c7c7100d4fb
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :width: 50%

.. Explore Images
.. _explore-images:

=======================================
:ruby:`Images <イメージ>` を見渡す
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The Images view is a simple interface that lets you manage Docker images without having to use the CLI. By default, it displays a list of all Docker images on your local disk.

 CLI を使わなくても Docker イメージが管理できるように、 **Images** の表示はシンプルなインタフェースです。デフォルトでは、ローカルディスク上の Docker イメージすべてを一覧表示します。

.. You can also view images in remote repositories, once you have signed in to Docker Hub. This allows you to collaborate with your team and manage your images directly through Docker Desktop.

また、 Docker Hub にサインイン済みであれば、リモートリポジトリのイメージも表示できます。これにより、チームと共同作業ができるようにしたり、 Docker Desktop を通して直接イメージを管理できるようになります。

.. The Images view allows you to perform core operations such as running an image as a container, pulling the latest version of an image from Docker Hub, pushing the image to Docker Hub, and inspecting images.

**Images** の表示からは、コンテナとしてのイメージ実行や、Docker Hub から最新版のイメージ取得、Docker Hub へのイメージ送信、イメージの調査といった中心的な処理を行えます。

.. The Images view displays metadata about the image such as the:

**Images** の表示からは、次のようなイメージのメタデータを表示します：

..  Tag
    Image ID
    Date created
    Size of the image.

* Tag （タグ）
* Image ID （イメージ ID）
* Date created （作成日）
* Size of the image （イメージの容量）

.. It also displays In Use tags next to images used by running and stopped containers.

また、実行中または停止中のコンテナによって使われているイメージの横には **IN USE** （使用中）のタグも表示されます。

.. The Images on disk status bar displays the number of images and the total disk space used by the images.

**Images on disk** ステータスバーで表示しているのは、イメージの数と、イメージが使う合計ディスク容量です。

.. Manage your images
.. _desktop-manage-your-images:

イメージの管理
====================

.. Use the Search field to search for any specific image.

**Search** フォームを使い、特定のイメージを検索します。

.. You can sort images by:

イメージを次の順番で並べられます。

..  Name
    Date created
    Size

* 名前
* 作成日
* 容量

.. Run an image as a container
.. _desktop-run-an-image-as-a-container:

コンテナとしてイメージを実行
==============================

.. From the Images view, hover over an image and click Run.

**Images の表示** から、イメージの上にマウスカーソルを移動し、 **Run** を実行します。

.. When prompted you can either:

確認画面（プロンプト）が出ますので、どちらかを選べます。

..  Click the Optional settings drop-down to specify a name, port, volumes, environment variables and click Run
    Click Run without specifying any optional settings.

* **Optional settings** （オプション設定）のドロップダウンメニューをクリックし、名前、ポート、ボリューム、環境変数を指定してから **Run** をクリックする。
* オプション設定を指定しないで **Run** をクリックする。

.. Inspect an image
.. _desktop-inspect-an-image:

イメージを調査
====================

.. Inspecting an image displays detailed information about the image such as the:

イメージを調査するため、イメージに関する次のような詳細情報を表示します。

..  Image history
    Image ID
    Date the image was created
    Size of the imag

* イメージ履歴
* イメージ ID
* イメージが作成された日付
* イメージの容量

.. To inspect an image, hover over an image, select the More options button and then select Inspect from the dropdown menu.

イメージを調査するには、イメージの上にマウスカーソルを移動し、 **More options** ボタン（⋮）をクリックし、ドロップダウンメニューから **Inspect** を選びます。


.. Pull the latest image from Docker Hub
.. _desktop-pull-the-latest-image-from-docker-hub:

Docker Hub から最新イメージを取得
========================================

.. Select the image from the list, click the More options button and click Pull.

一覧からイメージを選び、 **More options** ボタンをクリックし、 **Pull** をクリックします。

..  Note
    The repository must exist on Docker Hub in order to pull the latest version of an image. You must be logged in to pull private images.

.. note::

   イメージの最新版を取得するには、 Docker Hub 上にリポジトリが存在している必要があります。プライベート イメージを取得するには、ログインが必須です。

.. Push an image to Docker Hub
.. _dexktop-push-an-image-to-docker-hub:

Docker Hub にイメージの送信
==============================

.. Select the image from the list, click the More options button and click Push to Hub.

一覧からイメージを選び、 **More options** ボタンをクリックし、 **Push to Hub** をクリックします。

..  Note
    You can only push an image to Docker Hub if the image belongs to your Docker ID or your organization. That is, the image must contain the correct username/organization in its tag to be able to push it to Docker Hub.


.. note::

   Docker Hub に送信できるイメージは、自分の Docker ID または自分の organization に所属しているイメージのみです。つまり、 Docker Hub にイメージを送信するには、イメージのタグに適切なユーザ名または組織名を含む必要があります。

.. Remove an image
.. _desktop-remove-an-image:

イメージの削除
====================

..  Note
    To remove an image used by a running or a stopped container, you must first remove the associated container.

.. note::

   実行中または停止中のコンテナによって使われているイメージを削除するには、まず関連しているコンテナの削除が必要です。

.. You can remove individual images or use the Clean up option to delete unused and dangling images.

イメージは個々に削除できますし、あるいは、 **Clean up** オプションを使うと未使用イメージや :ruby:`宙吊り <dangling>` イメージを削除できます。

.. An unused image is an image which is not used by any running or stopped containers. An image becomes dangling when you build a new version of the image with the same tag.

未使用イメージとは、あらゆる実行中または停止中のコンテナによって使われていないイメージです。同じタグを持つ新しいバージョンのイメージを構築すると、元々あるイメージは :ruby:`宙吊り <dangling>` イメージとなります。

.. To remove individual images, select the image from the list, click the More options button and click Remove

イメージを個々に削除するには、一覧からイメージを選択し、 **More options** ボタンをクリックし、 **Remove** をクリックします。

.. To remove an unused or a dangling image:

宙吊りイメージを削除するには：

..    Select the Clean up option from the Images on disk status bar.
    Use the Unused or Dangling check boxes to select the type of images you would like to remove.
    The Clean up images status bar displays the total space you can reclaim by removing the selected images. 3.. Select Remove to confirm.

1. ***Images on disk** ステータスバーにある **Clean up** オプションをクリックします。
2. **Unused** （未使用）か **Dangling** （宙吊り）チェックボックスで、削除したいイメージの種類を選びます。

   **Clean up images** ステータスバーには、選択したイメージを削除した後、確保できる容量を表示します。

3. 確認し、 **Remove** を選べます。

.. Interact with remote repositories
.. _desktop-interact-with-remote-repositories:

リモートリポジトリとのやりとり
==============================

.. The Images view also allows you to manage and interact with images in remote repositories and lets you switch between organizations. Select an organization from the drop-down to view a list of repositories in your organization.

**Images** の表示では、リモート リポジトリにあるイメージの管理や操作ができます。また、組織（organization）へも切り替えできます。自分の組織のリポジトリ一覧を表示するには、ドロップダウンメニューから組織名を選択します。

..  Note
    If you have a paid Docker subscription and enabled Vulnerability Scanning in Docker Hub, the scan results appear on the Remote repositories tab. The Pull option allows you to pull the latest version of the image from Docker Hub. The View in Hub option opens the Docker Hub page and displays detailed information about the image, such as the OS architecture, size of the image, the date when the image was pushed, and a list of the image layers.

.. note::

   Docker 有償サブスクリプション契約があり、 Docker Hub で :doc:`脆弱性検査 </docker-hub/vulnerability-scanning>` を有効にしている場合、 :ruby:`リモートリポジトリ <REMOTE REPOSITORIES>` のタブで検査結果を表示できます。 **PULL** オプションは、 Docker Hub から最新版のイメージをダウンロードします。 **View in Hub** オプションは Docker Hub ページを開き、 OS アーキテクチャ、イメージの容量、イメージの送信日、イメージのレイヤ一覧といった、イメージに関する詳細情報を表示します。

.. To interact with remote repositories:

リモートリポジトリを操作するには、次のように実行します。

..  Click the Remote repositories tab.
    Select an organization from the drop-down list. This displays a list of repositories in your organization.
    Hover over an image from the list and then select Pull to pull the latest image from the remote repository.

1. **REMOTE REPOSITORIES** タブをクリックします。
2. ドロップダウンメニューのリストラから、対象となる組織をクリックします。自分の組織にあるイメージ一覧を表示します。
3. リモートリポジトリから最新のイメージをダウンロードするには、 一覧のイメージの上にマウスカーソルを移動し､ **PULL** を選びます。

.. To view a detailed information about the image in Docker Hub, select the image and then click View in Hub.

Docker Hub にあるイメージの詳細情報を表示するには、対象のイメージを選び、 **View in Hub** をクリックします。

.. The View in Hub option opens the Docker Hub page and displays detailed information about the image, such as the OS architecture, size of the image, the date when the image was pushed, and a list of the image layers.

**View in Hub** オプションは Docker Hub ページを開き、 OS アーキテクチャ、イメージの容量、イメージの送信日、イメージのレイヤ一覧といった、イメージに関する詳細情報を表示します。

.. If you have a paid Docker subscription and have enabled Vulnerability Scanning the Docker Hub page also displays a summary of the vulnerability scan report and provides detailed information about the vulnerabilities identified.

Docker 有償サブスクリプション契約があり、 Docker Hub で :doc:`脆弱性検査 </docker-hub/vulnerability-scanning>` を有効にしている場合、 Docker Hub ページでも脆弱性検査の概要を表示し、さらに、発見された脆弱性に関する詳細情報を表示します。


.. seealso::

   Explore Images
      https://docs.docker.com/desktop/use-desktop/images/
