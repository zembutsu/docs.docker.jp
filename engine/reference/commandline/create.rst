.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/create.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_create.yaml
.. check date: 2022/03/20
.. Commits on Oct 13, 2021 373ec2cf37bd5ef812b65a8f5c43e81001a61c8c
.. -------------------------------------------------------------------

.. docker create

=======================================
docker create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. seealso:: 

   :doc:`docker container create <container_create>`

.. _docker_create-description:

説明
==========

.. Creates a new container.

新しいコンテナを :ruby:`作成 <create>` します。

.. _docker_create-usage:

使い方
==========

.. code-block:: bash

   $ docker create [OPTIONS] IMAGE [COMMAND] [ARG...]


.. Extended description
.. _docker_create-extended-description:

補足説明
==========

.. The docker create command creates a writeable container layer over the specified image and prepares it for running the specified command. The container ID is then printed to STDOUT. This is similar to docker run -d except the container is never started. You can then use the docker start <container_id> command to start the container at any point.

``docker create`` コマンドは、指定したイメージ上に書き込み可能なコンテナ・レイヤを作成し、指定したコマンドを実行する準備をします。実行後、 ``STDOUT`` にコンテナ ID を表示します。これは ``docker run -d`` と似ていますが、コンテナは決して起動しません。その後、いつでも ``docker start <コンテナID>`` コマンドを使ってコンテナを起動できます。

.. This is useful when you want to set up a container configuration ahead of time so that it is ready to start when you need it. The initial status of the new container is created.

これは、事前にコンテナの設定を済ませておきたい場合に役立ちます。そのため、必要があればいつでも起動できます。この新しいコンテナの初期 :ruby:`状態 <status>` は ``created`` （作成済み）です。

.. Please see the run command section and the Docker run reference for more details.

詳細は :doc:`run コマンド <run>` と :doc:`Docker run リファレンス </engine/reference/run>` をご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_create-examples>` をご覧ください。

.. _docker_create-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
 - デフォルト
     - 説明
   * - ``--add-host``
     - 
     - 任意のホスト名と IP アドレスの割り当てを追加（host:ip）
   * - ``--attach`` , ``-a``
     - 
     - 標準入力、標準出力、標準エラー出力にアタッチ
   * - ``--blkio-weight``
     - 
     - ブロック I/O ウエイト（相対値）を 10 ～ 1000 までの値でウエイトを設定（デフォルト 0）
   * - ``--blkio-weight-device``
     - 
     - ブロック I/O ウエイト（相対デバイス値）
   * - ``--cap-add``
     - 
     - Linux ケーパビリティを追加
   * - ``--cap-drop``
     - 
     - Linux ケーパビリティを削除
   * - ``--cgroup-parent``
     - 
     - コンテナに対し、オプションの親 cgroup を追加
   * - ``--cgroups``
     - 
     - `【API 1.41+】 <https://docs.docker.com/engine/api/v1.41/>`_ 使用する cgorup 名前空間を指定します（ host | private ）。 ``host`` は、Docker ホストの cgroup 名前空間内でコンテナを実行します。 ``private`` は自身の cgroup 名前空間でコンテナを実行します。使用する cgorup 名前空間は、デーモンのオプション default-cgroupns-mode によって設定されたものです（デフォルト）
   * - ``--cidfile``
     - 
     - コンテナ ID をファイルに書き出す
   * - ``--cpu-count``
     - 
     - CPU カウント（Windowsのみ）
   * - ``--cpu-percent``
     - 
     - CPU パーセント（Windowsにみ）
   * - ``--cpu-period``
     - 
     - CPU CFS (Completely Fair Scheduler) の間隔を設定
   * - ``--cpu-quota``
     - 
     - CPU CFS (Completely Fair Scheduler) のクォータを設定
   * - ``--cpu-rt-period``
     - 
     - 【API 1.25+】 CPU real-time period 制限をマイクロ秒で指定
   * - ``--cpu-rt-runtime``
     - 
     - 【API 1.25+】 CPU real-time runtime 制限をマイクロ秒で指定
   * - ``--cpu-shares`` , ``-c``
     - 
     - CPU 共有（相対値）
   * - ``--cpus``
     - 
     - 【API 1.25+】 CPU 数
   * - ``--cpuset-cpus``
     - 
     - 実行する CPU の割り当て（0-3, 0,1）
   * - ``--cpuset-mems``
     - 
     - 実行するメモリ・ノード（MEM）の割り当て（0-3, 0,1）
   * - ``--device``
     - 
     - ホスト・デバイスをコンテナに追加
   * - ``--device-cgroup-rule``
     - 
     - cgroup を許可するデバイス一覧にルールを追加
   * - ``--device-read-bps``
     - 
     - デバイスからの読み込みレートを制限
   * - ``--device-read-iops``
     - 
     - デバイスからの読み込みレート（１秒あたりの IO）を制限
   * - ``--device-write-bps``
     - 
     - デバイスからの書き込みレートを制限
   * - ``--device-write-iops``
     - 
     - デバイスからの書き込みレート（１秒あたりの IO）を制限
   * - ``--disable-content-trust``
     - ``true``
     - イメージの認証を省略
   * - ``--dns``
     - 
     - 任意の DNS サービスを指定
   * - ``--dns-opt``
     - 
     - DNS オプションを指定
   * - ``--dns-option``
     - 
     - DNS オプションを指定
   * - ``--dns-search``
     - 
     - 任意の DNS 検索ドメインを指定
   * - ``--domainname``
     - 
     - コンテナ NIS ドメイン名
   * - ``--entrypoint``
     - 
     - イメージのデフォルト ENTRYPOINT を上書き
   * - ``--env`` , ``-e``
     - 
     - 環境変数を指定
   * - ``--env-file``
     - 
     - 環境変数のファイルを読み込む
   * - ``--expose``
     - 
     - 公開するポートまたはポート範囲
   * - ``--gpus``
     - 
     - 【API 1.40+】 コンテナに対して GPU デバイスを追加（ ``all`` は全ての GPU を割り当て）
   * - ``--group-add``
     - 
     - 参加する追加グループを指定
   * - ``--health-cmd``
     - 
     - 正常性を確認するために実行するコマンド
   * - ``--health-interval``
     - 
     - 確認を実行する間隔（ ms|s|m|h）（デフォルト 0s）
   * - ``--health-retries``
     - 
     - 障害と報告するために必要な、失敗を繰り返す回数
   * - ``--health-start-period``
     - 
     - 【API 1.29+】 正常性確認をカウントダウン開始するまで、コンテナ初期化まで待つ期間を指定（ms|s|m|h）（デフォルト 0s）
   * - ``--health-timeout``
     - 
     - 実行の確認を許容する最長時間（ms|s|m|h）（デフォルト 0s）
   * - ``--help``
     - 
     - 使い方を表示
   * - ``--hostname`` , ``-h``
     - 
     - コンテナのホスト名
   * - ``--init``
     - 
     - 【API 1.25+】コンテナ内で :ruby:`初回のプロセス <init>` として実行し、シグナルを転送し、プロセスに渡す
   * - ``--interactive`` , ``-i``
     - 
     - アタッチしていなくても、標準入力を開き続ける
   * - ``--io-maxbandwidth``
     - 
     - システム・デバイスの IO 帯域に対する上限を指定（Windowsのみ）
   * - ``--io-maxiops``
     - 
     - システム・ドライブの最大 IO/秒に対する上限を指定（Windowsのみ）
   * - ``--ip``
     - 
     - IPv4 アドレス（例：172.30.100.104）
   * - ``--ipv6``
     - 
     - IPv6 アドレス（例：2001:db8::33）
   * - ``--ipc``
     - 
     - 使用する IPC 名前空間
   * - ``--isolation``
     - 
     - コンテナ分離（隔離）技術
   * - ``--kernel-memory``
     - 
     - カーネル・メモリ上限
   * - ``--label`` , ``-l``
     - 
     - コンテナにメタデータを指定
   * - ``--label-file``
     - 
     - 行ごとにラベルを記述したファイルを読み込み
   * - ``--link``
     - 
     - 他のコンテナへのリンクを追加
   * - ``--link-local-ip``
     - 
     - コンテナとリンクするローカルの IPv4/IPv6 アドレス
   * - ``--log-driver``
     - 
     - コンテナ用のログ記録ドライバを追加
   * - ``--log-opt``
     - 
     - ログドライバのオプションを指定
   * - ``--mac-address``
     - 
     - コンテナの MAC アドレス (例： 92:d0:c6:0a:29:33)
   * - ``--memory`` , ``-m``
     - 
     - メモリ上限
   * - ``--memory-reservation``
     - 
     - メモリのソフト上限
   * - ``--memory-swap``
     - 
     - 整数値の指定はメモリにスワップ値を追加。 ``-1`` は無制限スワップを有効化
   * - ``--memory-swappiness``
     - ``-1``
     - コンテナ用メモリの :ruby:`スワップ程度 <swappiness>` を調整。整数値の 0 から 100 で指定
   * - ``--mount``
     - 
     - ファイルシステムをアタッチし、コンテナにマウント
   * - ``--name``
     - 
     - コンテナに名前を割り当て
   * - ``--net``
     - 
     - コンテナをネットワークに接続
   * - ``--net-alias``
     - 
     - コンテナにネットワーク内部用のエイリアスを追加
   * - ``--network``
     - 
     - コンテナをネットワークに接続
   * - ``--network-alias``
     - 
     - コンテナにネットワーク内部用のエイリアスを追加
   * - ``--no-healthcheck``
     - 
     - あらゆるコンテナ独自の HEALTHCHECK を無効化
   * - ``--oom-kill-disable``
     - 
     - コンテナの OOM Killer を無効化するかどうか指定
   * - ``--oom-score-adj``
     - 
     - コンテナに対してホスト側の OOM 優先度を設定 ( -1000 ～ 1000 を指定)
   * - ``--pid``
     - 
     - 使用する PID 名前空間
   * - ``--pids-limit``
     - 
     - コンテナの pids 制限を調整（ -1 は無制限）
   * - ``--platform``
     - 
     - 【API 1.32+】 サーバがマルチプラットフォーム対応であれば、プラットフォームを指定
   * - ``--privileged``
     - 
     - このコンテナに対して :ruby:`拡張権限 <extended privileged>` を与える
   * - ``--publish`` , ``-p``
     - 
     - コンテナのポートをホストに公開
   * - ``--publish-all`` , ``-P``
     - 
     - 全ての出力用ポートをランダムなポートで公開
   * - ``--pull``
     - ``missing``
     - 作成する前にイメージを取得（ "always" | "missing" | "never" ）
   * - ``--read-only``
     - ``no``
     - コンテナのルートファイルシステムを :ruby:`読み込み専用 <read-only>` としてマウント
   * - ``--restart``
     - ``no``
     - コンテナ終了時に適用する再起動ポリシー
   * - ``--rm``
     - 
     - コンテナ終了時に、自動的に削除
   * - ``--runtime``
     - 
     - コンテナで使うランタイム名を指定
   * - ``--security-opt``
     - 
     - セキュリティ・オプション
   * - ``--shm-size``
     - 
     - /dev/shm の容量
   * - ``--stop-signal``
     - ``SIGTERM``
     - コンテナを停止するシグナル
   * - ``--stop-timeout``
     - 
     - 【API 1.25+】コンテナ停止までのタイムアウト（秒）を指定
   * - ``--storage-opt``
     - 
     - コンテナに対するストレージ上ージ・ドライバのオプション
   * - ``--sysctl``
     - 
     - sysctl オプション
   * - ``--tmpfs``
     - 
     - tmpfs ディレクトリをムント
   * - ``--tty`` , ``-t``
     - 
     - :ruby:`疑似 <pseudo>` TTY を割り当て
   * - ``--ulimit``
     - 
     - ulimit オプション
   * - ``--user`` , ``-u``
     - 
     - ユーザ名または UID （format: <name|uid>[:<group|gid>]）
   * - ``--userns``
     - 
     - 使用する :ruby:`ユーザ名前空間 <user namespace>`
   * - ``--uts``
     - 
     - 使用する UTS 名前空間
   * - ``--volume`` , ``-v``
     - 
     - バインドマウントするボリューム
   * - ``--volume-driver``
     - 
     - コンテナに対するオプションのボリュームドライバを指定
   * - ``--volumes-from``
     - 
     - 指定したコンテナからボリュームをマウント
   * - ``--workdir`` , ``-w``
     - 
     - コンテナ内の作業ディレクトリ


.. Examples
.. _docker_create-examples:

使用例
==========

.. Create and start a container

.. _docker_craete-create-and-start-a-container:

コンテナの作成と起動
--------------------

.. code-block:: bash
   :emphasize-lines: 1, 4

   $ docker create -t -i fedora bash
   6d8af538ec541dd581ebc2a24153a28329acb5268abe5ef868c1f1a261221752
   
   $ docker start -a -i 6d8af538ec5
   bash-4.2#

.. Initialize volumes

.. _docker_create-initialize-volumes:

ボリュームの初期化
--------------------

.. As of v1.4.0 container volumes are initialized during the docker create phase (i.e., docker run too). For example, this allows you to create the data volume container, and then use it from another container:

バージョン 1.4.0 以降では、 ``docker create`` の段階で（ ``docker run`` も同様 ）コンテナのボリュームを初期化します。これにより、例えば  ``date`` ボリューム（の名前を持つ）コンテナを :ruby:`作成 <create>` すると、他のコンテナからもボリュームが利用可能になります。

.. code-block:: bash

   $ docker create -v /data --name data ubuntu
   240633dfbb98128fa77473d3d9018f6123b99c454b3251427ae190a7d951ad57
   
   $ docker run --rm --volumes-from data ubuntu ls -la /data
   total 8
   drwxr-xr-x  2 root root 4096 Dec  5 04:10 .
   drwxr-xr-x 48 root root 4096 Dec  5 04:11 ..

.. Similarly, create a host directory bind mounted volume container, which can then be used from the subsequent container:

同様に、 ホスト側のディレクトリを :ruby:`バインド <bind>` するボリューム・コンテナを作成した後は、以降に処理するコンテナからも（bind マウントしたホスト側のディレクトリが）利用可能になります。

.. code-block:: bash

   $ docker create -v /home/docker:/docker --name docker ubuntu
   9aa88c08f319cd1e4515c3c46b0de7cc9aa75e878357b1e96f91e2c773029f03
   
   $ docker run --rm --volumes-from docker ubuntu ls -la /docker
   total 20
   drwxr-sr-x  5 1000 staff  180 Dec  5 04:00 .
   drwxr-xr-x 48 root root  4096 Dec  5 04:13 ..
   -rw-rw-r--  1 1000 staff 3833 Dec  5 04:01 .ash_history
   -rw-r--r--  1 1000 staff  446 Nov 28 11:51 .ashrc
   -rw-r--r--  1 1000 staff   25 Dec  5 04:00 .gitconfig
   drwxr-sr-x  3 1000 staff   60 Dec  1 03:28 .local
   -rw-r--r--  1 1000 staff  920 Nov 28 11:51 .profile
   drwx--S---  2 1000 staff  460 Dec  5 00:51 .ssh
   drwxr-xr-x 32 1000 staff 1140 Dec  5 04:01 docker

.. Set storage driver options per container.

コンテナごとにストレージ・ドライバの指定するには、次のように実行します。

.. code-block:: bash

   $ docker create -it --storage-opt size=120G fedora /bin/bash

.. This (size) will allow to set the container rootfs size to 120G at creation time. This option is only available for the devicemapper, btrfs, overlay2, windowsfilter and zfs graph drivers. For the devicemapper, btrfs, windowsfilter and zfs graph drivers, user cannot pass a size less than the Default BaseFS Size. For the overlay2 storage driver, the size option is only available if the backing fs is xfs and mounted with the pquota mount option. Under these conditions, user can pass any size less than the backing fs size.

この size（容量）とは、コンテナのルート・ファイルシステムの容量を作成時に 120GB と指定しています。このオプションを指定できるのは ``devicemapper`` 、 ``brtfs`` 、 ``overlay2`` 、 ``windowsfilter`` 、 ``zfs`` の各 :ruby:`グラフ・ドライバ <graph driver>` を使う時のみです。 ``devicemapper`` 、 ``brtfs`` 、 ``overlay2`` 、 ``windowsfilter`` 、 ``zfs`` の各 :ruby:`グラフ・ドライバ <graph driver>` では、ユーザはデフォルトの BaseFS 容量をよりも小さな値を指定できません。 ``overlay2`` ストレージ上ージ・ドライバでは、バックエンドで使用するファイルシステムが ``xfs`` で、かつ、 ``pquota`` マウントオプションでマウント指定している場合のみ、size オプションを指定できます。

.. Specify isolation technology for container (--isolation)

.. _docker_create-specify-isolation-technology-for-container:

コンテナの分離技術を指定（--isolation）
----------------------------------------

.. This option is useful in situations where you are running Docker containers on Windows. The --isolation=<value> option sets a container's isolation technology. On Linux, the only supported is the default option which uses Linux namespaces. On Microsoft Windows, you can specify these values:

このオプションは Docker コンテナを Window 上で使う状況で役立ちます。 ``--isolation=<値>`` オプションは、コンテナの分離技術を指定します。 Linux 上では、サポートしているオプションは Linux 名前空間を使う ``default`` のみです。Microsoft Windows 上では、以下の値を指定できます。

.. Value 	Description
   default 	Use the value specified by the Docker daemon's --exec-opt . If the daemon does not specify an isolation technology, Microsoft Windows uses process as its default value if the
   daemon is running on Windows server, or hyperv if running on Windows client. 	
   process 	Namespace isolation only.
   hyperv 	Hyper-V hypervisor partition-based isolation.

.. list-table::
   :header-rows: 1
   
   * - 値
     - 説明
   * - ``default``
     - Docker デーモンの ``--exec-opt`` で指定した値を使います。 ``daemon`` に分離技術を指定しなければ、Microsoft Windows は Windows Server が動いていれば ``process`` を使います。あるいは Windows クライアントの場合は ``hyperv`` を使います。
   * - デーモンが Windows server 上で実行中か、Windows クライアントが ``hyperv`` で動作中
     - 
   * - ``process``
     - 名前空間の分離のみです。
   * - ``hyperv``
     - Hyper-V ハイパーバイザのパーティションをベースとした分離です。

.. Specifying the --isolation flag without a value is the same as setting --isolation="default".

``--isolation`` フラグに値を指定しなければ、 ``--isolation="default"``  を指定したのと同じです。

.. Dealing with dynamically created devices (--device-cgroup-rule)

.. _docker_create-Dealing-with-dynamically-created-devices:

デバイスを動的に扱うには（ --device-cgroup-rule ）
------------------------------------------------------------

.. Devices available to a container are assigned at creation time. The assigned devices will both be added to the cgroup.allow file and created into the container once it is run. This poses a problem when a new device needs to be added to running container.

デバイスはコンテナの作成時に割り当て可能です。このデバイス割り当ては、コンテナ実行時に一度だけ作成される cgroup.allow ファイルへの追加でも可能です。これにより、実行中のコンテナに対して新しいデバイスを追加する時に、課題が発生します。

.. One of the solutions is to add a more permissive rule to a container allowing it access to a wider range of devices. For example, supposing our container needs access to a character device with major 42 and any number of minor number (added as new devices appear), the following rule would be added:

解決法の1つは、コンテナが広範囲のデバイスに対してアクセスできないように、より厳密なルールを追加します。たとえば、仮定としてコンテナに必要な接続とは、キャラクタ・デバイスのメジャー ``42`` と、その他のマイナー・ナンバー（新しいデバイスが追加されると出現）とするには、次のようにしてルールを適用します。

.. code-block:: bash

   $ docker create --device-cgroup-rule='c 42:* rmw' -name my-container my-image

.. Then, a user could ask udev to execute a script that would docker exec my-container mknod newDevX c 42 <minor> the required device when it is added.

その後、必要なデバイスを追加した後で、ユーザは ``udev`` に対して探すよう、 ``docker exec my-container mknod newDevX c 42 <minor>`` のような命令を実行できます。

.. NOTE: initially present devices still need to be explicitly added to the create/run command

.. note::

   はじめから存在しているデバイスは、create や run コマンドの実行時に、（デバイスの）追加を明示する必要があります。


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker create
      https://docs.docker.com/engine/reference/commandline/create/



