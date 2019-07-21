.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/breaking_changes/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/breaking_changes.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/breaking_changes.md
.. check date: 2016/06/13
.. Commits on May 20, 2016 3d6f5984f52802fe2f4af0dd2296c9e2e4a1e003
.. -----------------------------------------------------------------------------

.. Breaking changes and incompatibilities

.. _breaking-changes-and-incompatibilities:

=======================================
互換性を維持しない変更、非互換性
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Every Engine release strives to be backward compatible with its predecessors,
   and interface stability is always a priority at Docker.

Docker Engine の各リリースでは、前バージョンとの下位互換性を保つように努めています。
インターフェースを安定させることは Docker において常に最重要なことです。

.. In all cases, feature removal is communicated three releases
   in advance and documented as part of the [deprecated features](deprecated.md)
   page.

どのような場合でも将来的に削除する予定の機能は、前もって 3 リリースの期間は議論を継続し、:doc:`廃止機能 <deprecated>` において文書化しています。

.. ## Engine 1.10

.. _engine-110:

Engine 1.10
====================

.. There were two breaking changes in the 1.10 release that affected
   Registry and Docker Content Trust:

1.10 のリリースにおいては、互換性を維持しない変更が 2 つ存在し、Registry と Docker Content Trust に影響を与えています。

**Registry**

.. Registry 2.3 includes improvements to the image manifest that caused a
   breaking change. Images pushed by Engine 1.10 to a Registry 2.3 cannot be
   pulled by digest by older Engine versions. A `docker pull` that encounters this
   situation returns the following error:

Registry 2.3 においてはイメージマニフェストに対する変更が行われ、これは下位互換性のないものとなりました。
Engine 1.10 によって Registry 2.3 にプッシュされたイメージは、古い Engine バージョンを用いた場合には、ダイジェスト値を用いたプルができません。
``docker pull`` がこの状況において実行されると、以下のようなエラーが返されます。

.. ```none
    Error response from daemon: unsupported schema version 2 for tag TAGNAME
   ```
::

   Error response from daemon: unsupported schema version 2 for tag TAGNAME
   （デーモンからのエラー： タグ TAGNAME に対してスキーマバージョン 2 はサポートされません）

.. Docker Content Trust heavily relies on pull by digest. As a result, images
   pushed from the Engine 1.10 CLI to a 2.3 Registry cannot be pulled by older
   Engine CLIs (< 1.10) with Docker Content Trust enabled.

Docker Content Trust は、ダイジェスト値によるイメージの取得機能に大きく依存しています。
したがって Engine 1.10 CLI から Registry 2.3 にプッシュされたイメージは、Docker Content Trust を有効にしていても、古いバージョンの Engine CLI （1.10 以前）ではプルすることはできません。

.. If you are using an older Registry version (< 2.3), this problem does not occur
   with any version of the Engine CLI; push, pull, with and without content trust
   work as you would expect.

かつての Registry バージョン（2.3 以前）を利用している場合は、Docker Engine CLI がどのバージョンであっても問題ありません。
プッシュやプルでも、また Docker Content Trust を利用するしないに関係なく、思いどおりに動くはずです。

.. Docker Content Trust

Docker Content Trust
--------------------

.. Engine older than the current 1.10 cannot pull images from repositories that have enabled key delegation. Key delegation is a feature which requires a manual action to enable.

現在の Engine 1.10 よりも古いバージョンでは、key delegation（鍵の権限委譲）のためリポジトリからイメージを取得（pull）できません。key delegation 機能は手動で有効化する必要があります。

.. seealso:: 

   Breaking changes and incompatibilities
      https://docs.docker.com/engine/breaking_changes/
