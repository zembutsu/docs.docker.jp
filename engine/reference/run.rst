.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/reference/run/
.. doc version: 1.9
.. check date: 2016/01/10

.. Docker run reference

.. _docker-run-reference:

========================================
Docker run リファレンス
========================================

.. Docker runs processes in isolated containers. A container is a process which runs on a host. The host may be local or remote. When an operator executes docker run, the container process that runs is isolated in that it has its own file system, its own networking, and its own isolated process tree separate from the host.

Docker は隔離されたコンテナでプロセスを実行します。コンテナはホスト上で動くプロセスです。ホストとはローカルかリモートです。作業者が ``docker run`` を実行すると、コンテナのプロセスが隔離されて実行されます。ここではコンテナ自身のファイルシステムを持ち、自身のネットワークを持ち、ホスト上の他のプロセス・ツリーからは隔離されています。

.. This page details how to use the docker run command to define the container’s resources at runtime.

このページでは、コンテナ実行時のリソースを指定するために、 ``docker run`` コマンドの使い方の詳細を説明します。

.. General form

.. _run-general-form:

一般的な形式
====================

.. The basic docker run command takes this form:

基本的な ``docker run`` コマンドの形式は、次の通りです。

.. code-block:: bash

   $ docker run [オプション] イメージ[:タグ|@ダイジェスト値] [コマンド] [引数...]

.. The docker run command must specify an IMAGE to derive the container from. An image developer can define image defaults related to:

``docker run`` コマンドはコンテナを形成する元になる :ref:`イメージ <image>` の指定が必須です。イメージの開発者はイメージに関連するデフォルト値を定義できます。

..    detached or foreground running
    container identification
    network settings
    runtime constraints on CPU and memory
    privileges and LXC configuration

* デタッチ、あるいはフォアグラウンドで実行するか
* コンテナの識別
* ネットワーク設定
* 実行時の CPU とメモリの制限
* 権限と LXC 設定

.. With the docker run [OPTIONS] an operator can add to or override the image defaults set by a developer. And, additionally, operators can override nearly all the defaults set by the Docker runtime itself. The operator’s ability to override image and Docker runtime defaults is why run has more options than any other docker command.

``docker run [オプション]`` では、開発者がイメージに対して行ったデフォルト設定の変更や、設定の追加をオペレータが行えます。そして更に、オペレータは Docker で実行する時、すべてのデフォルト設定を上書きすることもできます。オペレータはイメージと Docker 実行時のデフォルト設定を上書きできるのは、 :doc:`run </engine/reference/commandline/run>` コマンドは他の ``docker`` コマンドより多くのオプションがあるためです。

.. To learn how to interpret the types of [OPTIONS], see Option types.

様々な種類の ``[オプション]`` を理解するには、 :ref:`オプションの種類 <option-types>` をご覧ください。

..    Note: Depending on your Docker system configuration, you may be required to preface the docker run command with sudo. To avoid having to use sudo with the docker command, your system administrator can create a Unix group called docker and add users to it. For more information about this configuration, refer to the Docker installation documentation for your operating system.

.. note::

   Docker システムの設定によっては、 ``docker run`` コマンドを ``sudo`` で実行する必要があるかもしれません。 ``docker`` コマンドで ``sudo`` を使わないようにするには、システム管理者に ``docker`` という名称のグループの作成と、そこにユーザの追加を依頼してください。この設定に関するより詳しい情報は、各オペレーティング・システム向けのインストール用ドキュメントをご覧ください。

.. Operator exclusive options

.. _operator-exclusive-options:

オペレータ専用のオプション
==============================

.. Only the operator (the person executing docker run) can set the following options.

オペレータ（ ``docker run`` の実行者 ）のみ、以下のオプションを設定できます。

..    Detached vs foreground
        Detached (-d)
        Foreground
    Container identification
        Name (–name)
        PID equivalent
    IPC settings (–ipc)
    Network settings
    Restart policies (–restart)
    Clean up (–rm)
    Runtime constraints on resources
    Runtime privilege, Linux capabilities, and LXC configuration

* :ref:`デタッチド vs フォアグラウンド <detached-vs-foreground>`
 * :ref:`デタッチド (-d) <detached-d>`
 * :ref:`フォアグラウンド <foreground>`
* :ref:`コンテナの識別 <container-identification>`
 * :ref:`名前 <name-name>`
 * :ref:`PID 相当 <pid-quivalent>`
* :ref:`IPC 設定 <ipc-settings-ipc>`
* :ref:`ネットワーク設定 <network-settings>`
* :ref:`再起動ポリシー <restart-policies-restart>`
* :ref:`クリーンアップ <clean-up-rm>`
* :ref:`実行時のリソース制限 <runtime-constraints-on-resources>`
* :ref:`実行時の権限、Linux 機能、LXC 設定 <runtime-privilege-linux-capabilities-and-lxc-configuration>`

.. Detached vs foreground

.. _detatched-vs-foreground:

デタッチド vs フォアグラウンド
==============================

.. When starting a Docker container, you must first decide if you want to run the container in the background in a “detached” mode or in the default foreground mode:

Docker コンテナの起動時には、まず、コンテナをバックグラウンドで「デタッチド」モード（detached mode）で実行するか、デフォルトのフォアグラウンド・モード（foreground mode）で実行するかを決める必要があります。

.. code-block:: bash

   -d=false: Detached mode: Run container in the background, print new container id

.. Detached (-d)

.. _detached-d:

デタッチド (-d)
====================

.. To start a container in detached mode, you use -d=true or just -d option. By design, containers started in detached mode exit when the root process used to run the container exits. A container in detached mode cannot be automatically removed when it stops, this means you cannot use the --rm option with -d option.

コンテナをデタッチド・モードで起動するには、 ``-d=true`` か ``-d`` オプションを使います。設計上、コンテナが実行するルート・プロセスが終了すると、デタッチド・モードで起動したコンテナも終了します。デタッチド・モードのコンテナは停止しても自動的に削除できません。つまり ``-d`` オプションで ``--rm`` を指定できません。

.. Do not pass a service x start command to a detached container. For example, this command attempts to start the nginx service.

デタッチドのコンテナでは ``service x start`` コマンドは受け付けられません。例えば、次のコマンドは ``nginx`` サービスの起動を試みるものです。

.. code-block:: bash

   $ docker run -d -p 80:80 my_image service nginx start

.. This succeeds in starting the nginx service inside the container. However, it fails the detached container paradigm in that, the root process (service nginx start) returns and the detached container stops as designed. As a result, the nginx service is started but could not be used. Instead, to start a process such as the nginx web server do the following:

コンテナ内で ``nginx`` サービスの起動は成功します。しかしながら、デタッチド・コンテナの枠組みにおいては処理が失敗します。これはルート・プロセス（ ``service nginx start`` ）が戻るので、デタッチド・コンテナを停止させようとします。その結果、 ``nginx`` サービスは実行されますが、実行し続けることができません。そのかわり、 ``nginx``  ウェブ・サーバのプロセスを実行するには、次のようにします。

.. code-block:: bash

   $ docker run -d -p 80:80 my_image nginx -g 'daemon off;'

.. To do input/output with a detached container use network connections or shared volumes. These are required because the container is no longer listening to the command line where docker run was run.

コンテナの入出力はネットワーク接続や共有ボリュームも扱えます。コマンドラインで ``docker run`` を実行し終わったあとでも、必要になることがあるでしょう。

.. To reattach to a detached container, use docker attach command.

デタッチド・コンテナに再度アタッチするには、 ``docker`` :doc:`attach </engine/reference/commandline/attach>` コマンドを使います。

