.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/extend/examples/apt-cacher-ng/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/examples/apt-cacher-ng.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/examples/apt-cacher-ng.md
.. check date: 2016/06/13
.. Commits on Jun 20, 2016 8aba9fd3ec776fa419ea504982e9bc12b6427f22
.. ---------------------------------------------------------------

.. Dockerizing an apt-cacher-ng service

.. _dockerizing-an-apt-cacher-ng-service:

========================================
apt-cacher-ng サービスの Docker 化
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

..     Note: - If you don’t like sudo then see Giving non-root access. - If you’re using OS X or docker via TCP then you shouldn’t use sudo.

   ``sudo`` が好きでなければ、 :ref:`giving-non-root-access` をご覧ください。OS X を使っている場合や docker を TCP 経由で使っている場合は、 sudo を使う必要がありません。

.. When you have multiple Docker servers, or build unrelated Docker containers which can’t make use of the Docker build cache, it can be useful to have a caching proxy for your packages. This container makes the second download of any package almost instant.

複数の Docker サーバを持っている場合や、Docker 構築キャッシュを使わない Docker コンテナを構築する場合は、パッケージ用のキャッシュ・プロキシを使うと便利です。このコンテナは、パッケージを既にダウンロード済みの環境から二次ダウンロードできるようにします。

.. Use the following Dockerfile:

以下の Dockerfile を使います。

.. code-block:: bash

   #
   # Build: docker build -t apt-cacher .
   # Run: docker run -d -p 3142:3142 --name apt-cacher-run apt-cacher
   #
   # and then you can run containers with:
   #   docker run -t -i --rm -e http_proxy http://dockerhost:3142/ debian bash
   #
   # Here, `dockerhost` is the IP address or FQDN of a host running the Docker daemon
   # which acts as an APT proxy server.
   FROM        ubuntu
   MAINTAINER  SvenDowideit@docker.com
   
   VOLUME      ["/var/cache/apt-cacher-ng"]
   RUN     apt-get update && apt-get install -y apt-cacher-ng
   
   EXPOSE      3142
   CMD     chmod 777 /var/cache/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*

.. To build the image using:

イメージを構築するには、次のようにします。

.. code-block:: bash

   $ docker build -t eg_apt_cacher_ng .

.. Then run it, mapping the exposed port to one on the host

それから実行します。公開されたポートをホスト側に割り当てます。

.. code-block:: bash

   $ docker run -d -p 3142:3142 --name test_apt_cacher_ng eg_apt_cacher_ng

.. To see the logfiles that are tailed in the default command, you can use:

ログファイルを参照します。デフォルトのコマンドに ``ｰf`` （末尾を表示）オプションを付けます。

.. code-block:: bash

   $ docker logs -f test_apt_cacher_ng

.. To get your Debian-based containers to use the proxy, you have following options. Note that you must replace dockerhost with the IP address or FQDN of the host running the test_apt_cacher_ng container.

Debian をベースとしたコンテナで proxy を使うには、以下の手順とオプションを進めます。このとき ``dockerhost``  の箇所は ``test_apt_cacher_ng`` コンテナを実行するホストの IP アドレスか FQDN を置き換える必要があります。

..    Add an apt Proxy setting echo 'Acquire::http { Proxy "http://dockerhost:3142"; };' >> /etc/apt/conf.d/01proxy
    Set an environment variable: http_proxy=http://dockerhost:3142/
    Change your sources.list entries to start with http://dockerhost:3142/

1. apt プロキシ設定を追加します。

.. code-block:: bash

   echo 'Acquire::http { Proxy "http://dockerhost:3142"; };' >> /etc/apt/conf.d/01proxy

2. 環境変数を設定します： ``http_proxy=http://dockerhost:3142/``

3. ``sources.list`` エントリを変更し、 ``http://dockerhost:3142/`` から始めるようにします。

4. ``--link`` を使って APT proxy コンテナを Debian ベースのコンテナにリンクします。

5. Debian ベースのコンテナで、APT proxy コンテナに接続するカスタム・ネットワークを作成します。

.. Option 1 injects the settings safely into your apt configuration in a local version of a common base:

**オプション１** ：apt 設定を安全に行うには、共通の基盤となるバージョンで apt 設定を行う方法があります。

.. code-block:: bash

   FROM ubuntu
   RUN  echo 'Acquire::http { Proxy "http://dockerhost:3142"; };' >> /etc/apt/apt.conf.d/01proxy
   RUN apt-get update && apt-get install -y vim git
   
   # docker build -t my_ubuntu .

.. Option 2 is good for testing, but will break other HTTP clients which obey http_proxy, such as curl, wget and others:

**オプション２** ： ``http_proxy`` 設定はテストに便利ですが、 ``curl`` と ``wget``  のような HTTP クライアントでは動作しない場合があります。

.. code-block:: bash

   $ docker run --rm -t -i -e http_proxy=http://dockerhost:3142/ debian bash

.. Option 3 is the least portable, but there will be times when you might need to do it and you can do it from your Dockerfile too.

**オプション３** ： これは最新版を取り入れるためですが、 ``Dockerfile`` では何度が記述が必要になるかもしれません。

.. Option 4  links Debian-containers to the proxy server using following command:

**オプション４** ：Debian コンテナを proxy サーバに次のコマンドでリンクします。

.. code-block:: bash

   $ docker run -i -t --link test_apt_cacher_ng:apt_proxy -e http_proxy=http://apt_proxy:3142/ debian bash

.. **Option 5** creates a custom network of APT proxy server and Debian-based containers:

**オプション５** ：APT proxy サーバと Debian ベースのコンテナが接続するカスタム・ネットワークを作成します。

.. code-block:: bash

   $ docker network create mynetwork
   $ docker run -d -p 3142:3142 --net=mynetwork --name test_apt_cacher_ng eg_apt_cacher_ng
   $ docker run --rm -it --net=mynetwork -e http_proxy=http://test_apt_cacher_ng:3142/ debian bash





.. Apt-cacher-ng has some tools that allow you to manage the repository, and they can be used by leveraging the VOLUME instruction, and the image we built to run the service:

apt-cacher-ng はリポジトリを管理するのと同じツールを持っています。 ``VOLUME`` 命令を使い、サービスを実行するイメージを構築します。

.. code-block:: bash

   $ docker run --rm -t -i --volumes-from test_apt_cacher_ng eg_apt_cacher_ng bash
   
   $$ /usr/lib/apt-cacher-ng/distkill.pl
   Scanning /var/cache/apt-cacher-ng, please wait...
   Found distributions:
   bla, taggedcount: 0
        1. precise-security (36 index files)
        2. wheezy (25 index files)
        3. precise-updates (36 index files)
        4. precise (36 index files)
        5. wheezy-updates (18 index files)
   
   Found architectures:
        6. amd64 (36 index files)
        7. i386 (24 index files)
   
   WARNING: The removal action may wipe out whole directories containing
            index files. Select d to see detailed list.
   
   (Number nn: tag distribution or architecture nn; 0: exit; d: show details; r: remove tagged; q: quit): q

.. Finally, clean up after your test by stopping and removing the container, and then removing the image.

最後に、コンテナのテストが終わったら、クリーンアップのためにコンテナを停止・削除し、イメージを削除します。

.. code-block:: bash

   $ docker stop test_apt_cacher_ng
   $ docker rm test_apt_cacher_ng
   $ docker rmi eg_apt_cacher_ng

.. seealso:: 

   Dockerizing an apt-cacher-ng service
      https://docs.docker.com/engine/examples/apt-cacher-ng/

