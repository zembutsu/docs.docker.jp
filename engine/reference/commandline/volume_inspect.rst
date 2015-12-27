.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/volume_inspect/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. volume inspect

=======================================
volume inspect
=======================================

.. code-block:: bash

   Usage: docker volume inspect [OPTIONS] VOLUME [VOLUME...]
   
   Inspect one or more volumes
   
     -f, --format=       Format the output using the given go template.
     --help=false        Print usage

.. Returns information about a volume. By default, this command renders all results in a JSON array. You can specify an alternate format to execute a given template for each result. Go’s text/template package describes all the details of the format.

ボリュームに関する情報を返します。デフォルトでは、コマンドは JSON 配列の形式です。実行レンプレートを個々に指定し、別のフォーマットを指定できます。Go 言語の `text/template <http://golang.org/pkg/text/template/>`_ パッケージに、フォーマットの詳細に関する全てが記述されています。

.. Example output:

出力例：

.. code-block:: bash

   $ docker volume create
   85bffb0677236974f93955d8ecc4df55ef5070117b0e53333cc1b443777be24d
   $ docker volume inspect 85bffb0677236974f93955d8ecc4df55ef5070117b0e53333cc1b443777be24d
   [
     {
         "Name": "85bffb0677236974f93955d8ecc4df55ef5070117b0e53333cc1b443777be24d",
         "Driver": "local",
         "Mountpoint": "/var/lib/docker/volumes/85bffb0677236974f93955d8ecc4df55ef5070117b0e53333cc1b443777be24d/_data"
     }
   ]
   
   $ docker volume inspect --format '{{ .Mountpoint }}' 85bffb0677236974f93955d8ecc4df55ef5070117b0e53333cc1b443777be24d
   /var/lib/docker/volumes/85bffb0677236974f93955d8ecc4df55ef5070117b0e53333cc1b443777be24d/_data


