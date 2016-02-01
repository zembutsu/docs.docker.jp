.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/misc/faq/
.. doc version: 1.9
.. check date: 2016/02/01
.. -----------------------------------------------------------------------------

.. Frequently Asked Questions (FAQ)

.. faq:

=======================================
よくある質問と回答(FAQ)
=======================================

.. If you don’t see your question here, feel free to submit new ones to docs@docker.com. Or, you can fork the repo and contribute them yourself by editing the documentation sources.

あなたの質問がここになければ、 docs@docker.com まで遠慮なく送信してください。あるいは、 `レポジトリをフォークし <https://github.com/docker/docker>`_ 、ドキュメントのソースを自分自身で編集し、それらで貢献することもできます。

.. How much does Docker cost?

.. _how-much-does-docker-cost?

Docker を使うには、どれだけの費用がかかりますか？
==================================================

.. Docker is 100% free. It is open source, so you can use it without paying.

Docker は 100% 自由に使えます。オープンソースであり、使うために支払う必要はありません。

.. What open source license are you using?

.. _what-open-source-license-are-you-using:

オープンソースのライセンスに何を使っていますか？
==================================================

.. We are using the Apache License Version 2.0, see it here: https://github.com/docker/docker/blob/master/LICENSE

Apache License Version 2.0 を使っています。こちらをご覧ください：https://github.com/docker/docker/blob/master/LICENSE

.. Does Docker run on Mac OS X or Windows?

.. _does-docker-run-on-mac-os-x-or-windows?

Mac OS X や Windows で Docker は動きますか？
==================================================

.. Docker currently runs only on Linux, but you can use VirtualBox to run Docker in a virtual machine on your box, and get the best of both worlds. Check out the Mac OS X and Microsoft Windows installation guides. The small Linux distribution Docker Machine can be run inside virtual machines on these two operating systems.

現時点の Docker は Linux 上でしか動きません。しかし VirtualBox を使えば、仮想マシン上で Docker を動かして使えるため、どちらの環境でも便利に扱えるでしょう。 :doc:`Mac OS X </engine/installation/mac>` と :doc:`Microsoft Windows </engine/installation/windows>` のインストールガイドをご覧ください。どちらの OS 上にも、仮想マシン内で Docker Machine を実行するための、小さな Linux ディストリビューションをインストールします。

..    Note: if you are using a remote Docker daemon on a VM through Docker Machine, then do not type the sudo before the docker commands shown in the documentation’s examples.

.. note::

   Docker Machine を通して仮想マシン上の Docker デーモンをリモート操作する場合は、ドキュメントの例で ``docker`` コマンドの前にある ``sudo`` を入力 *しない* でください。

(以下TODO)