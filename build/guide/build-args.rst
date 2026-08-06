.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/build/guide/build-args/
   doc version: 24.0
      https://github.com/docker/docs/blob/main/content/build/guide/build-args.md
.. check date: 2023/08/28
.. Commits on Aug 22, 2023 79e84623663771417fb406dfc80b6f01551bc2b2
.. -----------------------------------------------------------------------------

.. Build arguments
.. _build-guide-build-arguments:

========================================
構築引数（build arguments）
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:　

.. Build arguments is a great way to add flexibility to your builds. You can pass build arguments at build-time, and you can set a default value that the builder uses as a fallback.

:ruby:`構築引数 <build arguments>` は、構築に柔軟性を追加するために良い方法です。構築時に構築引数を渡せるため、ビルダがフォールバックとして使うデフォルト値を設定できます。

.. Change runtime versions
.. _change-runtime-versions:

ランタイムのバージョン変更
==============================

.. A practical use case for build arguments is to specify runtime versions for build stages. Your image uses the golang:1.20-alpine image as a base image. But what if someone wanted to use a different version of Go for building the application? They could update the version number inside the Dockerfile, but that’s inconvenient, it makes switching between versions more tedious than it has to be. Build arguments make life easier:

構築引数の実践的な利用例は、ビルドステージにおけるランタイムのバージョン指定です。イメージは ``golang:1.20-alpine`` イメージをベースイメージとして使うとします。ですが、アプリケーション構築にあたり異なるバージョンの Go が必要な時はどうしたらよいでしょうか。 Dockerfile 内のバージョン番号を変更して対応できますが、バージョン間の切替は少々面倒です。それよりも構築引数を使う方が簡単です。

.. code-block:: diff


.. Summary

まとめ
==========

.. This section has shown how you can improve your build speed using cache and bind mounts.

このセクションでは、キャッシュとバインドマウントを使って構築速度を改善できる方法を学びました。

.. Related information:

関連情報：

..  Dockerfile reference
    Bind mounts


* :ref:`Dockerfile リファレンス <builder-run---mount>`
* :doc:`バインドマウント </storage/bind-mounts>`

次のステップ
====================

.. The next section of this guide is an introduction to making your builds configurable, using build arguments.

次セクションでは構築引数を使い、調整可能な構築をする方法をを紹介します。

.. raw:: html

   <div style="overflow: hidden; margin-bottom:20px;">
      <a href="build-args.html" class="btn btn-neutral float-left">構築引数 <span class="fa fa-arrow-circle-right"></span></a>
   </div>


----

.. seealso::

   Build arguments
      https://docs.docker.com/build/guide/build-args/


