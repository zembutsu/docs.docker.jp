.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/inspect/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/inspect.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/inspect.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. inspect

=======================================
inspect
=======================================

.. code-block:: bash

   使い方: docker inspect [オプション] コンテナ|イメージ|タスク [コンテナ|イメージ|タスク...]
   
   コンテナあるいはイメージかタスクの低レベル情報を表示
   
     -f, --format=""              指定する go テンプレートを使い、出力を整形
     --help                       使い方を表示
     --type=container|image|task  JSON を返すイメージまたはコンテナの種類を指定
                                  値は「イメージ」か「コンテナ」か「タスク」
     -s, --size                   種類がコンテナの場合、合計ファイルサイズを表示
   
.. By default, this will render all results in a JSON array. If a format is specified, the given template will be executed for each result.

デフォルトは、全ての結果を JSON 配列で表示します。フォーマットを指定した場合は、それぞれのテンプレートに従って結果を表示します。

.. By default, this will render all results in a JSON array. If the container and image have the same name, this will return container JSON for unspecified type. If a format is specified, the given template will be executed for each result.

デフォルトは、全ての結果を JSON 配列で表示します。コンテナとイメージが同じ名前を持つ場合は、タイプを指定しなければコンテナの JSON を返します。フォーマットを指定した場合は、それぞれのテンプレートに従って結果を表示します。

.. Go’s text/template package describes all the details of the format.

フォーマットの詳細については、Go 言語の `text/template  <http://golang.org/pkg/text/template/>`_ パッケージの説明をご覧ください。

.. Examples

.. _inspect-examples:

例
==========

.. Get an instance’s IP address:

**インスタンスの IP アドレスを取得**

.. For the most part, you can pick out any field from the JSON in a fairly straightforward manner.

ほとんどの場合、JSON の適切そのままの手法でフィールドから取得できます。

.. code-block:: bash

   $ docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $INSTANCE_ID

.. Get an instance’s MAC Address:

**インスタンスの MAC アドレスを取得：**

.. For the most part, you can pick out any field from the JSON in a fairly straightforward manner.

ほとんどの場合、JSON の適切そのままの手法でフィールドから取得できます。

.. code-block:: bash

   $ docker inspect '{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' $INSTANCE_ID

.. Get an instance’s log path:

**インスタンス用ログのパスを取得：**

.. code-block:: bash

    $ docker inspect --format='{{.LogPath}}' $INSTANCE_ID

.. Get a Task's image name:

**タスクのイメージ名を取得：**

.. code-block:: bash

   $ docker inspect --format='{{.Container.Spec.Image}}' $INSTANCE_ID

.. List All Port Bindings:

**バインドしているポート一覧を表示：**

.. One can loop over arrays and maps in the results to produce simple text output:

配列の中をループして、割り当てられている結果を簡単な文字で出力します。

.. code-block:: bash

   $ docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' $INSTANCE_ID

.. Find a Specific Port Mapping:

**特定のポート割り当てを探す：**

.. The .Field syntax doesn’t work when the field name begins with a number, but the template language’s index function does. The .NetworkSettings.Ports section contains a map of the internal port mappings to a list of external address/port objects. To grab just the numeric public port, you use index to find the specific port map, and then index 0 contains the first object inside of that. Then we ask for the HostPort field to get the public address.

``.Field`` 構文は数字で始まるフィールド名で使えませんが、テンプレート言語の ``index`` 機能では利用可能です。 ``.NetworkSettings.Prots`` セクションには、内部と外部にあるアドレス/ポートのオブジェクトに対する割り当てリストを含みます。 ``index`` 0 は、そのオブジェクトの１番めの項目です。 ``HostPort`` フィールドからパブリックアドレスを入手するには、次のようにします。

.. code-block:: bash

   $ docker inspect --format='{{(index (index .NetworkSettings.Ports "8787/tcp") 0).HostPort}}' $INSTANCE_ID

.. Get config:

**設定を取得する：**

.. The .Field syntax doesn’t work when the field contains JSON data, but the template language’s custom json function does. The .config section contains complex JSON object, so to grab it as JSON, you use json to convert the configuration object into JSON.

``.Field`` 構文は JSON データを含む場合に使えませんが、テンプレート言語のカスタム ``json`` であれば利用可能です。 ``.config`` セクションは複雑な JSON オブジェクトですが、JSON 全体を取り込んでから、 ``json`` を使って設定オブジェクトを JSON に変換します。

.. code-block:: bash

   $ docker inspect --format='{{json .config}}' $INSTANCE_ID

.. seealso:: 

   inspect
      https://docs.docker.com/engine/reference/commandline/inspect/

