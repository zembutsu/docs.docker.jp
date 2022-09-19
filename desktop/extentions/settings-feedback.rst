.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/extensions/settings-feedback/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/extensions/settings-feedback.md
.. check date: 2022/09/19
.. Commits on Sep 8, 2022 8bce7328f1d7f6df2ccd508d2f2970c244ebc10f
.. -----------------------------------------------------------------------------

.. Settings and feedback
.. _extensions-settings-and-feedback:

==================================================
拡張の設定とフィードバック
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _deskto-settings:

設定
==========

.. Enable or disable extensions available in the Marketplace
.. _desktop-enable-or-disable-extensions-available-in-the-marketplace:

マーケットプレイス内で利用可能な拡張の有効化と無効化
------------------------------------------------------------

.. Docker Extensions is switched on by default. To change your settings:

Docker 拡張は、デフォルトで切り替え可能です。設定を変更するには：

..  Navigate to Settings, or Preferences if you’re a Mac user.
    Select the Extensions tab.
    Next to Enable Docker Extensions, select or clear the checkbox to set your desired state.
    In the bottom-right corner, click Apply & Restart.

1. **Settings** に移動するか、 Mac ユーザは **Preferences** に移動します。
2. **Extensions** タブを選びます。
3. **Enable Docker Extensions** の横にあるチェックボックスを、希望する状態に設定を選ぶか、もしくはクリアします。
4. 右下の角にある **Apply & Restart** をクリックします。

.. Enable or disable extensions not available in the Marketplace
.. _desktop-enable-or-disable-extensions-not-available-in-the-marketplace:

マーケットプレイス内で利用できない拡張の有効化と無効化
------------------------------------------------------------

.. You can install extensions through the Marketplace or through the Extensions SDK tools. You can choose to only allow published extensions (extensions that have been reviewed and published in the Extensions Marketplace).

拡張のインストールは、マーケットプレイスを通してか、 Extensions SDK ツールを通してインストールできます。公開された拡張（レビューかつ Extensions マーケットプレイス内で公開された拡張）のみ選べるよう設定できます。

..  Navigate to Settings, or Preferences if you’re a Mac user.
    Select the Extensions tab.
    Next to Allow only extensions distributed through the Docker Marketplace, select or clear the checkbox to set your desired state.
    In the bottom-right corner, click Apply & Restart.

1. **Settings** に移動するか、 Mac ユーザは **Preferences** に移動します。
2. **Extensions** タブを選びます。
3. **Allow only extensions distributed through the Docker Marketplace** の横にあるチェックボックスを、希望する状態に設定を選ぶか、もしくはクリアします。
4. 右下の角にある **Apply & Restart** をクリックします。

.. See containers created by extensions
.. _拡張によって作られたコンテナを表示
------------------------------------------------------------

.. By default, containers created by extensions are hidden from the list of containers in Docker Dashboard and the Docker CLI. To make them visible update your settings:

デフォルトでは、拡張によって作成されたコンテナは Docker ダッシュボードと Docker CLI から隠されます。これらを表示するには、設定を変更します。

..   Navigate to Settings, or Preferences if you’re a Mac user.
    Select the Extensions tab.
    Next to Show Docker Extensions system containers, select or clear the checkbox to set your desired state.
    In the bottom-right corner, click Apply & Restart.

1. **Settings** に移動するか、 Mac ユーザは **Preferences** に移動します。
2. **Extensions** タブを選びます。
3. **Show Docker Extensions system containers** の横にあるチェックボックスを、希望する状態に設定を選ぶか、もしくはクリアします。
4. 右下の角にある **Apply & Restart** をクリックします。


.. Submit feedback
.. _desktop-submit-feedback:

フィードバック送信
====================

.. Feedback can be given to an extension author through a dedicated Slack channel or Github. To submit feedback about a particular extension:

専用の Slack チャンネルや GitHub を通して拡張の作者に対してフィードバックを送れます。特定の拡張に対してフィードバックを送信するには：

..  Navigate to Docker Dashboard and from the menu bar select the ellipsis to the right of Extensions.
    Click Manage Extensions.
    Select the extension you want to provide feedback on.
    Scroll down to the bottom of the extension’s description and, depending on the extension, select:
        Support
        Slack
        Issues. You’ll be sent to a page outside of Docker Desktop to submit your feedback.

1. Docker ダッシュボードを開き、メニューバーから **Extensions** の右横にある記号をクリックします。
2. **Manage Extensions** をクリックします。
3. フィードバックを提供したい拡張を選びます。
4. 拡張の説明をスクロールダウンし、拡張に依存しますが、項目を選びます：

   * サポート
   * Slack
   * 問題（issue）。フィードバックを送信するため、Docker Desktop の外のページに送られます。

.. If an extension does not provide a way for you to give feedback, contact us and we’ll pass on the feedback for you. To provide feedback, select the Give feedback to the right of Extensions Marketplace.

拡張がフィードバックの方法を提供していない場合、私たちに連絡をいただければフィードバック先をお伝えします。フィードバックを提供するには、 **Extensions Marketplace** の右にある **Give feedback** を選んでください。

.. seealso::

   Settings and feedback | Docker Documentation
      https://docs.docker.com/desktop/extensions/settings-feedback/

