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

.. Docker Content Trust heavily relies on pull by digest. As a result, images pushed from the Engine 1.10 CLI to a 2.3 Registry cannot be pulled by older Engine CLIs (< 1.10) with Docker Content Trust enabled.

Docker Content Trust は、この digest 値に強く依存しています。そのため、Engine 1.10 のコマンドラインで Registry 2.3 にイメージを送信したとしても、Docker Content Trust を有効化した古い Engine 用の CLI （バージョン 1.10 より小さい）では、イメージを取得（pull）できません。

.. If you are using an older Registry version (< 2.3), this problem does not occur with any version of the Engine CLI; push, pull, with and without content trust work as you would expect.

Registry の古いバージョン（2.3 より小さい）を使っている場合は、どのエンジンの CLI を使って送受信（push、pull）しても問題ありません。ただし、Content Trust を使っていない場合に限ります。

.. Docker Content Trust

Docker Content Trust
--------------------

.. Engine older than the current 1.10 cannot pull images from repositories that have enabled key delegation. Key delegation is a feature which requires a manual action to enable.

現在の Engine 1.10 よりも古いバージョンでは、key delegation（鍵の権限委譲）のためリポジトリからイメージを取得（pull）できません。key delegation 機能は手動で有効化する必要があります。

.. seealso:: 

   Breaking changes and incompatibilities
      https://docs.docker.com/engine/breaking_changes/
