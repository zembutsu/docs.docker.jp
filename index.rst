.. -*- coding: utf-8 -*-
.. Docker-docs-ja documentation master file, created by
   sphinx-quickstart on Sat Nov  7 10:06:34 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.
.. -----------------------------------------------------------------------------
.. URL: https://docs.docker.com/
   doc version: 20.10 (current)
.. check date: 2021/07/03
.. -----------------------------------------------------------------------------

.. Welcome to Docker-docs-ja's documentation!

Docker ドキュメント日本語化プロジェクト
==========================================

* :doc:`about` ... はじめての方へ、このサイトや翻訳について
* :doc:`guide`
* :doc:`pdf-download` （バージョンが古いです）

.. attention::

  * Docker `v20.10 (current)`  向けにドキュメントの改訂作業中です(2022年4月現在)。一部古い場合がありますので、ご注意ください。
  * Docker のドキュメントは常に変わり続けています。最新の情報については `公式ドキュメント <https://docs.docker.com/>`_ をご覧ください。
  * 本プロジェクトは有志による翻訳プロジェクトです。お気づきの点がございましたら、 `issue <https://github.com/zembutsu/docs.docker.jp/issues>`_ や `Pull Request <https://github.com/zembutsu/docs.docker.jp/pulls>`_ でお知らせ願います。

.. Docker Documentation

.. _docker-documentation:

Docker ドキュメント
==========================================

* :doc:`始めましょう </get-started/index>`
   * Docker の基礎とアプリケーションをコンテナ化する利点を学びます。

* :doc:`ダウンロードとインストール <get-docker>`
   * Docker をダウンロードし、マシン上に 簡単な数ステップでインストールします。

* :doc:`ガイド </develop/index>`
   * Docker 環境のセットアップ方法と、アプリケーションをコンテナ化し始める方法を学びます。

* :doc:`最新情報（リリースノート） </release-notes>`
   *  クールな新機能、更新情報、バグ修正に関して学びます。

* :doc:`プロダクト・マニュアル </engine/index>`
   * マニュアルにザッと目を通し、Docker プロダクトの使い方を学びます。

* :doc:`リファレンス </reference/index>`
   * CLI と API リファレンス文章をザッと目を通します。

---

Doc v20.10 目次
====================

.. toctree::
   :caption: Guides - ガイド
   :maxdepth: 1

   Docker概要 <get-started/overview.rst>
   get-docker.rst
   get-started/toc.rst
   language/toc.rst
   develop/toc.rst
   production.rst
   opensoruce/toc.rst
   docsarchive.rst




.. toctree::
   :caption: Product manuals - マニュアル
   :maxdepth: 1

   Docker Engine <engine/toc.rst>
   Docker Compose <compose/toc.rst>
   Docker Desktop <desktop/toc.rst>
   Docker Hub <docker-hub/index.rst>
   Docker Machine <machine/index.rst>
   Docker Toolbox <toolbox/index.rst>
   registry/toc.rst
   swarm/toc.rst

.. toctree::
   :caption: Reference - 参考資料
   :maxdepth: 1

   reference/index.rst
   コマンドライン・リファレンス <engine/reference/index.rst>
   API リファレンス <reference/api.rst>
   Dockerfile リファレンス <engine/reference/builder.rst>
   Compose ファイル リファレンス <reference/compose-file/toc.rst>
   ドライバと仕様 <reference/drivers-and-specifications.rst>
   glossary.rst


.. toctree::
   :caption: Samples - サンプル
   :maxdepth: 1

   sample/index.rst

About
==============================

.. toctree::
   :maxdepth: 3
   :caption: Docker について

   release-notes.rst
   about.rst
   guide.rst
   pdf-download.rst

図版は `GitHub リポジトリ元 <https://github.com/docker/docker.github.io>`_ で Apache License v2 に従って配布されているデータを使っているか、配布されているデータを元に日本語化した素材を使っています。

Docs archive
====================

.. toctree::
   :maxdepth: 1
   :caption: Docs アーカイブ

   v19.03 <http://docs.docker.jp/v19.03/>
   v17.06 <http://docs.docker.jp/v17.06/>
   v1.12 <http://docs.docker.jp/v1.12/>
   v1.11 <http://docs.docker.jp/v1.11/>
   v1.10 <http://docs.docker.jp/v1.10/>
   v1.9 <http://docs.docker.jp/v1.9/>
