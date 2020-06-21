.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/develop/develop-images/multistage-build/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/develop/develop-images/multistage-build.md
.. check date: 2020/06/21
.. Commits on Mar 17, 2020 14bbe621e55e9360019f6b3e25be4a25e3f79688
.. -----------------------------------------------------------------------------

.. Use multi-stage builds

.. _use-multi-stage-builds:

=======================================
マルチステージ・ビルドを使う
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Multi-stage builds are a new feature requiring Docker 17.05 or higher on the daemon and client. Multistage builds are useful to anyone who has struggled to optimize Dockerfiles while keeping them easy to read and maintain.

マルチステージ・ビルド（multi-stage build）は Docker 17.05 以上のデーモンとクライアントを必要とする新機能です。

..    Acknowledgment: Special thanks to Alex Ellis for granting permission to use his blog post Builder pattern vs. Multi-stage builds in Docker as the basis of the examples below.

.. seealso:

   以下で用いる例として、ブログ投稿 `Builder pattern vs. Multi-stage builds in Docker  <http://blog.alexellis.io/mutli-stage-docker-builds/>`_ の利用許諾をいただいた `Alex Ellis <https://twitter.com/alexellisuk>`_ さんに大変感謝します。

.. Before multi-stage builds

.. _before-multi-stage-builds:

マルチステージ・ビルドの前に
==============================

.. One of the most challenging things about building images is keeping the image size down. Each instruction in the Dockerfile adds a layer to the image, and you need to remember to clean up any artifacts you don’t need before moving on to the next layer. To write a really efficient Dockerfile, you have traditionally needed to employ shell tricks and other logic to keep the layers as small as possible and to ensure that each layer has the artifacts it needs from the previous layer and nothing else.

イメージ構築にあたり最もチャレンジングなものの１つに、イメージ容量を小さくし続けるというものがあります。Dockerfile 中の命令ごとにイメージにレイヤを追加するため、次のレイヤへと移る前に、不要なアーティファクトを忘れずクリーンアップし続ける必要があります。本当に効率的な これまで Dockerfile を書くためには、以降のレイヤで必要になるアーティファクトのみを保持するために、シェル芸（shell tricks）を駆使する必要と、レイヤを維持するロジックを用いる必要がありました。

.. It was actually very common to have one Dockerfile to use for development (which contained everything needed to build your application), and a slimmed-down one to use for production, which only contained your application and exactly what was needed to run it. This has been referred to as the “builder pattern”. Maintaining two Dockerfiles is not ideal.

実際にとても一般的になったのは、開発用途に１つのファイル（アプリケーションの構築に必要な全てを含む）を用いることです。そして、プロダクション向けに、そのアプリケーションを実行するために必要なものだけを含む、１つのレイヤへとスリムダウンすることです。これが従来はずっと「構築パターン（builder pattern）」として参照されていました。しかし、２つの Dockerfile を持つのは、理想的ではありません。

.. Here’s an example of a Dockerfile.build and Dockerfile which adhere to the builder pattern above:

以下の ``Dockerfile.build`` と ``Dockerfile`` は、この構築パターンを遵守した例です。

.. Dockerfile.build:

``Dockerfile.build`` ：

::

   FROM golang:1.7.3
   WORKDIR /go/src/github.com/alexellis/href-counter/
   COPY app.go .
   RUN go get -d -v golang.org/x/net/html \
     && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

.. Notice that this example also artificially compresses two RUN commands together using the Bash && operator, to avoid creating an additional layer in the image. This is failure-prone and hard to maintain. It’s easy to insert another command and forget to continue the line using the \ character, for example.

また、この例では２つの ``RUN``  コマンドを Bash の ``&&`` 演算子を使い１行にまとめ、イメージ中に追加レイヤが増えないのを防いでいます。ですが、これは失敗しがちでメンテナンスが大変です。これは、他のコマンドの連結が簡単ですが、場合によっては行の最後で ``\`` 文字を使うのを忘れがちです。

.. Dockerfile:

``Dockerfile`` ：

::

   FROM alpine:latest  
   RUN apk --no-cache add ca-certificates
   WORKDIR /root/
   COPY app .
   CMD ["./app"]  

.. build.sh:

``build.sh`` ：

.. code-block:: bash

   #!/bin/sh
   echo Building alexellis2/href-counter:build
   
   docker build --build-arg https_proxy=$https_proxy --build-arg http_proxy=$http_proxy \  
       -t alexellis2/href-counter:build . -f Dockerfile.build
   
   docker container create --name extract alexellis2/href-counter:build  
   docker container cp extract:/go/src/github.com/alexellis/href-counter/app ./app  
   docker container rm -f extract
   
   echo Building alexellis2/href-counter:latest
   
   docker build --no-cache -t alexellis2/href-counter:latest .
   rm ./app

.. When you run the build.sh script, it needs to build the first image, create a container from it to copy the artifact out, then build the second image. Both images take up room on your system and you still have the app artifact on your local disk as well.

``build.sh`` スクリプトを実行するにあたり、まずイメージを構築する必要があります。コンテナを作成し、そこからアーティファクトをコピーし、２つめに構築するイメージにコピーします。ローカルディスク上で両イメージがシステム上で場所を取るだけでなく、 ``app`` アーティファクトも同様に場所をとります。

.. Multi-stage builds vastly simplify this situation!

マルチステージ・ビルドは、この状況をとてもシンプルにします。

.. Use multi-stage builds

マルチステージ・ビルドを使う
==============================

.. With multi-stage builds, you use multiple FROM statements in your Dockerfile. Each FROM instruction can use a different base, and each of them begins a new stage of the build. You can selectively copy artifacts from one stage to another, leaving behind everything you don’t want in the final image. To show how this works, let’s adapt the Dockerfile from the previous section to use multi-stage builds.

マルチステージ・ビルドでは、 Dockerfile の中で複数の ``FROM`` 命令文を使います。各 ``FROM`` 命令は、異なるベースを使い、それを使って新しい構築ステージを始めます。あるステージから別のステージに対し、コピーするアーティファクトを選べるため、最終イメージで不要なすべてを残したままにできます。これがどのような挙動か確認するために、先ほどのセクションで使った Dockerfile をマルチステージ・ビルドに対応させましょう。

.. Dockerfile:

``Dockerfile`` ：

::

   FROM golang:1.7.3
   WORKDIR /go/src/github.com/alexellis/href-counter/
   RUN go get -d -v golang.org/x/net/html  
   COPY app.go .
   RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .
   
   FROM alpine:latest  
   RUN apk --no-cache add ca-certificates
   WORKDIR /root/
   COPY --from=0 /go/src/github.com/alexellis/href-counter/app .
   CMD ["./app"]  

.. You only need the single Dockerfile. You don’t need a separate build script, either. Just run docker build.

あなたが必要なのは１つの Dockerfile だけです。。構築スクリプトを分ける必要はありません。 ``docker build`` を実行するだけです。

.. code-block:: bash

   $ docker build -t alexellis2/href-counter:latest .

.. The end result is the same tiny production image as before, with a significant reduction in complexity. You don’t need to create any intermediate images and you don’t need to extract any artifacts to your local system at all.

最終結果は、先ほどと同じ小さなプロダクション・イメージですが、複雑さは極めて減少しました。もうこれで中間イメージを作成する必要はありませんし、ローカルシステム上にアーティファクトを展開する必要も、もうありません。

.. How does it work? The second FROM instruction starts a new build stage with the alpine:latest image as its base. The COPY --from=0 line copies just the built artifact from the previous stage into this new stage. The Go SDK and any intermediate artifacts are left behind, and not saved in the final image.

どのような挙動でしょうか？ ２つめの ``FROM`` 命令は、 ``alpine:latest`` をベースとして新しい構築ステージを開始します。 ``COPY --from=0``  行が、以前のステージで構築したアーティファクトを、この新しいイメージの中にコピーします。Go SDK や他の中間アーティファクトは残したままであり、最終イメージの中に保存しません。

.. Name your build stages

構築ステージに名前を付ける
==============================

.. By default, the stages are not named, and you refer to them by their integer number, starting with 0 for the first FROM instruction. However, you can name your stages, by adding an AS <NAME> to the FROM instruction. This example improves the previous one by naming the stages and using the name in the COPY instruction. This means that even if the instructions in your Dockerfile are re-ordered later, the COPY doesn’t break.

デフォルトでは、ステージに名前がなく、ステージを 0 で始まる整数値で参照します。しかし、 ``FROM`` 命令の中で ``AS <名前>`` を追加することにより、ステージに対して名前を付けられます。先ほどの例を改善し、ステージに対して名前を付け、その名前を ``COPY`` 命令で使います。つまり、Dockerfile に記述する（ FROM ）命令の順番を入れ替えたとしても、 ``COPY`` 命令は壊れません。

::

   FROM golang:1.7.3 AS builder
   WORKDIR /go/src/github.com/alexellis/href-counter/
   RUN go get -d -v golang.org/x/net/html  
   COPY app.go    .
   RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .
   
   FROM alpine:latest  
   RUN apk --no-cache add ca-certificates
   WORKDIR /root/
   COPY --from=builder /go/src/github.com/alexellis/href-counter/app .
   CMD ["./app"]  

.. Stop at a specific build stage

.. _stop at a specific build stage:

特定の構築ステージ後に停止
==============================

.. When you build your image, you don’t necessarily need to build the entire Dockerfile including every stage. You can specify a target build stage. The following command assumes you are using the previous Dockerfile but stops at the stage named builder:

イメージの構築時、Dockerfile 含まれる各イメージを全て構築する必要はありません。特定のターゲット（target）構築ステージを指定できます。以下のコマンドは、以前の ``Dockerfile`` を使いますが、 ``builder`` という名前のステージで停止します。

.. code-block:: bash

   $ docker build --target builder -t alexellis2/href-counter:latest .

.. A few scenarios where this might be very powerful are:

いくつかの場合に、これが非常にパワフルになるでしょう。

..  Debugging a specific build stage
    Using a debug stage with all debugging symbols or tools enabled, and a lean production stage
    Using a testing stage in which your app gets populated with test data, but building for production using a different stage which uses real data

* 特定の構築ステージをデバッグする用途
* デバッグ用の目印として ``debug`` ステージを使うか、ツールを有効化することで、 ``production`` ステージをスリムにする用途
* ``testing`` イメージを使い、アプリがテストデータを処理できるようにしますが、プロダクションが使う別のステージ構築時には実際のデータを使う用途


.. Use an external image as a “stage”

.. _use-an-external-image-as-a-stage:

外部イメージを「ステージ」として使う
========================================

.. When using multi-stage builds, you are not limited to copying from stages you created earlier in your Dockerfile. You can use the COPY --from instruction to copy from a separate image, either using the local image name, a tag available locally or on a Docker registry, or a tag ID. The Docker client pulls the image if necessary and copies the artifact from there. The syntax is:

マルチステージ・ビルドを使う時、 Dockerfile でこれまで作成済みのステージからコピーするだけ、という制限はありません。 ``COPY --from`` 命令で別のイメージからコピーできるだけでなく、ローカルで利用可能なイメージとタグの利用や、Docker レジストリ上やタグ ID ですらも利用できます。それらからアーティファクトのコピーが必要であれば、Docker クライアントはイメージを取得します。構文は次の通りです。

.. code-block:: bash

   COPY --from=nginx:latest /etc/nginx/nginx.conf /nginx.conf


.. Use a previous stage as a new stage

以前のステージを新しいステージとして使う
========================================

.. You can pick up where a previous stage left off by referring to it when using the FROM directive. For example:

以前のステージを残したまま、そこを``FROM`` 命令を使って参照できます。以下は例です。

::

   FROM alpine:latest as builder
   RUN apk --no-cache add build-base
   
   FROM builder as build1
   COPY source1.cpp source.cpp
   RUN g++ -o /binary source.cpp
   
   FROM builder as build2
   COPY source2.cpp source.cpp
   RUN g++ -o /binary source.cpp



.. seealso:: 

   Use multi-stage builds
      https://docs.docker.com/develop/develop-images/multistage-build/
