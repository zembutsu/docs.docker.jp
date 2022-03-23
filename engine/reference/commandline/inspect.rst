.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/inspect/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/inspect.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_inspect.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker inspect

=======================================
docker inspect
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_inspect-description:

説明
==========

.. Return low-level information on Docker objects

Docker オブジェクト上の :ruby:`ローレベル <low-level>` 情報を返します。

.. _docker_inspect-usage:

使い方
==========

.. code-block:: bash

   $ docker inspect [OPTIONS] NAME|ID [NAME|ID...]

.. Extended description
.. _docker_inspect-extended-description:

補足説明
==========

.. Docker inspect provides detailed information on constructs controlled by Docker.

docker inspect は、 Docker によって管理されている構築物の詳細情報を表示します。

.. By default, docker inspect will render results in a JSON array.

デフォルトでは、 ``docker inspect`` は結果を JSON 配列で表示します。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_inspect-examples>` をご覧ください。

.. _docker_inspect-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレートを使って、出力を整える
   * - ``--size`` , ``-s``
     - 
     - タイプがコンテナであれば、合計ファイル容量を表示
   * - ``--type``
     - 
     - 特定のタイプを JSON で返す

.. Examples
.. _docker_inspect-examples:

使用例
==========

.. Get an instance’s IP address
.. _docker_inspect-get-an-instances-ip-address:

インスタンスの IP アドレスを取得
----------------------------------------

.. For the most part, you can pick out any field from the JSON in a fairly straightforward manner.

多くの部分は、JSON からあらゆるフィールドを、ほとんど一般的な手法で 取得できます。

.. code-block:: bash

   $ docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $INSTANCE_ID

.. Get an instance’s MAC Address
.. _docker_inspect-get-an-instances-mac-address:

インスタンスの MAC アドレスを取得
----------------------------------------

.. code-block:: bash

   $ docker inspect '{{range .NetworkSettings.Networks}}{{.MacAddress}}{{end}}' $INSTANCE_ID

.. Get an instance’s log path
.. _docker_inspect-get-an-instances-log-path:

インスタンス用ログのパスを取得
----------------------------------------

.. code-block:: bash

    $ docker inspect --format='{{.LogPath}}' $INSTANCE_ID

.. Get a Task's image name
.. _docker_inspect-get-a-tasks-image-name:

タスクのイメージ名を取得
------------------------------

.. code-block:: bash

   $ docker inspect --format='{{.Container.Spec.Image}}' $INSTANCE_ID

.. List All Port Bindings
.. _docker_inspect-list-all-port-bindings:

バインドしているポート一覧を表示
---------------------------------------

.. You can loop over arrays and maps in the results to produce simple text output:

配列の中をループして、割り当てられている結果を簡単な文字で出力します。

.. code-block:: bash

   $ docker inspect --format='{{range $p, $conf := .NetworkSettings.Ports}} {{$p}} -> {{(index $conf 0).HostPort}} {{end}}' $INSTANCE_ID

.. Find a Specific Port Mapping
.. _docker_inspect-find-a-specific-port-mapping:

特定のポートに対する割り当てを探す
----------------------------------------

.. The .Field syntax doesn’t work when the field name begins with a number, but the template language’s index function does. The .NetworkSettings.Ports section contains a map of the internal port mappings to a list of external address/port objects. To grab just the numeric public port, you use index to find the specific port map, and then index 0 contains the first object inside of that. Then we ask for the HostPort field to get the public address.

``.Field`` 構文は数字で始まるフィールド名で使えませんが、テンプレート言語の ``index`` ファンクションでは利用できます。``.NetworkSettings.Prots`` セクションには、内部と外部にあるアドレス/ポートのオブジェクトに対する割り当てリストを含みます。``index`` 0 は、そのオブジェクトの１番めの項目です。 ``HostPort`` フィールドから公開アドレスを入手するには、次のようにします。

.. code-block:: bash

   $ docker inspect --format='{{(index (index .NetworkSettings.Ports "8787/tcp") 0).HostPort}}' $INSTANCE_ID

.. Get a subsection in JSON format
.. _docker_inspect-get-a-subsection-in-json-format:

JSON 形式でサブセクションを取得
----------------------------------------

.. If you request a field which is itself a structure containing other fields, by default you get a Go-style dump of the inner values. Docker adds a template function, json, which can be applied to get results in JSON format.

フィールドに自身の構造を含む他のフィールドを要求する場合、デフォルトでは内部の値を Go スタイルで出力します。Docker がテンプレート・ファンクションで ``json`` を追加すると、JSON 形式で結果を得られるようになります。

.. code-block:: bash

   $ docker inspect --format='{{json .config}}' $INSTANCE_ID


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker inspect
      https://docs.docker.com/engine/reference/commandline/inspect/

