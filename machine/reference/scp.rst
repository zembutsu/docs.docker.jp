.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/scp/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/scp.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/reference/scp.md
.. check date: 2016/03/09
.. Commits on Nov 27, 2015 68e6e3f905856bc1d93cb5c1e99cc3b3ac900022
.. ----------------------------------------------------------------------------

.. scp

.. _machine-scp:

=======================================
scp
=======================================

.. Copy files from your local host to a machine, from machine to machine, or from a machine to your local host using scp.

``scp`` を使い、ローカル・ホストからマシンにファイルをコピーします。あるいは、マシンからマシンへ、マシンからローカルホストへコピーします。

.. The notation is machinename:/path/to/files for the arguments; in the host machine’s case, you don’t have to specify the name, just the path.

引数の表記法は ``マシン名:/path/to/files`` （ファイルへのパス）です。対象がホストマシン上であれば、マシン名を指定せずに、パスのみを指定します。

.. Consider the following example:

次の例を考えてみます：

.. code-block:: bash

   $ cat foo.txt
   cat: foo.txt: No such file or directory
   $ docker-machine ssh dev pwd
   /home/docker
   $ docker-machine ssh dev 'echo A file created remotely! >foo.txt'
   $ docker-machine scp dev:/home/docker/foo.txt .
   foo.txt                                                           100%   28     0.0KB/s   00:00
   $ cat foo.txt
   A file created remotely!

.. Just like how scp has a -r flag for copying files recursively, docker-machine has a -r flag for this feature.

``scp`` で ``-r`` フラグを使うと、再帰的にファイルをコピーします。この機能を ``docker-machine`` で使うには ``-r`` フラグを使います。

.. In the case of transferring files from machine to machine, they go through the local host’s filesystem first (using scp’s -3 flag).

マシンからマシンへファイルを転送する場合は、ローカル・ホスト上のファイルシステムを経由する必要があります（ ``scp`` の ``-3`` フラグ）を使います。

.. seealso:: 

   scp
      https://docs.docker.com/machine/reference/scp/
