.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/help/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/help.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/help.md
.. check date: 2016/04/28
.. Commits on Feb 21, 2016 d7e97d04436601da26d24b199532652abe78770e
.. ----------------------------------------------------------------------------

.. help

.. _machine-help:

=======================================
help
=======================================

.. code-block:: bash

   Usage: docker-machine help [arg...]
   
   Shows a list of commands or help for one command

.. Usage: docker-machine help subcommand

使い方：docker-machine help *サブコマンド*

.. Show help text, for example:

ヘルプ・テキストを表示するには、次のように実行します。

.. code-block:: bash

   $ docker-machine help config
   Usage: docker-machine config [OPTIONS] [arg...]
   
   Print the connection config for machine
   
   Description:
      Argument is a machine name.
   
   Options:
   
      --swarm      Display the Swarm config instead of the Docker daemon

.. seealso:: 

   help
      https://docs.docker.com/machine/reference/help/

