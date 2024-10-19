.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/build/guide/multi-stage/
   doc version: 24.0
      https://github.com/docker/docs/blob/main/build/guide/multi-stage.md
.. check date: 2023/08/10
.. Commits on Apr 25, 2023 da6586c498f34c0edac3171a48468a0f26aa0182
.. -----------------------------------------------------------------------------

.. Multi-stage
.. _build-guide-multi-stage:

========================================
マルチステージ
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:　

.. This section explores multi-stage builds. There are two main reasons for why you’d want to use multi-stage builds:

このセクションは :ruby:`マルチステージビルド <multi-stage build>` を見ていきます。マルチステージビルドを使う理由は、主に2つあります。

..  They allow you to run build steps in parallel, making your build pipeline faster and more efficient.
    They allow you to create a final image with a smaller footprint, containing only what’s needed to run your program.

* 構築ステップを並列に実行できるため、構築パイプラインをより速くより効率的にできる。
* プログラムを実行するために必要なものだけを含む、形跡が最小の最終イメージを作成できる。

.. In a Dockerfile, a build stage is represented by a FROM instruction. The Dockerfile from the previous section doesn’t leverage multi-stage builds. It’s all one build stage. That means that the final image is bloated with resources used to compile the program.

Dockerfile 内では ``FROM`` 命令によって :ruby:`構築ステージ <build stage>` を表します。前のセクションにある Dockerfile では、マルチステージビルドを活用していませんでした。先ほどは、すべて1つの構築ステージでした。つまり、最終イメージはプログラムのコンパイルに使われたリソースで膨れあがっています。

.. code-block:: bash

   $ docker build --tag=buildme .
   $ docker images buildme
   REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
   buildme      latest    c021c8a7051f   5 seconds ago   150MB

.. The program compiles to executable binaries, so you don’t need Go language utilities to exist in the final image.

プログラムは実行可能なバイナリにコンパイルされているため、最終イメージ内に Go 言語ユーティリティは不要になります。

.. Add stages
.. _build-add-stages:

ステージの追加
====================

.. Using multi-stage builds, you can choose to use different base images for your build and runtime environments. You can copy build artifacts from the build stage over to the runtime stage.

マルチステージビルドの使用により、構築用と実行環境用で、異なるベースイメージが選べます。 :ruby:`構築の成果物 <build artifacts>` を構築用ステージから実行用ステージにコピーできます。

.. Modify the Dockerfile as follows. This change creates another stage using a minimal scratch image as a base. In the final scratch stage, the binaries built in the previous stage are copied over to the filesystem of the new stage.

以下のように Dockerfile を編集します。この変更により、最小の ``scratch`` イメージをベースとして使う別のステージを作成します。最終の ``scratch`` ステージでは、前のステージで構築されたバイナリを、新しいステージのファイルシステムへとコピーしています。


.. code-block:: diff

   # syntax=docker/dockerfile:1
   FROM golang:{{site.example_go_version}}-alpine
   WORKDIR /src
   COPY go.mod go.sum .
   RUN go mod download
   COPY . .
   RUN go build -o /bin/client ./cmd/client
   RUN go build -o /bin/server ./cmd/server
 +
 + FROM scratch
 + COPY --from=0 /bin/client /bin/server /bin/
   ENTRYPOINT [ "/bin/server" ]

.. Now if you build the image and inspect it, you should see a significantly smaller number:

これで、イメージを構築して調査したら、値が著しく小さくなったと分かるでしょう。

.. code-block:: bash

   $ docker build --tag=buildme .
   $ docker images buildme
   REPOSITORY   TAG       IMAGE ID       CREATED         SIZE
   buildme      latest    436032454dd8   7 seconds ago   8.45MB

.. The image went from 150MB to only just 8.45MB in size. That’s because the resulting image only contains the binaries, and nothing else.

150MB だったイメージは、ほんの 8.45MB になりました。最終的なイメージに含まれるのはバイナリだけであり、他になにもないからです。

.. Parallelism
.. _multi-stage-parallelism:

並列処理
==========

.. You’ve reduced the footprint of the image. The following step shows how you can improve build speed with multi-stage builds, using parallelism. The build currently produces the binaries one after the other. There is no reason why you need to build the client before building the server, or vice versa.

これまでは、イメージの形跡を減らしました。以下の手順では、マルチステージビルドの並列処理を使い、構築速度を改善できる方法を見ていきます。現時点の構築は、次々にバイナリを作成します。しかし、サーバの前にクライアントを作成する必要はなく、その逆の場合も同じです。

.. You can split the binary-building steps into separate stages. In the final scratch stage, copy the binaries from each corresponding build stage. By segmenting these builds into separate stages, Docker can run them in parallel.

バイナリの構築ステップを、個々のステージに分割できます。最後の ``scratch`` ステージでは、それぞれの適切な構築ステージからバイナリをコピーします。それぞれの構築をステージに分ければ、 Docker は並列でそれらを実行できます。

.. The stages for building each binary both require the Go compilation tools and application dependencies. Define these common steps as a reusable base stage. You can do that by assigning a name to the stage using the pattern FROM image AS stage_name. This allows you to reference the stage name in a FROM instruction of another stage (FROM stage_name).

構築用のステージでは、Go コンパイルツールとアプリケーション依存関係の、それぞれのバイナリが必要です。これらに共通するステップを、再利用可能な :ruby:`ベースステージ <base stage>` として定義できます。これを可能とするには、 ``FROM イメージ AS ステージ名`` のパターンを使い、ステージに対して名前を割り当てます。これでそのステージ名は、他のステージの ``FROM`` 命令内で参照できるようになります（ ``FROM ステージ名`` ）。

.. You can also assign a name to the binary-building stages, and reference the stage name in the COPY --from=stage_name instruction when copying the binaries to the final scratch image.

また、バイナリ構築ステージでも名前を割り当て可能なため、バイナリを最終 ``scratch`` イメージにコピーするには  ``COPY --from=ステージ名`` としてステージ名を参照します。

.. code-block:: diff

     # syntax=docker/dockerfile:1
   - FROM golang:{{site.example_go_version}}-alpine
   + FROM golang:{{site.example_go_version}}-alpine AS base
     WORKDIR /src
     COPY go.mod go.sum .
     RUN go mod download
     COPY . .
   +
   + FROM base AS build-client
     RUN go build -o /bin/client ./cmd/client
   +
   + FROM base AS build-server
     RUN go build -o /bin/server ./cmd/server
   
     FROM scratch
   - COPY --from=0 /bin/client /bin/server /bin/
   + COPY --from=build-client /bin/client /bin/
   + COPY --from=build-server /bin/server /bin/
     ENTRYPOINT [ "/bin/server" ]

.. Now, instead of first building the binaries one after the other, the build-client and build-server stages are executed simultaneously.

これで、最初のバイナリを次々に構築する方法に替わり、 ``build-client`` と ``build-server`` ステージが同時に処理されます。

.. image:: ./images/parallelism.gif
   :width: 70%
   :alt: 並列にステージを実行


.. Build targets
.. _build-targets:

構築ターゲット
====================

.. The final image is now small, and you’re building it efficiently using parallelism. But this image is slightly strange, in that it contains both the client and the server binary in the same image. Shouldn’t these be two different images?

最終イメージは小さくなり、並列処理を使って構築できるようになりました。しかし、このイメージは少し変わってて、同じイメージ内にクライアントとサーバ両方のイメージが入っています。これらは2つのイメージに分けるべきではないでしょうか。

.. It’s possible to create multiple different images using a single Dockerfile. You can specify a target stage of a build using the --target flag. Replace the unnamed FROM scratch stage with two separate stages named client and server.

1つの Dockerfile を使って、複数のイメージの作成が可能です。 ``--target`` フラグを使い、構築の :ruby:`対象となるステージ <target stage>` を指定できます。名前の付いていない ``FROM scratch`` ステージの名前を書き換え、 ``client`` と ``server`` の異なる2つのステージにします。

.. code-block:: diff

     # syntax=docker/dockerfile:1
     FROM golang:{{site.example_go_version}}-alpine AS base
     WORKDIR /src
     COPY go.mod go.sum .
     RUN go mod download
     COPY . .
   
     FROM base AS build-client
     RUN go build -o /bin/client ./cmd/client
   
     FROM base AS build-server
     RUN go build -o /bin/server ./cmd/server
   
   - FROM scratch
   - COPY --from=build-client /bin/client /bin/
   - COPY --from=build-server /bin/server /bin/
   - ENTRYPOINT [ "/bin/server" ]
   
   + FROM scratch AS client
   + COPY --from=build-client /bin/client /bin/
   + ENTRYPOINT [ "/bin/client" ]
   
   + FROM scratch AS server
   + COPY --from=build-server /bin/server /bin/
   + ENTRYPOINT [ "/bin/server" ]

.. And now you can build the client and server programs as separate Docker images (tags):

これで、クライアントとサーバのプログラムが分けられた Docker イメージ（タグ）を構築できます。


.. code-block:: bash

   $ docker build --tag=buildme-client --target=client .
   $ docker build --tag=buildme-server --target=server .
   $ docker images buildme 
   REPOSITORY       TAG       IMAGE ID       CREATED          SIZE
   buildme-client   latest    659105f8e6d7   20 seconds ago   4.25MB
   buildme-server   latest    666d492d9f13   5 seconds ago    4.2MB

.. The images are now even smaller, about 4 MB each.

イメージは更に小さくなり、それぞれ 4 MB です。

.. This change also avoids having to build both binaries each time. When selecting to build the client target, Docker only builds the stages leading up to that target. The build-server and server stages are skipped if they’re not needed. Likewise, building the server target skips the build-client and client stages.

この変更は、バイナリをそれぞれ構築する必要もありません。 ``client`` ターゲットの構築を選ぶ場合、 Docker は対象となるターゲットが必要なステージのみ構築します。 ``build-server`` と ``server`` ステージは必要がなければ飛ばします。同様に、 ``server`` ターゲットの構築では、 ``build-client`` と ``client`` ステージを飛ばします。

.. Summary

まとめ
==========

.. Multi-stage builds are useful for creating images with less bloat and a smaller footprint, and also helps to make builds run faster.

マルチステージビルドは肥大化しないイメージの構築に役立ち、形跡をより小さくし、構築を速くするのにも役立ちます。

.. Related information:

関連情報：

..  Multi-stage builds
    Base images

* :doc:`マルチステージビルド </build/building/multi-stage>`
* :doc:`ベースイメージ </build/building/base-images>`

次のステップ
====================

.. The next section describes how you can use file mounts to further improve build speeds.

次のセクションでは、構築速度を更に改善するため、ファイルマウントの使い方を説明します。

.. raw:: html

   <div style="overflow: hidden; margin-bottom:20px;">
      <a href="mounts.html" class="btn btn-neutral float-left">マウント <span class="fa fa-arrow-circle-right"></span></a>
   </div>


----

.. seealso::

   Multi-stage
       https://docs.docker.com/build/guide/multi-stage/

