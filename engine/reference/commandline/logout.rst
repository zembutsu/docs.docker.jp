.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/logout/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/logout.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/logout.md
.. check date: 2016/06/16
.. Commits on Dec 24, 2015 e6115a6c1c02768898b0a47e550e6c67b433c436
.. -------------------------------------------------------------------

.. logout

=======================================
logout
=======================================

.. code-block:: bash

   使い方: docker logout [サーバ]
   
   Docker レジストリからログアウトする
   サーバの指定が無ければデフォルトで "https://index.docker.io/v1/" を使用
   
     --help          使い方の表示

.. For example:

例：

.. code-block:: bash

   $ docker logout localhost:8080

.. seealso:: 

   logout
      https://docs.docker.com/engine/reference/commandline/logout/
