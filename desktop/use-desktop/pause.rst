.. H-*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/use-desktop/pause/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/use-desktop/pause.md
.. check date: 2022/09/17
.. Commits on Sep 7, 2022 cbbb9f1fac9289c0d2851584010559f8f03846f0
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :width: 50%

.. Pause Docker Desktop
.. _pause-docker-desktop:

==================================================
Docker Desktop の :ruby:`一次停止 <pause>`
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can pause your Docker Desktop session when you are not actively using it and save CPU resources on your machine. When you pause Docker Desktop, the Linux VM running Docker Engine is paused, the current state of all your containers are saved in memory, and all processes are frozen. This reduces the CPU usage and helps you retain a longer battery life on your laptop. You can resume Docker Desktop when you want by clicking the Resume option.

Docker Desktop をアクティブに使っていない場合や、マシン上の CPU リソースを節約したい場合、 Docker Desktop を :ruby:`一次停止 <pause>` できます。Docker Desktop を一次停止すると、 Docker Engine を動かしている Linux VM が一次停止され、全てのコンテナの現在の状態がメモリに保存され、全てのプロセスが :ruby:`凍結 <frozen>` されます。これにより CPU 使用量を経たし、ノート PC 上ではバッテリの寿命を長くするのに役立ちます。Docker Desktop を再開したい場合は、 **Resume** オプションをクリックします。

.. From the Docker menu, selectwhale menu and then Pause to pause Docker Desktop.

Docker メニュー |whale| から **Pause** を選ぶと、 Docker Desktop は一次停止します。

.. Docker Desktop displays the paused status on the Docker menu and on the Containers, Images, Volumes, and Dev Environment screens in Docker Dashboard. You can still access the Preferences (or Settings if you are a Windows user) and the Troubleshoot menu from the Dashboard when you’ve paused Docker Desktop.

Docker Desktop の Docker メニュー上では、 **Containers** 、 **Images** 、 **Volumes** 、 **Dev Environment** 画面が  Paused （一次停止）と表示されます。Docker Desktop が一次停止していても、ダッシュボード上の **Preferences** （Windows ユーザの場合は **Settings** ）と **Troubleshoot** メニューにはアクセスできます。

.. Select whale menu then Resume to resume Docker Desktop.

Docker Desktop を再開するには |whale| から **Resume** を選びます。

..  Note
    When Docker Desktop is paused, running any commands in the Docker CLI will automatically resume Docker Desktop.

.. note::

   Docker Desktop を一次停止中に、 Docker CLI 内でコマンドを実行すると、自動的に Docker Desktop が再開されます。

.. seealso::

   Pause Docker Desktop
      https://docs.docker.com/desktop/use-desktop/pause/

