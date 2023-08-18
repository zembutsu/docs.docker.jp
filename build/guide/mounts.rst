.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/build/guide/mounts/
   doc version: 24.0
      https://github.com/docker/docs/blob/main/build/guide/mounts.md
.. check date: 2023/08/18
.. Commits on Apr 25, 2023 da6586c498f34c0edac3171a48468a0f26aa0182
.. -----------------------------------------------------------------------------

.. Mounts
.. _build-guide-mounts:

========================================
マウント
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:　

.. This section describes how to use cache mounts and bind mounts with Docker builds.

このセクションでは、Docker の構築（ docker build ）で :ruby:`キャッシュ マウント <cache mount>` と :ruby:`バインド マウント <bind mount>` を使う方法を説明します。

.. Cache mounts let you specify a persistent package cache to be used during builds. The persistent cache helps speed up build steps, especially steps that involve installing packages using a package manager. Having a persistent cache for packages means that even if you rebuild a layer, you only download new or changed packages.

キャッシュマウントでは、構築中に使用する固定されたパッケージのキャッシュを指定できます。 :ruby:`固定されたキャッシュ <persistent cache>` は構築ステップの速度向上に役立ちます。特に、パッケージマネージャーを使い、パッケージのインストールが発生するステップに役立ちます。パッケージに対する固定されたキャッシュを持つのが意味するのは、レイヤを再構築したとしても、新しいまたは変更されたパッケージしかダウンロードしません。

.. Cache mounts are created using the --mount flag together with the RUN instruction in the Dockerfile. To use a cache mount, the format for the flag is --mount=type=cache,target=<path>, where <path> is the location of the cache directory that you wish to mount into the container.

キャッシュマウントを作成するには、Dockerfile 内の ``RUN`` 命令で ``--mount`` フラグと一緒に使います。キャッシュマウントを使うには、フラグの書式は ``--mount=type=cache,target=<path>`` であり、 ``<path>`` にはコンテナ内にマウントしたいキャッシュディレクトリの場所です。

.. Add a cache mount
.. _add-a-cache-mount:

キャッシュマウントの追加
==============================

.. The target path to use for the cache mount depends on the package manager you’re using. The application example in this guide uses Go modules. That means that the target directory for the cache mount is the directory where the Go module cache gets written to. According to the Go modules reference, the default location for the module cache is $GOPATH/pkg/mod, and the default value for $GOPATH is /go.

キャッシュマウントの対象として使用するパスは、使用するパッケージマネージャに依存します。このガイドのアプリケーション例では Go モジュールを使います。つまり、キャッシュマウント対象のディレクトリとは、Go モジュールキャッシュが書き込む場所です。 `Go モジュール リファレンス <https://go.dev/ref/mod#module-cache>`_ に従うと、モジュールキャッシュに使うデフォルトの場所は ``$GOPATH/pkg/mod`` であり、 ``$GOPATH`` 用のデフォルト値は ``/go`` です。

.. Update the build steps for downloading packages and compiling the program to mount the /go/pkg/mod directory as a cache mount:

パッケージのダウンロードとプログラムをコンパイルする構築ステップを書き換え、キャッシュマウントとして ``/go/pkg/mod`` ディレクトリをマウントします。

.. code-block:: dockerfile

     # syntax=docker/dockerfile:1
     FROM golang:{{site.example_go_version}}-alpine AS base
     WORKDIR /src
     COPY go.mod go.sum .
   - RUN go mod download
   + RUN --mount=type=cache,target=/go/pkg/mod/ \
   +     go mod download -x
     COPY . .
   
     FROM base AS build-client
   - RUN go build -o /bin/client ./cmd/client
   + RUN --mount=type=cache,target=/go/pkg/mod/ \
   +     go build -o /bin/client ./cmd/client
   
     FROM base AS build-server
   - RUN go build -o /bin/server ./cmd/server
   + RUN --mount=type=cache,target=/go/pkg/mod/ \
   +     go build -o /bin/server ./cmd/server
   
     FROM scratch AS client
     COPY --from=build-client /bin/client /bin/
     ENTRYPOINT [ "/bin/client" ]
   
     FROM scratch AS server
     COPY --from=build-server /bin/server /bin/
     ENTRYPOINT [ "/bin/server" ]

.. The -x flag added to the go mod download command prints the download executions that take place. Adding this flag lets you see how the cache mount is being used in the next step.

``go mod download`` コマンドに ``-x`` フラグを付け、ダウンロード処理を表示します。このフラグの追加により、次のステップでキャッシュマウントがどのように使われているのか分かるでしょう。

.. Rebuild the image
.. _rebuild-the-image:

イメージの再構築
====================

.. Before you rebuild the image, clear your build cache. This ensures that you’re starting from a clean slate, making it easier to see exactly what the build is doing.

イメージを再構築する前に、 :ruby:`構築キャッシュ <build cache>` を片付けます。これにより、白紙状態から始められるようにし、構築で何をしているのか確実に見えるようにします。

.. code-block:: bash

   $ docker builder prune -af

.. Now it’s time to rebuild the image. Invoke the build command, this time together with the --progress=plain flag, while also redirecting the output to a log file.

次はイメージを再構築する時です。今回は構築コマンドで ``--progress=plain`` フラグを付けて実行し、出力をログファイルにリダイレクトします。

.. code-block:: bash

   $ docker build --target=client --progress=plain . 2> log1.txt

.. When the build has finished, inspect the log1.txt file. The logs show how the Go modules were downloaded as part of the build.

構築が完了すると、 ``log1.txt`` を調べます。ログからは、構築パートで Go モジュールがダウンロードされているのが分かります。

.. code-block:: bash

   $ awk '/proxy.golang.org/' log1.txt
   #11 0.168 # get https://proxy.golang.org/github.com/charmbracelet/lipgloss/@v/v0.6.0.mod
   #11 0.168 # get https://proxy.golang.org/github.com/aymanbagabas/go-osc52/@v/v1.0.3.mod
   #11 0.168 # get https://proxy.golang.org/github.com/atotto/clipboard/@v/v0.1.4.mod
   #11 0.168 # get https://proxy.golang.org/github.com/charmbracelet/bubbletea/@v/v0.23.1.mod
   #11 0.169 # get https://proxy.golang.org/github.com/charmbracelet/bubbles/@v/v0.14.0.mod
   #11 0.218 # get https://proxy.golang.org/github.com/charmbracelet/bubbles/@v/v0.14.0.mod: 200 OK (0.049s)
   #11 0.218 # get https://proxy.golang.org/github.com/aymanbagabas/go-osc52/@v/v1.0.3.mod: 200 OK (0.049s)
   #11 0.218 # get https://proxy.golang.org/github.com/containerd/console/@v/v1.0.3.mod
   #11 0.218 # get https://proxy.golang.org/github.com/go-chi/chi/v5/@v/v5.0.0.mod
   #11 0.219 # get https://proxy.golang.org/github.com/charmbracelet/bubbletea/@v/v0.23.1.mod: 200 OK (0.050s)
   #11 0.219 # get https://proxy.golang.org/github.com/atotto/clipboard/@v/v0.1.4.mod: 200 OK (0.051s)
   #11 0.219 # get https://proxy.golang.org/github.com/charmbracelet/lipgloss/@v/v0.6.0.mod: 200 OK (0.051s)
   ...

.. Now, in order to see that the cache mount is being used, change the version of one of the Go modules that your program imports. By changing the module version, you’re forcing Go to download the new version of the dependency the next time you build. If you weren’t using cache mounts, your system would re-download all modules. But because you’ve added a cache mount, Go can reuse most of the modules and only download the package versions that doesn’t already exist in the /go/pkg/mod directory.

次はキャッシュマウントが使われているのを確認するため、プログラムが読み込む Go モジュールのバージョンを変えます。モジュールのバージョンを変更するには、次回構築時に、Go に対して依存関係の新しいバージョンを強制的にダウンロードさせます。ですが、キャッシュマウントを追加していますので、Go は大部分のモジュールを再利用でき、 ``/go/pkg/mod`` ディレクトリ内にまだ存在していないパッケージのバージョンのみダウンロードします。

.. Update the version of the chi package that the server component of the application uses:

アプリケーションが使うサーバコンポーネントである ``chi`` パッケージのバージョンを更新します。

.. code-block:: bash

   $ docker run -v $PWD:$PWD -w $PWD golang:{{site.example_go_version}}-alpine \
       go get github.com/go-chi/chi/v5@v5.0.8

.. Now, run another build, and again redirect the build logs to a log file:

次は別の構築を行い、再び構築ログをログファイルにリダイレクトします。

.. code-block:: bash

   $ docker build --target=client --progress=plain . 2> log2.txt

.. Now if you inspect the log2.txt file, you’ll find that only the chi package that was changed has been downloaded:

次は ``log2.txt`` ファイルを調査しますと、 ``chi`` パッケージのみがダウンロードされ、更新されたのが分かるでしょう。

.. code-block:: bash

   $ awk '/proxy.golang.org/' log2.txt
   #10 0.143 # get https://proxy.golang.org/github.com/go-chi/chi/v5/@v/v5.0.8.mod
   #10 0.190 # get https://proxy.golang.org/github.com/go-chi/chi/v5/@v/v5.0.8.mod: 200 OK (0.047s)
   #10 0.190 # get https://proxy.golang.org/github.com/go-chi/chi/v5/@v/v5.0.8.info
   #10 0.199 # get https://proxy.golang.org/github.com/go-chi/chi/v5/@v/v5.0.8.info: 200 OK (0.008s)
   #10 0.201 # get https://proxy.golang.org/github.com/go-chi/chi/v5/@v/v5.0.8.zip
   #10 0.209 # get https://proxy.golang.org/github.com/go-chi/chi/v5/@v/v5.0.8.zip: 200 OK (0.008s)

.. Add bind mounts
.. _add-bind-mounts:

バインドマウントの追加
==============================

.. There are a few more small optimizations that you can implement to improve the Dockerfile. Currently, it’s using the COPY instruction to pull in the go.mod and go.sum files before downloading modules. Instead of copying those files over to the container’s filesystem, you can use a bind mount. A bind mount makes the files available to the container directly from the host. This change removes the need for the additional COPY instruction (and layer) entirely.

いくつかの小さな最適化により、Dockerfile を改善できます。現時点では、モジュールをダウンロードする前に、 ``COPY`` 命令を使って ``go.mod`` と ``go.sum`` ファイルを取得します。これらのファイルをコンテナのファイルシステムを通してコピーするのではなく、バインドマウントが利用できます。バインドマウントはホストから直接コンテナでファイルを利用できるようにします。この変更は ``COPY`` 命令（とレイヤ）を追加する必要を完全に除去します。

.. code-block:: dockerfile

     # syntax=docker/dockerfile:1
     FROM golang:{{site.example_go_version}}-alpine AS base
     WORKDIR /src
   - COPY go.mod go.sum .
     RUN --mount=type=cache,target=/go/pkg/mod/ \
   +     --mount=type=bind,source=go.sum,target=go.sum \
   +     --mount=type=bind,source=go.mod,target=go.mod \
         go mod download -x
     COPY . .
   
     FROM base AS build-client
     RUN --mount=type=cache,target=/go/pkg/mod/ \
         go build -o /bin/client ./cmd/client
   
     FROM base AS build-server
     RUN --mount=type=cache,target=/go/pkg/mod/ \
         go build -o /bin/server ./cmd/server
   
     FROM scratch AS client
     COPY --from=build-client /bin/client /bin/
     ENTRYPOINT [ "/bin/client" ]
   
     FROM scratch AS server
     COPY --from=build-server /bin/server /bin/
     ENTRYPOINT [ "/bin/server" ]

.. Similarly, you can use the same technique to remove the need for the second COPY instruction as well. Specify bind mounts in the build-client and build-server stages for mounting the current working directory.

同様に、同じテクニックを使い2つめの ``COPY`` 命令も同じく不要にできます。 ``build-client`` と ``build-server`` ステージ内で、現在の作業ディレクトリをバインドマウントとして指定します。

.. code-block:: dockerfile

     # syntax=docker/dockerfile:1
     FROM golang:{{site.example_go_version}}-alpine AS base
     WORKDIR /src
     RUN --mount=type=cache,target=/go/pkg/mod/ \
         --mount=type=bind,source=go.sum,target=go.sum \
         --mount=type=bind,source=go.mod,target=go.mod \
         go mod download -x
   - COPY . .
   
     FROM base AS build-client
     RUN --mount=type=cache,target=/go/pkg/mod/ \
   +     --mount=type=bind,target=. \
         go build -o /bin/client ./cmd/client
   
     FROM base AS build-server
     RUN --mount=type=cache,target=/go/pkg/mod/ \
   +     --mount=type=bind,target=. \
         go build -o /bin/server ./cmd/server
   
     FROM scratch AS client
     COPY --from=build-client /bin/client /bin/
     ENTRYPOINT [ "/bin/client" ]
   
     FROM scratch AS server
     COPY --from=build-server /bin/server /bin/
     ENTRYPOINT [ "/bin/server" ]

.. Summary

まとめ
==========

.. This section has shown how you can improve your build speed using cache and bind mounts.

このセクションでは、キャッシュとバインドマウントを使って構築速度を改善できる方法を学びました。

.. Related information:

関連情報：

..  Dockerfile reference
    Bind mounts


* :ref:`Dockerfile リファレンス <builder-run---mount>`
* :doc:`バインドマウント </storage/bind-mounts>`

次のステップ
====================

.. The next section of this guide is an introduction to making your builds configurable, using build arguments.

次セクションでは構築引数を使い、調整可能な構築をする方法をを紹介します。

.. raw:: html

   <div style="overflow: hidden; margin-bottom:20px;">
      <a href="build-args.html" class="btn btn-neutral float-left">構築引数 <span class="fa fa-arrow-circle-right"></span></a>
   </div>


----

.. seealso::

   Mounts
      https://docs.docker.com/build/guide/mounts/


