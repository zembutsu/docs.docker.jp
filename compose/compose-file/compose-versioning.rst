.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/compose-file/compose-versioning/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/compose-file/compose-versioning.md
.. check date: 2021/08/08
.. Commits on Mar 15, 2021 ddf8543d282487b2179cdec7692cb3e05530f4e0
.. -------------------------------------------------------------------

.. Compose file versions and upgrading

.. _compose-file-versions-and-upgrading:

==================================================
Compose ファイルのバージョンとアップグレード
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The Compose file is a YAML file defining services, networks, and volumes for a Docker application.

Compose ファイルはとは、Docker アプリケーションの :ruby:`サービス <service>` 、 :ruby:`ネットワーク <network>` 、 :ruby:`ボリューム <volume>` を定義する `YAML <https://yaml.org/>`_ ファイルです。

.. The Compose file formats are now described in these references, specific to each version.

これらのリファレンスは、各バージョンに対応する Compose ファイル形式を説明します。

.. list-table::
   :header-rows: 1
   
   * - リファレンス・ファイル
     - 対象バージョンの変更点
   * - `Compose 仕様 <https://docs.docker.com/compose/compose-file/>`_ （最新かつ推奨）
     - `バージョン情報 <https://docs.docker.com/compose/compose-file/compose-versioning/#versioning>`_
   * - :doc:`バージョン 3  <compose-file-v3>`
     - :ref:`バージョン 3 更新情報 <compose-file-version-3>`
   * - :doc:`バージョン 2  <compose-file-v2>`
     - :ref:`バージョン 2 更新情報 <compose-file-version-2>`
   * - バージョン 1 （非推奨）
     - :ref:`バージョン 1 更新情報 <compose-file-version-1>`

.. The topics below explain the differences among the versions, Docker Engine compatibility, and how to upgrade.

以下のトピックで説明するのは、バージョン間の違い、Docker Engine 互換性、 :ref:`アップグレードの仕方 <compose-file-upgrading>` です。

.. Compatibility matrix

.. _compose-file-compatibility-matrix:

互換表
==========

.. There are several versions of the Compose file format – 1, 2, 2.x, and 3.x

Compose ファイル形式には、1 、 2 、 2.x 、 3.x のように複数のバージョンがあります。

.. This table shows which Compose file versions support specific Docker releases.

この表は、各 Compose ファイル形式を、どの Docker リリースでサポートしているかを表します。


.. list-table::
   :header-rows: 1

   * - Compose ファイル形式
     - Docker Engine リリース
   * - Compose 仕様
     - 19.03.0+
   * - 3.8
     - 19.03.0+
   * - 3.7
     - 18.06.0+
   * - 3.6
     - 18.02.0+
   * - 3.5
     - 17.12.0+
   * - 3.4
     - 17.09.0+
   * - 3.3
     - 17.06.0+
   * - 3.2
     - 17.04.0+
   * - 3.1
     - 1.13.1+
   * - 3.0
     - 1.13.0+
   * - 2.4
     - 17.12.0+
   * - 2.3
     - 17.06.0+
   * - 2.2
     - 1.13.0+
   * - 2.1
     - 1.12.0+
   * - 2.0
     - 1.10.0+

.. In addition to Compose file format versions shown in the table, the Compose itself is on a release schedule, as shown in Compose releases, but file format versions do not necessarily increment with each release. For example, Compose file format 3.0 was first introduced in Compose release 1.10.0, and versioned gradually in subsequent releases.

先ほどの表中にある Compose ファイル形式のバージョンに加え、Compose 自身も `Compose リリースのページ <https://github.com/docker/compose/releases/>`_ にリリース情報の一覧があります。しかし、ファイル形式のバージョンは、各リリースごとに増えていません。たとえば、Compose ファイル形式 3.0 が始めて導入されたのは、 `Compose リリース 1.10.0 <https://github.com/docker/compose/releases/tag/1.10.0>`_ からであり、以降はリリースに従って順々とバージョンが割り当てられています。

.. The latest Compose file format is defined by the Compose Specification and is implemented by Docker Compose 1.27.0+.

最新の Compose ファイル形式は `Compose 仕様`_ で定義されており、 Docker Compose **1.27.0 以上** から実装されています。

..     Looking for more detail on Docker and Compose compatibility?
    We recommend keeping up-to-date with newer releases as much as possible. However, if you are using an older version of Docker and want to determine which Compose release is compatible, refer to the Compose release notes. Each set of release notes gives details on which versions of Docker Engine are supported, along with compatible Compose file format versions. (See also, the discussion in issue #3404.)

.. note:: **Docker と Compose の互換性について、詳細を探していますか？**

   可能な限り、最新版に更新し続けるのを推奨します。しかしながら、Docker の古いバージョンを使っている場合や、Compose リリースに互換性があるかどうか判断する場合は、 :doc:`Compose リリースノート </compose/releases>` を参照ください。リリースノートごとに、サポートしている Docker Engine のバージョン加え、互換性のある Compose ファイル形式のバージョンの詳細があります。（ `issue #3404 <https://github.com/docker/docker.github.io/issues/3404>`_ の議論もご覧ください。）

.. For details on versions and how to upgrade, see Versioning and Upgrading.

バージョンについての詳細やアップグレードの仕方については、 :ref:`<compose-file-versioning>` と :ref:`<compose-file-upgrading>` をご覧ください。

.. Versioning

.. _compose-file-versioning:

バージョン仕様
====================

.. There are three legacy versions of the Compose file format:

Compose ファイル形式には、過去3つのバージョンがあります。

..  Version 1. This is specified by omitting a version key at the root of the YAML.
    Version 2.x. This is specified with a version: '2' or version: '2.1', etc., entry at the root of the YAML.
    Version 3.x, designed to be cross-compatible between Compose and the Docker Engine’s swarm mode. This is specified with a version: '3' or version: '3.1', etc., entry at the root of the YAML.

- バージョン 1。これを指定するには、 YAML のルート（先頭）で ``version`` キーを省略します。
- バージョン 2.x。これを指定するには、 YAML のルートで ``version: '2'`` や ``version: '2.1'`` のように入力します。
- バージョン 3.x は、Compose と Docker Engine の :doc:`swarm モード </engine/swarm/index>` 間で、互換性を持つように設計されました。これを指定するには、 YAML のルートで ``version: '3'`` や ``version: '3.1'`` のように入力します。

.. The latest and recommended version of the Compose file format is defined by the Compose Specification. This format merges the 2.x and 3.x versions and is implemented by Compose 1.27.0+.

最新かつ推奨される Compose ファイル形式は、 `Compose 仕様`_ で定義されたものです。この形式はバージョン 2.x と 3.x を統合したもので、 **Compose 1.27.0 以上** で実装されています。

..     v2 and v3 Declaration
    Note: When specifying the Compose file version to use, make sure to specify both the major and minor numbers. If no minor version is given, 0 is used by default and not the latest minor version.


v2 と v3 の宣言
--------------------

   メモ： Compose ファイルのバージョン指定時は、メジャー番号とマイナー番号の両方を指定してください。マイナーバージョンの指定が無ければ、最新のマイナーバージョンではなく、デフォルトの ``0`` が使われます。

:ref:`compose-file-compatibility-matrix` から、どの Compose ファイル形式が Docker Engine のリリースに対応しているか分かります。

.. To move your project to a later version, see the Upgrading section.

プロジェクトを最新版に移行するには、 :ref:`compose-file-upgrading` をご覧ください。

.. Note: If you’re using multiple Compose files or extending services, each file must be of the same version - you cannot, for example, mix version 1 and 2 in a single project.

.. note::

   メモ： :ref:`複数の Compose ファイル <multiple-compose-files>` や :ref:`サービス拡張 <extending-services> を使う場合は、各ファイルのバージョンを同じにする必要があります。たとえば、1つのプロジェクト内でバージョン 1 と 2 は混在できません。

.. Several things differ depending on which version you use:

どのバージョンを使うかにより、複数の点が異なります。

..  The structure and permitted configuration keys
    The minimum Docker Engine version you must be running
    Compose’s behaviour with regards to networking

* 構造と利用可能な設定キー
* 実行に必要な Docker Engine の最低バージョン
* ネットワーク機能に関する Compose の挙動

.. These differences are explained below.

これらの違いを、以下で説明します。


.. Version 1

.. _compose-file-version-1:

バージョン１（非推奨）
------------------------------

.. Compose files that do not declare a version are considered “version 1”. In those files, all the services are declared at the root of the document.

Compose ファイルでバージョンを宣言しなければ「バージョン１」とみなされます。バージョン１では、ドキュメントの冒頭から全ての :ref:`サービス <service-configuration-reference>` を定義します。

.. Version 1 is supported by Compose up to 1.6.x. It will be deprecated in a future Compose release.

バージョン１は **Compose 1.6.x まで** サポートされました。今後の Compose バージョンでは :ruby:`非推奨 <deprecated>` です。

.. Version 1 files cannot declare named volumes, networks or build arguments.

バージョン1のファイルでは  :ref:`volumes <volume-configuration-reference>` 、 :doc:`networks <networking>` 、 :ref:`build 引数 <compose-file-build>` を使えません。

.. Compose does not take advantage of networking when you use version 1: every container is placed on the default bridge network and is reachable from every other container at its IP address. You need to use links to enable discovery between containers.

バージョン1を使うと、Compose は :doc:`ネットワーク機能 </compose/networking>` を全く活用できません。これは、全てのコンテナがデフォルトの ``bridge`` ネットワークに置かれ、他すべてのコンテナと相互に IP アドレスで到達可能だからです。コンテナ間で接続先を見つけるには、 ``links`` を使う必要があります。

.. Example:

例：

.. code-block:: yaml

   web:
     build: .
     ports:
      - "5000:5000"
     volumes:
      - .:/code
     links:
      - redis
   redis:
     image: redis

.. Version 2

.. _compose-file-version-2:

バージョン 2
--------------------

.. Compose files using the version 2 syntax must indicate the version number at the root of the document. All services must be declared under the services key.

バージョン 2 の Compose ファイルでは、ドキュメントの冒頭でバージョン番号を明示する必要があります。 ``services`` キーの下で :ref:`サービス <service-configuration-reference>` をすべて定義する必要があります。

.. Version 2 files are supported by Compose 1.6.0+ and require a Docker Engine of version 1.10.0+.

バージョン２のファイルは **Compose 1.6.0 以上** でサポートされており、実行には Docker Engine **1.10.0 以上** が必要です。

.. Named volumes can be declared under the volumes key, and networks can be declared under the networks key.

名前付き :ref:`ボリューム <volume-configuration-reference>` の宣言は ``volumes`` キーの下で行えます。また、名前付き :ref:`ネットワーク <network-configuration-reference>` の宣言は ``networks`` キーの下で行えます。

.. By default, every container joins an application-wide default network, and is discoverable at a hostname that’s the same as the service name. This means links are largely unnecessary. For more details, see Networking in Compose.

デフォルトでは、すべてのコンテナがアプリケーション全体のデフォルトネットワークに :ruby:`接続 <join>` します。そして（コンテナの）ホスト名は、各サービス名と同じ名前で発見可能になります。つまり、 :ref:`links <links>` は全くもって不要です。詳細は :doc:`/compose/networking` を参照ください。

.. When specifying the Compose file version to use, make sure to specify both the major and minor numbers. If no minor version is given, 0 is used by default and not the latest minor version. As a result, features added in later versions will not be supported. For example:

.. note::

   Compose ファイルのバージョンを指定する場合は、メジャー番号とマイナー番号の両方を指定する必要があります。マイナーバージョンの指定がなければ、最新のマイナーバージョンではなく、デフォルトの ``0`` が使われます。その結果、新しいバージョンで追加された機能はサポートされません。たとえば
   
   ::
   
      version: "2"
   
   は、以下の指定と同等です。
   
   ::
   
      version: "2.0"


.. Simple example:

簡単な例：

.. code-block:: yaml

   version: "2.4"
   services:
     web:
       build: .
       ports:
        - "5000:5000"
       volumes:
        - .:/code
     redis:
       image: redis

.. A more extended example, defining volumes and networks:

ボリュームとネットワークを定義するよう拡張した例：

.. code-block:: yaml

   version: "2.4"
   services:
     web:
       build: .
       ports:
        - "5000:5000"
       volumes:
        - .:/code
       networks:
         - front-tier
         - back-tier
     redis:
       image: redis
       volumes:
         - redis-data:/var/lib/redis
       networks:
         - back-tier
   volumes:
     redis-data:
       driver: local
   networks:
     front-tier:
       driver: bridge
     back-tier:
       driver: bridge

.. Several other options were added to support networking, such as:
    aliases
    The depends_on option can be used in place of links to indicate dependencies between services and startup order.
    ipv4_address, ipv6_address

以下のような、ネットワーク機能をサポートするオプションが追加されました。

* :ref:`compose-file-aliases`
* :ref:`compose-file-depends_on` オプションは、links に置き換わるもので、サービスと起動順番との間での依存関係を示します。

   ::
   
      version: "2.4"
      services:
        web:
          build: .
          depends_on:
            - db
            - redis
        redis:
          image: redis
        db:
          image: postgres

* :ref:`ipv4_address 、 ipv6_address <ipv4-address-ipv6-address>`

.. Variable substitution also was added in Version 2.

バージョン 2 では、 :ref:`compose-file-variable-substitution` も追加されました。

.. Version 2.1

.. _compose-file-version-21:

バージョン 2.1
--------------------

.. An upgrade of version 2 that introduces new parameters only available with Docker Engine version 1.12.0+. Version 2.1 files are supported by Compose 1.9.0+.

:ref:`バージョン 2 <compose-file-version-2>` の更新版で、 Docker Engine バージョン **1.12.0 以上** のみで利用可能なパラメータが導入されました。バージョン 2.1 形式のファイルは、 **Compose 1.9.0 以上** でサポートされています。

.. Introduces the following additional parameters:
    link_local_ips
    isolation in build configurations and service definitions
    labels for volumes, networks, and build
    name for volumes
    userns_mode
    healthcheck
    sysctls
    pids_limit
    oom_kill_disable
    cpu_period

以下のパラメータが追加導入されました。

* :ref:`link_local_ips <compose-file-link_local_ips>`
* 構築時の設定と、サービス定義での :ref:`分離（isolation） <compose-file-isolation>`
* :ref:`volumes <volume-configuration-reference>` 、 :ref:`networks <network-configuration-reference>` 、 :ref:`build <compose-file-v3-build>` 用の ``lables`` 
* :ref:`volumes <volume-configuration-reference>` 用の ``name`` 
* :ref:`userns_mode <compose-file-userns_mode>`
* :ref:`healthcheck <compose-file-healthcheck>`
* :ref:`sysctls <compose-file-sysctls>`
* :ref:`pids_limit <compose-file-pids_limit>`
* :ref:`oom_kill_disable <compose-file-oom_kill_disable>`
* :ref:`cpu_period <compose-file-cpu_period>`


.. Version 2.2

.. _compose-file-version-22:

バージョン 2.2
--------------------

.. An upgrade of version 2.1 that introduces new parameters only available with Docker Engine version 1.13.0+. Version 2.2 files are supported by Compose 1.13.0+. This version also allows you to specify default scale numbers inside the service’s configuration.

:ref:`バージョン 2.1 <compose-file-version-21>` の更新版で、 Docker Engine バージョン **1.13.0 以上** のみで利用可能なパラメータが導入されました。バージョン 2.2 形式のファイルは、 **Compose 1.13.0 以上** でサポートされています。また、このバージョンでは、サービスの定義内で :ruby:`デフォルトのスケール数 <default scale numbers>` を指定可能になりました。

以下のパラメータが追加導入されました。

* :ref:`init <compose-file-init>`
* :ref:`scale <compose-file-scale>`
* :ref:`cpu_rt_runtime <compose-file-cpu_rt_runtime>` と :ref:`cpu_rt_period <compose-file-cpu_rt_period>`
* :ref:`build 設定 <compose-file-build>` 用の ``network``

.. Version 2.3

.. _compose-file-version-23:

バージョン 2.3
--------------------

.. An upgrade of version 2.2 that introduces new parameters only available with Docker Engine version 17.06.0+. Version 2.3 files are supported by Compose 1.16.0+.

:ref:`バージョン 2.2 <compose-file-version-22>` の更新版で、 Docker Engine バージョン **17.06.0 以上** のみで利用可能なパラメータが導入されました。バージョン 2.3 形式のファイルは、 **Compose 1.16.0 以上** でサポートされています。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* :ref:`build 設定 <compose-file-build>` 用の ``target`` 、 ``extra_hosts`` 、 ``shm_size`` 
* :ref:`healthchecks <compose-file-healthchecks>` 用の ``start_period`` 
* :ref:`volumes 用の「長い書式（Long syntax）」 <compose-file-long-syntax>`
* サービス定義用の :ref:`runtime <compose-file-runtime>`
* :ref:`device_cgroup_rules <compose-file-device_cgroup_rules>`

.. Version 2.3

.. _compose-file-version-24:

バージョン 2.4
--------------------

.. An upgrade of version 2.3 that introduces new parameters only available with Docker Engine version 17.12.0+. Version 2.4 files are supported by Compose 1.21.0+.

:ref:`バージョン 2.3 <compose-file-version-23>` の更新版で、 Docker Engine バージョン **17.12.0 以上** のみで利用可能なパラメータが導入されました。バージョン 2.4 形式のファイルは、 **Compose 1.21.0 以上** でサポートされています。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* サービス定義用の :ref:`platform <compose-file-platform>`
* サービスのルート、ネットワーク、ボリューム定義での、 :ruby:`拡張フィールド <extension field>` をサポート

.. Version 3

.. _compose-file-version-3:

バージョン 3
--------------------

.. Designed to be cross-compatible between Compose and the Docker Engine’s swarm mode, version 3 removes several options and adds several more.

Compose と Docker Engine の :doc:`swarm モード </engine/swarm/index>` 間で、互換性を持つように設計されました。バージョン 3 では複数のオプションが削除され、さらに複数のオプションが追加されました。

* 削除： ``volume_driver`` 、 ``volumes_from`` 、 ``cpu_shares`` 、 ``cpu_quota`` 、 ``cpuset`` 、 ``mem_limit`` 、 ``memswap_limit`` 、 ``extends`` 、 ``group_add`` 。これらを移行するには :ref:`compose-file-upgrading` のガイドをご覧ください（ ``extends`` に関する詳しい情報は、 :ref:`extending-services` をご覧ください）。
* 追加： :ref:`deploy <compose-file-v3-deploy>`

.. When specifying the Compose file version to use, make sure to specify both the major and minor numbers. If no minor version is given, 0 is used by default and not the latest minor version. As a result, features added in later versions will not be supported. For example:

.. note::

   Compose ファイルのバージョンを指定する場合は、メジャー番号とマイナー番号の両方を指定する必要があります。マイナーバージョンの指定がなければ、最新のマイナーバージョンではなく、デフォルトの ``0`` が使われます。その結果、新しいバージョンで追加された機能はサポートされません。たとえば
   
   ::
   
      version: "3"
   
   は、以下の指定と同等です。
   
   ::
   
      version: "3.0"

.. Version 3.1

.. _compose-file-version-31:

バージョン 3.1
--------------------

.. An upgrade of version 3 that introduces new parameters only available with Docker Engine version 1.13.1+, and higher.

:ref:`バージョン 3 <compose-file-version-3>` の更新版で、 Docker Engine バージョン **17.04.0 以上** のみで利用可能なパラメータが導入されました。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* :ref:`secret <compose-file-v3-secret>`

.. Version 3.2

.. _compose-file-version-32:

バージョン 3.2
--------------------

.. An upgrade of version 3 that introduces new parameters only available with Docker Engine version 17.04.0+, and higher.

:ref:`バージョン 3 <compose-file-version-3>` の更新版で、 Docker Engine バージョン **17.04.0 以上** のみで利用可能なパラメータが導入されました。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* :ref:`構築時の設定 <compose-file-v3-build>` で、 :ref:`cache_from <compose-file-v3-cache_from>`
* :ref:`ports <compose-file-v3-ports>` と :ref:`volume マウント <compose-file-v3-volumes>` の :ruby:`長い構文<long syntax>`
* ネットワーク・ドライバのオプション * :ref:`attachable <compose-file-v3-attachable>`
* :ref:`endpoint_mode <compose-file-v3-endpoint_mode>` のデプロイ
* :ruby:`デプロイ時の配置設定 <deploy placement>` :ref:`preference <compose-file-v3-placement>`

.. Version 3.3

.. _compose-file-version-33:

バージョン 3.3
--------------------

.. An upgrade of version 3 that introduces new parameters only available with Docker Engine version 17.06.0+, and higher.

:ref:`バージョン 3 <compose-file-version-3>` の更新版で、 Docker Engine バージョン **17.06.0 以上** のみで利用可能なパラメータが導入されました。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* 構築時の  :ref:`labels <compose-file-v3-build>`
* :ref:`credential_spec <compose-file-v3-credential_spec>`
* :ref:`configs <compose-file-v3-configs>`

.. Version 3.4

.. _compose-file-version-34:

バージョン 3.4
--------------------

.. An upgrade of version 3 that introduces new parameters. It is only available with Docker Engine version 17.09.0 and higher.

:ref:`バージョン 3 <compose-file-version-3>` の更新版で、 Docker Engine バージョン **17.09.0 以上** のみで利用可能なパラメータが導入されました。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* :ruby:`構築用設定 <build configurations>` の  :ref:`target <compose-file-v3-target>` と :ref:`network <compose-file-v3-network>`
* :ref:`healthcheck <compose-file-v3-helthcheck>` 用の :ref:`start_period <compose-file-v3-start_period>`
* :ref:`設定更新時 <compose-file-v3-update_config>` の順番（ ``order`` ）
* :ref:`volumes </compose-file-v3-volume-configuration-reference>` の ``name`` 

.. Version 3.5

.. _compose-file-version-35:

バージョン 3.5
--------------------

.. An upgrade of version 3 that introduces new parameters. It is only available with Docker Engine version 17.12.0 and higher.

:ref:`バージョン 3 <compose-file-version-3>` の更新版で、 Docker Engine バージョン **17.12.0 以上** のみで利用可能なパラメータが導入されました。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* サービス定義での :ref:`分離（isolation） <compose-file-v3-isolation>` 
* networks、secrets、configs での ``name`` 
* :ref:`構築用設定 <compose-file-v3-build>` での ``shm_size`` 


.. Version 3.6

.. _compose-file-version-36:

バージョン 3.6
--------------------

.. An upgrade of version 3 that introduces new parameters. It is only available with Docker Engine version 18.02.0 and higher.

:ref:`バージョン 3 <compose-file-version-3>` の更新版で、 Docker Engine バージョン **18.02.0 以上** のみで利用可能なパラメータが導入されました。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* ``tmpfs`` タイプをマウントする :ref:`tmpfs サイズ <compose-file-v3-long-syntax-3>`


.. Version 3.7

.. _compose-file-version-37:

バージョン 3.7
--------------------

.. An upgrade of version 3 that introduces new parameters. It is only available with Docker Engine version 18.06.0 and higher.

:ref:`バージョン 3 <compose-file-version-3>` の更新版で、 Docker Engine バージョン **18.06.0 以上** のみで利用可能なパラメータが導入されました。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* サービス定義での :ref:`init <compose-file-v3-init>` 
* デプロイ設定での :ref:`rollback_config <compose-file-v3-rollback_config>` 
* サービスのルート、ネットワーク、ボリューム、シークレット、設定定義での拡張フィールドをサポート

.. Version 3.8

.. _compose-file-version-38:

バージョン 3.8
--------------------

.. An upgrade of version 3 that introduces new parameters. It is only available with Docker Engine version 19.03.0 and higher.

:ref:`バージョン 3 <compose-file-version-3>` の更新版で、 Docker Engine バージョン **19.03.0 以上** のみで利用可能なパラメータが導入されました。

.. Introduces the following additional parameters:

以下のパラメータが追加導入されました。

* placement 設定での :ref:`max_replicas_per_node <compose-file-v3-max_replicas_per_node>` 
* :ref:`config <compose-file-v3-configs-configuration-reference>` と :ref:`secret <compose-file-v3-secrets-configuration-reference>` 向けの ``template_driver`` オプション。このオプションをサポートしているのは、 ``docker stack deploy`` を使って swarm サービスをデプロイした時のみ。
*  :ref:`secret <compose-file-v3-secrets-configuration-reference>` 向けの ``driver`` オプションと ``driver_opts`` オプション。このオプションをサポートしているのは、 ``docker stack deploy`` を使って swarm サービスをデプロイした時のみ。

.. Upgrading

.. _compose-file-upgrading:

アップグレード方法
====================

.. Version 2.x to 3.x

.. _version-2x-to-3x:

バージョン 2.x から 3.x
------------------------------

.. Between versions 2.x and 3.x, the structure of the Compose file is the same, but several options have been removed:

バージョン 2.x と 3.x 間では、 Compose ファイルの構造は同じですが、いくつかのオプションが削除されています。

* ``volume_driver`` : サービス上で :ruby:`ボリュームドライバ <volume driver>` を設定するのではなく、 :ref:`トップレベルの volumes オプション <compose-file-v3-volume-configuration-reference>` を使ってボリュームを定義し、ドライバもそこで指定します。

   :::
   
      version: "3.9"
      services:
        db:
          image: postgres
          volumes:
            - data:/var/lib/postgresql/data
      volumes:
        data:
          driver: mydriver

* ``volumes_from`` : サービス間で :ruby:`ボリューム <volume>` を共有するには、 :ref:`トップレベルの volumes オプション <compose-file-v3-volume-configuration-reference>` を使ってボリュームを定義します。それから、サービスごとに :ref:`サービスレベルの volumes オプション <compose-file-v3-driver>` を使い、対象のボリュームを参照します。
* ``cpu_shares`` 、 ``cpu_quota`` 、 ``cpuset`` 、 ``mem_limit`` 、 ``memswap_limit`` : これらは ``deploy`` 以下の :ref:`resources <compose-file-v3-resources>` キーに置き換えられました。この ``deploy`` 設定が有効なのは、 ``docker stack deploy`` を使った時のみであり、 ``docker-compose`` では無視されます。
* ``extends`` : このオプションは ``version: "3.x"``  向けの Compose ファイルでは削除されました。（詳しい情報は、 :ref:`extending-services` をご覧ください。）
* ``group_add`` : このオプションは ``version: "3.x"``  向けの Compose ファイルでは削除されました。
* ``pids_limit`` : このオプションは ``version: "3.x"``  向けの Compose ファイルでは削除されました。
* ``networks`` での ``link_local_ips`` : このオプションは ``version: "3.x"``  向けの Compose ファイルでは削除されました。


.. Version 1 to 2.x

.. _version-1-to-2x:

バージョン 1 から 2.x
------------------------------



.. In the majority of cases, moving from version 1 to 2 is a very simple process:

ほとんどの場合、バージョン１から２への移行はとても簡単な手順です。

..    Indent the whole file by one level and put a services: key at the top.
    Add a version: '2' line at the top of the file.

1. 最上位のレベルに ``services:`` キーを追加する。
2. ファイルの１行め冒頭に ``version: '2'`` を追加する。

.. It’s more complicated if you’re using particular configuration features:

特定の設定機能を使っている場合は、より複雑です。

..     dockerfile: This now lives under the build key:

* ``dockerfile`` ： ``build`` キー配下に移動します。

.. code-block:: yaml

   build:
     context: .
     dockerfile: Dockerfile-alternate

.. log_driver, log_opt: These now live under the logging key:

* ``log_driver`` 、 ``log_opt`` ：これらは ``logging`` キー以下です。

.. code-block:: yaml

   logging:
     driver: syslog
     options:
       syslog-address: "tcp://192.168.0.42:123"

.. links with environment variables: As documented in the environment variables reference, environment variables created by links have been deprecated for some time. In the new Docker network system, they have been removed. You should either connect directly to the appropriate hostname or set the relevant environment variable yourself, using the link hostname:

* ``links`` と環境変数： ``CONTAINERNAME_PORT`` のような、links によって作成される環境変数機能は、いずれ廃止予定です。新しい Docker ネットワーク・システム上では、これらは削除されています。ホスト名のリンクを使う場合は、適切なホスト名で接続できるように設定するか、あるいは自分自身で代替となる環境変数を指定します。

.. code-block:: yaml

   web:
     links:
       - db
     environment:
       - DB_PORT=tcp://db:5432

.. external_links: Compose uses Docker networks when running version 2 projects, so links behave slightly differently. In particular, two containers must be connected to at least one network in common in order to communicate, even if explicitly linked together.

* ``external_links`` ： バージョン２のプロジェクトを実行する時、 Compose は Docker ネットワーク機能を使います。つまり、これまでのリンク機能と挙動が変わります。典型的なのは、２つのコンテナが通信するためには、少なくとも１つのネットワークを共有する必要があります。これはリンク機能を使う場合でもです。

.. Either connect the external container to your app’s default network, or connect both the external container and your service’s containers to an external network.

外部のコンテナがアプリケーションの :doc:`デフォルト・ネットワーク </compose/networking>` に接続する場合や、自分で作成したサービスが外部のコンテナと接続するには、 :ref:`外部ネットワーク機能 <using-a-pre-existing-network>` を使います。

.. net: This is now replaced by network_mode:

* ``net`` ：これは :ref:`network_mode <compose-file-network_mode>` に置き換えられました。

::

   net: host    ->  network_mode: host
   net: bridge  ->  network_mode: bridge
   net: none    ->  network_mode: none

.. If you’re using net: "container:[service name]", you must now use network_mode: "service:[service name]" instead.

``net: "コンテナ:[サービス名]"`` を使っていた場合は、 ``network_mode: "サービス:[サービス名]"`` に置き換える必要があります。

::

   net: "container:web"  ->  network_mode: "service:web"

.. If you’re using net: "container:[container name/id]", the value does not need to change.


``net: "コンテナ:[コンテナ名/ID]"`` の場合は変更不要です。

::

   net: "container:cont-name"  ->  network_mode: "container:cont-name"
   net: "container:abc12345"   ->  network_mode: "container:abc12345"

net: "container:abc12345"   ->  network_mode: "container:abc12345"

.. volumes with named volumes: these must now be explicitly declared in a top-level volumes section of your Compose file. If a service mounts a named volume called data, you must declare a data volume in your top-level volumes section. The whole file might look like this:

* ``volumes`` を使う名前付きボリューム：Compose ファイル上で、トップレベルの ``volumes`` セクションとして明示する必要があります。 ``data`` という名称のボリュームにサービスがマウントする必要がある場合、トップレベルの ``volumes`` セクションで ``data`` ボリュームを宣言する必要があります。記述は以下のような形式です。

.. code-block:: yaml

   version: '2.4'
   services:
     db:
       image: postgres
       volumes:
         - data:/var/lib/postgresql/data
   volumes:
     data: {}

.. By default, Compose creates a volume whose name is prefixed with your project name. If you want it to just be called data, declared it as external:

デフォルトでは、 Compose はプロジェクト名を冒頭に付けたボリュームを作成します。 ``data`` のように名前を指定するには、以下のように宣言します。

.. code-block:: yaml

   volumes:
     data:
       external: true

.. Compatibility mode

.. _compatibility_mode:

:ruby:`互換モード <compatibility mode>`
========================================

.. docker-compose 1.20.0 introduces a new --compatibility flag designed to help developers transition to version 3 more easily. When enabled, docker-compose reads the deploy section of each service’s definition and attempts to translate it into the equivalent version 2 parameter. Currently, the following deploy keys are translated:

開発者がバージョン 3 に簡単に以降するための手助けとなるのを意図し、 ``docker-compose 1.20.0`` では新しい ``--compatibility`` （互換性）フラグが追加されミズ空いた。これを有効にすると、 ``docker-compose``  は ``deploy`` セクションの各サービス定義を読み込み、バージョン 2 のパラメータと同等に解釈しようとします。現時点では、以下の deploy キーが変換されます。

..  resources limits and memory reservations
    replicas
    restart_policy condition and max_attempts

* :ref:`resources <compose-file-v3-resources>` の :ruby:`制限 <limits>` と :ruby:`メモリ予約 <memory reservations>`
* :ref:`replicas <compose-file-v3-replicas>` 
* :ref:`restart_policy <compose-file-v3-restart_policy>` の ``condition`` と ``max_attempts`` 

.. All other keys are ignored and produce a warning if present. You can review the configuration that will be used to deploy by using the --compatibility flag with the config command.

その他のキーはすべて無視され、指定しても警告が表示されます。 ``config`` コマンドで ``--compatibility`` フラグを使うと、デプロイに使う設定をレビューできます。

..     Do not use this in production!
    We recommend against using --compatibility mode in production. Because the resulting configuration is only an approximate using non-Swarm mode properties, it may produce unexpected results.

.. note:: **本番環境では使わないでください**

   本番環境での ``--compatibility`` モードの使用に反対します。結果的に設定は、非 Swarm モードでの :ruby:`設定値 <property>` に近似しているだけであり、それにより、予期しない結果を生み出す可能性があるからです。

.. Compose file format references

.. _compose-file-format-references:

Compose ファイル形式リファレンス
========================================

..  Compose Specification
    Compose file version 3
    Compose file version 2


* :doc:`Compose 仕様 </compose/compose-file/index>`
* :doc:`Compose ファイル・バージョン 3 </compose/compose-file/compose-file-v3>`
* :doc:`Compose ファイル・バージョン 2 </compose/compose-file/compose-file-v2>`


.. seealso:: 

   Compose file versions and upgrading
      https://docs.docker.com/compose/compose-file/compose-versioning/
