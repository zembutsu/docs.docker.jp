.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/engine/userguide/eng-image/dockerfile_best-practices.md
.. check date: 2017/09/23
.. Commits on Aug 9, 2017 54e823ae7a6f9bf4bf84966d21bd6a4e88b25941
.. ---------------------------------------------------------------------------

.. Best practices for writing Dockerfile

.. _best-practices-for-writing-dockerfile:

=======================================
Dockerfile 記述のベスト・プラクティス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker can build images automatically by reading the instructions from a
   `Dockerfile`, a text file that contains all the commands, in order, needed to
   build a given image. `Dockerfile`s adhere to a specific format and use a
   specific set of instructions. You can learn the basics on the
   [Dockerfile Reference](../../reference/builder.md) page. If
   you’re new to writing `Dockerfile`s, you should start there.

Docker は ``Dockerfile`` に書かれる指示を読み込んで、自動的にイメージを構築します。
これは、あらゆる命令を含んだテキストファイルであり、順に処理することで指定されたイメージを構築するために必要となるものです。
``Dockerfile`` は所定のフォーマットにこだわっていて、特定の指示を用いることにしています。
基本的なことは :doc:`Dockerfile リファレンス </engine/reference/builder>` で学ぶことができます。
Dockerfile を書き慣れていない方は、そのリファレンスから始めてください。

.. This document covers the best practices and methods recommended by Docker,
   Inc. and the Docker community for creating easy-to-use, effective
   `Dockerfile`s. We strongly suggest you follow these recommendations (in fact,
   if you’re creating an Official Image, you *must* adhere to these practices).

このドキュメントでは、Docker 社や Docker コミュニティが推奨するベストプラクティスおよび方法を示しています。
Dockerfile を簡単に作り出して利用できるように、効率的な Dockerfile の書き方を示すものです。
みなさんには、ここに示す推奨方法を強くお勧めします（さらに、公式イメージを生成するときには、この推奨方法に従うことが必要になってきます）。

.. You can see many of these practices and recommendations in action in the [buildpack-deps `Dockerfile`](https://github.com/docker-library/buildpack-deps/blob/master/jessie/Dockerfile).


このベストプラクティスや推奨する手法の多くは、更新中の `buildpack-deps <https://github.com/docker-library/buildpack-deps/blob/master/jessie/Dockerfile>`_ の ``Dockerfile`` に見ることができます。

.. > Note: for more detailed explanations of any of the Dockerfile commands
   >mentioned here, visit the [Dockerfile Reference](../../reference/builder.md) page.

.. note::

   ここで説明する Dockerfile コマンドの詳しい説明は  :doc:`Dockerfile リファレンス </engine/reference/builder>` を参照してください。

.. General guidelines and recommendations

一般的なガイドラインとアドバイス
================================

.. ### Containers should be ephemeral

コンテナは "はかない" もの
--------------------------

.. The container produced by the image your `Dockerfile` defines should be as
   ephemeral as possible. By “ephemeral,” we mean that it can be stopped and
   destroyed and a new one built and put in place with an absolute minimum of
   set-up and configuration. You may want to take a look at the
   [Processes](https://12factor.net/processes) section of the 12 Factor app
   methodology to get a feel for the motivations of running containers in such a
   stateless fashion.

``Dockerfile`` が定義するイメージによって生成されるコンテナは、できる限り "はかないもの"（ephemeral）と考えておくべきです。
"はかない" という語を使うのは、コンテナが停止、破棄されて、すぐに新たなものが作り出されるからです。
最小限の構成や設定があれば稼動できます。

.. Use a .dockerignore file

.dockerignore ファイルの利用
------------------------------

.. In most cases, it's best to put each Dockerfile in an empty directory. Then,
   add to that directory only the files needed for building the Dockerfile. To
   increase the build's performance, you can exclude files and directories by
   adding a `.dockerignore` file to that directory as well. This file supports
   exclusion patterns similar to `.gitignore` files. For information on creating one,
   see the [.dockerignore file](../../reference/builder.md#dockerignore-file).

Dockerfile は、たいていは空のディレクトリに配置するのが適当です。
その後にそのディレクトリへは、Dockerfile の構築に必要となるファイルのみを追加します。
ビルドの効率をよくするために、ファイルやディレクトリを除外指定する ``.dockerignore`` ファイルをそのディレクトリに置く方法もあります。
このファイルがサポートする除外パターンの指定方法は ``.gitignore`` と同様です。
このファイルの作成に関しては :ref:`.dockerignore ファイル <dockerignore-file>` を参照してください。

.. Avoid installing unnecessary packages

不要なパッケージをインストールしない
----------------------------------------

.. In order to reduce complexity, dependencies, file sizes, and build times, you should avoid installing extra or unnecessary packages just because they might be “nice to have.” For example, you don’t need to include a text editor in a database image.

複雑さ、依存関係、ファイルサイズ、構築時間をそれぞれ減らすためには、余分な、または必須ではない「あった方が良いだろう」程度のパッケージをインストールすべきではありません。例えば、データベース・イメージであればテキストエディタは不要でしょう。

.. Run only one process per container

コンテナごとに１つのプロセスだけ実行
----------------------------------------

.. Decoupling applications into multiple containers makes it much easier to scale
   horizontally and reuse containers. For instance, a web application stack might
   consist of three separate containers, each with its own unique image, to manage
   the web application, database, and an in-memory cache in a decoupled manner.

アプリケーションを複数のコンテナに分けることにより、スケールアウトやコンテナの再利用が行いやすくなります。
たとえばウェブ・アプリケーションが３つの独立したコンテナにより成り立っているとします。
それらは個々のイメージを持つものとなり、それぞれに分かれてウェブ・アプリケーション、データベース、メモリキャッシュを管理するようになります。

.. You may have heard that there should be "one process per container". While this
   mantra has good intentions, it is not necessarily true that there should be only
   one operating system process per container. In addition to the fact that
   containers can now be [spawned with an init process](https://docs.docker.com/engine/reference/run/#/specifying-an-init-process),
   some programs might spawn additional processes of their own accord. For
   instance, [Celery](http://www.celeryproject.org/) can spawn multiple worker
   processes, or [Apache](https://httpd.apache.org/) might create a process per
   request. While "one process per container" is frequently a good rule of thumb,
   it is not a hard and fast rule. Use your best judgment to keep containers as
   clean and modular as possible.

「１つのコンテナには１つのプロセス」とすべき、ということを聞いたことがあるかもしれません。
この標語には見習うべきところはあるのですが、１つのコンテナに１つのオペレーティング・システムのプロセスだけを割り当てるのかというと、必ずしもそうではありません。
最近のコンテナは `初期プロセスにおいて起動 <https://docs.docker.com/engine/reference/run/#/specifying-an-init-process)>`_ するという現実もあり、プログラムの中には都合に応じて追加のプロセスを起動するようなものもあります。
例をあげると、 `Celery <http://www.celeryproject.org/>`_ はワーカ・プロセスを複数起動し、 `Apache <https://httpd.apache.org/>`_ はリクエストごとにプロセスを生成します。
「１つのコンテナには１つのプロセス」というのは、優れた経験則となることがありますが、決して厳密な規則というわけでもありません。
コンテナはできる限りすっきりとモジュラ化されるように、適切な判断をしてください。

.. If containers depend on each other, you can use [Docker container networks](https://docs.docker.com/engine/userguide/networking/)
    to ensure that these containers can communicate.

コンテナが互いに依存している場合は、`Docker container ネットワーク <https://docs.docker.com/engine/userguide/networking/>`_ を用いることで、コンテナ間の通信を確実に行うことができます。

.. Minimize the number of layers

レイヤの数を最小に
--------------------

.. You need to find the balance between readability (and thus long-term
   maintainability) of the `Dockerfile` and minimizing the number of layers it
   uses. Be strategic and cautious about the number of layers you use.

``Dockerfile`` は可読性とレイヤ数のバランスを考慮する必要があります。
``Dockerfile`` を読みやすくする（つまり長期にわたって保守しやすくする）のか、利用するレイヤ数をできるだけ減らすのかということです。
使用するレイヤ数は、計画的に注意して取り決めてください。

.. ### Sort multi-line arguments

複数行にわたる引数は並びを適切に
--------------------------------

.. Whenever possible, ease later changes by sorting multi-line arguments
   alphanumerically. This will help you avoid duplication of packages and make the
   list much easier to update. This also makes PRs a lot easier to read and
   review. Adding a space before a backslash (`\`) helps as well.

複数行にわたる引数は、できるなら後々の変更を容易にするために、その並びはアルファベット順にしましょう。
そうしておけば、パッケージを重複指定することはなくなり、一覧の変更も簡単になります。
プルリクエストを読んだりレビューしたりすることも、さらに楽になります。
バックスラッシュ（\\） の前に空白を含めておくことも同様です。

.. Here’s an example from the buildpack-deps image:

以下は ``buildpack-deps`` `イメージ <https://github.com/docker-library/buildpack-deps>`_ の記述例です。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
     bzr \
     cvs \
     git \
     mercurial \
     subversion

.. ### Build cache

.. _build-cache:

ビルドキャッシュ
--------------------

.. During the process of building an image Docker will step through the
   instructions in your `Dockerfile` executing each in the order specified.
   As each instruction is examined Docker will look for an existing image in its
   cache that it can reuse, rather than creating a new (duplicate) image.
   If you do not want to use the cache at all you can use the `--no-cache=true`
   option on the `docker build` command.

イメージ構築の過程において Docker は、``Dockerfile`` 内に示されている命令を記述順に実行していきます。
個々の命令が検査される際に Docker は、既存イメージのキャッシュが再利用できるかどうかを調べます。
そこでは新たな（同じ）イメージを作ることはしません。
キャッシュをまったく使いたくない場合は ``docker build`` コマンドに ``--no-cache=true`` オプションをつけて実行します。

.. However, if you do let Docker use its cache then it is very important to
   understand when it will, and will not, find a matching image. The basic rules
   that Docker will follow are outlined below:

一方で Docker のキャッシュを利用する場合、Docker が適切なイメージを見つけた上で、どのようなときにキャッシュを利用し、どのようなときには利用しないのかを理解しておくことが必要です。Docker が従っている規則は以下のとおりです。

.. * Starting with a parent image that is already in the cache, the next
   instruction is compared against all child images derived from that base
   image to see if one of them was built using the exact same instruction. If
   not, the cache is invalidated.

* キャッシュ内にすでに存在している親イメージから処理を始めます。
  そのベースとなるイメージから派生した子イメージに対して、次の命令が合致するかどうかが比較され、子イメージのいずれかが同一の命令によって構築されているかを確認します。
  そのようなものが存在しなければ、キャッシュは無効になります。

.. * In most cases simply comparing the instruction in the `Dockerfile` with one
   of the child images is sufficient.  However, certain instructions require
   a little more examination and explanation.

* ほとんどの場合、 ``Dockerfile`` 内の命令と子イメージのどれかを単純に比較するだけで十分です。
  しかし命令によっては、多少の検査や解釈が必要となるものもあります。

.. * For the `ADD` and `COPY` instructions, the contents of the file(s)
   in the image are examined and a checksum is calculated for each file.
   The last-modified and last-accessed times of the file(s) are not considered in
   these checksums. During the cache lookup, the checksum is compared against the
   checksum in the existing images. If anything has changed in the file(s), such
   as the contents and metadata, then the cache is invalidated.

* ``ADD`` 命令や ``COPY`` 命令では、イメージに含まれるファイルの内容が検査され、個々のファイルについてチェックサムが計算されます。
  この計算において、ファイルの最終更新時刻、最終アクセス時刻は考慮されません。
  キャッシュを探す際に、このチェックサムと既存イメージのチェックサムが比較されます。
  ファイル内の何かが変更になったとき、たとえばファイル内容やメタデータが変わっていれば、キャッシュは無効になります。

.. * Aside from the `ADD` and `COPY` commands, cache checking will not look at the
   files in the container to determine a cache match. For example, when processing
   a `RUN apt-get -y update` command the files updated in the container
   will not be examined to determine if a cache hit exists.  In that case just
   the command string itself will be used to find a match.

* ``ADD`` と ``COPY`` 以外のコマンドの場合、キャッシュのチェックは、コンテナ内のファイル内容を見ることはなく、それによってキャッシュと合致しているかどうかが決定されるわけでありません。
  たとえば ``RUN apt-get -y update`` コマンドの処理が行われる際には、コンテナ内にて更新されたファイルは、キャッシュが合致するかどうかの判断のために用いられません。
  この場合にはコマンド文字列そのものが、キャッシュの合致判断に用いられます。

.. Once the cache is invalidated, all subsequent `Dockerfile` commands will
   generate new images and the cache will not be used.

キャッシュが無効になると、次に続く ``Dockerfile`` コマンドは新たなイメージを生成し、そのキャッシュは使われなくなります。

.. ## The Dockerfile instructions

Dockerfile コマンド
====================

.. Below you'll find recommendations for the best way to write the
   various instructions available for use in a `Dockerfile`.

以下は ``Dockerfile`` 記述にて推奨するベストな方法を示すものです。
``Dockerfile`` に記述できるさまざまなコマンドの記述方法を示します。

.. FROM

FROM
----------

.. [Dockerfile reference for the FROM instruction](../../reference/builder.md#from)

:ref:`Dockerfile リファレンスの FROM コマンド <from>`

.. Whenever possible, use current Official Repositories as the basis for your
   image. We recommend the [Debian image](https://hub.docker.com/_/debian/)
   since it’s very tightly controlled and kept minimal (currently under 150 mb),
   while still being a full distribution.

イメージのベースは、できるだけ現時点での公式リポジトリを利用してください。
`Debian イメージ <https://hub.docker.com/_/debian/>`_ がお勧めです。
このイメージはしっかりと管理されていて、充実したディストリビューションであるにもかかわらず、非常にコンパクトなものになっています（現在 150 MB 以下）。

.. LABEL

LABEL
----------

:doc:`オブジェクト・ラベルの理解 </engine/userguide/labels-custom-metadata>`

.. You can add labels to your image to help organize images by project, record
   licensing information, to aid in automation, or for other reasons. For each
   label, add a line beginning with `LABEL` and with one or more key-value pairs.
   The following examples show the different acceptable formats. Explanatory comments
   are included inline.

イメージにラベルを追加するのは、プロジェクト内でのイメージ管理をしやすくしたり、ライセンス情報の記録や自動化の助けとするなど、さまざまな目的があります。
ラベルを指定するには、 ``LABEL`` で始まる行を追加して、そこにキーと値のペア（key-value pair）をいくつか設定します。
以下に示す例は、いずれも正しい構文です。
説明をコメントとしてつけています。

.. >**Note**: If your string contains spaces, it must be quoted **or** the spaces
   must be escaped. If your string contains inner quote characters (`"`), escape
   them as well.

.. note::

   文字列に空白が含まれる場合は、引用符でくくるか **あるいは** エスケープする必要があります。
   文字列内に引用符がある場合も、同様にエスケープしてください。

::

   # 個別のラベルを設定
   LABEL com.example.version="0.0.1-beta"
   LABEL vendor="ACME Incorporated"
   LABEL com.example.release-date="2015-02-12"
   LABEL com.example.version.is-production=""
   
   # 1行でラベルを設定
   LABEL com.example.version="0.0.1-beta" com.example.release-date="2015-02-12"
   
   # 複数のラベルを一度に設定、ただし行継続の文字を使い、長い文字列を改行する
   LABEL vendor=ACME\ Incorporated \
         com.example.is-beta= \
         com.example.is-production="" \
         com.example.version="0.0.1-beta" \
         com.example.release-date="2015-02-12"

.. See [Understanding object labels](../labels-custom-metadata.md) for
   guidelines about acceptable label keys and values. For information about
   querying labels, refer to the items related to filtering in
   [Managing labels on objects](../labels-custom-metadata.md#managing-labels-on-objects).

ラベルにおける利用可能なキーと値のガイドラインとしては :doc:`オブジェクトラベルを理解する </engine/userguide/labels-custom-metadata>` を参照してください。またラベルの検索に関する情報は  :doc:`オブジェクト上のラベルの管理 </engine/userguide/labels-custom-metadata#managing-labels-on-objects>` のフィルタリングに関する項目を参照してください。

.. RUN

RUN
----------

.. [Dockerfile reference for the RUN instruction](../../reference/builder.md#run)

:ref:`Dockerfile リファレンスの RUN コマンド <run>`

.. As always, to make your `Dockerfile` more readable, understandable, and
   maintainable, split long or complex `RUN` statements on multiple lines separated
   with backslashes.

いつものことながら ``Dockerfile`` は読みやすく理解しやすく、そして保守しやすくすることが必要です。
``RUN`` コマンドが複数行にわたって長く複雑になるなら、バックスラッシュを使って行を分けてください。

.. apt-get

apt-get
^^^^^^^^^^

.. Probably the most common use-case for `RUN` is an application of `apt-get`. The
   `RUN apt-get` command, because it installs packages, has several gotchas to look
   out for.

おそらく ``RUN`` において一番利用する使い方が ``apt-get`` アプリケーションの実行です。
``RUN apt-get`` はパッケージをインストールするものであるため、注意点がいくつかあります。

.. You should avoid `RUN apt-get upgrade` or `dist-upgrade`, as many of the
   “essential” packages from the parent images won't upgrade inside an unprivileged
   container. If a package contained in the parent image is out-of-date, you should
   contact its maintainers.
   If you know there’s a particular package, `foo`, that needs to be updated, use
   `apt-get install -y foo` to update automatically.

``RUN apt-get upgrade`` や ``dist-upgrade`` の実行は避けてください。
ベース・イメージに含まれる重要パッケージは、権限が与えられていないコンテナ内ではほとんど更新できないからです。
ベース・イメージ内のパッケージが古くなっていたら、開発者に連絡をとってください。
``foo`` というパッケージを更新する必要があれば、 ``apt-get install -y foo`` を利用してください。
これによってパッケージは自動的に更新されます。

.. Always combine  `RUN apt-get update` with `apt-get install` in the same `RUN`
   statement, for example:

``RUN apt-get update`` と ``apt-get install`` は、同一の ``RUN`` コマンド内にて同時実行するようにしてください。
たとえば以下のようにします。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
       package-bar \
       package-baz \
       package-foo

.. Using `apt-get update` alone in a `RUN` statement causes caching issues and
   subsequent `apt-get install` instructions fail.
   For example, say you have a Dockerfile:

１つの ``RUN`` コマンド内で ``apt-get update`` だけを使うとキャッシュに問題が発生し、その後の ``apt-get install`` コマンドが失敗します。
たとえば Dockerfile を以下のように記述したとします。

.. code-block:: bash

   FROM ubuntu:14.04
   RUN apt-get update
   RUN apt-get install -y curl

.. After building the image, all layers are in the Docker cache. Suppose you later
   modify `apt-get install` by adding extra package:

イメージが構築されると、レイヤーがすべて Docker のキャッシュに入ります。
この次に ``apt-get install`` を編集して別のパッケージを追加したとします。

.. code-block:: bash

   FROM ubuntu:14.04
   RUN apt-get update
   RUN apt-get install -y curl nginx

.. Docker sees the initial and modified instructions as identical and reuses the
   cache from previous steps. As a result the `apt-get update` is *NOT* executed
   because the build uses the cached version. Because the `apt-get update` is not
   run, your build can potentially get an outdated version of the `curl` and `nginx`
   packages.

Docker は当初のコマンドと修正後のコマンドを見て、同一のコマンドであると判断するので、前回の処理において作られたキャッシュを再利用します。
キャッシュされたものを利用して処理が行われるわけですから、結果として ``apt-get update`` は実行 **されません** 。
``apt-get update`` が実行されないということは、つまり ``curl`` にしても ``nginx`` にしても、古いバージョンのまま利用する可能性が出てくるということです。

.. Using  `RUN apt-get update && apt-get install -y` ensures your Dockerfile
   installs the latest package versions with no further coding or manual
   intervention. This technique is known as "cache busting". You can also achieve
   cache-busting by specifying a package version. This is known as version pinning,
   for example:

``RUN apt-get update && apt-get install -y`` というコマンドにすると、 Dockerfile が確実に最新バージョンをインストールしてくれるものとなり、さらにコードを書いたり手作業を加えたりする必要がなくなります。
これは「キャッシュ・バスティング（cache busting）」と呼ばれる技術です。
この技術は、パッケージのバージョンを指定することによっても利用することができます。
これはバージョン・ピニング（version pinning）というものです。
以下に例を示します。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
       package-bar \
       package-baz \
       package-foo=1.3.*

.. Version pinning forces the build to retrieve a particular version regardless of
   what’s in the cache. This technique can also reduce failures due to unanticipated changes
   in required packages.

バージョン・ピニングでは、キャッシュにどのようなイメージがあろうとも、指定されたバージョンを使ってビルドが行われます。
この手法を用いれば、そのパッケージの最新版に、思いもよらない変更が加わっていたとしても、ビルド失敗を回避できることもあります。

.. Below is a well-formed `RUN` instruction that demonstrates all the `apt-get`
   recommendations.

以下の ``RUN`` コマンドはきれいに整えられていて、 ``apt-get`` の推奨する利用方法を示しています。

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

.. The `s3cmd` instructions specifies a version `1.1.*`. If the image previously
   used an older version, specifying the new one causes a cache bust of `apt-get
   update` and ensure the installation of the new version. Listing packages on
   each line can also prevent mistakes in package duplication.

``s3cmd`` のコマンド行は、バージョン ``1.1.*`` を指定しています。
以前に作られたイメージが古いバージョンを使っていたとしても、新たなバージョンの指定により ``apt-get update`` のキャッシュ・バスティングが働いて、確実に新バージョンがインストールされるようになります。
パッケージを各行に分けて記述しているのは、パッケージを重複して書くようなミスを防ぐためです。

.. In addition, when you clean up the apt cache by removing `/var/lib/apt/lists`
   reduces the image size, since the apt cache is not stored in a layer. Since the
   `RUN` statement starts with `apt-get update`, the package cache will always be
   refreshed prior to `apt-get install`.

apt キャッシュをクリーンアップし ``/var/lib/apt/lists`` を削除するのは、イメージサイズを小さくするためです。
そもそも apt キャッシュはレイヤー内に保存されません。
``RUN`` コマンドを ``apt-get update`` から始めているので、 ``apt-get install`` の前に必ずパッケージのキャッシュが更新されることになります。

.. > **Note**: The official Debian and Ubuntu images [automatically run `apt-get clean`](https://github.com/moby/moby/blob/03e2923e42446dbb830c654d0eec323a0b4ef02a/contrib/mkimage/debootstrap#L82-L105),
   > so explicit invocation is not required.

.. note::

   公式の Debian と Ubuntu のイメージは `自動的に apt-get clean を実行する <https://github.com/moby/moby/blob/03e2923e42446dbb830c654d0eec323a0b4ef02a/contrib/mkimage/debootstrap#L82-L105>`_ ので、明示的にこのコマンドを実行する必要はありません。

.. #### Using pipes

パイプの利用
^^^^^^^^^^^^

.. Some `RUN` commands depend on the ability to pipe the output of one command into another, using the pipe character (`|`), as in the following example:

``RUN`` コマンドの中には、その出力をパイプを使って他のコマンドへ受け渡すことを前提としているものがあります。
そのときにはパイプを行う文字（ ``|`` ）を使います。
たとえば以下のような例があります。

::

   RUN wget -O - https://some.site | wc -l > /number

.. Docker executes these commands using the `/bin/sh -c` interpreter, which
   only evaluates the exit code of the last operation in the pipe to determine
   success. In the example above this build step succeeds and produces a new
   image so long as the `wc -l` command succeeds, even if the `wget` command
   fails.

Docker はこういったコマンドを ``/bin/sh -c`` というインタープリタ実行により実現します。
正常処理されたかどうかは、パイプの最後の処理の終了コードにより評価されます。
上の例では、このビルド処理が成功して新たなイメージが生成されるかどうかは、``wc -l`` コマンドの成功にかかっています。
つまり ``wget`` コマンドが成功するかどうかは関係がありません。

.. If you want the command to fail due to an error at any stage in the pipe,
   prepend `set -o pipefail &&` to ensure that an unexpected error prevents
   the build from inadvertently succeeding. For example:

パイプ内のどの段階でも、エラーが発生したらコマンド失敗としたい場合は、頭に ``set -o pipefail &&`` をつけて実行します。
こうしておくと、予期しないエラーが発生しても、それに気づかずにビルドされてしまうことはなくなります。
たとえば以下です。

.. ```Dockerfile
   RUN set -o pipefail && wget -O - https://some.site | wc -l > /number
   ```

::

   RUN set -o pipefail && wget -O - https://some.site | wc -l > /number

.. note::

   すべてのシェルが ``-o pipefail`` オプションをサポートしているわけではありません。
   その場合（例えば Debian ベースのイメージにおけるデフォルトシェル ``dash`` である場合）、``RUN`` コマンドにおける **exec** 形式の利用を考えてみてください。
   これは ``pipefail`` オプションをサポートしているシェルを明示的に指示するものです。
   たとえば以下です。

   .. ```Dockerfile
      RUN ["/bin/bash", "-c", "set -o pipefail && wget -O - https://some.site | wc -l > /number"]
      ```
   
   ::
   
      RUN ["/bin/bash", "-c", "set -o pipefail && wget -O - https://some.site | wc -l > /number"]

.. CMD

CMD
----------

.. [Dockerfile reference for the CMD instruction](../../reference/builder.md#cmd)

:ref:`Dockerfile リファレンスの CMD コマンド <cmd>`

.. The `CMD` instruction should be used to run the software contained by your
   image, along with any arguments. `CMD` should almost always be used in the
   form of `CMD [“executable”, “param1”, “param2”…]`. Thus, if the image is for a
   service, such as Apache and Rails, you would run something like
   `CMD ["apache2","-DFOREGROUND"]`. Indeed, this form of the instruction is
   recommended for any service-based image.

``CMD`` コマンドは、イメージ内に含まれるソフトウェアを実行するために用いるもので、引数を指定して実行します。
``CMD`` はほぼ、``CMD ["実行モジュール名", "引数1", "引数2" …]`` の形式をとります。
Apache や Rails のようにサービスをともなうイメージに対しては、たとえば ``CMD ["apache2","-DFOREGROUND"]`` といったコマンド実行になります。
実際にサービスベースのイメージに対しては、この実行形式が推奨されます。

.. In most other cases, `CMD` should be given an interactive shell, such as bash, python
   and perl. For example, `CMD ["perl", "-de0"]`, `CMD ["python"]`, or
   `CMD [“php”, “-a”]`. Using this form means that when you execute something like
   `docker run -it python`, you’ll get dropped into a usable shell, ready to go.
   `CMD` should rarely be used in the manner of `CMD [“param”, “param”]` in
   conjunction with [`ENTRYPOINT`](../../reference/builder.md#entrypoint), unless
   you and your expected users are already quite familiar with how `ENTRYPOINT`
   works.

上記以外では、 ``CMD`` に対して bash、python、perl などインタラクティブシェルを与えることが行われます。
たとえば ``CMD ["perl", "-de0"]`` 、 ``CMD ["python"]`` 、 ``CMD ["php", "-a"]`` といった具合です。
この実行形式を利用するということは、たとえば ``docker run -it python`` というコマンドを実行したときに、指定したシェルの中に入り込んで、処理を進めていくことを意味します。
``CMD`` と ``ENTRYPOINT`` を組み合わせて用いる ``CMD ["引数", "引数"]`` という実行形式がありますが、これを利用するのはまれです。
開発者自身や利用者にとって ``ENTRYPOINT`` がどのように動作するのかが十分に分かっていないなら、用いないようにしましょう。

.. EXPOSE

EXPOSE
----------

.. [Dockerfile reference for the EXPOSE instruction](../../reference/builder.md#expose)

:ref:`Dockerfile リファレンスの EXPOSE コマンド <expose>`

.. The `EXPOSE` instruction indicates the ports on which a container will listen
   for connections. Consequently, you should use the common, traditional port for
   your application. For example, an image containing the Apache web server would
   use `EXPOSE 80`, while an image containing MongoDB would use `EXPOSE 27017` and
   so on.

``EXPOSE`` コマンドは、コンテナが接続のためにリッスンするポートを指定します。
当然のことながらアプリケーションにおいては、標準的なポートを利用します。
たとえば Apache ウェブ・サーバを含んでいるイメージに対しては ``EXPOSE 80`` を使います。
また MongoDB を含んでいれば ``EXPOSE 27017`` を使うことになります。

.. For external access, your users can execute `docker run` with a flag indicating
   how to map the specified port to the port of their choice.
   For container linking, Docker provides environment variables for the path from
   the recipient container back to the source (ie, `MYSQL_PORT_3306_TCP`).

外部からアクセスできるようにするため、これを実行するユーザは ``docker run`` にフラグをつけて実行します。
そのフラグとは、指定されているポートを、自分が取り決めるどのようなポートに割り当てるかを指示するものです。
Docker のリンク機能においては環境変数が利用できます。
受け側のコンテナが提供元をたどることができるようにするものです（例: ``MYSQL_PORT_3306_TCP`` ）。

.. ENV

ENV
----------

.. [Dockerfile reference for the ENV instruction](../../reference/builder.md#env)

:ref:`Dockerfile リファレンスの ENV コマンド <env>`

.. In order to make new software easier to run, you can use `ENV` to update the
   `PATH` environment variable for the software your container installs. For
   example, `ENV PATH /usr/local/nginx/bin:$PATH` will ensure that `CMD [“nginx”]`
   just works.

新しいソフトウェアに対しては ``ENV`` を用いれば簡単にそのソフトウェアを実行できます。
コンテナがインストールするソフトウェアに必要な環境変数 ``PATH`` を、この ``ENV`` を使って更新します。
たとえば ``ENV PATH /usr/local/nginx/bin:$PATH`` を実行すれば、 ``CMD ["nginx"]`` が確実に動作するようになります。

.. The `ENV` instruction is also useful for providing required environment
   variables specific to services you wish to containerize, such as Postgres’s
   `PGDATA`.

``ENV`` コマンドは、必要となる環境変数を設定するときにも利用します。
たとえば Postgres の ``PGDATA`` のように、コンテナ化したいサービスに固有の環境変数が設定できます。

.. Lastly, `ENV` can also be used to set commonly used version numbers so that
   version bumps are easier to maintain, as seen in the following example:

また ``ENV`` は普段利用している各種バージョン番号を設定しておくときにも利用されます。
これによってバージョンを混同することなく、管理が容易になります。
たとえば以下がその例です。

.. code-block:: bash

   ENV PG_MAJOR 9.3
   ENV PG_VERSION 9.3.4
   RUN curl -SL http://example.com/postgres-$PG_VERSION.tar.xz | tar -xJC /usr/src/postgress && …
   ENV PATH /usr/local/postgres-$PG_MAJOR/bin:$PATH

.. Similar to having constant variables in a program (as opposed to hard-coding
   values), this approach lets you change a single `ENV` instruction to
   auto-magically bump the version of the software in your container.

プログラムにおける（ハードコーディングではない）定数定義と同じことで、この方法をとっておくのが便利です。
ただ１つの ``ENV`` コマンドを変更するだけで、コンテナ内のソフトウェアバージョンは、いとも簡単に変えてしまうことができるからです。

.. ADD or COPY

ADD と COPY
--------------------

.. [Dockerfile reference for the ADD instruction](../../reference/builder.md#add)<br/>
   [Dockerfile reference for the COPY instruction](../../reference/builder.md#copy)

:ref:`Dockerfile リファレンスの ADD コマンド <add>`
:ref:`Dockerfile リファレンスの COPY コマンド <copy>`

.. Although `ADD` and `COPY` are functionally similar, generally speaking, `COPY`
   is preferred. That’s because it’s more transparent than `ADD`. `COPY` only
   supports the basic copying of local files into the container, while `ADD` has
   some features (like local-only tar extraction and remote URL support) that are
   not immediately obvious. Consequently, the best use for `ADD` is local tar file
   auto-extraction into the image, as in `ADD rootfs.tar.xz /`.

``ADD`` と ``COPY`` の機能は似ていますが、一般的には ``COPY`` が選ばれます。
それは ``ADD`` よりも機能がはっきりしているからです。
``COPY`` は単に、基本的なコピー機能を使ってローカルファイルをコンテナにコピーするだけです。
一方 ``ADD`` には特定の機能（ローカルでの tar 展開やリモート URL サポート）があり、これはすぐにわかるものではありません。
結局 ``ADD`` の最も適切な利用場面は、ローカルの tar ファイルを自動的に展開してイメージに書き込むときです。
たとえば ``ADD rootfs.tar.xz /`` といったコマンドになります。

.. If you have multiple `Dockerfile` steps that use different files from your
   context, `COPY` them individually, rather than all at once. This will ensure that
   each step's build cache is only invalidated (forcing the step to be re-run) if the
   specifically required files change.

``Dockerfile`` 内の複数ステップにおいて異なるファイルをコピーするときには、一度にすべてをコピーするのではなく、 ``COPY`` を使って個別にコピーしてください。
こうしておくと、個々のステップに対するキャッシュのビルドは最低限に抑えることができます。
つまり指定されているファイルが変更になったときのみキャッシュが無効化されます（そのステップは再実行されます）。

.. For example:

例：

.. code-block:: bash

   COPY requirements.txt /tmp/
   RUN pip install /tmp/requirements.txt
   COPY . /tmp/

.. Results in fewer cache invalidations for the `RUN` step, than if you put the
   `COPY . /tmp/` before it.

``RUN`` コマンドのステップより前に ``COPY . /tmp/`` を実行していたとしたら、それに比べて上の例はキャッシュ無効化の可能性が低くなっています。

.. Because image size matters, using `ADD` to fetch packages from remote URLs is
   strongly discouraged; you should use `curl` or `wget` instead. That way you can
   delete the files you no longer need after they've been extracted and you won't
   have to add another layer in your image. For example, you should avoid doing
   things like:

イメージ・サイズの問題があるので、 ``ADD`` を用いてリモート URL からパッケージを取得することはやめてください。
かわりに ``curl`` や ``wget`` を使ってください。
こうしておくことで、ファイルを取得し展開した後や、イメージ内の他のレイヤにファイルを加える必要がないのであれば、その後にファイルを削除することができます。
たとえば以下に示すのは、やってはいけない例です。

.. code-block:: bash

   ADD http://example.com/big.tar.xz /usr/src/things/
   RUN tar -xJf /usr/src/things/big.tar.xz -C /usr/src/things
   RUN make -C /usr/src/things all

.. And instead, do something like:

そのかわり、次のように記述します。

.. code-block:: bash

   RUN mkdir -p /usr/src/things \
       && curl -SL http://example.com/big.tar.xz \
       | tar -xJC /usr/src/things \
       && make -C /usr/src/things all

.. For other items (files, directories) that do not require `ADD`’s tar
   auto-extraction capability, you should always use `COPY`.

``ADD`` の自動展開機能を必要としないもの（ファイルやディレクトリ）に対しては、常に ``COPY`` を使うようにしてください。

.. ENTRYPOINT

ENTRYPOINT
----------

.. [Dockerfile reference for the ENTRYPOINT instruction](../../reference/builder.md#entrypoint)

:ref:`Dockerfile リファレンスの ENTRYPOINT コマンド <entrypoint>`

.. The best use for ENTRYPOINT is to set the image’s main command, allowing that image to be run as though it was that command (and then use CMD as the default flags).

``ENTRYPOINT`` のベストな使い方は、イメージにおけるメインコマンドの設定です。これによりイメージは、まるでそのコマンドであるかのように実行できます（そして、 ``CMD`` がデフォルトのフラグとして使われます）。

.. Let’s start with an example of an image for the command line tool s3cmd:

コマンドライン・ツール ``s3cmd`` のイメージを例にしてみましょう。

.. code-block:: bash

   ENTRYPOINT ["s3cmd"]
   CMD ["--help"]

.. Now the image can be run like this to show the command’s help:

このイメージを使って次のように実行したら、コマンドのヘルプを表示します。

.. code-block:: bash

   $ docker run s3cmd

.. Or using the right parameters to execute a command:

あるいは、適切なパラメータを指定したら、コマンドを実行します。

.. code-block:: bash

   $ docker run s3cmd ls s3://mybucket

.. This is useful because the image name can double as a reference to the binary as shown in the command above.

イメージ名が、上述したコマンドで示したバイナリへの参照も兼ねるので便利です。

.. The ENTRYPOINT instruction can also be used in combination with a helper script, allowing it to function in a similar way to the command above, even when starting the tool may require more than one step.

``ENTRYPOINT`` 命令はヘルパースクリプトと合わせて利用することもできます。これにより、ツールを使うために複数のステップが必要になるかもしれない場合も、先ほどのコマンドと似たような方法が使えます。

.. For example, the Postgres Official Image uses the following script as its ENTRYPOINT:

例えば、 `Postgres <https://hub.docker.com/_/postgres/>`_ 公式イメージは次のスクリプトを ``ENTRYPOINT`` に使っています。

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

..     Note: This script uses the exec Bash command so that the final running application becomes the container’s PID 1. This allows the application to receive any Unix signals sent to the container. See the ENTRYPOINT help for more details.

.. note::

   このスクリプトは ``exec`` `Bash コマンド <http://wiki.bash-hackers.org/commands/builtin/exec>`_ をコンテナの PID 1 アプリケーションとして実行します。これにより、コンテナに対して送信される Unix シグナルは、アプリケーションが受信します。詳細は ``ENTRYPOINT`` のヘルプをご覧ください。

.. The helper script is copied into the container and run via ENTRYPOINT on container start:

ヘルパースクリプトはコンテナの中にコピーされ、コンテナ開始時に ``ENTRYPOINT`` から実行されます。

.. code-block:: bash

   COPY ./docker-entrypoint.sh /
   ENTRYPOINT ["/docker-entrypoint.sh"]

.. This script allows the user to interact with Postgres in several ways.

このスクリプトにより、 Postgres とユーザとはいくつかの方法で対話できます。

.. It can simply start Postgres:

単純な postgres の起動にも使えます。

.. code-block:: bash

   $ docker run postgres

.. Or, it can be used to run Postgres and pass parameters to the server:

あるいは、PostgreSQL 実行時、サーバに対してパラメータを渡せます。

.. code-block:: bash

   $ docker run postgres postgres --help

.. Lastly, it could also be used to start a totally different tool, such as Bash:

または、Bash のような全く異なったツールのためにも利用可能です。

.. code-block:: bash

   $ docker run --rm -it postgres bash

.. VOLUME

VOLUME
----------

[Dockerfile reference for the VOLUME instruction](../../reference/builder.md#volume)

:ref:`Dockerfile リファレンスの VOLUME コマンド <volume>`

.. The VOLUME instruction should be used to expose any database storage area, configuration storage, or files/folders created by your docker container. You are strongly encouraged to use VOLUME for any mutable and/or user-serviceable parts of your image.

``VOLUME`` 命令はデータベース・ストレージ領域、設定用ストレージ、Docker コンテナによって作成されるファイルやフォルダの公開に使います。イメージにおける任意の、変わりやすい(かつ/または)ユーザが使う部分では VOLUME の利用が強く推奨されます。

.. USER

USER
----------

.. [Dockerfile reference for the USER instruction](../../reference/builder.md#user)

:ref:`Dockerfile リファレンスの USER コマンド <user>`

.. If a service can run without privileges, use USER to change to a non-root user. Start by creating the user and group in the Dockerfile with something like RUN groupadd -r postgres && useradd -r -g postgres postgres.

サービスが特権なしに実行できるなら、``USER`` を用いて root 以外のユーザに変更しましょう。利用するには ``Dockerfile`` で ``RUN groupadd -r postgres && useradd -r -g postgres postgres`` のようにユーザとグループを作成します。

..     Note: Users and groups in an image get a non-deterministic UID/GID in that the “next” UID/GID gets assigned regardless of image rebuilds. So, if it’s critical, you should assign an explicit UID/GID.

.. note::

   イメージ内で得られるユーザとグループの UID/GID は非決定的で、イメージの再構築とは無関係に「次の」 UID/GID が割り当てられます。これが問題になるようなら、UID/GID を明確に割り当ててください。
   
.. You should avoid installing or using sudo since it has unpredictable TTY and signal-forwarding behavior that can cause more problems than it solves. If you absolutely need functionality similar to sudo (e.g., initializing the daemon as root but running it as non-root), you may be able to use “gosu”.

``sudo`` は予測不可能なTTY/シグナル送信といった挙動を見せ、解決するより多くの問題を作り出しかねないので、インストールや使用は避けたほうが良いでしょう。もし、どうしても ``sudo`` のような機能が必要であれば（例：root としてデーモンを初期化しますが、実行は root 以外で行いたい時）、 「 `gosu <https://github.com/tianon/gosu>`_ 」を利用ができます。

.. Lastly, to reduce layers and complexity, avoid switching USER back and forth frequently.

あとは、レイヤの複雑さを減らすため、 ``USER`` を頻繁に切り替えるべきではありません。

.. WORKDIR

WORKDIR
----------

.. [Dockerfile reference for the WORKDIR instruction](../../reference/builder.md#workdir)

:ref:`Dockerfile リファレンスの WORKDIR コマンド <workdir>`

.. For clarity and reliability, you should always use absolute paths for your WORKDIR. Also, you should use WORKDIR instead of proliferating instructions like RUN cd … && do-something, which are hard to read, troubleshoot, and maintain.

明確さと信頼性のため、常に ``WORKDIR`` からの絶対パスを使うべきです。また、 ``RUN cd ... && 何らかの処理`` のような読みにくくデバッグもメンテも困難で増殖していく命令の代わりにも、 ``WORKDIR`` を使うべきです。

.. ONBUILD

ONBUILD
----------

.. [Dockerfile reference for the ONBUILD instruction](../../reference/builder.md#onbuild)

:ref:`Dockerfile リファレンスの ONBUILD コマンド <onbuild>`

.. An ONBUILD command executes after the current Dockerfile build completes. ONBUILD executes in any child image derived FROM the current image. Think of the ONBUILD command as an instruction the parent Dockerfile gives to the child Dockerfile.

``ONBULID`` コマンドは現 ``Dockerfile`` による構築の完了後に実行されます。 ``ONBUILD`` は、このイメージから ``FROM`` で派生したあらゆる子イメージにおいても実行されます。 ``ONBUILD`` コマンドは親の ``Dockerfile`` が子 ``Dockerfile``  に指定する命令としても考えられます。

.. A Docker build executes ONBUILD commands before any command in a child Dockerfile.

Docker は ``ONBUILD`` コマンドを処理する前に、あらゆる子 ``Dockerfile`` 命令を実行します。

.. ONBUILD is useful for images that are going to be built FROM a given image. For example, you would use ONBUILD for a language stack image that builds arbitrary user software written in that language within the Dockerfile, as you can see in Ruby’s ONBUILD variants.

``ONBUILD`` は 指定されたイメージから ``FROM`` で派生してビルドされるイメージにとって便利です。例えば、言語スタック・イメージの ``Dockerfile`` で ``ONBUILD`` を 使えば、その言語で書かれた任意のユーザソフトウェアをビルドできます。 これは Ruby の ``ONBUILD`` 各種でも `見られます <https://github.com/docker-library/ruby/blob/master/2.1/onbuild/Dockerfile>`_ 。

.. Images built from ONBUILD should get a separate tag, for example: ruby:1.9-onbuild or ruby:2.0-onbuild.

``ONBUILD`` によって構築されるイメージは、異なったタグを指定すべきです。例： ``ruby:1.9-onbuild`` や ``ruby:2.0-onbuild`` 。

.. Be careful when putting ADD or COPY in ONBUILD. The “onbuild” image will fail catastrophically if the new build’s context is missing the resource being added. Adding a separate tag, as recommended above, will help mitigate this by allowing the Dockerfile author to make a choice.

``ONBUILD`` で ``ADD`` や ``COPY`` を使う時は注意してください。追加されるべきリソースが新しいビルドコンテキスト上で見つからなければ、「onbuild」イメージに破滅的な失敗をもたらします。先ほどお勧めしたように、別々のタグを付けておけば、 ``Dockerfile`` の書き手が選べるようになります。

.. Examples for Official Repositories

公式リポジトリの例
====================

.. These Official Repositories have exemplary Dockerfiles:

模範的な ``Dockerfile`` の例をご覧ください。

..    Go
    Perl
    Hy
    Rails

* `Go <https://hub.docker.com/_/golang/>`_
* `Perl <https://hub.docker.com/_/perl/>`_
* `Hy <https://hub.docker.com/_/hylang/>`_
* `Rails <https://hub.docker.com/_/rails>`_

.. Additional resources:

さらなるリソース情報
====================

..    Dockerfile Reference
    More about Base Images
    More about Automated Builds
    Guidelines for Creating Official Repositories

* :doc:`Dockerfile リファレンス </engine/reference/builder>`
* :doc:`ベース・イメージの詳細 <baseimages>`
* :doc:`自動構築の詳細 </docker-hub/builds>`
* :doc:`公式リポジトリ作成のガイドライン </docker-hub/official_repos>`

.. seealso:: 

   Best practices for writing Dockerfiles
      https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
