.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/swarm/reference/help/
.. SOURCE: https://github.com/docker/swarm/blob/master/docs/reference/help.md
   doc version: 1.11
      https://github.com/docker/swarm/commits/master/docs/reference/help.md
.. check date: 2016/04/29
.. Commits on Feb 25, 2016 e8fad3d657f23aea08b3d03eab422ae89cfa3442
.. -------------------------------------------------------------------

.. help - Display information about a command

.. _help-display-information-about-a-command:

===================================================
help - コマンドに関する情報の表示
===================================================

.. The help command displays information about how to use a command.

``help`` コマンドは各コマンドの使い方に関する情報を表示します。

.. For example, to see a list of Swarm options and commands, enter:

例えば、Swarm のオプション一覧を表示するには、次のように実行します：

.. code-block:: bash

   $ docker run swarm --help

.. To see a list of arguments and options for a specific Swarm command, enter:

特定の Swarm コマンドのオプションに対する引数一覧を確認するには、次のように実行します。

.. code-block:: bash

   $ docker run swarm <command> --help

.. For example:

実行例：

.. code-block:: bash

   $ docker run swarm list --help
   Usage: swarm list [OPTIONS] <discovery>
   
   List nodes in a cluster
   
   Arguments:
      <discovery>    discovery service to use [$SWARM_DISCOVERY]
                      * token://<token>
                      * consul://<ip>/<path>
                      * etcd://<ip1>,<ip2>/<path>
                      * file://path/to/file
                      * zk://<ip1>,<ip2>/<path>
                      * [nodes://]<ip1>,<ip2>
   
   Options:
      --timeout "10s"                          timeout period
      --discovery-opt [--discovery-opt option --discovery-opt option]  discovery options

.. seealso:: 

   help - Display information about a command
      https://docs.docker.com/swarm/reference/help/
