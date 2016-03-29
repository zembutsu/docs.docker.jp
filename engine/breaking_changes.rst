.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/breaking_changes/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/breaking_changes.md
.. doc version: 1.10
.. check date: 2016/02/08
.. -----------------------------------------------------------------------------

.. Breaking changes and incompatibilities

=======================================
破壊的変更と非互換性
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Every Engine release strives to be backward compatible with its predecessors. In all cases, the policy is that feature removal is communicated two releases in advance and documented as part of the deprecated features page.

各 Engine をリリースする度に、前のバージョンとの下位互換性を持つように努めています。全てのケースにおいて、機能を廃止するのは２つ先のバージョンというポリシーを持っており、 :doc:`廃止機能 <deprecated>` のページでドキュメント化しています。

.. Unfortunately, Docker is a fast moving project, and newly introduced features may sometime introduce breaking changes and/or incompatibilities. This page documents these by Engine version.

残念ながら、Docker は非常に動いているプロジェクトであり、新しく導入した機能は変更や互換性を弱めてしまうかもしれません。このページでは各エンジンのバージョンごとに文書化しています。

.. Engine 1.10

Engine 1.10
====================

.. There were two breaking changes in the 1.10 release.

1.10 のリリースにあたり、２つの破壊的変更（breaking change）があります。

.. Registry

Registry
----------

.. Registry 2.3 includes improvements to the image manifest that have caused a breaking change. Images pushed by Engine 1.10 to a Registry 2.3 cannot be pulled by digest by older Engine versions. A docker pull that encounters this situation returns the following error:

Registry 2.3 はイメージのマニフェストという改良を取り込んだため、破壊的変更をもたらしました。Engine 1.10 から Registry 2.3 にイメージを送信しても、古いバージョンの Engine で digest 値を計算したものは取得できません。 ``docker pull`` を実行しても、次のようなエラーが表示されます。

.. code-block:: bash

   Error response from daemon: unsupported schema version 2 for tag TAGNAME

.. Docker Content Trust heavily relies on pull by digest. As a result, images pushed from the Engine 1.10 CLI to a 2.3 Registry cannot be pulled by older Engine CLIs (< 1.10) with Docker Content Trust enabled.

Docker Content Trust は、この digest 値に強く依存しています。そのため、Engine 1.10 のコマンドラインで Registry 2.3 にイメージを送信したとしても、Docker Content Trust を有効化した古い Engine 用の CLI （バージョン 1.10 より小さい）では、イメージを取得（pull）できません。

.. If you are using an older Registry version (< 2.3), this problem does not occur with any version of the Engine CLI; push, pull, with and without content trust work as you would expect.

Registry の古いバージョン（2.3 より小さい）を使っている場合は、どのエンジンの CLI を使って送受信（push、pull）しても問題ありません。ただし、Content Trust を使っていない場合に限ります。

.. Docker Content Trust

Docker Content Trust
====================

.. Engine older than the current 1.10 cannot pull images from repositories that have enabled key delegation. Key delegation is a feature which requires a manual action to enable.

現在の Engine 1.10 よりも古いバージョンでは、key delegation（鍵の権限委譲）のためレポジトリからイメージを取得（pull）できません。key delegation 機能は手動で有効化する必要があります。

.. seealso:: 

   Breaking changes and incompatibilities
      https://docs.docker.com/engine/breaking_changes/
