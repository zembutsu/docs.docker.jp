.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/reference/create/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/reference/create.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/reference/create.md
.. check date: 2016/04/29
.. Commits on Feb 25, 2016 e8fad3d657f23aea08b3d03eab422ae89cfa3442
.. -------------------------------------------------------------------

.. create — Create a discovery toke

.. _create-create-a-discovery-token:

===================================================
create - ディスカバリ・トークンの作成
===================================================

.. The create command uses Docker Hub’s hosted discovery backend to create a unique discovery token for your cluster. For example:

``create`` コマンドを実行したら、 Docker Hub ホステット・ディスカバリ・バックエンドを使い、クラスタ用のユニークなディスカバリ・トークンを作成します。

.. code-block:: bash

   $ docker run --rm  swarm create
   86222732d62b6868d441d430aee4f055

.. Later, when you use manage or join to create Swarm managers and nodes, you use the discovery token in the <discovery> argument (e.g., token://86222732d62b6868d441d430aee4f055). The discovery backend registers each new Swarm manager and node that uses the token as a member of your cluster.

.. Some documentation also refers to the discovery token as a cluster_id.

このディスカバリ・トークンは、ドキュメントによっては *clouster_id* と記述されているかもしれません。

..    Warning: Docker Hub’s hosted discovery backend is not recommended for production use. It’s intended only for testing/development.

.. warning::

   Docker Hub のホステッド・ディスカバリ・バックエンドはプロダクション環境での利用が推奨されていません。純粋にテスト・開発目的での利用を意図しています。

.. For more information and examples about this and other discovery backends, see the Docker Swarm Discovery topic.

具体的な利用方法や他のバックエンドに関する情報は :doc:`/swarm/discovery` をご覧ください。

.. seealso:: 

   create — Create a discovery token
      https://docs.docker.com/swarm/reference/create/

