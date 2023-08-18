.. H-*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/use-desktop/volumes/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/use-desktop/volumes.md
.. check date: 2022/09/17
.. Commits on Jul 25, 2022 81fb76d3f408c8ea6c0ccdbd2ffb58bf37c8570b
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :width: 50%

.. Explore Volumes
.. _explore-volumes:

=======================================
:ruby:`Volumes <ボリューム>` を見渡す
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The Volumes view in Docker Dashboard enables you to easily create and delete volumes and see which ones are being used. You can also see which container is using a specific volume and explore the files and folders in your volumes.

Docker ダッシュボードの **Volumes** 表示からは、ボリュームの作成や削除が簡単にでき、どのボリュームが使われているかを確認できます。また、特定のボリュームがどのコンテナで使われているかも分かりますし、ボリューム内のファイルとフォルダも調査できます。

.. For more information about volumes, see Use volumes

ボリュームに関する詳しい情報は :doc:`ボリュームを使う </storage/volumes>` をご覧ください。

.. By default, the Volumes view displays a list of all the volumes. Volumes that are currently used by a container display the In Use badge.

デフォルトでは、 **Volumes** ではボリュームの一覧を表示します。使用中のボリュームには **IN USE** のバッジが付きます。

.. Manage your volumes
.. _desktop-manage-your-volumes:

ボリュームの管理
====================

.. Use the Search field to search for any specific volume.

**Search** フォームを使い、特定のボリュームを検索します。

.. You can sort volumes by:

ボリュームを次の順番で並べられます。

..  Name
    Date created
    Size

* 名前
* 作成日
* 容量

.. From the More options menu to the right of the search bar, you can choose what volume information to display.

検索バーの右にある **More options** メニューから、どのボリューム情報を表示するかを選べます。

.. Inspect a volume
.. _desktop-inspect-a-volume:

ボリュームを調査
====================

.. To explore the details of a specific volume, select a volume from the list. This opens the detailed view.

特定のボリュームに対する詳細を調べるには、一覧からボリュームを選択します。そうすると、詳細を表示が開きます。

.. The In Use tab displays the name of the container using the volume, the image name, the port number used by the container, and the target. A target is a path inside a container that gives access to the files in the volume.

**IN USE** （使用中）タブは、ボリュームを使っているコンテナ名、イメージ名、コンテナによって使われているポート番号、 :ruby:`対象 <target>` を表示します。対象とは、ボリューム内がコンテナ内で操作できるパスです。

.. The Data tab displays the files and folders in the volume and the file size. To save a file or a folder, hover over the file or folder and click on the more options menu. Select Save As and then specify a location to download the file.

**DATA** タブは、ボリューム内のファイルとフォルダ、ファイル容量を表示します。ファイルやフォルダを保存するには、ファイルやフォルダの上にマウスカーソルを移動し、 More Options メニューをクリックします。 **Save As** を選ぶと、指定した場所にファイルをダウンロードします。

.. To delete a file or a folder from the volume, select Remove from the More options menu.

ボリュームからファイルやフォルダを削除するには、 **More options** メニューから **Remove** を選びます。

.. Remove a volume
.. _desktop-remove-a-volume:

ボリュームを削除
====================

.. Removing a volume deletes the volume and all its data.

ボリュームを削除すると、ボリュームとボリューム内のデータを削除します。

.. To remove a volume, hover over the volume and then click the Delete icon. Alternatively, select the volume from the list and then click the Delete button.

ボリュームを削除する胃は、ボリュームの上にマウスカーソルを移動し **Delete** アイコンをクリックします。あるいは、一覧からボリュームを選んでから **Delete** ボタンをクリックします。

.. seealso::

   Explore Volumes
      https://docs.docker.com/desktop/use-desktop/volumes/

