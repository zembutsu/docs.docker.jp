.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/dev-environments/specify/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/dev-environments/specify.md
.. check date: 2022/09/18
.. Commits on Jul 1, 2022 1645a61593f79996a3191a2c6f37ada885fe62b7
.. -----------------------------------------------------------------------------


.. Specify a Dockerfile or base image
.. _specify-a-dockerfile-or-base-image:

==================================================
Dockerfile やベースイメージの指定
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Specify a Dockerfile
.. _dev-env-specify-a-dockerfile:

Dockerfile の指定
====================

.. Use a JSON file to specify a Dockerfile which in turn defines your Dev Environment. You must include this as part of the .docker folder and then add it as a config.json file. For example:

JSON ファイルを使い、 Dev Environment を定義する Dockerfile を指定します。これを ``.docker`` フォルダの中に入れ、さらに ``config.json`` ファイルへの追加が必要です。例：


.. code-block:: yaml

   {
       "dockerfile": "Dockerfile.devenv"
   }

.. Next, define the dependencies you want to include in your Dockerfile.devenv.

次に、 ``Dockerfile.devenv`` 内に必要となる依存家計を定義します。

.. While some images or Dockerfiles include a non-root user, many base images and Dockerfiles do not. Fortunately, you can add a non-root user named vscode. If you include Docker tooling, for example the Docker CLI or docker compose, in the Dockerfile.devenv, you need the vscode user to be included in the docker group.

いくつかのイメージや Dockerfile に root 以外のユーザを含まれていますが、多くのベースイメージと Dockerfile には含まれていません。幸いにも、 vscode という名前の root 以外のユーザを追加可能です。 Docker CLI や ``docker compose`` のような Docker ツールを含む場合、 ``Dockerfile.devenv`` 内で、 ``docker`` グループ内に ``vscode`` ユーザを含める必要があります。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   
   FROM <your base image>
   
   RUN useradd -s /bin/bash -m vscode \
    && groupadd docker \
    && usermod -aG docker vscode
   
   USER vscode

.. Specify a base image
.. _dev-env-specify-a-base-image:

ベースイメージの指定
====================

.. If you already have an image built, you can specify it as a base image to define your Dev Environment. You must include this as part of the .docker folder and then add it as a config.json file. For example, to use the Jekyll base image, add:

既に構築したイメージがある場合、 Dev Environment でベースイメージとして定義できます。これを ``.docker`` フォルダの中に入れ、さらに ``config.json`` ファイルへの追加が必要です。たとえば、 Jekyll ベースイメージを使う場合は、次の内容を追加します：

.. code-block:: yaml

   {
     "image": "jekyll/jekyll"
   }

..  Note
    This configuration is to unblock users for the Beta release only. We may move this configuration for single and multi-container applications to a Compose-based implementation in future releases.

.. note::

   この設定は、ベータリリースのみユーザのブロックが解除されています。今後のリリースでは、シングルおよびマルチコンテナアプリケーションの設定が、 Compose ベースの実装に移行する可能性があります。


.. seealso::

   Specify a Dockerfile or base image
      https://docs.docker.com/desktop/dev-environments/specify/
