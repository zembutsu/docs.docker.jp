.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/logout/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/logout.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/reference/commandline/logout.md
.. check date: 2016/04/27
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. logout

=======================================
logout
=======================================

.. code-block:: bash

   Usage: docker logout [SERVER]
   
   Log out from a Docker registry, if no server is
   specified "https://index.docker.io/v1/" is the default.
   
     --help          Print usage

.. For example:

例：

.. code-block:: bash

   $ docker logout localhost:8080

.. seealso:: 

   logout
      https://docs.docker.com/engine/reference/commandline/logout/
