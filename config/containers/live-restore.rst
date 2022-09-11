.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/live-restore/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/live-restore.md
   doc version: 20.10
.. check date: 2022/04/27
.. Commits on Oct 26, 2020 2ce808edc0fc8bed39e5f115dffc221727a77fe7
.. ---------------------------------------------------------------------------

.. Keep containers alive during daemon downtime

.. _keep-containers-alive-during-daemon-downtime:

==================================================
デーモンが停止中でも、コンテナの実行を維持
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. By default, when the Docker daemon terminates, it shuts down running containers. You can configure the daemon so that containers remain running if the daemon becomes unavailable. This functionality is called live restore. The live restore option helps reduce container downtime due to daemon crashes, planned outages, or upgrades.

デフォルトでは、 Docker デーモンを終了（terminate）すると、実行中のコンテナを停止（shut down）します。デーモンが利用できない場合に、コンテナを実行し続けるかどうかのオプションを設定できます。この機能をライブ・リストア（ *live restore* ）と呼びます。リストアのオプションがあれば、デーモンのクラッシュ発生や、計画的な停止、アップグレード時にダウンタイムを短縮するのに役立ちます。

..    Note
    Live restore is not supported on Windows containers, but it does work for Linux containers running on Docker Desktop for Windows.

.. note::

   ライブ・リストアは Windows コンテナをサポートしていません。しかし、Docker Desktop for Windows 上で実行している Linux コンテナには動作します。

.. Enable live restore

.. _enable-live-restore:

ライブ・リストアの有効化
==============================

.. There are two ways to enable the live restore setting to keep containers alive when the daemon becomes unavailable. Only do one of the following.

デーモンが利用できなくなった場合、コンテナを残し続けるようにライブ・リストアを有効化にするには、2つの方法があります。 **以下にある、いずれか1つのみ行ってください** 。

..    Add the configuration to the daemon configuration file. On Linux, this defaults to /etc/docker/daemon.json. On Docker Desktop for Mac or Docker Desktop for Windows, select the Docker icon from the task bar, then click Preferences -> Daemon -> Advanced.
        Use the following JSON to enable live-restore.
        {
          "live-restore": true
        }
        Restart the Docker daemon. On Linux, you can avoid a restart (and avoid any downtime for your containers) by reloading the Docker daemon. If you use systemd, then use the command systemctl reload docker. Otherwise, send a SIGHUP signal to the dockerd process.

* デーモンの設定ファイル上で、設定を追加します。 Linux 上であれば、デフォルトは ``/etc/docker/daemon.json`` です。Docker Desktop for Windows や Docker Desktop for Mac であれば、タスクバーの Docker アイコンから、 **Preferences -> Daemon -> Advanced** をクリックします。

   * 以下の JSON を使うと ``live-restore`` を有効化します。
   
   ::
   
      {
        "live-restore": true
      }
   
   * Docker daemon を再起動します。 Linux 上であれば、Docker デーモンを再読込することで、再起動を防止できます（そして、コンテナに対する停止期間も防止）。 ``systemd`` を使っている場合は、 ``systemctl restart docker`` コマンドを使います。あるいは、 ``dockerd`` プロセスに対して ``SIGHUP`` シグナルを送信します。

..    If you prefer, you can start the dockerd process manually with the --live-restore flag. This approach is not recommended because it does not set up the environment that systemd or another process manager would use when starting the Docker process. This can cause unexpected behavior.

* あるいは別の方法として、 ``dockerd`` プロセスを手動で起動し、 ``--live-restore`` フラグを付けても可能です。しかし、この方法は推奨しません。セットアップ環境にある ``systemd`` や他のプロセス・マネージャが Docker プロセスを開始してしまう可能性があるためです。その結果、予期しない挙動になる可能性があります。

.. Live restore during upgrades

.. _live-restore-during-upgrades:

アップグレード中のライブ・リストア
========================================

.. Live restore allows you to keep containers running across Docker daemon updates, but is only supported when installing patch releases (YY.MM.x), not for major (YY.MM) daemon upgrades.

ライブ・リストアは、 Docker デーモンを更新中でもコンテナを実行したままにします。しかし、サポートしているのはパッチ・リリース（ ``年.月.x`` の形式 ）のバージョンに対してのみであり、メジャー（ ``年.月`` の形式 ）バージョンには対応していません。

.. If you skip releases during an upgrade, the daemon may not restore its connection to the containers. If the daemon can’t restore the connection, it cannot manage the running containers and you must stop them manually.

リリースを越えてアップグレードを試みると、デーモンはコンテナとの通信が修復（リストア）できない可能性があります。もしもデーモンが接続を修復できなければ、実行中のコンテナは管理できなくなり、手動でコンテナを停止する必要になります。

.. Live restore upon restart

.. _live-restore-upon-restart:

再起動時のライブ・リストア
==============================

.. The live restore option only works to restore containers if the daemon options, such as bridge IP addresses and graph driver, did not change. If any of these daemon-level configuration options have changed, the live restore may not work and you may need to manually stop the containers.

ライブ・リストアのオプション設定が機能するのは、デーモンのコンテナに対するオプション指定のみです。ブリッジ IP アドレスと、グラフ・ドライバは変更しません。デーモン・レベルの設定オプションを変更するのであれば、ライブ・リストアは動作せず、手動でコンテナを停止する必要が出てきます。

.. Impact of live restore on running containers

.. _impact-of-live-restore-on-running-containers:

実行中のコンテナに対するライブ・リストアの影響
==================================================

.. If the daemon is down for a long time, running containers may fill up the FIFO log the daemon normally reads. A full log blocks containers from logging more data. The default buffer size is 64K. If the buffers fill, you must restart the Docker daemon to flush them.

長期間にわたりデーモンが停止すると、実行中のコンテナでは、デーモンが通常読み込む FIFO ログが溢れてしまう可能性があります。コンテナからのロギングや他データなど、全てのログをブロックします。デフォルトのバッファ・サイズは 64K です。バッファが溢れると、これらをフラッシュするには Docker デーモンの再起動が必要になります。

.. On Linux, you can modify the kernel’s buffer size by changing /proc/sys/fs/pipe-max-size. You cannot modify the buffer size on Docker Desktop for Mac or Docker Desktop for Windows.

Linux 上では、このカーネルのバッファ・サイズを ``/proc/sys/fs/pipe-max-size`` で変更できます。しかし、Docker Desktop for mac や Docker Desktop for Windows では、このバッファ・サイズを変更できません。

.. Live restore and swarm mode

.. _live restore and swarm mode:

ライブ・リストアと swarm モード
========================================

.. The live restore option only pertains to standalone containers, and not to swarm services. Swarm services are managed by swarm managers. If swarm managers are not available, swarm services continue to run on worker nodes but cannot be managed until enough swarm managers are available to maintain a quorum.

ライブ・リストアオプションが有効になるのは、スタンドアロンのコンテナに対してであり、 swarm サービスでは利用できません。 Swarm サービスは swarm マネージャによって管理されます。swarm マネージャが利用できなくなれば、 swarm サービスはワーカ・ノード上で実行し続けようとしますが、クォーラムを維持するために利用可能な swarm マネージャが十分でなければ、サービスの実行は維持できません。

.. seealso:: 

   Keep containers alive during daemon downtime
      https://docs.docker.com/config/containers/live-restore/
