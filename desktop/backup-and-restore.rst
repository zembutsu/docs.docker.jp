.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/backup-and-restore/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/backup-and-restore.md
.. check date: 2022/09/17
.. Commits on Jun 14, 2022 cb777edea9927f36aeb445099b62afb3c205b60d
.. -----------------------------------------------------------------------------

.. Back up and restore data
.. _desktop-back-up-and-restore-data:

=======================================
バックアップとデータ修復
=======================================

.. sidebar:: 目次

   .. contents::
       :depth: 3
       :local:

.. Use the following procedure to save and restore your images and container data. This is useful if you want to reset your VM disk or to move your Docker environment to a new computer, for example.

以下の手順を用いて、イメージとコンテナのデータを保存・修復できます。VM ディスクをリセットしたい場合や、 Docker 環境を新しいコンピュータに移動したい場合などに役立ちます。

..    Should I back up my containers?
    If you use volumes or bind-mounts to store your container data, backing up your containers may not be needed, but make sure to remember the options that were used when creating the container or use a Docker Compose file if you want to re-create your containers with the same configuration after re-installation.

.. note::

   **私のコンテナをバックアップすべきですか？**
   
   コンテナのデータをボリュームやバインド マウントに保存している場合、コンテナのバックアップは不要かもしれません。ですが、コンテナ作成時に使用したオプションを確実に覚えておくか、再インストール後に同じ設定でコンテナを再作成したい場合は、 :doc:`Docker Compose ファイル </compose/compose-file/index>` の利用を検討ください。

.. Save your data
.. _desktop-backup-save-your-data:

データの保存
====================

..    Commit your containers to an image with docker container commit.
..    Committing a container stores the container filesystem changes and some of the container’s configuration, for example labels and environment-variables, as a local image. Be aware that environment variables may contain sensitive information such as passwords or proxy-authentication, so care should be taken when pushing the resulting image to a registry.
..    Also note that filesystem changes in volume that are attached to the container are not included in the image, and must be backed up separately.
..    If you used a named volume to store container data, such as databases, refer to the backup, restore, or migrate data volumes page in the storage section.


1. ``docker container commit`` でコンテナをイメージにコミットします。

   コンテナへのコミットは、コンテナ内ファイルシステムの変更とコンテナ内の設定、たとえばラベルと環境変数、ローカルのイメージとしてを保存します。環境変数にはパスワードやプロキシ認証のような機微情報を含む場合があるため、注意してください。イメージをレジストリに送信する場合には、注意を払う必要があります。

   また、コンテナにアタッチしているボリューム内では、ファイルシステムへの変更はイメージに含まれません。そのため、個別にバックアップが必要です。

   データベースのようなコンテナデータを保管するために :ref:`名前付きボリューム <more-details-about-mount-types>` を使っている場合、ストレージのセクションにある :ref:`backup-restore-or-migrate-data-volumes` をご覧ください。


..    Use docker push to push any images you have built locally and want to keep to the Docker Hub registry.
..    Make sure to configure the repository’s visibility as “private” for images that should not be publicly accessible.
..    Alternatively, use docker image save -o images.tar image1 [image2 ...] to save any images you want to keep to a local tar file.


.. After backing up your data, you can uninstall the current version of Docker Desktop and install a different version or reset Docker Desktop to factory defaults.

2.  ``docker push`` を使うと、ローカルで構築したイメージを送信できるようになり、 :doc:`Docker Hub レジストリ </docker-hub/index>` に保管できるようになります。

   イメージに対して :ref:`リポジトリの可視性を「private」 <docker-hub-private-repositories>` に設定すると、パブリックにアクセスできなくなります。

   あるいは、 ``docker image save -o images.tar image1 [image2 ...]`` を使えば、あらゆるイメージをローカルの tar ファイルとして維持できるよう保存します。

.. After backing up your data, you can uninstall the current version of Docker Desktop and install a different version or reset Docker Desktop to factory defaults.

データのバックアップ後は、現在のバージョンの Docker Desktop をアンインストールし、 :doc:`異なるバージョンのインストール <release-note>` や Docker Desktop を初期状態のデフォルトにリセットできます。

.. Restore your data
.. _desktop-restore-your-data:

データの復旧
====================

..     Use docker pull to restore images you pushed to Docker Hub.
..     If you backed up your images to a local tar file, use docker image load -i images.tar to restore previously saved images.

1. Docker Hub に送信したイメージを復旧するには、 ``docker pull`` を使います。

   ローカルの tar ファイルとしてイメージをバックアップしている場合は、保存済みのイメージを復旧するために :doc:`docker image load -i images.tar </engine/reference/commandline/load>` を使います。

..     Re-create your containers if needed, using docker run, or Docker Compose.

2. コンテナを再作成する必要があれば、 ``docker run`` を使うか、 :doc:`Docker Compose </compose/index>` を使います。

.. Refer to the backup, restore, or migrate data volumes page in the storage section to restore volume data.

ボリュームデータの復旧は、ストレージセクションにある :ref:`backup-restore-or-migrate-data-volumes` をご覧ください。

.. seealso::

   Back up and restore datam
      https://docs.docker.com/desktop/backup-and-restore/

