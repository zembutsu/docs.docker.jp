.. H-*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/troubleshoot/workarounds/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/troubleshoot/workarounds.md
.. check date: 2022/09/17
.. Commits on Jul 20, 2022 e29b9691aee66bb49fb8439e47ab84a5f2c316ac
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :scale: 50%

.. Workarounds for common problems
.. _desktop-workarounds-for-common-problems:

==================================================
共通する問題の回避策
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Reboot
.. _desktop-workarounds-reboot:
再起動
--------------------------------------------------

.. Restart your PC to stop / discard any vestige of the daemon running from the previously installed version.

PC を再起動し、以前にインストールしたバージョンで動いているデーモンの残骸を、停止・削除します。

.. Unset DOCKER_HOST
.. _desktop-unset-docker-host:

``DOCKER_HOST`` のリセット（unset）
--------------------------------------------------

.. The DOCKER_HOST environmental variable does not need to be set. If you use bash, use the command unset ${!DOCKER_*} to unset it. For other shells, consult the shell’s documentation.

:code:`DOCKER_HOST` 環境変数の設定は不要です。 bash を使用する場合は、リセットのために :code:`unset ${!DOCKER_*}` コマンドを使います。他のシェルの場合は、シェルのドキュメントをご確認ください。

.. Make sure Docker is running for webserver examples
.. _desktop-make-sure-docker-is-running-for-webserver-examples:

ウェブサーバの例で Docker が動作しているのを確認
--------------------------------------------------

.. For the hello-world-nginx example and others, Docker Desktop must be running to get to the webserver on http://localhost/. Make sure that the Docker whale is showing in the menu bar, and that you run the Docker commands in a shell that is connected to the Docker Desktop Engine (not Engine from Toolbox). Otherwise, you might start the webserver container but get a “web page not available” error when you go to docker.

``hello-world-nginx`` サンプルなどを使い、 Docker Desktop で ``https://localhost`` 上にウェブサーバを起動します。メニューバー上に Docker 鯨（のアイコン）があるのを確認し、シェル上の Docker コマンドが Docker Desktop エンジンに接続しているのを確認します（Toolbox のエンジンではありません）。そうしなければ、ウェブサーバ・コンテナは実行できるかもしれませんが、 ``docker`` は "web page not available"（ウェブページが表示できません）というエラーを返すでしょう。

.. How to solve port already allocated errors
.. _desktoo-how-to-solve-port-already-allocated-errors:

``port already allocated`` （ポートが既に割り当てられています） エラーを解決するには
--------------------------------------------------------------------------------------

.. If you see errors like Bind for 0.0.0.0:8080 failed: port is already allocated or listen tcp:0.0.0.0:8080: bind: address is already in use ...

``Bind for 0.0.0.0:8080 failed: port is already allocated`` や ``listen tcp:0.0.0.0:8080: bind: address is already in use`` ... のようなエラーが出ることがあるでしょう。

.. These errors are often caused by some other software on Windows using those ports. To discover the identity of this software, either use the resmon.exe GUI and click “Network” and then “Listening Ports” or in a Powershell use netstat -aon | find /i "listening " to discover the PID of the process currently using the port (the PID is the number in the rightmost column). Decide whether to shut the other process down, or to use a different port in your docker app.

これらのエラーは、Windows 上の他のソフトウェアが各ポートを使っている場合によく発生します。どのソフトウェアが使っているかを見つけるか、 ``resmon.exe`` の GUI を使い "Network" と "listening Ports"  をクリックするか、 Powershell 上では ``netstat -aon | find /i "listening "`` を使って、対象ポートを現在使っているプロセスの PID を見つけます（PID の値は行の右端です）。他のプロセスの停止を決めるか、あるいは、docker アプリで別のポートを使うかを決めます。

.. Docker Desktop fails to start when anti-virus software is installed
.. _desktop-docker-desktop-fails-to-start-when-anti-virus-software-is-installed:

アンチウィルス ソフトウェアをインストールしていると、Docker Desktop の起動に失敗
-------------------------------------------------------------------------------------

.. Some anti-virus software may be incompatible with Hyper-V and Microsoft Windows 10 builds. The conflict typically occurs after a Windows update and manifests as an error response from the Docker daemon and a Docker Desktop start failure.

いくつかのアンチウィルス ソフトウェアは、Hyper-V と Microsoft Windows 10 ビルドによっては互換性がない場合があります。典型的に発生するのは Windows update 直後で、Docker デーモンからエラーの反応が表示され、Docker Desktop の起動に失敗します。

.. For a temporary workaround, uninstall the anti-virus software, or explore other workarounds suggested on Docker Desktop forums.

一時的な回避策としては、アンチウィルス ソフトウェアをアンインストールするか、Docker Desktop フォーラム上での他の回避策をお探しください。



.. seealso::

   Workarounds for common problems
      https://docs.docker.com/desktop/troubleshoot/workarounds/

