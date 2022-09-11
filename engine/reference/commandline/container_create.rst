.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/container_create/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/container_create.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_container_create.yaml
.. check date: 2022/03/15
.. Commits on Dec 9, 2020 3ed725064445f19e836620432ba7522865002da5
.. -------------------------------------------------------------------

.. docker container create

=======================================
docker container create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _container_create-description:

説明
==========

.. Create a new container

新しいコンテナを :ruby:`作成 <create>` します。

.. _container_create-usage:

使い方
==========

.. code-block:: bash

   $ docker container create [OPTIONS] IMAGE [COMMAND] [ARG...]


.. _container_create-options:

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


.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker container attach<container_attach>`
     - ローカルの標準入出、標準出力、標準エラーのストリームに、実行中のコンテナを :ruby:`接続 <attach>`
   * - :doc:`docker container commit<container_commit>`
     - コンテナの変更から新しいイメージを作成
   * - :doc:`docker container cp<container_cp>`
     - コンテナとローカルファイルシステム間で、ファイルやフォルダを :ruby:`コピー <copy>`
   * - :doc:`docker container create<container_create>`
     - 新しいコンテナを :ruby:`作成 <create>`
   * - :doc:`docker container diff<container_diff>`
     - コンテナのファイルシステム上で、ファイルやディレクトリの変更を調査
   * - :doc:`docker container exec<container_exec>`
     - 実行中のコンテナ内でコマンドを実行
   * - :doc:`docker container export<container_export>`
     - コンテナのファイルシステムを tar アーカイブとして :ruby:`出力 <export>`
   * - :doc:`docker container inspect<container_inspect>`
     - 1つまたは複数コンテナの情報を表示
   * - :doc:`docker container kill<container_kill>`
     - 1つまたは複数の実行中コンテナを :ruby:`強制停止 <kill>`
   * - :doc:`docker container logs<container_logs>`
     - コンテナのログを取得
   * - :doc:`docker container ls<container_ls>`
     - コンテナ一覧
   * - :doc:`docker container pause<container_pause>`
     - 1つまたは複数コンテナ内の全てのプロセスを :ruby:`一時停止 <pause>`
   * - :doc:`docker container port<container_port>`
     - ポート :ruby:`割り当て <mapping>` の一覧か、特定のコンテナに対する :ruby:`割り当て <mapping>`
   * - :doc:`docker container prune<container_prune>`
     - すべての停止中のコンテナを削除
   * - :doc:`docker container rename<container_rename>`
     - コンテナの :ruby:`名前変更 <rename>`
   * - :doc:`docker container restart<container_restart>`
     - 1つまたは複数のコンテナを再起動
   * - :doc:`docker container rm<container_rm>`
     - 1つまたは複数のコンテナを :ruby:`削除 <remove>`
   * - :doc:`docker container run<container_run>`
     - 新しいコンテナでコマンドを :ruby:`実行 <run>`
   * - :doc:`docker container start<container_start>`
     - 1つまたは複数のコンテナを :ruby:`開始 <start>`
   * - :doc:`docker container stats<container_stats>`
     - コンテナのリソース使用統計情報をライブストリームで表示
   * - :doc:`docker container stop<container_stop>`
     - 1つまたは複数の実行中コンテナを :ruby:`停止 <stop>`
   * - :doc:`docker container top<container_top>`
     - コンテナで実行中のプロセスを表示
   * - :doc:`docker container unpause<container_unpause>`
     - 1つまたは複数コンテナの :ruby:`一時停止を解除 <unpause>`
   * - :doc:`docker container update<container_update>`
     - 1つまたは複数コンテナの設定を :ruby:`更新 <update>`
   * - :doc:`docker container wait<container_wait>`
     - 1つまたは複数コンテナが停止するまでブロックし、終了コードを表示

.. seealso:: 

   docker container create
      https://docs.docker.com/engine/reference/commandline/container_create/
