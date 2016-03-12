.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/registry/recipes/
.. SOURCE: -
   doc version: 1.10
.. check date: 2016/03/12
.. -------------------------------------------------------------------

.. Recipies

.. _recipies:

========================================
レシピ
========================================

.. You will find here a list of “recipes”, end-to-end scenarios for exotic or otherwise advanced use-cases.

ここでは魅力的あるいは高度な利用例といった、様々な実際の利用シナリオを「レシピ」として一覧にしたものです。

.. Most users are not expected to have a use for these.

予想できない利用例もあるでしょう。

.. Requirements

.. _registry-requirements:

必要条件
==========

.. You should have followed entirely the basic deployment guide.

基本である :doc:`デプロイメント・ガイド </registry/deployment>` 全体を理解していることが望ましいです。

.. If you have not, please take the time to do so.

そうでなければ、まずはドキュメントを読んだ上で、次に進んでください。

.. At this point, it’s assumed that:

この時点では、次のような状態とみなします。

..    you understand Docker security requirements, and how to configure your docker engines properly
    you have installed Docker Compose
    it’s HIGHLY recommended that you get a certificate from a known CA instead of self-signed certificates
    inside the current directory, you have a X509 domain.crt and domain.key, for the CN myregistrydomain.com
    be sure you have stopped and removed any previously running registry (typically docker stop registry && docker rm -v registry)

* Docker のセキュリティ要件を理解し、Docker Engine を適切に設定できる。
* Docker Compose をインストールしたことがある。
* 自己署名ではなく認証局（CA）による証明書を準備しておくことを、強く推奨します。
* 現在のディレクトリに  CN ``myregistrydomain.com`` の X509 ``domain.cert`` と ``domain.key`` がある。
* これまで実行していた registry を停止・削除している（通常は ``docker stop registry && docker rm -v registry`` ）

.. The List

レシピの一覧
====================

..    using Apache as an authenticating proxy
    using Nginx as an authenticating proxy
    running a Registry on OS X
    hacking the registry: build instructions
    mirror the Docker Hub

* :doc:`apache`
* :doc:`nginx`
* :doc:`osx-setup-guide`
* :doc:`building`
* :doc:`mirror`

.. seealso:: 

   Recipies
      https://docs.docker.com/registry/recipes/

