.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/dev-environments/share/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/dev-environments/share.md
.. check date: 2022/09/18
.. Commits on Sep 14, 2022 ce0c26b7b2429fbb2b2ff743267e0bc194f4eec8
.. -----------------------------------------------------------------------------

.. Share your Dev Environment
.. _share-your-dev-environment:

==================================================
Dev Environment の共有
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

..  This feature requires a paid Docker subscription
   Docker Team and Business users can now share Dev Environments with their team members.

.. note::

   **この機能は有償 Docker サブスクリプションが必要です**
   
   Docker Team と Business ユーザは、チームメンバと Dev Environments を共有できます。
   
   `いますぐアップグレード <https://www.docker.com/pricing>`_ 

.. Sharing a Dev Environment lets your team members access the code, any dependencies, and the current Git branch you are working on. They can also review your changes and provide feedback before you create a pull request.

Dev Environment を共有し、チームメンバ間でコード、あらゆる依存関係、作業中の Git ブランチにアクセスできるようにしましょう。また、プルリクエストを作成する前に、変更についてのプレビューやフィードバックの提供もできます。

.. Share your Dev Environment
.. _dev-env-share-your-dev-environment:

Dev Environment の共有
==============================

.. When you are ready to share your environment, hover over your Dev Environment, select the Share icon, and specify the Docker Hub namespace where you’d like to push your Dev Environment to.

Environment の共有準備が整ったら、 Dev Environment の上にマウスカーソルを移動し、 **Share** アイコンをクリックし、自分の Dev Environment を送信したい Docker Hub 名前空間を指定します。

.. This creates an image of your Dev Environment, uploads it to the Docker Hub namespace you have specified, and provides a tiny URL to share with your team members.

これは、自分の Dev Environment のイメージを作成し、アップロードする Docker Hub 名前空間を指定子、チームメンバと共有するための短い URL を得られます。

.. Dev environment shared

.. image:: ../images/dev-share.png
   :width: 60%
   :alt: Dev Environment の共有

.. Open a Dev Environment that has been shared with you
.. _open-a-dev-environment-that-has-been-shared-with-you:

自分が共有した Dev Environment を開く
========================================

.. To open a Dev Environment that was shared with you, select the Create button in the top right-hand corner, select the Existing Dev Environment tab, and then paste the URL.

自分が共有した Dev Environment を開くには、右上の角にある **Create** ボタンをクリックし、 **Existing Dev Environment** タブを選び、そこに URL を貼り付けます。

.. Using this shared Dev Environment, your team members can access the code, any dependencies, and the current Git branch you are working on. They can also review your changes and give feedback even before you create a pull request!

この共有 Dev Environment を使えば、チームメンバ間でコード、あらゆる依存関係、作業中の Git ブランチにアクセスできるようになります。また、プルリクエストを作成する前に、変更についてのプレビューやフィードバックの提供もできます！

.. seealso::

   Share your Dev Environment
      https://docs.docker.com/desktop/dev-environments/share/
