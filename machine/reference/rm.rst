.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/reference/rm/
.. doc version: 1.9
.. check date: 2016/01/28
.. -----------------------------------------------------------------------------

.. rm

.. _machine-rm:

=======================================
rm
=======================================

.. Remove a machine. This will remove the local reference as well as delete it on the cloud provider or virtualization management platform.

マシンを削除（remove）します。ローカル環境から削除するだけでなく、クラウド・プロバイダや仮想化管理プラットフォームからも削除します。

.. code-block:: bash

   $ docker-machine ls
   NAME   ACTIVE   DRIVER       STATE     URL
   foo0   -        virtualbox   Running   tcp://192.168.99.105:2376
   foo1   -        virtualbox   Running   tcp://192.168.99.106:2376
   
   $ docker-machine rm foo1
   Do you really want to remove "foo1"? (y/n): y
   Successfully removed foo1
   
   $ docker-machine ls
   NAME   ACTIVE   DRIVER       STATE     URL
   foo0   -        virtualbox   Running   tcp://192.168.99.105:2376
