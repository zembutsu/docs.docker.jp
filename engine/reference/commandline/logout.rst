.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/logout/
.. doc version: 1.9
.. check date: 2015/12/26
.. -----------------------------------------------------------------------------

.. logout

=======================================
logout
=======================================

.. code-block:: bash

   Usage: docker logout [SERVER]
   
   Log out from a Docker registry, if no server is
   specified "https://index.docker.io/v1/" is the default.
   
     --help=false    Print usage

.. For example:

例：

.. code-block:: bash

   $ docker logout localhost:8080
