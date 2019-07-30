.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/labels-custom-metadata/
   doc version: 17.06
      https://github.com/docker/docker.github.io/blob/master/engine/userguide/eng-image/labels-custom-metadata.md
.. check date: 2017/09/23
.. Commits on Aug 18, 2017 1df865ac7552fd2c865b7bc1bafa0016235a1a5a
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

..    Authors of third-party tools should prefix each label key with the reverse DNS notation of a domain they own, such as com.example.some-label.
    Do not use a domain in your label key without the domain owner’s permission.
    The com.docker.*, io.docker.*, and org.dockerproject.* namespaces are reserved by Docker for internal use.
    Label keys should begin and end with a lower-case letter and should only contain lower-case alphanumeric characters, the period character (.), and the hyphen character (-). Consecutive periods or hyphens are not allowed.
    The period character (.) separates namespace “fields”. Label keys without namespaces are reserved for CLI use, allowing users of the CLI to interactively label Docker objects using shorter typing-friendly strings.

* サードパーティ製ツールの作者は、各ラベルのキーの冒頭に、 ``com.example.some-label`` のように、 自分のドメインの逆引き DNS 記法を使うべきです。
* ドメイン所有者の許可無くラベルのキーにドメインを使ってはいけません。
* ``com.docker.*`` と ``org.dockerproject.*`` の名前空間は、Docker の内部利用のために予約されています。
* ラベル・キーの始めと終わりは小文字であるべきです。利用可能なのは小文字のアルファベットと、ピリオド文字（ ``.`` ）、ハイフン文字（ ``-`` ）です。ピリオドとハイフンの連続は利用できません。
* ピリオド文字（ ``.`` ）名前空間の「フィールド」を分けます。名前空間のないラベル・キーは CLI が使うために予約されています。これは Docker オブジェクトのラベルを ユーザが CLI を使って入力しやすくするためです。

.. These guidelines are not currently enforced and additional guidelines may apply to specific use cases.

これらのガイドラインは、現時点において強制するものではありません。また、特定用途に対するガイドラインが追加される可能性があります。

.. Value guidelines
.. _value-guidelines:

バリューのガイドライン
------------------------------

.. Label values can contain any data type that can be represented as a string, including (but not limited to) JSON, XML, CSV, or YAML. The only requirement is that the value be serialized to a string first, using a mechanism specific to the type of structure. For instance, to serialize JSON into a string, you might use the JSON.stringify() JavaScript method.

ラベルの値には、文字列であれば JSON、XML、CSV、YAML など（に制限されません）、あらゆる種類のデータをを入れられます。値が連続している文字列であるのは必要ですが、あとは各々の構造に従います。たとえば、整形した JSON を文字列にするには ``JSON.stringify()`` JavaScirpt メソッドが使えるでしょう。

.. Since Docker does not deserialize the value, you cannot treat a JSON or XML document as a nested structure when querying or filtering by label value unless you build this functionality into third-party tooling.

Dockerはバリューの構造解釈ができないので、 JSON や XML ドキュメントのようなネストされた構造の場合、サードパーティ製ツールでは、クエリやフィルタを利用できません。

.. Manage labels on objects
.. _manage-labels-on-oabjects:

オブジェクトにおけるラベルの管理
========================================

.. nEach type of object with support for labels has mechanisms for adding and managing them and using them as they relate to that type of object. These links provide a good place to start learning about how you can use labels in your Docker deployments.

各オブジェクト・タイプには、ラベルを追加・管理する仕組みが備わっています。そして、オブジェクトのタイプを関連付けるためにも使えます。以下のリンクは Docker のデプロイ時、どのようにラベルを使うかを学ぶのに役立ちます。

.. Labels on images, containers, local daemons, volumes, and networks are static for the lifetime of the object. To change these labels you must recreate the object. Labels on swarm nodes and services can be updated dynamically.

イメージ、コンテナ、ローカル・デーモン、ボリューム、ネットワークのラベルは、オブジェクトの利用中は固定（static）です。これらのラベルを変えるためには、オブジェクトの再作成が必要です。swarm ノードとサービスのラベルは動的に変更できます。

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

   Apply custom metadata
      https://docs.docker.com/engine/userguide/labels-custom-metadata/
