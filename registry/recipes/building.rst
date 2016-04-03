.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/registry/building/
.. SOURCE: 
   doc version: 1.10
.. check date: 2016/03/30
.. -------------------------------------------------------------------

.. Building the registry source

==============================
レジストリをソースからビルド
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

使用例
==========

.. This is useful if you intend to actively work on the registry.

レジストリを活用したい場合に役立ちます。

あるいは
----------

.. Most people should use the official Registry docker image.

多くの皆さんは `公式 Registry Docker イメージ <https://hub.docker.com/r/library/registry/>`_ を使ったほうが良いでしょう。

.. People looking for advanced operational use cases might consider rolling their own image with a custom Dockerfile inheriting FROM registry:2.

高度な使い方を考えている皆さんであれば、 ``FROM registry:2`` 以降の Dockerfile をカスタマイズし、自分でイメージを作成したいと考えているかもしれません。

.. OS X users who want to run natively can do so following the instructions here.

OS X ユーザであれば :doc:`こちらの手順 <osx-setup-guide>` をご覧ください。

.. Gotchas

捕捉
----------

.. You are expected to know your way around with go & git.

既に Go 言語や git の使い方について理解している前提です。

.. If you are a casual user with no development experience, and no preliminary knowledge of go, building from source is probably not a good solution for you.

これまで開発経験のないカジュアルのユーザであり、Go 言語に関する予備知識が無いのであれば、ソースコードからビルドする方法は、あなたにとって適切ではないかもしれません。

.. Build the development environment

.. _build-the-development-environment:

開発環境の構築
====================

.. The first prerequisite of properly building distribution targets is to have a Go development environment setup. Please follow How to Write Go Code for proper setup. If done correctly, you should have a GOROOT and GOPATH set in the environment.

まず、利用環境に対して適切な Go 開発環境をセットアップする必要があります。適切なセットアップ方法は `Goコードの書き方（英語） <https://golang.org/doc/code.html>`_ をご覧ください。正しく終わったら、環境変数の GOROOT と GOPATH が設定されているでしょう。

.. If a Go development environment is setup, one can use go get to install the registry command from the current latest:

Go 開発環境をセットアップしたら、 ``go get`` コマンドを使って最新バージョンの ``registry`` をインストールします。

.. code-block:: bash

   go get github.com/docker/distribution/cmd/registry

.. The above will install the source repository into the GOPATH.

ソース・リポジトリから ``GOPATH`` にインストールします。

.. Now create the directory for the registry data (this might require you to set permissions properly)

次にレジストリ・データ用のディレクトリを作成します（パーミッションを適切に設定する必要があるでしょう）。

.. code-block:: bash

.. mkdir -p /var/lib/registry

.. … or alternatively ``export REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/somewhere`` if you want to store data into another location.

あるいは別の場所に保管したい場合は  ``export REGISTRY_STORAGE_FILESYSTEM_ROOTDIRECTORY=/somewhere`` を実行します。

.. The registry binary can then be run with the following:

レジストリのバイナリを以下の場所に設置します。

.. code-block:: bash

   $ $GOPATH/bin/registry --version
   $GOPATH/bin/registry github.com/docker/distribution v2.0.0-alpha.1+unknown

..    NOTE: While you do not need to use go get to checkout the distribution project, for these build instructions to work, the project must be checked out in the correct location in the GOPATH. This should almost always be $GOPATH/src/github.com/docker/distribution.

.. note::

   プロジェクトから ``go get`` でチェックアウトしなくても、ビルド手順は動くするでしょう。しかし、 ``GOPATH`` の適切な場所にプロジェクトがなければチェックアウトできません。通常は ``$GOPATH/src/github.com/docker/distribution`` です。

.. The registry can be run with the default config using the following incantation:

次の定型コマンドを実行すると、レジストリは標準のオプションで起動します。

.. code-block:: bash

   $ $GOPATH/bin/registry $GOPATH/src/github.com/docker/distribution/cmd/registry/config-example.yml
   INFO[0000] endpoint local-5003 disabled, skipping        app.id=34bbec38-a91a-494a-9a3f-b72f9010081f version=v2.0.0-alpha.1+unknown
   INFO[0000] endpoint local-8083 disabled, skipping        app.id=34bbec38-a91a-494a-9a3f-b72f9010081f version=v2.0.0-alpha.1+unknown
   INFO[0000] listening on :5000                            app.id=34bbec38-a91a-494a-9a3f-b72f9010081f version=v2.0.0-alpha.1+unknown
   INFO[0000] debug server listening localhost:5001

.. If it is working, one should see the above log messages.

動作しない場合は、ログメッセージの内容を確認すべきです。

.. Repeatable Builds

ビルドを繰り返す
--------------------

.. For the full development experience, one should cd into $GOPATH/src/github.com/docker/distribution. From there, the regular go commands, such as go test, should work per package (please see Developing if they don’t work).

完全な開発経験のためには、 ``cd`` で ``$GOPATH/src/github.com/docker/distribution`` に移動すべきです。ここから ``go test`` のような通常の ``go`` コマンドを実行しても、パッケージが動くでしょう。動かない場合は :ref:`registry-developing` をご覧ください。

.. A Makefile has been provided as a convenience to support repeatable builds. Please install the following into GOPATH for it to work:

繰り返しのビルドが便利になるように ``Makefile`` が提供されています。動作するためには ``GOPATH`` にインストールします。

.. code-block:: bash

   go get github.com/tools/godep github.com/golang/lint/golint

.. TODO(stevvooe): Add a make setup command to Makefile to run this. Have to think about how to interact with Godeps properly.

**TODO（原文ママ）** ``make setup`` コマンドを Makefile の実行時に追加。Godeps が適切に働くか考慮する必要がある。

.. Once these commands are available in the GOPATH, run make to get a full build:

``GOPATH`` でコマンドが実行可能であれば、 ``make`` によってビルドできます。

.. code-block:: bash


   $ GOPATH=`godep path`:$GOPATH make
   + clean
   + fmt
   + vet
   + lint
   + build
   github.com/docker/docker/vendor/src/code.google.com/p/go/src/pkg/archive/tar
   github.com/Sirupsen/logrus
   github.com/docker/libtrust
   ...
   github.com/yvasiyarov/gorelic
   github.com/docker/distribution/registry/handlers
   github.com/docker/distribution/cmd/registry
   + test
   ...
   ok    github.com/docker/distribution/digest 7.875s
   ok    github.com/docker/distribution/manifest 0.028s
   ok    github.com/docker/distribution/notifications  17.322s
   ?     github.com/docker/distribution/registry [no test files]
   ok    github.com/docker/distribution/registry/api/v2  0.101s
   ?     github.com/docker/distribution/registry/auth  [no test files]
   ok    github.com/docker/distribution/registry/auth/silly  0.011s
   ...
   + /Users/sday/go/src/github.com/docker/distribution/bin/registry
   + /Users/sday/go/src/github.com/docker/distribution/bin/registry-api-descriptor-template
   + binaries

.. The above provides a repeatable build using the contents of the vendored Godeps directory. This includes formatting, vetting, linting, building, testing and generating tagged binaries. We can verify this worked by running the registry binary generated in the “./bin” directory:

これは Godeps の指定したディレクトリでビルドする度に表示されるでしょう。ここには formatting 、 vetting 、 linting 、 building 、 testing 、generating とタグ付けされたバイナリが作成されています。生成されたバイナリが実行可能か確認するには ``./bin`` ディレクトリに移動します。

.. code-block:: bash

   $ ./bin/registry -version
   ./bin/registry github.com/docker/distribution v2.0.0-alpha.2-80-g16d8b2c.m

.. Developing

.. _registry-developing:

レジストリの開発
--------------------

.. The above approaches are helpful for small experimentation. If more complex tasks are at hand, it is recommended to employ the full power of godep.

上記の手法は小さな実験に役立つでしょう。より複雑なタスクをこなしたい場合は ``godep`` の力を使うことを推奨します。

.. The Makefile is designed to have its GOPATH defined externally. This allows one to experiment with various development environment setups. This is primarily useful when testing upstream bugfixes, by modifying local code. This can be demonstrated using godep to migrate the GOPATH to use the specified dependencies. The GOPATH can be migrated to the current package versions declared in Godeps with the following command:

Makefile は外部の定義 ``GOPATH`` に依存するよう設計されています。これは様々な環境にセットアップできるようにするためです。便利なのは、主にアップストリームのバグ修正のため、ローカルのコードを変更する場合です。そのためには ``godep`` を移行して ``GOPATH`` の依存関係を解決する必要があります。 ``Godeps`` の ``GOPATH``  にある現在の依存関係を解消するには、次のコマンドを実行します。

.. code-block:: bash

   godep restore

..    WARNING: This command will checkout versions of the code specified in Godeps/Godeps.json, modifying the contents of GOPATH. If this is undesired, it is recommended to create a workspace devoted to work on the Distribution project.

.. warning::

   このコマンドは Godeps/Godeps.json で指定されたコードに対してチェックアウトすると  ``GOPATH``  の中にあるファイルを編集します。そうしたくない場合は、分岐したプロジェクトで使うため、別のワークスペースを作成することを推奨します。

.. With a successful run of the above command, one can now use make without specifying the GOPATH:

上記のコマンドに成功すると、 ``GOPATH`` を指定せず ``make`` します。

.. code-block:: bash

    make

.. If that is successful, standard go commands, such as go test should work, per package, without issue.

成功すると ``go test`` のような通常の ``go`` コマンドをパッケージごとに実行しても、問題無く動作するでしょう。


.. Optional build tags

.. _optional-build-tags:

build tag のオプション
------------------------------

.. Optional build tags can be provided using the environment variable DOCKER_BUILDTAGS.

オプションの `build tags <http://golang.org/pkg/go/build/>`_ は環境変数 ``DOCKER_BUILDTAGS`` で指定できます。

.. To enable the Ceph RADOS storage driver (librados-dev and librbd-dev will be required to build the bindings):

`Ceph RADOS ストレージ・ドライバ <https://docs.docker.com/registry/storage-drivers/rados/>`_ を有効にするには（ librados-dev と librdb-dev がビルド時に必要となります）、次のように実行します。

.. code-block:: bash

   export DOCKER_BUILDTAGS='include_rados'

.. seealso:: 

   Building the registry source
      https://docs.docker.com/registry/building/


