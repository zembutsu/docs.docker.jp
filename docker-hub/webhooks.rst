.. -*- coding: utf-8 -*-
.. https://docs.docker.com/docker-hub/webhooks/
.. doc version: 1.9
.. check date: 2016/01/07

.. Webhooks for automated builds

.. _webhooks-for-automated-builds:

========================================
自動構築用の Webhooks
========================================

.. If you have created an automated build, you have the option of using Webhooks with it. You can use a webhook to cause an action in another application in response to an event in your automated build repository. Currently, your webhook fires when an image is built in, or a new tag added to, your automated build repository.

自動構築（automated build）の設定を作成するとき、オプションで webhook の設定もできます。webhook の設定を使えば、レポジトリで他のアプリケーションによるアクションが、自動構築リポジトリにイベントを発生させます。現時点の webhook ファイルは、自動構築リポジトリに対するイメージの構築か、新しいタグの追加を扱います。

.. With your webhook, you specify a target URL and a JSON payload to deliver. The webhook below generates an HTTP POST that delivers a JSON payload:

webhook では、ターゲット URL とドライバに対する JSON ペイロードを指定します。以下の webhook は JSON ペイロードの送信に HTTP POST を使用します。

.. code-block:: bash

   {
     callback_url: https://registry.hub.docker.com/u/svendowideit/testhook/hook/2141b5bi5i5b02bec211i4eeih0242eg11000a/,
     push_data: {
       images: [
           27d47432a69bca5f2700e4dff7de0388ed65f9d3fb1ec645e2bc24c223dc1cc3,
           51a9c7c1f8bb2fa19bcd09789a34e63f35abb80044bc10196e304f6634cc582c,
           ...
       ],
       pushed_at: 1.417566161e+09,
       pusher: trustedbuilder
     },
     repository: {
       comment_count: 0,
       date_created: 1.417494799e+09,
       description: ,
       dockerfile: #\n# BUILD\u0009\u0009docker build -t svendowideit/apt-cacher .\n# RUN\u0009\u0009docker run -d -p 3142:3142 -name apt-cacher-run apt-cacher\n#\n# and then you can run containers with:\n# \u0009\u0009docker run -t -i -rm -e http_proxy http://192.168.1.2:3142/ debian bash\n#\nFROM\u0009\u0009ubuntu\nMAINTAINER\u0009SvenDowideit@home.org.au\n\n\nVOLUME\u0009\u0009[\/var/cache/apt-cacher-ng\]\nRUN\u0009\u0009apt-get update ; apt-get install -yq apt-cacher-ng\n\nEXPOSE \u0009\u00093142\nCMD\u0009\u0009chmod 777 /var/cache/apt-cacher-ng ; /etc/init.d/apt-cacher-ng start ; tail -f /var/log/apt-cacher-ng/*\n,
       full_description: Docker Hub based automated build from a GitHub repo,
       is_official: false,
       is_private: true,
       is_trusted: true,
       name: testhook,
       namespace: svendowideit,
       owner: svendowideit,
       repo_name: svendowideit/testhook,
       repo_url: https://registry.hub.docker.com/u/svendowideit/testhook/,
       star_count: 0,
       status: Active
     }
   }

..    Note: If you want to test your webhook, we recommend using a tool like requestb.in. Also note, the Docker Hub server can’t be filtered by IP address.

.. note::

   webhook のテストには `requestb.in <http://requestb.in/>`_ のようなツールを推奨します。また、Docker Hub サーバは IP アドレスをフィルタできないのでご注意ください。

.. Chaining webhooks

.. _chaining-webhooks:

webhook の連鎖
====================

.. Webhook chains allow you to chain calls to multiple services. For example, you can use a webhook chain to trigger a deployment of your container only after it passes testing, then update a separate change log once the deployment is complete. After clicking the Add webhook button, simply add as many URLs as necessary in your chain.

.. The first webhook in a chain is called after a successful push. Subsequent URLs is contacted after the callback is validated. You can find specific details on how to set up webhooks in the GitHub and Bitbucket documentation.

.. Validating a callback

.. _validating-a-callback:

コールバックの確認
===================

.. To validate a callback in a webhook chain, you need to

webhook 連鎖のコールバックを確認するには、次のようにします。

..    Retrieve the callback_url value in the request’s JSON payload.
..    Send a POST request to this URL containing a valid JSON body.

1. リクエストする JSON ペイロードに ``callback_url`` 値を入れてから、読み込む
2. 有効な JSON の内容に含まれる URL に対して、POST リクエストが送信

..    Note: A chain request is only considered complete once the last callback is validated.

.. note::

  最後のコールバックが正常だった場合のみ、 連鎖リクエストが完了したとみなされます。

.. To help you debug or simply view the results of your webhook(s), view the History of the webhook available on its settings page.

webhook のデバッグを簡単にしたり、結果を単に表示したい亜愛は、設定ページにある webhook の「History」をご覧ください。

.. Callback JSON data

JSON データのコールバック
==============================

.. The following is the JSON structure for the callback.

以下の形式の JSON 構造がコールバックされます。

.. code-block:: json

   {
     state: success,
     description: 387 tests PASSED,
     context: Continuous integration by Acme CI,
     target_url: http://ci.acme.com/results/afd339c1c3d27
   }

.. Parameter 	Description
.. state 	Required. Can contain the success, failure and error values. If the state isn’t success, the webhook chain is interrupted.
.. description 	A string containing miscellaneous information that is,available on the Docker Hub. Maximum 255 characters.
.. context 	A string containing the context of the operation. Can be retrieved,from the Docker Hub. Maximum 100 characters.
.. target_url 	The URL where the results of the operation can be found. Can be,retrieved on the Docker Hub.

パラメータと説明：

* ``state`` （必須）： ``success`` 、 ``failure`` 、 ``error`` の値を受信。 ``success`` でなければ、webhook 連鎖は中断。
* ``description`` ：Docker Hub で利用可能な様々な説明を含む文字列。最大255文字。
* ``context`` ：操作に関連するコンテキストを含む文字列。Docker Hub が受信可能。最大100文字。
* ``target_url`` ：オペレーションで得られた結果を送る URL 。Docker Hub が受信可能。
