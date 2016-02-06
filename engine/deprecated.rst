.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/misc/deprecated/
.. doc version: 1.9
.. check date: 2015/12/22
.. -----------------------------------------------------------------------------

.. Deprecated Features

=======================================
廃止機能
=======================================

.. The following list of features are deprecated.

以下は廃止された機能の一覧です。

.. Command line short variant options

.. _command-line-short-variant-options:

コマンドラインの短縮オプション
==============================

.. Deprecated In Release: v1.9

**廃止リリース：v1.9**

.. Target For Removal In Release: v1.11

**削除目標リリース：v1.11**

.. The following short variant options are deprecated in favor of their long variants:

以下の短縮オプションは廃止されるので、長いオプションを使うべきです。

.. code-block:: bash

   docker run -c (--cpu-shares)
   docker build -c (--cpu-shares)
   docker create -c (--cpu-shares)

.. Driver Specific Log Tags

.. _driver-specific-log-tags:

ドライバを指定するログ用タグ
==============================

.. Deprecated In Release: v1.9

**廃止リリース：v1.9**

.. Target For Removal In Release: v1.11

**削除目標リリース：v1.11**

.. Log tags are now generated in a standard way across different logging drivers. Because of which, the driver specific log tag options syslog-tag, gelf-tag and fluentd-tag have been deprecated in favor of the generic tag option.

異なったログ保存用ドライバをまたがって利用するため、標準的な手法としてログ用のタグが作成されました。そのため、ドライバを指定するタグのオプションは標準的な ``tag`` オプションが望ましくなるため、 ``syslog-tag`` 、 ``gelf-tag`` 、``fluentd-tag`` は廃止されました。

.. code-block:: bash

   docker --log-driver=syslog --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}"


.. LXC built-in exec driver

.. _lxc-built-in-exec-driver:

内蔵 LXC 実行ドライバ
==============================

.. Deprecated In Release: v1.8

**廃止リリース：v1.8**

.. Target For Removal In Release: v1.10

**削除目標リリース：v1.10**

.. The built-in LXC execution driver is deprecated for an external implementation. The lxc-conf flag and API fields will also be removed.

外部実装である内蔵（built-in）LXC 実行ドライバは廃止されました。lxc-conf フラグと API も削除予定です。

.. Old Command Line Options

.. _old-command-line-options:

古いコマンドライン・オプション
==============================

.. Deprecated In Release: v1.8.0

**廃止リリース：v1.8.0**

.. Target For Removal In Release: v1.10

**削除目標リリース：v1.10**

.. The flags -d and --daemon are deprecated in favor of the daemon subcommand:

``-d`` フラグと ``--daemon`` は ``daemon`` サブコマンドに移行するため、廃止されます。

.. code-block:: bash

   docker daemon -H ...

.. The following single-dash (-opt) variant of certain command line options are deprecated and replaced with double-dash options (--opt):

コマンドライン・オプションのうち、以下のシングル・ダッシュ（ ``-opt``  ）派生は廃止され、新しいダブル・ダッシュ（ ``--opt`` ）に変わります。

.. code-block:: bash

   docker attach -nostdin
   docker attach -sig-proxy
   docker build -no-cache
   docker build -rm
   docker commit -author
   docker commit -run
   docker events -since
   docker history -notrunc
   docker images -notrunc
   docker inspect -format
   docker ps -beforeId
   docker ps -notrunc
   docker ps -sinceId
   docker rm -link
   docker run -cidfile
   docker run -cpuset
   docker run -dns
   docker run -entrypoint
   docker run -expose
   docker run -link
   docker run -lxc-conf
   docker run -n
   docker run -privileged
   docker run -volumes-from
   docker search -notrunc
   docker search -stars
   docker search -t
   docker search -trusted
   docker tag -force

.. The following double-dash options are deprecated and have no replacement:

以下のダブル・ダッシュのオプションは、置き換えられずに廃止されます。

.. code-block:: bash

   docker run --networking
   docker ps --since-id
   docker ps --before-id
   docker search --trusted

.. Auto-creating missing host paths for bind mounts

.. _auto-creating-missing-host-paths-for-bind-mounts:

マウント割り当て用ホスト・パス喪失時の自動作成
==================================================

.. Deprecated in Release: v1.9

**廃止リリース：v1.9**

.. Target for Removal in Release: 1.11

**削除目標リリース：v1.11**

.. When creating a container with a bind-mounted volume– docker run -v /host/path:/container/path – docker was automatically creating the /host/path if it didn’t already exist.

ボリューム ``docker run -v /host/path:/container/path`` でマウントするコンテナを作成時、docker は自動的に ``/host/path`` が存在しなければ作成します。

.. This auto-creation of the host path is deprecated and docker will error out if the path does not exist.

ホスト・パス上のディレクトリ自動作成は廃止されたため、パスが存在しなければエラーを表示します。

.. Interacting with V1 registries

.. _interacting-with-v1-registries:

V1 レジストリとの通信
==============================

.. Version 1.9 adds a flag (--disable-legacy-registry=false) which prevents the docker daemon from pull, push, and login operations against v1 registries. Though disabled by default, this signals the intent to deprecate the v1 protocol.

バージョン 1.9 にフラグ（ ``--disable-legacy-registry=false`` ）が追加されました。これは docker デーモンが v1 レジストリと ``pull`` 、 ``push`` 、 ``login`` させないようにします。デフォルトでは無効化されているため、廃止された v1 プロトコルとは通信しません。

.. Docker Content Trust ENV passphrase variables name change

.. _docker-content-trust-env:

Docker Content Trust ENV パスフレーズの変数名を変更
===================================================

.. Deprecated In Release: v1.9

**廃止リリース：v1.9**

.. Target For Removal In Release: v1.10

**削除目標リリース：v1.10**

.. As of 1.9, Docker Content Trust Offline key will be renamed to Root key and the Tagging key will be renamed to Repository key. Due to this renaming, we’re also changing the corresponding environment variables

バージョン 1.9 における Docker Content Trust のオフライン鍵はルート鍵に、タギング鍵はレポジトリ鍵に名称変更されました。この名称変更により、関係する環境変数も変わります。

* DOCKER_CONTENT_TRUST_OFFLINE_PASSPHRASE は、次のように変更されます： DOCKER_CONTENT_TRUST_ROOT_PASSPHRASE
* DOCKER_CONTENT_TRUST_TAGGING_PASSPHRASE は、次のように変更されます： DOCKER_CONTENT_TRUST_REPOSITORY_PASSPHRASE



