.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/kill/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/kill.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_kill.yaml
.. check date: 2022/03/21
.. Commits on Oct 12, 2021 ed135fe151ad43ca1093074c8fbf52243402013a
.. -------------------------------------------------------------------

.. docker kill

=======================================
docker kill
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_kill-description:

説明
==========

.. Kill one or more running containers

1つまたは複数の実行中コンテナを :ruby:`強制停止 <kill>` します。

.. _docker_kill-usage:

使い方
==========

.. code-block:: bash

   $ docker kill [OPTIONS] CONTAINER [CONTAINER...]

.. Extended description
.. _docker_killl-extended-description:

補足説明
==========

.. The docker kill subcommand kills one or more containers. The main process inside the container is sent SIGKILL signal (default), or the signal that is specified with the --signal option. You can reference a container by its ID, ID-prefix, or name.

``docker kill`` サブコマンドは、1つまたは複数のコンテナを :ruby:`強制停止 <kill>` します。コンテナ内のメイン・プロセスに、（デフォルトでは） ``SIGKILL`` シグナルを送信するか、 ``--signal`` オプションで指定したシグナルを送信します。コンテナの指定には、 ID、 ID の短縮形、コンテナ名が使えます。

.. The --signal (or -s shorthand) flag sets the system call signal that is sent to the container. This signal can be a signal name in the format SIG<NAME>, for instance SIGINT, or an unsigned number that matches a position in the kernel’s syscall table, for instance 2.

``--signal`` （または短縮形の ``-s`` ）フラグは、コンテナに対して送信する、システムコールのシグナルを指定します。このシグナルには、 ``SIGINT`` のように ``SIG<NAME>`` 形式のシグナル名も指定できます。あるいは、 ``2`` のように、カーネルのシステムコール表で対応する数値です。

.. While the default (SIGKILL) signal will terminate the container, the signal set through --signal may be non-terminal, depending on the container’s main process. For example, the SIGHUP signal in most cases will be non-terminal, and the container will continue running after receiving the signal.

デフォルトの（ ``SIGKILL`` ）シグナルがコンテナを終了させようとしますが、 ``--signal`` で指定したシグナルを渡すのが（コンテナの）終了を意味するのではなく、（動作は）コンテナのメイン・プロセスに依存します。たとえば、ほとんどの ``SIGHUP`` は終了ではなく、コンテナはシグナルを受信した後も実行し続けます。

..    Note
    ENTRYPOINT and CMD in the shell form run as a child process of /bin/sh -c, which does not pass signals. This means that the executable is not the container’s PID 1 and does not receive Unix signals.

    シェル形式の ``ENTRYPOINT`` と ``CMD`` は ``/bin/sh -c`` の子プロセスとして実行されますので、シグナルを渡せません。つまり、実行しているプロセスはコンテナの PID 1 ではなく、Unix シグナルを受信できません。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_kill-examples>` をご覧ください。

.. _docker_kill-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--signal`` , ``-s``
     - ``KILL``
     - コンテナに対してシグナルを送信

.. Examples
.. _docker_kill-examples:

使用例
==========

.. Send a KILL signal to a container
.. _docker_kill-send-a-kill-signal-to-a-container:
コンテナに KILL シグナルを送信
----------------------------------------

.. The following example sends the default SIGKILL signal to the container named my_container:

以下の例は、 ``my_container`` という名前のコンテナに対して、デフォルトの ``SIGKILL`` シグナルを送信します。

.. code-block:: bash

   $ docker kill my_container

.. Send a custom signal to a container
.. _docker_kill-send-a-custom-signal-to-a-container:
コンテナに任意のシグナルを送信
----------------------------------------

.. The following example sends a SIGHUP signal to the container named my_container:

以下の例は、 ``my_container`` という名前のコンテナに対して、 ``SIGHUP`` シグナルを送信します。

.. code-block:: bash

   $ docker kill --signal=SIGHUP  my_container

.. You can specify a custom signal either by name, or number. The SIG prefix is optional, so the following examples are equivalent:

「名前」あるいは「番号」のどちらかでも任意のシグナルを指定できます。 ``SIG`` を冒頭に付けるのはオプションのため、以下の例はどれも同じです。

.. code-block:: bash

   $ docker kill --signal=SIGHUP my_container
   $ docker kill --signal=HUP my_container
   $ docker kill --signal=1 my_container

.. Refer to the signal(7) man-page for a list of standard Linux signals.

標準 Linux シグナルの一覧は `signal(7) <https://man7.org/linux/man-pages/man7/signal.7.html>`_ の man ページをご覧ください。

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker kill
      https://docs.docker.com/engine/reference/commandline/kill/
