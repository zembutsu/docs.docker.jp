.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/labels-custom-metadata/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/labels-custom-metadata.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/labels-custom-metadata.md
.. check date: 2016/06/13
.. Commits on May 26, 2016 b2643b6953e59549eba8af51a7e783a3e4cebc46
.. ---------------------------------------------------------------------------

.. Apply custom metadata

=======================================
カスタム・メタデータ追加
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can apply metadata to your images, containers, or daemons via labels. Labels serve a wide range of uses, such as adding notes or licensing information to an image, or to identify a host.

イメージ、コンテナ、デーモンに対してラベルを通してメタデータを追加できます。ラベルには様々な使い方があります。例えば、メモの追加、イメージに対するライセンス情報の追加、ホストを識別するためです。

.. A label is a <key> / <value> pair. Docker stores the label values as strings. You can specify multiple labels but each <key> must be unique or the value will be overwritten. If you specify the same key several times but with different values, newer labels overwrite previous labels. Docker uses the last key=value you supply.

ラベルは ``<key>`` / ``<value>`` のペアです。Docker はラベルの値を *文字列* として保管します。複数のラベルを指定できますが、 ``<key>`` はユニークである必要があるため、重複時は上書きされます。同じ ``<key>`` を複数回指定したら、古いラベルは新しいラベルに置き換えられるため、都度値が変わります。Docker は常に指定した最新の ``key=value`` を使います。

..    Note: Support for daemon-labels was added in Docker 1.4.1. Labels on containers and images are added in Docker 1.6.0

.. note::

   デーモンのラベル機能は Docker 1.4.1 から追加されました。コンテナとイメージに対するラベルは、Docker 1.6.0 で追加されました。

.. Label keys (namespaces)

ラベルのキーと名前空間
==============================

.. Docker puts no hard restrictions on the key used for a label. However, using simple keys can easily lead to conflicts. For example, you have chosen to categorize your images by CPU architecture using “architecture” labels in your Dockerfiles:

Docker は ``key`` の使用にあたり、厳密な制約を設けていません。しかしながら、単純な key であれば重複の可能性があります。例えば、Dockerfile の中で「architecture」ラベルを使い、 CPU アーキテクチャごとにイメージを分類する場合です。

.. code-block:: bash

   LABEL architecture="amd64"
   LABEL architecture="ARMv7"

.. Another user may apply the same label based on a building’s “architecture”:

他のユーザも、同じラベルを構築時の「architecture」（構築担当者）としてラベル付けするかもしれません。

.. code-block:: bash

   LABEL architecture="Art Nouveau"

.. To prevent naming conflicts, Docker recommends using namespaces to label keys using reverse domain notation. Use the following guidelines to name your keys:

このような名前の衝突を避けるために、Docker が推奨するのはラベルの key を使うにあたり、逆ドメイン表記による名前空間を使う方法です。

..    All (third-party) tools should prefix their keys with the reverse DNS notation of a domain controlled by the author. For example, com.example.some-label.

* 全ての（サードパーティー製）ツールは、キーの頭に作者が管理するドメインの逆 DNS 表記を付けるべきです。例： ``com.example.some-label``

..    The com.docker.*, io.docker.* and org.dockerproject.* namespaces are reserved for Docker’s internal use.

* 名前空間 ``com.docker.*`` と ``io.docker.*`` と ``org.dockerproject.*`` は、Docker の内部利用のために予約されています。

..    Keys should only consist of lower-cased alphanumeric characters, dots and dashes (for example, [a-z0-9-.]).

* キーはアルファベットの小文字、ドット、ダッシュのみに統一されるべきです（例： ``[a-z0-9-.]`` ）。

..    Keys should start and end with an alpha numeric character.

..    Keys may not contain consecutive dots or dashes.

* キーは連続したドットやダッシュを含みません。

..    Keys without namespace (dots) are reserved for CLI use. This allows end- users to add metadata to their containers and images without having to type cumbersome namespaces on the command-line.

* ネームスペース（ドット）が *ない* キーは CLI で使うために予約されています。これにより、エンドユーザはコマンドライン上で各々のコンテナやイメージに対してメタデータを追加する時、面倒な名前空間を指定する必要がありません。

.. These are simply guidelines and Docker does not enforce them. However, for the benefit of the community, you should use namespaces for your label keys.

これらは簡単なガイドラインであり、Docker は *強制しません* 。しかしながら、コミュニティの利益を考えるならば、自分のラベルのキーで名前空間を使う *べき* でしょう。

.. Store structured data in labels

構造化したデータをラベルに保存
========================================

.. Label values can contain any data type as long as it can be represented as a string. For example, consider this JSON document:

ラベルの値は文字列で表現できるような、あらゆる種類のデータを含められます。例えば、次のような JSON ドキュメントを考えます。

.. code-block:: json

   {
       "Description": "A containerized foobar",
       "Usage": "docker run --rm example/foobar [args]",
       "License": "GPL",
       "Version": "0.0.1-beta",
       "aBoolean": true,
       "aNumber" : 0.01234,
       "aNestedArray": ["a", "b", "c"]
   }


.. You can store this struct in a label by serializing it to a string first:

この構造を保管するには、文字列を１行に並べてラベルにできます。

.. code-block:: bash

   LABEL com.example.image-specs="{\"Description\":\"A containerized foobar\",\"Usage\":\"docker run --rm example\\/foobar [args]\",\"License\":\"GPL\",\"Version\":\"0.0.1-beta\",\"aBoolean\":true,\"aNumber\":0.01234,\"aNestedArray\":[\"a\",\"b\",\"c\"]}"

.. While it is possible to store structured data in label values, Docker treats this data as a ‘regular’ string. This means that Docker doesn’t offer ways to query (filter) based on nested properties. If your tool needs to filter on nested properties, the tool itself needs to implement this functionality.

ラベルの値に構造化データを保管できるかもしれませんが、Docker はこのデータを「普通の」文字列として扱います。これが意味するのは、Docker は深く掘り下げた（ネストする）問い合わせ（フィルタ）手法を提供しません。ツールが何らかの設定項目をフィルタする必要があれば、ツール自身で処理する機能の実装が必要です。

.. Add labels to images

ラベルをイメージに追加
==============================

.. To add labels to an image, use the LABEL instruction in your Dockerfile:

イメージにラベルを追加するには、Dockerfile で ``LABEL`` 命令を使います。

.. code-block:: bash

   LABEL [<名前空間>.]<key>=<value> ...

.. The LABEL instruction adds a label to your image, optionally with a value. Use surrounding quotes or backslashes for labels that contain white space characters in the <value>:

``LABEL`` 命令はイメージにラベルを追加し、オプションで値も追加します。 ``<値>`` に空白文字列を踏む場合、ラベルをクォートで囲むかバックスラッシュを使います。

.. code-block:: bash

   LABEL vendor=ACME\ Incorporated
   LABEL com.example.version.is-beta=
   LABEL com.example.version.is-production=""
   LABEL com.example.version="0.0.1-beta"
   LABEL com.example.release-date="2015-02-12"

.. The LABEL instruction also supports setting multiple <key> / <value> pairs in a single instruction:

また、LABEL 命令は１行で複数の ``<key>`` / ``<value>`` ペアの設定をサポートしています。

.. code-block:: bash

   LABEL com.example.version="0.0.1-beta" com.example.release-date="2015-02-12"

.. Long lines can be split up by using a backslash (\) as continuation marker:

長い行は、バックスラッシュ（ ``\`` ）を継続マーカーとして使い、分割できます。

.. code-block:: bash

   LABEL vendor=ACME\ Incorporated \
         com.example.is-beta= \
         com.example.is-production="" \
         com.example.version="0.0.1-beta" \
         com.example.release-date="2015-02-12"

.. Docker recommends you add multiple labels in a single LABEL instruction. Using individual instructions for each label can result in an inefficient image. This is because each LABEL instruction in a Dockerfile produces a new IMAGE layer.

Docker が推奨するのは、複数のラベルを１つの ``LABEL`` 命令にする方法です。ラベルごとに命令するのでは、非効率なイメージになってしまいます。これは ``Dockerfile`` が ``LABEL`` 命令ごとに新しいイメージ・レイヤを作るためです。

.. You can view the labels via the docker inspect command:

ラベルの情報は ``docker inspect`` コマンドでも確認できます。

.. code-block:: bash

   $ docker inspect 4fa6e0f0c678
   
   ...
   "Labels": {
       "vendor": "ACME Incorporated",
       "com.example.is-beta": "",
       "com.example.is-production": "",
       "com.example.version": "0.0.1-beta",
       "com.example.release-date": "2015-02-12"
   }
   ...
   
   # Inspect labels on container
   $ docker inspect -f "{{json .Config.Labels }}" 4fa6e0f0c678
   
   {"Vendor":"ACME Incorporated","com.example.is-beta":"", "com.example.is-production":"", "com.example.version":"0.0.1-beta","com.example.release-date":"2015-02-12"}
   
   # Inspect labels on images
   $ docker inspect -f "{{json .ContainerConfig.Labels }}" myimage

.. _query-labels:

.. Query labels

クエリ・ラベル
====================

.. Besides storing metadata, you can filter images and containers by label. To list all running containers that have the com.example.is-beta label:

メタデータの保管とは別に、ラベルによってイメージとコンテナをフィルタできます。 ``com.example.is-beta`` ラベルを持っている実行中のコンテナを全て表示するには、次のようにします。

.. code-block:: bash

   # List all running containers that have a `com.example.is-beta` label
   $ docker ps --filter "label=com.example.is-beta"

.. List all running containers with the label color that have a value blue:

ラベル ``color`` が ``blue`` の全コンテナを表示します。

.. code-block:: bash

   $ docker ps --filter "label=color=blue"

.. List all images with the label vendor that have the value ACME:

ラベル ``vendor`` が ``ACME`` の全イメージを表示します。

.. code-block:: bash

   $ docker images --filter "label=vendor=ACME"


.. Container labels

コンテナ・ラベル
====================

.. code-block:: bash

   docker run \
      -d \
      --label com.example.group="webservers" \
      --label com.example.environment="production" \
      busybox \
      top

.. Please refer to the Query labels section above for information on how to query labels set on a container.

コンテナにクエリ・ラベルをセットするには、先ほどの :ref:`クエリ・ラベル <query-labels>` セクションをご覧ください。

.. Daemon labels

.. _daemon-labels:

デーモン・ラベル
====================

.. code-block:: bash

   docker daemon \
     --dns 8.8.8.8 \
     --dns 8.8.4.4 \
     -H unix:///var/run/docker.sock \
     --label com.example.environment="production" \
     --label com.example.storage="ssd"

.. These labels appear as part of the docker info output for the daemon:

これらのラベルは ``docker info`` によるデーモンの出力で表示されます。

.. code-block:: bash

   $ docker -D info
   Containers: 12
   Running: 5
   Paused: 2
   Stopped: 5
   Images: 672
   Server Version: 1.9.0
   Storage Driver: aufs
    Root Dir: /var/lib/docker/aufs
    Backing Filesystem: extfs
    Dirs: 697
    Dirperm1 Supported: true
   Execution Driver: native-0.2
   Logging Driver: json-file
   Kernel Version: 3.19.0-22-generic
   Operating System: Ubuntu 15.04
   CPUs: 24
   Total Memory: 62.86 GiB
   Name: docker
   ID: I54V:OLXT:HVMM:TPKO:JPHQ:CQCD:JNLC:O3BZ:4ZVJ:43XJ:PFHZ:6N2S
   Debug mode (server): true
    File Descriptors: 59
    Goroutines: 159
    System Time: 2015-09-23T14:04:20.699842089+08:00
    EventsListeners: 0
    Init SHA1:
    Init Path: /usr/bin/docker
    Docker Root Dir: /var/lib/docker
    Http Proxy: http://test:test@localhost:8080
    Https Proxy: https://test:test@localhost:8080
   WARNING: No swap limit support
   Username: svendowideit
   Registry: [https://index.docker.io/v1/]
   Labels:
    com.example.environment=production
    com.example.storage=ssd

.. seealso:: 

   Apply custom metadata
      https://docs.docker.com/engine/userguide/labels-custom-metadata/
