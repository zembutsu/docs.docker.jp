.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/develop-images/build_enhancements/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/develop/develop-images/build_enhancements.md
.. check date: 2022/04/25
.. Commits on Feb 18, 2022 0508c664d23d9d28d8f07f8d8b0d2422242400e4
.. -----------------------------------------------------------------------------

.. Build images with BuildKit
.. _build-images-with-buildkit:

=======================================
BuildKit でイメージ構築
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Build is one of the most used features of the Docker Engine - users ranging from developers, build teams, and release teams all use Docker Build.

Docker Build は Docker Engine で最も使われる機能の１つです。利用者、開発チーム、リリースチームに至る利用者の全てが Docker Build を使います。

.. Docker Build enhancements for 18.09 release introduces a much-needed overhaul of the build architecture. By integrating BuildKit, users should see an improvement on performance, storage management, feature functionality, and security.

リリース 18.09 では、強く求められていた構築方式が見直され、 Docker Build の拡張が導入されました。利用者は :ruby:`BuildKit <ビルドキット>` との統合により、性能、ストレージ管理、際立つ機能性、セキュリティの改善を目の当たりにするでしょう。

..  Docker images created with BuildKit can be pushed to Docker Hub just like Docker images created with legacy build
    the Dockerfile format that works on legacy build will also work with BuildKit builds
    The new --secret command line option allows the user to pass secret information for building new images with a specified Dockerfile

* BuildKit が作成した Docker イメージは、これまでの構築で作成した Docker イメージ同様、 Docker Hub に送信可能
* Dockerfile の書式は、従来の構築用だけでなく、 BuitKit による構築でも動作
* Dockerfile で新しいイメージの構築時、新しい ``--secret`` コマンドライン オプションを使えば、 :ruby:`機微情報 <secret>` （シークレット）を（コマンドライン上で）渡せるようになる

.. For more information on build options, see the reference guide on the command line build options and the Dockerfile reference page.

.. For more information on build options, see the reference guide on the command line build options.

build オプションに関する詳しい情報は、リファレンスガイド上の :doc:`コマンドライン build オプション </engine/reference/commandline/build>` と :doc:`Dockerfile リファレンス ページ </engine/reference/builder>` をご覧ください。

.. Requirements

動作条件
====================

..  A current version of Docker (18.09 or higher)
    Network connection required for downloading images of custom frontends

* Docker の最新版（18.09 以上）
* 任意のフロントエンドからイメージをダウンロードするには、ネットワーク接続が必要

.. Limitations

制限事項
====================

..    Only supported for building Linux containers

* Linux コンテナの構築のみサポート

.. To enable BuildKit builds
.. _to-enable-buildkit-builds:

BuildKit での構築を有効化するには
==================================================

.. Easiest way from a fresh install of docker is to set the DOCKER_BUILDKIT=1 environment variable when invoking the docker build command, such as:

Docker の新規インストールが最も簡単で、 ``docker build`` コマンドの実行時に ``DOCKER_BUILDKIT``` 環境変数を次のように指定します。

.. code-block:: bash

   $ DOCKER_BUILDKIT=1 docker build .

.. To enable docker BuildKit by default, set daemon configuration in /etc/docker/daemon.json feature to true and restart the daemon:

デフォルトで docker BuildKit を有効化するには、 ``/etc/docker/daemon.json`` にあるデーモンの設定で、（buildkit の）機能を true にしてから、デーモンを再起動します。

::

    { "features": { "buildkit": true } }

.. New Docker Build command line build output
.. _new-docker-build-command-line-build-output:

新しい Docker Build コマンドラインによる構築の出力
==================================================

.. New docker build BuildKit TTY output (default):

新しい docker build BuildKit TTY 出力（デフォルト）：

.. code-block:: bash

   $ docker build . 
   
   [+] Building 70.9s (34/59)                                                      
    => [runc 1/4] COPY hack/dockerfile/install/install.sh ./install.sh       14.0s
    => [frozen-images 3/4] RUN /download-frozen-image-v2.sh /build  buildpa  24.9s
    => [containerd 4/5] RUN PREFIX=/build/ ./install.sh containerd           37.1s
    => [tini 2/5] COPY hack/dockerfile/install/install.sh ./install.sh        4.9s
    => [vndr 2/4] COPY hack/dockerfile/install/vndr.installer ./              1.6s
    => [dockercli 2/4] COPY hack/dockerfile/install/dockercli.installer ./    5.9s
    => [proxy 2/4] COPY hack/dockerfile/install/proxy.installer ./           15.7s
    => [tomlv 2/4] COPY hack/dockerfile/install/tomlv.installer ./           12.4s
    => [gometalinter 2/4] COPY hack/dockerfile/install/gometalinter.install  25.5s
    => [vndr 3/4] RUN PREFIX=/build/ ./install.sh vndr                       33.2s
    => [tini 3/5] COPY hack/dockerfile/install/tini.installer ./              6.1s
    => [dockercli 3/4] RUN PREFIX=/build/ ./install.sh dockercli             18.0s
    => [runc 2/4] COPY hack/dockerfile/install/runc.installer ./              2.4s
    => [tini 4/5] RUN PREFIX=/build/ ./install.sh tini                       11.6s
    => [runc 3/4] RUN PREFIX=/build/ ./install.sh runc                       23.4s
    => [tomlv 3/4] RUN PREFIX=/build/ ./install.sh tomlv                      9.7s
    => [proxy 3/4] RUN PREFIX=/build/ ./install.sh proxy                     14.6s
    => [dev 2/23] RUN useradd --create-home --gid docker unprivilegeduser     5.1s
    => [gometalinter 3/4] RUN PREFIX=/build/ ./install.sh gometalinter        9.4s
    => [dev 3/23] RUN ln -sfv /go/src/github.com/docker/docker/.bashrc ~/.ba  4.3s
    => [dev 4/23] RUN echo source /usr/share/bash-completion/bash_completion  2.5s
    => [dev 5/23] RUN ln -s /usr/local/completion/bash/docker /etc/bash_comp  2.1s

.. New docker build BuildKit plain output:

新しい docker build BuildKit による、そのままの出力。

.. code-block:: bash

   $ docker build --progress=plain . 
   
   #1 [internal] load .dockerignore
   #1       digest: sha256:d0b5f1b2d994bfdacee98198b07119b61cf2442e548a41cf4cd6d0471a627414
   #1         name: "[internal] load .dockerignore"
   #1      started: 2018-08-31 19:07:09.246319297 +0000 UTC
   #1    completed: 2018-08-31 19:07:09.246386115 +0000 UTC
   #1     duration: 66.818µs
   #1      started: 2018-08-31 19:07:09.246547272 +0000 UTC
   #1    completed: 2018-08-31 19:07:09.260979324 +0000 UTC
   #1     duration: 14.432052ms
   #1 transferring context: 142B done
   
   
   #2 [internal] load Dockerfile
   #2       digest: sha256:2f10ef7338b6eebaf1b072752d0d936c3d38c4383476a3985824ff70398569fa
   #2         name: "[internal] load Dockerfile"
   #2      started: 2018-08-31 19:07:09.246331352 +0000 UTC
   #2    completed: 2018-08-31 19:07:09.246386021 +0000 UTC
   #2     duration: 54.669µs
   #2      started: 2018-08-31 19:07:09.246720773 +0000 UTC
   #2    completed: 2018-08-31 19:07:09.270231987 +0000 UTC
   #2     duration: 23.511214ms
   #2 transferring dockerfile: 9.26kB done

.. Overriding default frontends

.. _overriding-default-frontends:
デフォルトのフロントエンドを上書き
========================================

.. The new syntax features in Dockerfile are available if you override the default frontend. To override the default frontend, set the first line of the Dockerfile as a comment with a specific frontend image:

 ``Dockerfile`` では、デフォルトのフロントエンドを上書きする、新しい構文機能が利用可能です。デフォルトのフロントエンドを上書きするには、 ``Dockerfile`` の１行目で、コメント文として特定のフロントエンド イメージを指定します。

::

   # syntax=<frontend image>, e.g. # syntax=docker/dockerfile:1.2

.. The examples on this page use features that are available in docker/dockerfile version 1.2.0 and up. We recommend using docker/dockerfile:1, which always points to the latest release of the version 1 syntax. BuildKit automatically checks for updates of the syntax before building, making sure you are using the most current version. Learn more about the syntax directive in the Dockerfile reference.

このページの例では、 ``docker/dockerfile`` バージョン 1.2.0 以上で利用可能な機能を使います。ですが、私たちは ``docker/dockerfile:1``  の利用を推奨します。こちらであれば、常にバージョン１構文の最新リリースを示すからです。BuildKit は構築前に構文の更新を自動的に確認し、最新の安定バージョンを使っているかどうかを常に確認します。 ``syntax`` 命令について学ぶには、 :ref:`Dockerfile リファレンス <builder-syntax>` をご覧ください。


.. New Docker Build secret information
.. _new-docker-build-secret-information:

Docker Build の新しいシークレット情報
========================================

.. The new --secret flag for docker build allows the user to pass secret information to be used in the Dockerfile for building docker images in a safe way that will not end up stored in the final image.

docker build の新しい ``--secret`` フラグは、利用者が Dockerfile で :ruby:`シークレット <secret>` 情報（機微情報）を渡す必要があるときに、docker イメージを安全に構築するための方法であり、最終イメージに機微情報を保存しません。

.. id is the identifier to pass into the docker build --secret. This identifier is associated with the RUN --mount identifier to use in the Dockerfile. Docker does not use the filename of where the secret is kept outside of the Dockerfile, since this may be sensitive information.

``id`` とは、 ``docker build --secret`` で（シークレットを）渡すための :ruby:`識別子 <identifier>` です。この識別子は Dockerfile 中で使う ``RUN --mount`` 識別子と関連付けられます。これは、 Dockerfile の外で持つシークレットがどこにあるのかは、ファイル名が機微情報になり得るため、Docker ではファイル名を（直接）扱いません。

.. dst renames the secret file to a specific file in the Dockerfile RUN command to use.

Dockerfile 内の ``RUN`` コマンドの使用時に、シークレット ファイルを ``dest`` で指定するファイルに名称変更します。

.. For example, with a secret piece of information stored in a text file:

たとえば、機微情報の一部をテキストファイル中に保存します。

.. code-block:: bash

   $ echo 'WARMACHINEROX' > mysecret.txt

.. And with a Dockerfile that specifies use of a BuildKit frontend docker/dockerfile:1.2, the secret can be accessed when performing a RUN:

.. And with a Dockerfile that specifies use of a BuildKit frontend docker/dockerfile:1.0-experimental, the secret can be accessed.

そして、Dockerfile 側では、Buildkit フロントエンド ``docker/dockerfile:1.2`` を使う指定をすると、 ``RUN`` 命令の処理時にシークレットを利用できます。

.. code-block:: dockerfile

   # syntax = docker/dockerfile:1.2
   
   FROM alpine
   
   # デフォルトのシークレットの場所から、シークレットを表示
   RUN --mount=type=secret,id=mysecret cat /run/secrets/mysecret
   
   # 任意のシークレットの場所から、シークレットを表示
   RUN --mount=type=secret,id=mysecret,dst=/foobar cat /foobar

.. The secret needs to be passed to the build using the --secret flag. This Dockerfile is only to demonstrate that the secret can be accessed. As you can see the secret printed in the build output. The final image built will not have the secret file:

シークレットを使うには、構築時に ``--secret`` フラグを使って渡す必要があります。この Dockerfile はシークレットがアクセス可能であるという実証用途です。ご覧の通り、シークレットは構築時の出力で表示されます。最終イメージの構築では、このシークレット・ファイルを（イメージ内に）保持しません。

.. code-block:: bash

   $ docker build --no-cache --progress=plain --secret id=mysecret,src=mysecret.txt .
   ...
   #8 [2/3] RUN --mount=type=secret,id=mysecret cat /run/secrets/mysecret
   #8       digest: sha256:5d8cbaeb66183993700828632bfbde246cae8feded11aad40e524f54ce7438d6
   #8         name: "[2/3] RUN --mount=type=secret,id=mysecret cat /run/secrets/mysecret"
   #8      started: 2018-08-31 21:03:30.703550864 +0000 UTC
   #8 1.081 WARMACHINEROX
   #8    completed: 2018-08-31 21:03:32.051053831 +0000 UTC
   #8     duration: 1.347502967s
   
   
   #9 [3/3] RUN --mount=type=secret,id=mysecret,dst=/foobar cat /foobar
   #9       digest: sha256:6c7ebda4599ec6acb40358017e51ccb4c5471dc434573b9b7188143757459efa
   #9         name: "[3/3] RUN --mount=type=secret,id=mysecret,dst=/foobar cat /foobar"
   #9      started: 2018-08-31 21:03:32.052880985 +0000 UTC
   #9 1.216 WARMACHINEROX
   #9    completed: 2018-08-31 21:03:33.523282118 +0000 UTC
   #9     duration: 1.470401133s
   ...

.. Using SSH to access private data in builds
.. _using-ssh-to-access-private-data-in-builds:

構築時に SSH で :ruby:`内部データ <private date>` にアクセス
============================================================

..    Acknowledgment
    Please see Build secrets and SSH forwarding in Docker 18.09 for more information and examples.

.. seealso::

   `Build secrets and SSH forwarding in Docker 18.09 <https://medium.com/@tonistiigi/build-secrets-and-ssh-forwarding-in-docker-18-09-ae8161d066>`_ に詳しい情報と例がありますのでご覧ください。

.. Some commands in a Dockerfile may need specific SSH authentication - for example, to clone a private repository. Rather than copying private keys into the image, which runs the risk of exposing them publicly, docker build provides a way to use the host system’s ssh access while building the image.

``Dockerfile`` 内のコマンドによっては、プライベート リポジトリをクローンするような、 SSH 認証の指定が必要となる場合があります。秘密鍵をイメージにコピーしてしまうと、一般公開してしまう危険性があります。コピーするのではなく、 ``docker build`` でイメージの構築時に、ホストシステム上の ssh へのアクセスする方法があります。

.. There are three steps to this process.

この手順には、３つの過程があります。

.. First, run ssh-add to add private key identities to the authentication agent. If you have more than one SSH key and your default id_rsa is not the one you use for accessing the resources in question, you’ll need to add that key by path: ssh-add ~/.ssh/<some other key>. (For more information on SSH agent, see the OpenSSH man page.)

１番目は、 ``ssh-add`` を実行し、認証エージェントに対して秘密鍵（identity）を追加します。もしも複数の SSH 鍵があり、デフォルトの ``id_rsa`` でリソースにアクセスできるかどうか疑わしい場合は、 ``ssh-add ~/.ssh/<他の何らかの鍵>`` で鍵のパスを追加する必要があります（SSH エージェントの詳しい情報は、 `OpenSSH の man ページ <https://man.openbsd.org/ssh-agent>`_ をご覧ください。）。

.. Second, when running docker build, use the --ssh option to pass in an existing SSH agent connection socket. For example, --ssh default=$SSH_AUTH_SOCK, or the shorter equivalent, --ssh default.

２番目は、 ``docker build`` コマンドの実行時、 ``--ssh`` オプションを使い、既存の SSH エージェントへ接続するソケットを指定します。たとえば、 ``--ssh default=$SSH_AUTH_SOCK`` や、同等の省略形の ``--ssh default`` です。

.. Third, to make use of that SSH access in a RUN command in the Dockerfile, define a mount with type ssh. This will set the SSH_AUTH_SOCK environment variable for that command to the value provided by the host to docker build, which will cause any programs in the RUN command which rely on SSH to automatically use that socket. Only the commands in the Dockerfile that have explicitly requested SSH access by defining type=ssh mount will have access to SSH agent connections. The other commands will have no knowledge of any SSH agent being available.

３番目は、その SSH アクセスを ``Dockerfile`` 内の ``RUN`` 命令で使えるようにするため、 ``ssh`` タイプとしてマウントを定義します。これにより、 ``docker build`` 時にホスト上で提供された値が  ``SSH_AUTH_SOCK`` 環境変数に指定され、結果として ``RUN`` 命令内のあらゆるプログラムが、SSH で自動的にそのソケットを使うよう依存します。``type=ssh`` マウントの定義があれば、 SSH アクセスを明示的に要求する ``Dockerfile`` 内のコマンドのみが、SSH エージェントへ接続できます。他のコマンドは、どのような SSH エージェントが利用可能かどうかを一切知りません。

.. Here is an example Dockerfile using SSH in the container:

こちらはコンテナ内で SSH を使う ``Dockerfile`` の例です：

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   FROM alpine
   
   # ssh クライアントと git をインストール
   RUN apk add --no-cache openssh-client git
   
   # github.com のための公開鍵をダウンロード
   RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
   
   # プライベート・リポジトリのクローン
   RUN --mount=type=ssh git clone git@github.com:myorg/myproject.git myproject

.. The image could be built as follows:

イメージの構築は、以下のようにします。

.. code-block:: bash

   $ docker build --ssh default .

.. As with --mount=type=secret, you can specify an id if you want to use multiple sockets per build and want to differentiate them. For example, you could run docker build --ssh main=$SSH_AUTH_SOCK --ssh other=$OTHER_SSH_AUTH_SOCK. In your Dockerfile, you could then have a RUN --mount=type=ssh,id=main and a RUN --mount=type=ssh,id=other to use those two sockets. If a --mount=type=ssh doesn’t specify an id, default is assumed.


``--mount=type=secret`` と同様、構築するたびに複数のソケットを使い分けたい場合には、 ``id`` を指定できます。たとえば、 ``docker build --ssh main=$SSH_AUTH_SOCK --ssh other=$OTHER_SSH_AUTH_SOCK`` のように実行できます。 ``Dockerfile`` 内で、これら２つのソケットを使うには ``RUN --mount=type=ssh,id=main`` か ``RUN --mount=type=ssh,id=other`` とします。もしも ``--mount=type=ssh`` のように ``id`` を指定しなければ、 ``default`` が想定されます。

.. Troubleshooting : issues with private registries
.. _troubleshooting-issues-with-private-registries:

トラブルシューティング：プライベート・レジストリでの問題
============================================================

.. x509: certificate signed by unknown authority

x509：未知の認証局によって書名された証明書
--------------------------------------------------

.. If you are fetching images from insecure registry (with self-signed certificates) and/or using such a registry as a mirror, you are facing a known issue in Docker 18.09 :

（自己書名した証明書を使う） :ruby:`安全ではない レジストリ <insecure registry>` からイメージを取得しようとすると、あるいはレジストリをミラーとして使おうとすると、Docker 18.09 では以下の問題に直面します。

.. code-block:: bash

   [+] Building 0.4s (3/3) FINISHED
    => [internal] load build definition from Dockerfile
    => => transferring dockerfile: 169B
    => [internal] load .dockerignore
    => => transferring context: 2B
    => ERROR resolve image config for docker.io/docker/dockerfile:experimental
   ------
    > resolve image config for docker.io/docker/dockerfile:experimental:
   ------
   failed to do request: Head https://repo.mycompany.com/v2/docker/dockerfile/manifests/experimental: x509: certificate signed by unknown authority

.. Solution : secure your registry properly. You can get SSL certificates from Let’s Encrypt for free. See /registry/deploying/

解決策：適切にレジストリを安全にします。 Let's Encrypt の SSL 証明書は無料で取得できます。 :doc:`/registry/deploying` をご覧ください。

.. image not found when the private registry is running on Sonatype Nexus version < 3.15
.. _image-not-found-when-the-private-registry-is-running-on-sonatype:

Sonatype Nexus バージョン 3.15 未満の上でプライベート・レジストリを実行中に、イメージが見つからない
----------------------------------------------------------------------------------------------------

.. If you are running a private registry using Sonatype Nexus version < 3.15, and receive an error similar to the following :

Sonatype Nexus バージョン 3.15 未満を使い、プライベート・レジストリを事項中であれば、以下のようなエラーメッセージが表示されるでしょう。

.. code-block:: bash

   ------
    > [internal] load metadata for docker.io/library/maven:3.5.3-alpine:
   ------
   ------
    > [1/4] FROM docker.io/library/maven:3.5.3-alpine:
   ------
   rpc error: code = Unknown desc = docker.io/library/maven:3.5.3-alpine not found

.. you may be facing the bug below : NEXUS-12684

おそらくこのバグに直面しました： `NEXUS-12684 <https://issues.sonatype.org/browse/NEXUS-12684>`_

.. Solution is to upgrade your Nexus to version 3.15 or above.

解決策は、Nexus をバージョン 3.15 以上にアップグレードします。

.. seealso:: 

   Build images with BuildKit
      https://docs.docker.com/develop/develop-images/build_enhancements/
