.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/regenerate-certs/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/regenerate-certs.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/regenerate-certs.md
.. check date: 2016/04/28
.. Commits on Feb 21, 2016 d7e97d04436601da26d24b199532652abe78770e
.. ----------------------------------------------------------------------------

.. regenerate-certs

.. _machine-regenerate-certs:

=======================================
regenerate-certs
=======================================

.. code-block:: bash

   使い方: docker-machine regenerate-certs [オプション] [引数...]
   
   マシン用の TLS 証明書を再作成
   
   説明:
      引数は１つまたは複数のマシン名
   
   オプション:
   
      --force, -f  強制的に再作成し、表示しない

.. Regenerate TLS certificates and update the machine with new certs.

TLS 証明書を再作成し、新しい証明書を使うようにマシンの情報を更新します。

例：

.. code-block:: bash

   $ docker-machine regenerate-certs dev
   Regenerate TLS machine certs?  Warning: this is irreversible. (y/n): y
   Regenerating TLS certificates

.. seealso:: 

   regenerate-certs
      https://docs.docker.com/machine/reference/regenerate-certs/
