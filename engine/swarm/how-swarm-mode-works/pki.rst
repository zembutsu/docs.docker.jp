.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/how-swarm-mode-works/pki/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/how-swarm-mode-works/services.md
   doc version: 20.10
.. check date: 2022/04/29
.. Commits on Jan 26, 2018 a4f5e3024919b0bbfe294e0a4e65b7b6e09c487e
.. -----------------------------------------------------------------------------

.. Manage swarm security with public key infrastructure (PKI)

.. _manage-swarm-security-with-public-key-infrastructure-pki:

==================================================
swarm セキュリティを公開鍵暗号基盤 [PKI] で管理
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The swarm mode public key infrastructure (PKI) system built into Docker makes it simple to securely deploy a container orchestration system. The nodes in a swarm use mutual Transport Layer Security (TLS) to authenticate, authorize, and encrypt the communications with other nodes in the swarm.

swarm モードの公開鍵暗号基盤（PKI）システムは Docker に組み込まれおり、コンテナのオーケストレーション・システムの安全なデプロイを簡単にします。swarm 内のノードは共通の TLS （トランスポート・レイヤー・セキュリティ）を使い、認証、権限付与、他のノートとの暗号化通信を行います。

.. When you create a swarm by running docker swarm init, Docker designates itself as a manager node. By default, the manager node generates a new root Certificate Authority (CA) along with a key pair, which are used to secure communications with other nodes that join the swarm. If you prefer, you can specify your own externally-generated root CA, using the --external-ca flag of the docker swarm init command.

``docker swarm init`` を実行して swarm を作成すると、 Docker は自分自身を manager ノードに指定します。デフォルトでは、 manager ノードは新しいルート認証局（CA）をキーペア（key pair）と共に作成します。これらは swarm に参加する他のノード間で安全に通信するために使います。もしも希望するのであれば、外部で生成した自身のルート CA を指定するためい、 :doc:`docker swarm init </engine/reference/commandline/swarm_init>` で ``--external-ca`` フラグを使います。

.. The manager node also generates two tokens to use when you join additional nodes to the swarm: one worker token and one manager token. Each token includes the digest of the root CA’s certificate and a randomly generated secret. When a node joins the swarm, the joining node uses the digest to validate the root CA certificate from the remote manager. The remote manager uses the secret to ensure the joining node is an approved node.

また、manager ノードは swarm にノードが参加するために使う2つのトークンを作成します。1つは **woker トークン** で、もう1つは **manager トークン** です。各トークンには root CA 証明書の digest とランダムに生成したシークレット（secret）を含みます。swarm にノードが参加する時、参加するノードはリモートの manager からの root CA 証明書を確認するために digest を使います。リモートの manager はシークレットを使い、参加を試みているノードに対して、ノードとしての承認を与えます。

.. Each time a new node joins the swarm, the manager issues a certificate to the node. The certificate contains a randomly generated node ID to identify the node under the certificate common name (CN) and the role under the organizational unit (OU). The node ID serves as the cryptographically secure node identity for the lifetime of the node in the current swarm.

swarm に新しいノードが参加するたびに、 manager はノードに対して証明書を発行します。この証明書には、認証コモン・ネーム（CN）と organization unit（ON）の下に、役割を識別するためのランダムに生成した ノード ID を含みます。このノード ID の役目は、現在の swarm において、ノードが生存し続ける限り、暗号化して安全にノードを識別するためです。

.. The diagram below illustrates how manager nodes and worker nodes encrypt communications using a minimum of TLS 1.2.

下図は manager ノードと worker ノードが最小の TLS 1.2 を使ってどのように暗号化通信するかを示します。

.. tls diagram
.. image:: /engine/swarm/images/tls.png
   :alt: tls の図

.. The example below shows the information from a certificate from a worker node:

以下の例は worker ノードにおける証明書の情報を表示したものです。

::

   Certificate:
       Data:
           Version: 3 (0x2)
           Serial Number:
               3b:1c:06:91:73:fb:16:ff:69:c3:f7:a2:fe:96:c1:73:e2:80:97:3b
           Signature Algorithm: ecdsa-with-SHA256
           Issuer: CN=swarm-ca
           Validity
               Not Before: Aug 30 02:39:00 2016 GMT
               Not After : Nov 28 03:39:00 2016 GMT
           Subject: O=ec2adilxf4ngv7ev8fwsi61i7, OU=swarm-worker, CN=dw02poa4vqvzxi5c10gm4pq2g
   ...snip...

.. By default, each node in the swarm renews its certificate every three months. You can configure this interval by running the docker swarm update --cert-expiry <TIME PERIOD> command. The minimum rotation value is 1 hour. Refer to the docker swarm update CLI reference for details.

デフォルトでは、 swarm 内の各ノードは3ヶ月ごとに証明書を更新します。この期間は ``docker swarm update --cert-expiry <間隔>`` のコマンドで調整できます。最小のローテート時間は1時間です。詳細は :doc:`docker swarm update </engine/reference/commandline/swarm_update>` コマンドライン・リファレンスをご覧ください。

.. Rotating the CA certificate

CA 証明書のローテート
==============================

.. In the event that a cluster CA key or a manager node is compromised, you can rotate the swarm root CA so that none of the nodes trust certificates signed by the old root CA anymore.

クラスタ CA キーや manager ノードで障害が発生する事態になったら、自分で swarm ルート CA をローテートできますので、古いルート CA によって書名された証明書を、一切信頼しないようにできます。

.. Run docker swarm ca --rotate to generate a new CA certificate and key. If you prefer, you can pass the --ca-cert and --external-ca flags to specify the root certificate and to use a root CA external to the swarm. Alternately, you can pass the --ca-cert and --ca-key flags to specify the exact certificate and key you would like the swarm to use.

新しい CA 証明書とキーを作成するには、 ``docker swarm ca --rotate`` を実行します。希望する場合は、 swarm 外部のルート証明書やルート CA を使うため ``--ca-cert`` と ``--external-ca`` フラグを使えます。あるいは、 ``--ca-cert`` と ``--ca-key`` フラグを使い、swarm で使いたい証明書と鍵を指定できます。

.. When you issue the docker swarm ca --rotate command, the following things happen in sequence:

``docker swarm ca --rotate`` コマンドを実行すると、順番に以下の処理が進みます。

..    Docker generates a cross-signed certificate. This means that a version of the new root CA certificate is signed with the old root CA certificate. This cross-signed certificate is used as an intermediate certificate for all new node certificates. This ensures that nodes that still trust the old root CA can still validate a certificate signed by the new CA.

1. Docker はクロス書名証明書（cross-signed certificate）を生成します。これは、新しいルート CA 証明書のバージョンは、古いルート CA 証明書によって書名されているということを意味します。クロス書名証明書は、新しい全てのノード証明書に対する中間証明書として用います。これにより、ノードは古い CA によって確実に信頼されているだけなく、新しい CA によって署名された証明書も有効であるとも確認できます。

..    In Docker 17.06 and higher, Docker also tells all nodes to immediately renew their TLS certificates. This process may take several minutes, depending on the number of nodes in the swarm.

2. Docker 17.06 以降では、 Docker もまた全ノードに対して直ちに更新した TLS 証明書を伝えられます。この処理は swarm 内のノード数に依存し、数分かかる場合があります。

   ..        Note: If your swarm has nodes with different Docker versions, the following two things are true:
            Only a manager that is running as the leader and running Docker 17.06 or higher tells nodes to renew their TLS certificates.
            Only nodes running Docker 17.06 or higher obey this directive.

   .. note::
   
      もしも swarm ノードの Docker バージョンが異なる場合は、以下2つのことが真になります。
      
      * manager のみが leader として稼働し、 **かつ** 、Docker 17.06 以上で動作中は、ノードに対して更新した TLS 証明書を伝達する
      * ノードのみが Docker 17.06 以上で動作中は、その命令に従う
      
      ..        For the most predictable behavior, ensure that all swarm nodes are running Docker 17.06 or higher.
      
      最も予想できうる挙動は、全ての swarm ノードを Docker 17.06 以上で確実に稼働することです。

..    After every node in the swarm has a new TLS certificate signed by the new CA, Docker forgets about the old CA certificate and key material, and tells all the nodes to trust the new CA certificate only.

3. swarm 内の全てのノードが、新しい CA によって書名された新しい TLS 証明書に切り替わり後、Docker は古い CA 証明書とキーの要素を忘れ、全てのノードに対して信頼できる CA 証明書のみを伝えます。

   ..    This also causes a change in the swarm’s join tokens. The previous join tokens are no longer valid.

   これにより、 swarm への参加（join）トークンも変更になります。以前の参加トークンは以後一切無効です。

.. From this point on, all new node certificates issued are signed with the new root CA, and do not contain any intermediates.

以上の手順で、新しいノード証明書が新しいルート CA によって書名および発行され、あらゆる中間物を含みません。

.. Learn More

さらに学ぶ
====================

..  Read about how nodes work.
    Learn how swarm mode services work.

* :doc:`ノード <nodes>` の挙動について学ぶ
* swarm mode の :doc:`サービス <services>` の挙動について学ぶ

.. seealso:: 

   Manage swarm security with public key infrastructure (PKI)
      https://docs.docker.com/engine/swarm/how-swarm-mode-works/pki/
