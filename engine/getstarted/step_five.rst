.. -*- coding: utf-8 -*-
.. https://docs.docker.com/linux/step_five/
.. doc version: 1.10
.. check date: 2016/4/13
.. -----------------------------------------------------------------------------

.. Crate a Docker Hub account & repository

.. _create-a-docker-hub-account-and-repository-linux:

========================================
Docker Hub アカウントとリポジトリの作成
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You’ve built something really cool, you should share it. In this next section, you’ll do just that. You’ll need a Docker Hub account. Then, you’ll push your image up to it so other people with Docker Engine can run it.

良い感じにイメージを構築できました。次はイメージ共有しましょう。このセクションでは共有を扱います。共有するには Docker Hub アカウントが必要です。イメージをアップロードしたら、Docker Engine を持つ他の人も実行できるようになります。

.. Step 1: Sign up for an account

.. _step-1-sign-up-for-an-account-linux:

ステップ１：アカウントの登録（サインアップ）
==================================================

..    Use your browser to navigate to the Docker Hub signup page.

1. ブラウザで `Docker Hub のサインアップ・ページ <https://hub.docker.com/>`_ を開きます。　

..    Your browser displays the page.

ブラウザには次のページが表示されます。

.. image:: /tutimg/hub_signup.png
   :scale: 60%
   :alt: Docker Hub

..    Fill out the form on the signup page.

2. サインアップ・ページのフォームを入力します。

..    Docker Hub is free. Docker does need a name, password, and email address.

Docker Hub は無料で使えます。登録にはユーザ名、パスワード、メールアドレスが必要です。

..    Press Signup.

3. Signup（サインアップ）を押します。

..    The browser displays the welcome to Docker Hub page.

ブラウザには Docker Hub のウェルカム・ページが表示されます。

.. Step 2: Verify your email and add a repository

.. _step-2-verify-your-email-and-add-a-repository-linux:

ステップ２：メールアドレスの確認とリポジトリの追加
==================================================

.. Before you can share anything on the hub, you need to verify your email address.

何かを Docker Hub 上で共有する前に、メールアドレスの確認が必要です。

..    Open your email inbox.

1. メールの受信箱を確認します。

..    Look for the email titled Please confirm email for your Docker Hub account.

2. メールのタイトル ``Please confirm email for your Docker Hub account`` （Docker Hub アカウントのメールアドレスをご確認ください）を探します。

..    If you don’t see the email, check your Spam folder or wait a moment for the email to arrive.

メールが届いていなければ、迷惑メール用のフォルダに入っていないか確認するか、メールが到着するまでお待ちください。

..    Open the email and click the Confirm Your Email button.

3. メールの本文にあるボタンをクリックし、メールアドレスの確認を済ませます。

..    The browser opens Docker Hub to your profile page.

ブラウザで Docker Hub のページを開くと、自分のプロフィール・ページを表示します。

..    Choose Create Repository.

4. Create Repository（リポジトリの作成）をクリックします。

..    The browser opens the Create Repository page.

ブラウザは新しいリポジトリ作成ページを開きます。

..    Provide a Repository Name and Short Description.

5. リポジトリ名と簡単な説明を背追加します。

..    Make sure Visibility is set to Public.

6. Visibility（可視性）は Public （公開）に指定します。

..    When you are done, your form should look similar to the following:

作成するには、次の画面のように入力します。

.. image:: /tutimg/add_repository.png

..    Press Create when you are done.

7. Create を押すと作業完了です。

..    Docker Hub creates your new repository.

Docker Hub に自分の新しいリポジトリを作成しました。

.. Where to go next

次は何をしますか
====================

.. On this page, you opened an account on Docker Hub and created a new repository. In the next section, you populate the repository by tagging and pushing the image you created earlier.

このページでは Docker Hub 上にアカウントを開設し、新しいリポジトリを追加しました。次のセクションではリポジトリに送信するため、 :doc:`先ほど作成したイメージにタグを付けて送信 <step_six>` します。

.. seealso:: 

   Create a Docker Hub account & repository
      https://docs.docker.com/linux/step_five/


