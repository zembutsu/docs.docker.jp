.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/volume_inspect/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/volume_inspect.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/reference/commandline/volume_inspect.md
.. check date: 2016/04/28
.. Commits on Apr 15, 2016 36a1c56cf555f8fe9ceabeebb8fc956e05863fc7
.. -------------------------------------------------------------------

.. volume inspect

=======================================
volume inspect
=======================================

.. code-block:: bash

   使い方: docker volume inspect [オプション] ボリューム [ボリューム...]
   
   ボリュームの低レベル情報を返す
   
     -f, --format=       指定した go テンプレートの形式で出力
     --help              使い方の表示

.. Returns information about a volume. By default, this command renders all results in a JSON array. You can specify an alternate format to execute a given template for each result. Go’s text/template package describes all the details of the format.

ボリュームに関する情報を返します。デフォルトでは、コマンドは JSON 配列の形式です。実行テンプレートを個々に指定し、別のフォーマットを指定できます。Go 言語の `text/template <http://golang.org/pkg/text/template/>`_ パッケージに、フォーマットの詳細に関する全てが記述されています。

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
         "Mountpoint": "/var/lib/docker/volumes/85bffb0677236974f93955d8ecc4df55ef5070117b0e53333cc1b443777be24d/_data",
         "Status": null
     }
   ]
   
   $ docker volume inspect --format '{{ .Mountpoint }}' 85bffb0677236974f93955d8ecc4df55ef5070117b0e53333cc1b443777be24d
   /var/lib/docker/volumes/85bffb0677236974f93955d8ecc4df55ef5070117b0e53333cc1b443777be24d/_data

関連情報
==========

* :doc:`volume_create`
* :doc:`volume_ls`
* :doc:`volume_rm`
* :doc:`/engine/userguide/containers/dockervolumes`

.. seealso:: 

   volume inspect
      https://docs.docker.com/engine/reference/commandline/volume_inspect/
