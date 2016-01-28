.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/reference/regenerate-certs/
.. doc version: 1.9
.. check date: 2016/01/28
.. -----------------------------------------------------------------------------

.. regenerate-certs

.. _machine-regenerate-certs:

=======================================
regenerate-certs
=======================================

.. Regenerate TLS certificates and update the machine with new certs.

TLS 証明書を再作成し、新しい証明書を使うようにマシンの情報を更新します。

.. code-block:: bash

   $ docker-machine regenerate-certs dev
   Regenerate TLS machine certs?  Warning: this is irreversible. (y/n): y
   Regenerating TLS certificates

