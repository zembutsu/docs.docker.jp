.. http://docs.docker.com/swarm/install-manual/
.. doc version: 1.9
.. check date: 2015/11/23

.. Create a swarm for development

==============================
開発用の Swarm クラスタ作成
==============================

.. This section tells you how to create a Docker Swarm on your network to use only for debugging, testing, or development purposes. You can also use this type of installation if you are developing custom applications for Docker Swarm or contributing to 

このページでは、自分のネットワーク上に Docker Swam を作成する方法を紹介します。用途は、デバッグやテストや開発目的のみ対象です。この構築手順は、Docker Swam 向けの何らかのアプリケーション開発や、貢献のためにも使えます。

.. Caution: Only use this set up if your network environment is secured by a firewall or other measures.

.. caution::

   セットアップは、ファイアーウォールや他の手法によって、安全なネットワーク環境上で行ってください。

.. Prerequisites

事前準備
==========

.. You install Docker Swarm on a single system which is known as your Docker Swarm manager. You create the cluster, or swarm, on one or more additional nodes on your network. Each node in your swarm must:

単一システム上に Docker Swarm をインストールします。インストールするのは Docker Swarm マネージャです。これを使い、クラスタの作成や、ネットワーク上で１つないし


..    be accessible by the swarm manager across your network
    have Docker Engine 1.6.0+ installed
    open a TCP port to listen for the manager

.. You can run Docker Swarm on Linux 64-bit architectures. You can also install and run it on 64-bit Windows and Max OSX but these architectures are not regularly tested for compatibility.


.. Take a moment and identify the systems on your network that you intend to use. Ensure each node meets the requirements listed above.
