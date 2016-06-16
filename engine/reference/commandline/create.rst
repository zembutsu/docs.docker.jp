.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/create/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/create.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/create.md
.. check date: 2016/06/14
.. Commits on May 22, 2016 ef2db56bcf73b3962548a474bbd4469d26f2c655
.. -------------------------------------------------------------------

.. create

=======================================
create
=======================================

.. Creates a new container.

新しいコンテナを作成します。

.. code-block:: bash

   使い方: docker create [オプション] イメージ [コマンド] [引数...]
   
   新しいコンテナを作成
   
     -a, --attach=[]               STDIN、STDOUT、STDERR にアタッチする
     --add-host=[]                 ホストから IP アドレスのマッピングをカスタマイズして追加 (host:ip)
     --blkio-weight=0              ブロック IO ウエイト (相対ウエイト)
     --blkio-weight-device=[]      ブロック IO ウエイト (相対デバイス・ウエイト。書式： `デバイス名:ウエイト`)
     --cpu-shares=0                CPU 共有 (相対ウエイト)
     --cap-add=[]                  Linux ケーパビリティの追加
     --cap-drop=[]                 Linux ケーパビリティの削除
     --cgroup-parent=""            コンテナ用のオプション親 cgroup を指定
     --cidfile=""                  コンテナ ID をファイルに書き出し
     --cpu-period=0                CPU CFS (Completely Fair Scheduler) ペイロードの制限
     --cpu-quota=0                 CPU CFS (Completely Fair Scheduler) クォータの制限
     --cpuset-cpus=""              実行を許可する CPU (0-3, 0,1)
     --cpuset-mems=""              実行を許可するメモリ必要量 (0-3, 0,1)
     --device=[]                   ホスト・デバイスをコンテナに追加
     --device-read-bps=[]          デバイスからの読み込みレート (バイト/秒) を制限
     --device-read-iops=[]         デバイスからの読み込みレート (IO/秒) を制限
     --device-write-bps=[]         デバイスへの書き込みレート (バイト/秒) を制限 (例: --device-write-bps=/dev/sda:1mb)
     --device-write-iops=[]        デバイスへの書き込みレート (IO/秒) を制限 (例: --device-write-iops=/dev/sda:1000)
     --disable-content-trust=true  イメージの認証をスキップ
     --dns=[]                      カスタム DNS サーバの指定
     --dns-opt=[]                  カスタム DNS オプションの指定
     --dns-search=[]               カスタム DNS 検索ドメインの指定
     -e, --env=[]                  環境変数を指定
     --entrypoint=""               イメージのデフォルト ENTRYPOINT を上書き
     --env-file=[]                 ファイルから環境変数を読み込み
     --expose=[]                   ポートまたはポート範囲を露出
     --group-add=[]                参加するグループを追加
     -h, --hostname=""             コンテナのホスト名
     --help                        使い方の表示
     -i, --interactive             アタッチしていなくても STDIN を開き続ける
     --ip=""                       コンテナの IPv4 アドレス (例: 172.30.100.104)
     --ip6=""                      コンテナの IPv6 アドレス (例: 2001:db8::33)
     --ipc=""                      使用する IPC 名前空間
     --isolation=""                コンテナの分離（独立）技術
     --kernel-memory=""            Kernel メモリ上限
     -l, --label=[]                コンテナにメタデータを指定 (例: --label=com.example.key=value)
     --label-file=[]               行ごとにラベルを記述したファイルを読み込み
     --link=[]                     他のコンテナへのリンクを追加
     --log-driver=""               コンテナ用のログ記録ドライバを追加
     --log-opt=[]                  ログドライバのオプションを指定
     -m, --memory=""               メモリ上限
     --mac-address=""              コンテナの MAC アドレス (例： 92:d0:c6:0a:29:33)
     --memory-reservation=""       メモリのソフト上限
     --memory-swap=""              整数値の指定はメモリにスワップ値を追加。-1は無制限スワップを有効化
     --memory-swappiness=""        コンテナ用メモリのスワップ程度を調整。整数値の 0 から 100 で指定
     --name=""                     コンテナに名前を割り当て
     --net="bridge"   : コンテナをネットワークに接続
                                   'bridge': docker ブリッジ上でコンテナ用に新しいネットワーク・スタックを作成
                                   'none': コンテナにネットワーク機能を付けない
                                   'container:<name|id>': 他のコンテナ用ネットワーク・スタックを再利用
                                   'host': コンテナ内でホスト側ネットワーク・スタックを使用
                                   'NETWORK': 「docker network create」コマンドでユーザ作成したネットワークを使用
     --net-alias=[]                コンテナにネットワーク内部用のエイリアスを追加
     --oom-kill-disable            コンテナの OOM Killer を無効化するかどうか指定
     --oom-score-adj=0             コンテナに対してホスト側の OOM 優先度を設定 ( -1000 ～ 1000 を指定)
     -P, --publish-all             全ての露出ポートをランダムならポートに公開
     -p, --publish=[]              コンテナのポートをホスト側に公開
     --pid=""                      使用する PID 名前空間
     --pids-limit=-1                コンテナの pids 制限を調整 (kernel 4.3 以上は -1 で無制限に設定)
     --privileged                  このコンテナに対して拡張権限を与える
     --read-only                   コンテナのルート・ファイルシステムを読み込み専用としてマウント
     --restart="no"                再起動ポリシー (no, on-failure[:max-retry], always, unless-stopped)
     --security-opt=[]             セキュリティ・オプション
     --stop-signal="SIGTERM"       コンテナの停止シグナル
     --shm-size=[]                 `/dev/shm` のサイズ。書式は `<数値><単位>`. `数値` は必ず `0` より大きい。単位はオプションで `b` (bytes)、 `k` (kilobytes)、 `m` (megabytes)、 `g` (gigabytes) を指定可能。単位を指定しなければ、システムは bytes を使う。数値を指定しなければ、システムは `64m` を使う
     -t, --tty                     疑似ターミナル (pseudo-TTY) を割り当て
     -u, --user=""                 ユーザ名または UID
     --userns=""                   コンテナのユーザ名前空間
                                   'host': Docker ホストで使うユーザ名前空間
                                   '': Docker デーモンのユーザ名前空間を指定するには `--userns-remap` オプションを使う
     --ulimit=[]                   Ulimit オプション
     --uts=""                      使用する UTS 名前空間
     -v, --volume=[ホスト側ソース:]コンテナ側送信先[:<オプション>]
                                   ボリュームを拘束マウント。カンマ区切りで指定
                                   `オプション` は [rw|ro], [z|Z], [[r]shared|[r]slave|[r]private], [nocopy]
                                   'ホスト側ソース' は絶対パスまたは名前の値
     --volume-driver=""            コンテナのボリューム・ドライバ
     --volumes-from=[]             指定したコンテナからボリュームをマウント
     -w, --workdir=""              コンテナ内の作業用ディレクトリを指定

.. The docker create command creates a writeable container layer over the specified image and prepares it for running the specified command. The container ID is then printed to STDOUT. This is similar to docker run -d except the container is never started. You can then use the docker start <container_id> command to start the container at any point.

``docker create`` コマンドは、特定のイメージ上に書き込み可能なコンテナ・レイヤ（層）を作成し、測定のコマンドを実行する準備をします。それから、コンテナ ID を ``STDOUT`` （標準出力）に表示します。これは開始したことが無いコンテナに対して ``docker run -d`` する時も同様です。それから、 ``docker start <コンテナID>`` コマンドを使って、いつてもコンテナを実行できます。

.. This is useful when you want to set up a container configuration ahead of time so that it is ready to start when you need it. The initial status of the new container is created.

コンテナが必要な時に直ちに実行できるよう、事前に設定を済ませて使えるように準備したい場合に役立ちます。新しいコンテナ作成時の初期状態を指定しました。

.. Please see the run command section and the Docker run reference for more details.

より詳細に関しては :doc:`run </engine/reference/commandline/run>` セクションと :doc:`Docker run リファレンス </engine/reference/run>` をご覧ください。

.. Examples

.. _create-examples:

例
==========

.. code-block:: bash

   $ docker create -t -i fedora bash
   6d8af538ec541dd581ebc2a24153a28329acb5268abe5ef868c1f1a261221752
   $ docker start -a -i 6d8af538ec5
   bash-4.2#

.. As of v1.4.0 container volumes are initialized during the docker create phase (i.e., docker run too). For example, this allows you to create the data volume container, and then use it from another container:

バージョン 1.4.0 以降では、 ``docker create`` の段階で（ ``docker run`` も同様 ）コンテナのボリュームが初期化されます。例えば、 ``データ`` ボリュームコンテナを  ``create``  したら、他のコンテナからも利用可能になります。

.. code-block:: bash

   $ docker create -v /data --name data ubuntu
   240633dfbb98128fa77473d3d9018f6123b99c454b3251427ae190a7d951ad57
   $ docker run --rm --volumes-from data ubuntu ls -la /data
   total 8
   drwxr-xr-x  2 root root 4096 Dec  5 04:10 .
   drwxr-xr-x 48 root root 4096 Dec  5 04:11 ..

.. Similarly, create a host directory bind mounted volume container, which can then be used from the subsequent container:

同様に、 ホスト側のディレクトリをバインドするボリューム・コンテナを作成したら、次に処理するコンテナからも利用可能になります。

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

コンテナごとにストレージ・ドライバを指定します。

.. code-block:: bash

   $ docker create -it --storage-opt size=120G fedora /bin/bash

.. This (size) will allow to set the container rootfs size to 120G at creation time. User cannot pass a size less than the Default BaseFS Size. 

この容量（size）はコンテナのルート・ファイルシステムの容量を作成時に 120GB と指定しています。ユーザはデフォルトのベース・ファイルシステムより小さな容量を指定できません。

.. Specify isolation technology for container (--isolation)

.. _specify-isolation-technology-for-container:

コンテナの分離技術を指定（--isolation）
----------------------------------------

.. This option is useful in situations where you are running Docker containers on Windows. The --isolation=<value> option sets a container's isolation technology. On Linux, the only supported is the default option which uses Linux namespaces. On Microsoft Windows, you can specify these values:

このオプションは Docker コンテナを Window 上で使う状況で役立ちます。 ``--isolation=<値>`` オプションはコンテナの分離技術を指定します。 Linux 上では、サポートしているオプションは Linux 名前空間を使う ``default`` のみです。Microsoft Windows 上では、以下の値を指定できます。

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
   * - ``process``
     - 名前空間の分離のみです。
   * - ``hyperv``
     - Hyper-V ハイパーバイザのパーティションをベースとした分離です。

.. Specifying the --isolation flag without a value is the same as setting --isolation="default".

``--isolation`` フラグに値を指定しなければ、 ``--isolation="default"``  を指定したのと同じです。

.. seealso:: 

   Quickstart Docker Engine
      https://docs.docker.com/engine/reference/commandline/

