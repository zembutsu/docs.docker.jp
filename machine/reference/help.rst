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

   使い方: docker-machine help [引数...]
   
   全てのコマンドを表示するか、１つのコマンドのヘルプを表示

   使い方: docker-machine help サブコマンド

.. Show help text, for example:

ヘルプ・テキストを表示するには、次のように実行します。

.. code-block:: bash

   $ docker-machine help config
   使い方: docker-machine config [オプション] [引数...]
   
   マシンに接続する設定を表示
   
   説明:
      引数はマシン名。
   
   オプション:
   
      --swarm      Docker デーモンの代わりに Swarm の設定を表示

.. seealso:: 

   help
      https://docs.docker.com/machine/reference/help/

