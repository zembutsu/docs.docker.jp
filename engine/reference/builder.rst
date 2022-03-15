.. -*- coding: utf-8 -*-:
.. URL: https://docs.docker.com/engine/reference/builder/
.. SOURCE: https://github.com/docker/cli/blob/master/docs/reference/builder.md
   doc version: 20.10
.. check date: 2021/07/09
.. Commits on May 5, 2021 782192a6e50bacd73dcd2e9f9128f1708435b555
.. -------------------------------------------------------------------

.. Dockerfile reference

=======================================
Dockerfile リファレンス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build users can create an automated build that executes several command-line instructions in succession.

Docker は ``Dockerfile`` から命令を読み込み、自動的にイメージをビルドできます。 ``Dockerfile`` はテキストファイルであり、イメージを作り上げるために実行するコマンドライン命令を、すべてこのファイルに含められます。 ``docker build`` を実行すると、順次コマンドライン命令を自動化した処理を行い、ビルド結果となるイメージが得られます。

.. This page describes the commands you can use in a Dockerfile. When you are done reading this page, refer to the Dockerfile Best Practices for a tip-oriented guide.

このページでは、 ``Dockerfile`` で利用可能なコマンドを説明します。このページを読み終えたら、 ``Dockerfile`` の :doc:`ベストプラクティス </develop/develop-images/dockerfile_best-practices/>` を開き、理解を重視するガイドをご覧ください。

.. ## Usage

使用法
==========

.. The docker build command builds an image from a Dockerfile and a context. The build’s context is the set of files at a specified location PATH or URL. The PATH is a directory on your local filesystem. The URL is a Git repository location.

:doc:`docker build </engine/reference/commandline/build>` コマンドは、 ``Dockerfile`` と :ruby:`コンテキスト <context>` からイメージを :ruby:`構築 <build>` （ビルド）します。構築におけるコンテキストとは、指定された ``PATH`` （場所）または ``URL`` にあるファイル一式です。 ``PATH`` はローカル・ファイルシステム上のディレクトリです。 ``URL`` は Git リポジトリの場所です。

.. The build context is processed recursively. So, a PATH includes any subdirectories and the URL includes the repository and its submodules. This example shows a build command that uses the current directory (.) as build context:

:ruby:`構築コンテキスト <build context>` は再帰的に処理されます。つまり、 ``PATH`` にはすべてのサブディレクトリが含まれ、 ``URL`` にはリポジトリとサブモジュールが含まれます。以下の例における構築コマンドは、現在のディレクトリ（ ``.`` ）を構築コンテキストとして使用します。

.. code-block:: bash

   $ docker build .
   
   Sending build context to Docker daemon  6.51 MB
   ...

.. The build is run by the Docker daemon, not by the CLI. The first thing a build process does is send the entire context (recursively) to the daemon. In most cases, it’s best to start with an empty directory as context and keep your Dockerfile in that directory. Add only the files needed for building the Dockerfile.

構築は Docker デーモンが実行するものであり、 CLI によるものではありません。構築処理でまず行われるのは、コンテキスト全体を（再帰的に）デーモンに送信します。たいていの場合、コンテキストとして空のディレクトリを用意し、そこに Dockerfile を置くのがベストです。そのディレクトリへは、Dockerfile の構築に必要なファイルのみ追加します。

..     Warning
    Do not use your root directory, /, as the PATH for your build context, as it causes the build to transfer the entire contents of your hard drive to the Docker daemon.

.. warning::

   ルート・ディレクトリ ``/`` を構築コンテキストの ``PATH`` として指定しないでください。構築時、ハードディスクの内容すべてを Docker デーモンに転送してしまうからです。

.. To use a file in the build context, the Dockerfile refers to the file specified in an instruction, for example, a COPY instruction. To increase the build’s performance, exclude files and directories by adding a .dockerignore file to the context directory. For information about how to create a .dockerignore file see the documentation on this page.

構築コンテキスト内にあるファイルを使う場合、 ``COPY`` 命令など、 ``Dockerfile`` の命令で指定されたファイルを参照します。構築時の処理性能を上げるには、コンテキスト・ディレクトリに ``.dockerignore`` ファイルを追加し、不要なファイルやディレクトリを除外します。 ``.dockerignore`` ファイルを作成する詳細は、このページ内の :ref:`ドキュメント <dockerignore-file>` を参照ください。

.. Traditionally, the Dockerfile is called Dockerfile and located in the root of the context. You use the -f flag with docker build to point to a Dockerfile anywhere in your file system

もともと、 ``Dockerfile``  は ``Dockerfile`` と呼ばれ、コンテキストのルート（対象ディレクトリのトップ）に置かれました。 ``docker build`` で ``-f`` フラグを使えば、Dockerfile がファイルシステム上のどこにあっても指定できます。

.. code-block:: bash

   $ docker build -f /path/to/a/Dockerfile .

.. You can specify a repository and tag at which to save the new image if the build succeeds:

構築の成功時、新しいイメージを保存する :ruby:`リポジトリ <repository>` と :ruby:`タグ <tag>` を指定できます。


.. code-block:: bash

   $ docker build -t shykes/myapp .

.. To tag the image into multiple repositories after the build, add multiple -t parameters when you run the build command:

構築後、複数のリポジトリに対してイメージをタグ付けするには、 ``biuld`` コマンドの実行時、複数の ``-t`` パラメータを追加します。

.. code-block:: bash

   docker build -t shykes/myapp:1.0.2 -t shykes/myapp:latest .

.. Before the Docker daemon runs the instructions in the Dockerfile, it performs a preliminary validation of the Dockerfile and returns an error if the syntax is incorrect:

Docker デーモンは ``Dockerfile`` 内に書かれた命令を実行する前に、事前に ``Dockerfile`` を検証し、構文が間違っている場合はエラーを返します。

.. code-block:: bash

   $ docker build -t test/myapp .
   
   [+] Building 0.3s (2/2) FINISHED
    => [internal] load build definition from Dockerfile                       0.1s
    => => transferring dockerfile: 60B                                        0.0s
    => [internal] load .dockerignore                                          0.1s
    => => transferring context: 2B                                            0.0s
   error: failed to solve: rpc error: code = Unknown desc = failed to solve with frontend dockerfile.v0: failed to create LLB definition:
   dockerfile parse error line 2: unknown instruction: RUNCMD

.. The Docker daemon runs the instructions in the Dockerfile one-by-one, committing the result of each instruction to a new image if necessary, before finally outputting the ID of your new image. The Docker daemon will automatically clean up the context you sent.

Docker デーモンは ``Dockerfile`` 内の命令を 1 つずつ実行し、必要な場合にはビルドイメージ内にその処理結果を :ruby:`確定 <commit>` （コミット）し、最後に新しいイメージの ID を出力します。Docker デーモンは、送信されたコンテキスト内容を自動的に :ruby:`除去 <clean up>` します。

.. Note that each instruction is run independently, and causes a new image to be created - so RUN cd /tmp will not have any effect on the next instructions.

各命令は個別に実行され、都度、新しいイメージが生成されますのでご注意ください。したがって、たとえば ``RUN cd /tmp`` という命令があっても、その次の命令には何ら影響を与えません。

.. Whenever possible, Docker uses a build-cache to accelerate the docker build process significantly. This is indicated by the CACHED message in the console output. (For more information, see the Dockerfile best practices guide:

Docker は可能な限り :ruby:`構築キャッシュ <build-cache>` を使用し、 ``docker build`` の処理を著しく高速にします。その場合はコンソール出力に ``CACHED`` というメッセージが出ます。（詳細については、 :doc:`Dockerfile のベストプラクティスガイド </develop/develop-images/dockerfile_best-practices/>` を参照ください。）

.. code-block:: bash

   $ docker build -t svendowideit/ambassador .
   
   [+] Building 0.7s (6/6) FINISHED
    => [internal] load build definition from Dockerfile                       0.1s
    => => transferring dockerfile: 286B                                       0.0s
    => [internal] load .dockerignore                                          0.1s
    => => transferring context: 2B                                            0.0s
    => [internal] load metadata for docker.io/library/alpine:3.2              0.4s
    => CACHED [1/2] FROM docker.io/library/alpine:3.2@sha256:e9a2035f9d0d7ce  0.0s
    => CACHED [2/2] RUN apk add --no-cache socat                              0.0s
    => exporting to image                                                     0.0s
    => => exporting layers                                                    0.0s
    => => writing image sha256:1affb80ca37018ac12067fa2af38cc5bcc2a8f09963de  0.0s
    => => naming to docker.io/svendowideit/ambassador                         0.0s

.. By default, the build cache is based on results from previous builds on the machine on which you are building. The --cache-from option also allows you to use a build-cache that's distributed through an image registry refer to the specifying external cache sources section in the docker build command reference.

構築キャッシュとは、デフォルトでは、構築するマシン上で以前に構築された結果に基づきます。 ``--cache-from`` オプションの指定により、イメージ・レジストリを通して配布された構築キャッシュも使えます。 ``docker build`` コマンドリファレンスの :ref:`外部のキャッシュをソースとして指定 <specifying-external-cache-sources>` セクションをご覧ください。

.. When you’re done with your build, you’re ready to look into scanning your image with docker scan, and pushing your image to Docker Hub.

構築が終われば、 ``docker scan`` で  :doc:`イメージを検査 </engine/scan>` したり、 :doc:`Docker Hub にイメージを送信 </docker-hub/repos>` したりできます。

.. BuildKit

.. _builder-buildkit:

:ruby:`BuildKit <ビルドキット>`
========================================

.. Starting with version 18.09, Docker supports a new backend for executing your builds that is provided by the moby/buildkit project. The BuildKit backend provides many benefits compared to the old implementation. For example, BuildKit can:

バージョン 18.09 から、Docker は `moby/buildkit <https://github.com/moby/buildkit>`_ プロジェクトによって提供された、新しい構築用バックエンドをサポートしています。古い実装に比べ、BuildKit バックエンドは多くの利点があります。たとえば、 BuildKit は次のことができます。

..  Detect and skip executing unused build stages
    Parallelize building independent build stages
    Incrementally transfer only the changed files in your build context between builds
    Detect and skip transferring unused files in your build context
    Use external Dockerfile implementations with many new features
    Avoid side-effects with rest of the API (intermediate images and containers)
    Prioritize your build cache for automatic pruning

* 使用していない :doc:`構築ステージ <build stage>` の検出とスキップ
* 独立している構築ステージを :ruby:`並列構築 <parallelize building>`
* 構築コンテキストと構築の間では、変更のあったファイルのみ転送
* 構築コンテキスト内で、未使用ファイルの検出と、転送のスキップ
* 多くの新機能がある :ruby:`拡張 Dockerfile 実装 <external Dockerfile implementations>` を使用
* 他の API （中間イメージとコンテナ）による副作用を回避
* :ruby:`自動整理 <automatic pruning>` のために、構築キャッシュを優先度付け

.. To use the BuildKit backend, you need to set an environment variable DOCKER_BUILDKIT=1 on the CLI before invoking docker build.

BuildKit バックエンドを使うには、 ``docker build`` を実行する前に、CLI 上で環境変数 ``DOCKER_BUILDKIT=1`` を設定する必要があります。

.. To learn about the experimental Dockerfile syntax available to BuildKit-based builds refer to the documentation in the BuildKit repository.

BuildKit を使った構築時に有効となる、拡張 Dockerfile 実装についての詳細を知るには、 `BuildKit リポジトリにあるドキュメントを参照ください <https://github.com/moby/buildkit/blob/master/frontend/dockerfile/docs/experimental.md>`_ 。

.. Format

.. _builder-format:

書式
==========

.. Here is the format of the `Dockerfile`:

``Dockerfile`` の書式は次の通りです。

.. code-block:: dockerfile

   # コメント
   命令 引数

.. The instruction is not case-sensitive. However, convention is for them to be UPPERCASE to distinguish them from arguments more easily.

.. The instruction is not case-sensitive. However, convention is for them to
   be UPPERCASE to distinguish them from arguments more easily.

:ruby:`命令 <instruction>` は大文字と小文字を区別しません。ただし、引数と区別をつけやすくするため、慣例として引数は大文字です。

.. Docker runs instructions in a Dockerfile in order. A Dockerfile must begin with a FROM instruction. This may be after parser directives, comments, and globally scoped ARGs. The FROM instruction specifies the Parent Image from which you are building. FROM may only be preceded by one or more ARG instructions, which declare arguments that are used in FROM lines in the Dockerfile.

Docker は ``Dockerfile`` 内の命令を記述順に実行します。  ``Dockerfile`` **は必ず** ``FROM`` **命令で始めなければなりません。** ただし、 :ref:`パーサ・ディレクティブ <parser-directives>` 、 :ref:`コメント <format>` 、全体に適用される :ref:`ARG <arg>` の後になる場合があります。 ``FROM`` 命令で指定するのは、構築時に元となる :ref:`親イメージ <parent-image>` です。 ``Dockerfile`` の中で、 ``FROM`` 行の :ruby:`引数 <arguments>` として利用できる ``ARG`` 命令は、 ``FROM`` よりも前に記述できる唯一の命令です。

.. Docker treats lines that begin with # as a comment, unless the line is a valid parser directive. A # marker anywhere else in a line is treated as an argument. This allows statements like:

.. Docker treats lines that begin with # as a comment, unless the line is a valid parser directive. A # marker anywhere else in a line is treated as an argument. This allows statements like:

Docker は ``#`` で始まる行をコメントとして扱います。ただし、 :ref:`パーサ・ディレクティブ <parser-directives>` は例外です。また、行の途中にある ``#`` は単なる引数として扱います。次のような記述ができます。


.. code-block:: Dockerfile

   # コメント
   RUN echo 'we are running some # of cool things'


.. Comment lines are removed before the Dockerfile instructions are executed, which means that the comment in the following example is not handled by the shell executing the echo command, and both examples below are equivalent:

Dockerfile で命令を実行する前に、コメント行は削除されます。つまり、以下の例にあるコメントは ``echo``  コマンドのシェル実行では扱われず、以下両方の例は同じものです。

.. code-block:: bash

   RUN echo hello \
   # コメント
   world

.. code-block:: bash

   RUN echo hello \
   world

.. Line continuation characters are not supported in comments.

なお、コメント中では :ruby:`バックスラッシュ <line continuation characters>` はサポートされていません。

.. note:: **空白についての注意**

   .. For backward compatibility, leading whitespace before comments (#) and instructions (such as RUN) are ignored, but discouraged. Leading whitespace is not preserved in these cases, and the following examples are therefore equivalent:
   
   後方互換性のため、コメント（ ``#`` ）と（ ``RUN`` のような）命令よりも前の空白を無視しますが、お勧めしません。以下のような例では、先頭の空白は保持されないため、どちらも同じものです。
   
   ::
   
              # これはコメント行です
         RUN echo hello
      RUN echo world
   
   ::
   
      # this is a comment-line
      RUN echo hello
      RUN echo world
   
   ただし注意が必要なのは、以下の ``RUN`` 命令のように、命令に対する引数の空白は保持されます。そのため、以下の例では、先頭に空白が指定した通りある「 hello world」を表示します。
   
   ::
   
      RUN echo "\
        hello\
        world"

.. Parser directives

.. _parser-directives:

:ruby:`パーサ・ディレクティブ <parser directives>`
==================================================

.. Parser directives are optional, and affect the way in which subsequent lines in a Dockerfile are handled. Parser directives do not add layers to the build, and will not be shown as a build step. Parser directives are written as a special type of comment in the form # directive=value. A single directive may only be used once.

:ruby:`パーサ・ディレクティブ <parser directives>` （構文命令）はオプションです。 ``Dockerfile`` で指定すると、以降の行での挙動に影響を与えます。パーサ・ディレクティブは構築時にレイヤを追加しないため、構築ステップで表示されません。パーサ・ディレクティブは ``# ディレクティブ（命令の名前）=値`` という形式の、特別なタイプのコメントとして書きます。1つのディレクティブ（命令）は一度しか使えません。

.. Once a comment, empty line or builder instruction has been processed, Docker no longer looks for parser directives. Instead it treats anything formatted as a parser directive as a comment and does not attempt to validate if it might be a parser directive. Therefore, all parser directives must be at the very top of a Dockerfile.

コメントや空行、構築命令を処理すると、Docker はパーサ・ディレクティブを探さなくなります。そのかわり、パーサ・ディレクティブの記述はコメントとして扱われ、パーサ・ディレクティブかどうかは確認しません。そのため、すべてのパーサ・ディレクティブは ``Dockerfile`` の一番上に書く必要があります。

.. Parser directives are not case-sensitive. However, convention is for them to be lowercase. Convention is also to include a blank line following any parser directives. Line continuation characters are not supported in parser directives.

パーサ・ディレクティブは大文字と小文字を区別しません。しかし、小文字を使うのが慣例です。他にも慣例として、パーサ・ディレクティブの次行は空白にします。パーサ・ディレクティブ内では、 :ruby:`バックスラッシュ <line continuation characters>` はサポートされません。

.. Due to these rules, the following examples are all invalid:

これらの規則があるため、次の例はどれも無効です。

.. Invalid due to line continuation:

（バックスラッシュを使った）行の継続はできません：

.. code-block:: dockerfile

   # ディレク \
   ティブ=値

.. Invalid due to appearing twice:

（ディレクティブが）二度出現するため無効：

.. code-block:: dockerfile

   # ディレクティブ=値1
   # ディレクティブ=値2
   
   FROM イメージ名

.. T reated as a comment due to appearing after a builder instruction:

構築命令の後に（パーサ・ディレクティブが）あっても、コメントとして扱う：

.. code-block:: dockerfile

   FROM ImageName
   # ディレクティブ=値

.. Treated as a comment due to appearing after a comment which is not a parser directive:

コメントの後にパーサ・ディレクティブあれば、（単なる）コメントとして扱う：

.. code-block:: dockerfile

   # dockerfile についての説明
   # ディレクティブ=値
   FROM ImageName

.. The unknown directive is treated as a comment due to not being recognized. In addition, the known directive is treated as a comment due to appearing after a comment which is not a parser directive.

不明なディレクティブは認識できないため、コメントとして扱う。さらに、パーサ・ディレクティブではないコメントの後にディレクティブがあっても、（命令としてではなく）コメントとして扱う：

.. code-block:: dockerfile

   # 不明な命令=値
   # 正しい命令=値


.. Non line-breaking whitespace is permitted in a parser directive. Hence, the following lines are all treated identically:

パーサ・ディレクティブでは、改行ではない空白（スペース）を書けます。そのため、以下の各行はすべて同じように扱われます。
そこで、以下の各行はすべて同一のものとして扱われます。

.. code-block:: dockerfile

   #directive=value
   # directive =value
   #	directive= value
   # directive = value
   #	  dIrEcTiVe=value

.. The following parser directive is supported:

以下のパーサ・ディレクティブをサポートしています。

* ``syntax``
* ``escape``

.. syntax

.. _builder-syntax:

syntax
==========

::

   # syntax=[リモート・イメージ・リファレンス]

例：

::

   # syntax=docker/dockerfile:1
   # syntax=docker.io/docker/dockerfile:1
   # syntax=example.com/user/repo:tag@sha256:abcdef...

.. This feature is only available when using the BuildKit backend, and is ignored when using the classic builder backend.

この機能は、 :ref:`BuildKit <builder-buildkit>` バックエンドを利用時のみ使えます。そのため、古い構築バックエンドの利用時には、無視されます。

.. The syntax directive defines the location of the Dockerfile syntax that is used to build the Dockerfile. The BuildKit backend allows to seamlessly use external implementations that are distributed as Docker images and execute inside a container sandbox environment.

syntax ディレクティブ（命令）では、対象の Dockerfile が構築時に使う、 Dockerfile :ruby:`構文 <syntax>` の場所を定義します。BuildKit バックエンドは Docker イメージとして配布され、コンテナのサンドボックス環境内で実行される :ruby:`外部実装 <external implementation>` をシームレスに利用できます。

.. Custom Dockerfile implementations allows you to:

カスタム Dockerfile 実装により、次のことが可能になります。

..     Automatically get bugfixes without updating the Docker daemon
    Make sure all users are using the same implementation to build your Dockerfile
    Use the latest features without updating the Docker daemon
    Try out new features or third-party features before they are integrated in the Docker daemon
    Use alternative build definitions, or create your own

* Docker デーモンを更新しなくても、自動的にバグ修正をする
* すべての利用者が確実に同じ実装を使い、Dockerfile で構築する
* Docker デーモンを更新しなくても、最新機能を使う
* Docker デーモンに統合前の、新機能やサードパーティ機能を試す
* `他の build 定義や、自分自身で作成した定義 <https://github.com/moby/buildkit#exploring-llb>`_ を使う


.. Official releases

.. _builder-official-releases:

公式リリース
--------------------

.. Docker distributes official versions of the images that can be used for building Dockerfiles under docker/dockerfile repository on Docker Hub. There are two channels where new images are released: stable and labs.

 Docker Hub の ``docker/dockerfile`` `リポジトリ <https://hub.docker.com/r/docker/dockerfile>`_以下で、 Dockerfile 構築に使用できるイメージの公式バージョンを、 Docker が配布しています。新しいイメージがリリースされるのは、 ``stable`` と ``labs`` という2つのチャンネルがあります。

.. Stable channel follows semantic versioning. For example:

stable チャンネルは `セマンティック・バージョニング <https://semver.org/lang/ja/>`_ に従います。たとえば、

.. 
    docker/dockerfile:1 - kept updated with the latest 1.x.x minor and patch release
    docker/dockerfile:1.2 - kept updated with the latest 1.2.x patch release, and stops receiving updates once version 1.3.0 is released.
    docker/dockerfile:1.2.1 - immutable: never updated

* ``docker/dockerfile:1`` - 最新の ``1.x.x``  マイナー *および* パッチ・リリースが更新され続ける
* ``docker/dockerfile:1.2`` - 最新の ``1.2.x`` パッチ・リリースが更新され続けますが、 ``1.3.0`` バージョンがリリースされると更新停止
* ``docker/dockerfile:1.2.1`` -  :ruby:`変わりません <immutable>` ：決して更新しない

.. We recommend using docker/dockerfile:1, which always points to the latest stable release of the version 1 syntax, and receives both “minor” and “patch” updates for the version 1 release cycle. BuildKit automatically checks for updates of the syntax when performing a build, making sure you are using the most current version.

私たちは ``docker/dockerfile:1`` の使用を推奨します。これは、常にバージョン 1 :ruby:`構文 <syntax>` の最新 :ruby:`安定版 <stable>` リリースを示し、かつ、バージョン 1 のリリース・サイクルにおける「マイナー」と「パッチ」更新の両方も受け取れるからです。 BuildKit は構築の処理時、自動的に構文の更新を確認し、常に最新安定版を使うようにします。

.. If a specific version is used, such as 1.2 or 1.2.1, the Dockerfile needs to be updated manually to continue receiving bugfixes and new features. Old versions of the Dockerfile remain compatible with the new versions of the builder.

``1.2`` や ``1.2.1`` のようなバージョンを指定すると、バグ修正や新機能を利用するには、 Dockerfile を手動で更新する必要があります。Dockerfile の古いバージョンは、 :ruby:`ビルダー <builder>` の新しいバージョンと互換性を維持します。

.. _builder-labs-channel

labs チャンネル
^^^^^^^^^^^^^^^^^^^^^

.. The “labs” channel provides early access to Dockerfile features that are not yet available in the stable channel. Labs channel images are released in conjunction with the stable releases, and follow the same versioning with the -labs suffix, for example:

「labs」チャンネルが提供するのは、まだ stable チャンネルでは利用できない、 Dockerfile機能に対する早期アクセスです。Labs チャンネル・イメージは stable リリースと連携しています。同じバージョンに ``-labs`` 文字が付きます。たとえば、

.. 
    docker/dockerfile:labs - latest release on labs channel
    docker/dockerfile:1-labs - same as dockerfile:1 in the stable channel, with labs features enabled
    docker/dockerfile:1.2-labs - same as dockerfile:1.2 in the stable channel, with labs features enabled
    docker/dockerfile:1.2.1-labs - immutable: never updated. Same as dockerfile:1.2.1 in the stable channel, with labs features enabled

* ``docker/dockerfile:labs`` - labs チャンネルの最新リリース
* ``docker/dockerfile:1-labs`` - stable チャンネルの ``dockerfile:1`` と同じで、labs 機能が有効化
* ``docker/dockerfile:1.2-labs`` - stable チャンネルの ``dockerfile:1.2`` と同じで、labs 機能が有効化
* ``docker/dockerfile:1.2.1-labs`` -  :ruby:`変わりません <immutable>` ：決して更新しない。 stable チャンネルの ``dockerfile:1.2.1`` と同じで、labs 機能が有効化

.. Choose a channel that best fits your needs; if you want to benefit from new features, use the labs channel. Images in the labs channel provide a superset of the features in the stable channel; note that stable features in the labs channel images follow semantic versioning, but “labs” features do not, and newer releases may not be backwards compatible, so it is recommended to use an immutable full version variant.

必要に応じて最適なチャンネルを選びます。新機能を活用したい場合は labs チャンネルを使います。labs チャンネルが提供するイメージは、stable チャンネルの :ruby:`上位互換 <superset>` です。注意として、labs チャンネルのイメージでは、 ``stable`` 機能は `セマンティック・バージョニング <https://semver.org/lang/ja/>`_ に従います。しかし「labs」機能は従いません。また、新しいリリースは下位互換性がない可能性もあるため、バージョンが固定されたフルバージョンでの指定をお勧めします。

.. For documentation on “labs” features, master builds, and nightly feature releases, refer to the description in the BuildKit source repository on GitHub. For a full list of available images, visit the image repository on Docker Hub, and the docker/dockerfile-upstream image repository for development builds.

「labs」機能、 :ruby:`マスター・ビルド <master builds>` 、 :ruby:`毎晩の機能リリース <nightly feature releases>` に関するドキュメントは、 `GitHub 上の BuildKit ソースリポジトリ <https://github.com/moby/buildkit/blob/master/README.md>`_ にある説明をご覧ください。利用可能なイメージの一覧は、 `Docker Hub のイメージ・リポジトリ <https://hub.docker.com/r/docker/dockerfile>`_ や、開発ビルド用の `docker/dockerfile-upstream image repositry <https://hub.docker.com/r/docker/dockerfile-upstream>`_ をご覧ください。


.. escape

.. _builder-escape:

escape
==========

.. code-block:: dockerfile

   # escape=\ (バックスラッシュ)

.. Or

または

.. code-block:: dockerfile

   # escape=` (バッククォート)

.. The escape directive sets the character used to escape characters in a Dockerfile. If not specified, the default escape character is \.

``Dockerfile`` 内で文字を :ruby:`エスケープ <escape>` するために使う文字を、 ``escape`` 命令で指定します。指定がなければ、デフォルトのエスケープ文字は ``\`` です。

.. The escape character is used both to escape characters in a line, and to escape a newline. This allows a Dockerfile instruction to span multiple lines. Note that regardless of whether the escape parser directive is included in a Dockerfile, escaping is not performed in a RUN command, except at the end of a line.

エスケープ文字は、行の中で文字をエスケープするのに使う場合と、改行をエスケープする（改行文字として使う）場合があります。これにより、 ``Dockerfile`` の命令は、複数の行に書けます。注意点としては、 ``Dockerfile``  で ``escape`` パーサ・ディレクティブの有無にかかわらず、 ``RUN`` 命令ではエスケープされませんが、行末のみ（改行文字として）使用できます。

.. Setting the escape character to ` is especially useful on Windows, where \ is the directory path separator. ` is consistent with Windows PowerShell.

``Windows`` 上では「 ``\`` 」がディレクトリ・パスの区切り文字のため、エスケープ文字として「`」 を指定すると、とても使いやすいでしょう。 `Windows PowerShell <https://docs.microsoft.com/ja-jp/powershell/module/microsoft.powershell.core/about/about_special_characters?view=powershell-7.1>`_ 上でも、「`」はエスケープ文字列として扱います。

.. Consider the following example which would fail in a non-obvious way on Windows. The second \ at the end of the second line would be interpreted as an escape for the newline, instead of a target of the escape from the first \. Similarly, the \ at the end of the third line would, assuming it was actually handled as an instruction, cause it be treated as a line continuation. The result of this dockerfile is that second and third lines are considered a single instruction:

以下にあるような、一見すると分かりづらい ``Windows`` 上での失敗例を考えます。2行目の行末にある、2つめの ``\`` は、1つめの ``\`` のエスケープ対象ではなく、改行（を表すエスケープ文字）として解釈されます。同じように、3行目の行末にある ``\`` も、実際には命令として処理され、改行として扱われます。結果として、この Dockerfile では2行目と3行目は1つの命令と見なされます。

.. code-block:: dockerfile

   FROM microsoft/nanoserver
   COPY testfile.txt c:\\
   RUN dir c:\

.. Results in:

結果：

.. code-block:: bash

   PS E:\myproject> docker build -t cmd .
   
   Sending build context to Docker daemon 3.072 kB
   Step 1/2 : FROM microsoft/nanoserver
    ---> 22738ff49c6d
   Step 2/2 : COPY testfile.txt c:\RUN dir c:
   GetFileAttributesEx c:RUN: The system cannot find the file specified.
   PS E:\myproject>

.. One solution to the above would be to use / as the target of both the COPY instruction, and dir. However, this syntax is, at best, confusing as it is not natural for paths on Windows, and at worst, error prone as not all commands on Windows support / as the path separator.

これを解決する方法の1つは、``COPY`` 命令と ``dir`` の両方で、対象に対して ``/`` 文字を使うものです。これはベストですが、 ``Windows``  上のパスとしては自然ではないため、混乱します。また、困ったことに、 ``Windows`` 上でコマンドすべてが ``/`` をパスの区切り文字としてサポートしておらず、エラーが発生しがちです。

.. By adding the escape parser directive, the following Dockerfile succeeds as expected with the use of natural platform semantics for file paths on Windows:

次の ``Dockerfile`` は　``escape`` パーサ・ディレクティブの追加により、 ``Windows`` 上のファイルやパスを通常通りの構文として扱えるようになります（捕捉説明：デフォルトでは「 ``\`` 」が改行文字として扱われています。あえてエスケープ文字を「`」と明示すると、特に「\」がエスケープ文字かどうか考慮する必要がなくなり、パスの指定として「 ``C:\`` 」の記述がそのまま扱えるようになります）。

::

   # escape=`
   
   FROM microsoft/nanoserver
   COPY testfile.txt c:\
   RUN dir c:\

結果：

.. code-block:: bash

   PS E:\myproject> docker build -t succeeds --no-cache=true .
   
   Sending build context to Docker daemon 3.072 kB
   Step 1/3 : FROM microsoft/nanoserver
    ---> 22738ff49c6d
   Step 2/3 : COPY testfile.txt c:\
    ---> 96655de338de
   Removing intermediate container 4db9acbb1682
   Step 3/3 : RUN dir c:\
    ---> Running in a2c157f842f5
    Volume in drive C has no label.
    Volume Serial Number is 7E6D-E0F7
   
    Directory of c:\
   
   10/05/2016  05:04 PM             1,894 License.txt
   10/05/2016  02:22 PM    <DIR>          Program Files
   10/05/2016  02:14 PM    <DIR>          Program Files (x86)
   10/28/2016  11:18 AM                62 testfile.txt
   10/28/2016  11:20 AM    <DIR>          Users
   10/28/2016  11:20 AM    <DIR>          Windows
              2 File(s)          1,956 bytes
              4 Dir(s)  21,259,096,064 bytes free
    ---> 01c7f3bef04f
   Removing intermediate container a2c157f842f5
   Successfully built 01c7f3bef04f
   PS E:\myproject>


.. Environment replacement

.. _environment-replacement:

環境変数の置き換え
====================

.. Environment variables (declared with the ENV statement) can also be used in certain instructions as variables to be interpreted by the Dockerfile. Escapes are also handled for including variable-like syntax into a statement literally.

（ :ref:`ENV 命令 <builder-env>` で宣言する ） :ruby:`環境変数 <environment variables>` は、 ``Dockerfile`` で特定の命令に対する変数としての使用もできます。また、エスケープを使えば、変数のような構文も、命令文の文字列に入れられます。

.. Environment variables are notated in the Dockerfile either with $variable_name or ${variable_name}. They are treated equivalently and the brace syntax is typically used to address issues with variable names with no whitespace, like ${foo}_bar.

``Dockerfile`` 内での環境変数は、 ``$variable_name`` または ``${variable_name}`` として書きます。どちらも同等に扱われます。中括弧（ ``{ }`` ）を使う書き方は、 ``${foo}_bar`` のように空白を使わず、変数名に割り当てる（ための変数）として通常は使います。

.. The ${variable_name} syntax also supports a few of the standard bash modifiers as specified below:

``${variable_name}`` の書き方は、次のような（変数展開するための）標準的 ``bash`` :ruby:`修飾子 <modifiers>` もサポートしています。

..
    ${variable:-word} indicates that if variable is set then the result will be that value. If variable is not set then word will be the result.
    ${variable:+word} indicates that if variable is set then word will be the result, otherwise the result is the empty string.

* ``${variable:-word}`` … ``variable`` （「変数」として何らかの値）が設定されていれば、結果はその（変数が）値になる。 ``variable`` （変数）が指定されていなければ、 ``word`` が値として設定される。
* ``${variable:+word}`` … ``variable`` （「変数」として何らかの値）が設定されていれば、結果は ``word`` が（変数の）値になり、それ以外の場合（変数の設定がない場合）は空の文字列になる。

.. In all cases, word can be any string, including additional environment variables.

どちらの例でも、（変数の中にある） ``word`` には任意の文字列を指定できますし、環境変数を追加した文字列も指定できます。

.. Escaping is possible by adding a \ before the variable: \$foo or \${foo}, for example, will translate to $foo and ${foo} literals respectively.

変数の前に ``\`` を追加してエスケープできます。たとえば、 ``\$foo`` や ``\${foo}`` は、 ``$foo`` と ``${foo}`` という文字列に変換されます。

.. Example (parsed representation is displayed after the #)

例（ ``#`` の横が、変数展開した結果 ）：

::

   FROM busybox
   ENV FOO=/bar
   WORKDIR ${FOO}   # WORKDIR /bar
   ADD . $FOO       # ADD . /bar
   COPY \$FOO /quux # COPY $FOO /quux

.. Environment variables are supported by the following list of instructions in the Dockerfile:

環境変数は、 ``Dockerfile`` 内の以下の命令でサポートされています。

* ``ADD``
* ``COPY``
* ``ENV``
* ``EXPOSE``
* ``FROM``
* ``LABEL``
* ``STOPSIGNAL``
* ``USER``
* ``VOLUME``
* ``WORKDIR``
* ``ONBUILD`` （以上の命令との組み合わせでサポートされます）

.. Environment variable substitution will use the same value for each variable throughout the entire instruction. In other words, in this example:

環境変数を置き換えでは、各命令（の行）全体を処理する間は、各変数は同じ値です。すなわち、この例では

.. code-block:: dockerfile

   ENV abc=hello
   ENV abc=bye def=$abc
   ENV ghi=$abc

.. will result in def having a value of hello, not bye. However, ghi will have a value of bye because it is not part of the same instruction that set abc to bye.

結果、 ``def``  の値は ``hello`` であり、 ``bye`` ではありません。しかし、 ``ghi`` の値は ``bye`` です。なぜなら、（変数） ``abc`` に ``bye`` を指定する命令の行と、この ``ghi`` の命令の行が違うからです。（捕捉説明： ``ENV abc=bye def=$abc`` の命令文の処理が終わるまでは ``$abc`` は ``hello`` のまま。この命令の処理が終わると、 ``$abc`` は ``bye`` になる。そのため、次の命令分 ``ghi=$abc`` で、 ``$abc`` の値 ``bye`` が変数 ``ghi`` に入る ）

.. _dockerignore-file:

.dockerignore ファイル
==============================

.. Before the docker CLI sends the context to the docker daemon, it looks for a file named .dockerignore in the root directory of the context. If this file exists, the CLI modifies the context to exclude files and directories that match patterns in it. This helps to avoid unnecessarily sending large or sensitive files and directories to the daemon and potentially adding them to images using ADD or COPY.

Docker CLI が :ruby:`コンテクスト <context>` （ `Dockerfile` や Docker イメージの中に送りたいファイルなど、Docker イメージ構築時に必要な素材・内容物のこと）を docker デーモンに送信する前に、コンテクストのルート・ディレクトリで ``.dockerignore`` という名前のファイルを探します。このファイルが存在する場合、CLI はファイル内で書かれたパターンに一致するファイルやディレクトリを、コンテクストから除外します。これにより、容量が大きいか機微情報を含むファイルやディレクトリを、不用意にデーモンに送信するのを回避したり、 ``ADD`` や ``COPY`` を使ってイメージに加えてしまうのも回避したりするのに役立ちます。

.. The CLI interprets the .dockerignore file as a newline-separated list of patterns similar to the file globs of Unix shells. For the purposes of matching, the root of the context is considered to be both the working and the root directory. For example, the patterns /foo/bar and foo/bar both exclude a file or directory named bar in the foo subdirectory of PATH or in the root of the git repository located at URL. Neither excludes anything else.

CLI は ``.dockerignore`` ファイルを、改行で区切られたパターンの一覧として解釈します。パターンとは、Unix シェルの :ruby:`ファイル・グロブ <file glob>` と似たものです。パターン一致にあたり、コンテクストのルートを :ruby:`作業ディレクトリ <working directory>` 、かつ、 :ruby:`ルート・ディレクトリ <root dhirectory>` とみなします。たとえば、 ``/foo/bar`` と ``foo/bar`` のパターンでは、どちらも ``PATH`` 、もしくは git リポジトリの場所を示す ``URL``  のルート以下で、 ``foo`` サブディレクトリ内の ``bar`` という名前のファイルかディレクトリを除外します。それ以外は除外しません。

.. If a line in .dockerignore file starts with # in column 1, then this line is considered as a comment and is ignored before interpreted by the CLI.

``.dockerignore`` ファイルでは、 ``#`` 記号で始まる行はコメントとみなされ、 CLI によって解釈される前に無視されます。

.. Here is an example .dockerignore file:

これは ``.dockerignore`` ファイルの例です：

.. code-block:: bash

   # コメント
   */temp*
   */*/temp*
   temp?

.. This file causes the following build behavior:

このファイルは構築時に以下の挙動をします。

.. list-table::
   :header-rows: 1

   * - ルール
     - 挙動
   * - ``# コメント``
     - 無視する。
   * - ``*/temp*``
     - root 以下のあらゆるサブディレクトリ内で、 ``temp`` で始まる名前のファイルやディレクトリを除外。たとえば、テキストファイル ``/somedir/temporary.txt`` を除外し、同様にディレクトリ ``/somedir/temp`` も除外する。
   * - ``*/*/temp*``
     - root から2階層以下のサブディレクトリ内で、 ``temp`` で始まる名前のファイルやディレクトリを除外。たとえば、 ``/somedir/subdir/temporary.txt`` を除外。
   * - ``temp?``
     - ルートディレクトリ内で、 ``temp`` と1文字が一致する名前のファイルやディレクトリを除外。たとえば、 ``/tempa`` と ``/tempb`` を除外。


.. Matching is done using Go’s filepath.Match rules. A preprocessing step removes leading and trailing whitespace and eliminates . and .. elements using Go’s filepath.Clean. Lines that are blank after preprocessing are ignored.

一致には Go 言語の `filepath.Match <http://golang.org/pkg/path/filepath#Match>`_ を使います。前処理として、前後の空白を削除し、``.`` と ``..`` 要素を削除するのに Go 言語の `filepath.Clean <http://golang.org/pkg/path/filepath/#Clean>`_ を使います。前処理により、空白になった行は無視されます。

.. Beyond Go’s filepath.Match rules, Docker also supports a special wildcard string ** that matches any number of directories (including zero). For example, **/*.go will exclude all files that end with .go that are found in all directories, including the root of the build context.

Go 言語の filepath.Match ルールを拡張し、 Docker は特別なワイルドカード文字列 ``**`` もサポートします。これは、（0も含む）複数のディレクトリに一致します。たとえば、 ``**/*.go`` は ``.go`` で終わるすべてのファイルを除外します。つまり、構築コンテクストのルートも含む、全てのディレクトリが対象です。

.. Lines starting with ! (exclamation mark) can be used to make exceptions to exclusions. The following is an example .dockerignore file that uses this mechanism:

``!`` （エクスクラメーション・マーク）で始まる行は、除外対象の例外を指定します。次の ``.dockerignore`` ファイル例では、この仕組みを使っています：

::

    *.md
    !README.md

.. All markdown files except README.md are excluded from the context.

コンテクストから ``README.md`` を **例外として除き** 、その他すべてのマークダウンファイルを除外します。

.. The placement of ! exception rules influences the behavior: the last line of the .dockerignore that matches a particular file determines whether it is included or excluded. Consider the following example:

``!`` による除外に対する例外ルールは、他の挙動にも影響します。 ``.dockerignore`` ファイルに書かれた最終行によって、特定のファイルが除外されるかどうかが決まるります。次の例を考えます：

::

   *.md
   !README*.md
   README-secret.md

.. No markdown files are included in the context except README files other than README-secret.md.

``README-secret.md`` 以外の README ファイル（ ``README*.md`` ）は例外として除外されませんが、その他のマークダウンファイル（ ``*.md`` ）はコンテキストに含まれません。

.. Now consider this example:

次は、こちらの例を考えます：

::

   *.md
   README-secret.md
   !README*.md

.. All of the README files are included. The middle line has no effect because !README*.md matches README-secret.md and comes last.

すべての README ファイルが含まれます（除外されません）。 ``!README*.md`` は ``README-secret.md`` と一致し、かつ最後の行にあるので、真ん中の行は無意味です。

.. You can even use the .dockerignore file to exclude the Dockerfile and .dockerignore files. These files are still sent to the daemon because it needs them to do its job. But the ADD and COPY instructions do not copy them to the image.

``.dockerignore`` ファイルを使い、 ``Dockerfile`` と ``.dockerignore`` ファイルすら除外できます。除外設定をしても、これらのファイルは構築処理で必要なため、デーモンに送信されます。ですが、 ``ADD`` と ``COPY`` 命令で、これらのファイルをイメージにコピーしません。

.. Finally, you may want to specify which files to include in the context, rather than which to exclude. To achieve this, specify * as the first pattern, followed by one or more ! exception patterns.

ほかには、コンテクスト内に特定のファイルを除外するのではなく、入れたいファイルを指定したい場合もあるでしょう。そのためには、1つめのパターンとして ``*`` を指定し（一度、全てを除外する）、以降の行では ``!`` で例外とするパターンを指定します。

.. 
    Note
    For historical reasons, the pattern . is ignored.

.. note::

   これまでの経緯により、パターン ``.`` は無視されます。

.. _from:

FROM
==========


.. code-block:: dockerfile

   FROM [--platform=<プラットフォーム>] <イメージ名> [AS <名前>]

または

.. code-block:: dockerfile

   FROM [--platform=<プラットフォーム>] <イメージ名>[:<タグ>] [AS <名前>]

または

.. code-block:: dockerfile

   FROM [--platform=<プラットフォーム>] <イメージ名>[@<ダイジェスト>] [AS <名前>]

.. The FROM instruction initializes a new build stage and sets the Base Image for subsequent instructions. As such, a valid Dockerfile must start with a FROM instruction. The image can be any valid image – it is especially easy to start by pulling an image from the Public Repositories.

``FROM`` 命令は、新しい :ruby:`構築ステージ <build stage>` を初期化し、以降の命令で使う :ref:`ベース・イメージ <base-image>` を指定します。そのため、正しい ``Dockerfile`` とは ``FROM`` 命令で始める必要があります。イメージとは、適切なイメージであれば何でも構いません。 `公開リポジトリ <https://docs.docker.com/docker-hub/repos/>`_ から **イメージを取得して始める** のが、特に簡単です。

.. 
    ARG is the only instruction that may precede FROM in the Dockerfile. See Understand how ARG and FROM interact.
    FROM can appear multiple times within a single Dockerfile to create multiple images or use one build stage as a dependency for another. Simply make a note of the last image ID output by the commit before each new FROM instruction. Each FROM instruction clears any state created by previous instructions.
    Optionally a name can be given to a new build stage by adding AS name to the FROM instruction. The name can be used in subsequent FROM and COPY --from=<name> instructions to refer to the image built in this stage.
    The tag or digest values are optional. If you omit either of them, the builder assumes a latest tag by default. The builder returns an error if it cannot find the tag value.

* ``Dockerfile`` では、 ``FROM`` よりも前に書ける命令は ``ARG`` だけです。 :ref:`understand-how-arg-and-from-interact` をご覧ください。
* 複数のイメージを作成する場合や、ある構築ステージを他からの依存関係として用いる場合のため、1つの ``Dockerfile `` に複数の ``FROM`` を書けます。新しい各 ``FROM`` 命令が処理される前には、その直前でコミットされた、最も新しいイメージ ID を単に表示するだけです。 ``FROM`` 命令があるたびに、それ以前の命令で作成されたあらゆる状態がクリアになります。
* オプションとして、 ``FROM`` 命令に ``AS 名前`` を追加し、新しい構築ステージに名前を付けられます。この名前は、以降の ``FROM`` と ``COPY --from=<名前>`` 命令で使用し、このステージで構築したイメージを参照できます。
* ``タグ`` や ``ダイジェスト`` 値はオプションです。どちらも省略すると、ビルダーは ``latest`` タグだとデフォルトで扱われます。 ``タグ`` 値（に相当するイメージ名）が見つからなければ、ビルダーはエラーを返します。

.. The optional --platform flag can be used to specify the platform of the image in case FROM references a multi-platform image. For example, linux/amd64, linux/arm64, or windows/amd64. By default, the target platform of the build request is used. Global build arguments can be used in the value of this flag, for example automatic platform ARGs allow you to force a stage to native build platform (--platform=$BUILDPLATFORM), and use it to cross-compile to the target platform inside the stage.

``FROM`` でマルチプラットフォーム対応のイメージを参照する場合には、オプションの ``--platform`` フラグを使うと、特定のプラットフォーム向けイメージを指定できます。たとえば、 ``linux/amd64`` や、 ``linux/arm64`` や、 ``windows/amd64`` です。デフォルトでは、今まさに利用しているプラットフォームを対象として構築します。 :ruby:`グローバル構築引数 <global build arguments>` が、このフラグの値をとして利用できます。たとえば :ref:`自動的なプラットフォーム ARG <automatic-platform-args-in-the-global-scope>` は、構築段階でネイティブな構築プラットフォームを上書きでき（ ``--platform=$BUILDPLATFORM`` ）、これを、そのステージ内で対象プラットフォーム向けのクロス・コンパイルとして利用できます。

.. Understand how ARG and FROM interact🔗

.. _understand-how-arg-and-from-interact:

ARG と FROM の相互作用を理解
------------------------------

.. FROM instructions support variables that are declared by any ARG instructions that occur before the first FROM.

1つめの ``FROM`` 命令の前に ``ARG`` 命令があり、そこで変数が宣言されていれば ``FROM`` 命令で参照できます。

.. code-block:: dockerfile

   ARG  CODE_VERSION=latest
   FROM base:${CODE_VERSION}
   CMD  /code/run-app

   FROM extras:${CODE_VERSION}
   CMD  /code/run-extras

.. An ARG declared before a FROM is outside of a build stage, so it can’t be used in any instruction after a FROM. To use the default value of an ARG declared before the first FROM use an ARG instruction without a value inside of a build stage:

``FROM`` 命令より前に宣言された ``ARG`` は構築ステージ外のため、 ``FROM`` 命令以降で使えません。1つめの ``FROM`` よりも前に宣言された ``ARG`` のデフォルト値を使うには、構築ステージ内で値を持たない ``ARG`` 命令を使います。

.. code-block:: dockerfile

   ARG VERSION=latest
   FROM busybox:$VERSION
   ARG VERSION
   RUN echo $VERSION > image_version

.. _run:

RUN
==========

.. RUN has 2 forms:

RUN には２つの形式があります。

.. 
    RUN <command> (shell form, the command is run in a shell, which by default is /bin/sh -c on Linux or cmd /S /C on Windows)
    RUN ["executable", "param1", "param2"] (exec form)

* ``RUN <コマンド>`` （ :ruby:`シェル形式 <shell form>` 。コマンドはシェル内で実行される。デフォルトは Linux が ``/bin/sh -c`` で、 Windows は ``cmd /S /C`` ）
* ``RUN ["実行ファイル", "パラメータ1", "パラメータ2"]`` （ :ruby:`実行形式 <exec form>` ）

.. The RUN instruction will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the Dockerfile.

``RUN`` 命令は、現在のイメージよりも上にある新しいレイヤでコマンドを実行し、その結果を :ruby:`コミット（確定） <commit>` します。結果が確定されたイメージは、 ``Dockerfile`` の次のステップで使われます。

.. Layering RUN instructions and generating commits conforms to the core concepts of Docker where commits are cheap and containers can be created from any point in an image’s history, much like source control.

``RUN`` 命令の実行と、コミット処理によって生成される（イメージ・レイヤの）階層化とは、Docker の中心となる考え方に基づいています。これは、ソースコードを管理するかのように、手軽にコミットができ、イメージ履歴のどの場所からもコンテナを作成できます。

.. The exec form makes it possible to avoid shell string munging, and to RUN commands using a base image that does not contain the specified shell executable

*exec* 形式は、シェル上の処理で文字列が改変されないようにします。加えて、シェルを実行するバイナリを含まないベース・イメージでも、 ``RUN`` 命令を実行できるようにします。

.. The default shell for the shell form can be changed using the SHELL command.

シェル形式で使うデフォルトのシェルは、 ``SHELL`` コマンドで変更できます。

.. In the shell form you can use a \ (backslash) to continue a single RUN instruction onto the next line. For example, consider these two lines:

シェル形式で ``\`` （バックスラッシュ）を使うと、 RUN 命令を次の行に続けられます。たとえば、次の２行を考えます。

::

   RUN /bin/bash -c 'source $HOME/.bashrc ;\
   echo $HOME'

.. Together they are equivalent to this single line:

これは、次の１行に合わせたのと同じです。

.. code-block:: dockerfile

   RUN /bin/bash -c 'source $HOME/.bashrc ; echo $HOME'

.. To use a different shell, other than ‘/bin/sh’, use the exec form passing in the desired shell. For example:

``/bin/sh`` 以外のシェルを使うには、 `exec` 形式で使いたいシェルを指定します。

::

   RUN ["/bin/bash", "-c", "echo hello"]

..    Note
    The exec form is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘).

.. note::

   `exec` 形式は JSON :ruby:`配列 <array>` として構文解析されます。そのため、文字を囲むにはシングル・クォート（`）ではなく、ダブル・クォート（ "）を使う必要があります。

.. Unlike the shell form, the exec form does not invoke a command shell. This means that normal shell processing does not happen. For example, RUN [ "echo", "$HOME" ] will not do variable substitution on $HOME. If you want shell processing then either use the shell form or execute a shell directly, for example: RUN [ "sh", "-c", "echo $HOME" ]. When using the exec form and executing a shell directly, as in the case for the shell form, it is the shell that is doing the environment variable expansion, not docker

シェル形式と異なり、 `exec` 形式はコマンドとしてのシェルを実行しません。つまり、通常のシェルとしての処理を行いません。たとえば、 ``RUN [  "echo", "$HOME" ]`` では、 ``$HOME`` を変数展開しません。もしも、シェルとしての総理を行いたければ、シェル形式を使うか、 ``RUN [ "sh", "-c", "echo $HOME" ]`` のように、直接シェルを実行します。 exec 形式もしくは直接シェルを実行する場合は、シェル形式と同じように処理をしているように見えますが、シェルが環境変数を処理しているのであり、 Docker が行っているのではありません。

.. Note
   In the JSON form, it is necessary to escape backslashes. This is particularly relevant on Windows where the backslash is the path separator. The following line would otherwise be treated as shell form due to not being valid JSON, and fail in an unexpected way:

.. note::

   （exec 形式の記述方法は JSON です）`JSON` 形式では、バックスラッシュをエスケープする必要があります。これが特に関係するのは、 :ruby:`パス区切り文字 <path separator>` にバックラッシュを使う Windows です。次の行は正しい JSON 形式ではないため、シェル形式として扱われます。しかし、想定していない動作を試みようとするため、処理は失敗します。
   
   ::
   
      RUN ["c:\windows\system32\tasklist.exe"]
   
   この例の正しい構文は、こちらです。
   
   ::
   
      RUN ["c:\\windows\\system32\\tasklist.exe"]

``RUN`` 命令（で処理された内容）のキャッシュは、次回以降の構築時にも、自動的に有効です。 ``RUN apt-get dist-upgrade -y`` のような命令に対するキャッシュは、次の構築時に再利用されます。 ``RUN`` 命令に対するキャッシュを無効にするには、 ``docker build --no-cache`` のように ``--no-cache`` フラグを使います。

.. See the Dockerfile Best Practices guide for more information.

詳細は、:doc:`/develop/develop-images/dockerfile_best-practices` をご覧ください。

.. The cache for RUN instructions can be invalidated by ADD and COPY instructions.

Dockerfile 中に ``ADD`` 命令と ``COPY`` 命令が出てくると、以降の ``RUN`` 命令の内容はキャッシュされません。

.. Known issues (RUN)

.. _known-issues-run

判明している問題 (RUN)
------------------------------

.. 
    Issue 783 is about file permissions problems that can occur when using the AUFS file system. You might notice it during an attempt to rm a file, for example.

* `Issue 783 <https://github.com/docker/docker/issues/783>`_ は、 AUFS ファイルシステム使用時に発生する、ファイルの権限（パーミッション）についての問題です。たとえば、ファイルを ``rm`` で削除するときに気づくかもしれません。

..    For systems that have recent aufs version (i.e., dirperm1 mount option can be set), docker will attempt to fix the issue automatically by mounting the layers with dirperm1 option. More details on dirperm1 option can be found at aufs man page

  最近の aufs バージョンのシステムであれば（ ``dirperm1`` マウントのオプションが指定可能 ）、docker は ``dirperm1`` オプションでレイヤをマウントするため、自動的にこの問題の解決を試みます。 ``dirperm1`` オプションによってできる詳細は、 `aufs man ページ <https://github.com/sfjro/aufs3-linux/tree/aufs3.18/Documentation/filesystems/aufs>`_ にあります。

..     If your system doesn’t have support for dirperm1, the issue describes a workaround.

  システムが ``dirperm1`` をサポートしていなければ、issue ページに記載の回避方法をご覧ください。

.. _cmd:

CMD
==========

.. The CMD instruction has three forms:

``CMD`` 命令には３つの形式があります。

.. 
    CMD ["executable","param1","param2"] (exec form, this is the preferred form)
    CMD ["param1","param2"] (as default parameters to ENTRYPOINT)
    CMD command param1 param2 (shell form)

* ``CMD ["実行ファイル","パラメータ1","パラメータ2"]`` （ `exec` 形式、こちらが望ましい ）
* ``CMD ["パラメータ1", "パラメータ2"]`` （ `ENTRYPOINT` 命令に対するデフォルトのパラメータとして扱う）
* ``CMD コマンド パラメータ1 パラメータ2`` （シェル形式）

.. There can only be one CMD instruction in a Dockerfile. If you list more than one CMD then only the last CMD will take effect.

``CMD`` 命令は ``Dockerfile`` 中で１度しか使えません。複数の ``CMD`` 命令があれば、最後の ``CMD`` のみ有効です。

.. The main purpose of a CMD is to provide defaults for an executing container. These defaults can include an executable, or they can omit the executable, in which case you must specify an ENTRYPOINT instruction as well.

**CMD の主な目的は、コンテナ実行時のデフォルト（初期設定）を指定するためです** 。デフォルトには、実行ファイルを含める場合も、そうでない場合もあります。実行ファイルを含まない場合は、 ``ENTRYPOINT`` 命令の指定が必要です。

.. If CMD is used to provide default arguments for the ENTRYPOINT instruction, both the CMD and ENTRYPOINT instructions should be specified with the JSON array format.

``ENTRYPOINT`` 命令に対するデフォルトの引数を `CMD`` で指定する場合は、 ``CMD`` 命令と ``ENTRYPOINT`` 命令の両方を JSON 配列形式で指定する必要があります。

..    Note
    The exec form is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘).

.. note::

   `exec` 形式は JSON :ruby:`配列 <array>` として構文解析されます。そのため、文字を囲むにはシングル・クォート（`）ではなく、ダブル・クォート（ "）を使う必要があります。

.. Unlike the shell form, the exec form does not invoke a command shell. This means that normal shell processing does not happen. For example, CMD [ "echo", "$HOME" ] will not do variable substitution on $HOME. If you want shell processing then either use the shell form or execute a shell directly, for example: CMD [ "sh", "-c", "echo $HOME" ]. When using the exec form and executing a shell directly, as in the case for the shell form, it is the shell that is doing the environment variable expansion, not docker.

シェル形式と異なり、 `exec` 形式はコマンドとしてのシェルを実行しません。つまり、通常のシェルとしての処理を行いません。たとえば、 ``CMD [  "echo", "$HOME" ]`` では、 ``$HOME`` を変数展開しません。もしも、シェルとしての総理を行いたければ、シェル形式を使うか、 ``CMD [ "sh", "-c", "echo $HOME" ]`` のように、直接シェルを実行します。 exec 形式もしくは直接シェルを実行する場合は、シェル形式と同じように処理をしているように見えますが、シェルが環境変数を処理しているのであり、 Docker が行っているのではありません。

.. When used in the shell or exec formats, the CMD instruction sets the command to be executed when running the image.

シェル形式か exec 形式の ``CMD`` 命令とは、対象イメージの起動時に処理するコマンドを指定します。

.. If you use the shell form of the CMD, then the <command> will execute in /bin/sh -c:

``CMD`` をシェル形式にする場合、 ``/bin/sh -c`` の中で ``<コマンド>`` が実行されます。

::

   FROM ubuntu
   CMD echo "This is a test." | wc -

.. If you want to run your <command> without a shell then you must express the command as a JSON array and give the full path to the executable. This array form is the preferred format of CMD. Any additional parameters must be individually expressed as strings in the array:

**シェルを使わずに <コマンド> を実行** したければ、JSON 配列としてコマンドを記述する必要があり、その実行ファイルはフルパスで指定します。 **この、JSON 配列形式が、CMD での望ましいフォーマットです** 。パラメータを追加するには、その配列内で１つ１つの文字列として記述します。

::

   FROM ubuntu
   CMD ["/usr/bin/wc","--help"]

.. If you would like your container to run the same executable every time, then you should consider using ENTRYPOINT in combination with CMD. See ENTRYPOINT.

コンテナを起動するたびに、同じコマンドを毎回実行するのであれば、 ``ENTRYPOINT`` 命令と ``CMD`` 命令の組み合わせを検討ください。詳しくは :ref:`entrypoint` をご覧ください。

.. If the user specifies arguments to docker run then they will override the default specified in CMD.

``docker run`` で引数を指定すると、 ``CMD`` で指定されているデフォルトの挙動を上書きできます。

.. 
    Note
    Do not confuse RUN with CMD. RUN actually runs a command and commits the result; CMD does not execute anything at build time, but specifies the intended command for the image.

.. note::

   ``RUN`` と ``CMD`` を混同しないでください。 ``RUN`` は実際にコマンドを実行し、その結果をコミットします。対して、 ``CMD`` は構築時には何も実行しませんが、イメージを使って実行したいコマンドを指定するものです。

.. _builder-label:

LABEL
==========

.. code-block:: dockerfile

   LABEL <キー>=<値> <キー>=<値> <キー>=<値> ...

.. The LABEL instruction adds metadata to an image. A LABEL is a key-value pair. To include spaces within a LABEL value, use quotes and backslashes as you would in command-line parsing. A few usage examples:

``LABEL`` 命令は、イメージに :ruby:`メタデータ <metadata>` を追加します。 ``LABEL`` は :ruby:`キー・バリュー <key-value>` の組み合わせです。 ``LABEl`` の値に空白がある場合は、コマンドラインでの構文解析と同じように、引用符とバックラッシュを使います。いくつかの使用例がこちらです。

.. code-block:: dockerfile

   LABEL "com.example.vendor"="ACME Incorporated"
   LABEL com.example.label-with-value="foo"
   LABEL version="1.0"
   LABEL description="This text illustrates \
   that label-values can span multiple lines."

.. An image can have more than one label. You can specify multiple labels on a single line. Prior to Docker 1.10, this decreased the size of the final image, but this is no longer the case. You may still choose to specify multiple labels in a single instruction, in one of the following two ways:

イメージは複数のラベルを持てます。１行で複数のラベルを指定できます。 Docker 1.10 未満では、この手法で最終イメージの容量を減らせましたが、今は違います。それでも１行で書く方法を選択するのであれば、２つの方法があります。

.. code-block:: dockerfile

   LABEL multi.label1="value1" multi.label2="value2" other="value3"

.. code-block:: dockerfile

   LABEL multi.label1="value1" \
         multi.label2="value2" \
         other="value3"

.. Labels included in base or parent images (images in the FROM line) are inherited by your image. If a label already exists but with a different value, the most-recently-applied value overrides any previously-set value.

ベース・イメージか親イメージ（ ``FROM`` 行にあるイメージ）を含むラベルは、イメージで継承されます。ラベルが既に存在していても、その値が違う場合は、直近で追加された値で、以前の値を上書きします。

.. To view an image’s labels, use the docker image inspect command. You can use the --format option to show just the labels;

イメージのラベルを表示するには、 ``docker image inspect`` コマンドを使います。 ``--format`` オプションを使えば、ラベルのみ表示できます。

.. code-block:: bash

   $ docker image inspect --format='' myimage

.. code-block:: bash

   "Labels": {
       "com.example.vendor": "ACME Incorporated"
       "com.example.label-with-value": "foo",
       "version": "1.0",
       "description": "This text illustrates that label-values can span multiple lines.",
       "multi.label1": "value1",
       "multi.label2": "value2",
       "other": "value3"
   },

.. MAINTAINER (deprecated)

.. _maintainer:

MAINTAINER（非推奨）
=======================

.. code-block:: dockerfile

    MAINTAINER <名前>

.. The MAINTAINER instruction sets the Author field of the generated images. The LABEL instruction is a much more flexible version of this and you should use it instead, as it enables setting any metadata you require, and can be viewed easily, for example with docker inspect. To set a label corresponding to the MAINTAINER field you could use:

``MAINTAINER`` 命令は、イメージを作成した `Author` （作成者）のフィールドを設定します。この命令よりも ``LABEL`` 命令のほうが、より柔軟であり、こちらを使うべきです。それにより、必要なメタデータの設定が簡単になり、 ``docker inspect`` などで簡単に表示できます。 ``MAINTAINER`` フィールドに相当するラベルは、次のように指定します。

.. code-block:: dockerfile

   LABEL maintainer="SvenDowideit@home.org.au"

.. This will then be visible from docker inspect with the other labels.

こうしておけば、 ``docker inspect`` で他のラベルと一緒に表示できます。

.. _expose:

EXPOSE
==========

.. code-block:: dockerfile

   EXPOSE <ポート> [<ポート>/<プロトコル>...]

.. The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime. You can specify whether the port listens on TCP or UDP, and the default is TCP if the protocol is not specified.

コンテナの実行時、指定した :ruby:`ネットワーク・ポート <network port>` をコンテナがリッスンするように、Docker へ通知するのが ``EXPOSE`` 命令です。対象ポートが TCP か UDP か、どちらをリッスンするか指定できます。プロトコルの指定がなければ、 TCP がデフォルトです。

.. The EXPOSE instruction does not actually publish the port. It functions as a type of documentation between the person who builds the image and the person who runs the container, about which ports are intended to be published. To actually publish the port when running the container, use the -p flag on docker run to publish and map one or more ports, or the -P flag to publish all exposed ports and map them to high-order ports.

``EXPOSE`` 命令だけは、実際にはポートを :ruby:`公開 <publish>` しません。これは、どのポートを公開する意図なのかという、イメージの作者とコンテナ実行者の両者に対し、ある種のドキュメントとして機能します。コンテナの実行時に実際にポートを公開するには、 ``docker run`` で ``-p`` フラグを使い、公開用のポートと割り当てる（ :ruby:`マップ <map>` する）ポートを指定します。

.. By default, EXPOSE assumes TCP. You can also specify UDP:

``EXPOSE`` はデフォルトで TCP を前提としますが、 UDP も指定できます。

::

   EXPOSE 80/udp

.. To expose on both TCP and UDP, include two lines:

TCP と UDP の両方を公開するには、2行で書きます。

::

   EXPOSE 80/tcp
   EXPOSE 80/udp

.. In this case, if you use -P with docker run, the port will be exposed once for TCP and once for UDP. Remember that -P uses an ephemeral high-ordered host port on the host, so the port will not be the same for TCP and UDP.

この例で、 ``docker run`` で ``-P`` オプションを付けると、TCP と UDP のそれぞれにポートを公開します。注意点としては、 `-P` を使うと、ホスト上で :ruby:`一時的なハイポート <ephemeral high-ordered host port>` を順番に使いますので、 TCP と UDP のポート番号が同じにならない場合もあります。

.. Regardless of the EXPOSE settings, you can override them at runtime by using the -p flag. For example

``EXPOSE`` の設定に関係なく、実行時に ``-p`` フラグを使い、その設定を上書き出来ます。たとえば、次のようにします。

.. code-block:: bash

   docker run -p 80:80/tcp -p 80:80/udp ...

.. To set up port redirection on the host system, see using the -P flag. The docker network command supports creating networks for communication among containers without the need to expose or publish specific ports, because the containers connected to the network can communicate with each other over any port. For detailed information, see the overview of this feature.

ホストシステム上でポート転送を設定するには、 :ref:`-P フラグの使い方 <expose-incoming-ports>` をご覧ください。 ``docker network`` コマンドはコンテナ間で通信するネットワークの作成をサポートしますが、特定のポートを露出したり公開したりを指定する必要はありません。これは、ネットワークに接続している複数のコンテナは、あらゆるポートを通して相互に通信できるからです。詳細な情報は、 :doc:`この機能の上書き </network/index>` をご覧ください。

.. _builder-env:

ENV
==========

.. code-block:: dockerfile

   ENV <キー>=<値> ...

.. The ENV instruction sets the environment variable <key> to the value <value>. This value will be in the environment for all subsequent instructions in the build stage and can be replaced inline in many as well. The value will be interpreted for other environment variables, so quote characters will be removed if they are not escaped. Like command line parsing, quotes and backslashes can be used to include spaces within values.

``ENV`` 命令は、環境変数 ``<キー>`` に対し、値を ``<値>`` として設定します。この値は、以降に続く構築ステージ中で、環境変数として保持されます。その上、多くの場合、 :ref:`その途中で置き換え <environment-replacement>` 可能です。値は、他の環境変数を示すものとしても解釈できます。そのため、引用符はエスケープしなければ削除されます。コマンドラインでの構文解釈と同様に、引用符とバックラッシュによって、値のなかで空白を使えるようになります。

例：

::

   ENV MY_NAME="John Doe"
   ENV MY_DOG=Rex\ The\ Dog
   ENV MY_CAT=fluffy

.. The ENV instruction allows for multiple <key>=<value> ... variables to be set at one time, and the example below will yield the same net results in the final image:

``ENV`` 命令では、一度に複数の ``<キー>=<値> ...`` 変数を指定できます。次の例は、先ほどの例の結果と（環境変数の値が）完全に同じになります。

::

   ENV MY_NAME="John Doe" MY_DOG=Rex\ The\ Dog \
       MY_CAT=fluffy

.. The environment variables set using ENV will persist when a container is run from the resulting image. You can view the values using docker inspect, and change them using docker run --env <key>=<value>.

``ENV`` 命令を使い設定した環境変数は、結果として作成されたイメージから実行したコンテナでも維持されます。 ``docker inspect`` を使い、この値を確認できます。そして、それらを変更するには ``docker run --env <キー>=<値>`` を使います。

.. Environment variable persistence can cause unexpected side effects. For example, setting ENV DEBIAN_FRONTEND=noninteractive changes the behavior of apt-get, and may confuse users of your image.

環境変数の維持は、予期しない悪影響を引き起こす可能性があります。たとえば、 ``ENV DEBIAN_FRONTEND=noninteractive` を設定すると、 ``apt-get`` の挙動を変えます。そのため、イメージの利用者を混乱させるかもしれません。

.. If an environment variable is only needed during build, and not in the final image, consider setting a value for a single command instead:

環境変数が構築中のみ必要で、最終イメージで不要な場合は、代わりにコマンドで値の指定を検討ください。

::

   RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y ...

.. Or using ARG, which is not persisted in the final image:

あるいは、 ``ARG`` を使えば、最終イメージでは保持されません。

::

   ARG DEBIAN_FRONTEND=noninteractive
   RUN apt-get update && apt-get install -y ...

..    Alternative syntax

.. note:: **別の書き方**

   .. The ENV instruction also allows an alternative syntax ENV <key> <value>, omitting the =. For example:
   
   ``ENV`` 命令では、 ``ENV <キー> <値>`` のように、 ``=`` を省略する別の構文があります。例：

   ::
   
      ENV MY_VAR my-value

   .. This syntax does not allow for multiple environment-variables to be set in a single ENV instruction, and can be confusing. For example, the following sets a single environment variable (ONE) with value "TWO= THREE=world":

   この構文では、1つの ``ENV`` 命令で、複数の環境変数を設定できません。そのため、混乱を引き起こす可能性があります。たとえば、以下の指定では、1つの環境変数（ ``ONE`` ）に対し、値 ``"TWO= THREE=world"`` を設定します。

   ::
   
      ENV ONE TWO= THREE=world

   .. The alternative syntax is supported for backward compatibility, but discouraged for the reasons outlined above, and may be removed in a future release.

   後方互換のため、この別の書き方がサポートされています。しかし、先述で説明した理由のため、使わないほうが良いでしょう。加えて、将来のリリースでは削除される可能性があります。


.. _builder-add:

ADD
==========

.. ADD has two forms:

ADD には 2 つの形式があります。

::

   ADD [--chown=<ユーザ>:<グループ>] <追加元>... <追加先>
   ADD [--chown=<ユーザ>:<グループ>] ["<追加元>",... "<追加先>"]

.. The latter form is required for paths containing whitespace.

パスに空白を含む場合には、後者の形式が必要です。

..    Note
    The --chown feature is only supported on Dockerfiles used to build Linux containers, and will not work on Windows containers. Since user and group ownership concepts do not translate between Linux and Windows, the use of /etc/passwd and /etc/group for translating user and group names to IDs restricts this feature to only be viable for Linux OS-based containers.

.. note::

   ``--chown`` 機能がサポートされているのは、 Linux コンテナを構築するために使う Dockerfile 上のみです。そのため、 Windows コンテナ上では機能しません。Linux と Windows 間では、ユーザとグループの所有者に関する概念を変換できません。ユーザ名とグループ名を ID に変換するには、 ``/etc/passwd`` と ``/etc/group`` を使いますが、これができるのは Linux OS をベースとしたコンテナのみです。

.. The ADD instruction copies new files, directories or remote file URLs from <src> and adds them to the filesystem of the image at the path <dest>.

``ADD`` 命令では、追加したいファイル、ディレクトリ、リモートファイルの URL を ``<追加元>`` で指定すると、これらをイメージのファイルシステム上のパス ``<追加先>`` に追加します。

.. Multiple <src> resources may be specified but if they are files or directories, their paths are interpreted as relative to the source of the context of the build.

複数の ``追加元`` リソースを指定できます。ファイルやディレクトリの場合、それぞれのパスは、構築コンテキストの追加先に対する相対パスとして解釈されます。

.. Each <src> may contain wildcards and matching will be done using Go’s filepath.Match rules. For example:

それぞれの ``追加元`` には、Go 言語の `filepath.Match <http://golang.org/pkg/path/filepath#Match>`_ ルールを使い、ワイルドカードや一致が処理されます。

.. To add all files starting with “hom”:

"hom" で始まるファイルすべてを追加するには、次のようにします。

::

   ADD hom* /mydir/

.. In the example below, ? is replaced with any single character, e.g., “home.txt”.

次の例では、 ``?`` は "home.txt" のような1文字に置き換えられます。

::

   ADD hom?.txt /mydir/

.. The <dest> is an absolute path, or a path relative to WORKDIR, into which the source will be copied inside the destination container.

``<追加先>`` は絶対パスか ``WORKDIR`` （作業ディレクトリ）からの相対パスであり、これらの（追加元の）ソースを送信先コンテナ内にコピーします。

.. The example below uses a relative path, and adds “test.txt” to <WORKDIR>/relativeDir/:

以下は相対パスを使う例で、 "test.txt" を ``<WORKDIR>/relativeDir/`` （相対ディレクトリ）に追加します。

::

   ADD test.txt relativeDir/

.. Whereas this example uses an absolute path, and adds “test.txt” to /absoluteDir/

次は絶対パスを使う例です。 ``/absoluteDir/`` （相対ディレクトリ）に "test.txt" を追加します。

::

   ADD test.txt /absoluteDir/

.. When adding files or directories that contain special characters (such as [ and ]), you need to escape those paths following the Golang rules to prevent them from being treated as a matching pattern. For example, to add a file named arr[0].txt, use the following;

特殊文字（ ``[`` や ``]`` など）を含むファイルやディレクトリを追加する場合は、Go 言語のルールに従い、各パスをエスケープする必要があります。たとえば、ファイル名 ``arr[0].txt,`` を追加するには、次のようにします。

::

   ADD arr[[]0].txt /mydir/

.. All new files and directories are created with a UID and GID of 0, unless the optional --chown flag specifies a given username, groupname, or UID/GID combination to request specific ownership of the content added. The format of the --chown flag allows for either username and groupname strings or direct integer UID and GID in any combination. Providing a username without groupname or a UID without GID will use the same numeric UID as the GID. If a username or groupname is provided, the container’s root filesystem /etc/passwd and /etc/group files will be used to perform the translation from name to integer UID or GID respectively. The following examples show valid definitions for the --chown flag:

新しいファイルやディレクトリは、オプションの ``--chown`` フラグでユーザ名、グループ名、UID/GID の組み合わせて追加対象の権限指定リクエストを指定しない限り、 UID と GID が 0 として作成されます。 ``--chown`` フラグの書式により、ユーザ名とグループ名の文字列の指定や、整数として直接 UID と GID のあらゆる組み合わせの指定ができます。ユーザ名かグループ名を指定すると、コンテナのルート・ファイルシステム上にある ``/etc/passwd`` と ``/etc/group`` ファイルを使い、その名前から適切な整数の UID や GID にそれぞれ変換する処理が行われます。以下は ``--chown`` フラグを使って適切に定義する例です。

::

   ADD --chown=55:mygroup files* /somedir/
   ADD --chown=bin files* /somedir/
   ADD --chown=1 files* /somedir/
   ADD --chown=10:11 files* /somedir/

.. If the container root filesystem does not contain either /etc/passwd or /etc/group files and either user or group names are used in the --chown flag, the build will fail on the ADD operation. Using numeric IDs requires no lookup and will not depend on container root filesystem content.

もしも、コンテナのルート・ファイルシステムに ``/etc/passwd`` や ``/etc/group`` ファイルが無く、さらに ``--chown`` フラグで使われたユーザ名やグループ名が存在しない場合は、 ``ADD`` の処理段階で構築が失敗します。整数で ID を指定すると、（ユーザ名が存在しているかどうか）検索する必要がなく、コンテナのルート・ファイルシステムの内容に依存しません。

.. In the case where <src> is a remote file URL, the destination will have permissions of 600. If the remote file being retrieved has an HTTP Last-Modified header, the timestamp from that header will be used to set the mtime on the destination file. However, like any other file processed during an ADD, mtime will not be included in the determination of whether or not the file has changed and the cache should be updated.

``<追加元>`` がリモートにあるファイル URL の場合には、追加先のパーミッションは 600 になります。もしも、リモートファイルの取得時に HTTP ヘッダ ``Last-Modified`` があれば、追加先の ``mtime`` を設定するために使います。しかしながら、 ``ADD`` の途中で処理される他のファイルと同じように、ファイルが変更されたかどうかや、キャッシュを更新するかどうかを判断するために ``mtime`` は使われません。

..    Note
    If you build by passing a Dockerfile through STDIN (docker build - < somefile), there is no build context, so the Dockerfile can only contain a URL based ADD instruction. You can also pass a compressed archive through STDIN: (docker build - < archive.tar.gz), the Dockerfile at the root of the archive and the rest of the archive will be used as the context of the build.

.. note::

   :ruby:`標準入力 <STDIN>` を通し（ ``docker build - < ファイル名`` ） ``Dockerfile`` を渡して構築する場合は、 :ruby:`構築コンテクスト <build context>` が存在しませんので、 ``Dockerfile`` で URL をベースとした ``ADD`` のみ追加可能です。また、標準入力で圧縮したアーカイブも渡せます（ ``docker build - < archive.tar.gz`` ）ので、アーカイブのルートにある ``Dockerfile`` と、以降に続くアーカイブ内容が、構築用のコンテクストとして利用されます。

.. If your URL files are protected using authentication, you need to use RUN wget, RUN curl or use another tool from within the container as the ADD instruction does not support authentication.

もしも URL ファイルが認証によって保護されている場合、``ADD`` 命令は認証をサポートしていないため、コンテナ内で  ``RUN wget`` や ``RUN curl`` など他のツールを使う必要があります。

..    Note
    The first encountered ADD instruction will invalidate the cache for all following instructions from the Dockerfile if the contents of <src> have changed. This includes invalidating the cache for RUN instructions. See the Dockerfile Best Practices guide – Leverage build cache for more information.

.. note::

   ``ADD`` 命令を処理するにあたり、 ``<追加元>`` の内容が変更されている場合は、その Dockerfile の対象行以降でキャッシュを無効にします。``RUN`` 命令のためのキャッシュも、無効になる対象です。詳しい情報は :ref:`ベストプラクティス・ガイド - 構築キャッシュの活用 <leverage-build-cache>` をご覧ください。


.. ADD obeys the following rules:

``ADD`` は以下のルールに従います。

..    The <src> path must be inside the context of the build; you cannot ADD ../something /something, because the first step of a docker build is to send the context directory (and subdirectories) to the docker daemon.
    If <src> is a URL and <dest> does not end with a trailing slash, then a file is downloaded from the URL and copied to <dest>.
    If <src> is a URL and <dest> does end with a trailing slash, then the filename is inferred from the URL and the file is downloaded to <dest>/<filename>. For instance, ADD http://example.com/foobar / would create the file /foobar. The URL must have a nontrivial path so that an appropriate filename can be discovered in this case (http://example.com will not work).
    If <src> is a directory, the entire contents of the directory are copied, including filesystem metadata.

- ``<追加元>`` のパスは、構築コンテクスト内にある必要があります。つまり、 ``ADD .../どこか /どこか`` のように指定できません。これは、 ``docker build`` の第一段階が、コンテクスト対象のディレクトリ（とサブディレクトリ）を docker デーモンに対して送信するからです。
- もしも ``<追加元>`` が URL で ``追加先`` の最後が :ruby:`スラッシュ記号 <trailing slash>` で終わっていなければ、URL からファイルをダウンロードした後、 ``<追加先>`` にコピーします。
- もしも ``<追加元>`` が URL で ``追加先`` の最後が :ruby:`スラッシュ記号 <trailing slash>` で終わっていれば、URL からファイル名を推測し、それから ``<追加先>/<ファイル名>`` にファイルをダウンロードします。たとえば、 ``ADD http://example.com/foobar /`` は、ファイル ``/foobar`` を作成します。その際、適切なファイル名を検出できるようするため、URL には何らかのパスを含める必要があります（ ``http://example.com`` は動作しません ）。
- ``<追加元>`` がディレクトリであれば、ファイルシステムのメタデータも含む、ディレクトリの内容すべてがコピーされます。

..    Note
    The directory itself is not copied, just its contents.

.. note::

   対象ディレクトリそのものはコピーしません。ディレクトリの内容のみコピー対象です。

..    If <src> is a local tar archive in a recognized compression format (identity, gzip, bzip2 or xz) then it is unpacked as a directory. Resources from remote URLs are not decompressed. When a directory is copied or unpacked, it has the same behavior as tar -x, the result is the union of:
        Whatever existed at the destination path and
        The contents of the source tree, with conflicts resolved in favor of “2.” on a file-by-file basis.

- ``<追加元>`` がローカルにあり、認識できる圧縮形式（ :ruby:`無圧縮 <identity>` 、 gzip 、 gzip2、xz ）の tar アーカイブの場合は、ディレクトリとして :ruby:`展開 <unpacked>` します。リモート URL からのリソースは展開 **しません** 。ディレクトリのコピーまたは展開は、 ``tar -x`` の挙動と同じ、次の処理の組み合わせです。

   1. 送信先に何らかのパスが存在していたら、
   2. 1つ1つのファイルごとに、ソースツリーに含まれる方を優先して処理（コピー）する
   
   .. note::
   
      ファイルが認識できる圧縮形式かどうかにかかわらず、ファイル名ではなく、対象ファイルの内容に基づいて処理が行われます。たとえば、空ファイルの名前が ``.tar.gz`` だとしておｍ、これは圧縮ファイルとは認識されず、ファイル展開に関するエラーメッセージは一切表示 **されず** 、それどころか、ファイルは単に追加先にコピーされます。

..    If <src> is any other kind of file, it is copied individually along with its metadata. In this case, if <dest> ends with a trailing slash /, it will be considered a directory and the contents of <src> will be written at <dest>/base(<src>).
    If multiple <src> resources are specified, either directly or due to the use of a wildcard, then <dest> must be a directory, and it must end with a slash /.
    If <dest> does not end with a trailing slash, it will be considered a regular file and the contents of <src> will be written at <dest>.
    If <dest> doesn’t exist, it is created along with all missing directories in its path.

- ``追加元`` が何らかのファイルの場合は、そのメタデータと一緒に個別にコピーされます。 ``<追加先>`` が :ruby:`スラッシュ記号 <trailing slash>` で終わっている場合は、これがディレクトリとみなされ、 ``<追加元>`` は ``<追加先>/base(<送信元>)`` に書き込まれます。
- 複数の ``<追加元>`` が :ruby:`スラッシュ記号 <trailing slash>` で終わっていなければ、対象は通常のファイルとみなされ、 ``<追加元>`` の内容が、 ``<追加先>`` に書き込まれます。
- ``<追加先>`` が存在しない場合は、対象パス内に存在していないディレクトリ全てと共に作成されます。


.. _builder-copy:

COPY
==========

.. COPY has two forms:

ADD には 2 つの形式があります。

::

   COPY [--chown=<ユーザ>:<グループ>] <コピー元>... <コピー先>
   COPY [--chown=<ユーザ>:<グループ>] ["<コピー元>",... "<コピー先>"]


.. This latter form is required for paths containing whitespace

パスに空白を含む場合には、後者の形式が必要です。

..    Note
    The --chown feature is only supported on Dockerfiles used to build Linux containers, and will not work on Windows containers. Since user and group ownership concepts do not translate between Linux and Windows, the use of /etc/passwd and /etc/group for translating user and group names to IDs restricts this feature to only be viable for Linux OS-based containers.

.. note::

   ``--chown`` 機能がサポートされているのは、 Linux コンテナを構築するために使う Dockerfile 上のみです。そのため、 Windows コンテナ上では機能しません。Linux と Windows 間では、ユーザとグループの所有者に関する概念を変換できません。ユーザ名とグループ名を ID に変換するには、 ``/etc/passwd`` と ``/etc/group`` を使いますが、これができるのは Linux OS をベースとしたコンテナのみです。

.. The COPY instruction copies new files or directories from <src> and adds them to the filesystem of the container at the path <dest>.

``COPY`` 命令では、追加したいファイル、ディレクトリを ``<コピー元>`` で指定すると、これらをイメージのファイルシステム上のパス ``<コピー先>`` に追加します。

.. Multiple <src> resources may be specified but the paths of files and directories will be interpreted as relative to the source of the context of the build.

複数の ``コピー元`` リソースを指定できます。ファイルやディレクトリの場合、それぞれのパスは、構築コンテキストのコピー先に対する相対パスとして解釈されます。

.. Each <src> may contain wildcards and matching will be done using Go’s filepath.Match rules. For example:

それぞれの ``コピー元`` には、Go 言語の `filepath.Match <http://golang.org/pkg/path/filepath#Match>`_ ルールを使い、ワイルドカードや一致が処理されます。

.. To add all files starting with “hom”:

"hom" で始まるファイルすべてを追加するには、次のようにします。

::

   COPY hom* /mydir/

.. In the example below, ? is replaced with any single character, e.g., “home.txt”.

次の例では、 ``?`` は "home.txt" のような1文字に置き換えられます。


::

   COPY hom?.txt /mydir/

.. The <dest> is an absolute path, or a path relative to WORKDIR, into which the source will be copied inside the destination container.

``<コピー先>`` は絶対パスか ``WORKDIR`` （作業ディレクトリ）からの相対パスであり、これらの（コピー元の）ソースを送信先コンテナ内にコピーします。

.. The example below uses a relative path, and adds “test.txt” to <WORKDIR>/relativeDir/:

以下は相対パスを使う例で、 "test.txt" を ``<WORKDIR>/relativeDir/`` （相対ディレクトリ）に追加します。

::

   COPY test.txt relativeDir/

.. Whereas this example uses an absolute path, and adds “test.txt” to /absoluteDir/

次は絶対パスを使う例です。 ``/absoluteDir/`` （相対ディレクトリ）に "test.txt" を追加します。

::

   COPY test.txt /absoluteDir/

.. When copying files or directories that contain special characters (such as [ and ]), you need to escape those paths following the Golang rules to prevent them from being treated as a matching pattern. For example, to copy a file named arr[0].txt, use the following;

特殊文字（ ``[`` や ``]`` など）を含むファイルやディレクトリを追加する場合は、Go 言語のルールに従い、各パスをエスケープする必要があります。たとえば、ファイル名 ``arr[0].txt,`` を追加するには、次のようにします。

::

   COPY arr[[]0].txt /mydir/

.. All new files and directories are created with a UID and GID of 0, unless the optional --chown flag specifies a given username, groupname, or UID/GID combination to request specific ownership of the copied content. The format of the --chown flag allows for either username and groupname strings or direct integer UID and GID in any combination. Providing a username without groupname or a UID without GID will use the same numeric UID as the GID. If a username or groupname is provided, the container’s root filesystem /etc/passwd and /etc/group files will be used to perform the translation from name to integer UID or GID respectively. The following examples show valid definitions for the --chown flag:

新しいファイルやディレクトリは、オプションの ``--chown`` フラグでユーザ名、グループ名、UID/GID の組み合わせて追加対象の権限指定リクエストを指定しない限り、 UID と GID が 0 として作成されます。 ``--chown`` フラグの書式により、ユーザ名とグループ名の文字列の指定や、整数として直接 UID と GID のあらゆる組み合わせの指定ができます。ユーザ名かグループ名を指定すると、コンテナのルート・ファイルシステム上にある ``/etc/passwd`` と ``/etc/group`` ファイルを使い、その名前から適切な整数の UID や GID にそれぞれ変換する処理が行われます。以下は ``--chown`` フラグを使って適切に定義する例です。

::

   COPY --chown=55:mygroup files* /somedir/
   COPY --chown=bin files* /somedir/
   COPY --chown=1 files* /somedir/
   COPY --chown=10:11 files* /somedir/

.. If the container root filesystem does not contain either /etc/passwd or /etc/group files and either user or group names are used in the --chown flag, the build will fail on the COPY operation. Using numeric IDs requires no lookup and does not depend on container root filesystem content.

もしも、コンテナのルート・ファイルシステムに ``/etc/passwd`` や ``/etc/group`` ファイルが無く、さらに ``--chown`` フラグで使われたユーザ名やグループ名が存在しない場合は、 ``COPY`` の処理段階で構築が失敗します。整数で ID を指定すると、（ユーザ名が存在しているかどうか）検索する必要がなく、コンテナのルート・ファイルシステムの内容に依存しません。

..    Note
    If you build using STDIN (docker build - < somefile), there is no build context, so COPY can’t be used.

.. note::

   :ruby:`標準入力 <STDIN>` を通し（ ``docker build - < ファイル名`` ） ``Dockerfile`` を渡して構築しようとしても、 :ruby:`構築コンテクスト <build context>` が存在しませんので、 ``COPY`` は使えません。

.. Optionally COPY accepts a flag --from=<name> that can be used to set the source location to a previous build stage (created with FROM .. AS <name>) that will be used instead of a build context sent by the user. In case a build stage with a specified name can’t be found an image with the same name is attempted to be used instead.

オプションで、これまでの（ ``FROM .. AS <名前>`` として作成した）構築ステージをコピー元（ソース）の場所として指定するために、 ``COPY`` で ``--from=<名前>`` フラグを利用できます。これは、ユーザ自身が構築コンテキストを送る作業の替わりとなります。

.. COPY obeys the following rules:

``COPY`` は以下のルールに従います。

..    The <src> path must be inside the context of the build; you cannot COPY ../something /something, because the first step of a docker build is to send the context directory (and subdirectories) to the docker daemon.
    If <src> is a directory, the entire contents of the directory are copied, including filesystem metadata.

- ``<コピー元>`` のパスは、構築コンテクスト内にある必要があります。つまり、 ``COPY .../どこか /どこか`` のように指定できません。これは、 ``docker build`` の第一段階が、コンテクスト対象のディレクトリ（とサブディレクトリ）を docker デーモンに対して送信するからです。
- ``<コピー元>`` がディレクトリであれば、ファイルシステムのメタデータも含む、ディレクトリの内容すべてがコピーされます。

..    Note
    The directory itself is not copied, just its contents.

.. note::

   対象ディレクトリそのものはコピーしません。ディレクトリの内容のみコピー対象です。

..    If <src> is any other kind of file, it is copied individually along with its metadata. In this case, if <dest> ends with a trailing slash /, it will be considered a directory and the contents of <src> will be written at <dest>/base(<src>).
    If multiple <src> resources are specified, either directly or due to the use of a wildcard, then <dest> must be a directory, and it must end with a slash /.
    If <dest> does not end with a trailing slash, it will be considered a regular file and the contents of <src> will be written at <dest>.
    If <dest> doesn’t exist, it is created along with all missing directories in its path.

- ``コピー元`` が何らかのファイルの場合は、そのメタデータと一緒に個別にコピーされます。 ``<コピー先>`` が :ruby:`スラッシュ記号 <trailing slash>` で終わっている場合は、これがディレクトリとみなされ、 ``<コピー元>`` は ``<コピー先>/base(<コピー元>)`` に書き込まれます。
- 複数の ``<コピー元>`` が :ruby:`スラッシュ記号 <trailing slash>` で終わっていなければ、対象は通常のファイルとみなされ、 ``<コピー元>`` の内容が、 ``<コピー先>`` に書き込まれます。
- ``<コピー先>`` が存在しない場合は、対象パス内に存在していないディレクトリ全てと共に作成されます。


..    Note
    The first encountered COPY instruction will invalidate the cache for all following instructions from the Dockerfile if the contents of <src> have changed. This includes invalidating the cache for RUN instructions. See the Dockerfile Best Practices guide – Leverage build cache for more information.

.. note::

   ``COPY`` 命令を処理するにあたり、 ``<コピー元>`` の内容が変更されている場合は、その Dockerfile の対象行以降でキャッシュを無効にします。``RUN`` 命令のためのキャッシュも、無効になる対象です。詳しい情報は :ref:`ベストプラクティス・ガイド - 構築キャッシュの活用 <leverage-build-cache>` をご覧ください。


.. _builder-entrypoint:

ENTRYPOINT
==========

.. ENTRYPOINT has two forms:

ENTRYPOINT には２つの形式があります。

.. The exec form, which is the preferred form:

*exec* 形式は、推奨されている形式です：

::

   ENTRYPOINT ["実行ファイル", "パラメータ1", "パラメータ2"]

.. The shell form:

*shell* 形式：

::

    ENTRYPOINT コマンド パラメータ1 パラメータ2

.. An ENTRYPOINT allows you to configure a container that will run as an executable.

``ENTRYPOINT`` は、コンテナを :ruby:`実行ファイル <executable>` として処理するように設定できます。

.. For example, the following starts nginx with its default content, listening on port 80:

たとえば、以下はデフォルト設定の nginx が、ポート 80 をリッスンして起動します。

.. code-block:: bash

   docker run -i -t --rm -p 80:80 nginx

.. Command line arguments to docker run <image> will be appended after all elements in an exec form ENTRYPOINT, and will override all elements specified using CMD. This allows arguments to be passed to the entry point, i.e., docker run <image> -d will pass the -d argument to the entry point. You can override the ENTRYPOINT instruction using the docker run --entrypoint flag.

コマンドラインでの ``docker run <イメージ名>`` に対する引数は、 *exec* 形式の ``ENTRYPOINT`` の全要素の後に追加されます。そして、 ``CMD`` を使って指定した全ての要素は上書きされます。これにより、 :ruby:`エントリーポイント <entry point>` に対する引数として渡せます。たとえば、 ``docker run <イメージ> -d`` では、エントリーポイントに対して引数 ``-d`` を渡せます。また、 ``ENTRYPOINT`` 命令の上書きは、 ``docker run --entrypoint`` フラグを使います。

.. The shell form prevents any CMD or run command line arguments from being used, but has the disadvantage that your ENTRYPOINT will be started as a subcommand of /bin/sh -c, which does not pass signals. This means that the executable will not be the container’s PID 1 - and will not receive Unix signals - so your executable will not receive a SIGTERM from docker stop <container>.

*shell* 形式では、 ``CMD`` や ``run`` コマンドラインの引数を使えません。 ``ENTRYPOINT`` は ``/bin/sh -c`` のサブコマンドとして起動されるため、シグナルを渡せません。そのため、実行ファイルはコンテナの ``PID 1`` ではなく、Unix シグナルを受信できません。つまり、 ``docker stop <コンテナ名>`` を実行しても、実行ファイルは ``SIGTERM`` シグナルを受信しません。

.. Only the last ENTRYPOINT instruction in the Dockerfile will have an effect.

``ENTRYPOINT`` を複数書いても、``Dockerfile`` 中で一番最後の 命令しか処理されません。

.. Exec form ENTRYPOINT example

.. _exec-form-entrypoint-example:

exec 形式の ENTRYPOINT 例
------------------------------

.. You can use the exec form of ENTRYPOINT to set fairly stable default commands and arguments and then use either form of CMD to set additional defaults that are more likely to be changed.

``ENTRYPOINT`` の *exec* 形式は、確実に実行するデフォルトのコマンドと引数を設定するために使います。そして、 ``CMD`` のどちらかの形式を使い、変わる可能性があるデフォルト（のパラメータや引数）を指定します。

::

   FROM ubuntu
   ENTRYPOINT ["top", "-b"]
   CMD ["-c"]

.. When you run the container, you can see that top is the only process:

このコンテナを実行すると、唯一のプロセスとして ``top`` が見えます。

.. code-block:: bash

   $ docker run -it --rm --name test  top -H
   
   top - 08:25:00 up  7:27,  0 users,  load average: 0.00, 0.01, 0.05
   Threads:   1 total,   1 running,   0 sleeping,   0 stopped,   0 zombie
   %Cpu(s):  0.1 us,  0.1 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
   KiB Mem:   2056668 total,  1616832 used,   439836 free,    99352 buffers
   KiB Swap:  1441840 total,        0 used,  1441840 free.  1324440 cached Mem
   
     PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
       1 root      20   0   19744   2336   2080 R  0.0  0.1   0:00.04 top

.. To examine the result further, you can use docker exec:

さらに詳しく調べるには、 ``docker exec`` が使えます。

.. code-block:: bash

   $ docker exec -it test ps aux
   
   USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
   root         1  2.6  0.1  19752  2352 ?        Ss+  08:24   0:00 top -b -H
   root         7  0.0  0.1  15572  2164 ?        R+   08:25   0:00 ps aux

.. And you can gracefully request top to shut down using docker stop test.

``top`` を適切に終了するには、``docker stop test`` を実行します。

.. The following Dockerfile shows using the ENTRYPOINT to run Apache in the foreground (i.e., as PID 1):

以下の ``Dockerfile`` は、Apache をフォアグラウンドで実行するために（つまり、 ``PID 1`` として） ``ENTRYPOINT`` を使います。

::

   FROM debian:stable
   RUN apt-get update && apt-get install -y --force-yes apache2
   EXPOSE 80 443
   VOLUME ["/var/www", "/var/log/apache2", "/etc/apache2"]
   ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

.. If you need to write a starter script for a single executable, you can ensure that the final executable receives the Unix signals by using exec and gosu commands:

実行ファイルの :ruby:`起動スクリプト <starter script>` を書く必要がある場合は、最後に起動する実行ファイルが Unix シグナルを確実に受信するようにするには、 ``exec`` と ``gosu`` コマンドを使えます。

.. code-block:: bash

   #!/usr/bin/env bash
   set -e
   
   if [ "$1" = 'postgres' ]; then
       chown -R postgres "$PGDATA"
   
       if [ -z "$(ls -A "$PGDATA")" ]; then
           gosu postgres initdb
       fi
   
       exec gosu postgres "$@"
   fi
   
   exec "$@"

.. Lastly, if you need to do some extra cleanup (or communicate with other containers) on shutdown, or are co-ordinating more than one executable, you may need to ensure that the ENTRYPOINT script receives the Unix signals, passes them on, and then does some more work:

最後に、 :ruby:`停止時 <shutdown>` に追加のクリーンアップ（あるいは他のコンテナとの通信）をする場合や、複数の実行ファイルを組み合わせている場合は、 ``ENTRYPOINT`` スクリプトが Unix シグナルを受信し、続いて、他の処理を行うようにする必要があります。

.. code-block:: bash

   #!/bin/sh
   # メモ：sh でスクリプトを書いたため、buxybox コンテナも動作する
      
   # サービスの停止後に、必要があれば手動でクリーンアップできるようにする場合や、
   # 1つのコンテナ内で複数のサービスを起動できるようにする場合には、トラップを使う
   trap "echo TRAPed signal" HUP INT QUIT TERM
   
   # ここでは、バックグラウンドでサービスを起動
   /usr/sbin/apachectl start
   
   echo "[hit enter key to exit] or run 'docker stop <container>'"
   read
   
   # ここでは、サービスの停止とクリーンアップ
   echo "stopping apache"
   /usr/sbin/apachectl stop
   
   echo "exited $0"

.. If you run this image with docker run -it --rm -p 80:80 --name test apache, you can then examine the container’s processes with docker exec, or docker top, and then ask the script to stop Apache:

このイメージを ``docker run -it --rm -p 80:80 --name test apache`` で実行すると、以後、 ``docker exec`` や ``docker top`` でコンテナのプロセスを確認できます。その後、Apache を :ruby:`停止 <stop>` するようにスクリプトへ求めします。

.. code-block:: bash

   $ docker exec -it test ps aux
   
   USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
   root         1  0.1  0.0   4448   692 ?        Ss+  00:42   0:00 /bin/sh /run.sh 123 cmd cmd2
   root        19  0.0  0.2  71304  4440 ?        Ss   00:42   0:00 /usr/sbin/apache2 -k start
   www-data    20  0.2  0.2 360468  6004 ?        Sl   00:42   0:00 /usr/sbin/apache2 -k start
   www-data    21  0.2  0.2 360468  6000 ?        Sl   00:42   0:00 /usr/sbin/apache2 -k start
   root        81  0.0  0.1  15572  2140 ?        R+   00:44   0:00 ps aux
   
   $ docker top test
   
   PID                 USER                COMMAND
   10035               root                {run.sh} /bin/sh /run.sh 123 cmd cmd2
   10054               root                /usr/sbin/apache2 -k start
   10055               33                  /usr/sbin/apache2 -k start
   10056               33                  /usr/sbin/apache2 -k start
   
   $ /usr/bin/time docker stop test
   
   test
   real	0m 0.27s
   user	0m 0.03s
   sys	0m 0.03s

..    Note
    You can override the ENTRYPOINT setting using --entrypoint, but this can only set the binary to exec (no sh -c will be used).

.. note::

   ``ENTRYPOINT`` 設定は ``--entrypoint`` を使って上書きできます。しかし、ここでの設定は、実行ファイルとしての :ruby:`処理 <exec>` だけです（ ``sh -c`` は使いません）。

..    Note
    The exec form is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘).

.. note::

   *exec* 形式は JSON 配列として解釈されますので、単語を囲むにはシングルクオート（'）ではなくダブルクオート（"）を使う必要があります。

.. Unlike the shell form, the exec form does not invoke a command shell. This means that normal shell processing does not happen. For example, ENTRYPOINT [ "echo", "$HOME" ] will not do variable substitution on $HOME. If you want shell processing then either use the shell form or execute a shell directly, for example: ENTRYPOINT [ "sh", "-c", "echo $HOME" ]. When using the exec form and executing a shell directly, as in the case for the shell form, it is the shell that is doing the environment variable expansion, not docker.

*シェル* 形式とは異なり、 *exec* 形式はコマンドシェルを呼び出しません。つまり、通常のシェルとしての処理が怒らないのを意味します。たとえば、 ``ENTRYPOINT [ "echo", "$HOME" ]`` では、 ``$HOME`` を変数展開しません。シェルとしての処理を行いたい場合には、 *シェル* 形式を使うか、 ``ENTRYPOINT [ "sh", "-c", "echo $HOME" ]`` のようにシェルを直接実行します。exec 形式を使って直接シェルを実行する場合は、シェル形式の場合と同様に、環境変数の展開をするのはシェルであり、 Docker ではありません。

.. Shell form ENTRYPOINT example

.. _shell-form-entrypoint-example:

シェル形式の ENTRYPOINT 例
------------------------------

.. You can specify a plain string for the ENTRYPOINT and it will execute in /bin/sh -c. This form will use shell processing to substitute shell environment variables, and will ignore any CMD or docker run command line arguments. To ensure that docker stop will signal any long running ENTRYPOINT executable correctly, you need to remember to start it with exec:

単に文字列を ``ENTRYPOINT``` で指定するだけで、 ``/bin/sh -c`` の中で実行できます。この形式では、環境変数を展開するためにシェルの処理を使います。そして、 ``CMD`` や ``docker run`` コマンドラインでの引数は無視されます。長期に実行している ``ENTRYPOINT`` の実行バイナリに対し、 ``docker stop`` で適切にシグナルを送るには、 ``exec`` で起動する必要があるのを念頭に置いてください。

::

   FROM ubuntu
   ENTRYPOINT exec top -b

.. When you run this image, you’ll see the single PID 1 process:

このイメージで実行すると、 ``PID 1`` のプロセスが1つ見えます。

.. code-block:: bash

   $ docker run -it --rm --name test top
   
   Mem: 1704520K used, 352148K free, 0K shrd, 0K buff, 140368121167873K cached
   CPU:   5% usr   0% sys   0% nic  94% idle   0% io   0% irq   0% sirq
   Load average: 0.08 0.03 0.05 2/98 6
     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
       1     0 root     R     3164   0%   0% top -b

.. Which exits cleanly on docker stop:

``docker stop`` でクリーンに終了します。

.. code-block:: bash

   $ /usr/bin/time docker stop test
   
   test
   real	0m 0.20s
   user	0m 0.02s
   sys	0m 0.04s

.. If you forget to add exec to the beginning of your ENTRYPOINT:

仮に、 ``ENTRYPOINT`` のはじめに ``exec`` を追加し忘れたとします。

::

   FROM ubuntu
   ENTRYPOINT top -b
   CMD --ignored-param1


.. You can then run it (giving it a name for the next step):

そして、これを使って起動します（指定した名前は次のステップで使います）。

.. code-block:: bash

   $ docker run -it --name test top --ignored-param2
   
   Mem: 1704184K used, 352484K free, 0K shrd, 0K buff, 140621524238337K cached
   CPU:   9% usr   2% sys   0% nic  88% idle   0% io   0% irq   0% sirq
   Load average: 0.01 0.02 0.05 2/101 7
     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
       1     0 root     S     3168   0%   0% /bin/sh -c top -b cmd cmd2
       7     1 root     R     3164   0%   0% top -b

.. You can see from the output of top that the specified ENTRYPOINT is not PID 1.

``top`` の出力から、 ``ENTRYPOINT`` の指定したものが ``PID 1`` ではないのが分かります。

.. If you then run docker stop test, the container will not exit cleanly - the stop command will be forced to send a SIGKILL after the timeout:

``docker stop test`` を実行しても、コンテナはきれいに終了しません。 ``stop``  コマンドはタイムアウト後に ``SIGKILL``  を強制送信するからです。

.. code-block:: bash

   $ docker exec -it test ps aux
   
   PID   USER     COMMAND
       1 root     /bin/sh -c top -b cmd cmd2
       7 root     top -b
       8 root     ps aux
   
   $ /usr/bin/time docker stop test
   
   test
   real	0m 10.19s
   user	0m 0.04s
   sys	0m 0.03s

.. Understand how CMD and ENTRYPOINT interact

.. _understand-how-cmd-and-entrypoint-interact:

CMD と ENTRYPOINT の連携を理解
----------------------------------------

.. Both CMD and ENTRYPOINT instructions define what command gets executed when running a container. There are few rules that describe their co-operation.

``CMD`` と ``ENTRYPOINT`` 命令は、どちらもコンテナ起動時に何のコマンドを実行するか定義します。命令を書くにあたり、両方が連携するには、いくつかのルールがあります。

..    Dockerfile should specify at least one of CMD or ENTRYPOINT commands.
    ENTRYPOINT should be defined when using the container as an executable.
    CMD should be used as a way of defining default arguments for an ENTRYPOINT command or for executing an ad-hoc command in a container.
    CMD will be overridden when running the container with alternative arguments.

1. Dockerfile は、少なくとも1つの ``CMD`` か ``ENTRYPOINT`` 命令を書くべきです。
2. ``ENTRYPOINT`` は、コンテナを :ruby:`実行バイナリ <exeutable>` のように扱いたい場合に定義すべきです。
3. ``CMD`` は、 ``ENTRYPOINT`` コマンドに対するデフォルトの引数を定義するためか、、コンテナ内でその場その場でコマンドを実行するために使うべきです。
4. ``CMD`` は、コンテナの実行時に、ほかの引数で上書きされる場合があります。

.. The table below shows what command is executed for different ENTRYPOINT / CMD combinations:

以下の表は、 ``ENTRYPOINT`` と ``CMD`` の組み合わせで、どのような処理が行われるかを示します。

.. list-table::
   :header-rows: 1
   
   * - 
     - ENTRYPOINT なし
     - ENTRYPOINT exec_entry p1_entry
     - ENTRYPOINT [“exec_entry”, “p1_entry”]
   * - **CMD なし**
     - エラー。実行できない。
     - /bin/sh -c exec_entry p1_entry
     - exec_entry p1_entry
   * - **CMD [“exec_cmd”, “p1_cmd”]**
     - exec_cmd p1_cmd
     - /bin/sh -c exec_entry p1_entry exec_cmd p1_cmd
     - exec_entry p1_entry exec_cmd p1_cmd
   * - **CMD [“p1_cmd”, “p2_cmd”]**
     - p1_cmd p2_cmd
     - /bin/sh -c exec_entry p1_entry p1_cmd p2_cmd
     - exec_entry p1_entry p1_cmd p2_cmd
   * - **CMD exec_cmd p1_cmd**
     - /bin/sh -c exec_cmd p1_cmd
     - /bin/sh -c exec_entry p1_entry /bin/sh -c exec_cmd p1_cmd
     - exec_entry p1_entry /bin/sh -c exec_cmd p1_cmd

..     Note
    If CMD is defined from the base image, setting ENTRYPOINT will reset CMD to an empty value. In this scenario, CMD must be defined in the current image to have a value.

.. note::

   ベース・イメージで ``CMD`` が定義されている場合でも、 ``ENTRYPOINT`` の設定によって ``CMD`` は空の値にリセットされます。このような場合は、現在のイメージで何らかの値を持つように、 ``CMD`` を定義する必要があります。


.. _builder-volume:

VOLUME
==========

::

   VOLUME ["/data"]

.. The VOLUME instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers. The value can be a JSON array, VOLUME ["/var/log/"], or a plain string with multiple arguments, such as VOLUME /var/log or VOLUME /var/log /var/db. For more information/examples and mounting instructions via the Docker client, refer to Share Directories via Volumes documentation.

``VOLUME`` 命令は、指定した名前で :ruby:`マウントポイント <mount point>` を作成します。そして、（Docker が動いている）自ホスト上や他のコンテナといった、外部からマウントされたボリュームを収容する場所として、そのマウントポイントが示します。ここでの値は ``VOLUME ["/var/log/"]`` のような JSON 配列か、 ``VOLUME /var/log`` や ``VOLUME /var/log /var/db`` のような複数の引数を持つ単なる文字列です。　詳しい情報やサンプル、Docker クライアントを経由してマウントする方法は :ref:`ボリュームを通したディレクトリ共有 <mount-a-host-directory-as-a-data-volume>` を参照ください。

.. The docker run command initializes the newly created volume with any data that exists at the specified location within the base image. For example, consider the following Dockerfile snippet:

``docker run`` 命令は、ベース・イメージ内で指定した場所に何かデータがあっても、そこを新規に作成するボリュームとして初期化します。例えば、次のような Dockerfile の抜粋で考えます。

::

   FROM ubuntu
   RUN mkdir /myvol
   RUN echo "hello world" > /myvol/greeting
   VOLUME /myvol

.. This Dockerfile results in an image that causes docker run to create a new mount point at /myvol and copy the greeting file into the newly created volume.

この Dockerfile で ``docker run`` によって作成されるイメージとは、新しいマウントポイントを ``/myvol`` へ作成し、（その場所にあった） ``greeting`` ファイルを新規作成するボリュームへコピーします。

.. Notes about specifying volumes

.. _notes-about-specifying-volumes:

ボリューム指定についての注意
------------------------------

.. Keep the following things in mind about volumes in the Dockerfile.

``Dockerfile`` 内でのボリュームの扱いについては、以下の点に注意してください。

..     Volumes on Windows-based containers: When using Windows-based containers, the destination of a volume inside the container must be one of:
        a non-existing or empty directory
        a drive other than C:
    Changing the volume from within the Dockerfile: If any build steps change the data within the volume after it has been declared, those changes will be discarded.
    JSON formatting: The list is parsed as a JSON array. You must enclose words with double quotes (") rather than single quotes (').
    The host directory is declared at container run-time: The host directory (the mountpoint) is, by its nature, host-dependent. This is to preserve image portability, since a given host directory can’t be guaranteed to be available on all hosts. For this reason, you can’t mount a host directory from within the Dockerfile. The VOLUME instruction does not support specifying a host-dir parameter. You must specify the mountpoint when you create or run the container.

* **Windows ベースのコンテナ上のボリューム** ： Windows ベースのコンテナを利用する場合、コンテナ内でのボリューム指定先は、次のどちらかの必要があります。

   * 存在していないディレクトリ、または、空のディレクトリ
   * C ドライブ以外

* **Dockerfile 内からのボリューム変更** ：ボリュームを宣言後、構築ステップでボリューム内のデータに対する変更があったとしても、それらの変更は破棄されます（反映されません）。
* **JSON 形式** ：引数リストは JSON 配列として扱われます。文字を囲むにはシングル・クォート（ ``'`` ）ではなくダブル・クォート（ ``"`` ）を使う必要があります。 
* **コンテナ実行時に宣言されるホスト側ディレクトリ** ： :ruby:`ホスト側ディレクトリ <host directory>` （マウントポイント）は、その性質上、ホストに依存します。これはイメージの移植性を維持するためであり、指定対象のホスト側ディレクトリが、全てのホスト上で利用可能である保証がないためです。この理由により、Dockerfile 内からホスト側ディレクトリをマウントできません。 ``VOLUME`` 命令は、一切の ```ホスト側ディレクトリ`` に対するパラメータ指定をサポートしません。（ホスト側を指定する必要がある場合は）コンテナの実行時や作成時に、マウントポイントを指定しなくてはいけません。

.. USER

.. _builder-user:

USER
==========

::

   USER <ユーザ>[:<グループ>]

.. or

または

::

   USER <UID>[:<GID>]

.. The USER instruction sets the user name (or UID) and optionally the user group (or GID) to use when running the image and for any RUN, CMD and ENTRYPOINT instructions that follow it in the Dockerfile.

 ``USER`` 命令は、イメージの実行時のユーザ名（あるいは UID）を指定し、オプションでユーザ・グループ（あるいは GID）も指定します。さらに、 ``Dockerfile`` 内で ``RUN`` 、 ``CMD`` 、 ``ENTRYPOINT`` の各命令を処理する時のユーザ名とグループの指定にもなります。

.. Note that when specifying a group for the user, the user will have only the specified group membership. Any other configured group memberships will be ignored.

.. note::

   ユーザに対してグループを指定する場合、そのユーザは指定したグループに「のみ」所属しますので注意してください。他のグループ所属の設定は無視されます。

.. When the user doesn’t have a primary group then the image (or the next instructions) will be run with the root group.
   On Windows, the user must be created first if it’s not a built-in account. This can be done with the net user command called as part of a Dockerfile.

.. warning::

   ユーザに対して所属グループの指定が無ければ、イメージ（または以降の命令）の実行時に ``root`` グループとして実行されます。
   Windows では、まず、初期に作成済みではないユーザを作成が必要です。これをするには、 Dockerfile で ``net user`` コマンドを使う必要があります。
   
   ::
   
      FROM microsoft/windowsservercore
      # コンテナ内で Windows ユーザを作成
      RUN net user /add patrick
      # 次のコマンドを指定
      USER patrick

.. _builder-workdir:

WORKDIR
==========

::

   WORKDIR /path/to/workdir

.. The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile. If the WORKDIR doesn’t exist, it will be created even if it’s not used in any subsequent Dockerfile instruction.

``WORKDIR`` 命令は、``Dockerfile`` 内で以降に続く ``RUN`` 、 ``CMD`` 、 ``ENTRYPOINT`` 、 ``COPY`` 、 ``ADD`` 命令の処理時に（コマンドを実行する場所として）使う :ruby:`作業ディレクトリ <working directory>` を指定します。 ``WORKDIR`` が存在していなければ作成されます。これは、以降の ``Dockerfile`` で使われなくてもです。

.. The WORKDIR instruction can be used multiple times in a Dockerfile. If a relative path is provided, it will be relative to the path of the previous WORKDIR instruction. For example:

``WORKDIR`` 命令は ``Dockerifle`` 内で何度も利用できます。相対パスを指定すると、その前の ``WORKDIR`` 命令で指定された場所に対する相対パスになります。

::

   WORKDIR /a
   WORKDIR b
   WORKDIR c
   RUN pwd

.. The output of the final pwd command in this Dockerfile would be /a/b/c.

この ``Dockerfile`` で、最後の ``pwd`` コマンドの出力は ``/a/b/c`` になります。

.. The WORKDIR instruction can resolve environment variables previously set using ENV. You can only use environment variables explicitly set in the Dockerfile. For example:

``WORKDIR`` 命令は、 ``ENV`` 命令で設定済みの環境変数を展開できます。利用できる環境変数は、 ``Dockerfile`` で明示したものだけです。例：

::

   ENV DIRPATH /path
   WORKDIR $DIRPATH/$DIRNAME
   RUN pwd

.. The output of the final pwd command in this Dockerfile would be /path/$DIRNAME

この ``Dockerfile`` では、最後の ``pwd`` コマンドの出力は ``/path/$DIRNAME`` になります。

.. _builder-arg:

ARG
==========

::

   ARG <名前>[=<デフォルト値>]

.. The ARG instruction defines a variable that users can pass at build-time to the builder with the docker build command using the --build-arg <varname>=<value> flag. If a user specifies a build argument that was not defined in the Dockerfile, the build outputs a warning.

``ARG`` 命令は :ruby:`構築時 <build-time>` にユーザが渡せる変数を定義します。変数を渡すには、構築時に ``docker biuld`` コマンドで ``--build-arg <変数名>=<値>`` を指定します。もしも、ユーザが構築時に引数を指定しても、 Dockerfile 中で指定が無ければ、構築時に警告が出ます。

.. code-block:: bash

   [Warning] One or more build-args [foo] were not consumed.

（[警告] build-arg [foo] は使われませんでした）

.. A Dockerfile may include one or more ARG instructions. For example, the following is a valid Dockerfile:

Dockerfile に1つまたは複数の ``ARG`` 命令を入れられます。たとえば、以下は正しい Dockerfile です。

::

   FROM busybox
   ARG user1
   ARG buildno
   # ...

..     Warning:
    It is not recommended to use build-time variables for passing secrets like github keys, user credentials etc. Build-time variable values are visible to any user of the image with the docker history command.
    Refer to the “build images with BuildKit” section to learn about secure ways to use secrets when building images.

.. warning::

   GitHub キーやユーザの認証情報のような :ruby:`機微情報（シークレット） <secret>` を、構築時に変数として使うのは推奨しません。これは、どのようなイメージも ``docker history`` コマンドを使えば、構築時の変数を表示できるからです。
   
   イメージ構築時に機微情報（シークレット）を安全に使う方法を学ぶには、 :ref:`BuildKit でイメージを構築 <new-docker-build-secret-information>` をご覧ください。

.. Default values

.. _builder-default-value:

デフォルトの値
--------------------

.. An ARG instruction can optionally include a default value:

オプションで、``ARG`` 命令にデフォルト値を指定できます。

::

   FROM busybox
   ARG user1=someuser
   ARG buildno=1
   ...

.. If an ARG instruction has a default value and if there is no value passed at build-time, the builder uses the default.

もし ``ARG`` 命令にデフォルト値があり、構築時に値の指定が無ければ、ビルダーはデフォルト値を使います。

.. Scope

.. _builder-scope:

変数の範囲
--------------------

.. An ARG variable definition comes into effect from the line on which it is defined in the Dockerfile not from the argument’s use on the command-line or elsewhere. For example, consider this Dockerfile:

``ARG`` 変数の定義が有効になるのは、 ``Dockerfile`` で定義された後の行であり、コマンドライン上などでの引数ではありません。たとえば、このような Dockerfile を例に考えましょう。

   FROM busybox
   USER ${user:-some_user}
   ARG user
   USER $user
   ...

.. A user builds this file by calling:

このファイルを使って構築するには、次のコマンドを実行するとします。

.. code-block:: bash

   $ docker build --build-arg user=what_user .

.. The USER at line 2 evaluates to some_user as the user variable is defined on the subsequent line 3. The USER at line 4 evaluates to what_user as user is defined and the what_user value was passed on the command line. Prior to its definition by an ARG instruction, any use of a variable results in an empty string.

.. 2行目の ``USER`` 命令は、この時点では（ARG 命令がなく、かつ、変数 user の値が定義されていないため、変数 user の値は） ``some_user`` として処理されます。つまり、続く3行目（にある ARG 命令）では、 ``user`` 変数を定義しています。さらに、4行目の ``USER`` 命令では、変数 ``user`` は ``what_user`` として処理されるるのですが、これは ``what_user`` の値が定義済みであり、かつ、コマンドラインで ``what_user`` の値が指定されたからです。 ``ARG`` 命令で定義するまでは、変数を使っても値は空白の文字列として処理されます。

.. ※直訳しても日本語として理解しづらいので、書き換え

構築時、コマンドラインの引数で変数の値を指定していても、 ``ARG`` 命令で変数を定義するまでは、その変数の値は空白の文字列として扱われます。2行目の ``USER`` 命令は、この時点では変数 ``$user``  に対する値が定義されていないため、変数 ``$user`` の値は ``some_user`` として処理されます（シェルなどの変数展開と同じで、 ``${user:-some_user}`` は、変数 ``$user`` の値が未定義であれば、 ``some_user`` を値に入れる処理です ）。続く3行目の ``ARG`` 命令により、コマンドラインで指定した引数 ``what_user`` が、変数 ``$user`` に対する値として設定されます。そして、4行目の ``USER`` 命令で使われている ``$user`` は ``what_user`` になります。

.. An ARG instruction goes out of scope at the end of the build stage where it was defined. To use an arg in multiple stages, each stage must include the ARG instruction.

``ARG`` 命令が有効な範囲は、構築ステージの定義が終わるまでです。複数のステージで :ruby:`引数 <arg>` を使うには、ステージごとに ``ARG`` 命令が必要です。

::

   FROM busybox
   ARG SETTINGS
   RUN ./run/setup $SETTINGS

   FROM busybox
   ARG SETTINGS
   RUN ./run/other $SETTINGS

.. Using ARG variables

.. _using-arg-variables:

ARG で変数を使うには
--------------------

.. You can use an ARG or an ENV instruction to specify variables that are available to the RUN instruction. Environment variables defined using the ENV instruction always override an ARG instruction of the same name. Consider this Dockerfile with an ENV and ARG instruction.

 ``ARG`` 命令や ``ENV`` 命令で、 ``RUN`` 命令で利用可能な変数を指定できます。 ``ENV`` 命令を使って定義した環境変数は、常に同じ名前の ``ARG`` 命令を上書きします。次の ``ENV`` と ``ARG`` 命令のある Dockerfile を考えます。

::

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER v1.0.0
   RUN echo $CONT_IMG_VER


.. Then, assume this image is built with this comman

そして、次のコマンドでイメージを作ったとしましょう。

.. code-block:: bash

   $ docker build --build-arg CONT_IMG_VER=v2.0.1 Dockerfile

.. In this case, the RUN instruction uses v1.0.0 instead of the ARG setting passed by the user:v2.0.1 This behavior is similar to a shell script where a locally scoped variable overrides the variables passed as arguments or inherited from environment, from its point of definition.

この場合、 ``RUN`` 命令で使われる値は、ユーザが（コマンドラインで）指定した ``ARG`` 命令の値 ``v2.0.1`` ではなく ``v1.0.0`` です。これは、シェルスクリプトの挙動に似ています。定義した時点から、 :ruby:`ローカルな範囲の変数（ローカルスコープ変数） <locally scoped variable>` は、引数として指定した変数や、環境変数として継承された変数をで上書きします。

.. Using the example above but a different ENV specification you can create more useful interactions between ARG and ENV instructions:

先ほどの例と違う ``ENV`` 仕様を使えば、 ``ARG`` 命令と ``ENV`` 命令の間で、より役立つ相互関係を作れます。

::

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER ${CONT_IMG_VER:-v1.0.0}
   RUN echo $CONT_IMG_VER

``ARG`` 命令とは違い、 ``ENV`` の値は常に構築イメージ内に保持されます。 ``--build-arg`` フラグがない docker build を考えます。

.. code-block:: bash

   $ docker build .

.. Using this Dockerfile example, CONT_IMG_VER is still persisted in the image but its value would be v1.0.0 as it is the default set in line 3 by the ENV instruction.

この Dockerfile 例を使うと、  （docker build 時に引数の指定がなかったため）3行目の ``ENV`` 命令によってデフォルトの ``v1.0.0`` が変数 ``CONT_IMG_VER`` の値となり、この値がイメージ内でずっと保持されます。

.. The variable expansion technique in this example allows you to pass arguments from the command line and persist them in the final image by leveraging the ENV instruction. Variable expansion is only supported for a limited set of Dockerfile instructions.

今回の例にある変数展開の手法によって、コマンドラインから引数を渡し、 ``ENV`` 命令を利用して最終的なイメージまで保持できます。なお、変数展開をサポートしているのは、 :ref:`Dockerfile 命令の一部 <environment-replacement>` のみです。

.. Predefined ARGs

.. _predefined-args:

定義済みの ARG 変数
--------------------

.. Docker has a set of predefined ARG variables that you can use without a corresponding ARG instruction in the Dockerfile.

Docker には、Dockerfile 内で対応する ``ARG`` 命令を使わなくても利用できる :ruby:`定義済み <predefined>` の ``ARG`` 変数があります。

* ``HTTP_PROXY``
* ``http_proxy``
* ``HTTPS_PROXY``
* ``https_proxy``
* ``FTP_PROXY``
* ``ftp_proxy``
* ``NO_PROXY``
* ``no_proxy``

.. To use these, pass them on the command line using the --build-arg flag, for example:

これらの変数を使うには、コマンドライン上の ``--build-arg`` フラグで渡します。

.. code-block:: bash

   $ docker build --build-arg CONT_IMG_VER=v2.0.1 .

.. By default, these pre-defined variables are excluded from the output of docker history. Excluding them reduces the risk of accidentally leaking sensitive authentication information in an HTTP_PROXY variable.

デフォルトでは、これらの定義済み変数は ``docker history`` の出力から除外されます。それらを除外することで、 ``HTTP_PROXY`` 変数のような機微情報が漏洩する危険性を減らします。

.. For example, consider building the following Dockerfile using --build-arg HTTP_PROXY=http://user:pass@proxy.lon.example.com

たとえば、次の Dockerifle を使い 、 `` --build-arg HTTP_PROXY=http://user:pass@proxy.lon.example.com`` で構築する例を考えます。

::

   FROM ubuntu
   RUN echo "Hello World"

.. In this case, the value of the HTTP_PROXY variable is not available in the docker history and is not cached. If you were to change location, and your proxy server changed to http://user:pass@proxy.sfo.example.com, a subsequent build does not result in a cache miss.

こうすると、 ``HTTP_PROXY`` 変数の値は ``docker history`` で見えなくなり、キャッシュもされません。もしも、プロキシサーバの場所が ``http://user:pass@proxy.sfo.example.com`` に変わったとしても、以後の構築で（誤った情報を）キャッシュすることによる構築失敗もありません。

.. If you need to override this behaviour then you may do so by adding an ARG statement in the Dockerfile as follows:

このような挙動を上書きしたい場合は、次の Dockerfile のような ``ARG`` 命令を追加します。

::

   FROM ubuntu
   ARG HTTP_PROXY
   RUN echo "Hello World"

.. When building this Dockerfile, the HTTP_PROXY is preserved in the docker history, and changing its value invalidates the build cache.

この Dockerfile で構築すると、 ``HTTP_PROXY`` は ``docker history`` （で見えるように）保存され、この値を変更すると構築キャッシュは無効化されます。

.. Automatic platform ARGs in the global scope

.. _automatic-platform-args-in-the-global-scope:

グローバル範囲での自動的なプラットフォーム ARG 変数
------------------------------------------------------------

.. This feature is only available when using the BuildKit backend.

この機能が利用できるのは、 :ref:`BuildKit <builder-buildkit>` バックエンドを利用する時のみです。

.. Docker predefines a set of ARG variables with information on the platform of the node performing the build (build platform) and on the platform of the resulting image (target platform). The target platform can be specified with the --platform flag on docker build.

構築を処理するノード（ :ruby:`構築プラットフォーム <build platform>`  ）と、結果として作成されるイメージ（ :ruby:`ターゲット・プラットフォーム <target platform>` ）の、各プラットフォームに関する情報を Docker では ``ARG`` 変数として定義済みです。ターゲット・プラットフォームは ``docker build`` の ``--platform`` フラグで指定できます。

.. The following ARG variables are set automatically:

以下の ``ARG`` 変数は自動的に設定されます。

..    TARGETPLATFORM - platform of the build result. Eg linux/amd64, linux/arm/v7, windows/amd64.
    TARGETOS - OS component of TARGETPLATFORM
    TARGETARCH - architecture component of TARGETPLATFORM
    TARGETVARIANT - variant component of TARGETPLATFORM
    BUILDPLATFORM - platform of the node performing the build.
    BUILDOS - OS component of BUILDPLATFORM
    BUILDARCH - architecture component of BUILDPLATFORM
    BUILDVARIANT - variant component of BUILDPLATFORM



* ``TARGETPLATFORM`` … :ruby:`構築対象 <build result>` のプラットフォーム。例： ``linux/amd64`` 、 ``linux/arm/v7`` 、 ``windows/amd64`` 
* ``TARGETOS`` … TARGETPLATFORM の OS コンポーネント
* ``TARGETARCH`` … TARGETPLATFORM のアーキテクチャ・コンポーネント
* ``TARGETVARIANT`` … TARGETPLATFORM の派生コンポーネント
* ``BUILDPLATFORM … 構築を処理するノードのプラットフォーム
* ``BUILDOS`` … BUILDPLATFORM の OS コンポーネント
* ``BUILDARCH`` … BUILDPLATFORM のアーキテクチャ・コンポーネント
* ``BUILDVARIANT`` … BUILDPLATFORM の派生コンポーネント

.. These arguments are defined in the global scope so are not automatically available inside build stages or for your RUN commands. To expose one of these arguments inside the build stage redefine it without value.

これらの引数はグローバル :ruby:`スコープ（範囲） <scope>` として定義されているため、構築ステージ内や、そのステージ内の ``RUN`` コマンドから自動的に利用できません。これらの引数を構築ステージの中で利用するには、値なしで定義します。

.. For example:

例：

::

   FROM alpine
   ARG TARGETPLATFORM
   RUN echo "I'm building for $TARGETPLATFORM"

.. Impact on build caching

.. _impact-on-build-caching:

構築キャッシュへの影響
------------------------------

.. ARG variables are not persisted into the built image as ENV variables are. However, ARG variables do impact the build cache in similar ways. If a Dockerfile defines an ARG variable whose value is different from a previous build, then a “cache miss” occurs upon its first usage, not its definition. In particular, all RUN instructions following an ARG instruction use the ARG variable implicitly (as an environment variable), thus can cause a cache miss. All predefined ARG variables are exempt from caching unless there is a matching ARG statement in the Dockerfile.

``ARG`` 変数は ``ENV`` 変数と異なり、構築イメージ内に保持されません。しかしながら、 ``ARG`` 変数も（ ENV と）同じように構築キャッシュに影響を与えます。たとえば、 Dockerfile で以前に構築されたものと異なる ``ARG`` 変数が定義された場合は、定義がどうであろうと、真っ先に「 :ruby:`キャッシュ失敗 <cache miss>` 」が発生します。特に、全ての ``RUN`` 命令は ``ARG`` 命令で指定された ``ARG`` 変数を自動的に（環境変数として）扱います。つまり、これによって失敗が発生する可能性があります。全ての定義済み ``ARG`` 変数は、 ``Dockerfile`` 内で一致する ``ARG`` 命令がなければ、キャッシュから除外されます。

.. For example, consider these two Dockerfile:

たとえば、これら2つの Dockerfile で考えましょう。

::

   FROM ubuntu
   ARG CONT_IMG_VER
   RUN echo $CONT_IMG_VER

::

   FROM ubuntu
   ARG CONT_IMG_VER
   RUN echo hello

.. If you specify --build-arg CONT_IMG_VER=<value> on the command line, in both cases, the specification on line 2 does not cause a cache miss; line 3 does cause a cache miss.ARG CONT_IMG_VER causes the RUN line to be identified as the same as running CONT_IMG_VER=<value> echo hello, so if the <value> changes, we get a cache miss.

コマンドラインで ``--build-arg CONT_IMG_VER=<値>`` を指定すると、どちらの場合も2行目まではキャッシュ失敗は発生せず、3行目で失敗が発生します。 ``ARG CONT_IMG_VER`` によって、 RUN 行を ``CONT_IMG_VER=<value> echo hello`` として実行するように定義するのと同じです。つまり、 ``<値>`` が変わったため、キャッシュに失敗します。

.. Consider another example under the same command line:

同じコマンドラインで、別の例を考えます。

::

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER=$CONT_IMG_VER
   RUN echo $CONT_IMG_VER

.. In this example, the cache miss occurs on line 3. The miss happens because the variable’s value in the ENV references the ARG variable and that variable is changed through the command line. In this example, the ENV command causes the image to include the value.

この例では、3行目でキャッシュに失敗します。失敗するのは、 ``ENV`` にある変数の値が ``ARG`` 変数を参照し、かつ、その変数がコマンドラインを通して変更されるからです。この例では、 ``ENV`` 命令によってイメージの中に値が含まれます。

.. If an ENV instruction overrides an ARG instruction of the same name, like this Dockerfile:

``ENV`` 命令を、同じ名前の ``ARG`` で上書きする場合は、次のような Dockerifle になります。

::

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER=hello
   RUN echo $CONT_IMG_VER

.. Line 3 does not cause a cache miss because the value of CONT_IMG_VER is a constant (hello). As a result, the environment variables and values used on the RUN (line 4) doesn’t change between builds.

3行目の ``CONT_IMG_VER`` 値は定数（ ``hello`` ）のため、キャッシュ失敗は発生しません。結果として、 ``RUN`` （4行目）で使われる環境変数と値は、構築の間は変わりません。

.. _builder-onbuild:

ONBUILD
==========

::

   ONBUILD [命令]

.. The ONBUILD instruction adds to the image a trigger instruction to be executed at a later time, when the image is used as the base for another build. The trigger will be executed in the context of the downstream build, as if it had been inserted immediately after the FROM instruction in the downstream Dockerfile.

``ONBUILD`` 命令は、後から他のイメージ構築の基礎（ベース）として使われる時に、「 :ruby:`トリガ <trigger>` 」として実行する命令をイメージに追加します。トリガは後に続く（ダウンストリームの）コンテクストを構築時、ダウンストリームの ``Dockerfile`` にある ``FROM`` 命令の直後に、直ちに実行されます。

.. Any build instruction can be registered as a trigger.

あらゆる構築命令をトリガとして登録できます。

.. This is useful if you are building an image which will be used as a base to build other images, for example an application build environment or a daemon which may be customized with user-specific configuration.

他のイメージを構築する時に、その基礎となるイメージを構築するのに役立ちます。たとえば、アプリケーションの構築環境や、ユーザ固有の設定でカスタマイズ可能なデーモンです。

.. For example, if your image is a reusable Python application builder, it will require application source code to be added in a particular directory, and it might require a build script to be called after that. You can’t just call ADD and RUN now, because you don’t yet have access to the application source code, and it will be different for each application build. You could simply provide application developers with a boilerplate Dockerfile to copy-paste into their application, but that is inefficient, error-prone and difficult to update because it mixes with application-specific code.

たとえば、イメージが再利用可能な Python アプリケーションを構築するもの（ビルダ）であれば、特定のディレクトリに対してアプリケーションのソースコードを追加する必要があり、さらに、後から構築用スクリプトを呼び出す必要がある場合もあるでしょう。この時点では ``ADD`` と ``RUN`` 命令を呼び出せません。なぜなら、まだアプリケーションのソースコードにアクセスできず、さらに、アプリケーションごとにソースコードが異なるからです。これをシンプルに実現するには、アプリケーション開発者がテンプレートとなる ``Dockerfile`` をアプリケーションごとにコピー＆ペーストする方法があります。しかしこれは、アプリケーション固有のコードが混在すると、効率が悪く、エラーも発生しがちであり、更新も困難です。

.. The solution is to use ONBUILD to register advance instructions to run later, during the next build stage.

この解決策は ``ONBLUD`` 命令を使い、次の構築ステージ中に、後で実行する高度な命令を登録します。

.. Here’s how it works:

これは、次のように動作します：

..    When it encounters an ONBUILD instruction, the builder adds a trigger to the metadata of the image being built. The instruction does not otherwise affect the current build.
    At the end of the build, a list of all triggers is stored in the image manifest, under the key OnBuild. They can be inspected with the docker inspect command.
    Later the image may be used as a base for a new build, using the FROM instruction. As part of processing the FROM instruction, the downstream builder looks for ONBUILD triggers, and executes them in the same order they were registered. If any of the triggers fail, the FROM instruction is aborted which in turn causes the build to fail. If all triggers succeed, the FROM instruction completes and the build continues as usual.
    Triggers are cleared from the final image after being executed. In other words they are not inherited by “grand-children” builds.

1. ``ONBUILD`` 命令が発生すると、ビルダーは構築中のイメージ内に、トリガをメタデータとして追加します。現時点での構築では、この命令は何ら影響を与えません。
2. 構築後、すべてのトリガ一覧は、イメージのマニフェスト ``OnBuild`` キー以下に保管されます。これらは ``docker inspect`` コマンドで調べられます。
3. 後ほど、このイメージを新しい構築のベースとして用いるため、``FROM`` 命令で呼び出されるでしょう。 ``FROM`` 命令の処理の一部として、ダウンストリームのビルダーは ``ONBUILD`` トリガを探します。そして、トリガが登録されたのと同じ順番で、トリガを実行します。もしもトリガの1つでも失敗すると、 ``FROM`` 命令は処理が中止となり、構築は失敗します。全てのトリガ処理が成功すると、 ``FROM`` 命令は完了し、以降は通常通り構築が進行します。
4. 最後の処理がおわった後、最終イメージからトリガは削除されます。言い換えると、「 :ruby:`孫 <grand-children>` 」ビルドには継承されません。

.. For example you might add something like this:

たとえば、次のような追加となるでしょう。

::

   ONBUILD ADD . /app/src
   ONBUILD RUN /usr/local/bin/python-build --dir /app/src

..    Warning
    Chaining ONBUILD instructions using ONBUILD ONBUILD isn’t allowed.

.. warning::

   ``ONBUILD`` 命令をつなげ、 ``ONBUILD ONBUILD`` としては使えません。

..    Warning
    The ONBUILD instruction may not trigger FROM or MAINTAINER instructions.

.. warning::

   ``ONBLUID`` 命令は ``FROM``  や ``MAINTAINER`` 命令をトリガにできません。

.. STOPSIGNAL

.. _builder-stopsignal:

STOPSIGNAL
==========

::

   STOPSIGNAL 信号

.. The STOPSIGNAL instruction sets the system call signal that will be sent to the container to exit. This signal can be a valid unsigned number that matches a position in the kernel’s syscall table, for instance 9, or a signal name in the format SIGNAME, for instance SIGKILL.

``STOPSIGNAL`` 命令は、 :ruby:`システムコール信号 <system call signal>` を設定し、コンテナを :ruby:`終了 <exit>` するために送信されます。この信号（シグナル）は符号無し整数であり、カーネルの syscall 表の位置と一致します。たとえば、「9」であったり、 ``SIGKILL`` のような信号名の書式の :ruby:`信号 <signal>` です。

.. HEALTHCHECK

.. _builder-healthcheck:

HEALTHCHECK
====================

.. The HEALTHCHECK instruction has two forms:

``HEALTHCHECK`` 命令は２つの形式があります。

.. * `HEALTHCHECK [OPTIONS] CMD command` (check container health by running a command inside the container)
   * `HEALTHCHECK NONE` (disable any healthcheck inherited from the base image)

* ``HEALTHCHECK [オプション] CMD コマンド`` (コンテナ内部でコマンドを実行し、コンテナの正常性を確認)
* ``HEALTHCHECK NONE`` (ベースイメージから、ヘルスチェック設定の継承を無効化)

.. The HEALTHCHECK instruction tells Docker how to test a container to check that it is still working. This can detect cases such as a web server that is stuck in an infinite loop and unable to handle new connections, even though the server process is still running.

``HEALTHCHECK`` 命令は、Docker に対してコンテナのテスト方法を伝え、コンテナが動作し続けているかどうか確認します。これにより、ウェブサーバなどでサーバのプロセスが実行中にかかわらず、無限ループして詰まっていたり、新しい接続を処理できなかったりするような問題を検出します。

.. When a container has a healthcheck specified, it has a health status in addition to its normal status. This status is initially starting. Whenever a health check passes, it becomes healthy (whatever state it was previously in). After a certain number of consecutive failures, it becomes unhealthy.

コンテナで :ruby:`ヘルスチェック <healthcheck>` が指定されている場合は、通常のステータスに加え *health status* （ヘルスステータス）が追加されます。初期のステータスは ``starting`` （起動中）です。ヘルスチェックが正常であれば、（以前の状況にかかわらず）ステータスは ``healthy`` （正常）になります。何度か連続した :ruby:`失敗 <failure>` があれば、ステータスは ``unhealthy`` （障害発生）になります。

.. The options that can appear before CMD are:

``CMD`` よりも前に書いて、オプションを指定できます。

...    --interval=DURATION (default: 30s)
    --timeout=DURATION (default: 30s)
    --start-period=DURATION (default: 0s)
    --retries=N (default: 3)

* ``--interval=期間`` (デフォルト: `30s`) ※ヘルスチェックの間隔
* ``--timeout=期間`` (デフォルト: `30s`) ※タイムアウトの長さ
* ``--start-period=期間`` (デフォルト: `0s`) ※ 開始時の間隔
* ``--retries=`` (デフォルト: `3`) ※リトライ回数

.. The health check will first run interval seconds after the container is started, and then again interval seconds after each previous check completes.

コンテナが起動し、（間隔で指定した） **interval** 秒後に、1回目のヘルスチェックを実行します。それから、再びヘルスチェックを前回のチェック完了後から、 **interval**  秒を経過するごとに行います。

.. If a single run of the check takes longer than timeout seconds then the check is considered to have failed.

信号を送信しても、 **タイムアウト** 秒まで処理に時間がかかっていれば、チェックに失敗したとみなされます。

.. It takes retries consecutive failures of the health check for the container to be considered unhealthy.

コンテナに対するヘルスチェックの失敗が、 **retries** で指定したリトライ回数に達すると、コンテナは ``unhealthy`` とみなされます。

.. start period provides initialization time for containers that need time to bootstrap. Probe failure during that period will not be counted towards the maximum number of retries. However, if a health check succeeds during the start period, the container is considered started and all consecutive failures will be counted towards the maximum number of retries.

コンテナが起動に必要な時間を、初期化する時間として **start period** で指定します。この期間中に :ruby:`プローブ障害 <probe failure>` が発生したとしても、最大リトライ回数としてはカウントされません。ですが、 start period の期間中にヘルスチェックが成功するとコンテナは起動したとみなされ、以降に連続した失敗があれば、最大リトライ回数までカウントされます。

.. There can only be one HEALTHCHECK instruction in a Dockerfile. If you list more than one then only the last HEALTHCHECK will take effect.

これらを指定できるのは、Dockerfile の ``HEALTHCHECK`` 命令のみです。複数の ``HEALTHCHECK`` 命令があれば、最後の1つのみ有効です。

.. The command after the CMD keyword can be either a shell command (e.g. HEALTHCHECK CMD /bin/check-running) or an exec array (as with other Dockerfile commands; see e.g. ENTRYPOINT for details).

``CMD`` キーワードの後に書くコマンドは、シェルコマンド（例： ``HEALTHCHECK CMD /bin/check-running`` ）か exec 配列（他の Dockerfile コマンドと同様です。詳細は ``ENTRYPOINT`` をご覧ください）のどちらか一方を使えます。

.. The command’s exit status indicates the health status of the container. The possible values are:

そのコマンドの終了ステータスが、対象となるコンテナのヘルスステータスになります。可能性のある値は、次の通りです。

..    0: success - the container is healthy and ready for use
    1: unhealthy - the container is not working correctly
    2: reserved - do not use this exit code

* 0: :ruby:`成功 <success>` コンテナは正常
* 1: ruby:`障害 <unhealthy>` 
* 2: ruby:`予約済み <reserved>` - この終了コードは使いません

.. For example, to check every five minutes or so that a web-server is able to serve the site’s main page within three seconds:

たとえば、ウェブサーバがサイトのメインページを3秒以内に提供できるかどうかを、5分ごとにチェックするには、次の様にします。

::

   HEALTHCHECK --interval=5m --timeout=3s \
     CMD curl -f http://localhost/ || exit 1

.. To help debug failing probes, any output text (UTF-8 encoded) that the command writes on stdout or stderr will be stored in the health status and can be queried with docker inspect. Such output should be kept short (only the first 4096 bytes are stored currently).

ヘルスチェックの失敗時に調査（デバッグ）をしやすくするために、

コマンドが書き込んだ標準出力や標準エラー出力といった、あらゆる出力文字（UTF-8 エンコード方式）がヘルスステータスに保存され、これらは ``docker inspect`` で調べられます。この出力は短く保たれます（初めから 4096 バイトのみ保存します）。

.. When the health status of a container changes, a health_status event is generated with the new status.

コンテナのヘルスステータスが変われば、新しいステータスで ``health_status`` イベントが作成されます。

.. SHELL

.. _builder-shell:

SHELL
==========

..   SHELL ["executable", "parameters"]

::

   SHELL ["実行ファイル", "パラメータ"]

.. The SHELL instruction allows the default shell used for the shell form of commands to be overridden. The default shell on Linux is ["/bin/sh", "-c"], and on Windows is ["cmd", "/S", "/C"]. The SHELL instruction must be written in JSON form in a Dockerfile.

``SHELL`` 命令は、 *シェル* 形式で使われるデフォルトのコマンドを上書きできます。 Linux 上でのデフォルトのシェルは ``["/bin/sh", "-c"]`` で、Windows は ``["cmd", "/S", "/C"]`` です。Dockerfile では、 ``SHELL`` 命令を JSON 形式で書く必要があります。

.. The SHELL instruction is particularly useful on Windows where there are two commonly used and quite different native shells: cmd and powershell, as well as alternate shells available including sh.

Windows 上では特に ``SHELL`` 命令が役立ちます。これは、一般的に使われるシェルが ``cmd`` と ``powershell`` の2種類ありますし、 ``sh`` を含む他のシェルも利用できるからです。

.. The SHELL instruction can appear multiple times. Each SHELL instruction overrides all previous SHELL instructions, and affects all subsequent instructions. For example:

``SHELL`` 命令は何度も指定できます。それぞれの ``SHELL`` 命令は、以前すべての ``SHELL`` 命令を上書きし、以降の命令で（新しく指定したシェルが）有効になります。以下は例です。

::

   FROM microsoft/windowsservercore

   # 「cmd /S /C echo default」として実行
   RUN echo default

   # 「cmd /S /C powershell -command Write-Host default」として実行
   RUN powershell -command Write-Host default

   # 「powershell -command Write-Host hello」として実行
   SHELL ["powershell", "-command"]
   RUN Write-Host hello

   # 「cmd /S /C echo hello」として実行
   SHELL ["cmd", "/S", "/C"]
   RUN echo hello

.. The following instructions can be affected by the SHELL instruction when the shell form of them is used in a Dockerfile: RUN, CMD and ENTRYPOINT.

``SHELL`` 命令によって効果があるのは、 Dockerfile でシェル形式として ``RUN`` 、 ``CMD`` 、 ``ENTRYPOINT`` を使う時です。

.. The following example is a common pattern found on Windows which can be streamlined by using the SHELL instruction:

以下の例は、Windows 上でよく見かける共通パターンであり、 ``SHELL`` 命令を使って効率化できます。

::

   RUN powershell -command Execute-MyCmdlet -param1 "c:\foo.txt"

.. The command invoked by docker will be:

Docker が呼び出すコマンドは、このようになります。

.. code-block:: bash

   cmd /S /C powershell -command Execute-MyCmdlet -param1 "c:\foo.txt"

.. This is inefficient for two reasons. First, there is an un-necessary cmd.exe command processor (aka shell) being invoked. Second, each RUN instruction in the shell form requires an extra powershell -command prefixing the command.

これには、効率的ではない2つの理由があります。まず1つは、不要な cmd.exe コマンドのプロセッサ（シェル）が呼び出されるからです。2つめは、各 ``RUN`` 命令はシェル形式のため、コマンドの前に追加で ``powershell -command`` の実行が必要になるからです。

.. To make this more efficient, one of two mechanisms can be employed. One is to use the JSON form of the RUN command such as:

これを効率的にするには、2つの仕組みのどちらか1つを使います。1つは、次のように RUN 命令のコマンドを JSON 形式で書きます。

::

   RUN ["powershell", "-command", "Execute-MyCmdlet", "-param1 \"c:\\foo.txt\""]

.. While the JSON form is unambiguous and does not use the un-necessary cmd.exe, it does require more verbosity through double-quoting and escaping. The alternate mechanism is to use the SHELL instruction and the shell form, making a more natural syntax for Windows users, especially when combined with the escape parser directive:

JSON 形式（で使うコマンドの指定）は明確であり、不要な cmd.exe を使いません。しかし、二重引用符（ダブルクォータ）やエスケープ処理が必要といった、冗長さがあります。もう1つの仕組みは、 ``SHELL`` 命令を使ってシェル形式にしますが、 ``escape`` パーサ・ディレクティブの指定があれば、 Windows ユーザにとって、より普通の書式で書けます（訳者捕捉： Dockerfile では、デフォルトのエスケープ文字は「\」ですが、Windows の場合「\」はパスの文字です。そのため、次の例のようにエスケープ文字を「`」などに変えると、Windows のパスがシェル形式でそのまま利用できるため、便利です）。

::

   # escape=`
   
   FROM microsoft/nanoserver
   SHELL ["powershell","-command"]
   RUN New-Item -ItemType Directory C:\Example
   ADD Execute-MyCmdlet.ps1 c:\example\
   RUN c:\example\Execute-MyCmdlet -sample 'hello world'

.. Resulting in:

結果は次のようになります。

.. code-block:: bash

   PS E:\myproject> docker build -t shell .
   
   Sending build context to Docker daemon 4.096 kB
   Step 1/5 : FROM microsoft/nanoserver
    ---> 22738ff49c6d
   Step 2/5 : SHELL powershell -command
    ---> Running in 6fcdb6855ae2
    ---> 6331462d4300
   Removing intermediate container 6fcdb6855ae2
   Step 3/5 : RUN New-Item -ItemType Directory C:\Example
    ---> Running in d0eef8386e97
   
   
       Directory: C:\
   
   
   Mode         LastWriteTime              Length Name
   ----         -------------              ------ ----
   d-----       10/28/2016  11:26 AM              Example
   
   
    ---> 3f2fbf1395d9
   Removing intermediate container d0eef8386e97
   Step 4/5 : ADD Execute-MyCmdlet.ps1 c:\example\
    ---> a955b2621c31
   Removing intermediate container b825593d39fc
   Step 5/5 : RUN c:\example\Execute-MyCmdlet 'hello world'
    ---> Running in be6d8e63fe75
   hello world
    ---> 8e559e9bf424
   Removing intermediate container be6d8e63fe75
   Successfully built 8e559e9bf424
   PS E:\myproject>

.. The SHELL instruction could also be used to modify the way in which a shell operates. For example, using SHELL cmd /S /C /V:ON|OFF on Windows, delayed environment variable expansion semantics could be modified.

また、シェルの動作を変更するためにも ``SHELL`` 命令が使えます。たとえば、 Windows 上で ``SHELL cmd /S /C /V:ON|OFF`` を使えば、 :ruby:`遅延環境変数 <delayed environment variable>` の展開方法を切り替えられます。

.. The SHELL instruction can also be used on Linux should an alternate shell be required such as zsh, csh, tcsh and others.

さらに、``SHELL`` 命令によって、Linux であれば ``zsh`` 、 ``csh`` 、 ``tcsh`` といった、他のシェルに切り替えられます。

.. Dockerfile examples

.. _dockerfile-examples:

Dockerifle の例
====================

Dockerfile の例は、以下をご覧ください。

- :doc:`「イメージ構築」のセクション </develop/develop-images/dockerfile_best-practices>` 
- :doc:`Get started - 始めましょう </get-started/index>`
- :doc:`言語別ガイド </language/index>`

.. seealso:: 

   Dockerfile reference
      https://docs.docker.com/engine/reference/builder/
