.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/extend/plugins_volume/
.. doc version: 1.9
.. check date: 2016/01/09

.. Write a volume plugin

.. _write-a-volume-plugin:

========================================
ボリューム・プラグインの記述
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Engine volume plugins enable Engine deployments to be integrated with
   external storage systems such as Amazon EBS, and enable data volumes to persist
   beyond the lifetime of a single Docker host. See the
   [plugin documentation](legacy_plugins.md) for more information.

Docker Engine ボリューム・プラグインは、Amazon EBS のような外部ストレージシステムと統合した Engine デプロイメントを可能にするものです。
そして単独の Docker ホスト上では維持できない、データボリュームの長期保存を可能にします。
詳細は :doc:`プラグインのドキュメント <./legacy_plugins>` を参照してください。

.. ## Changelog

.. _changelog:

変更履歴
=========

.. ### 1.13.0

1.13.0
-------

.. - If used as part of the v2 plugin architecture, mountpoints that are part of
     paths returned by the plugin must be mounted under the directory specified by
     `PropagatedMount` in the plugin configuration
     ([#26398](https://github.com/docker/docker/pull/26398))

* プラグイン・アーキテクチャ v2 を部分的に用いている場合、プラグインにより返されるパスで構成される mountpoints は、プラグイン設定内の ``PropagatedMount`` によって指定されるディレクトリ配下にマウントされるべき。
  (`#26398 <https://github.com/docker/docker/pull/26398>`_)

.. ### 1.12.0

1.12.0
-------

.. - Add `Status` field to `VolumeDriver.Get` response
     ([#21006](https://github.com/docker/docker/pull/21006#))
   - Add `VolumeDriver.Capabilities` to get capabilities of the volume driver
     ([#22077](https://github.com/docker/docker/pull/22077))

* ``VolumeDriver.Get`` レスポンスに ``Status`` フィールドを追加。
  (`#21006 <https://github.com/docker/docker/pull/21006#>`_)
* ``VolumeDriver.Capabilities`` の追加。ボリューム・ドライバのケーパビリティ（capability）を取得する。
  (`#22077 <https://github.com/docker/docker/pull/22077>`_)

.. ### 1.10.0

1.10.0
-------

.. - Add `VolumeDriver.Get` which gets the details about the volume
     ([#16534](https://github.com/docker/docker/pull/16534))
   - Add `VolumeDriver.List` which lists all volumes owned by the driver
     ([#16534](https://github.com/docker/docker/pull/16534))

* ``VolumeDriver.Get`` の追加。 ボリュームの詳細情報を取得する。
  (`#16534 <https://github.com/docker/docker/pull/16534>`_)
* ``VolumeDriver.List`` の追加。 ドライバが所有する全ボリューム一覧を取得する。
  (`#16534 <https://github.com/docker/docker/pull/16534>`_)

.. ### 1.8.0

1.8.0
------

.. - Initial support for volume driver plugins
     ([#14659](https://github.com/docker/docker/pull/14659))

* ボリューム・ドライバ・プラグインに対する初めてのサポート。
  (`#14659 <https://github.com/docker/docker/pull/14659>`_)

.. ## Command-line changes

.. _command-line-changes:

コマンドラインによる変更
=========================

.. To give a container access to a volume, use the `--volume` and `--volume-driver`
   flags on the `docker container run` command.  The `--volume` (or `-v`) flag
   accepts a volume name and path on the host, and the `--volume-driver` flag
   accepts a driver type.

コンテナからボリュームへアクセスするためには、``docker container run`` コマンドの ``--volume`` フラグや ``--volume-driver`` フラグを用います。
``--volume`` （または ``-v`` ）フラグは、ボリューム名とホスト上のパスを指定します。
また ``--volume-driver`` フラグはドライバ・タイプを指定します。

.. ```bash
   $ docker volume create --driver=flocker volumename

   $ docker container run -it --volume volumename:/data busybox sh
   ```

.. code-block:: bash

   $ docker volume create --driver=flocker volumename

   $ docker container run -it --volume volumename:/data busybox sh

.. ### `--volume`

``--volume``
-------------

.. The `--volume` (or `-v`) flag takes a value that is in the format
   `<volume_name>:<mountpoint>`. The two parts of the value are
   separated by a colon (`:`) character.

``--volume`` （または ``-v`` ）フラグは ``<volume_name>:<mountpoint>`` という書式の値をとります。
この値の 2 つの部分はコロン（``:``）によって区切ります。

.. - The volume name is a human-readable name for the volume, and cannot begin with
     a `/` character. It is referred to as `volume_name` in the rest of this topic.
   - The `Mountpoint` is the path on the host (v1) or in the plugin (v2) where the
     volume has been made available.

* ボリューム名は、人間が読み取れる文字を使って、ボリュームにつけた名前のことです。
  ``/`` で始めることはできません。
  これ以降では ``volume_name`` と呼び表わすことにします。
* ``Mountpoint`` は、ホスト上のパス（v1 の場合）、またはプラグイン内のパス（v2 の場合）のいずれかであり、ボリュームが生成されている場所を示します。

.. ### `volumedriver`

``volumedriver``
-----------------

.. Specifying a `volumedriver` in conjunction with a `volumename` allows you to
   use plugins such as [Flocker](https://github.com/ScatterHQ/flocker) to manage
   volumes external to a single host, such as those on EBS.

``volumename`` とともに ``volumedriver`` を指定すると、`Flocker <https://github.com/ScatterHQ/flocker>`_ のようなプラグインが利用できるようになります。
これにより 1 つのホストから、EBS 上などの外部にあるボリュームを管理できるようになります。

.. ## Create a VolumeDriver

VolumeDriver の生成
====================

.. The container creation endpoint (`/containers/create`) accepts a `VolumeDriver`
   field of type `string` allowing to specify the name of the driver. If not
   specified, it defaults to `"local"` (the default driver for local volumes).

コンテナの生成エンドポイント（``/containers/create``）は、``string`` 型の ``VolumeDriver`` を受け付け、ドライバ名を指定することができます。
指定されていない場合は、デフォルトの ``"local"`` になります。
（デフォルトドライバはローカルボリューム向けのものです。）

.. ## Volume plugin protocol

ボリューム・プラグイン・プロトコル
========================================

.. If a plugin registers itself as a `VolumeDriver` when activated, it must
   provide the Docker Daemon with writeable paths on the host filesystem. The Docker
   daemon provides these paths to containers to consume. The Docker daemon makes
   the volumes available by bind-mounting the provided paths into the containers.

プラグインが有効化される際に ``VolumeDriver`` として自分自身を登録するのであれば、このプラグインは Docker デーモンに対して、ホストファイルシステム上の書き込み可能なパスを提供しなければなりません。
Docker デーモンはそのパスをコンテナに提供して利用させます。
Docker デーモンはボリュームを利用できるようにするために、そのパスをバインドマウントしてコンテナに提供しています。

.. > **Note**: Volume plugins should *not* write data to the `/var/lib/docker/`
   > directory, including `/var/lib/docker/volumes`. The `/var/lib/docker/`
   > directory is reserved for Docker.

.. note::

   ボリューム・プラグインは、``/var/lib/docker/`` ディレクトリや ``/var/lib/docker/volumes`` にデータ書き込みを行っては **いけません** 。
   ``/var/lib/docker/`` ディレクトリは Docker により予約されています。

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


VolumeDriver.Unmount
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
