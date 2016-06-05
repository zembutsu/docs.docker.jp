.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/extend/plugins_volume/
.. doc version: 1.9
.. check date: 2016/01/09

.. Write a volume plugin

.. _write-a-volume-plugin:

========================================
Docker ボリューム・プラグインを書く
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker volume plugins enable Docker deployments to be integrated with external storage systems, such as Amazon EBS, and enable data volumes to persist beyond the lifetime of a single Docker host. See the plugin documentation for more information.

Docker ボリューム・プラグインとは、Amazon EBS のような外部のストレージ・システムと統合した環境に Docker をデプロイできるようにします。そして、単一の Docker ホスト上で、データ・ボリュームを使う間はその一貫性をもたらします。詳しい情報は :doc:`プラグインのドキュメント <plugins>` をご覧ください。

.. Command-line changes

.. _command-line-changes:

コマンドラインの変更
=====================

.. A volume plugin makes use of the -vand --volume-driver flag on the docker run command. The -v flag accepts a volume name and the --volume-driver flag a driver type, for example:

ボリューム・プラグインを使うには ``docker run``  コマンドで ``-v`` と ``--volume-driver`` フラグを指定します。 ``-v`` フラグはボリューム名を受け付け、 ``--volume-driver`` フラグはドライバの種類を指定します。例えば、次のように実行します。

.. code-block:: bash

   $ docker run -ti -v volumename:/data --volume-driver=flocker   busybox sh

.. This command passes the volumename through to the volume plugin as a user-given name for the volume. The volumename must not begin with a /.

このコマンドは、ユーザがボリュームで使う名前を ``volumename`` としてボリューム・プラグインに渡しています。 ``volumename`` は ``/`` で始まってはいけません。

.. By having the user specify a volumename, a plugin can associate the volume with an external volume beyond the lifetime of a single container or container host. This can be used, for example, to move a stateful container from one server to another.

ユーザが ``volumename`` を指定したら、プラグインは１つのコンテナが稼働し続ける間、あるいはコンテナのホスト上における外部ボリュームをプラグインに関連づけます。これを使えば、例えばステートフルなコンテナを、あるサーバから別のサーバに移せます。

.. By specifying a volumedriver in conjunction with a volumename, users can use plugins such as Flocker to manage volumes external to a single host, such as those on EBS.

``volumename`` と ``volumedriver`` を同時に使うよう指定したら、ユーザは `Flocker <https://clusterhq.com/docker-plugin/>`_ のような外部プラグインで単一ホスト上のボリュームや EBS のようなボリュームを管理します。

.. Create a VolumeDriver

ボリューム・ドライバの作成
==============================

.. The container creation endpoint (/containers/create) accepts a VolumeDriver field of type string allowing to specify the name of the driver. It’s default value of "local" (the default driver for local volumes).

コンテナが作成用エンドポイント（  ``/containers/create`` ） の ``volumeDriver`` フィールドにおいて、 ``string`` タイプでドライバ名を指定します。デフォルトの値は ``"local"`` です（デフォルトのドライバは、local ボリュームです）。

.. Volume plugin protocol

.. _volume-plugin-protocol:

ボリューム・プラグイン・プロトコル
========================================

.. If a plugin registers itself as a VolumeDriver when activated, then it is expected to provide writeable paths on the host filesystem for the Docker daemon to provide to containers to consume.

プラグインは自身を ``VolumeDriver`` として登録した時に有効化されます。その後、Docker デーモンがファイルシステム上に、コンテナが使うための書き込み可能なパスを提供します。

.. The Docker daemon handles bind-mounting the provided paths into user containers.

Docker デーモンはユーザのコンテナが指定したパスに対し、マウントの拘束（バインド）を扱います。


.. /VolumeDriver.Create

/VolumeDriver.Create
--------------------------

..   Request:

**リクエスト** :

.. code-block:: bash

   {
       "Name": "volume_name",
       "Opts": {}
   }

.. Instruct the plugin that the user wants to create a volume, given a user specified volume name. The plugin does not need to actually manifest the volume on the filesystem yet (until Mount is called). Opts is a map of driver specific options passed through from the user request.

プラグインはユーザが作成を望むボリュームを、ユーザが指定した名前で作成するよう命令します。プラグインは実際にファイルシステムのボリュームを明示する必要がありません（マウントがコールされるまで）。Opts はドライバ固有のオプションをユーザがリクエストする箇所です。

.. Response:

**応答** :

.. code-block:: bash

   {
       "Err": null
   }

.. Respond with a string error if an error occurred.

エラーが発生した場合は、エラー文字列が表示されます。

/VolumeDriver.Remove
--------------------

.. Request:

**リクエスト** :

.. code-block:: bash

   {
       "Name": "volume_name"
   }

.. Delete the specified volume from disk. This request is issued when a user invokes docker rm -v to remove volumes associated with a container.

ディスクから特定のボリュームを削除します。このリクエストはユーザから ``docker rm -v`` を呼び出されたとき、コンテナに関連するボリュームを削除します。

.. Response:

**応答** :

{
    "Err": null
}

.. Respond with a string error if an error occurred.

エラーが発生した場合は、エラー文字列が表示されます。

/VolumeDriver.Mount
--------------------

.. Request:

**リクエスト** :

.. code-block:: bash

   {
       "Name": "volume_name"
   }

.. Docker requires the plugin to provide a volume, given a user specified volume name. This is called once per container start. If the same volume_name is requested more than once, the plugin may need to keep track of each new mount request and provision at the first mount request and deprovision at the last corresponding unmount request.

Docker でプラグインがボリュームを必要とする場合は、ユーザがボリューム名を指定する必要があります。これは、コンテナが開始される度に必要です。既に作成されているボリューム名で呼び出されると、プラグインは既にマウントされている箇所に対して、新しいマウント・リクエストとプロビジョンが行われると、アンマウント・リクエストが呼び出され、プロビジョニングが取り消されるまで追跡します。

.. Response:

**応答** :

.. code-block:: bash

   {
       "Mountpoint": "/path/to/directory/on/host",
       "Err": null
   }

.. Respond with the path on the host filesystem where the volume has been made available, and/or a string error if an error occurred.

ボリュームが利用可能になったり、あるいはエラーが発生したりする場合には、ホスト・ファイルシステム上のパスを返します。

/VolumeDriver.Path
--------------------

.. Request:

**リクエスト** :

.. code-block:: bash

   {
       "Name": "volume_name"
   }

.. Docker needs reminding of the path to the volume on the host.

Docker はホスト上のボリュームのパスを覚えておく必要があります。

.. Response:

**応答** :

.. code-block:: bash

   {
       "Mountpoint": "/path/to/directory/on/host",
       "Err": null
   }

.. Respond with the path on the host filesystem where the volume has been made available, and/or a string error if an error occurred.

ボリュームが利用可能になったり、あるいはエラーが発生したりする場合には、ホスト・ファイルシステム上のパスを返します。


.. /VolumeDriver.Unmount
------------------------------

.. Request:

**リクエスト** :


.. code-block:: bash

   {
       "Name": "volume_name"
   }

.. Indication that Docker no longer is using the named volume. This is called once per container stop. Plugin may deduce that it is safe to deprovision it at this point.

Docker ホストに指定した名前のボリュームを使わないことを指示します。これはコンテナが停止すると呼び出されます。その時点でプラグインはデプロビジョンが安全に行われているとみなします。

.. Response:

**レスポンス**

.. code-block:: bash

   {
       "Err": null
   }

.. Respond with a string error if an error occurred.

エラーが発生したら、エラー文字列を返します。

.. seealso:: 

   Write a volume plugin
      https://docs.docker.com/engine/extend/plugins_volume/
