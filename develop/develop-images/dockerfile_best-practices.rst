.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
   doc version: 24.0
      https://github.com/docker/docker.github.io/blob/master/develop/develop-images/dockerfile_best-practices.md
.. check date: 2023/07/22
.. Commits on Jun 22, 2023 a1c30d0af927f7f4e90f5d2d426d99846c7221a0
.. -----------------------------------------------------------------------------

.. Best practices for writing Dockerfile
.. _best-practices-for-writing-dockerfile:

=======================================
Dockerfile を書くベストプラクティス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This topic covers recommended best practices and methods for building efficient images.

このトピックでは、効率的なイメージ構築を目的とした、ベストプラクティスと手法についてのアドバイスを扱います。

.. Docker builds images automatically by reading the instructions from a Dockerfile -- a text file that contains all commands, in order, needed to build a given image. A Dockerfile adheres to a specific format and set of instructions which you can find at Dockerfile reference.

Docker は Dockerfile に書かれた命令を読み込み、自動的にイメージを :ruby:`構築 <build>` します。この Dockerfile とはテキスト形式のファイルであり、イメージを構築するために必要となる、全ての命令を順番通りに記述します。 ``Dockerfile`` は特定の書式と命令群に忠実であり、それらは :doc:`Dockerfile リファレンス </engine/reference/builder>` で確認できます。

.. A Docker image consists of read-only layers each of which represents a Dockerfile instruction. The layers are stacked and each one is a delta of the changes from the previous layer. The following is the contents of an example Dockerfile:

Docker イメージを構成するのは、 Dockerfile の各命令に相当する、読み込み専用のレイヤ群です。それぞれのレイヤは直前のレイヤから変更した差分であり、これらのレイヤが積み重なっています。以下は Dockerfile 例の内容です。

.. code-block:: bash

   # syntax=docker/dockerfile:1
   FROM ubuntu:22.04
   COPY . /app
   RUN make /app
   CMD python /app/app.py

.. Each instruction creates one layer:

命令ごとに１つのレイヤを作成します。

..  FROM creates a layer from the ubuntu:22.04 Docker image.
    COPY adds files from your Docker client’s current directory.
    RUN builds your application with make.
    CMD specifies what command to run within the container.

* ``FROM`` は ``ubuntu:22.04`` の Docker イメージからレイヤを作成
* ``COPY`` は Docker クライアントで操作しているディレクトリから、ファイルを（コンテナのレイヤに）追加
* ``RUN`` はアプリケーションを ``make`` で構築
* ``CMD`` はコンテナ内で何のコマンドを実行するか指定

.. When you run an image and generate a container, you add a new writable layer, also called the container layer, on top of the underlying layers. All changes made to the running container, such as writing new files, modifying existing files, and deleting files, are written to this writable container layer.

イメージを実行してコンテナを生成するとき、元から存在するレイヤ上に新しい :ruby:`書き込み可能なレイヤ <writable layer>` を追加します。これは :ruby:`コンテナ・レイヤ <container layer>` とも呼ばれます。実行中のコンテナに対する全ての変更、例えば新しいファイル書き込み、既存ファイルの編集、ファイルの削除などは、この書き込み可能なコンテナ・レイヤ内に記述されます。

.. For more on image layers and how Docker builds and stores images, see About storage drivers.

イメージ・レイヤに関する詳しい情報や、 Docker のイメージ構築と保存の仕方は、 :doc:`ストレージ・ドライバについて </storage/storagedriver/index>` を御覧ください。

.. General guidelines and recommendations

.. _general-guidelines-and-recommendations:

一般的なガイドラインとアドバイス
================================

.. Create ephemeral containers

.. _create-ephemeral-containers:

一時的なコンテナを作成
------------------------------

.. The image defined by your Dockerfile should generate containers that are as ephemeral as possible. Ephemeral means that the container can be stopped and destroyed, then rebuilt and replaced with an absolute minimum set up and configuration.

Dockerfile で定義したイメージによって生成するコンテナは、可能な限り一時的（ :ruby:`エフェメラル <ephemeral>` ）であるべきです。一時的が意味するのは、コンテナとは停止および破棄可能であり、その後も極めて最小限のセットアップと設定により、再構築や置き換えが可能だからです。

.. Refer to Processes under The Twelve-factor App methodology to get a feel for the motivations of running containers in such a stateless fashion.

コンテナをステートレスな（状態を保持しない）手法で実行するための原動力を感じ取るには、「The Twelve-factor app」 手法の `Process <https://12factor.net/processes>`_ 以下を参照ください。

.. Understand build context

.. _understand-build-context:

ビルド コンテクストの理解
------------------------------

.. See Build context for more information.

詳しい情報は :doc:`ビルド コンテクスト </build/building/context>`  を御覧ください。


.. Pipe Dockerfile through stdin

.. _pipe-dockerfile-through-stdin:

標準入力を通して Dockerfile をパイプ
----------------------------------------

.. Docker has the ability to build images by piping a Dockerfile through stdin with a local or remote build context. Piping a Dockerfile through stdin can be useful to perform one-off builds without writing a Dockerfile to disk, or in situations where the Dockerfile is generated, and should not persist afterwards.

ローカル若しくはリモートのビルド・コンテクストを使い、標準入力（stdin）を通した Dockerfile のパイプにより、イメージを構築する機能が Docker にはあります。標準入力を通して Dockerfile をパイプすると、Dockerfile をディスクに書き込まないため、一回限りの構築を行いたい時に役立ちます。あるいは、 Dockerfile が生成された場所が、後で残らない状況でも役立つでしょう。

.. The examples in this section use here documents for convenience, but any method to provide the Dockerfile on stdin can be used.
.. For example, the following commands are equivalent:
.. You can substitute the examples with your preferred approach, or the approach that best fits your use-case.


.. note::

   **このセクションで扱う例は、便宜上** `ヒア・ドキュメント <https://tldp.org/LDP/abs/html/here-docs.html>`_ **を扱いますが、**  ``Dockerfile`` **には** ``stdin`` **を使う様々な手法が利用できます** 。

   例えば、以下のコマンドは、どちらも同じ処理をします。

   .. code-block:: bash
   
      echo -e 'FROM busybox\nRUN echo "hello world"' | docker build -
   
   .. code-block:: bash
   
      docker build -<<EOF
      FROM busybox
      RUN echo "hello world"
      EOF
   
   それぞれの例は、好きな方法や、利用例に一番あう方法に置き換えられます。

.. Build an image using a Dockerfile from stdin, without sending build context

.. _build-an-image-using-a-dockerfile-from-stdin,-without-sending-build-context:

ビルド・コンテクストを送信せず、stdin からの Dockerfile を使ってイメージ構築
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Use this syntax to build an image using a Dockerfile from stdin, without sending additional files as build context. The hyphen (-) takes the position of the PATH, and instructs Docker to read the build context, which only contains a Dockerfile, from stdin instead of a directory:

以下の構文を使えば、標準入力から Dockerfile を使ってイメージを構築するため、ビルド・コンテクストとして送信するファイルの追加が不要です。ハイフン（ ``-`` ）が意味するのは ``PATH`` に替わるもので、ディレクトリの代わりに標準入力から Dockerfile だけを含むビルド・コンテクストを読み込むよう、 Docker に命令します。

.. code-block:: bash

   docker build [OPTIONS] 

.. The following example builds an image using a Dockerfile that is passed through stdin. No files are sent as build context to the daemon.

以下のイメージ構築例は、標準入力を通して渡された Dockerfile を使います。ビルド・コンテクストとしては、デーモンには一切ファイルを送信しません。

.. code-block:: bash

   docker build -t myimage:latest -<<EOF
   FROM busybox
   RUN echo "hello world"
   EOF

.. Omitting the build context can be useful in situations where your Dockerfile doesn’t require files to be copied into the image, and improves the build-speed, as no files are sent to the daemon.

デーモンに対してファイルを一切送信しないため、Dockerfileをイメージの中にコピーする必要がない状況や、構築速度を改善するために、このようなビルド・コンテクストの省略が役立ちます。

.. If you want to improve the build-speed by excluding some files from the build- context, refer to exclude with .dockerignore.

ビルド・コンテクストから不要なファイルを除外し、構築速度の改善をしたければ、 :ref:`.dockerignore で除外 <exclude-with-dockerignore>` を参照ください。

.. If you attempt build an image using a Dockerfile from stdin, without sending build context, then the build will fail if you use COPY or ADD. The following example illustrates this:

.. note::

   イメージの構築にあたり、ビルド・コンテクストを送信しない標準入力の Dockerfile で  ``COPY`` や ``ADD`` 構文を使おうとしても、構築できません。以下の例は失敗します。
   
   .. code-block:: bash

      # 作業用のディレクトリを作成します
      mkdir example
      cd example
      
      # ファイル例を作成します
      touch somefile.txt
      
      docker build -t myimage:latest -<<EOF
      FROM busybox
      COPY somefile.txt ./
      RUN cat /somefile.txt
      EOF
      
      # 構築失敗を表示します
      ...
      Step 2/3 : COPY somefile.txt ./
      COPY failed: stat /var/lib/docker/tmp/docker-builder249218248/somefile.txt: no such file or directory
   
.. Build from a local build context, using a Dockerfile from stdin

.. _build-from-a-local-build-context,-using-a-dockerfile-from-stdin:

ローカルのビルド・コンテクストとして、stdin からの Dockerfile を読み込んで構築
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Use this syntax to build an image using files on your local filesystem, but using a Dockerfile from stdin. The syntax uses the -f (or --file) option to specify the Dockerfile to use, and it uses a hyphen (-) as filename to instruct Docker to read the Dockerfile from stdin:

ローカル・ファイルシステム上ファイルを使って構築する構文には、標準入力から Dockerfile を使います。この構文では、 ``-f`` （あるいは ``--file`` ）オプションで、使用する Dockerfile を指定します。そして、ファイル名としてハイフン（ ``-`` ）を使い、Docker には標準入力から Dockerfile を読み込むように命令します。

.. code-block:: bash

   docker build [オプション] -f- PATH

.. The example below uses the current directory (.) as the build context, and builds an image using a Dockerfile that is passed through stdin using a here document.

以下の例は、現在のディレクトリ（ ``.`` ）をビルド・コンテクストとして使います。また、イメージの構築には、標準入力の ` ヒア・ドキュメント <https://tldp.org/LDP/abs/html/here-docs.html>`_ を経由する Dockerfile を使います。

.. code-block:: bash

   # 作業用のディレクトリを作成します
   mkdir example
   cd example
   
   # ファイル例を作成します
   touch somefile.txt
   
   # build an image using the current directory as context, and a Dockerfile passed through stdin
   # イメージ構築のために、現在のディレクトリをコンテクストとして用い、Dockerfile は stdin を通します
   docker build -t myimage:latest -f- . <<EOF
   FROM busybox
   COPY somefile.txt ./
   RUN cat /somefile.txt
   EOF


.. build from a remote build context, using a Dockerfile from stdin

.. _build-from-a-remote-build-context,-using-a-dockerfile-from-stdin:

リモートのビルド・コンテクストから構築するため標準入力から読み込む Dockerfile を使う
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Use this syntax to build an image using files from a remote Git repository, using a Dockerfile from stdin. The syntax uses the -f (or --file) option to specify the Dockerfile to use, using a hyphen (-) as filename to instruct Docker to read the Dockerfile from stdin:

リモート Git リポジトリにあるファイルを使って構築する構文には、標準入力から読む込む Dockerfile を使います。この構文では、 ``-f`` （あるいは ``--file`` ）オプションで、使用する Dockerfile を指定します。そして、ファイル名としてハイフン（ ``-`` ）を使い、Docker には標準入力から Dockerfile を読み込むように命令します。

.. code-block:: bash

   docker build [OPTIONS] -f- PATH

.. This syntax can be useful in situations where you want to build an image from a repository that does not contain a Dockerfile, or if you want to build with a custom Dockerfile, without maintaining your own fork of the repository.

この構文が役立つ状況は、 ``Dockerfile`` を含まないリポジトリにあるイメージを構築したい場合や、自分でフォークしたリポジトリを保持することなく、任意の ``Dockerfile`` でビルドしたい場合です。

.. The example below builds an image using a Dockerfile from stdin, and adds the hello.c file from the hello-world repository on GitHub.


以下のイメージ構築例は、標準入力から読み込む Dockerfile を使い、 `GitHub 上の "hello-wolrd" リポジトリ <https://github.com/docker-library/hello-world>`_ にあるファイル ``hello.c`` を追加します。

.. code-block:: bash

   docker build -t myimage:latest -f- https://github.com/docker-library/hello-world.git <<EOF
   FROM busybox
   COPY hello.c ./
   EOF


.. When building an image using a remote Git repository as build context, Docker performs a git clone of the repository on the local machine, and sends those files as build context to the daemon. This feature requires you to install Git on the host where you run the docker build command.

.. note::

   リモートの Git リポジトリをビルド・コンテクストに使ってイメージを構築する時に、 Docker はリポジトリの ``git clone``  をローカルマシン上で処理し、これらの取得したファイルをビルド・コンテクストとしてデーモンに送信します。この機能を使うには、 ``docker build`` コマンドを実行するホスト上に Git のインストールが必要です。


.. Exclude with .dockerignore

.. _exclude-with-.dockerignore:

.dockerignore で除外
------------------------------

.. To exclude files not relevant to the build, without restructuring your source repository, use a .dockerignore file. This file supports exclusion patterns similar to .gitignore files. For information on creating one, see .dockerignore file.

ソース・リポジトリを再構築しないで、イメージの構築と無関係のファイルを除外するには、 ``.dockerignore`` ファイルを使います。このファイルは ``.gitignore`` と似たような除外パターンをサポートします。ファイルの作成に関する情報は :ref:`.dockerignore ファイル <dockerignore-file>` を参照してください。


.. Use multi-stage builds

.. _use-multi-stage-builds::

マルチステージ・ビルドを使う
------------------------------

.. Multi-stage builds allow you to drastically reduce the size of your final image, without struggling to reduce the number of intermediate layers and files.

:doc:`マルチステージ・ビルド </build/building/multi-stage>` は、中間レイヤとイメージの数を減らすのに苦労しなくても、最終イメージの容量を大幅に減少できます。

.. Because an image is built during the final stage of the build process, you can minimize image layers by leveraging build cache.

構築プロセスの最終段階のビルドを元にイメージを作成するため、 :ref:`ビルド・キャッシュの活用 <leverage-build-cache>` によってイメージ・レイヤを最小化できます。

.. For example, if your build contains several layers and you want to ensure the build cache is reusable, you can order them from the less frequently changed to the more frequently changed. The following list is an example of the order of instructions:

例えば、複数のレイヤを含む構築を行おうとしていて、ビルド・キャッシュを確実に再利用可能にしたい場合は、余り頻繁に変更しないものから、より頻繁に変更するものへと順番を並べます。以下のリストは命令の順番例です。

..  Install tools you need to build your application
    Install or update library dependencies
    Generate your application

1. アプリケーションの構築に必要なツールをインストール
2. ライブラリの依存関係をインストール又は更新
3. アプリケーションを生成


.. A Dockerfile for a Go application could look like:

Go アプリケーションに対する Dockerfile は、以下のようになります。

.. code-block:: bash

   # syntax=docker/dockerfile:1
   FROM golang:1.16-alpine AS build
   
   # プロジェクトに必要なツールをインストール
   # 依存関係を更新するには「docker build --no-cache」を実行（キャッシュを無効化するオプション）
   RUN apk add --no-cache git
   RUN go get github.com/golang/dep/cmd/dep
   
   # Gopkg.toml と Gopkg.lock はプロジェクトの依存関係の一覧
   # Gopkg ファイルが更新された時のみ、レイヤを再構築
   COPY Gopkg.lock Gopkg.toml /go/src/project/
   WORKDIR /go/src/project/
   # ライブラリの依存関係をインストール
   RUN dep ensure -vendor-only
   
   # プロジェクト全体をコピーし、構築
   # プロジェクトのディレクトリ内でファイルの変更があれば、レイヤを再構築
   COPY . /go/src/project/
   RUN go build -o /bin/project
   
   # 結果として、１つのレイヤ・イメージになる
   FROM scratch
   COPY --from=build /bin/project /bin/project
   ENTRYPOINT ["/bin/project"]
   CMD ["--help"]

.. Don’t install unnecessary packages

.. _dont-install-unnecessary-packages:

不要なパッケージのインストール禁止
----------------------------------------

.. Avoid installing extra or unnecessary packages just because they might be nice to have. For example, you don’t need to include a text editor in a database image.

余分な、又は、あったほうが良いだろうという程度の必須はないパッケージのインストールを避けてください。例えば、データベースのイメージであれば、テキストエディタは不要です。

.. When you avoid installing extra or unnecessary packages, you images will have reduced complexity, reduced dependencies, reduced file sizes, and reduced build times.

余分な又は不要なパッケージのインストールを避ければ、イメージの複雑さ、依存関係、ファイルサイズ、構築時間をそれぞれ減らせます。

.. Decouple applications

.. _decouple-applications:

アプリケーションを切り離す
------------------------------

.. Each container should have only one concern. Decoupling applications into multiple containers makes it easier to scale horizontally and reuse containers. For instance, a web application stack might consist of three separate containers, each with its own unique image, to manage the web application, database, and an in-memory cache in a decoupled manner.

各コンテナはただ１つだけの用途を持つべきです。アプリケーションを複数のコンテナに切り離すことで、水平スケールやコンテナの再利用がより簡単になります。例えば、ウェブアプリケーションのスタックであれば、３つのコンテナに分割できるでしょう。切り離す方法にしますと、ウェブアプリケーションの管理、データベース、メモリ内のキャッシュ、それぞれが独自のイメージを持ちます。

.. Limiting each container to one process is a good rule of thumb, but it's not a hard and fast rule. For example, not only can containers be spawned with an init process, some programs might spawn additional processes of their own accord. For instance, Celery can spawn multiple worker processes, and Apache can create one process per request.

各コンテナに１つのプロセスに制限するのは、経験的には良い方針です。しかし、これは大変かつ厳しいルールです。例えば、コンテナで :ref:`init プロセスを生成 <specify-an-init-process>` する時、プログラムによっては、そのプロセスが許容する追加プロセスも生成するでしょう。他にも例えば、 `Celery <https://www.celeryproject.org/>`_ は複数のワーカ・プロセスを生成しますし、 `Apache <https://httpd.apache.org/>`_ はリクエストごとに１つのプロセスを作成します。

.. Use your best judgment to keep containers as clean and modular as possible. If containers depend on each other, you can use Docker container networks to ensure that these containers can communicate.

ベストな判断のためには、コンテナを綺麗（クリーン）に保ち、可能であればモジュール化します。コンテナがお互いに依存する場合は、 :doc:`Docker コンテナ・ネットワーク </network/index>` を使い、それぞれのコンテナを通信可能にします。

レイヤの数を最小に
--------------------

.. In older versions of Docker, it was important that you minimized the number of layers in your images to ensure they were performant. The following features were added to reduce this limitation:

Docker の古いバージョンでは、性能を確保するために、イメージ・レイヤ数の最小化が重要でした。以下の機能は、この制限を減らすために追加されたものです。

..    Only the instructions RUN, COPY, ADD create layers. Other instructions create temporary intermediate images, and don't increase the size of the build.

* ``RUN`` 、 ``COPY`` 、 ``ADD``  命令のみレイヤを作成します。他の命令では、一時的な中間イメージ（temporary intermediate images）を作成し、構築時の容量は増えません。

..    Where possible, use multi-stage builds, and only copy the artifacts you need into the final image. This allows you to include tools and debug information in your intermediate build stages without increasing the size of the final image.

* 可能であれば、 :doc:`マルチステージ・ビルド </build/building/multi-stage>` を使い、必要な最終成果物（アーティファクト）のみ最終イメージにコピーします。これにより、中間構築ステージではツールやデバッグ情報を入れられますし、最終イメージの容量も増えません。

.. Sort multi-line arguments

.. _sort-multi-line-arguments

.. ### Sort multi-line arguments

複数行にわたる引数は並びを適切に
--------------------------------

.. Whenever possible, ease later changes by sorting multi-line arguments alphanumerically. This helps to avoid duplication of packages and make the list much easier to update. This also makes PRs a lot easier to read and review. Adding a space before a backslash (\) helps as well.

可能であれば常に、後々の変更を簡単にするため、複数行にわたる引数はアルファベット順にします。これにより、パッケージの重複指定を防ぎ、パッケージ一覧の変更も簡単になります。プルリクエストを読んだりレビューしたりが、更に楽になります。バックスラッシュ（ ``\`` ） の前に空白を含めるのも同様です。

.. Here’s an example from the buildpack-deps image:

以下は `buildpack-deps イメージ <https://github.com/docker-library/buildpack-deps>`_ の記述例です。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
     bzr \
     cvs \
     git \
     mercurial \
     subversion \
     && rm -rf /var/lib/apt/lists/*

.. Leverage build cache

.. _leverage-build-cache:

ビルド・キャッシュの活用
------------------------------

.. When building an image, Docker steps through the instructions in your Dockerfile, executing each in the order specified. As each instruction is examined, Docker looks for an existing image in its cache that it can reuse, rather than creating a new, duplicate image.

イメージの構築時、Docker は Dockerfile に記述された命令を順番に実行します。それぞれの命令のチェック時、Docker は新しい重複したイメージを作成するのではなく、キャッシュされた既存のイメージを再利用できるかどうか調べます。

.. If you don’t want to use the cache at all, you can use the --no-cache=true option on the docker build command. However, if you do let Docker use its cache, it’s important to understand when it can, and can’t, find a matching image. The basic rules that Docker follows are outlined below:

キャッシュを一切使いたくない場合は ``docker build`` コマンドに ``--no-cache=true`` オプションをつけて実行します。一方で Docker のキャッシュを利用する場合、Docker が適切なイメージを見つけた上で、どのようなときにキャッシュを利用し、どのようなときに利用しないのかの理解が必要です。Docker が従っている規則は以下のとおりです。

.. Starting with a parent image that's already in the cache, the next instruction is compared against all child images derived from that base image to see if one of them was built using the exact same instruction. If not, the cache is invalidated.

* キャッシュ内に既に存在している親イメージから処理を始めます。そのベースとなるイメージから派生した子イメージに対して、次の命令が合致するかどうかを比較し、子イメージのいずれかが同一の命令によって構築されているかを確認します。そのようなものが存在しなければ、キャッシュは無効になります。

.. In most cases, simply comparing the instruction in the Dockerfile with one of the child images is sufficient. However, certain instructions require more examination and explanation.

* ほとんどの場合、 Dockerfile 内の命令と子イメージのどれかを単純に比較するだけで十分です。しかし命令によっては、多少の検査や解釈が必要となるものもあります。

.. For the ADD and COPY instructions, the contents of each file in the image are examined and a checksum is calculated for each file. The last-modified and last-accessed times of each file aren’t considered in these checksums. During the cache lookup, the checksum is compared against the checksum in the existing images. If anything has changed in any file, such as the contents and metadata, then the cache is invalidated.

* ``ADD`` 命令や ``COPY`` 命令では、イメージに含まれるファイルの内容が検査され、個々のファイルについてチェックサムが計算されます。この計算において、ファイルの最終更新時刻、最終アクセス時刻は考慮されません。キャッシュを探す際に、このチェックサムと既存イメージのチェックサムが比較されます。ファイル内の何かが変更になったとき、例えばファイル内容やメタデータが変わっていれば、キャッシュは無効になります。

.. Aside from the ADD and COPY commands, cache checking doesn’t look at the files in the container to determine a cache match. For example, when processing a RUN apt-get -y update command the files updated in the container aren’t examined to determine if a cache hit exists. In that case just the command string itself is used to find a match.

* ``ADD`` と ``COPY`` 以外の命令の場合、キャッシュのチェックは、コンテナ内のファイル内容を見ることはなく、それによってキャッシュと一致しているかどうかが決定されません。例えば ``RUN apt-get -y update`` コマンドの処理が行われる際には、コンテナ内にて更新されたファイルは、キャッシュが一致するかどうかの判断のために用いられません。この場合にはコマンド文字列そのものが、キャッシュの一致判断に用いられます。

.. Once the cache is invalidated, all subsequent Dockerfile commands generate new images and the cache is not used.

キャッシュが無効になれば、次に続く ``Dockerfile`` コマンドは新たなイメージを生成し、キャッシュを使いません。

.. Dockerfile instructions

.. _dockerfile-instructions:

Dockerfile 命令
====================

.. These recommendations are designed to help you create an efficient and maintainable Dockerfile.

以下にある推奨項目は、効率的かつメンテナンス可能な Dockerfile の作成に役立つのを意図しています。


.. FROM

FROM
----------

.. Whenever possible, use current official images as the basis for your images. Docker recommends the Alpine image as it is tightly controlled and small in size (currently under 6 MB), while still being a full Linux distribution.

可能なら常に、イメージの基礎として最新の公式イメージを利用します。Docker の推奨は `Alpine イメージ <https://hub.docker.com/_/alpine/>`_ です。これはしっかりと管理されながら、容量が小さい（現時点で 6 MB 以下） Linux ディストリビューションです。

.. For more information about the FROM instruction, see Dockerfile reference for the FROM instruction.

``FROM`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの FROM 命令 <from>` を御覧ください。


.. LABEL

LABEL
----------

.. You can add labels to your image to help organize images by project, record licensing information, to aid in automation, or for other reasons. For each label, add a line beginning with LABEL and with one or more key-value pairs. The following examples show the different acceptable formats. Explanatory comments are included inline.

イメージにラベルを追加するのは、プロジェクト内でのイメージ管理をしやすくする、あるいは、ライセンス情報の記録や自動化の助けとするなど、様々な目的があります。ラベルを指定するには、 ``LABEL`` で始まる行を追加して、そこにキーと値のペア（key-value pair）を幾つか設定します。以下に示す例は、いずれも正しい構文です。説明をコメントとしてつけています。

.. Strings with spaces must be quoted or the spaces must be escaped. Inner quote characters ("), must also be escaped. For example:

文字列に空白が含まれる場合は、引用符で囲むか **あるいは** エスケープする必要があります。文字列内に引用符（ ``"`` ）がある場合も、同様にエスケープが必要です。

.. code-block:: dockerfile

   # 個別のラベルを設定
   LABEL com.example.version="0.0.1-beta"
   LABEL vendor1="ACME Incorporated"
   LABEL vendor2=ZENITH\ Incorporated
   LABEL com.example.release-date="2015-02-12"
   LABEL com.example.version.is-production=""

.. An image can have more than one label. Prior to Docker 1.10, it was recommended to combine all labels into a single LABEL instruction, to prevent extra layers from being created. This is no longer necessary, but combining labels is still supported. For example:

イメージには複数のラベルを設定できます。Docker 1.10 未満では、余分なレイヤが追加されるのを防ぐため、１つの  ``LABEL`` 命令中に複数のラベルをまとめる手法が推奨されていました。もはやラベルをまとめる必要はありませんが、今もなおラベルの連結をサポートしています。

.. code-block:: dockerfile

   # 1行でラベルを設定
   LABEL com.example.version="0.0.1-beta" com.example.release-date="2015-02-12"

上の例は以下のように書き換えられます。

.. code-block:: dockerfile

   # 複数のラベルを一度に設定、ただし行継続の文字を使い、長い文字列を改行する
   LABEL vendor=ACME\ Incorporated \
         com.example.is-beta= \
         com.example.is-production="" \
         com.example.version="0.0.1-beta" \
         com.example.release-date="2015-02-12"

.. See Understanding object labels for guidelines about acceptable label keys and values. For information about querying labels, refer to the items related to filtering in Managing labels on objects. See also LABEL in the Dockerfile reference.

ラベルにおける利用可能なキーと値のガイドラインとしては :doc:`オブジェクトラベルを理解する </engine/userguide/labels-custom-metadata>` を参照してください。またラベルの検索に関する情報は  :ref:`オブジェクト上のラベル管理 <managing-labels-on-objects>` のフィルタリングに関する項目を参照してください。また、 Dockerfile リファレンスの :ref:`LABEL <builder-label>` も御覧ください。

.. RUN

RUN
----------

.. Split long or complex RUN statements on multiple lines separated with backslashes to make your Dockerfile more readable, understandable, and maintainable.

``Dockerfile`` をより読みやすく、理解しやすく、メンテナンスしやすくするためには、長く複雑な  ``RUN`` 命令を、バックスラッシュで複数行に分けてください。

.. For more information about RUN, see Dockerfile reference for the RUN instruction.

``RUN`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの RUN 命令 <run>` を御覧ください。


.. apt-get

apt-get
^^^^^^^^^^

.. Probably the most common use-case for RUN is an application of apt-get. Because it installs packages, the RUN apt-get command has several counter-intuitive behaviors to look out for.

恐らく ``RUN`` において一番利用する使い方が ``apt-get`` アプリケーションの実行です。これはパッケージをインストールするものですが、 ``RUN apt-get`` は直感的に分かるものではないため、注意点が幾つかあります。

.. Always combine RUN apt-get update with apt-get install in the same RUN statement. For example:

``RUN apt-get update`` と ``apt-get install`` は、同一の ``RUN`` 命令内にて同時実行するようにしてください。例えば以下のようにします。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
       package-bar \
       package-baz \
       package-foo \
       && rm -rf /var/lib/apt/lists/*

.. Using apt-get update alone in a RUN statement causes caching issues and subsequent apt-get install instructions fail. For example, the issue will occur in the following Dockerfile:

１つの ``RUN`` 命令内で ``apt-get update`` だけを使うとキャッシュに問題が発生し、その後の ``apt-get install`` コマンドが失敗します。例えば Dockerfile を以下のように記述したとします。

.. code-block:: bash

   # syntax=docker/dockerfile:1
   FROM ubuntu:22.04
   RUN apt-get update
   RUN apt-get install -y curl

.. After building the image, all layers are in the Docker cache. Suppose you later modify apt-get install by adding an extra package as shown in the following Dockerfile:

イメージの構築後、すべてのレイヤは Docker のキャッシュに入ります。この次に、 ``apt-get install`` を編集して、以下のように別のパッケージを追加したとします。

.. code-block:: bash

   # syntax=docker/dockerfile:1
   FROM ubuntu:22.04
   RUN apt-get update
   RUN apt-get install -y curl nginx

.. Docker sees the initial and modified instructions as identical and reuses the cache from previous steps. As a result the apt-get update isn’t executed because the build uses the cached version. Because the apt-get update isn’t run, your build can potentially get an outdated version of the curl and nginx packages.

Docker は当初の命令と修正後の命令を見て、同一のコマンドであると判断するため、前回の処理において作られたキャッシュを再利用します。キャッシュされたものを利用して処理を行うため、結果として ``apt-get update`` は実行 **されません** 。``apt-get update`` を実行しないとは、つまり ``curl`` にしても ``nginx`` にしても、古いバージョンのまま利用する可能性が出てきます。

.. Using RUN apt-get update && apt-get install -y ensures your Dockerfile installs the latest package versions with no further coding or manual intervention. This technique is known as cache busting. You can also achieve cache busting by specifying a package version. This is known as version pinning. For example:

``RUN apt-get update && apt-get install -y`` コマンドを使えば、 Dockerfile が確実に最新バージョンをインストールし、更にコードを書いたり手作業を加えたりする必要がなくなります。これはキャッシュ・バスティング（cache busting）と呼ばれる技術です。この技術は、パッケージのバージョン指定にも利用できます。これはバージョン・ピニング（version pinning）よ呼ばれています。以下に例を示します。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
       package-bar \
       package-baz \
       package-foo=1.3.*

.. Version pinning forces the build to retrieve a particular version regardless of what’s in the cache. This technique can also reduce failures due to unanticipated changes in required packages.

バージョン・ピニングでは、キャッシュにどのようなイメージがあったとしても、指定されたバージョンを使って構築します。この手法を使えば、そのパッケージの最新版に、思いもよらない変更が加わっていたとしても、ビルド失敗を回避できることもあります。

.. Below is a well-formed RUN instruction that demonstrates all the apt-get recommendations.

以下は、 ``apt-get`` の推奨する利用方法で整えられた ``RUN`` 命令です。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
       aufs-tools \
       automake \
       build-essential \
       curl \
       dpkg-sig \
       libcap-dev \
       libsqlite3-dev \
       mercurial \
       reprepro \
       ruby1.9.1 \
       ruby1.9.1-dev \
       s3cmd=1.1.* \
    && rm -rf /var/lib/apt/lists/*

.. The s3cmd argument specifies a version 1.1.*. If the image previously used an older version, specifying the new one causes a cache bust of apt-get update and ensures the installation of the new version. Listing packages on each line can also prevent mistakes in package duplication.

``s3cmd`` の引数は、バージョン ``1.1.*`` を指定しています。以前に作られたイメージが古いバージョンを使っていたとしても、新たなバージョンの指定により ``apt-get update`` のキャッシュ・バスティングが働いて、確実に新バージョンをインストールします。パッケージを各行に分けて記述しているのは、パッケージを重複して書くようなミスを防ぐためです。

.. In addition, when you clean up the apt cache by removing /var/lib/apt/lists it reduces the image size, since the apt cache isn’t stored in a layer. Since the RUN statement starts with apt-get update, the package cache is always refreshed prior to apt-get install.

apt キャッシュをクリーンアップし ``/var/lib/apt/lists`` を削除するのは、イメージ容量を小さくするためです。そもそも apt キャッシュはレイヤー内に保存されません。``RUN`` 命令は ``apt-get update`` から始めていますので、 ``apt-get install`` の前に必ずパッケージのキャッシュが更新されます。

.. Official Debian and Ubuntu images automatically run apt-get clean, so explicit invocation is not required.

公式の Debian と Ubuntu のイメージは `自動的に apt-get clean を実行する <https://github.com/moby/moby/blob/03e2923e42446dbb830c654d0eec323a0b4ef02a/contrib/mkimage/debootstrap#L82-L105>`_ ので、明示的にこのコマンドを実行する必要はありません。



..  Using pipes

パイプの利用
^^^^^^^^^^^^

.. Some RUN commands depend on the ability to pipe the output of one command into another, using the pipe character (|), as in the following example:

``RUN`` 命令の中には、その出力をパイプし、他のコマンドへと受け渡すのを前提としているものもあります。そのときには、以下の例のように、パイプを行う文字（ ``|`` ）を使います。

::

   RUN wget -O - https://some.site | wc -l > /number


.. Docker executes these commands using the /bin/sh -c interpreter, which only evaluates the exit code of the last operation in the pipe to determine success. In the example above, this build step succeeds and produces a new image so long as the wc -l command succeeds, even if the wget command fails.

Docker はこういったコマンドを ``/bin/sh -c`` というインタープリタで処理します。正常に処理されたかどうかは、最後のパイプ処理における終了コードで評価します。上の例では、この構築処理が成功して新たなイメージが生成されるかどうかは、``wc -l`` コマンドの成功にかかっています。つまり ``wget`` コマンドが成功するかどうかは関係がありません。

.. If you want the command to fail due to an error at any stage in the pipe, prepend set -o pipefail && to ensure that an unexpected error prevents the build from inadvertently succeeding. For example:

パイプ内のどの段階でも、エラーが発生したらコマンド失敗としたい場合は、頭に ``set -o pipefail &&`` をつけて実行します。こうしますと、予期しないエラーが発生しても、それに気づかずに構築されてしまうことはなくなります。以下は例です。

::

   RUN set -o pipefail && wget -O - https://some.site | wc -l > /number

.. Not all shells support the -o pipefail option.
.. In cases such as the dash shell on Debian-based images, consider using the exec form of RUN to explicitly choose a shell that does support the pipefail option. For example:

.. note::

   ``-o pipefail`` **オプションは全てのシェルでサポートされていません。**

   Debian がベースのイメージにおけるデフォルトシェル ``dash`` のような場合、``RUN`` 命令における **exec** 形式の利用を考えてみてください。これは ``pipefail`` オプションをサポートしているシェルの利用を明示します。

   ::
   
      RUN ["/bin/bash", "-c", "set -o pipefail && wget -O - https://some.site | wc -l > /number"]


.. CMD

CMD
----------

.. The CMD instruction should be used to run the software contained in your image, along with any arguments. CMD should almost always be used in the form of CMD ["executable", "param1", "param2"…]. Thus, if the image is for a service, such as Apache and Rails, you would run something like CMD ["apache2","-DFOREGROUND"]. Indeed, this form of the instruction is recommended for any service-based image.

``CMD`` 命令は、イメージ内に含まれるソフトウェアを実行するために用いるもので、引数を指定して実行します。``CMD`` はほぼ、``CMD ["実行モジュール名", "引数1", "引数2" …]`` の形式をとります。Apache や Rails のようなサービス用途のイメージに対しては、例えば ``CMD ["apache2","-DFOREGROUND"]`` といったコマンド実行になります。サービスの土台となるイメージに対しては、この実行形式を推奨します。

.. In most other cases, CMD should be given an interactive shell, such as bash, python and perl. For example, CMD ["perl", "-de0"], CMD ["python"], or CMD ["php", "-a"]. Using this form means that when you execute something like docker run -it python, you’ll get dropped into a usable shell, ready to go. CMD should rarely be used in the manner of CMD ["param", "param"] in conjunction with ENTRYPOINT, unless you and your expected users are already quite familiar with how ENTRYPOINT works.

ほとんどのケースでは、 ``CMD`` に対して bash、python、perl など双方向のシェルがあります。例えば ``CMD ["perl", "-de0"]`` 、 ``CMD ["python"]`` 、 ``CMD ["php", "-a"]`` といった具合です。この実行形式の利用とは、例えば ``docker run -it python`` というコマンドを実行したときに、指定したシェルの中に入り込んで、処理の進行を意味します。``CMD`` と ``ENTRYPOINT`` を組み合わせて用いる ``CMD ["引数", "引数"]`` という実行形式がありますが、これを利用するのは稀です。開発者自身や利用者にとって ``ENTRYPOINT`` がどのように動作するのかを十分に理解していないなら、使うべきではありません。

.. For more information about CMD, see Dockerfile reference for the CMD instruction.

``CMD`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの CMD 命令 <cmd>` を御覧ください。


.. EXPOSE

EXPOSE
----------

.. The EXPOSE instruction indicates the ports on which a container listens for connections. Consequently, you should use the common, traditional port for your application. For example, an image containing the Apache web server would use EXPOSE 80, while an image containing MongoDB would use EXPOSE 27017 and so on.

``EXPOSE`` 命令は、コンテナが接続のためにリッスンするポートを指定します。当然ながら、アプリケーションは標準的なポートを試用すべきです。例えば Apache ウェブ・サーバを含んでいるイメージに対しては ``EXPOSE 80`` を使います。また MongoDB を含んでいれば ``EXPOSE 27017`` を使います。

.. For external access, your users can execute docker run with a flag indicating how to map the specified port to the port of their choice. For container linking, Docker provides environment variables for the path from the recipient container back to the source (ie, MYSQL_PORT_3306_TCP).

外部からアクセスできるようにするには、 ``docker run`` にフラグをつけて実行します。そのフラグとは、指定されているポートを、自分が取り決めるどのようなポートに割り当てるかを指示するものです。Docker のリンク機能では環境変数が利用できます。受け側のコンテナが提供元をたどれるようにするものです（例: ``MYSQL_PORT_3306_TCP`` ）。

.. For more information about EXPOSE, see Dockerfile reference for the EXPOSE instruction.

``EXPOSE`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの EXPOSE 命令 <expose>` を御覧ください。


.. ENV

ENV
----------

.. To make new software easier to run, you can use ENV to update the PATH environment variable for the software your container installs. For example, ENV PATH=/usr/local/nginx/bin:$PATH ensures that CMD ["nginx"] just works.

新しいソフトウェアに対しては ``ENV`` を用いれば簡単にそのソフトウェアを実行できます。コンテナがインストールするソフトウェアに必要な環境変数 ``PATH`` を、この ``ENV`` を使って更新します。例えば ``ENV PATH=/usr/local/nginx/bin:$PATH`` を実行すれば、 ``CMD ["nginx"]`` が確実に動作するようになります。

.. The ENV instruction is also useful for providing required environment variables specific to services you wish to containerize, such as Postgres’s PGDATA.

``ENV`` 命令は、必要となる環境変数を設定するときにも利用します。例えば Postgres の ``PGDATA`` のように、コンテナ化したいサービスに固有の環境変数が設定できます。

.. Lastly, ENV can also be used to set commonly used version numbers so that version bumps are easier to maintain, as seen in the following example:

また ``ENV`` にはふだん利用している各種バージョン番号を設定しておくときにも利用されます。これによってバージョンを混同することなく、管理が容易になります。以下がその例です。

.. code-block:: bash

   ENV PG_MAJOR=9.3
   ENV PG_VERSION=9.3.4
   RUN curl -SL https://example.com/postgres-$PG_VERSION.tar.xz | tar -xJC /usr/src/postgres && …
   ENV PATH=/usr/local/postgres-$PG_MAJOR/bin:$PATH

.. Similar to having constant variables in a program, as opposed to hard-coding values, this approach lets you change a single ENV instruction to automatically bump the version of the software in your container.

この方法は、プログラムにおけるハードコーディングではない定数を定義するのと同じように使うのが便利です。ただ１つの ``ENV`` 命令を変更するだけで、コンテナ内のソフトウェアバージョンも、いとも簡単に変えられるからです。

.. Each ENV line creates a new intermediate layer, just like RUN commands. This means that even if you unset the environment variable in a future layer, it still persists in this layer and its value can  be dumped. You can test this by creating a Dockerfile like the following, and then building it.

``RUN`` 命令のように、各  ``ENV``  行によって新しい中間レイヤを作成します。つまり、以降のレイヤで環境変数をアンセットしても、このレイヤが値を保持するため、値を取り出せてしまいます。この挙動は以下のような Dockerfile で確認できますので、構築してみましょう。

.. code-block:: bash

   # syntax=docker/dockerfile:1
   FROM alpine
   ENV ADMIN_USER="mark"
   RUN echo $ADMIN_USER > ./mark
   RUN unset ADMIN_USER

.. code-block:: bash

   $ docker run --rm test sh -c 'echo $ADMIN_USER'
   
   mark

.. To prevent this, and really unset the environment variable, use a RUN command with shell commands, to set, use, and unset the variable all in a single layer. You can separate your commands with ; or &&. If you use the second method, and one of the commands fails, the docker build also fails. This is usually a good idea. Using \ as a line continuation character for Linux Dockerfiles improves readability. You could also put all of the commands into a shell script and have the RUN command just run that shell script.

この挙動を避けるには、 ``RUN`` 命令でシェルのコマンドを使い、環境変数を実際にアンセットします。ただし、レイヤ内の環境変数の指定とアンセットを、１つのレイヤで指定する必要があります。コマンドは ``;`` や ``&`` で分割できます。ただし、 ``&`` を使う場合、どこかの行の１つでも失敗したら、 ``docker build`` そのものが失敗します。 ``\`` をライン継続文字として使う方が、 Linux Dockerfile の読み込みやすさを改善します。また、コマンドのすべてをシェルスクリプトにし、そのスクリプトを ``RUN`` 命令として実行する方法もあります。

.. code-block:: bash

   # syntax=docker/dockerfile:1
   FROM alpine
   RUN export ADMIN_USER="mark" \
       && echo $ADMIN_USER > ./mark \
       && unset ADMIN_USER
   CMD sh

.. code-block:: bash

   $ docker run --rm test sh -c 'echo $ADMIN_USER'

.. For more information about ENV, see Dockerfile reference for the ENV instruction.

``ENV`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの ENV 命令 <env>` を御覧ください。


.. ADD or COPY

ADD と COPY
--------------------

.. Although ADD and COPY are functionally similar, generally speaking, COPY is preferred. That’s because it’s more transparent than ADD. COPY only supports the basic copying of local files into the container, while ADD has some features (like local-only tar extraction and remote URL support) that are not immediately obvious. Consequently, the best use for ADD is local tar file auto-extraction into the image, as in ADD rootfs.tar.xz /.

``ADD`` と ``COPY`` の機能は似ていますが、一般的には ``COPY`` を優先します。それは ``ADD`` よりも機能が明確だからです。``COPY`` は単に、基本的なコピー機能を使ってローカルファイルをコンテナにコピーするだけです。一方 ``ADD`` には特定の機能（ローカル環境での tar 展開やリモート URL サポート）がありますが、これはすぐにわかるものではありません。結局 ``ADD`` の最も適切な利用場面は、ローカルの tar ファイルを自動的に展開してイメージに書き込むときです。例えば ``ADD rootfs.tar.xz /`` といったコマンドです。

.. If you have multiple Dockerfile steps that use different files from your context, COPY them individually, rather than all at once. This ensures that each step’s build cache is only invalidated, forcing the step to be re-run if the specifically required files change.

Dockerfile 内の複数ステップで異なるファイルをコピーするには、一度にすべてをコピーするのではなく、 ``COPY`` を使って個別にコピーしてください。こうしておけば、個々のステップに対するキャッシュのビルドは最低限に抑えられます。つまり指定されているファイルが変更になったときのみ、キャッシュが無効化されます（そのステップは再実行されます）。

.. For example:

例：

.. code-block:: bash

   COPY requirements.txt /tmp/
   RUN pip install /tmp/requirements.txt
   COPY . /tmp/

.. Results in fewer cache invalidations for the RUN step, than if you put the COPY . /tmp/ before it.

``RUN`` 命令のステップより前に ``COPY . /tmp/`` を実行していたとしたら、それに比べて上の例はキャッシュ無効化の可能性が低くなっています。

.. Because image size matters, using ADD to fetch packages from remote URLs is strongly discouraged; you should use curl or wget instead. That way you can delete the files you no longer need after they’ve been extracted and you don’t have to add another layer in your image. For example, you should avoid doing things like:

イメージ容量の問題があるため、 ``ADD`` を用いてリモート URL からのパッケージ取得をやめてください。かわりに ``curl`` や ``wget`` を使ってください。こうしますと、ファイルを取得し展開した後や、イメージ内の他のレイヤにファイルを加える必要がないのであれば、その後にファイルを削除できます。例えば以下に示すのは、望ましくない例です。

.. code-block:: bash

   ADD https://example.com/big.tar.xz /usr/src/things/
   RUN tar -xJf /usr/src/things/big.tar.xz -C /usr/src/things
   RUN make -C /usr/src/things all

.. And instead, do something like:

そのかわり、次のように記述します。

.. code-block:: bash

   RUN mkdir -p /usr/src/things \
       && curl -SL https://example.com/big.tar.xz \
       | tar -xJC /usr/src/things \
       && make -C /usr/src/things all

.. For other items (files, directories) that do not require ADD’s tar auto-extraction capability, you should always use COPY.

``ADD`` の自動展開機能を必要としないもの（ファイルやディレクトリ）に対しては、常に ``COPY`` を使うべきです。

.. For more information about ADD or COPY, see the following:

``ADD`` と ``COPY`` についての詳しい情報は以下を御覧ください：

*  :ref:`Dockerfile リファレンスの ADD 命令 <builder-add>` 
*  :ref:`Dockerfile リファレンスの COPY コマンド <builder-copy>` 


.. ENTRYPOINT

ENTRYPOINT
----------

.. The best use for ENTRYPOINT is to set the image’s main command, allowing that image to be run as though it was that command, and then use CMD as the default flags.

``ENTRYPOINT`` の最適な利用方法は、イメージに対してメインとなるコマンドの設定です。これを設定しますと、イメージをそのコマンドそのものであるかのようにして実行できます。また、続いて ``CMD`` を使えば、デフォルトのフラグを指定します。

.. The following is an example of an image for the command line tool s3cmd:

以下は、コマンドライン・ツール ``s3cmd`` のイメージ例です。

.. code-block:: bash

   ENTRYPOINT ["s3cmd"]
   CMD ["--help"]

.. You can use the following command to run the image and show the command’s help:

以下のコマンドを実行してこのイメージを実行したら、コマンドのヘルプが表示されます。

.. code-block:: bash

   $ docker run s3cmd

.. Or using the right parameters to execute a command:

あるいは適正なパラメータを指定してコマンドを実行します。

.. code-block:: bash

   $ docker run s3cmd ls s3://mybucket

.. This is useful because the image name can double as a reference to the binary as shown in the command above.

このコマンドのようにして、イメージ名がバイナリへの参照としても使えるので便利です。

.. The ENTRYPOINT instruction can also be used in combination with a helper script, allowing it to function in a similar way to the command above, even when starting the tool may require more than one step.

``ENTRYPOINT`` 命令はヘルパースクリプトとの組み合わせでの利用もできます。そのスクリプトは、上記のコマンド例と同じように機能します。たとえ対象ツールの起動に複数ステップを要するような場合でも、それが可能です。

.. For example, the Postgres Official Image uses the following script as its ENTRYPOINT:

例えば `Postgres 公式イメージ <https://hub.docker.com/_/postgres/>`_ は次のスクリプトを ``ENTRYPOINT`` として使っています。

.. code-block:: bash

   #!/bin/bash
   set -e
   
   if [ "$1" = 'postgres' ]; then
       chown -R postgres "$PGDATA"
   
       if [ -z "$(ls -A "$PGDATA")" ]; then
           gosu postgres initdb
       fi
   
       exec gosu postgres "$@"
   fi
   
   exec "$@"

.. This script uses the exec Bash command so that the final running application becomes the container’s PID 1. This allows the application to receive any Unix signals sent to the container. For more information, see the ENTRYPOINT reference.

このスクリプトは `Bash コマンドの exec <https://wiki.bash-hackers.org/commands/builtin/exec>`_ を用います。 このため最終的に実行されたアプリケーションが、コンテナの PID として 1 を持つことになります。 こうなるとそのアプリケーションは、コンテナに送信された Unix シグナルをすべて受信できます。 詳細は :ref:`ENTRYPOINT <entrypoint>` を参照してください。

.. In the following example, helper script is copied into the container and run via ENTRYPOINT on container start:

以下の例では、ヘルパースクリプトはコンテナの中にコピーされ、コンテナ開始時に ``ENTRYPOINT`` から実行されます。

.. code-block:: bash

   COPY ./docker-entrypoint.sh /
   ENTRYPOINT ["/docker-entrypoint.sh"]
   CMD ["postgres"]

.. This script allows the user to interact with Postgres in several ways.

このスクリプトを使うと、Postgres との間で、ユーザがいろいろな方法でやり取りできるようになります。

.. It can simply start Postgres:

以下は単純に Postgres を起動します。

.. code-block:: bash

   $ docker run postgres

.. Or, it can be used to run Postgres and pass parameters to the server:

あるいは、PostgreSQL 実行時、サーバに対してパラメータを渡せます。

.. code-block:: bash

   $ docker run postgres postgres --help

.. Lastly, it could also be used to start a totally different tool, such as Bash:

又は Bash のような全く異なるツールを起動するための利用もできます。

.. code-block:: bash

   $ docker run --rm -it postgres bash


.. For more information about ENTRYPOINT, see Dockerfile reference for the ENTRYPOINT instruction.

``ENTRYPOINT`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの ENTRYPOINT 命令 <entrypoint>` を御覧ください。


.. VOLUME

VOLUME
----------

.. The VOLUME instruction should be used to expose any database storage area, configuration storage, or files and folders created by your Docker container. You are strongly encouraged to use VOLUME for any combination of mutable or user-serviceable parts of your image.

.. The VOLUME instruction should be used to expose any database storage area, configuration storage, or files/folders created by your docker container. You are strongly encouraged to use VOLUME for any mutable and/or user-serviceable parts of your image.

``VOLUME`` コマンドは、データベース・ストレージ領域、設定用ストレージ、Docker コンテナによって作成されるファイルやフォルダの公開に使います。イメージ内であらゆる可変的な部分、あるいはユーザが設定可能な部分では、 VOLUME の利用が強く推奨されます。

.. For more information about VOLUME, see Dockerfile reference for the VOLUME instruction.

``VOLUME`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの VOLUME 命令 <volume>` を御覧ください。


.. USER

USER
----------

.. If a service can run without privileges, use USER to change to a non-root user. Start by creating the user and group in the Dockerfile with something like the following example:

サービスが特権ユーザでなくても実行できる場合は、 ``USER`` を用いて非 root ユーザに変更します。ユーザとグループを生成するところから始めてください。``Dockerfile`` 内で、例えば次のように入力します。

.. code-block:: bash

   RUN groupadd -r postgres && useradd -r -g postgres postgres

..  Consider an explicit UID/GID
   Users and groups in an image are assigned a non-deterministic UID/GID in that the “next” UID/GID is assigned regardless of image rebuilds. So, if it’s critical, you should assign an explicit UID/GID.
   Due to an unresolved bug in the Go archive/tar package’s handling of sparse files, attempting to create a user with a significantly large UID inside a Docker container can lead to disk exhaustion because /var/log/faillog in the container layer is filled with NULL (\0) characters. A workaround is to pass the --no-log-init flag to useradd. The Debian/Ubuntu adduser wrapper does not support this flag.

.. note:: **UID/GIDの明示を検討**

   イメージ内のユーザとグループに割り当てられる UID、GID は確定的なものではありません。イメージが再構築されるかどうかには関係なく、「次の」値が UID、GID に割り当てられます。これが問題となる場合は、UID、GID を明示的に割り当ててください。


.. note::

   Go 言語の archive/tar パッケージが取り扱うスパースファイルにおいて `未解決のバグ <https://github.com/golang/go/issues/13548>`_ があります。これは Docker コンテナ内で非常に大きな値の UID を使ってユーザを生成しようとするため、ディスクを異常に消費します。コンテナ・レイヤ内の ``/var/log/faillog`` が NUL (\\0) キャラクタにより埋められてしまいます。useradd に対して ``--no-log-init`` フラグを付けますと、とりあえずこの問題は回避できます。ただし Debian/Ubuntu の ``adduser`` ラッパーは ``--no-log-init`` フラグをサポートしていないため、利用出来ません。

.. Avoid installing or using sudo as it has unpredictable TTY and signal-forwarding behavior that can cause problems. If you absolutely need functionality similar to sudo, such as initializing the daemon as root but running it as non-root, consider using “gosu”.

``sudo`` のインストールとその利用は避けてください。TTY やシグナル送信が予期しない動作をするため、多くの問題を引き起こす可能性があります。 ``sudo`` と同様の機能（例えばデーモンの初期化を root により行い、起動は root 以外で行うなど）を実現する必要がある場合は、 `gosu <https://github.com/tianon/gosu>`_ を検討ください。

.. Lastly, to reduce layers and complexity, avoid switching USER back and forth frequently.

レイヤ数を減らしたり複雑さを減らしたりするには、 ``USER`` の設定を何度も繰り返すのは避けてください。

.. For more information about USER, see Dockerfile reference for the USER instruction.

``USER`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの USER 命令 <user>` を御覧ください。



.. WORKDIR

WORKDIR
----------

.. For clarity and reliability, you should always use absolute paths for your WORKDIR. Also, you should use WORKDIR instead of proliferating instructions like RUN cd … && do-something, which are hard to read, troubleshoot, and maintain.

``WORKDIR`` に設定するパスは、分かりやすく確実なものとするために、絶対パス指定としてください。また ``RUN cd … && do-something`` といった長くなる一方のコマンドを書くくらいなら、 ``WORKDIR`` を利用してください。そのような書き方は読みにくく、トラブル発生時には解決しにくく保守が困難になるためです。

.. For more information about WORKDIR, see Dockerfile reference for the WORKDIR instruction.

``WORKDIR`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの WORKDIR 命令 <workdir>` を御覧ください。


.. ONBUILD

ONBUILD
----------

.. An ONBUILD command executes after the current Dockerfile build completes. ONBUILD executes in any child image derived FROM the current image. Think of the ONBUILD command as an instruction that the parent Dockerfile gives to the child Dockerfile.

``ONBUILD`` 命令は、Dockerfileによるビルドが完了した後に実行されます。``ONBUILD`` は、現在のイメージから ``FROM`` によって派生した子イメージで実行されます。つまり ``ONBUILD`` とは、親の Dockerfile が子どもの Dockerfile へ与える命令であると言えます。

.. A Docker build executes ONBUILD commands before any command in a child Dockerfile.

Docker によるビルドは、 子 Dockerfile 内のどの命令よりも先に ``ONBUILD`` 命令を実行します。

.. ONBUILD is useful for images that are going to be built FROM a given image. For example, you would use ONBUILD for a language stack image that builds arbitrary user software written in that language within the Dockerfile, as you can see in Ruby’s ONBUILD variants.

``ONBUILD`` は、所定のイメージから ``FROM`` を使ってのイメージ構築時に利用できます。例えば特定言語のスタックイメージは ``ONBUILD`` を利用します。``Dockerfile`` 内にて、その言語で書かれたどのようなユーザ・ソフトウェアであっても構築できます。その例として `Ruby's ONBUILD variants <https://github.com/docker-library/ruby/blob/master/2.1/onbuild/Dockerfile>`_ があります。

.. Images built with ONBUILD should get a separate tag, for example: ruby:1.9-onbuild or ruby:2.0-onbuild.

``ONBUILD`` によって構築するイメージは、異なったタグを指定してください。例えば ``ruby:1.9-onbuild`` と ``ruby:2.0-onbuild`` などです。

.. Be careful when putting ADD or COPY in ONBUILD. The onbuild image fails catastrophically if the new build’s context is missing the resource being added. Adding a separate tag, as recommended above, helps mitigate this by allowing the Dockerfile author to make a choice.

``ONBUILD`` において ``ADD`` や ``COPY`` を用いるときは注意してください。onbuild イメージで新たに構築する際に、追加しようとしているリソースが見つからなかったとしたら、このイメージは復旧できない状態になります。上に示したように個別にタグをつけておけば、 Dockerfile の開発者にとっても判断ができるようになりますので、不測の事態は軽減されます。

.. For more information about ONBUILD, see Dockerfile reference for the ONBUILD instruction.

``ONBUILD`` 命令についての詳しい情報は、 :ref:`Dockerfile リファレンスの ONBUILD 命令 <builder-onbuild>` を御覧ください。



.. Examples of Docker Official Images
.. _examples-of-docker-official-images:

Docker 公式リポジトリの例
==============================

.. These Official Repositories have exemplary `Dockerfiles:

以下に示すのは代表的な Dockerfile の例です。

..    Go
    Perl
    Hy
    Rails

* `Go <https://hub.docker.com/_/golang/>`_
* `Perl <https://hub.docker.com/_/perl/>`_
* `Hy <https://hub.docker.com/_/hylang/>`_
* `Rails <https://hub.docker.com/_/ruby>`_

.. ## Additional resources:

その他の情報
============

..    Dockerfile Reference
    More about Base Images
    More about Automated Builds
    Guidelines for Creating Docker Official Repositories

* :doc:`Dockerfile リファレンス </engine/reference/builder>`
* :doc:`自動構築の詳細 </docker-hub/builds>`
* :doc:`Docker 公式イメージ作成のガイドライン </docker-hub/official_repos>`
* `Best practices to containerize Node.js web applications with Docker <https://snyk.io/blog/10-best-practices-to-containerize-nodejs-web-applications-with-docker>`_
* :doc:`ベースイメージについての詳細 </build/building/base-images>` 


.. seealso:: 

   Best practices for writing Dockerfiles
      https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
