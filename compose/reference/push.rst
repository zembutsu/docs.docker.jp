.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/reference/push/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/reference/push.md
.. check date: 2022/04/09
.. Commits on Jan 28, 2022 b6b19516d0feacd798b485615ebfee410d9b6f86
.. -------------------------------------------------------------------

.. docker-compose push
.. _docker-compose-push:

=======================================
docker-compose push
=======================================

.. code-block:: bash

   使い方: docker-compose push [オプション] [サービス...]
   
   オプション:
       --ignore-push-failures  送信可能なイメージは送信し、送信失敗するイメージは無視

.. Pushes images for services to their respective registry/repository.

サービスに対応するイメージを各 ``registry/repositor`` に送信します。

.. The following assumptions are made:

以下の状況が想定されています。

..    You are pushing an image you have built locally
..    You have access to the build key

* ローカルで構築したイメージを送信しようとしている
* :ruby:`構築キー <build key>` にアクセス可能


.. Example
例
==========

.. code-block:: yalm

   version: '3'
   services:
     service1:
       build: .
       image: localhost:5000/yourimage  # goes to local registry
   
     service2:
       build: .
       image: your-dockerid/yourimage  # goes to your repository on Docker Hub


.. seealso:: 

   docker-compose push
      https://docs.docker.com/compose/reference/push/
