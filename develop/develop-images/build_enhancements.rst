.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/develop-images/build_enhancements/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/develop/develop-images/build_enhancements.md
.. check date: 2020/06/20
.. Commits on Jun 16, 2020 3e767a72b3c48ecd23e1f734a27b7ca7b9cfc3f7
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

Docker Build は Docker Engine で最も使われる機能の１つです。利用者の幅は、利用者、開発チーム、リリースチーム、全てが Docker Build を使います。

.. Docker Build enhancements for 18.09 release introduces a much-needed overhaul of the build architecture. By integrating BuildKit, users should see an improvement on performance, storage management, feature functionality, and security.

18.09 のリリースで導入されたのは、構築アーキテクチャの見直しが非常に求められていた、 Docker Build の拡張です。BuildKit （ビルドキット）の統合により、性能、ストレージ管理、特徴的な機能性、セキュリティに関する改善が利用者に分かるでしょう。

..  Docker images created with BuildKit can be pushed to Docker Hub just like Docker images created with legacy build
    the Dockerfile format that works on legacy build will also work with BuildKit builds
    The new --secret command line option allows the user to pass secret information for building new images with a specified Dockerfile

* BuildKit が作成した Docker イメージは、以前のビルドが作成した Docker イメージ同様、 Docker Hub に送信可能です
* Dockerfile の形式は、以前の Build の動作と同様に、 BuitKit の構築でも動作します
* ユーザは Dockerfile で指定した新しいイメージの構築は、新しい ``--secret`` コマンドライン・オプションでシークレット（機微）情報をパスします（訳者注、イメージに記録しません）

.. For more information on build options, see the reference guide on the command line build options.

build オプションに関する詳しい情報は、リファレンスガイド上の :doc:`コマンドライン build オプション </engine/reference/commandline/build>` をご覧ください。

.. Requirements

必要条件
====================

..  A current version of Docker (18.09 or higher)
    Network connection required for downloading images of custom frontends

* Docker の最新版（18.09 以上）
* カスタム・フロントエンドのイメージをダウンロードするには、ネットワーク接続が必要

.. Limitations

制限事項
====================

..    Only supported for building Linux containers

* Linux コンテナの構築のみサポート

.. To enable BuildKit builds

.. _to-enable-buildkit-builds:

BuildKit での構築を有効化
==============================

.. Easiest way from a fresh install of docker is to set the DOCKER_BUILDKIT=1 environment variable when invoking the docker build command, such as:

Docker の新規インストールが最も簡単で、 ``docker build`` コマンドの実行時に ``DOCKER_BUILDKIT``` 環境変数を次のように指定します。

.. code-block:: bash

   $ DOCKER_BUILDKIT=1 docker build .

.. To enable docker BuildKit by default, set daemon configuration in /etc/docker/daemon.json feature to true and restart the daemon:

デフォルトで docker BuildKit を有効化するには、 ``/etc/docker/daemon.json`` のデーモン設定で機能を true にし、デーモンを再起動します。

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

新しい docker build BuildKit の簡易出力：

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

デフォルトのフロントエンドを上書きすると、 ``Dockerfile`` で新しい構文機能が利用可能です。デフォルトのフロントエンドを上書きするには、 ``Dockerfile`` の１行目に、特定のフロントエンド・イメージをコメントとして指定します。

::

   # syntax = <frontend image>, e.g. # syntax = docker/dockerfile:1.0-experimental


.. New Docker Build secret information

.. _new-docker-build-secret-information:

新しい Docker Build シークレット情報
========================================

.. The new --secret flag for docker build allows the user to pass secret information to be used in the Dockerfile for building docker images in a safe way that will not end up stored in the final image.

docker build の新しい ``--secret`` フラグは、Dockerfile でシークレット情報（機微情報）をユーザが渡す必要があるときに、docker イメージを安全に構築するための方法であり、最終イメージにシークレットを保存しません。

.. id is the identifier to pass into the docker build --secret. This identifier is associated with the RUN --mount identifier to use in the Dockerfile. Docker does not use the filename of where the secret is kept outside of the Dockerfile, since this may be sensitive information.

``id`` は ``docker build --secret`` を渡すための識別子です。この識別子は Dockerfile 中で使う ``RUN --mount`` 識別子と関連付けられます。この情報はセンシティブな情報となりうるため、Docker は secret がどこにあるかをファイル名を使わずに、Dockerfile の外で保持します。

.. dst renames the secret file to a specific file in the Dockerfile RUN command to use.

``dst``  はシークレット用のファイルを、 Dockerfile の ``RUN`` コマンドで使う特定のファイルに名称変更します。

.. For example, with a secret piece of information stored in a text file:

たとえば、テキストファイル中に秘密情報の一部を保存します。

.. code-block:: bash

   $ echo 'WARMACHINEROX' > mysecret.txt

.. And with a Dockerfile that specifies use of a BuildKit frontend docker/dockerfile:1.0-experimental, the secret can be accessed.

そして、Dockerfile 側では、Buildkit フロントエンド ``docker/dockerfile:1.0-experimental`` を使う指定をしたら、シークレット機能が利用できます。

.. For example:

例：

::

   # syntax = docker/dockerfile:1.0-experimental
   FROM alpine
   
   # デフォルトのシークレットの場所から、シークレットを表示
   RUN --mount=type=secret,id=mysecret cat /run/secrets/mysecret
   
   # 任意のシークレットの場所から、シークレットを表示
   RUN --mount=type=secret,id=mysecret,dst=/foobar cat /foobar

.. This Dockerfile is only to demonstrate that the secret can be accessed. As you can see the secret printed in the build output. The final image built will not have the secret file:

この Dockerfile はシークレットがアクセス可能であるというデモンストレーションです。ご覧の通り、シークレットは構築の出力で表示されます。最終イメージのビルドでは、このシークレット・ファイルを持ちません。

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

構築時に SSH でプライベート・データにアクセス
==================================================

..    Acknowledgment
    Please see Build secrets and SSH forwarding in Docker 18.09 for more information and examples.

.. seealso::

   `Build secrets and SSH forwarding in Docker 18.09 <https://medium.com/@tonistiigi/build-secrets-and-ssh-forwarding-in-docker-18-09-ae8161d066>`_ に詳しい情報と例がありますのでご覧ください。

.. The docker build has a --ssh option to allow the Docker Engine to forward SSH agent connections. For more information on SSH agent, see the OpenSSH man page.

``docker build`` で ``--ssh`` オプションを付けると、 Docker Engine は SSH エージェント接続の転送が可能になります。SSH エージェントに関する情報は `OpenSSH の man ページ <https://man.openbsd.org/ssh-agent>`_ をご覧ください。

.. Only the commands in the Dockerfile that have explicitly requested the SSH access by defining type=ssh mount have access to SSH agent connections. The other commands have no knowledge of any SSH agent being available.

``Dockerfile`` 中の命令で、 ``type=ssh`` マウントの定義で明確に SSH アクセスを要求すると、SSH エージェントとの接続が可能になります。その他の方法では、SSH エージェントと通信することはできません。

.. To request SSH access for a RUN command in the Dockerfile, define a mount with type ssh. This will set up the SSH_AUTH_SOCK environment variable to make programs relying on SSH automatically use that socket.

``Dockerfile`` 中で ``RUN`` コマンドで SSH アクセスの要求をするには、マウント時のタイプを ``ssh`` と定義します。これは ``SSH_AUTH_SOCK`` 環境変数をセットアップし、プログラムが SSH でそのソケットを自動的に使うのに依存します。

.. Here is an example Dockerfile using SSH in the container:

こちらはコンテナ内で SSH を使う Dockerfile の例です：

::

   # syntax=docker/dockerfile:experimental
   FROM alpine
   
   # ssh クライアントと git をインストール
   RUN apk add --no-cache openssh-client git
   
   # github.com のための公開鍵をダウンロード
   RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts
   
   # プライベート・リポジトリのクローン
   RUN --mount=type=ssh git clone git@github.com:myorg/myproject.git myproject

.. Once the Dockerfile is created, use the --ssh option for connectivity with the SSH agent.

``Dockerfile`` が作成されれば、 ``--ssh``  オプションを使ってで SSH エージェントと接続できます。

.. code-block:: bash

   $ docker build --ssh default .

.. Troubleshooting : issues with private registries

.. _troubleshooting-issues-with-private-registries:

トラブルシューティング：プライベート・レジストリでの問題
============================================================

.. x509: certificate signed by unknown authority

x509：未知の認証局によって書名された証明書
--------------------------------------------------

.. If you are fetching images from insecure registry (with self-signed certificates) and/or using such a registry as a mirror, you are facing a known issue in Docker 18.09 :

安全ではない（自己書名した証明書の）レジストリ（insecure registry）からイメージを取得しようとすると、あるいはレジストリをミラーとして使おうとすると、Docker 18.09 では以下の問題に直面します。

::

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

::

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
