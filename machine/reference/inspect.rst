.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/inspect/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/inspect.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/inspect.md
.. check date: 2016/04/28
.. Commits on Nov 27, 2015 68e6e3f905856bc1d93cb5c1e99cc3b3ac900022
.. ----------------------------------------------------------------------------

.. inspect

.. _machine-inspect:

=======================================
inspect
=======================================


.. code-block:: bash

   使い方: docker-machine inspect [オプション] [引数...]
   
   マシンに関する情報を調査
   
   説明:
      引数はマシン名。
   
   オプション:
      --format, -f     go template で指定した出力に整形

.. By default, this will render information about a machine as JSON. If a format is specified, the given template will be executed for each result.

デフォルトでは、マシンの情報を JSON 形式で表示します。フォーマットを指定すると、特定のテンプレートを使った結果を表示します。

.. Go’s text/template package describes all the details of the format.

Go 言語の `text/template <http://golang.org/pkg/text/template/>`_ パッケージのページに、全てのフォーマットに関する情報の説明があります。

.. In addition to the text/template syntax, there are some additional functions, json and prettyjson, which can be used to format the output as JSON (documented below).

``text/template`` 構文の他にも、 ``json`` や ``prettyjson`` で JSON 形式の出力も可能です（ドキュメントは以下をご覧ください。）。

.. Examples

例
==========

.. List all the details of a machine:

**全マシンの詳細を表示：**

.. This is the default usage of inspect.

こちらは ``inspect`` のデフォルトの使い方です。

.. code-block:: bash

   $ docker-machine inspect dev
   {
       "DriverName": "virtualbox",
       "Driver": {
           "MachineName": "docker-host-128be8d287b2028316c0ad5714b90bcfc11f998056f2f790f7c1f43f3d1e6eda",
           "SSHPort": 55834,
           "Memory": 1024,
           "DiskSize": 20000,
           "Boot2DockerURL": "",
           "IPAddress": "192.168.5.99"
       },
       ...
   }

.. **Get a machine’s IP address:**

**マシンの IP アドレスを取得：**

.. For the most part, you can pick out any field from the JSON in a fairly straightforward manner.

JSON の出力結果全体から、適切なフィールドのみを適切に取得できます。

.. code-block:: bash

   $ docker-machine inspect --format='{{.Driver.IPAddress}}' dev
   192.168.5.99

.. Formatting details:

**フォーマットの詳細：**

.. If you want a subset of information formatted as JSON, you can use the json function in the template.

JSON 形式として情報のサブセットが欲しい場合は、テンプレートの中で ``json`` ファンクションが使えます。

.. code-block:: bash

   $ docker-machine inspect --format='{{json .Driver}}' dev-fusion
   {"Boot2DockerURL":"","CPUS":8,"CPUs":8,"CaCertPath":"/Users/hairyhenderson/.docker/machine/certs/ca.pem","DiskSize":20000,"IPAddress":"172.16.62.129","ISO":"/Users/hairyhenderson/.docker/machine/machines/dev-fusion/boot2docker-1.5.0-GH747.iso","MachineName":"dev-fusion","Memory":1024,"PrivateKeyPath":"/Users/hairyhenderson/.docker/machine/certs/ca-key.pem","SSHPort":22,"SSHUser":"docker","SwarmDiscovery":"","SwarmHost":"tcp://0.0.0.0:3376","SwarmMaster":false}

.. While this is usable, it’s not very human-readable. For this reason, there is prettyjson:

json 形式は使い易いのですが、人間にとって非常に読み辛いです。人が読む場合は ``prettyjson`` が使えます。

.. code-block:: bash

   $ docker-machine inspect --format='{{prettyjson .Driver}}' dev-fusion
   {
       "Boot2DockerURL": "",
       "CPUS": 8,
       "CPUs": 8,
       "CaCertPath": "/Users/hairyhenderson/.docker/machine/certs/ca.pem",
       "DiskSize": 20000,
       "IPAddress": "172.16.62.129",
       "ISO": "/Users/hairyhenderson/.docker/machine/machines/dev-fusion/boot2docker-1.5.0-GH747.iso",
       "MachineName": "dev-fusion",
       "Memory": 1024,
       "PrivateKeyPath": "/Users/hairyhenderson/.docker/machine/certs/ca-key.pem",
       "SSHPort": 22,
       "SSHUser": "docker",
       "SwarmDiscovery": "",
       "SwarmHost": "tcp://0.0.0.0:3376",
       "SwarmMaster": false
   }

.. seealso:: 

   inspect
      https://docs.docker.com/machine/reference/inspect/

