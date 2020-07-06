.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/security/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/security/index.md
   doc version: 19.03
.. check date: 2020/07/04
.. Commits on Oct 24, 2019 40747fcca7962ed58a8f5185d34619d35dd594ff
.. -------------------------------------------------------------------

.. Secure Engine

.. _secure-engine:

========================================
Engine を安全に
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3

.. This section discusses the security features you can configure and use within your Docker Engine installation.

このセクションは Docker Engine のセキュリティ機能や、インストール時の設定について扱います。

..    You can configure Docker’s trust features so that your users can push and pull trusted images. To learn how to do this, see Use trusted images in this section.

* トラステッド・イメージ（trusted image）を送受信できる機能を設定することで、Docker の信頼性を高めます。設定の詳細は :doc:`トラステッド・イメージを使う <trust/index>` をご覧ください。

..    You can protect the Docker daemon socket and ensure only trusted Docker client connections. For more information, Protect the Docker daemon socket

* Docker デーモン・ソケットを守り、確かなものとするには信頼された Docker クライアント接続を使います。詳細は :doc:`https` をご覧ください。

..    You can use certificate-based client-server authentication to verify a Docker daemon has the rights to access images on a registry. For more information, see Using certificates for repository client verification.

* 証明書をベースとするクライアント・サーバ認証を使えます。これは Docker デーモンがレジストリ上のイメージに対する適切なアクセス権があるかどうかを確認します。詳細は :doc:`certificates` をご覧ください。

..    You can configure secure computing mode (Seccomp) policies to secure system calls in a container. For more information, see Seccomp security profiles for Docker.

* セキュア・コンピューティング・モード（Seccomp）ポリシーを設定することで、コンテナ内のシステムコールを安全にします。詳細な情報は :doc:`seccomp` をご覧ください。

..    An AppArmor profile for Docker is installed with the official .deb packages. For information about this profile and overriding it, see AppArmor security profiles for Docker.

* 公式の .deb パッケージは、Docker 用の AppArmor プロファイルがインストールされます。プロファイルや更新方法は :doc:`apparmor` をご覧ください。

.. You can map the root user in the containers to a non-root user. See Isolate containers with a user namespace.

* ルート・ユーザ（root user）をコンテナ内の非ルート・ユーザ（non-root user）にマップできます。 :doc:`userns-remap` をご覧ください。

.. You can also run the Docker daemon as a non-root user. See Run the Docker daemon as a non-root user (Rootless mode).

* Docker デーモンを非ルート・ユーザとして実行できます。 :doc:`rootless` をご覧ください。

.. seealso:: 

   Secure Engine
      https://docs.docker.com/engine/security/
