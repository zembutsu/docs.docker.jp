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

   Usage: docker-machine regenerate-certs [OPTIONS] [arg...]
   
   Regenerate TLS Certificates for a machine
   
   Description:
      Argument(s) are one or more machine names.
   
   Options:
   
      --force, -f  Force rebuild and do not prompt

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
