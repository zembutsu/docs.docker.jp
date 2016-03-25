.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/configure-tls/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/configure-tls.md
   doc version: 1.10
      https://github.com/docker/swarm/commits/master/docs/configure-tls.md
.. check date: 2016/03/10
.. Commits on Feb 7, 2016 c7eb7ee52f73cb8249ec7eba73c0c05dcbbd720d
.. -------------------------------------------------------------------

.. Configure Docker Swarm for TLS

.. _configure-docker-swarm-for-tls:

Docker Swarm の TLS 設定
==============================

.. In this procedure you create a two-node Swarm cluster, a Docker Engine CLI, a Swarm Manager, and a Certificate Authority as shown below. All the Docker Engine hosts (client, swarm, node1, and node2) have a copy of the CA’s certificate as well as their own key-pair signed by the CA.

この手順では下図のように、 Swarm クラスタに２つのノードを作成し、Swarm マネージャ、認証局をします。全ての Docker Engine ホスト（ ``client`` 、 ``swarm`` 、 ``node1``  、 ``node2``  ）は、認証局の証明書のコピーと、自分自身で認証局の署名をしたキーペアのコピーも持ちます。

. image:: ./images/tls-1.png
   :scale: 60%

以下の手順で作業を進めていきます。

* :ref:`step-1-set-up-the-prerequisites`
* :ref:`step-2-create-a-certificate-authority-ca-server`
* :ref:`step-3-create-and-sign-keys`
* :ref:`step-4-install-the-keys`
* :ref:`step-5-configure-the-engine-daemon-for-tls`
* :ref:`step-6-create-a-swarm-cluster`
* :ref:`step-7-create-the-swarm-manager-using-tls`
* :ref:`step-8-test-the-swarm-manager-configuration`
* :ref:`step-9-configure-the-engine-cli-to-use-tls`

.. Before you begin

始める前に
==========

.. The article includes steps to create your own CA using OpenSSL. This is similar to operating your own internal corporate CA and PKI. However, this must not be used as a guide to building a production-worthy internal CA and PKI. These steps are included for demonstration purposes only - so that readers without access to an existing CA and set of certificates can follow along and configure Docker Swarm to use TLS.

この記事には OpenSSL で自分自身で認証局(CA)を作成する手順を含みます。これは簡単な社内の認証局や PKI と似ています。しかしながら、プロダクション級の内部の認証局・PKI としては ``使うべきではありません`` 。以降の手順は検証用（デモンストレーション）目的のみです。つまり、皆さんが既に適切な証明局や証明書をお持ちであれば、Docker Swarm で TLS を利用する際には置き換えてお読みください。

.. _step-1-set-up-the-prerequisites:

.. Step 1: Set up the prerequisites

ステップ１：動作環境のセットアップ
========================================

(ToDo)
https://docs.docker.com/swarm/configure-tls/

.. _step-2-create-a-certificate-authority-ca-server:



.. _step-3-create-and-sign-keys:


.. _step-4-install-the-keys:


.. _step-5-configure-the-engine-daemon-for-tls:


.. _step-6-create-a-swarm-cluster:


.. _step-7-create-the-swarm-manager-using-tls:


.. _step-8-test-the-swarm-manager-configuration:


.. _step-9-configure-the-engine-cli-to-use-tls:


.. seealso::

   Configure Docker Swarm for TLS
      https://docs.docker.com/swarm/configure-tls/
