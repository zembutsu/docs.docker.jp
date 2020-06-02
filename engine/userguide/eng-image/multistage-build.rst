.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/eng-image/multistage-build/
.. ---------------------------------------------------------------------------

.. title: Use multi-stage builds

.. _use-multi-stage-builds:

========================================
マルチステージビルドの利用
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Multi-stage builds are a new feature in Docker 17.05, and they will be exciting
   to anyone who has struggled to optimize Dockerfiles while keeping them easy to
   read and maintain.

マルチステージビルドは、Docker 17.05 またはそれ以上の Docker デーモンおよび Docker クライアントにおける新機能です。
マルチステージビルドは、Dockerfile を読みやすく保守しやすくするように、最適化に取り組むユーザーにとって非常にありがたいものです。

.. > **Acknowledgment**:
   > Special thanks to [Alex Ellis](https://twitter.com/alexellisuk) for granting
   > permission to use his blog post
   > [Builder pattern vs. Multi-stage builds in Docker](http://blog.alexellis.io/mutli-stage-docker-builds/)
   > as the basis of the examples below.

.. admonition:: 感謝

   `Alex Ellis <https://twitter.com/alexellisuk>`_ 氏に感謝します。
   氏のブログ投稿 `Builder pattern vs. Multi-stage builds in Docker <http://blog.alexellis.io/mutli-stage-docker-builds/>`_ に基づいて、以下の利用例を掲載する許可を頂きました。

.. ## Before multi-stage builds

.. _before-multi-stage-builds:

マルチステージビルド以前
=========================

.. One of the most challenging things about building images is keeping the image
   size down. Each instruction in the Dockerfile adds a layer to the image, and you
   need to remember to clean up any artifacts you don't need before moving on to
   the next layer. To write a really efficient Dockerfile, you have traditionally
   needed to employ shell tricks and other logic to keep the layers as small as
   possible and to ensure that each layer has the artifacts it needs from the
   previous layer and nothing else.

イメージをビルドする際に取り組むことといえば、ほとんどがそのイメージサイズを小さく抑えることです。
Dockerfile 内の各命令は、イメージに対してレイヤーを追加します。
そこで次のレイヤー処理に入る前には、不要となった生成物はクリーンアップしておくことが必要です。
現実に効果的な Dockerfile を書くためには、いつもながらトリッキーなシェルのテクニックや、レイヤーができる限り小さくなるようなロジックを考えたりすることが必要でした。
つまり各レイヤーは、それ以前のレイヤーから受け継ぐべき生成物のみを持ち、他のものは一切持たないようにすることが必要であったわけです。

.. It was actually very common to have one Dockerfile to use for development (which
   contained everything needed to build your application), and a slimmed-down one
   to use for production, which only contained your application and exactly what
   was needed to run it. This has been referred to as the "builder
   pattern". Maintaining two Dockerfiles is not ideal.

これまでのごくあたりまえの方法として、開発環境向けの Dockerfile を 1 つ用意し、そこにアプリケーションの構築に必要なものをすべて含めます。
そこから本番環境向けとしてスリム化したものをもう 1 つ用意して、アプリケーションそのものとそれを動かすために必要なもののみを含めるようにします。
これは「開発パターン」（builder pattern）と呼ばれてきました。
ただこの 2 つの Dockerfile を保守していくことは、目指すものではありません。

.. Here's an example of a `Dockerfile.build` and `Dockerfile` which adhere to the
   builder pattern above:

以下に示すのは ``Dockerfile.build`` と ``Dockerfile`` を用いる例であり、上述の開発パターンにこだわったやり方です。

.. **`Dockerfile.build`**:

``Dockerfile.build``:

.. ```conf
   FROM golang:1.7.3
   WORKDIR /go/src/github.com/alexellis/href-counter/
   RUN go get -d -v golang.org/x/net/html  
   COPY app.go .
   RUN go get -d -v golang.org/x/net/html \
     && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .
   ```

.. code-block:: Dockerfile

   FROM golang:1.7.3
   WORKDIR /go/src/github.com/alexellis/href-counter/
   RUN go get -d -v golang.org/x/net/html  
   COPY app.go .
   RUN go get -d -v golang.org/x/net/html \
     && CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

.. Notice that this example also artificially compresses two `RUN` commands together
   using the Bash `&&` operator, to avoid creating an additional layer in the image.
   This is failure-prone and hard to maintain. It's easy to insert another command
   and forget to continue the line using the `\` character, for example.

上の例を見てわかるように、本来 2 つある ``RUN`` コマンドを Bash の ``&&`` オペレーターによって連結しています。
これを行うことで、イメージ内に不要なレイヤーが生成されることを防いでいます。
ただこれでは間違いを起こしやすく、保守もやりづらくなります。
別のコマンドを挿入するのは簡単なことなので、``\`` 文字を使って行を分割するようなことは止めにして、以下のようにします。

.. **`Dockerfile`**:

``Dockerfile``:

.. ```conf
   FROM alpine:latest  
   RUN apk --no-cache add ca-certificates
   WORKDIR /root/
   COPY app .
   CMD ["./app"]  
   ```

.. code-block:: Dockerfile

   FROM alpine:latest  
   RUN apk --no-cache add ca-certificates
   WORKDIR /root/
   COPY app .
   CMD ["./app"]  

.. **`build.sh`**:

``build.sh``:

.. ```bash
   #!/bin/sh
   echo Building alexellis2/href-counter:build
   
   docker build --build-arg https_proxy=$https_proxy --build-arg http_proxy=$http_proxy \  
       -t alexellis2/href-counter:build . -f Dockerfile.build
   
   docker create --name extract alexellis2/href-counter:build  
   docker cp extract:/go/src/github.com/alexellis/href-counter/app ./app  
   docker rm -f extract
   
   echo Building alexellis2/href-counter:latest
   
   docker build --no-cache -t alexellis2/href-counter:latest .
   rm ./app
   ```

.. code-block:: bash

   #!/bin/sh
   echo Building alexellis2/href-counter:build
   
   docker build --build-arg https_proxy=$https_proxy --build-arg http_proxy=$http_proxy \  
       -t alexellis2/href-counter:build . -f Dockerfile.build
   
   docker create --name extract alexellis2/href-counter:build  
   docker cp extract:/go/src/github.com/alexellis/href-counter/app ./app  
   docker rm -f extract
   
   echo Building alexellis2/href-counter:latest
   
   docker build --no-cache -t alexellis2/href-counter:latest .
   rm ./app

.. When you run the `build.sh` script, it needs to build the first image, create
   a container from it in order to copy the artifact out, then build the second
   image. Both images take up room on your system and you still have the `app`
   artifact on your local disk as well.

``build.sh`` スクリプトを実行すると、1 つめのイメージがビルドされます。
そこからコンテナーを生成してイメージ内容をコピーし、2 つめのイメージがビルドされます。
2 つのイメージは、それなりの容量をとるものであり、ローカルディスク上に ``app`` の生成物も残ったままです。

.. Multi-stage builds vastly simplify this situation!

マルチステージビルドは、広範囲にわたってこのような状況を簡略化します。

.. ## Use multi-stage builds

.. _use-multi-stage-builds:

マルチステージビルドの利用
===========================

.. With multi-stage builds, you use multiple `FROM` statements in your Dockerfile.
   Each `FROM` instruction can use a different base, and each of them begins a new
   stage of the build. You can selectively copy artifacts from one stage to
   another, leaving behind everything you don't want in the final image. To show
   how this works, Let's adapt the Dockerfile from the previous section to use
   multi-stage builds.

マルチステージビルドを行うには、Dockerfile 内に ``FROM`` 行を複数記述します。
各 ``FROM`` 命令のベースイメージは、それぞれに異なるものとなり、各命令から新しいビルドステージが開始されます。
イメージ内に生成された内容を選び出して、一方から他方にコピーすることができます。
そして最終イメージに含めたくない内容は、放っておくことができます。
こういったことがどのようにして動作するのかを見るために、前節で示した Dockerfile をマルチステージビルドを使ったものに変更してみます。

.. **`Dockerfile`**:

``Dockerfile``:

.. ```conf
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
   ```

.. code-block:: Dockerfile

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

.. You only need the single Dockerfile. You don't need a separate build script,
   either. Just run `docker build`.

Dockerfile はただ 1 つ用意するだけです。
またビルドスクリプトも個別に用意するわけではありません。
単に ``docker build`` を実行するだけです。

.. ```bash
   $ docker build -t alexellis2/href-counter:latest .
   ```

.. code-block:: bash

   $ docker build -t alexellis2/href-counter:latest .

.. The end result is the same tiny production image as before, with a
   significant reduction in complexity. You don't need to create any intermediate
   images and you don't need to extract any artifacts to your local system at all.

最終結果として、以前と変わらずに本番環境向けの小さなイメージができあがりました。
しかも複雑さが一切なくなっています。
中間的なイメージを作る必要などありません。
さらに生成した内容をローカルシステムに抽出することも一切不要です。

.. How does it work? The second `FROM` instruction starts a new build stage with
   the `alpine:latest` image as its base. The `COPY --from=0` line copies just the
   built artifact from the previous stage into this new stage. The Go SDK and any
   intermediate artifacts are left behind, and not saved in the final image.

どうやってこれが動いているのでしょう？
2 つめの ``FROM`` 命令は、``alpine:latest`` をベースイメージとして新たなビルドステージを開始しています。
そして ``COPY --from=0`` という行では、直前のステージで作り出された生成内容を、単純に新たなステージにコピーしています。
Go 言語の SDK やその他の中間生成物は取り残されていて、最終的なイメージには保存されていません。

.. ### Name your build stages

.. _name-your-build-stages:

ビルドステージの命名
---------------------

.. By default, the stages are not named, and you refer to them by their integer
   number, starting with 0 for the first `FROM` instruction. However, you can
   name your stages, by adding an `as <NAME>` to the `FROM` instruction. This
   example improves the previous one by naming the stages and using the name in
   the `COPY` instruction. This means that even if the instructions in your
   Dockerfile are re-ordered later, the `COPY` won't break.

デフォルトではステージに名前はつきません。
そこでステージを参照するには、ステージを表わす整数値を用います。
この整数値は、最初の ``FROM`` 命令を 0 として順次割り振られるものです。
ただし ``FROM`` 命令に ``AS <NAME>`` の構文を加えれば、ステージに名前をつけることができます。
以下の例はこれまでのものをさらに充実させて、ステージに名前をつけ、``COPY`` 命令においてその名前を利用します。
これはつまり、Dockerfile 内の命令の記述順が、後々変更になったとしても、``COPY`` は確実に動作するということです。

.. ```conf
   FROM golang:1.7.3 as builder
   WORKDIR /go/src/github.com/alexellis/href-counter/
   RUN go get -d -v golang.org/x/net/html  
   COPY app.go    .
   RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

   FROM alpine:latest  
   RUN apk --no-cache add ca-certificates
   WORKDIR /root/
   COPY --from=builder /go/src/github.com/alexellis/href-counter/app .
   CMD ["./app"]  
   ```

.. code-block:: Dockerfile

   FROM golang:1.7.3 as builder
   WORKDIR /go/src/github.com/alexellis/href-counter/
   RUN go get -d -v golang.org/x/net/html  
   COPY app.go    .
   RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

   FROM alpine:latest  
   RUN apk --no-cache add ca-certificates
   WORKDIR /root/
   COPY --from=builder /go/src/github.com/alexellis/href-counter/app .
   CMD ["./app"]  

.. ## Next steps

.. _next-steps:

次のステップ
=============

.. - Check out the blog post
     [Builder pattern vs. Multi-stage builds in Docker](http://blog.alexellis.io/mutli-stage-docker-builds/)
     for full source code and a walk-through of these examples.

* ブログ投稿 `Builder pattern vs. Multi-stage builds in Docker <http://blog.alexellis.io/mutli-stage-docker-builds/>`_ を参照して、完全なソースコードや本記述例のウォークスルーを確認してください。

.. seealso:: 

   Use multi-stage builds
      https://docs.docker.com/engine/userguide/eng-image/multistage-build/

