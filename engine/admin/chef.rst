.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/chef/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/chef.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/chef.md
.. check date: 2016/06/23
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------------------

.. Using Chef

.. _using-chef:

=======================================
Chef を使う
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Note: Please note this is a community contributed installation path.

.. note::

   このインストール方法に関するドキュメントは、コミュニティから貢献です。

.. Requirements

動作条件
====================

.. To use this guide you’ll need a working installation of Chef. This cookbook supports a variety of operating systems.

このガイドを使う前に、 `Chef <http://www.chef.io/>`_ のインストール作業が必要です。cookbook は様々なオペレーティング・システムに対応しています。

.. Installation

インストール
====================

.. The cookbook is available on the Chef Supermarket and can be installed using your favorite cookbook dependency manager.

`Chef Supermarket <https://supermarket.chef.io/cookbooks/docker>`_ 上の cookbook が利用可能です。そして、好みの cookbook 依存関係マネージャ（dependency manager）を使ってインストールできます。

.. The source can be found on GitHub.

ソースは `GitHub <https://github.com/someara/chef-docker>`_ 上にあります。

.. Usage

使い方
==========

..    Add depends 'docker', '~> 2.0' to your cookbook’s metadata.rb
    Use resources shipped in cookbook in a recipe, the same way you’d use core Chef resources (file, template, directory, package, etc).

* 自分の cookbook の metadata.rb に ``depends 'docker', '~> 2.0'`` を追加します。
* cookbook のレシピに送信するリソースを指定します。同様にコア Chef リソースも使えます（file、template、directory、package 等）。

.. code-block:: bash

   docker_service 'default' do
     action [:create, :start]
   end
   
   docker_image 'busybox' do
     action :pull
   end
   
   docker_container 'an echo server' do
     repo 'busybox'
     port '1234:1234'
     command "nc -ll -p 1234 -e /bin/cat"
   end

.. Getting Started

はじめましょう
====================

.. Here’s a quick example of pulling the latest image and running a container with exposed ports.

こちらの例は、最新のイメージを取得し、コンテナ実行時にポートを公開します。

.. code-block:: bash

   # Pull latest image
   docker_image 'nginx' do
     tag 'latest'
     action :pull
   end
   
   # Run container exposing ports
   docker_container 'my_nginx' do
     repo 'nginx'
     tag 'latest'
     port '80:80'
     binds [ '/some/local/files/:/etc/nginx/conf.d' ]
     host_name 'www'
     domain_name 'computers.biz'
     env 'FOO=bar'
     subscribes :redeploy, 'docker_image[nginx]'
   end

.. seealso:: 

   Quickstart Docker Engine
      https://docs.docker.com/engine/quickstart/

