.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/commandline/volume_ls/
.. doc version: 1.9
.. check date: 2015/12/27
.. -----------------------------------------------------------------------------

.. volume ls

=======================================
volume ls
=======================================

.. code-block:: bash

   Usage: docker volume ls [OPTIONS]
   
   List volumes
   
     -f, --filter=[]      Provide filter values (i.e. 'dangling=true')
     --help=false         Print usage
     -q, --quiet=false    Only display volume names

.. Lists all the volumes Docker knows about. You can filter using the -f or --filter flag. The filtering format is a key=value pair. To specify more than one filter, pass multiple flags (for example, --filter "foo=bar" --filter "bif=baz")

Docker が把握している全てのボリュームを表示します。 ``-f`` か ``--filter`` フラグを使ってフィルタできます。フィルタリングの形式は ``key=value`` のペアです。１つまたは複数のフィルタを指定するには、複数のフラグを通します（例： ``--filter "foo=bar" --filter "bif=baz"`` ）。

.. There is a single supported filter dangling=value which takes a boolean of true or false.

``dangling=value`` フィルタのみ ``true`` か ``false`` を指定します。

.. Example output:

出力例：

.. code-block:: bash

   $ docker volume create --name rose
   rose
   $docker volume create --name tyler
   tyler
   $ docker volume ls
   DRIVER              VOLUME NAME
   local               rose
   local               tyler

