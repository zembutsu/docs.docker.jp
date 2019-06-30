.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/push/
.. -------------------------------------------------------------------

.. title: docker-compose push

.. _docker-compose-push:

=======================================
docker-compose push
=======================================

.. ```
   Usage: push [options] [SERVICE...]

   Options:
       --ignore-push-failures  Push what it can and ignores images with push failures.
   ```
::

   利用方法: push [オプション] [SERVICE...]

   オプション:
       --ignore-push-failures  可能なものはプッシュし、失敗するものは無視します。

.. Pushes images for services to their respective `registry/repository`.

サービスのイメージを、それぞれの ``registry/repository`` に対してプッシュします。

.. The following assumptions are made:

以下のことを前提としています。

.. - You are pushing an image you have built locally

* ローカルにビルド済のイメージをプッシュするものとします。

.. - You have access to the build key

* ビルドキーに対してアクセス権を有しているものとします。

.. ## Example

例
===

.. ```yaml
   version: '3'
   services:
     service1:
       build: .
       image: localhost:5000/yourimage  # goes to local registry

     service2:
       build: .
       image: youruser/yourimage  # goes to youruser DockerHub registry
   ```
.. code-block:: yaml

   version: '3'
   services:
     service1:
       build: .
       image: localhost:5000/yourimage  # ローカルレジストリへ

     service2:
       build: .
       image: youruser/yourimage  # 自ユーザーの DockerHub レジストリへ

.. seealso:: 

   docker-compose push
      https://docs.docker.com/compose/reference/push/
