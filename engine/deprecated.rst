.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/deprecated/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/deprecated.md
.. doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/deprecated.md
.. check date: 2016/06/13
.. Commits on Jun 7, 2016 148d2b8e4a7e4f669ba9e8db2adc2413fde27a07
.. Commits on Mar 31, 2016 0f70f53826ac311ca1653827c0d6bc170f300e84
.. -----------------------------------------------------------------------------

.. Deprecated Features

.. _deprecated-features:

=======================================
廃止機能
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. The following list of features are deprecated.

以下は廃止された機能の一覧です。

.. Three argument from in docker import

.. _three-argument-from-in-docker-import:

``docker import`` の３つの引数
========================================

.. Deprecated In Release: v0.6.7

**廃止リリース：** `v0.6.7 <https://github.com/docker/docker/releases/tag/v0.6.7>`_

.. Removed In Release: v1.12.0

**削除リリース：** `v1.12.0`_

.. The `docker import` command format 'file|URL|- [REPOSITORY [TAG]]' is deprecated since November 2013. It's no more supported.

`docker import` コマンドのフォーマット 'file|URL|- [REPOSITORY [TAG]]' は 2013 年 11 月に廃止されました。以降のサポートはありません。

.. -e and --email flags on docker login

.. _dep-email-flag:

``docker login`` の ``-e`` および ``--email`` フラグ
============================================================

.. Deprecated In Release: v1.11

**廃止リリース：** `v1.11 <https://github.com/docker/docker/releases/tag/v1.11.0>`_

.. Target For Removal In Release: v1.13

**削除目標リリース：v1.13**

.. The docker login command is removing the ability to automatically register for an account with the target registry if the given username doesn't exist. Due to this change, the email flag is no longer required, and will be deprecated.

docker login コマンドから、ユーザ名が指定されなかった場合に、対象レジストリのアカウントに自動で関連づける機能が削除されます。この変更に伴い email フラグは必要ではなくなり、将来的に廃止します。

.. Separator (:) of --security-opt flag on docker run

.. _separator-of-security-opt-flag:

``docker run`` の ``--security-opt`` フラグのセパレータ ( ``:`` )
======================================================================

.. Deprecated In Release: v1.11

**廃止リリース：** `v1.11`_

.. Target For Removal In Release: v1.13

**削除目標リリース：v1.13**

.. The flag --security-opt doesn't use the colon separator(:) anymore to divide keys and values, it uses the equal symbol(=) for consistency with other similar flags, like --storage-opt.

``--security-opt`` フラグでキーと値の分割にコロン・セパレータ（ ``:`` ）を使えなくなります。これは ``--storage-opt``  のような他のフラグと同様、イコール記号（ ``=`` ）で指定することになります。

.. /containers/(id or name)/copy endpoint

.. _containers-id-or-name-copy-endpoint:

``/containers/(id または名前)/copy`` エンドポイント
============================================================

.. Deprecated In Release: v1.8

**廃止リリース：** v1.8

.. Target For Removal In Release: v1.12.0

**削除目標リリース：** `v1.12.0`_

.. The endpoint `/containers/(id or name)/copy` is deprecated in favor of `/containers/(id or name)/archive`.

``/containers/(id または名前)/copy`` エンドポイントは ``/containers/(id または名前/archive)`` に変更のため、廃止しました。


.. Ambiguous event fields in API

.. _ambiguous-event-fields-in-api:

イベント API における不明確なフィールド
========================================

.. Deprecated In Release: v1.10.0

**廃止リリース：** `v1.10.0`_

.. The fields ID, Status and From in the events API have been deprecated in favor of a more rich structure. See the events API documentation for the new format.

イベント API をより優れた構造にするため、 ``ID`` 、 ``Status`` 、 ``From`` フィールドを廃止しました。新しいフォーマットに関してはイベント API のドキュメントをご覧ください。


.. -f lag on docker tag

.. _f-flag-on-docker-tag:

``docker tag`` の ``-f`` フラグ
========================================

.. Deprecated In Release: v1.10.0

**廃止リリース：** `v1.10.0 <https://github.com/docker/docker/releases/tag/v1.10.0>`_

.. Removed In Release: v1.12.0

**削除リリース：** `v1.12.0 <https://github.com/docker/docker/releases/tag/v1.12.0>`_

.. To make tagging consistent across the various docker commands, the -f flag on the docker tag command is deprecated. It is not longer necessary to specify -f to move a tag from one image to another. Nor will docker generate an error if the -f flag is missing and the specified tag is already in use.

様々な ``docker`` コマンド間でタグの付け方を統一するため、 ``docker tag`` コマンドの ``-f`` フラグを廃止しました。イメージのタグを別のものに変える時、 ``-f`` オプションの指定は不要です。また、対象のタグが既に利用中であれば、 ``docker`` コマンドに ``-f`` フラグが無くてもエラーになりません。

.. HostConfig at API container start

.. _hostconfig-at-api-container-start:

API による HostConfig を使ったコンテナ開始
==================================================

.. Deprecated In Release: v1.10

**廃止リリース：** `v1.10.0`_

.. Target For Removal In Release: v1.12

**削除目標リリース：** `v1.12 <https://github.com/docker/docker/releases/tag/v1.12.0>`_

.. Passing an HostConfig to POST /containers/{name}/start is deprecated in favor of defining it at container creation (POST /containers/create).

``POST /containers/{name}/start`` における ``HostConfig`` の指定は、コンテナ作成時の定義 （ ``POST /containers/create`` ）に置き換えられました。

.. Docker ps ‘before’ and ‘since’ options

.. _docker-ps-before-and-since-options:

Docker ps の「before」「since」オプション
==================================================

.. Deprecated In Release: v1.10.0

**廃止リリース：**  `v1.10.0`_

.. Removed In Release: v1.12

**削除リリース：** `v1.12`_

.. The docker ps --before and docker ps --since options are deprecated. Use docker ps --filter=before=... and docker ps --filter=since=... instead.

``docker ps --before`` と ``docker ps --since`` オプションを廃止しました。代わりに ``docker ps --filter=before=...`` と ``docker ps --filter=since=...`` をお使いください。

.. Docker search automated and starts options

.. _docker-search-automated-and-starts-options:

docker search ``automated`` および ``stars`` オプション
============================================================

.. Deprecated In Release: v1.12.0

**廃止リリース：** `v1.12.0`_

.. Target for Removal In Release: v1.14

**削除目標リリース：v1.14**

.. The `docker search --automated` and `docker search --stars` options are deprecated.
.. Use `docker search --filter=is-automated=...` and `docker search --filter=stars=...` instead.

``docker search --automated`` および ``docker search --starts`` オプションは廃止されました。その代わり、 ``docker search --filter=is-automated=...`` と ``docker search --filter=stars=...`` をご利用ください。

.. Command line short variant options

.. _command-line-short-variant-options:

コマンドラインの短縮オプション
==============================

.. 訳者注： Docs v1.12 で削除。改めて削除予定
.. https://github.com/docker/docker/commit/fea7acf0e9f0532af7451a3c3835a0cfabf4fb20

.. Deprecated In Release: v1.9

**廃止リリース：** `v1.9 <https://github.com/docker/docker/releases/tag/v1.9.0>`_

.. Target For Removal In Release: v1.11

**削除目標リリース：** `v1.11`_

.. The following short variant options are deprecated in favor of their long variants:

以下の短縮オプションを廃止するため、長いオプションを使うべきです。

.. code-block:: bash

   docker run -c (--cpu-shares)
   docker build -c (--cpu-shares)
   docker create -c (--cpu-shares)

.. Driver Specific Log Tags

.. _driver-specific-log-tags:

ログ用のドライバを指定するタグ
==============================

.. Deprecated In Release: v1.9

**廃止リリース：** `v1.9`_

.. Removed In Release: v1.12

**削除リリース：** `v1.12`_

.. Log tags are now generated in a standard way across different logging drivers. Because of which, the driver specific log tag options syslog-tag, gelf-tag and fluentd-tag have been deprecated in favor of the generic tag option.

異なったログ保存用（ロギング）ドライバを横断して使えるよう、標準化するためにログのタグ機能が生まれました。ドライバを指定するタグのオプションは標準的な ``tag`` オプションが望ましくなるため、 ``syslog-tag`` 、 ``gelf-tag`` 、``fluentd-tag`` は廃止されました。

.. code-block:: bash

   docker --log-driver=syslog --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}"


.. LXC built-in exec driver

.. _lxc-built-in-exec-driver:

内部 LXC 実行ドライバ
==============================

.. Deprecated In Release: v1.8

**廃止リリース：** `v1.8 <https://github.com/docker/docker/releases/tag/v1.8.0>`_

.. Removed In Release: v1.10

**削除リリース：** `v1.10.0`_

.. The built-in LXC execution driver, the lxc-conf flag, and API fields have been removed.

外部実装の内部（built-in）LXC 実行ドライバ、lxc-conf フラグ、 API を削除しました。

.. Old Command Line Options

.. _old-command-line-options:

古いコマンドライン・オプション
==============================

.. Deprecated In Release: v1.8.0

**廃止リリース：** `v1.8.0 <https://github.com/docker/docker/releases/tag/v1.8.0>`_

.. Removed In Release: v1.10

**削除リリース：** `v1.10.0`_

.. The flags -d and --daemon are deprecated in favor of the daemon subcommand:

``-d`` フラグと ``--daemon`` は ``daemon`` サブコマンドに移行するため、廃止されます。

.. code-block:: bash

   docker daemon -H ...

.. The following single-dash (-opt) variant of certain command line options are deprecated and replaced with double-dash options (--opt):

コマンドライン・オプションのうち、以下のシングル・ダッシュ（ ``-opt``  ）派生を廃止し、新しいダブル・ダッシュ（ ``--opt`` ）に変わります。

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

以下のダブル・ダッシュのオプションは、置き換えずに廃止です。

.. code-block:: bash

   docker run --networking
   docker ps --since-id
   docker ps --before-id
   docker search --trusted


.. Interacting with V1 registries

.. _interacting-with-v1-registries:

V1 レジストリとの通信
==============================

.. Version 1.9 adds a flag (--disable-legacy-registry=false) which prevents the docker daemon from pull, push, and login operations against v1 registries. Though disabled by default, this signals the intent to deprecate the v1 protocol.

バージョン 1.9 にフラグ（ ``--disable-legacy-registry=false`` ）を追加しました。これは docker デーモンが v1 レジストリと ``pull`` 、 ``push`` 、 ``login`` させないようにします。デフォルトは廃止された v1 プロトコルと通信しないよう無効化しています。

.. Docker Content Trust ENV passphrase variables name change

.. _docker-content-trust-env:

Docker Content Trust ENV パスフレーズの変数名を変更
===================================================

.. Deprecated In Release: v1.9

**廃止リリース：** `v1.9`_

.. Removed In Release: v1.12

**削除リリース：** `v1.12`_

.. Since of 1.9, Docker Content Trust Offline key has been renamed to Root key and the Tagging key has been renamed to Repository key. Due to this renaming, we’re also changing the corresponding environment variables

バージョン 1.9 以降、 Docker Content Trust のオフライン鍵（Offline key）はルート鍵（Root key）に、タギング鍵（Tagging key）はリポジトリ鍵（Repository key）に名称変更されました。この名称変更により、関係する環境変数も変わりました。

* DOCKER_CONTENT_TRUST_OFFLINE_PASSPHRASE を DOCKER_CONTENT_TRUST_ROOT_PASSPHRASE に変更しました。
* DOCKER_CONTENT_TRUST_TAGGING_PASSPHRASE を DOCKER_CONTENT_TRUST_REPOSITORY_PASSPHRASE に変更しました。

.. seealso:: 
   Deprecated Engine Features
      https://docs.docker.com/engine/deprecated/

