.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/containers/dockervolumes/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/containers/dockervolumes.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/containers/dockervolumes.md
.. check date: 2016/04/16
.. Commits on May 5, 2016 c7e738d641e83ab955be423b70b9ed364dba9637
.. ----------------------------------------------------------------------------

.. _dockervolumes:

.. Manage data in containers

=======================================
コンテナでデータを管理
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. So far you’ve been introduced to some basic Docker concepts, seen how to work with Docker images as well as learned about networking and links between containers. In this section you’re going to learn how you can manage data inside and between your Docker containers.

これまでは :doc:`基本的な Docker の概念 <usingdocker>` や、:doc:`Docker イメージ <dockerimages>` の導入部に加え、 :doc:`コンテナのネットワーク <networkingcontainers>` について学びました。このセクションでは、どのようにしてコンテナ内やコンテナ間でデータを管理できるか学びます。

.. You’re going to look at the two primary ways you can manage data with Docker Engine.

それでは、Docker Engine でデータを管理するための、主な手法２つを見ていきます。

.. 
    Data volumes
    Data volume containers

* データ・ボリューム
* データ・ボリューム・コンテナ

.. Data volumes

データ・ボリューム
====================

.. A data volume is a specially-designated directory within one or more containers that bypasses the Union File System. Data volumes provide several useful features for persistent or shared data:

*データ・ボリューム (data volume)* とは、１つまたは複数のコンテナ内で、特別に設計されたディレクトリです。また、 :ref:`ユニオン・ファイルシステム (Union File System) <union-file-system>` をバイパス（迂回）するものです。データ・ボリュームは、データの保持や共有のために、複数の便利な機能を提供します。

..    Volumes are initialized when a container is created. If the container’s base image contains data at the specified mount point, that existing data is copied into the new volume upon volume initialization.
    Data volumes can be shared and reused among containers.
    Changes to a data volume are made directly.
    Changes to a data volume will not be included when you update an image.
    Data volumes persist even if the container itself is deleted.

* ボリュームはコンテナ作成時に初期化されます。コンテナのベース・イメージ上で、特定のマウント・ポイント上のデータが指定されている場合、初期化されたボリューム上に既存のデータをコピーします。
* データ・ボリュームはコンテナ間で共有・再利用できます。
* データ・ボリュームに対する変更を直接行えます。
* イメージを更新しても、データ・ボリューム上には影響ありません。
* コンテナ自身を削除しても、データ・ボリュームは残り続けます。

.. Data volumes are designed to persist data, independent of the container’s life cycle. Docker therefore never automatically deletes volumes when you remove a container, nor will it “garbage collect” volumes that are no longer referenced by a container.

データ・ボリュームは、データ保持のために設計されており、コンテナのライフサイクルとは独立しています。そのため、コンテナの削除時、Docker は *決して* 自動的にボリュームを消さないだけでなく、コンテナから参照されなくなっても"後片付け"をせず、ボリュームはそのままです。

.. Adding a data volume

データ・ボリュームの追加
------------------------------

.. You can add a data volume to a container using the -v flag with the docker create and docker run command. You can use the -v multiple times to mount multiple data volumes. Now, mount a single volume in your web application container.

``docker create`` か ``docker run`` コマンドで ``-v`` フラグを使えば、コンテナにデータ・ボリュームを追加できます。``-v`` を複数回使うことで、複数のデータ・ボリュームをマウントできます。それでは、ウェブ・アプリケーションのコンテナに対して、ボリュームを１つ割り当ててみましょう。

.. code-block:: bash

   $ docker run -d -P --name web -v /webapp training/webapp python app.py

.. This will create a new volume inside a container at /webapp.

これはコンテナの中に ``/webapp`` という新しいボリュームを作成しました。

..    Note: You can also use the VOLUME instruction in a Dockerfile to add one or more new volumes to any container created from that image.

.. note::

   ``Dockerfile`` で ``VOLUME`` 命令を使ってもボリュームを作成できます、イメージから作成するあらゆるコンテナに対し、新しいボリュームを追加可能です。


.. Docker volumes default to mount in read-write mode, but you can also set it to be mounted read-only.

標準では、 Docker はボリュームを読み書き可能な状態でマウントします。あるいは、読み込み専用(read-only) を指定したマウントも可能です。

.. code-block:: bash

   $ docker run -d -P --name web -v /opt/webapp:ro training/webapp python app.py

.. Locating a volume

ボリュームの場所
--------------------

.. You can locate the volume on the host by utilizing the ‘docker inspect’ command.

``docker inspect`` コマンドを使い、ホスト上でボリュームが使っている場所を探せます。

.. code-block:: bash

   $ docker inspect web

.. The output will provide details on the container configurations including the volumes. The output should look something similar to the following:

ボリュームに関する情報を含む、コンテナの詳細設定を表示します。出力は、おそらく次のようなものでしょう。

.. code-block:: bash

   ...
   "Mounts": [
       {
           "Name": "fac362...80535",
           "Source": "/var/lib/docker/volumes/fac362...80535/_data",
           "Destination": "/webapp",
           "Driver": "local",
           "Mode": "",
           "RW": true,
           "Propagation": ""
       }
   ]
   ...

.. You will notice in the above ‘Source’ is specifying the location on the host and ‘Destination’ is specifying the volume location inside the container. RW shows if the volume is read/write.

ホスト上に場所にあたるのは、上の 'Source' （ソース）です。コンテナ内のボリューム指定は `Destination` です。``RW`` の表示は、ボリュームの読み書き可能を意味します。

.. Mount a host directory as a data volume

.. _mount-a-host-directory-as-a-data-volume:

データ・ボリュームとしてホスト上のディレクトリをマウント
------------------------------------------------------------

.. In addition to creating a volume using the -v flag you can also mount a directory from your Engine daemon’s host into a container.

``-v`` フラグの使用はボリューム作成だけではありません。Docker Engine デーモンのホスト上にあるディレクトリも、コンテナにマウント可能です。

.. code-block:: bash

    $ docker run -d -P --name web -v /src/webapp:/opt/webapp training/webapp python app.py

.. This command mounts the host directory, /src/webapp, into the container at /opt/webapp. If the path /opt/webapp already exists inside the container’s image, the /src/webapp mount overlays but does not remove the pre-existing content. Once the mount is removed, the content is accessible again. This is consistent with the expected behavior of the mount command.

このコマンドはホスト側のディレクトリ ``/src/webapp`` をコンテナ内の ``/opt/webapp`` にマウントします。パス ``/opt/webapp`` がコンテナ内のイメージに存在している場合でも、``/src/webapp`` を重複マウントします。しかし、既存の内容は削除しません。マウントを解除したら、内容に対して再度アクセス可能となります。これは、通常の mount コマンドと同じような動作をします。

.. The container-dir must always be an absolute path such as /src/docs. The host-dir can either be an absolute path or a name value. If you supply an absolute path for the host-dir, Docker bind-mounts to the path you specify. If you supply a name, Docker creates a named volume by that name.

``コンテナ内のディレクトリ`` は、``/src/docs`` のように、常に絶対パスが必要です。``ホスト側のディレクトリ`` は相対パスでも ``名前`` でも構いません。``ホスト側のディレクトリ`` に対して絶対パスを指定したら、Docker は指定したパスを拘束マウント（bind-mount）します。この時に ``名前`` の値を指定したら、Docker は指定した ``名前`` のボリュームを作成します。

.. A name value must start with start with an alphanumeric character, followed by a-z0-9, _ (underscore), . (period) or - (hyphen). An absolute path starts with a / (forward slash).

``名前`` の値は、アルファベットの文字で開始する必要があります。具体的には、 ``a-z0-9`` 、``_`` （アンダースコア）、 ``.`` （ピリオド）、 ``-`` （ハイフン）です。絶対パスの場合は ``/`` （スラッシュ）で開始します。

.. For example, you can specify either /foo or foo for a host-dir value. If you supply the /foo value, Engine creates a bind-mount. If you supply the foo specification, Engine creates a named volume.

例えば、``ホスト側ディレクトリ`` に ``/foo`` または ``foo`` を指定可能です。``/foo`` 値を指定したら、Docker は（ディレクトリを）拘束したマウントを作成します。``foo`` を指定したら、Docker Engine はその名前でボリュームを作成します。

.. If you are using Docker Machine on Mac or Windows, your Docker daemon has only limited access to your OS X or Windows filesystem. Docker Machine tries to auto-share your /Users (OS X) or C:\Users (Windows) directory. So, you can mount files or directories on OS X using.

Mac または Windows 上で Docker Machine を使う場合、Docker デーモンは OS X または Windows ファイルシステム上に限定的なアクセスを行います。Docker Machine は自動的に ``/Users`` (OS X) または ``C:\Users`` (Windows) ディレクトリのマウントを試みます。つまり、OS X 上で使っているファイルやディレクトリをマウント可能です。

.. code-block:: bash

   docker run -v /Users/<パス>:/<コンテナ内のパス> ...

.. On Windows, mount directories using:

Windows 上でも、同様にディレクトリのマウントが使えます。

.. code-block:: bash

   docker run -v /c/Users/<パス>:/<コンテナ内のパス> ...`

.. All other paths come from your virtual machine’s filesystem. For example, if you are using VirtualBox some other folder available for sharing, you need to do additional work. In the case of VirtualBox you need to make the host folder available as a shared folder in VirtualBox. Then, you can mount it using the Docker -v flag.

パスには、仮想マシンのファイルシステム上にある全てのパスを指定できます。もし VirtualBox などでフォルダの共有機能を使っているのであれば、追加の設定が必要です。VirtualBox の場合は、ホスト上のフォルダを共有フォルダとして登録する必要があります。それから、Docker の ``-v`` フラグを使ってマウントできます。

.. Mounting a host directory can be useful for testing. For example, you can mount source code inside a container. Then, change the source code and see its effect on the application in real time. The directory on the host must be specified as an absolute path and if the directory doesn’t exist the Engine daemon will automatically creates it for you. This auto-creation of the host path has been deprecated.

ホスト上のディレクトリをマウントするのは、テストに便利かも知れません。例えば、ソースコードをコンテナの中にマウントしたとします。次にソースコードに変更を加え、アプリケーションにどのような影響があるのか、リアルタイムで確認できます。ホスト側のディレクトリは絶対パスで指定する必要があります。もしディレクトリが存在しない場合、Docker Engine のデーモンは自動的にディレクトリを作成します。このホスト・パスの自動生成機能は廃止予定です。

.. Docker volumes default to mount in read-write mode, but you can also set it to be mounted read-only.

Docker ボリュームは、標準で読み書き可能な状態でマウントしますが、読み込み専用としてのマウントもできます。

.. code-block:: bash

   $ docker run -d -P --name web -v /src/webapp:/opt/webapp:ro training/webapp python app.py

.. Here you’ve mounted the same /src/webapp directory but we’ve added the ro option to specify that the mount should be read-only.

ここでは同じ ``/src/webapp`` ディレクトリをマウントしていますが、読み込み専用を示す ``ro`` オプションを指定しています。

.. Because of limitations in the mount function, moving subdirectories within the host’s source directory can give access from the container to the host’s file system. This requires a malicious user with access to host and its mounted directory.

`mount機能の制限 <http://lists.linuxfoundation.org/pipermail/containers/2015-April/035788.html>`_ により、ホスト側のソース・ディレクトリ内のサブディレクトリに移動したら、コンテナの中からホスト上のファイルシステムに移動できる場合があります。ただし、悪意を持つユーザがホストにアクセスし、ディレクトリを直接マウントする必要があります。

.. Note: The host directory is, by its nature, host-dependent. For this reason, you can’t mount a host directory from Dockerfile because built images should be portable. A host directory wouldn’t be available on all potential hosts.

.. note::

   ホスト・ディレクトリとは、ホストに依存する性質があります。そのため、ホストディレクトリを ``Dockerfile`` でマウントできません。なぜなら、イメージの構築はポータブル（どこでも実行可能な状態の意味）であるべきだからです。全てのホスト環境でホスト・ディレクトリを使えるとは限りません。

.. Mount a shared-storage volume as a data volume

.. _mount-a-shared-storage-volume-as-a-data-volume:

共有ストレージをデータ・ボリュームとしてマウント
--------------------------------------------------

.. In addition to mounting a host directory in your container, some Docker volume plugins allow you to provision and mount shared storage, such as iSCSI, NFS, or FC.

コンテナにホスト側ディレクトリをマウントできるだけではありません。、いくつかの Docker :doc:`ボリューム・プラグイン </engine/extend/plugins_volume>` は iSCSI、NFS、FC のような共有ストレージにプロビジョニングやマウントが可能です。

.. A benefit of using shared volumes is that they are host-independent. This means that a volume can be made available on any host that a container is started on as long as it has access to the shared storage backend, and has the plugin installed.

共有ボリュームを使う利点は、ホストに依存しない点です。つまり、あらゆるホスト上で利用可能なボリュームを扱えます。共有ストレージ・バックエンドにアクセス可能なホストと、プラグインさえインストールしておけば、コンテナがどこで動いてもボリュームを利用可能です。

.. One way to use volume drivers is through the docker run command. Volume drivers create volumes by name, instead of by path like in the other examples.

``docker run`` コマンドでボリューム・ドライバを使う方法は１つです。ボリューム・ドライバでボリュームの作成時、他の例のようにパスを指定せず、ボリューム名を指定します。

.. The following command creates a named volume, called my-named-volume, using the flocker volume driver, and makes it available within the container at /opt/webapp:

次のコマンドは ``my-named-volume`` という名前付きのボリュームを作成するコマンドです。作成には ``flocker`` ボリューム・ドライバを使い、コンテナからは ``/opt/webapp`` で利用できるようにします。

.. code-block:: bash

   $ docker run -d -P \
     --volume-driver=flocker \
     -v my-named-volume:/opt/webapp \
     --name web training/webapp python app.py

.. You may also use the docker volume create command, to create a volume before using it in a container.

あるいは、コンテナを作成する前でも、コンテナが使うボリュームを  ``docker volume create`` コマンドで作成できます。

.. The following example also creates the my-named-volume volume, this time using the docker volume create command.

次の例は　``docker volume create`` コマンドを使い ``my-named-volume`` ボリュームを作成します。

.. code-block:: bash

   $ docker volume create -d flocker --name my-named-volume -o size=20GB
   $ docker run -d -P \
     -v my-named-volume:/opt/webapp \
     --name web training/webapp python app.py

.. A list of available plugins, including volume plugins, is available here.

ボリューム・プラグインを含む利用可能なプラグインの一覧は :doc:`こちら </engine/extend/plugins>`　をご覧ください。

.. Volume labels

ボリューム・ラベル
--------------------

.. Labeling systems like SELinux require that proper labels are placed on volume content mounted into a container. Without a label, the security system might prevent the processes running inside the container from using the content. By default, Docker does not change the labels set by the OS.

SELinux のようなラベリング・システムでは、コンテナ内にマウントされたボリュームの内容に対しても、適切なラベル付けが行われます。ラベルがなければ、コンテナ内の内容物を使って実行しようとしても、セキュリティ・システムがプロセスの実行を妨げるでしょう。標準では、Docker は OS によって設定されるラベルに対して変更を加えません。

.. To change a label in the container context, you can add either of two suffixes :z or :Z to the volume mount. These suffixes tell Docker to relabel file objects on the shared volumes. The z option tells Docker that two containers share the volume content. As a result, Docker labels the content with a shared content label. Shared volume labels allow all containers to read/write content. The Z option tells Docker to label the content with a private unshared label. Only the current container can use a private volume.

コンテナの内容物に対するラベルを変更するには、ボリュームのマウントにあたり、``:z`` または ``:Z`` を末尾に追加可能です（接尾辞）。これらの指定したら、Docker に対して共有ボリュームが再度ラベル付けされたものと伝えます。``z`` オプションは、ボリュームの内容を複数のコンテナが共有していると Docker に伝えます。その結果、Docker は共有コンテント・ラベルとして内容をラベル付けします。``Z`` オプションは、内容はプライベートで共有されるべきではない（private unshared）ラベルと Docker に伝えます。現在のコンテナのみが、プライベートに（個別に）ボリュームを利用可能です。

.. Mount a host file as a data volume

ホスト上のファイルをデータ・ボリュームとしてマウント
------------------------------------------------------------

.. The -v flag can also be used to mount a single file - instead of just directories - from the host machine.

``-v`` フラグはホストマシン上のディレクトリ *だけ* ではなく、単一のファイルに対してもマウント可能です。


.. code-block:: bash

   $ docker run --rm -it -v ~/.bash_history:/.bash_history ubuntu /bin/bash

.. This will drop you into a bash shell in a new container, you will have your bash history from the host and when you exit the container, the host will have the history of the commands typed while in the container.

これは新しいコンテナ内の bash シェルを流し込むものです。コンテナを終了する時に、ホスト上の bash 履歴に対して、コンテナ内で実行したコマンドを履歴として記録します。

..    Note: Many tools used to edit files including vi and sed --in-place may result in an inode change. Since Docker v1.1.0, this will produce an error such as “sed: cannot rename ./sedKdJ9Dy: Device or resource busy”. In the case where you want to edit the mounted file, it is often easiest to instead mount the parent directory.

.. note::

   ``vi`` や ``sed --in-place`` など、多くのツールによる編集は、結果としてiノードを変更する場合があります。Docker v1.1.0 までは、この影響により *“sed: cannot rename ./sedKdJ9Dy: Device or resource busy" (デバイスまたはリソースがビジー)* といったエラーが表示されることがありました。マウントしたファイルを編集したい場合、親ディレクトリのマウントが最も簡単です。

.. Creating and mounting a data volume container

データ・ボリューム・コンテナの作成とマウント
==================================================

.. If you have some persistent data that you want to share between containers, or want to use from non-persistent containers, it’s best to create a named Data Volume Container, and then to mount the data from it.

データに永続性を持たせたい場合（データを保持し続けたい場合）、例えばコンテナ間での共有や、データを保持しないコンテナから使うには、名前を付けたデータ・ボリューム・コンテナ（Data Volume Container）を作成し、そこにデータをマウントするのが良い方法です。

.. Let’s create a new named container with a volume to share. While this container doesn’t run an application, it reuses the training/postgres image so that all containers are using layers in common, saving disk space.

ボリュームを持ち、共有するための新しい名前付きコンテナを作成しましょう。``training/postgres`` イメージを再利用し、全てのコンテナから利用可能なレイヤを作成し、ディスク容量を節約します。

.. code-block:: bash

   $ docker create -v /dbdata --name dbdata training/postgres /bin/true

.. You can then use the --volumes-from flag to mount the /dbdata volume in another container.

次に、``--volumes-from`` フラグを使い、他のコンテナから ``/dbdata`` ボリュームをマウント可能です。

.. code-block:: bash

   $ docker run -d --volumes-from dbdata --name db1 training/postgres

.. And another:

あるいは、他からも。

.. code-block:: bash

   $ docker run -d --volumes-from dbdata --name db2 training/postgres

.. In this case, if the postgres image contained a directory called /dbdata then mounting the volumes from the dbdata container hides the /dbdata files from the postgres image. The result is only the files from the dbdata container are visible.

この例では、``postgres`` イメージには ``/dbdata`` と呼ばれるディレクトリが含まれています。そのため ``dbdata`` コンテナからボリュームをマウントする（volumes from）とは、元の ``postgres`` イメージから ``/dbdata`` が隠された状態です。この結果、``dbdata`` コンテナからファイルを表示しているように見えます。

.. You can use multiple --volumes-from parameters to bring together multiple data volumes from multiple containers.

``--volumes-from`` パラメータは複数回利用できます。複数のコンテナから、複数のデータボリュームを一緒に扱えます。

.. You can also extend the chain by mounting the volume that came from the dbdata container in yet another container via the db1 or db2 containers.

また、ボリュームのマウントは連鎖（chain）できます。この例では、``dbdata`` コンテナのボリュームは ``db1`` コンテナと ``db2`` コンテナからマウントできるだけとは限りません。

.. code-block:: bash

   $ docker run -d --name db3 --volumes-from db1 training/postgres

.. If you remove containers that mount volumes, including the initial dbdata container, or the subsequent containers db1 and db2, the volumes will not be deleted. To delete the volume from disk, you must explicitly call docker rm -v against the last container with a reference to the volume. This allows you to upgrade, or effectively migrate data volumes between containers.

ボリュームをマウントしているコンテナを削除する場合、ここでは１つめの ``dbdata`` コンテナや、派生した ``db1`` と ``db2`` コンテナのボリュームは削除されません。ディスクからボリュームを削除したい場合は、最後までボリュームをマウントしていたコンテナで、必ず ``docker rm -v`` を実行する必要があります。この機能を使えば、コンテナ間でのデータボリュームの移行や更新を効率的に行えます。

..  Note: Docker will not warn you when removing a container without providing the -v option to delete its volumes. If you remove containers without using the -v option, you may end up with “dangling” volumes; volumes that are no longer referenced by a container. Dangling volumes are difficult to get rid of and can take up a large amount of disk space. We’re working on improving volume management and you can check progress on this in pull request #14214

.. note::

   コンテナ削除時、``-v`` オプションでボリュームを消そうとしなくても、Docker は何ら警告を表示しません。 ``-v`` オプションに使わずにコンテナを削除した場合、ボリュームは最終的にどのコンテナからも参照されない "宙づり"(dangling) ボリュームになってしまいます。宙づりボリュームは除去が大変であり、多くのディスク容量を使用する場合もあります。このボリューム管理の改善については、現在 `プルリクエスト#14214 <https://github.com/docker/docker/pull/14214>`_ において議論中です。

.. Backup, restore, or migrate data volume

.. _backup-restore-or-migrate-data-volumes:

データ・ボリュームのバックアップ・修復・移行
==================================================

.. Another useful function we can perform with volumes is use them for backups, restores or migrations. You do this by using the --volumes-from flag to create a new container that mounts that volume, like so:

ボリュームを使った他の便利な機能に、バックアップや修復、移行があります。これらの作業を使うには、新しいコンテナを作成する時に ``--volumes-from`` フラグを使い、次のようにボリュームをマウントします。

.. code-block:: bash

   $ docker run --volumes-from dbdata -v $(pwd):/backup ubuntu tar cvf /backup/backup.tar /dbdata

.. Here you’ve launched a new container and mounted the volume from the dbdata container. You’ve then mounted a local host directory as /backup. Finally, you’ve passed a command that uses tar to backup the contents of the dbdata volume to a backup.tar file inside our /backup directory. When the command completes and the container stops we’ll be left with a backup of our dbdata volume.

ここでは新しいコンテナを起動し、``dbdata`` コンテナからボリュームをマウントします。そして、ローカルのホスト上のディレクトリを ``/backup`` としてマウントします。最終的に、``dbdata`` ボリュームに含まれる内容をバックアップするため、  ``tar`` コマンドを使い ``/backup`` ディレクトリの中にあるファイルを  ``backup.tar`` に通します。コマンドの実行が完了したら、コンテナは停止し、``dbdata`` ボリュームのバックアップが完了します。

.. You could then restore it to the same container, or another that you’ve made elsewhere. Create a new container.

これで同じコンテナに修復（リストア）や、他のコンテナへの移行もできます。新しいコンテナを作成してみましょう。

.. code-block:: bash

   $ docker run -v /dbdata --name dbdata2 ubuntu /bin/bash

.. Then un-tar the backup file in the new container’s data volume.

それから、新しいコンテナのデータ・ボリュームにバックアップしたファイルを展開します。

.. code-block:: bash

   $ docker run --volumes-from dbstore2 -v $(pwd):/backup ubuntu bash -c "cd /dbdata && tar xvf /backup/backup.tar"

.. You can use the techniques above to automate backup, migration and restore testing using your preferred tools.

この手法を使うことで、好みのツールを用いた自動バックアップ、移行、修復が行えます。

.. Removing volumes

.. _removing-volumes:

ボリュームの削除
====================

.. A Docker data volume persists after a container is deleted. You can create named or anonymous volumes. Named volumes have a specific source form outside the container, for example awesome:/bar. Anonymous volumes have no specific source. When the container is deleted, you should instruction the Engine daemon to clean up anonymous volumes. To do this, use the --rm option, for example:

Docker データ・ボリュームはコンテナを削除しても残り続けます。ボリュームは名前を付けるかアノニマスで作成できます。名前付きボリュームはコンテナの外から ``awesome:/bar`` のように参照元（ソース）を指定できます。アノニマス・ボリュームはソースを指定できません。コンテナを削除時、 Docker Engine に対してアノニマス・ボリュームを削除するよう指示する必要があります。そのためには、 ``--rm`` オプションを使います。例：

.. code-block:: bash

   $ docker run --rm -v /foo -v awesome:/bar busybox top

.. This command creates an anonymous /foo volume. When the container is removed, Engine removes the /foo volume but not the awesome volume.

このコマンドはアノニマス ``/foo``  ボリュームを作成します。コンテナを削除時、Engine は ``/foo`` ボリュームを削除しますが、 ``awesome`` ボリュームは削除しません。

.. Important tips on using shared volumes

.. important-tips-on-using-shared-volumes:

ボリューム共有時の重要なヒント
==============================

.. Multiple containers can also share one or more data volumes. However, multiple containers writing to a single shared volume can cause data corruption. Make sure your applications are designed to write to shared data stores.

複数のコンテナが１つまたは複数のデータ・ボリュームを共有できます。しかしながら、複数のコンテナが１つの共有ボリュームに書き込むことにより、データ破損を引き起こす場合があります。アプリケーションが共有データ・ストアに対する書き込みに対応した設計かどうか、確認してください。

.. Data volumes are directly accessible from the Docker host. This means you can read and write to them with normal Linux tools. In most cases you should not do this as it can cause data corruption if your containers and applications are unaware of your direct access.

データ・ボリュームは Docker ホストから直接アクセス可能です。これが意味するのは、データ・ボリュームは通常の Linux ツールから読み書き可能です。コンテナとアプリケーションが直接アクセスできることを知らないことにより、データの改竄を引き起こすことは望ましくありません。

.. Next steps

次のステップ
====================

.. Now you’ve learned a bit more about how to use Docker we’re going to see how to combine Docker with the services available on Docker Hub including Automated Builds and private repositories.

これまでは、どのようにして Docker を使うのかを少々学びました。次は Docker と `Docker Hub <https://hub.docker.com/>`_ で利用可能なサービスを連携し、自動構築（Automated Build）やプライベート・リポジトリ（private repository）について学びます。

.. Go to Working with Docker Hub.

:doc:`Docker Hub の操作 <dockerrepos>` に移動します。

.. seealso:: 

   Manage data in containers
      https://docs.docker.com/engine/userguide/containers/dockervolumes/
