.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/extend/examples/couchdb_data_volumes/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/examples/couchdb_data_volumes.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/examples/couchdb_data_volumes.md
.. check date: 2016/06/13
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------

.. Dockerizing a CouchDB service

.. _dockerizing-a-couchdb-service:

========================================
CouchDB サービスの Docker 化
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

..    Note: - If you don’t like sudo then see Giving non-root access

   ``sudo`` が好きでなければ、 :ref:`giving-non-root-access` をご覧ください。

.. Here’s an example of using data volumes to share the same data between two CouchDB containers. This could be used for hot upgrades, testing different versions of CouchDB on the same data, etc.

２つの CouchDB コンテナ間で同じデータを共有するため、ここでは例としてデータ・ボリュームを使います。これはホット・アップグレード、同じデータを使った異なった CouchDB バージョンのテストなどに便利です。

.. Create first database

.. _couchdb-create-first-database:

１つめのデータベースを作成
==============================

.. Note that we’re marking /var/lib/couchdb as a data volume.

``/var/lib/couchdb`` をデータ・ボリュームとして作成するのに注意してください。

.. code-block:: bash

   $ COUCH1=$(docker run -d -p 5984 -v /var/lib/couchdb shykes/couchdb:2013-05-03)

.. Add data to the first database

.. _couchdb-add-data-to-the-first-database:

１つめのデータベースにデータを追加
========================================

.. We’re assuming your Docker host is reachable at localhost. If not, replace localhost with the public IP of your Docker host.

Docker ホストは到達可能な ``localhost`` を想定しています。もしそうでなければ、 ``localhost`` を Docker ホストのパブリック IP アドレスに置き換えてください。

.. code-block:: bash

   $ HOST=localhost
   $ URL="http://$HOST:$(docker port $COUCH1 5984 | grep -o '[1-9][0-9]*$')/_utils/"
   $ echo "Navigate to $URL in your browser, and use the couch interface to add data"

.. Create second database

.. _couchdb-create-second-database:

２つめのデータベースを作成
==============================

.. This time, we’re requesting shared access to $COUCH1’s volumes.

今回は ``$COUCH1`` のボリュームに対する共有アクセスをリクエストします。

.. code-block:: bash

   $ COUCH2=$(docker run -d -p 5984 --volumes-from $COUCH1 shykes/couchdb:2013-05-03)

.. Browse data on the second database

.. _couchdb-browse-data-on-the-second-database:

２つめのデータベースのデータを表示
========================================

.. code-block:: bash

   $ HOST=localhost
   $ URL="http://$HOST:$(docker port $COUCH2 5984 | grep -o '[1-9][0-9]*$')/_utils/"
   $ echo "Navigate to $URL in your browser. You should see the same data as in the first database"'!'

.. Congratulations, you are now running two Couchdb containers, completely isolated from each other except for their data.

おめでとうございます。２つの Couchdb コンテナを実行し、お互いのデータを完全に隔離しました。

.. seealso:: 

   Dockerizing a CouchDB service
      https://docs.docker.com/engine/examples/couchdb_data_volumes/
