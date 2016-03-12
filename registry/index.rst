.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/registry/
.. SOURCE: -
   doc version: 1.10
.. check date: 2016/03/12
.. -------------------------------------------------------------------

.. Docker Registry

.. _docker-registry:

========================================
Docker レジストリ
========================================

.. caution::

   訳者注：Docker Registry は今後 Docker Distribution https://github.com/docker/distribution に統合予定です。そのため、ドキュメントの更新は停止しており、将来的にここに書かれている情報が古くなる可能性があります。


.. What it is

.. _registry-what-it-is:

これは何ですか
====================

.. The Registry is a stateless, highly scalable server side application that stores and lets you distribute Docker images. The Registry is open-source, under the permissive Apache license.

レジストリ（Registry）とは、ステートレス（処理状態を把握しない）であり、サーバ・サイドのアプリケーションを大きくスケールさせるため、Docker イメージを保管・提供をします。レジストリは `Apache ライセンス <http://en.wikipedia.org/wiki/Apache_License>`_ 許諾のオープン・ソースです。

.. Why use it

.. _registry-why-use-it:

なぜ使うのですか？
====================

.. You should use the Registry if you want to:

次のことをしたい場合、レジストリを使ったほうが良いでしょう。

..    tightly control where your images are being stored
    fully own your images distribution pipeline
    integrate image storage and distribution tightly into your in-house development workflow


* イメージの保管される場所を厳密に管理したい
* イメージ配布パイプラインを、自分で完全に管理したい
* 組織内の開発ワークフローに一致するように、イメージ・ストレージと配布を統合

.. Alternatives

.. _registry-alternatives:

代替手法
==========

.. Users looking for a zero maintenance, ready-to-go solution are encouraged to head-over to the Docker Hub, which provides a free-to-use, hosted Registry, plus additional features (organization accounts, automated builds, and more).

ユーザがメンテナンスをしたくないのであれば、すぐにでも使える方法が `Docker Hub <https://hub.docker.com/>`_ の利用でしょう。無料で使え、レジストリを預かってくれ、追加機能（組織用アカウント、自動構築、など）があります。

.. Users looking for a commercially supported version of the Registry should look into Docker Trusted Registry.

レジストリの商用サポート版を探しているのであれば、 :doc:`Docker トラステッド・レジストリ（Trusted Registry） </docker-trusted-registry/index>` をご覧ください。

.. Requirements

.. _registry-requirements:

動作条件
====================

.. The Registry is compatible with Docker engine version 1.6.0 or higher. If you really need to work with older Docker versions, you should look into the old python registry.

レジストリは Docker エンジン **バージョン 1.6.0 以上** で動作します。どうしても古い Docker バージョンで動かす必要があれば、 `古い python レジストリ <https://github.com/docker/docker-registry>`_ をご覧ください。

.. TL;DR

TL;DR
====================

.. Start your registry

レジストリを開始する方法

.. code-block:: bash

   docker run -d -p 5000:5000 --name registry registry:2

.. Pull (or build) some image from the hub

Docker Hub からのイメージの取得（あるいは構築）

.. code-block:: bash

   docker pull ubuntu

.. Tag the image so that it points to your registry

自分のレジストリ上のイメージを指定

.. code-block:: bash

   docker tag ubuntu localhost:5000/myfirstimage

.. Push it

送信する

.. code-block:: bash

   docker push localhost:5000/myfirstimage

.. Pull it back

また取得する

.. code-block:: bash

   docker pull localhost:5000/myfirstimage

.. Now stop your registry and remove all data

レジストリを停止し、全てのデータを削除する。

.. code-block:: bash

   docker stop registry && docker rm -v registry

.. Next

.. _registry-next:

次へ
==========

.. You should now read the detailed introduction about the registry, or jump directly to deployment instructions.

これで :doc:`レジストリの詳細な紹介 <introduction>` を読むか、 :doc:`デプロイ方法 <deploying>` のページに直接ジャンプしてください。

.. seealso:: 

   Official Repositories on Docker Hub
      https://docs.docker.com/docker-hub/official_repos/
