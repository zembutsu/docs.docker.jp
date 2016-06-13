.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/puppet/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/puppet.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/puppet.md
.. check date: 2016/06/13
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------------------

.. Using Puppet

.. _using-pupet-admin:

=======================================
Puppet を使う
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

..    Note: Please note this is a community contributed installation path. The only official installation is using the Ubuntu installation path. This version may sometimes be out of date.

.. note::

   このインストール方法は、コミュニティからの貢献です。 ``公式の`` インストール方法は `Ubuntu <https://docs.docker.com/engine/installation/ubuntulinux/>`_ を使います。このバージョンは情報が古いかもしれません。

.. Requirements

動作条件
==========

.. To use this guide you’ll need a working installation of Puppet from Puppet Labs .

このガイドを利用するには、 `Puppet Labs <https://puppetlabs.com/>`_ が提供する Puppet をインストールする必要があります。

.. The module also currently uses the official PPA so only works with Ubuntu.

また、現時点の公式パッケージが利用できるモジュールは、 Ubuntu 向けのみです。

.. Installation

インストール
====================

.. The module is available on the Puppet Forge and can be installed using the built-in module tool.

モジュールは `Puppet Forge <https://forge.puppetlabs.com/garethr/docker/>`_ のものが使えます。内部モジュールのツールを使ってインストールします。

.. code-block:: bash

   $ puppet module install garethr/docker

.. It can also be found on GitHub if you would rather download the source.

また、ソースをダウンロードするには、 `GitHub <https://github.com/garethr/garethr-docker>`_  も使えます。

.. Usage

使い方
==========

.. The module provides a puppet class for installing Docker and two defined types for managing images and containers.

モジュールは Docker をインストールする puppet クラスを提供し、イメージとコンテナを管理するために２つのタイプを定義します。

.. Installation

インストール
--------------------

.. code-block:: bash

   include 'docker'

.. Images

イメージ
----------

.. The next step is probably to install a Docker image. For this, we have a defined type which can be used like so:

次の手順でほとんどの Docker イメージをインストールします。この例では、次のように使用するタイプを定義しています。

.. code-block:: bash

   docker::image { 'ubuntu': }

.. This is equivalent to running:

これは、次のコマンドと同等です。

.. code-block:: bash

   $ docker pull ubuntu

.. Note that it will only be downloaded if an image of that name does not already exist. This is downloading a large binary so on first run can take a while. For that reason this define turns off the default 5 minute timeout for the exec type. Note that you can also remove images you no longer need with:

.. code-block:: bash

   docker::image { 'ubuntu':
     ensure => 'absent',
   }

.. Containers

コンテナ
----------

.. Now you have an image where you can run commands within a container managed by Docker.

これで、Docker によって管理されるコンテナ内で、コマンドを実行するイメージができます。

.. code-block:: bash

   docker::run { 'helloworld':
     image   => 'ubuntu',
     command => '/bin/sh -c "while true; do echo hello world; sleep 1; done"',
   }

.. This is equivalent to running the following command, but under upstart:

これは upstart 下での次のコマンドと同等です。

.. code-block:: bash

   $ docker run -d ubuntu /bin/sh -c "while true; do echo hello world; sleep 1; done"

.. Run also contains a number of optional parameters:

   docker::run { 'helloworld':
     image        => 'ubuntu',
     command      => '/bin/sh -c "while true; do echo hello world; sleep 1; done"',
     ports        => ['4444', '4555'],
     volumes      => ['/var/lib/couchdb', '/var/log'],
     volumes_from => '6446ea52fbc9',
     memory_limit => 10485760, # bytes
     username     => 'example',
     hostname     => 'example.com',
     env          => ['FOO=BAR', 'FOO2=BAR2'],
     dns          => ['8.8.8.8', '8.8.4.4'],
   }
   
..    Note: The ports, env, dns and volumes attributes can be set with either a single string or as above with an array of values.

.. note::

   ``ports`` 、 ``env`` 、 ``dns`` 、 ``volumes``  の属性は文字で指定するか、先ほどの配列の値で指定します。

.. seealso:: 

   Using Puppet
      https://docs.docker.com/engine/admin/puppet/
