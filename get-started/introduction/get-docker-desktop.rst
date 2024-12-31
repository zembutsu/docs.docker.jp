.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/introduction/get-docker-desktop/
   doc version: 27.0
      https://github.com/docker/docs/blob/main/content/get-started/introduction/get-docker-desktop.md
.. check date: 2024/12/31
.. Commits on Nov 12, 2024 3a01ae99390f8ad7570a80beda022dc21b19f0e5
.. -----------------------------------------------------------------------------

.. Get Docker Desktop
.. _introduction-get-docker-desktop:

========================================
Docker Desktop の入手
========================================

.. raw:: html

   <iframe width="737" height="415" src="https://www.youtube.com/embed/C2bPVhiNU-0" title="YouTube video player" frameborder="1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>

----

.. _introduction-get-docker-desktop-explanation:

説明
==========

.. Docker Desktop is the all-in-one package to build images, run containers, and so much more. This guide will walk you through the installation process, enabling you to experience Docker Desktop firsthand.

Docker Desktop はイメージの構築、コンテナ実行などがすべて一体となったパッケージです。このガイドはインストール手順を通して、 Docker Desktop を直接体験できるようにします。

..  Docker Desktop terms
    Commercial use of Docker Desktop in larger enterprises (more than 250 employees OR more than $10 million USD in annual revenue) requires a paid subscription.

.. raw:: html

   <div class="blockquote">
     <b>Docker Desktop 利用規約</b>
     <p>大企業（従業員が 250 人より多い、または、年間売上高が1000万米ドルより多い）で Docker Desksotp を商用利用する場合、 <a class="reference external" href="https://www.docker.com/ja-jp/pricing/">有料サブスクリプション</a> が必要です。</p>
   </div>



.. raw:: html

   <div class="docker-button-full">
     <div class="icon">🍎</div>
     <div class="content">
       <h3>Docker Desktop for Mac</h3>
       <p class="download-links">
         <a href="https://desktop.docker.com/mac/main/arm64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-arm64" class="reference external">ダウンロード (Apple Silicon)</a> |
         <a href="https://desktop.docker.com/mac/main/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-mac-amd64" class="reference external">ダウンロード (Intel)</a> |
         <a href="../../desktop/setup/install/mac-install.html" class="inline-link">インストール手順</a>
       </p>
     </div>
   </div>

.. raw:: html

   <div class="docker-button-full">
     <div class="icon">🪟</div>
     <div class="content">
       <h3>Docker Desktop for Windows</h3>
       <p class="download-links">
         <a href="https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe?utm_source=docker&utm_medium=webreferral&utm_campaign=docs-driven-download-windows" class="reference external">ダウンロード</a> |
         <a href="../../desktop/setup/install/windows-install.html" class="inline-link">インストール手順</a>
       </p>
     </div>
   </div>

.. raw:: html

   <div class="docker-button-full">
     <div class="icon">🐧</div>
     <div class="content">
       <h3>Docker Desktop for Linux</h3>
       <p class="download-links">
         <a href="../../desktop/setup/install/linux.html" class="inline-link">インストール手順</a>
       </p>
     </div>
   </div>

.. Once it's installed, complete the setup process and you're all set to run a Docker container.

インストールが終われば、セットアップ処理は完了し、Docker コンテナを実行する準備がすっかり整いました。

.. Try it out
.. _introduction-try-it-out:

やってみよう
====================

.. In this hands-on guide, you will see how to run a Docker container using Docker Desktop.

このハンズオンガイドでは、Docker Desktop を使って Docker コンテナを実行する方法を学びます。

.. Follow the instructions to run a container using the CLI.

CLI（コマンドラインツール）を使ってコンテナを実行するには、以下の手順を進めます。

.. Run your first container
.. _introduction-run-your-first-container:

初めてのコンテナを実行
==============================

.. Open your CLI terminal and start a container by running the docker run command:

CLI ターミナルを開き、 ``docker run`` コマンドを実行してコンテナを起動します。


.. code-block:: console

   $ docker run -d -p 8080:80 docker/welcome-to-docker

.. Access the frontend
.. _introduction-access-the-frontend:

フロントエンドにアクセス
==============================

.. For this container, the frontend is accessible on port 8080. To open the website, visit http://localhost:8080 in your browser.

このコンテナは、フロントエンドにはポート ``8080`` でアクセスできます。ウェブサイトを開くには、ブラウザで http://localhost:8080 を表示します。

.. image:: ../docker-concepts/the-basics/images/access-the-frontend.webp
   :class: fade-image
   :alt: Nginx ウェブサーバのランディングページの表示は、実行中のコンテナからのもの



.. seealso::

   Get Docker Desktop | Docker Docs
      https://docs.docker.com/get-started/introduction/get-docker-desktop/

