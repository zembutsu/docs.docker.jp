.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/compose-file/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/compose-file/index.md
.. check date: 2021/08/08
.. Commits on Jun 4, 2021 fea0d8fea8e591afef3e65be46ac3b039968b00c
.. -------------------------------------------------------------------

.. Compose file

.. _compose-file:

====================
Compose ファイル
====================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Reference and guidelines

.. _compose-file-reference-and-guidelines:

リファレンスとガイドライン
==============================

.. These topics describe the Docker Compose implementation of the Compose format. Docker Compose 1.27.0+ implements the format defined by the Compose Specification. Previous Docker Compose versions have support for several Compose file formats – 2, 2.x, and 3.x. The Compose specification is a unified 2.x and 3.x file format, aggregating properties across these formats.

これらのトピックでは、 Docker Compose が Compose :ruby:`フォーマット <format>` （ファイル形式）をどのように実装しているかを説明します。Docker Compose **1.20.0 以上** では、 `Compose 仕様 <https://github.com/compose-spec/compose-spec/blob/master/spec.md>`_ で定義されたファイル形式を実装しています。以前の Docker Compose のバージョンでは、 2 や 2.x や 3.x といった、複数のファイル形式をサポートしていました。Compose 仕様は 2.x と 3.x のファイル形式を統合し、各フォーマット間の設定情報（プロパティ）を集約しています。

.. Compose and Docker compatibility matrix

.. _compose-and-docker-compatibility-matrix:

Compose と Docker の互換表
==============================

.. There are several versions of the Compose file format – 2, 2.x, and 3.x. The table below provides a snapshot of various versions. For full details on what each version includes and how to upgrade, see About versions and upgrading.

Compose ファイルの形式には、 2 、 2.x 、 3.x といった複数のバージョンがあります。以下の表は、各バージョンの対応表です。各バージョンに含まれているものの詳細や、アップグレードの仕方については、 :doc:`バージョンとアップグレードについて </compose/compose-file/compose-versioning>` をご覧ください。

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

.. Compose documentation

.. _compose-documentation:

Compose ドキュメント
====================

..  User guide
    Installing Compose
    Compose file versions and upgrading
    Sample apps with Compose
    Enabling GPU access with Compose
    Command line reference

* :doc:`ユーザガイド </compose/index>`
* :doc:`Compose のインストール </compose/install>`
* :doc:`Compose ファイルのバージョンとアップグレード <compose-versioning>`
* :doc:`Compose のアプリ例 </compose/samples-for-compose>`
* :doc:`Compose で GPU アクセスの有効化 </compose/gpu-support>`
* :doc:`コマンドライン・リファレンス </compose/reference>`

.. seealso:: 

   Compose file
      https://docs.docker.com/compose/compose-file/
