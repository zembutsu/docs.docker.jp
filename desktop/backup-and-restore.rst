
.. Save and restore data

.. _mac-save-and-restore-data:

データの保存と修復
--------------------

.. You can use the following procedure to save and restore images and container data. For example, if you want to switch between Edge and Stable, or to reset your VM disk:

以下の手順を用いて、イメージとコンテナのデータを保存・修復できます。例えば、Edge と Stable を切り替えたいときや、仮想マシンのディスクをリセットしたいときに用います。

..    Use docker save -o images.tar image1 [image2 ...] to save any images you want to keep. See save in the Docker Engine command line reference.

1.  :code:`docker save -o images.tar image1 [image2 ....]` を使い、保持したい全てのイメージを保存します。Docker Engine コマンドライン・リファレンスの :doc:`save </engine/reference/commandline/save>` セクションを御覧ください。

..    Use docker export -o myContainner1.tar container1 to export containers you want to keep. See export in the Docker Engine command line reference.

2.  :code:`docker export -o myContainer1.tar container` を使い、保持したい全てのコンテナをエクスポート（出力）します。Docker Engine コマンドライン・リファレンスの :doc:`export </engine/reference/commandline/export>` セクションを御覧ください。

..    Uninstall the current version of Docker Desktop and install a different version (Stable or Edge), or reset your VM disk.

3. 現在のバージョンの Docker Desktop をアンインストールし、異なるバージョン（Stable 又は Edge）をインストールし、仮想マシン・ディスクをリセットします。

..    Use docker load -i images.tar to reload previously saved images. See load in the Docker Engine.

4. :code:`docker load -i images.tar` を使い、以前に保存したイメージを再読み込みします。Docker Engine の  :doc:`load </engine/reference/commandline/load>` を御覧ください。

..    Use docker import -i myContainer1.tar to create a filesystem image corresponding to the previously exported containers. See import in the Docker Engine.

5. :code:`docker import -i myContainer1.tar` を使い、以前にエクスポートしたコンテナに対応するファイルシステム・イメージを作成します。Docker Engine の   :doc:`import </engine/reference/commandline/import>` を御覧ください。

.. For information on how to back up and restore data volumes, see Backup, restore, or migrate data volumes.

データ・ボリュームのバックアップと修復の仕方に関する情報は、 :ref:`backup-restore-or-migrate-data-volumes` を御覧ください。

