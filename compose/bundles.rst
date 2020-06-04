.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/bundles/
.. -------------------------------------------------------------------

.. title: Docker stacks and distributed application bundles (experimental)

.. _docker-stacks-and-distributed-application-bundles-experimental:

========================================================
Docker スタックと配布アプリケーションバンドル（試験的）
========================================================

.. FROM advisories.yaml
.. The functionality described on this page is marked as Experimental, and as such, may change before it becomes generally available.

.. note::

   このページに示す機能は「試験的」（experimental）として位置づけられています。
   このため正規安定版となる頃には変更されているかもしれません。

.. > **Note**: This is a modified copy of the [Docker Stacks and Distributed Application
   > Bundles](https://github.com/moby/moby/blob/v1.12.0-rc4/experimental/docker-stacks-and-bundles.md)
   > document in the [docker/docker-ce repo](https://github.com/docker/docker-ce). It's been updated to accurately reflect newer releases.

.. note::

   ここに示すドキュメントは `docker/docker-ce repo <https://github.com/docker/docker-ce>`_ にある `Docker スタックと配布アプリケーションバンドル <https://github.com/moby/moby/blob/v1.12.0-rc4/experimental/docker-stacks-and-bundles.md>`_ （Docker Stacks and Distributed Application Bundles）を修正したものです。
   そして最新の記述に合わせて的確に更新を行っています。

.. ## Overview

概要
=====

.. A Dockerfile can be built into an image, and containers can be created from
   that image. Similarly, a `docker-compose.yml` can be built into a **distributed
   application bundle**, and **stacks** can be created from that bundle. In that
   sense, the bundle is a multi-services distributable image format.

Dockerfile からイメージがビルドされ、そのイメージからコンテナが生成されます。
同じように ``docker-compose.yml`` からは **配布アプリケーションバンドル** がビルドされ、そのバンドルからは **スタック** （stack）が生成されます。
このことから言えば、バンドルとは複数サービスを持った配布可能なイメージ形式、ということになります。

.. Docker Stacks and Distributed Application Bundles started as experimental
   features introduced in Docker 1.12 and Docker Compose 1.8, alongside the concept
   of swarm mode, and nodes and services in the Engine API. Neither Docker Engine
   nor the Docker Registry support distribution of bundles, and the concept of a
   `bundle` is not the emphasis for new releases going forward.

Docker スタックと配布アプリケーションバンドルは、試験的な機能として Docker 1.12 および Docker Compose 1.8 より導入が始まりました。
これはスウォームモードや、Engine API におけるノードとサービスの考え方が進められた時期です。
Docker Engine や Docker Registry はバンドル配布をサポートしていません。
また **バンドル** （``bundle`` ）というものの考え方は、新たなリリースを迎えたとしても、さして重要視するものではありません。

.. However, [swarm mode](/engine/swarm/index.md), multi-service applications, and
   stack files now are fully supported. A stack file is a particular type of
   [version 3 Compose file](/compose/compose-file/index.md).

もっとも :doc:`スウォームモード </engine/swarm/index>` 、複数サービスによりアプリケーション、スタックファイルというものは、今や完全にサポートされました。
スタックファイルとは :doc:`Compose ファイルバージョン 3 </compose/compose-file>` の特定の形ということができます。

.. If you are just getting started with Docker and want to learn the best way to
   deploy multi-service applications, a good place to start is the [Get Started
   walkthrough](/get-started/). This shows you how to define
   a service configuration in a Compose file, deploy the app, and use
   the relevant tools and commands.

Docker に取り掛かかり始めたばかりの方が、次に複数サービスによるアプリケーションのデプロイ方法を学ぶとすれば、:doc:`はじめよう </get-started/index>` を読んでみるのがよいと思います。
そこでは Compose ファイルに 1 つのサービス設定を定義して、アプリをデプロイし、関連ツールやコマンドを使っていく方法が示されています。

.. ## Producing a bundle

バンドルの生成
===============

.. The easiest way to produce a bundle is to generate it using `docker-compose`
   from an existing `docker-compose.yml`. Of course, that's just *one* possible way
   to proceed, in the same way that `docker build` isn't the only way to produce a
   Docker image.

バンドルを生成するには、すでにある ``docker-compose.yml`` から ``docker-compose`` を実行するのが最も単純です。
もちろんこれは **一つ** のやり方にすぎません。
Docker イメージを作り出すのが ``docker build`` だけではないことと同じ話です。

.. From `docker-compose`:

``docker-compose`` を使って以下を実行します。

.. ```bash
   $ docker-compose bundle
   WARNING: Unsupported key 'network_mode' in services.nsqd - ignoring
   WARNING: Unsupported key 'links' in services.nsqd - ignoring
   WARNING: Unsupported key 'volumes' in services.nsqd - ignoring
   [...]
   Wrote bundle to vossibility-stack.dab
   ```
.. code-block:: bash

   $ docker-compose bundle
   WARNING: Unsupported key 'network_mode' in services.nsqd - ignoring
   WARNING: Unsupported key 'links' in services.nsqd - ignoring
   WARNING: Unsupported key 'volumes' in services.nsqd - ignoring
   [...]
   Wrote bundle to vossibility-stack.dab

.. ## Creating a stack from a bundle

バンドルからのスタック生成
===========================

.. > **Note**: Because support for stacks and bundles is in the experimental stage,
   > you need to install an experimental build of Docker Engine to use it.
   >
   > If you're on Mac or Windows, download the “Beta channel” version of
   > [Docker for Mac](/docker-for-mac/) or
   > [Docker for Windows](/docker-for-windows/) to install
   > it. If you're on Linux, follow the instructions in the
   > [experimental build README](https://github.com/docker/cli/blob/master/experimental/README.md).

.. note::

   スタックとバンドルに関するサポートが試験的な段階にあるため、これを利用するためには Docker Engine の試験的ビルド（experimental build）をインストールする必要があります。
   
   Mac や Windows を利用している場合は :doc:`Docker Desktop for Mac </docker-for-mac/index>` または :doc:`Docker Desktop for Windows </docker-for-windows/index>` の「ベータチャネル」（Beta channel）からダウンロードしてインストールしてください。
   Linux を利用している場合は `試験ビルドの README <https://github.com/docker/cli/blob/master/experimental/README.md>`_ に示す手順に従ってください。

.. A stack is created using the `docker deploy` command:

スタックは ``docker deploy`` コマンドを使って生成されます。

.. ```bash
   # docker deploy --help
   
   Usage:  docker deploy [OPTIONS] STACK
   
   Create and update a stack
   
   Options:
         --file   string        Path to a Distributed Application Bundle file (Default: STACK.dab)
         --help                 Print usage
         --with-registry-auth   Send registry authentication details to Swarm agents
   ```
.. code-block:: bash

   $ docker deploy --help

   利用方法:  docker deploy [オプション] STACK

   スタックを生成、更新します。

   オプション:
         --file   string        配布アプリケーションバンドルへのパスを指定します。
                                （デフォルト: STACK.dab）
         --help                 利用方法を表示します。
         --with-registry-auth   Swarm エージェントにレジストリ認証情報を送信します。
   ```

.. Let's deploy the stack created before:

前に生成したスタックをデプロイします。

.. ```bash
   # docker deploy vossibility-stack
   Loading bundle from vossibility-stack.dab
   Creating service vossibility-stack_elasticsearch
   Creating service vossibility-stack_kibana
   Creating service vossibility-stack_logstash
   Creating service vossibility-stack_lookupd
   Creating service vossibility-stack_nsqd
   Creating service vossibility-stack_vossibility-collector
   ```
.. code-block:: bash

   $ docker deploy vossibility-stack
   Loading bundle from vossibility-stack.dab
   Creating service vossibility-stack_elasticsearch
   Creating service vossibility-stack_kibana
   Creating service vossibility-stack_logstash
   Creating service vossibility-stack_lookupd
   Creating service vossibility-stack_nsqd
   Creating service vossibility-stack_vossibility-collector

.. We can verify that services were correctly created:

サービスが正しく生成されているかを確認します。

.. ```bash
   # docker service ls
   ID            NAME                                     REPLICAS  IMAGE
   COMMAND
   29bv0vnlm903  vossibility-stack_lookupd                1 nsqio/nsq@sha256:eeba05599f31eba418e96e71e0984c3dc96963ceb66924dd37a47bf7ce18a662 /nsqlookupd
   4awt47624qwh  vossibility-stack_nsqd                   1 nsqio/nsq@sha256:eeba05599f31eba418e96e71e0984c3dc96963ceb66924dd37a47bf7ce18a662 /nsqd --data-path=/data --lookupd-tcp-address=lookupd:4160
   4tjx9biia6fs  vossibility-stack_elasticsearch          1 elasticsearch@sha256:12ac7c6af55d001f71800b83ba91a04f716e58d82e748fa6e5a7359eed2301aa
   7563uuzr9eys  vossibility-stack_kibana                 1 kibana@sha256:6995a2d25709a62694a937b8a529ff36da92ebee74bafd7bf00e6caf6db2eb03
   9gc5m4met4he  vossibility-stack_logstash               1 logstash@sha256:2dc8bddd1bb4a5a34e8ebaf73749f6413c101b2edef6617f2f7713926d2141fe logstash -f /etc/logstash/conf.d/logstash.conf
   axqh55ipl40h  vossibility-stack_vossibility-collector  1 icecrime/vossibility-collector@sha256:f03f2977203ba6253988c18d04061c5ec7aab46bca9dfd89a9a1fa4500989fba --config /config/config.toml --debug
   ```
.. code-block:: bash

   $ docker service ls
   ID            NAME                                     REPLICAS  IMAGE
   COMMAND
   29bv0vnlm903  vossibility-stack_lookupd                1 nsqio/nsq@sha256:eeba05599f31eba418e96e71e0984c3dc96963ceb66924dd37a47bf7ce18a662 /nsqlookupd
   4awt47624qwh  vossibility-stack_nsqd                   1 nsqio/nsq@sha256:eeba05599f31eba418e96e71e0984c3dc96963ceb66924dd37a47bf7ce18a662 /nsqd --data-path=/data --lookupd-tcp-address=lookupd:4160
   4tjx9biia6fs  vossibility-stack_elasticsearch          1 elasticsearch@sha256:12ac7c6af55d001f71800b83ba91a04f716e58d82e748fa6e5a7359eed2301aa
   7563uuzr9eys  vossibility-stack_kibana                 1 kibana@sha256:6995a2d25709a62694a937b8a529ff36da92ebee74bafd7bf00e6caf6db2eb03
   9gc5m4met4he  vossibility-stack_logstash               1 logstash@sha256:2dc8bddd1bb4a5a34e8ebaf73749f6413c101b2edef6617f2f7713926d2141fe logstash -f /etc/logstash/conf.d/logstash.conf
   axqh55ipl40h  vossibility-stack_vossibility-collector  1 icecrime/vossibility-collector@sha256:f03f2977203ba6253988c18d04061c5ec7aab46bca9dfd89a9a1fa4500989fba --config /config/config.toml --debug

.. ## Managing stacks

スタックの管理
===============

.. Stacks are managed using the `docker stack` command:

スタックの管理には ``docker stack`` コマンドを利用します。

.. ```bash
   # docker stack --help

   Usage:  docker stack COMMAND

   Manage Docker stacks

   Options:
         --help   Print usage

   Commands:
     config      Print the stack configuration
     deploy      Create and update a stack
     rm          Remove the stack
     services    List the services in the stack
     tasks       List the tasks in the stack

   Run 'docker stack COMMAND --help' for more information on a command.
   ```
.. code-block:: bash

   $ docker stack --help

   利用方法:  docker stack コマンド

   Docker スタックを管理します。

   オプション:
         --help   利用方法を表示します。

   コマンド:
     config      スタック設定を出力します。
     deploy      スタックを生成、更新します。
     rm          スタックを削除します。
     services    スタック内のサービスを一覧表示します。
     tasks       スタック内のタスクを一覧表示します。

   各コマンドの詳細は 'docker stack COMMAND --help' を実行してください。

.. ## Bundle file format

バンドルファイルフォーマット
=============================

.. Distributed application bundles are described in a JSON format. When bundles
   are persisted as files, the file extension is `.dab`.

配布アプリケーションバンドルは JSON 形式により表現されます。
バンドルがファイルとして保存されている場合、そのファイル拡張子は ``.dab`` です。

.. A bundle has two top-level fields: `version` and `services`. The version used
   by Docker 1.12 tools is `0.1`.

バンドルには最上位のフィールドが 2 つあります。
``version`` と ``services`` です。
Docker 1.12 の各ツールにて利用されるバージョンは ``0.1`` です。

.. `services` in the bundle are the services that comprise the app. They
   correspond to the new `Service` object introduced in the 1.12 Docker Engine API.

バンドル内の ``services`` とは、アプリケーションを含めたサービスのことです。
これは Docker Engine API 1.12 において導入された、新しい ``Service`` オブジェクトに対応するものです。

.. A service has the following fields:

サービスには以下のフィールドがあります。

.. raw:: html

   <dl>
       <dt>
           <!--
           Image (required) <code>string</code>
           -->
           Image (必須) <code>string</code>
       </dt>
       <dd>
           <!--
           The image that the service will run. Docker images should be referenced
           with full content hash to fully specify the deployment artifact for the
           service. Example:
           <code>postgres@sha256:e0a230a9f5b4e1b8b03bb3e8cf7322b0e42b7838c5c87f4545edb48f5eb8f077</code>
           -->
           サービスが実行するイメージ。
           Docker イメージは全内容に基づくハッシュを使って指定します。
           この値によってサービスのデプロイ内容が完全に特定されます。
           たとえば <code>postgres@sha256:e0a230a9f5b4e1b8b03bb3e8cf7322b0e42b7838c5c87f4545edb48f5eb8f077</code> のようなものです。
       </dd>
       <dt>
           Command <code>[]string</code>
       </dt>
       <dd>
           <!--
           Command to run in service containers.
           -->
           サービスコンテナ内で実行するコマンド。
       </dd>
       <dt>
           Args <code>[]string</code>
       </dt>
       <dd>
           <!--
           Arguments passed to the service containers.
           -->
           サービスコンテナに受け渡すコマンド引数。
       </dd>
       <dt>
           Env <code>[]string</code>
       </dt>
       <dd>
           <!--
           Environment variables.
           -->
           環境変数。
       </dd>
       <dt>
           Labels <code>map[string]string</code>
       </dt>
       <dd>
           <!--
           Labels used for setting meta data on services.
           -->
           サービス上のメタデータを設定するために利用するラベル。
       </dd>
       <dt>
           Ports <code>[]Port</code>
       </dt>
       <dd>
           <!--
           Service ports (composed of <code>Port</code> (<code>int</code>) and
           <code>Protocol</code> (<code>string</code>). A service description can
           only specify the container port to be exposed. These ports can be
           mapped on runtime hosts at the operator's discretion.
           -->
           サービスのポート。
          （<code>Port</code> (<code>int</code>) と <code>Protocol</code> (<code>string</code> から構成される。）
           サービス記述は、公開するコンテナポートの指定のみでも可能です。
           このポートは操作時に、実行ホストへのポートマッピングを行うことができます。
       </dd>
   
       <dt>
           WorkingDir <code>string</code>
       </dt>
       <dd>
           <!--
           Working directory inside the service containers.
           -->
           サービスコンテナ内部のワークディレクトリ。
       </dd>
   
       <dt>
           User <code>string</code>
       </dt>
       <dd>
           <!--
           Username or UID (format: <code>&lt;name|uid&gt;[:&lt;group|gid&gt;]</code>).
           -->
           ユーザ名または UID （書式: <code>&lt;name|uid&gt;[:&lt;group|gid&gt;]</code>）
       </dd>
   
       <dt>
           Networks <code>[]string</code>
       </dt>
       <dd>
           <!--
           Networks that the service containers should be connected to. An entity
           deploying a bundle should create networks as needed.
           -->
           サービスコンテナが接続するべきネットワーク。
           バンドルをデプロイしているエンティティは、必要なネットワークを生成します。
       </dd>
   </dl>

.. > **Note**: Some configuration options are not yet supported in the DAB format,
   > including volume mounts.

.. note::

   DAB 形式においては、ボリュームマウントなどのように、まだサポートされていない設定があります。

.. ## Related topics

関連トピック
=============

.. * [Get started walkthrough](/get-started/)

   * [docker stack deploy](/engine/reference/commandline/stack_deploy/) command

   * [deploy](/compose/compose-file/index.md#deploy) option in [Compose files](/compose/compose-file/index.md)

* :doc:`はじめよう </get-started/index>`

* :doc:`docker stack deploy </engine/reference/commandline/stack_deploy>` コマンド

* :doc:`Compose ファイル </compose/compose-file>` の :ref:`deploy <compose-file-deploy>` オプション 
