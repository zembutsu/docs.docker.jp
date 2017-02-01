.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/eng-image/dockerfile_best-practices.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/userguide/eng-image/dockerfile_best-practices.md
.. check date: 2016/04/16
.. Commits on Mar 15, 2016 2f634e4691d13616cf8c714ec7653616ec3b121a
.. ---------------------------------------------------------------------------

.. Best practices for writing Dockerfile

.. _best-practices-for-writing-dockerfile:

=======================================
Dockerfile を書くベスト・プラクティス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker can build images automatically by reading the instructions from a Dockerfile, a text file that contains all the commands, in order, needed to build a given image. Dockerfiles adhere to a specific format and use a specific set of instructions. You can learn the basics on the Dockerfile Reference page. If you’re new to writing Dockerfiles, you should start there.

Docker は ``Dockerfile`` の命令を読み込み、自動的にイメージを構築できます。これはテキストファイルであり、特定のイメージを構築するために必要な全ての命令が入っています。 ``Dockerfile`` は個別の命令セットを使い、特定の形式で記述します。基本は :doc:`Dockerfile リファレンス </engine/reference/builder>` で学べます。新しく ``Dockerfile`` を書こうとしているのであれば、そのリファレンスから出発しましょう。

.. This document covers the best practices and methods recommended by Docker, Inc. and the Docker community for creating easy-to-use, effective Dockerfiles. We strongly suggest you follow these recommendations (in fact, if you’re creating an Official Image, you must adhere to these practices).

このドキュメントは Docker 社が推奨するベストプラクティスや手法を扱っており、Docker コミュニティが簡単かつ効率的に ``Dockerfile`` を作成できるようにします。この推奨方法に従うことを強く勧めます（実際、公式イメージを作成するには、これらのプラクティスに従う *必要* があります）。

.. You can see many of these practices and recommendations in action in the buildpack-deps Dockerfile.

多くのベストプラクティスや推奨する手法は、 `buildpack-deps <https://github.com/docker-library/buildpack-deps/blob/master/jessie/Dockerfile>`_ の ``Dockerfile`` でご覧いただけます。

..    Note: for more detailed explanations of any of the Dockerfile commands mentioned here, visit the Dockerfile Reference page.

.. note::

   Dockerfile の命令に関するより詳細な説明は、 :doc:`Dockerfile リファレンス </engine/reference/builder>` ページをご覧ください。

.. General guidelines and recommendations

一般的なガイドラインとアドバイス
================================

.. Containers should be ephemeral

コンテナはエフェメラルであるべき
----------------------------------------

.. The container produced by the image your Dockerfile defines should be as ephemeral as possible. By “ephemeral,” we mean that it can be stopped and destroyed and a new one built and put in place with an absolute minimum of set-up and configuration.

``Dockerfile`` で定義されたイメージを使って作成するコンテナは、可能ならばエフェメラル（短命；ephemeral）にすべきです。私たちの「エフェメラル」とは、停止・破棄可能であり、明らかに最小のセットアップで構築して使えることを意味します。

.. Use a .dockerignore file

.dockerignore ファイルの利用
------------------------------

.. In most cases, it’s best to put each Dockerfile in an empty directory. Then, add to that directory only the files needed for building the Dockerfile. To increase the build’s performance, you can exclude files and directories by adding a .dockerignore file to that directory as well. This file supports exclusion patterns similar to .gitignore files. For information on creating one, see the .dockerignore file.

ほとんどの場合、空のディレクトリに個々の Dockerfile を置くのがベストです。そうしておけば、そのディレクトリには Dockerfile が構築に必要なファイルだけ追加します。構築のパフォーマンスを高めるには、 ``.dockerignore`` ファイルを作成し、対象ディレクトリ上のファイルやディレクトリを除外できます。このファイルの除外パターンは ``.gitignore`` ファイルに似ています。ファイルを作成するには、 :ref:`.dockerignore ファイル <dockerignore-file>` をご覧ください。

.. Avoid installing unnecessary packages

不要なパッケージをインストールしない
----------------------------------------

.. In order to reduce complexity, dependencies, file sizes, and build times, you should avoid installing extra or unnecessary packages just because they might be “nice to have.” For example, you don’t need to include a text editor in a database image.

複雑さ、依存関係、ファイルサイズ、構築時間をそれぞれ減らすために、余分ないし不必要な「入れた方が良いだろう」というパッケージは、インストールを避けるべきです。例えば、データベース・イメージであればテキストエディタは不要でしょう。

.. Run only one process per container

コンテナごとに１つのプロセスだけ実行
----------------------------------------

.. In almost all cases, you should only run a single process in a single container. Decoupling applications into multiple containers makes it much easier to scale horizontally and reuse containers. If that service depends on another service, make use of container linking.

ほとんどの場合、１つのコンテナの中で１つのプロセスだけ実行すべきです。アプリケーションを複数のコンテナに分離することは、水平スケールやコンテナの再利用を簡単にします。サービスとサービスに依存関係がある場合は、 :doc:`コンテナのリンク </engine/userguide/networking/default_network/dockerlinks>` を使います。

.. Minimize the number of layers

レイヤの数を最小に
--------------------

.. You need to find the balance between readability (and thus long-term maintainability) of the Dockerfile and minimizing the number of layers it uses. Be strategic and cautious about the number of layers you use.

``Dockerfile`` の読みやすさと、使用するイメージレイヤ数の最小化は、両者のバランスを見つける必要があります。戦略的に注意深くレイヤ数をお使いください。

.. Sort multi-line arguments

複数行の引数
--------------------

.. Whenever possible, ease later changes by sorting multi-line arguments alphanumerically. This will help you avoid duplication of packages and make the list much easier to update. This also makes PRs a lot easier to read and review. Adding a space before a backslash (\) helps as well.

可能であれば常に複数行の引数をアルファベット順にします。これにより、パッケージが重複しないようにし、あるいはリストの更新を容易にします。また、プルリクエストの読み込みとレビューをより簡単にします。バックスラッシュ( \\ ) の前に空白を追加するのも、同じく役立つでしょう。

.. Here’s an example from the buildpack-deps image:

以下は ``buildpack-deps`` `イメージ <https://github.com/docker-library/buildpack-deps>`_ の記述例です。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
     bzr \
     cvs \
     git \
     mercurial \
     subversion

.. Build cache

.. _build-cache:

構築キャッシュ
--------------------

.. During the process of building an image Docker will step through the instructions in your Dockerfile executing each in the order specified. As each instruction is examined Docker will look for an existing image in its cache that it can reuse, rather than creating a new (duplicate) image. If you do not want to use the cache at all you can use the --no-cache=true option on the docker build command.

Docker イメージ構築のプロセスとは、 ``Dockerfile``  で指定した各命令を順番に実行していきます。それぞれの命令で、新しい（あるいは重複した）イメージを作成するのではなく、Docker は既存イメージのキャッシュがないか確認します。もしキャッシュを全く使いたくなければ、 ``docker build`` コマンドで ``--no-cache=true`` オプションを使います。

.. However, if you do let Docker use its cache then it is very important to understand when it will, and will not, find a matching image. The basic rules that Docker will follow are outlined below:

一方で非常に重要なのは、Docker でキャッシュ機能を使うにあたり、マシンイメージを探す時に、何を行い何を行わないかの理解です。Docker の基本的な処理の概要は、次の通りです。

..    Starting with a base image that is already in the cache, the next instruction is compared against all child images derived from that base image to see if one of them was built using the exact same instruction. If not, the cache is invalidated.

* 開始にあたり、ベース・イメージが既にキャッシュにあれば、次の命令を対象のベース・イメージから派生した全ての子イメージと比較します。同じ命令があれば構築にそのイメージを使います。もし同じ命令がなければ、キャッシュを無効化します。

..    In most cases simply comparing the instruction in the Dockerfile with one of the child images is sufficient. However, certain instructions require a little more examination and explanation.

* ほとんどの場合は、 ``Dockerfile`` 命令と子イメージの単純な比較で十分です。しかし、命令によっては更なる検査や追加検査が必要になります。

..    For the ADD and COPY instructions, the contents of the file(s) in the image are examined and a checksum is calculated for each file. The last-modified and last-accessed times of the file(s) are not considered in these checksums. During the cache lookup, the checksum is compared against the checksum in the existing images. If anything has changed in the file(s), such as the contents and metadata, then the cache is invalidated.

* ``ADD`` と ``COPY`` 命令は、イメージに含まれるファイルが検査され、各ファイルのチェックサムを計算します。ファイルの最終編集・最終アクセス時間は、チェックサムに影響ありません。キャッシュを探し、既存のイメージのチェックサムと比較します。内容やメタデータのようにファイルに変更があれば、キャッシュを無効化します。

..    Aside from the ADD and COPY commands, cache checking will not look at the files in the container to determine a cache match. For example, when processing a RUN apt-get -y update command the files updated in the container will not be examined to determine if a cache hit exists. In that case just the command string itself will be used to find a match.

* ``ADD`` と ``COPY`` コマンドだけでなく、キャッシュのチェックにおいて、キャッシュが一致すると思われるコンテナ内のファイル状態を確認しません。例えば、 ``RUN apt-get -y update`` コマンドによってコンテナ内のファイルに変更を加えたとしても、キャッシュの有無に影響を与えません。この場合、コマンドの文字列自身が一致するかどうかしか見ないためです。

.. Once the cache is invalidated, all subsequent Dockerfile commands will generate new images and the cache will not be used.

* キャッシュを無効化すると、以降の ``Dockerfile`` 命令ではキャッシュは使われず、新しいイメージを生成します。

.. The Dockerfile instructions

Dockerfile 命令
====================

.. Below you’ll find recommendations for the best way to write the various instructions available for use in a Dockerfile.

以下では、``Dockerfile`` で様々な命令を使うにあたり、推奨するベストな方法が分かるでしょう。

.. FROM

FROM
----------

.. Dockerfile reference for the FROM instruction

:ref:`Dockerfile リファレンスの FROM 命令 <from>`

.. Whenever possible, use current Official Repositories as the basis for your image. We recommend the Debian image since it’s very tightly controlled and kept minimal (currently under 150 mb), while still being a full distribution.

可能であれば、自分のイメージの元として現在の公式リポジトリを使います。私たちは `Debian イメージ <https://hub.docker.com/_/debian/>`_ を推奨します。これは、非常にしっかりと管理されており、ディストリビューションの中でも小さくなるよう（現在は 150 MB 以下に）維持されているからです。

.. RUN

RUN
----------

.. Dockerfile reference for the RUN instruction

:ref:`Dockerfile リファレンスの RUN 命令 <run>`

.. As always, to make your Dockerfile more readable, understandable, and maintainable, split long or complex RUN statements on multiple lines separated with backslashes.

常に ``Dockerfile`` をより読みやすく、理解しやすく、メンテナンスしやすくします。長ければ分割するか、複雑な ``RUN`` 命令はバックスラッシュを使い複数行に分割します。

.. apt-get

.. Probably the most common use-case for RUN is an application of apt-get. The RUN apt-get command, because it installs packages, has several gotchas to look out for.

おそらく ``RUN`` の最も一般的な利用例は ``apt-get`` アプリケーションです。 ``RUN apt-get`` コマンドはパッケージをインストールしますので、気を付けるべきいくつかの注意点があります。

.. You should avoid RUN apt-get upgrade or dist-upgrade, as many of the “essential” packages from the base images won’t upgrade inside an unprivileged container. If a package contained in the base image is out-of-date, you should contact its maintainers. If you know there’s a particular package, foo, that needs to be updated, use apt-get install -y foo to update automatically.

まず、``RUN apt-get update`` や ``dist-upgrade`` を避けるべきでしょう。ベース・イメージに含まれる「必須」パッケージの多くが、権限を持たないコンテナの内部で更新されないためです。もし、ベース・イメージに含まれるパッケージが時代遅れになっていれば、イメージのメンテナに連絡すべきでしょう。例えば、 ``foo`` という特定のパッケージを知っていて、それを更新する必要があるのであれば、自動的に更新するために ``apt-get install -y foo`` を使います。

.. Always combine RUN apt-get update with apt-get install in the same RUN statement, for example:

``RUN apt-get update`` と ``apt-get install`` は常に同じ ``RUN`` 命令文で連結します。以下は実行例です。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
       package-bar \
       package-baz \
       package-foo

.. Using apt-get update alone in a RUN statement causes caching issues and subsequent apt-get install instructions fail. For example, say you have a Dockerfile:

``RUN`` 命令文で ``apt-get update`` だけを使うとキャッシュ問題を引き起こし、その後の ``apt-get install`` 命令が失敗します。例えば、次のように Dockerfile を記述したとします。

.. code-block:: bash

   FROM ubuntu:14.04
   RUN apt-get update
   RUN apt-get install -y curl

.. After building the image, all layers are in the Docker cache. Suppose you later modify apt-get install by adding extra package:

イメージを構築後、Docker は全てのレイヤをキャッシュします。次に、別のパッケージを追加する ``apt-get install`` を編集したとします。

.. code-block:: bash

   FROM ubuntu:14.04
   RUN apt-get update
   RUN apt-get install -y curl nginx

.. Docker sees the initial and modified instructions as identical and reuses the cache from previous steps. As a result the apt-get update is NOT executed because the build uses the cached version. Because the apt-get update is not run, your build can potentially get an outdated version of the curl and nginx packages.

Docker は冒頭からファイルを読み込み、命令の変更を認識したら、前回に作成したキャッシュを再利用します。つまり、 ``apt-get update`` は *決して* 実行されず、キャッシュされたバージョンを使います。これは ``apt-get update`` を更新していないため、古いバージョンの ``curl`` と ``nginx`` パッケージを取得する恐れがあります。

.. Using RUN apt-get update && apt-get install -y ensures your Dockerfile installs the latest package versions with no further coding or manual intervention. This technique is known as “cache busting”. You can also achieve cache-busting by specifying a package version. This is known as version pinning, for example:

そこで、Dockerfile でインストールする場合は ``RUN apt-get update && apt-get install -y`` を指定し、最新バージョンのパッケージを、追加の記述や手動作業なく利用できます。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
       package-bar \
       package-baz \
       package-foo=1.3.*

.. Version pinning forces the build to retrieve a particular version regardless of what’s in the cache. This technique can also reduce failures due to unanticipated changes in required packages.

パッケージのバージョン指定は、何をキャッシュしているか気にせずに、特定バージョンを取得した上での構築を強制します。このテクニックにより、必要なパッケージが、予期しない変更によって引き起こされる失敗を減らします。

.. Below is a well-formed RUN instruction that demonstrates all the apt-get recommendations.

以下は　丁寧に練られた ``RUN`` 命令であり、推奨する ``apt-get`` の使い方の全てを示すものです。

.. code-block:: bash

   RUN apt-get update && apt-get install -y \
       aufs-tools \
       automake \
       build-essential \
       curl \
       dpkg-sig \
       libcap-dev \
       libsqlite3-dev \
       lxc=1.0* \
       mercurial \
       reprepro \
       ruby1.9.1 \
       ruby1.9.1-dev \
       s3cmd=1.1.* \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

.. The s3cmd instructions specifies a version 1.1.0*. If the image previously used an older version, specifying the new one causes a cache bust of apt-get update and ensure the installation of the new version. Listing packages on each line can also prevent mistakes in package duplication.

``s3cmd`` の命令行は、バージョン ``1.1.*`` を指定します。従来のイメージが古いバージョンを使っていたとしても、新しいイメージは ``apt-get update`` でキャッシュを使いません。そのため、確実に新しいバージョンをインストールします。他の各行はパッケージのリストであり、パッケージの重複という間違いをさせないためです。

.. In addition, cleaning up the apt cache and removing /var/lib/apt/lists helps keep the image size down. Since the RUN statement starts with apt-get update, the package cache will always be refreshed prior to apt-get install.

付け加えると、apt キャッシュをクリーンにし、 ``/var/lib/apt/lits`` を削除すると、イメージのサイズを減らします。 ``RUN`` 命令は ``apt-get update`` から開始しますので、 ``apt-get install`` は常に新しいパッケージをインストールします。

.. CMD

CMD
----------

.. Dockerfile reference for the CMD instruction

:ref:`Dockerfile リファレンスの CMD 命令 <cmd>`

.. The CMD instruction should be used to run the software contained by your image, along with any arguments. CMD should almost always be used in the form of CMD [“executable”, “param1”, “param2”…]. Thus, if the image is for a service (Apache, Rails, etc.), you would run something like CMD ["apache2","-DFOREGROUND"]. Indeed, this form of the instruction is recommended for any service-based image.

``CMD`` 命令は、イメージに含まれるソフトウェアの実行と、その引数のために使うべきです。また、``CMD`` は常に ``CMD [“実行ファイル”, “パラメータ1”, “パラメタ2”…]`` のような形式で使うべきです。そのため、イメージがサービス向け（Apache、Rails 等）であれば、 ``CMD ["apache2","-DFOREGROUND"]`` のようにすべきでしょう。実際に、あらゆるサービスのベースとなるイメージで、この命令形式が推奨されます。

.. In most other cases, CMD should be given an interactive shell (bash, python, perl, etc), for example, CMD ["perl", "-de0"], CMD ["python"], or CMD [“php”, “-a”]. Using this form means that when you execute something like docker run -it python, you’ll get dropped into a usable shell, ready to go. CMD should rarely be used in the manner of CMD [“param”, “param”] in conjunction with ENTRYPOINT, unless you and your expected users are already quite familiar with how ENTRYPOINT works.

その他の多くの場合、 ``CMD`` はインタラクティブなシェル（bash、python、perl 等）で使われます。例えば、 ``CMD ["perl", "-de0"]`` 、 ``CMD ["python"]`` 、 ``CMD [“php”, “-a”]`` です。この利用形式が意味するのは、 ``docker run -it python`` のように実行したら、そのコマンドを使いやすいシェル上に落とし込み、すぐに使えるようにします。 また、あなたとあなたの想定ユーザが ``ENTRYPOINT`` の動作に慣れていないなら、 ``CMD [“パラメータ”, “パラメータ”]`` 形式のように ``CMD`` を ``ENTRYPOINT`` と一緒に使うべきではないでしょう。

.. EXPOSE

EXPOSE
----------

.. Dockerfile reference for the EXPOSE instruction

:ref:`Dockerfile リファレンスの EXPOSE 命令 <expose>`

.. The EXPOSE instruction indicates the ports on which a container will listen for connections. Consequently, you should use the common, traditional port for your application. For example, an image containing the Apache web server would use EXPOSE 80, while an image containing MongoDB would use EXPOSE 27017 and so on.

``EXPOSE`` 命令は、コンテナが接続用にリッスンするポートを指定します。そのため、アプリケーションが一般的に使う、あるいは、伝統的なポートを使うべきです。例えば、Apache ウェブ・サーバのイメージは ``EXPOSE 80`` を使い、MongoDB を含むイメージであれば ``EXPOSE 27017`` を使うでしょう。

.. For external access, your users can execute docker run with a flag indicating how to map the specified port to the port of their choice. For container linking, Docker provides environment variables for the path from the recipient container back to the source (ie, MYSQL_PORT_3306_TCP).

外部からアクセスするためには、ユーザが ``docker run`` 実行時にフラグを指定し、特定のポートを任意のポートに割り当てられます。コンテナのリンク機能を使えば、Docker はコンテナがソースをたどれるよう、環境変数を提供します（例： ``MYSQL_PORT_3306_TCP`` ）。

.. ENV

ENV
----------

.. Dockerfile reference for the ENV instruction

:ref:`Dockerfile リファレンスの ENV 命令 <env>`

.. In order to make new software easier to run, you can use ENV to update the PATH environment variable for the software your container installs. For example, ENV PATH /usr/local/nginx/bin:$PATH will ensure that CMD [“nginx”] just works.

新しいソフトウェアを簡単に実行するため、コンテナにインストールされているソフトウェアの ``PATH`` 環境変数を ``ENV`` を使って更新できます。例えば、 ``ENV PATH /usr/local/nginx/bin:$PATH`` は ``CMD ["nginx"]`` を動作するようにします。

.. The ENV instruction is also useful for providing required environment variables specific to services you wish to containerize, such as Postgres’s PGDATA.

また、 ``ENV`` 命令は PostgreSQL の ``PGDATA`` のような、コンテナ化されたサービスが必要な環境変数を指定するのにも便利です。

.. Lastly, ENV can also be used to set commonly used version numbers so that version bumps are easier to maintain, as seen in the following example:

あとは、 ``ENV`` は一般的に使うバージョン番号の指定にも使えます。そのため、バージョンを特定したメンテナンスを次のように簡単にします。

.. code-block:: bash

   ENV PG_MAJOR 9.3
   ENV PG_VERSION 9.3.4
   RUN curl -SL http://example.com/postgres-$PG_VERSION.tar.xz | tar -xJC /usr/src/postgress && …
   ENV PATH /usr/local/postgres-$PG_MAJOR/bin:$PATH

.. Similar to having constant variables in a program (as opposed to hard-coding values), this approach lets you change a single ENV instruction to auto-magically bump the version of the software in your container.

プログラムにおける恒常的な変数と似ています。しかし（ハード・コーディングされた値とは違い）、この手法は ``ENV`` 命令の指定で、コンテナ内のソフトウェアのバージョンを自動的に選べるようにします。

.. ADD or COPY

ADD と COPY
--------------------

.. Dockerfile reference for the ADD instruction
.. Dockerfile reference for the COPY instruction

:ref:`Dockerfile リファレンスの ADD 命令 <add>`
:ref:`Dockerfile リファレンスの COPY 命令 <copy>`

.. Although ADD and COPY are functionally similar, generally speaking, COPY is preferred. That’s because it’s more transparent than ADD. COPY only supports the basic copying of local files into the container, while ADD has some features (like local-only tar extraction and remote URL support) that are not immediately obvious. Consequently, the best use for ADD is local tar file auto-extraction into the image, as in ADD rootfs.tar.xz /.

``ADD`` と ``COPY`` の機能は似ていますが、一般的には ``COPY`` が望ましいと言われています。これは、 ``ADD`` よりも機能が明確なためです。 ``COPY`` はローカルファイルをコンテナの中にコピーするという、基本的な機能しかサポートしていません。一方の ``ADD`` は複数の機能（ローカル上での tar アーカイブ展開や、リモート URL のサポート）を持ち、一見では処理内容が分かりません（訳者注：ファイルや URL に何が含まれているか確認できないためです）。したがって ``ADD`` のベストな使い方は、ローカルの tar ファイルをイメージに自動展開（ ``ADD rootfs.tar.xz /`` ）する用途です。

.. If you have multiple Dockerfile steps that use different files from your context, COPY them individually, rather than all at once. This will ensure that each step’s build cache is only invalidated (forcing the step to be re-run) if the specifically required files change.

内容によっては、一度にファイルを取り込むよりも、 ``Dockerfile`` の複数ステップで ``COPY`` することもあるでしょう。これにより、何らかのファイルが変更された所だけ、キャッシュが無効化されます（ステップを強制的に再実行します）。

.. For example:

例：

.. code-block:: bash

   COPY requirements.txt /tmp/
   RUN pip install /tmp/requirements.txt
   COPY . /tmp/

.. Results in fewer cache invalidations for the RUN step, than if you put the COPY . /tmp/ before it.

``RUN`` ステップはキャッシュ無効化の影響が少なくなるよう、 ``COPY . /tmp/`` の前に入れるべきでしょう。

.. Because image size matters, using ADD to fetch packages from remote URLs is strongly discouraged; you should use curl or wget instead. That way you can delete the files you no longer need after they’ve been extracted and you won’t have to add another layer in your image. For example, you should avoid doing things like:

イメージ・サイズの問題のため、 ``ADD`` でリモート URL 上のパッケージを取得するのは可能な限り避けてください。その代わりに ``curl`` や ``wget`` を使うべきです。この方法であれば、展開後に不要となったファイルを削除でき、イメージに余分なレイヤを増やしません。例えば、次のような記述は避けるべきです。

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

.. For other items (files, directories) that do not require ADD’s tar auto-extraction capability, you should always use COPY.

他のアイテム（ファイルやディレクトリ）は ``ADD`` の自動展開機能を必要としませんので、常に ``COPY`` を使うべきです。

.. ENTRYPOINT

ENTRYPOINT
----------

.. Dockerfile reference for the ENTRYPOINT instruction

:ref:`Dockerfile リファレンスの ENTRYPOINT 命令 <entrypoint>`

.. The best use for ENTRYPOINT is to set the image’s main command, allowing that image to be run as though it was that command (and then use CMD as the default flags).

``ENTRYPOINT`` のベストな使い方は、イメージにおけるメインコマンドの設定です。これによりイメージを指定したコマンドを通して実行します（そして、 ``CMD`` がデフォルトのフラグとして使われます）。

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

イメージ名が先ほどの命令で指定したコマンドのバイナリも兼ねているため、使いやすくなります。

.. The ENTRYPOINT instruction can also be used in combination with a helper script, allowing it to function in a similar way to the command above, even when starting the tool may require more than one step.

また、``ENTRYPOINT`` 命令は役に立つスクリプトの組みあわせにも利用できます。そのため、ツールを使うために複数のステップが必要になるかもしれない場合も、先ほどのコマンドと似たような方法が使えます。

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

ヘルパー・スクリプトをコンテナの中にコピーし、コンテナ開始時の ``ENTRYPOINT`` で実行します。

.. code-block:: bash

   COPY ./docker-entrypoint.sh /
   ENTRYPOINT ["/docker-entrypoint.sh"]

.. This script allows the user to interact with Postgres in several ways.

このスクリプトは Postgres とユーザとの対話に利用できます。例えば簡単な postgres の起動に使えます。

.. It can simply start Postgres:

.. 単純な postgres の起動に使います。

.. code-block:: bash

   $ docker run postgres

.. Or, it can be used to run Postgres and pass parameters to the server:

あるいは、PostgreSQL 実行時、サーバに対してパラメータを渡せます。

.. code-block:: bash

   $ docker run postgres postgres --help

.. Lastly, it could also be used to start a totally different tool, such as Bash:

または、Bash のように全く異なったツールのためにも利用可能です。

.. code-block:: bash

   $ docker run --rm -it postgres bash

.. VOLUME

VOLUME
----------

.. Dockerfile reference for the VOLUME instruction

:ref:`Dockerfile リファレンスの VOLUME 命令 <volume>`

.. The VOLUME instruction should be used to expose any database storage area, configuration storage, or files/folders created by your docker container. You are strongly encouraged to use VOLUME for any mutable and/or user-serviceable parts of your image.

``VOLUME`` 命令はデータベース・ストレージ領域、設定用ストレージ、Docker コンテナによって作成されるファイルやフォルダの公開のために使います。イメージにおいて変わりやすい場所・ユーザによって便利な場所として VOLUME の利用が強く推奨されます。

.. USER

USER
----------

.. Dockerfile reference for the USER instruction

:ref:`Dockerfile リファレンスの USER 命令 <user>`

.. If a service can run without privileges, use USER to change to a non-root user. Start by creating the user and group in the Dockerfile with something like RUN groupadd -r postgres && useradd -r -g postgres postgres.

 ``USER`` を使えばサービスを特権ユーザで実行せずに、root 以外のユーザで実行できます。利用するには ``Dockerfile`` で ``RUN groupadd -r postgres && useradd -r -g postgres postgres`` のようにユーザとグループを作成します。

..     Note: Users and groups in an image get a non-deterministic UID/GID in that the “next” UID/GID gets assigned regardless of image rebuilds. So, if it’s critical, you should assign an explicit UID/GID.

.. note::

   イメージ内で得られるユーザとグループは UID/GID に依存しないため、イメージの構築に関係なく次の UID/GID が割り当てられます。そのため、これが問題になるのであれば、UID/GID を明確に割り当ててください。
   
.. You should avoid installing or using sudo since it has unpredictable TTY and signal-forwarding behavior that can cause more problems than it solves. If you absolutely need functionality similar to sudo (e.g., initializing the daemon as root but running it as non-root), you may be able to use “gosu”.

TTY やシグナル送信を使わないつもりであれば、 ``sudo`` のインストールや使用を避けると良いでしょう。使うことで引き起こされる問題の解決は大変だからです。もし、どうしても ``sudo`` のような機能が必要であれば（例：root としてデーモンを初期化しますが、実行は root 以外で行いたい時）、 「 `gosu <https://github.com/tianon/gosu>`_ 」を利用ができます。

.. Lastly, to reduce layers and complexity, avoid switching USER back and forth frequently.

あとは、レイヤの複雑さを減らすため、 ``USER`` を頻繁に切り替えるべきではありません。

.. WORKDIR

WORKDIR
----------

.. Dockerfile reference for the WORKDIR instruction

:ref:`Dockerfile リファレンスの WORKDIR 命令 <workdir>`

.. For clarity and reliability, you should always use absolute paths for your WORKDIR. Also, you should use WORKDIR instead of proliferating instructions like RUN cd … && do-something, which are hard to read, troubleshoot, and maintain.

明確さと信頼性のため、常に ``WORKDIR`` からの絶対パスを使うべきです。また、 ``WORKDIR`` を ``RUN cd ... && 何らかの処理`` のように増殖する命令の代わり使うことで、より読みやすく、トラブルシュートしやすく、維持しやすくします。

.. ONBUILD

ONBUILD
----------

.. Dockerfile reference for the ONBUILD instruction

:ref:`Dockerfile リファレンスの ONBUILD 命令 <onbuild>`

.. An ONBUILD command executes after the current Dockerfile build completes. ONBUILD executes in any child image derived FROM the current image. Think of the ONBUILD command as an instruction the parent Dockerfile gives to the child Dockerfile.

``ONBULID`` 命令は現``Dockerfile`` による構築後に実行します。 ``ONBUILD`` は ``FROM`` から現在に至るあらゆる子イメージで実行できます。 ``ONBUILD`` コマンドは親の ``Dockerfile`` が子 ``Dockerfile``  を指定する命令としても考えられます。

.. A Docker build executes ONBUILD commands before any command in a child Dockerfile.

Docker は ``ONBUILD`` コマンドを処理する前に、あらゆる子 ``Dockerfile`` 命令を実行します。

.. ONBUILD is useful for images that are going to be built FROM a given image. For example, you would use ONBUILD for a language stack image that builds arbitrary user software written in that language within the Dockerfile, as you can see in Ruby’s ONBUILD variants.

``ONBUILD`` は ``FROM`` で指定したイメージを作ったあと、更にイメージを作るのに便利です。例えば、言語スタック・イメージで ``ONBUILD`` を使えば、 ``Dockerfile`` 内のソフトウェアは特定の言語環境を使えるようになります。これは Ruby の ``ONBUILD`` でも `見られます <https://github.com/docker-library/ruby/blob/master/2.1/onbuild/Dockerfile>`_ 。

.. Images built from ONBUILD should get a separate tag, for example: ruby:1.9-onbuild or ruby:2.0-onbuild.

``ONBUILD`` によって構築されるイメージは、異なったタグを指定すべきです。例： ``ruby:1.9-onbuild`` や ``ruby:2.0-onbuild`` 。

.. Be careful when putting ADD or COPY in ONBUILD. The “onbuild” image will fail catastrophically if the new build’s context is missing the resource being added. Adding a separate tag, as recommended above, will help mitigate this by allowing the Dockerfile author to make a choice.

``ONBUILD`` で ``ADD`` や ``COPY`` を使う時は注意してください。追加された新しいリソースが新しいイメージ上で見つからなければ、「onbuild」イメージに破壊的な失敗をもたらします。先ほどお勧めしたように、別々のタグを付けておけば、 ``Dockerfile`` の書き手が選べるようになります。

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
