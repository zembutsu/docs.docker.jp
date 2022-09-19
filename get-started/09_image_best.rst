.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/get-started/09_image_best/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/get-started/09_image_best.md
.. check date: 2022/04/22
.. Commits on Nov 28, 2021 10e8f008a554ae7ef7b2d5fa80538f1234fc741d
.. -----------------------------------------------------------------------------

.. Image-building best practices
.. _image-building-best-practices:

========================================
イメージ構築のベストプラクティス
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 2
       :local:

.. Security scanning
.. _security-scanning:
:ruby:`安全性の検査 <security scanning>`
========================================

.. When you have built an image, it is a good practice to scan it for security vulnerabilities using the docker scan command. Docker has partnered with Snyk to provide the vulnerability scanning service.

イメージの構築時、イメージのセキュリティ脆弱性を :ruby:`検査 <scan>` するために ``docker scan`` コマンドを使うベストプラクティスがあります。Docker は脆弱性検査サービスを提供する `Snyk <https://snyk.io/>`_ と提携しています。

..    Note
    You must be logged in to Docker Hub to scan your images. Run the command docker scan --login, and then scan your images using docker scan <image-name>.

.. note::

   イメージの検査には Docker Hubへのログインが必要です。 ``docker scan --login`` コマンドを実行してから、 ``docker scan <イメージ名>`` を使ってイメージを検査します。

.. For example, to scan the getting-started image you created earlier in the tutorial, you can just type

たとえば、これまでのチュートリアルの始めに作成した ``getting-started`` イメージを検査するには、次のコマンドを実行するだけです。

.. code-block:: dockerfile

   $ docker scan getting-started

.. The scan uses a constantly updated database of vulnerabilities, so the output you see will vary as new vulnerabilities are discovered, but it might look something like this:

検査には定期的に更新される脆弱性データベースを使いますので、様々な新しい脆弱性が発見されたと表示されるでしょう。表示されるのは、以下のようなものです。

.. code-block:: bash

   ✗ Low severity vulnerability found in freetype/freetype
     Description: CVE-2020-15999
     Info: https://snyk.io/vuln/SNYK-ALPINE310-FREETYPE-1019641
     Introduced through: freetype/freetype@2.10.0-r0, gd/libgd@2.2.5-r2
     From: freetype/freetype@2.10.0-r0
     From: gd/libgd@2.2.5-r2 > freetype/freetype@2.10.0-r0
     Fixed in: 2.10.0-r1
   
   ✗ Medium severity vulnerability found in libxml2/libxml2
     Description: Out-of-bounds Read
     Info: https://snyk.io/vuln/SNYK-ALPINE310-LIBXML2-674791
     Introduced through: libxml2/libxml2@2.9.9-r3, libxslt/libxslt@1.1.33-r3, nginx-module-xslt/nginx-module-xslt@1.17.9-r1
     From: libxml2/libxml2@2.9.9-r3
     From: libxslt/libxslt@1.1.33-r3 > libxml2/libxml2@2.9.9-r3
     From: nginx-module-xslt/nginx-module-xslt@1.17.9-r1 > libxml2/libxml2@2.9.9-r3
     Fixed in: 2.9.9-r4

.. The output lists the type of vulnerability, a URL to learn more, and importantly which version of the relevant library fixes the vulnerability.

出力の一覧には、脆弱性のタイプ、URL には詳細、そして重要な、脆弱性を修正するのに妥当なライブラリのバージョンがあります。

.. There are several other options, which you can read about in the docker scan documentation.

他にもいくつかのオプションがあり、 :doc:`docker scan のドキュメント </engine/scan>` から確認できます。

.. As well as scanning your newly built image on the command line, you can also configure Docker Hub to scan all newly pushed images automatically, and you can then see the results in both Docker Hub and Docker Desktop.

コマンドライン上で新しく構築するイメージを検査するのと同じように、 :doc:`Docker Hub の設定 </docker-hub/vulnerability-scanning>` でも、直近に送信したイメージすべてを自動的に検索できます。そして、その結果は Docker Hub と Docker Desktop の両方で確認できます。

.. image:: ./images/hvs.png
   :scale: 60%
   :alt: Docker Hub 脆弱性検査

.. Image layering
.. _image-layering:
イメージの :ruby:`階層化 <layering>`
========================================

.. Did you know that you can look at what makes up an image? Using the docker image history command, you can see the command that was used to create each layer within an image.

どのようにしてイメージが構成されたのか、調べる方法があるのを知っていますか。 ``docker image history`` コマンドを使うと、イメージ内の各レイヤーが作成時に使われたコマンドを表示できます。

..    Use the docker image history command to see the layers in the getting-started image you created earlier in the tutorial.

1. ``docker image history`` コマンドを使い、チュートリアルのはじめの方で作成した ``getting-started`` イメージ内のレイヤーを見ます。

   .. code-block:: bash

      $ docker image history getting-started

   .. You should get output that looks something like this (dates/IDs may be different).

   すると、次のような出力が見えるでしょう（日付や ID は異なるでしょう）。

   .. code-block:: bash

      IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
      a78a40cbf866        18 seconds ago      /bin/sh -c #(nop)  CMD ["node" "src/index.j…    0B                  
      f1d1808565d6        19 seconds ago      /bin/sh -c yarn install --production            85.4MB              
      a2c054d14948        36 seconds ago      /bin/sh -c #(nop) COPY dir:5dc710ad87c789593…   198kB               
      9577ae713121        37 seconds ago      /bin/sh -c #(nop) WORKDIR /app                  0B                  
      b95baba1cfdb        13 days ago         /bin/sh -c #(nop)  CMD ["node"]                 0B                  
      <missing>           13 days ago         /bin/sh -c #(nop)  ENTRYPOINT ["docker-entry…   0B                  
      <missing>           13 days ago         /bin/sh -c #(nop) COPY file:238737301d473041…   116B                
      <missing>           13 days ago         /bin/sh -c apk add --no-cache --virtual .bui…   5.35MB              
      <missing>           13 days ago         /bin/sh -c #(nop)  ENV YARN_VERSION=1.21.1      0B                  
      <missing>           13 days ago         /bin/sh -c addgroup -g 1000 node     && addu…   74.3MB              
      <missing>           13 days ago         /bin/sh -c #(nop)  ENV NODE_VERSION=12.14.1     0B                  
      <missing>           13 days ago         /bin/sh -c #(nop)  CMD ["/bin/sh"]              0B                  
      <missing>           13 days ago         /bin/sh -c #(nop) ADD file:e69d441d729412d24…   5.59MB   

   .. Each of the lines represents a layer in the image. The display here shows the base at the bottom with the newest layer at the top. Using this, you can also quickly see the size of each layer, helping diagnose large images.

   それぞれの行がイメージ内のレイヤーに相当します。この表示が示すのは、一番下が :ruby:`土台 <base>` となり、最新のレイヤーが一番上にあります。これを使えば、各レイヤーの容量も素早く見られるため、大きなイメージの特定に役立ちます。

.. You’ll notice that several of the lines are truncated. If you add the --no-trunc flag, you’ll get the full output (yes... funny how you use a truncated flag to get untruncated output, huh?)

2. いくつかの行が :ruby:`省略されている <trancated>` のに気が付くでしょう。 ``--no-trunc`` フラグを使えば、全てを表示できます（それにしても……省略を意味する "trancated" フラグを使って、省略されていない出力をするのは、面白いですね？）。

   .. code-block:: bash

    $ docker image history --no-trunc getting-started

.. Layer caching
.. _layer-caching:
レイヤーのキャッシュ
====================

.. Now that you’ve seen the layering in action, there’s an important lesson to learn to help decrease build times for your container images.

これまでレイヤーがどのようになっているかを見てきました。次は、コンテナ イメージの構築回数を減らすために役立つ、重要な知見を学びます。

.. note::

   .. Once a layer changes, all downstream layers have to be recreated as well

   あるレイヤーを変更すると、 :ruby:`以降に続く <downstream>` 全てのレイヤーも同様に再作成されます。


.. Let’s look at the Dockerfile we were using one more time...

それでは、使用していた Dockerfile をもう一度見てみましょう……。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   FROM node:12-alpine
   WORKDIR /app
   COPY . .
   RUN yarn install --production
   CMD ["node", "src/index.js"]

.. Going back to the image history output, we see that each command in the Dockerfile becomes a new layer in the image. You might remember that when we made a change to the image, the yarn dependencies had to be reinstalled. Is there a way to fix this? It doesn’t make much sense to ship around the same dependencies every time we build, right?

イメージ履歴の出力にさかのぼると、 Dockerfile の各命令が、イメージ内の新しいレイヤーになりました。イメージに変更を加えたとき、yarn の依存関係も再インストールされたのを覚えていますでしょうか。これを修正する方法はないでしょうか。使おうとする度に、毎回同じ依存関係を構築するのはイマイチではないでしょうか？

.. To fix this, we need to restructure our Dockerfile to help support the caching of the dependencies. For Node-based applications, those dependencies are defined in the package.json file. So, what if we copied only that file in first, install the dependencies, and then copy in everything else? Then, we only recreate the yarn dependencies if there was a change to the package.json. Make sense?

これに対応するには、依存関係のキャッシュをサポートするのに役立つように、 Dockerfile を再構成する必要があります。Node をベースとするアプリケーションでは、各依存関係は ``package.json`` ファイルで定義されています。そのため、何よりもまず第一にこのファイルをコピーし、依存関係をインストールし、「それから」他の全てをコピーします。そうすると、 ``package.json`` を変更した時だけ、 yarn の依存関係を再作成します。わかりましたか？

..    Update the Dockerfile to copy in the package.json first, install dependencies, and then copy everything else in.

1.  ``package.json`` ファイルを第一にコピーし、依存関係をインストールし、以降で他に必要な全てのものをコピーするよう、 Docker ファイルを更新します。

   .. code-block:: dockerfile

      # syntax=docker/dockerfile:1
      FROM node:12-alpine
      WORKDIR /app
      COPY package.json yarn.lock ./
      RUN yarn install --production
      COPY . .
      CMD ["node", "src/index.js"]

.. Create a file named .dockerignore in the same folder as the Dockerfile with the following contents.

2. Dockerfile と同じディレクトリ内に ``.dockerignore`` という名前でファイルを作成し、内容を以下のようにします。

   ::
   
      node_modules

   .. .dockerignore files are an easy way to selectively copy only image relevant files. You can read more about this here. In this case, the node_modules folder should be omitted in the second COPY step because otherwise, it would possibly overwrite files which were created by the command in the RUN step. For further details on why this is recommended for Node.js applications and other best practices, have a look at their guide on Dockerizing a Node.js web app.

   イメージに関係あるファイルだけ選んでコピーするには、 ``.dockerignore`` ファイルの利用が簡単です。 :ref:`こちら <dockerignore-file>` で詳しく読めます。今回の場合、２つめの ``COPY`` ステップで ``node_modulers`` フォルダは無視されます。これは、そうしなければ、 ``RUN`` ステップ中の命令で作成されるファイルにより、上書きされる可能性があるためです。どうして Node.js アプリケーションにこのような推奨をするのかや、他のペストプラクティスといった詳細は、Node.js のガイド `Dockerizing a Node.js web app <https://nodejs.org/en/docs/guides/nodejs-docker-webapp/>`_ をご覧ください。

.. Build a new image using docker build.

3. ``docker build`` を使って新しいイメージを構築します。

   .. code-block:: dockerfile

      $ docker build -t getting-started .

   .. You should see output like this...

   次のような出力が見えるでしょう……

   .. code-block:: bash

      Sending build context to Docker daemon  219.1kB
      Step 1/6 : FROM node:12-alpine
      ---> b0dc3a5e5e9e
      Step 2/6 : WORKDIR /app
      ---> Using cache
      ---> 9577ae713121
      Step 3/6 : COPY package.json yarn.lock ./
      ---> bd5306f49fc8
      Step 4/6 : RUN yarn install --production
      ---> Running in d53a06c9e4c2
      yarn install v1.17.3
      [1/4] Resolving packages...
      [2/4] Fetching packages...
      info fsevents@1.2.9: The platform "linux" is incompatible with this module.
      info "fsevents@1.2.9" is an optional dependency and failed compatibility check. Excluding it from installation.
      [3/4] Linking dependencies...
      [4/4] Building fresh packages...
      Done in 10.89s.
      Removing intermediate container d53a06c9e4c2
      ---> 4e68fbc2d704
      Step 5/6 : COPY . .
      ---> a239a11f68d8
      Step 6/6 : CMD ["node", "src/index.js"]
      ---> Running in 49999f68df8f
      Removing intermediate container 49999f68df8f
      ---> e709c03bc597
      Successfully built e709c03bc597
      Successfully tagged getting-started:latest

   .. You’ll see that all layers were rebuilt. Perfectly fine since we changed the Dockerfile quite a bit.

   すべてのレイヤーが再構築されるのが見えるでしょう。Dockerfile に少し手を加えただけで、全て完全に作り直されました。

.. Now, make a change to the src/static/index.html file (like change the <title> to say “The Awesome Todo App”).

4. 次は ``src/static/index.html`` に変更を加えます（ ``<title>`` を「The Awesome Todo App」のように変えます ）。

.. Build the Docker image now using docker build -t getting-started . again. This time, your output should look a little different.

5. ``docker build -t getting-started .`` を使って Docker イメージを再構築します。今回は、先ほどとは出力が変わります。

   .. code-block:: bash

      Sending build context to Docker daemon  219.1kB
      Step 1/6 : FROM node:12-alpine
      ---> b0dc3a5e5e9e
      Step 2/6 : WORKDIR /app
      ---> Using cache
      ---> 9577ae713121
      Step 3/6 : COPY package.json yarn.lock ./
      ---> Using cache
      ---> bd5306f49fc8
      Step 4/6 : RUN yarn install --production
      ---> Using cache
      ---> 4e68fbc2d704
      Step 5/6 : COPY . .
      ---> cccde25a3d9a
      Step 6/6 : CMD ["node", "src/index.js"]
      ---> Running in 2be75662c150
      Removing intermediate container 2be75662c150
      ---> 458e5c6f080c
      Successfully built 458e5c6f080c
      Successfully tagged getting-started:latest

   ..   First off, you should notice that the build was MUCH faster! And, you’ll see that steps 1-4 all have Using cache. So, hooray! We’re using the build cache. Pushing and pulling this image and updates to it will be much faster as well. Hooray!

   まず、かなり構築が早くなったのが分かるでしょう！ そして、ステップ１～４がすべて ``Using cache`` （キャッシュを使用中）になっています。やりました！ 構築キャッシュを使ったのです。このイメージを更新するための送信や取得が、より早くなりました！ やったね！

.. Multi-stage builds
.. _get-started-multi-stage-build:
:ruby:`マルチステージ ビルド <multi-stage build>`
==================================================

.. While we’re not going to dive into it too much in this tutorial, multi-stage builds are an incredibly powerful tool to help use multiple stages to create an image. There are several advantages for them:

このチュートリアル内ではあまり深く扱いませんが、イメージ作成時に複数の :ruby:`段階 <stage>` を使える大変強力なツールが :ruby:`マルチステージ ビルド <multi-stage build>` です。いくつかの利点があります。

..    Separate build-time dependencies from runtime dependencies
    Reduce overall image size by shipping only what your app needs to run

* 構築時の依存関係と、実行時の依存関係を分離できる
* アプリケーションが実行に必要なもの「だけ」送るので、イメージ全体の容量を削減できる

.. Maven/Tomcat example
.. _get-started-maven-tomcat-example:
Maven/Tomcat 例
--------------------

.. When building Java-based applications, a JDK is needed to compile the source code to Java bytecode. However, that JDK isn’t needed in production. Also, you might be using tools like Maven or Gradle to help build the app. Those also aren’t needed in our final image. Multi-stage builds help.

Java をベースとしたアプリケーションの構築時、ソースコードを Java バイトコードにコンパイルするため JDK が必要です。ですが、JDK は本番環境では不要です。また、 Maven や Grandle のようなツールをアプリの構築に使うかもしれません。ですが、これらは最終イメージでは不要です。マルチステージ ビルドは、このような場面で役立ちます。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   FROM maven AS build
   WORKDIR /app
   COPY . .
   RUN mvn package
   
   FROM tomcat
   COPY --from=build /app/target/file.war /usr/local/tomcat/webapps 

.. In this example, we use one stage (called build) to perform the actual Java build using Maven. In the second stage (starting at FROM tomcat), we copy in files from the build stage. The final image is only the last stage being created (which can be overridden using the --target flag).

この例では、１つめのステージ（ ``build`` と呼びます）で、実際に Java の構築を Maven を使って処理します。２つめのステージ（ ``FROM tomcat`` で始まります）に、 ``build`` ステージからファイルをコピーします。最終イメージには、最後のステージに作成されたものだけです（ ``--target`` フラグを使い、上書きできます）。

.. React example
React 例
----------

.. When building React applications, we need a Node environment to compile the JS code (typically JSX), SASS stylesheets, and more into static HTML, JS, and CSS. If we aren’t doing server-side rendering, we don’t even need a Node environment for our production build. Why not ship the static resources in a static nginx container?

React アプリケーションの構築時、 JS コード（通常は JSC）、SASS スタイルシート、その他 HTML、JS、CSS を Node 環境にコンパイルする必要があります。サーバ側でのレンダリングをしないのであれば、本番環境の構築で Node 環境は不要です。どうして静的なリソースを静的な nginx コンテナに入れないのでしょうか。

.. code-block:: dockerfile

   # syntax=docker/dockerfile:1
   FROM node:12 AS build
   WORKDIR /app
   COPY package* yarn.lock ./
   RUN yarn install
   COPY public ./public
   COPY src ./src
   RUN yarn run build
   
   FROM nginx:alpine
   COPY --from=build /app/build /usr/share/nginx/html

.. Here, we are using a node:12 image to perform the build (maximizing layer caching) and then copying the output into an nginx container. Cool, huh?

ここでは、 ``node:12`` イメージを使って構築（レイヤーのキャッシュを最大限活用）を処理し、それから出力を nginx コンテナにコピーします。すごいでしょ？

.. Recap
.. _part9-recap:
まとめ
==========

.. By understanding a little bit about how images are structured, we can build images faster and ship fewer changes. Scanning images gives us confidence that the containers we are running and distributing are secure. Multi-stage builds also help us reduce overall image size and increase final container security by separating build-time dependencies from runtime dependencies.

イメージがどのようにして構築されているかを少々学びましたので、ちょっとした変更でも、イメージを早く構築し、送り出せるようになります。イメージの検査によって、コンテナの実行や配布が安全だという信頼性をもたらします。また、マルチステージ ビルドによって、構築時の依存関係と実行時の依存関係を分けられるため、イメージ全体の容量を減らしたり、最終コンテナの安全を高められます。


.. seealso::

   Image-building best practices
      https://docs.docker.com/get-started/09_image_best/


