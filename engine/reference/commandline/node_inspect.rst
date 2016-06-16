.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/node_inspect/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/node_inspect.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/node_inspect.md
.. check date: 2016/06/16
.. Commits on Jun 14, 2016 9acf97b72a4d5ff7b1bcad36fb19b53775f01596
.. -------------------------------------------------------------------

.. Warning: this command is part of the Swarm management feature introduced in Docker 1.12, and might be subject to non backward-compatible changes.

.. warning::

  このコマンドは Docker 1.12 で導入された Swarm 管理機能の一部です。それと、変更は下位互換性を考慮していない可能性があります。

.. node inspect

=======================================
node inspect
=======================================

.. code-block:: bash

   使い方: docker node inspect [オプション] self|NODE [NODE...]
   
   ノードの低レベル情報を返す
   
     -f, --format=       go テンプレートで指定した形式で表示
     --help              使い方の表示
     -p, --pretty        人間が読みやすい形式で情報を表示

.. Returns information about a node. By default, this command renders all results in a JSON array. You can specify an alternate format to execute a given template for each result. Go's text/template package describes all the details of the format.

ノードに関する情報を返しミズ遭う。デフォルトでは、このコマンドはすべて JSON アレイで返します。あるいは、結果ごとにテンプレートを指定し、別の書式で表示できます。書式については Go 言語の `text/template <http://golang.org/pkg/text/template/>`_ パッケージの説明をご覧ください。

.. Example output:

出力例：

.. code-block:: bash

   $ docker node inspect swarm-manager
   [
     {
       "ID": "0gac67oclbxq7",
       "Version": {
           "Index": 2028
       },
       "CreatedAt": "2016-06-06T20:49:32.720047494Z",
       "UpdatedAt": "2016-06-07T00:23:31.207632893Z",
       "Spec": {
           "Role": "MANAGER",
           "Membership": "ACCEPTED",
           "Availability": "ACTIVE"
       },
       "Description": {
           "Hostname": "swarm-manager",
           "Platform": {
               "Architecture": "x86_64",
               "OS": "linux"
           },
           "Resources": {
               "NanoCPUs": 1000000000,
               "MemoryBytes": 1044250624
           },
           "Engine": {
               "EngineVersion": "1.12.0",
               "Labels": {
                   "provider": "virtualbox"
               }
           }
       },
       "Status": {
           "State": "READY"
       },
       "Manager": {
           "Raft": {
               "RaftID": 2143745093569717375,
               "Addr": "192.168.99.118:4500",
               "Status": {
                   "Leader": true,
                   "Reachability": "REACHABLE"
               }
           }
       },
       "Attachment": {},
     }
   ]
   
   $ docker node inspect --format '{{ .Manager.Raft.Status.Leader }}' self
   false
   
   $ docker node inspect --pretty self
   ID:                     2otfhz83efcc7
   Hostname:               ad960a848573
   Status:
    State:                 Ready
    Availability:          Active
   Manager Status:
    Address:               172.17.0.2:2377
    Raft status:           Reachable
    Leader:                Yes
   Platform:
    Operating System:      linux
    Architecture:          x86_64
   Resources:
    CPUs:                  4
    Memory:                7.704 GiB
   Plugins:
     Network:              overlay, bridge, null, host, overlay
     Volume:               local
   Engine Version:         1.12.0



.. Related information

関連情報
----------

* :doc:`node_update`
* :doc:`node_tasks`
* :doc:`node_ls`
* :doc:`node_rm`

.. seealso:: 

   node inspect
      https://docs.docker.com/engine/reference/commandline/node_inspect/

