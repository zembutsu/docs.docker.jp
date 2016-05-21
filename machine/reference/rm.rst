.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/rm/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/rm.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/rm.md
.. check date: 2016/04/28
.. Commits on Jan 9, 2016 b585ca631b53fb54591b044764198f863b490816
.. ----------------------------------------------------------------------------

.. rm

.. _machine-rm:

=======================================
rm
=======================================

.. Remove a machine. This will remove the local reference as well as delete it on the cloud provider or virtualization management platform.

マシンを削除（remove）します。ローカル環境から削除するだけでなく、クラウド・プロバイダや仮想化管理プラットフォームからも削除します。

.. code-block:: bash

   $ docker-machine rm --help
   
   使い方: docker-machine rm [オプション] [引数...]
   
   マシンを削除
   
   説明:
      引数は１つまたは複数のマシン名
   
   オプション:
   
      --force, -f  マシンを削除できなくても、ローカルの設定を削除する。また確認は自動的に `-y` を選択
      -y       削除時の確認で、入力プロンプトを表示せず、自動的に yes を選択

例：

.. code-block:: bash

   $ docker-machine ls
   NAME   ACTIVE   URL          STATE     URL                         SWARM   DOCKER   ERRORS
   bar    -        virtualbox   Running   tcp://192.168.99.101:2376           v1.9.1
   baz    -        virtualbox   Running   tcp://192.168.99.103:2376           v1.9.1
   foo    -        virtualbox   Running   tcp://192.168.99.100:2376           v1.9.1
   qix    -        virtualbox   Running   tcp://192.168.99.102:2376           v1.9.1
   
   
   $ docker-machine rm baz
   About to remove baz
   Are you sure? (y/n): y
   Successfully removed baz
   
   
   $ docker-machine ls
   NAME   ACTIVE   URL          STATE     URL                         SWARM   DOCKER   ERRORS
   bar    -        virtualbox   Running   tcp://192.168.99.101:2376           v1.9.1
   foo    -        virtualbox   Running   tcp://192.168.99.100:2376           v1.9.1
   qix    -        virtualbox   Running   tcp://192.168.99.102:2376           v1.9.1
   
   
   $ docker-machine rm bar qix
   About to remove bar, qix
   Are you sure? (y/n): y
   Successfully removed bar
   Successfully removed qix
   
   
   $ docker-machine ls
   NAME   ACTIVE   URL          STATE     URL                         SWARM   DOCKER   ERRORS
   foo    -        virtualbox   Running   tcp://192.168.99.100:2376           v1.9.1
   
   $ docker-machine rm -y foo
   About to remove foo
   Successfully removed foo

.. seealso:: 

   rm
      https://docs.docker.com/machine/reference/rm/
