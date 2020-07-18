.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-hub/slack_integration/
.. SOURCE: -
   doc version: 19.03
.. check date: 2019/04/22
.. -------------------------------------------------------------------

.. title: Set up Docker Hub notifications in Slack

.. _set-up-docker-hub-notifications-in-slack:

========================================
Slack における Docker Hub 通知の設定
========================================

.. Docker Hub can integrate with your **Slack** team to provide notifications about builds.

Docker Hub は **Slack** チームと連携して、イメージ・ビルドの通知を行うことができます。

.. ## Set up a Slack integration

.. _set-up-a-slack-integration:

Slack 連携のための設定
==============================

.. Before you begin, make sure that you are signed into the Slack team that you want to show notifications in.

始めるにあたっては、まず通知連携したい Slack チームにサインインしてください。

.. 1. Log in to the Docker account that owns the builds that you want to receive notifications about.

1. Docker アカウントにログインします。
   これは、ビルド通知の対象としたいビルド・イメージを所有するアカウントです。

   ..  > **Note**: If you are setting up notifications for an organization, log in as a member of the organization's `Owners` team, then switch to the organization account to change the settings.

   .. note::

      通知設定を組織に対して行うのであれば、その組織の ``Owners`` チームに所属するメンバとしてログインし、その後に組織アカウントに切り替えて設定を行ってください。

.. 2. Click **Account Settings** in the left hand navigation, and scroll down to the **Notifications** section.

2. ナビゲーション・バーの左側にある **Account Settings** をクリックして、下へスクロールして **Notifications** セクションを表示します。

.. 3. Click the plug icon next to **Slack**.

3. **Slack** の横にあるプラグ・アイコンをクリックします。

   ..  The Docker Hub page refreshes to show a Slack authorization screen.

   Docker Hub の画面がリフレッシュされて、Slack の認証画面が表示されます。

.. 4. On the page that appears, double check that you're signed in to the correct Slack team. (If necessary sign in to the correct one.)
   5. Select the channel that should receive notifications.
   6. Click **Authorize**.

4. 表示された認証画面上において、適切な Slack チームにサインインしていることを再度確認します。
   （必要に応じて正しいアカウントにサインインします。）
5. 通知を受信したいチャネルを選択します。
6. **Authorize** をクリックします。

   ..  Once you click **Authorize**, you should see a message in the Slack channel notifying you of the new integration.

   **Authorize** をクリックしたら、Slack チャネルのメッセージとして、新たな通知設定が行われたことが示されます。

.. Once configured, choose a notification level:

設定ができたら、通知レベルを選びます。

.. * **Off** Do not receive any notifications.
   * **Only failures** Only receive notifications about failed builds.
   * **Everything** Receive notifications for both failed and successful builds.
     ![](images/slack-notification-updates.png)

* **Off** 通知を受信しません。
* **Only failures** イメージ・ビルドに失敗したという通知のみ受信します。
* **Everything** イメージ・ビルドの成功、失敗のいずれの通知も受信します。

   .. image:: ./images/slack-notification-updates.png

.. Enjoy your new Slack channel integration!

Slack チャネルとの統合を活用してください。

.. ## Edit a Slack integration

.. _edit-a-slack-integration:

Slack 連携の編集
==============================

.. * Click **Account Settings** in the lower left, scroll down to **Notifications**, and locate the **Slack** section. From here you can choose a new notification level, or remove the integration.

* 下段左側の **Account Settings** をクリックして、下へスクロールして **Notifications** まで行き、**Slack** セクションを表示します。
  ここで通知レベルを新たに設定したり、通知を削除したりすることができます。

.. * From the Slack **Notifications** section you can also change the channel that the integration posts to. Click the reload icon (two arrows) next to the Slack integration to reopen the OAuth channel selector.

* Slack の **Notifications** セクションでは、通知を送信するチャネルの変更も行うことができます。
  Slack 連携のとなりにある（2 つ矢印の）リロード・アイコンをクリックすると、OAuth チャネルを選ぶことができます。

.. * Alternately, go to the <a href="https://slack.com/apps/manage" target="_blank">Slack App Management page</a> and search for "Docker Hub". Click the result to see all of the Docker Hub notification channels set for the Slack team.

* 上とは別に、`Slack App Management ページ <https://slack.com/apps/manage>`_ にアクセスし、「Docker Hub」を検索してみてください。検索結果をクリックして、Slack チームに設定されている Docker Hub の通知チャネルを確認してください。

.. seealso:: 

   Set up Docker Hub notifications in Slack
      https://docs.docker.com/docker-hub/slack_integration/
