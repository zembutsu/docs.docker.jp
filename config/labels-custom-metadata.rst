.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/labels-custom-metadata/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/config/labels-custom-metadata.md
.. check date: 2020/06/21
.. Commits on Apr 23, 2020 b0f90615659ac1319e8d8a57bb914e49d174242e
.. ---------------------------------------------------------------------------

.. Docker object labels
.. _docker-object-labels:

=======================================
Docker オブジェクト・ラベル
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Labels are a mechanism for applying metadata to Docker objects, including:

ラベル（label）とは、 Docker オブジェクトに対してメタデータを設定する仕組みです。Docker オブジェクトとは以下の通りです：

..    Images
    Containers
    Local daemons
    Volumes
    Networks
    Swarm nodes
    Swarm services

* イメージ
* コンテナ
* ローカル・デーモン
* ボリューム
* ネットワーク
* Swarm ノード
* Swarm サービス

.. You can use labels to organize your images, record licensing information, annotate
   relationships between containers, volumes, and networks, or in any way that makes
   sense for your business or application.

ラベルはさまざまな目的で利用することができます。
イメージを構成したり、ライセンス情報を記録したり、コンテナー、ボリューム、ネットワーク間の関係性を書きとめたりといったものです。
業務やアプリケーションにとって意義のあることなら、どのようなものでも含めて構いません。

.. ## Label keys and values

.. _label-keys-and-values:

ラベルのキーとバリュー
==============================

.. A label is a key-value pair, stored as a string. You can specify multiple labels
   for an object, but each key-value pair must be unique within an object. If the
   same key is given multiple values, the most-recently-written value overwrites
   all previous values.

ラベルはキーバリュー・ペアの形式であり、文字列として保存されます。
オブジェクトに対しては複数のラベルを指定することができますが、各キーバリュー・ペアは 1 つのオブジェクト内で一意である必要があります。
1 つのキーに対して複数の値が設定されていた場合、古い値は最後に書き込まれた値により上書きされます。

.. ### Key format recommendations

推奨されるキーの書式
---------------------

.. A label _key_ is the left-hand side of the key-value pair. Keys are alphanumeric
   strings which may contain periods (`.`) and hyphens (`-`). Most Docker users use
   images created by other organizations, and the following guidelines help to
   prevent inadvertent duplication of labels across objects, especially if you plan
   to use labels as a mechanism for automation.

ラベルにおけるキーは、キーバリュー・ペアの左側を指します。
キーに含めることができる文字は、英数字、ピリオド（``.``）、ハイフン（``-``）です。
Docker ユーザが利用するイメージは、たいていは他の組織が作り出したものであるため、ここに示すガイドラインに従っていれば、オブジェクト間でのラベル定義を不用意に重複させるようなことがなくなります。
自動化の仕組みの中でラベルを利用する場合は、特にこのことが重要になります。

.. - Authors of third-party tools should prefix each label key with the
     reverse DNS notation of a domain they own, such as `com.example.some-label`.

* サードパーティ製ツールの開発者は、各ラベルのプリフィックスとして、自身が所有するドメインの逆 DNS 記法を用いるようにします。
  たとえば ``com.example.some-label`` といったものです。

.. - Do not use a domain in your label key without the domain owner's permission.

* ドメイン所有者の許可なく、ラベルのキーにそのドメイン名を使ってはいけません。

.. - The `com.docker.*`, `io.docker.*`, and `org.dockerproject.*` namespaces are
     reserved by Docker for internal use.

* 以下の名前空間 ``com.docker.*``, ``io.docker.*``, ``org.dockerproject.*`` は、Docker が内部利用のために予約しています。

.. - Label keys should begin and end with a lower-case letter and should only
     contain lower-case alphanumeric characters, the period character (`.`), and
     the hyphen character (`-`). Consecutive periods or hyphens are not allowed.

* ラベルのキーの始まりと終わりの 1 文字は英小文字とします。
  そして文字列全体は、英小文字と数字、ピリオド（``.``）、ハイフン（``-``）を用いるようにします。
  そしてピリオドとハイフンは連続して用いないようにします。

.. - The period character (`.`) separates namespace "fields". Label keys without
     namespaces are reserved for CLI use, allowing users of the CLI to interactively
     label Docker objects using shorter typing-friendly strings.

* ピリオド（``.``）は名前空間の「項目」を区切るものです。
  ラベルのキーに名前空間が指定されていないものは、CLI が用いるものとしています。
  ユーザにとって CLI 実行の際、Docker オブジェクトに対して入力しやすい短いラベル文字列を指定できるようにするためです。

.. These guidelines are not currently enforced and additional guidelines may apply
   to specific use cases.

上のようなガイドラインは現時点において強制されるものではありません。
特定の用途において、さらに追加のガイドラインが適用されるかもしれません。

.. ### Value guidelines

.. _value-guidelines:

バリューに関するガイドライン
------------------------------

.. Label values can contain any data type that can be represented as a string,
   including (but not limited to) JSON, XML, CSV, or YAML. The only requirement is
   that the value be serialized to a string first, using a mechanism specific to
   the type of structure. For instance, to serialize JSON into a string, you might
   use the `JSON.stringify()` JavaScript method.

ラベルのバリューには、文字列として表現できるものであれば、どんな型のデータでも含めることができます。
たとえば JSON, XML, CSV, YAML があり、これ以外にもまだあります。
唯一必要になることは、そのデータ型の構造に従った形で、文字列としてシリアライズされたものであることです。
たとえば JSON データを文字列にシリアライズするには、JavaScript メソッドでは ``JSON.stringify()`` を利用するかもしれません。

.. Since Docker does not deserialize the value, you cannot treat a JSON or XML
   document as a nested structure when querying or filtering by label value unless
   you build this functionality into third-party tooling.

Docker ではそのバリューをデシリアライズしないため、ラベルを用いた検索やフィルタリングをする際には、ネスト構造になっている JSON や XML ドキュメントを取り扱うことはできません。
これを実現するためにはサードパーティ製のツール類に、そういった機能を組み入れる必要があります。

.. ## Manage labels on objects

.. _manage-labels-on-objects:

オブジェクトにおけるラベルの管理
========================================

.. Each type of object with support for labels has mechanisms for adding and
   managing them and using them as they relate to that type of object. These links
   provide a good place to start learning about how you can use labels in your
   Docker deployments.

ラベルがサポートされている各オブジェクトには、ラベルの追加や管理を行う機能が備わっていて、そのオブジェクトに関連づいたラベルとして取り扱うことができます。
以下に示すリンクは、Docker デプロイにおいて利用するラベルを学ぶ上で役立つものです。

.. Labels on images, containers, local daemons, volumes, and networks are static for
   the lifetime of the object. To change these labels you must recreate the object.
   Labels on swarm nodes and services can be updated dynamically.

イメージ、コンテナ、ローカル・デーモン、ボリューム、ネットワークといったオブジェクトにおいては、そのオブジェクトが存在する間、ラベルは静的で不変なものです。
ラベルを変更するためにはオブジェクトを再生成する必要があります。
Swarm ノードと Swarm サービスにおけるラベルは動的に変更することができます。

..    Images and containers
        Adding labels to images
        Overriding a container’s labels at runtime
        Inspecting labels on images or containers
        Filtering images by label
        Filtering containers by label
    Local Docker daemons
        Adding labels to a Docker daemon at runtime
        Inspecting a Docker daemon’s labels
    Volumes
        Adding labels to volumes
        Inspecting a volume’s labels
        Filtering volumes by label
    Networks
        Adding labels to a network
        Inspecting a network’s labels
        Filtering networks by label
    Swarm nodes
        Adding or updating a swarm node’s labels
        Inspecting a swarm node’s labels
        Filtering swarm nodes by label
    Swarm services
        Adding labels when creating a swarm service
        Updating a swarm service’s labels
        Inspecting a swarm service’s labels
        Filtering swarm services by label


* イメージとコンテナ

   * :ref:`イメージにラベルを追加 <builder-label>`
   * :ref:`コンテナのラベルを実行時に上書き <set-metadata-on-container>`
   * :doc:`イメージやコンテナのラベルを調査 </engine/reference/commandline/inspect>`
   * :doc:`イメージをラベルでフィルタ </engine/reference/commandline/inspect>`
   * :ref:`コンテナをラベルでフィルタ <ps-filtering>`

* ローカルの Docker デーモン

   * :doc:`Docker デーモン実行時にラベルを追加 </engine/reference/commandline/dockerd>`
   * :doc:`Docker デーモンのラベルを追加 </engine/reference/commandline/info>`

* ボリューム

   * :doc:`ボリュームにラベルを追加 </engine/reference/commandline/volume_create>`
   * :doc:`ボリュームのラベルを調査 </engine/reference/commandline/volume_inspect>`
   * :doc:`ボリュームをラベルでフィルタ </engine/reference/commandline/volume_ls>`

* ネットワーク

   * :doc:`ネットワークにラベルを追加 </engine/reference/commandline/network_create>`
   * :doc:`ネットワークのラベルを調査 </engine/reference/commandline/network_inspect>`
   * :doc:`ネットワークをラベルでフィルタ </engine/reference/commandline/network_ls>`

* Swarm ノード

   * :doc:`swarm ノードのラベルを追加・更新 </engine/reference/commandline/node_update>`
   * :doc:`swarm ノードのラベルを調査 </engine/reference/commandline/node_inspect>`
   * :doc:`ラベルで swarm ノードをフィルタ </engine/reference/commandline/node_ls>`

* Swarm サービス

   * :ref:`swarm サービス作成時にラベルの追加 <service-create-ls>`
   * :doc:`swarm サービスのラベルの更新 </engine/reference/commandline/service_update>`
   * :doc:`swarm サービスのラベルを調査 </engine/reference/commandline/service_inspect>`
   * :ref:`swarm サービスをラベルでフィルタ <service-ls-filtering>`

.. seealso:: 

   Docker object labels
      https://docs.docker.com/config/labels-custom-metadata/
