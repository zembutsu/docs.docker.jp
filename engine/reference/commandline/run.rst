.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/run/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/run.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_run.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker run

=======================================
docker run
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_run-description:

説明
==========

.. Run a command in a new container

新しいコンテナでコマンドを :ruby:`実行 <run>` します。

.. _docker_run-usage:

使い方
==========

.. code-block:: bash

   $ docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

.. Extended description
.. _docker_run-extended-description:

補足説明
==========

.. The docker run command first creates a writeable container layer over the specified image, and then starts it using the specified command. That is, docker run is equivalent to the API /containers/create then /containers/(id)/start. A stopped container can be restarted with all its previous changes intact using docker start. See docker ps -a to view a list of all containers.

``docker run`` コマンドは、まず指定されたイメージ上に書き込み可能なコンテナ・レイヤを ``create`` （作成）します。それから、指定されたコマンドを使って ``start`` （開始）します。この ``docker run`` は、 API の ``/containers/create`` の後で ``/containers/(id)/start`` を実行するのと同じです。以前に使っていたコンテナは ``docker start`` で再起動できます。全てのコンテナを表示するには ``docker ps -a`` を使います。

.. The docker run command can be used in combination with docker commit to change the command that a container runs. There is additional detailed information about docker run in the Docker run reference.

``docker run`` コマンドは、 :doc:`コンテナの内容を確定するため <commit>` に、 ``docker commit`` コマンドと連携して使えます。

.. For information on connecting a container to a network, see the “Docker network overview“.

コンテナをネットワークで接続する詳細については、 :doc:`Docker ネットワーク概要 </engine/userguide/networking/index>` をご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_run-examples>` をご覧ください。

.. _docker_run-options:

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
   * - ``--detach`` , ``-d``
     - 
     - デタッチド・モード：バックグラウンドでコマンドを実行
   * - ``--detach-keys``
     - 
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
   * - ``--sig-proxy``
     - ``true``
     - 受信したシグナルをプロセスに :ruby:`中継 <proxy>`
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
.. _docker_run-examples:

使用例
==========

.. Assign name and allocate pseudo-TTY (--name, -it)
.. _docker_run-assign-name-and-allocalte-pseudo-tty:

名前と: ruby:疑似 ターミナル <pseudo-TTY>` の割り当て（--name、-it）
----------------------------------------------------------------------

.. code-block:: bash

   $ docker run --name test -it debian
   root@d6c0fe130dba:/# exit 13
   $ echo $?
   13
   $ docker ps -a | grep test
   d6c0fe130dba        debian:7            "/bin/bash"         26 seconds ago      Exited (13) 17 seconds ago                         test

.. This example runs a container named test using the debian:latest image. The -it instructs Docker to allocate a pseudo-TTY connected to the container’s stdin; creating an interactive bash shell in the container. In the example, the bash shell is quit by entering exit 13. This exit code is passed on to the caller of docker run, and is recorded in the test container’s metadata.

この例は ``debian:latest`` イメージを使い、 ``test`` という名称のコンテナを実行します。 ``-it`` は疑似 TTY（pseudo-TTY）をコンテナの標準入力に接続するよう、 Docker に対して命令します。つまり、コンテナ内でインタラクティブな ``bash`` シェルを作成します。例の中で、 ``bash`` シェルを終了コード ``13`` で終了しています。この終了コードは ``docker run`` を呼び出したもの（docker）にも送られ、 ``test`` コンテナのメタデータに記録されます。

.. Capture container ID (--cidfile)
.. _docker_run-capture-container-id---cidfile:

コンテナ ID の取得（--cidfile）
----------------------------------------

.. code-block:: bash

   $ docker run --cidfile /tmp/docker_test.cid ubuntu echo "test"

.. This will create a container and print test to the console. The cidfile flag makes Docker attempt to create a new file and write the container ID to it. If the file exists already, Docker will return an error. Docker will close this file when docker run exits.

これはコンテナを作成し、コンソール上に ``test`` を表示します。 ``cidfile`` フラグは Docker に新しいファイルを作成させ、そこにコンテナ ID を書かせるものです。もしファイルが既に存在している場合、Docker はエラーを返します。 ``docker run`` を終了したら、Docker はこのファイルを閉じます。

.. Full container capabilities (--privileged)
.. _docker_run-full-container-capabilities:

コンテナのケーパビリティ（--privileged）
----------------------------------------

.. code-block:: bash

   $ docker run -t -i --rm ubuntu bash
   root@bc338942ef20:/# mount -t tmpfs none /mnt
   mount: permission denied

.. This will not work, because by default, most potentially dangerous kernel capabilities are dropped; including cap_sys_admin (which is required to mount filesystems). However, the --privileged flag will allow it to run:

これは動作 *しません*  。デフォルトでは、カーネルに対して潜在的に危険になりうる処理を破棄します。これには ``cap_sys_admin`` も含まれます（ファイルシステムのマウントに必要なものです）。しかしながら、 ``--privileged`` フラグがあれば、実行できるようになります。

.. code-block:: bash

   $ docker run -t -i --privileged ubuntu bash
   root@50e3f57e16e6:/# mount -t tmpfs none /mnt
   root@50e3f57e16e6:/# df -h
   Filesystem      Size  Used Avail Use% Mounted on
   none            1.9G     0  1.9G   0% /mnt

.. The --privileged flag gives all capabilities to the container, and it also lifts all the limitations enforced by the device cgroup controller. In other words, the container can then do almost everything that the host can do. This flag exists to allow special use-cases, like running Docker within Docker.

``--privileged`` フラグはコンテナに対して *全ての* 能力を与えます。また、そのために ``device`` cgroup コントローラの制限を昇格します。言い換えますと、コンテナはホスト上であらゆる処理が可能となります。このフラグが存在する時、 Docker の中で Docker を動かすといった特別な使い方ができます。

.. Set working directory (-w)
.. _docker_run-set-working-directory:

:ruby:`作業ディレクトリ <working directory>` を指定（-w）
-----------------------------------------------------------

.. code-block:: bash

   $ docker  run -w /path/to/dir/ -i -t  ubuntu pwd

.. The -w lets the command being executed inside directory given, here /path/to/dir/. If the path does not exists it is created inside the container.

``-w`` は、指定したディレクトリの中でコマンドを実行します。この例では ``/path/to/dir`` で実行します。コンテナ内にパスが存在しなければ、作成されます。

.. Set storage driver options per container
.. _docker_run-set-storage-driver-options-per-container:

コンテナごとにストレージ・オプションを指定
--------------------------------------------------

.. code-block:: bash

   $ docker create -it --storage-opt size=120G fedora /bin/bash

.. This (size) will allow to set the container rootfs size to 120G at creation time. This option is only available for the devicemapper, btrfs, overlay2, windowsfilter and zfs graph drivers. For the devicemapper, btrfs, windowsfilter and zfs graph drivers, user cannot pass a size less than the Default BaseFS Size. For the overlay2 storage driver, the size option is only available if the backing fs is xfs and mounted with the pquota mount option. Under these conditions, user can pass any size less than the backing fs size.

この size（容量）とは、コンテナのルート・ファイルシステムの容量を作成時に 120GB と指定しています。このオプションを指定できるのは ``devicemapper`` 、 ``brtfs`` 、 ``overlay2`` 、 ``windowsfilter`` 、 ``zfs`` の各 :ruby:`グラフ・ドライバ <graph driver>` を使う時のみです。 ``devicemapper`` 、 ``brtfs`` 、 ``overlay2`` 、 ``windowsfilter`` 、 ``zfs`` の各 :ruby:`グラフ・ドライバ <graph driver>` では、ユーザはデフォルトの BaseFS 容量をよりも小さな値を指定できません。 ``overlay2`` ストレージ上ージ・ドライバでは、バックエンドで使用するファイルシステムが ``xfs`` で、かつ、 ``pquota`` マウントオプションでマウント指定している場合のみ、size オプションを指定できます。

.. Mount tmpfs (--tmpfs)
.. _docker_run-mount-tmpfs:

tmpfs のマウント（--tmpfs）
------------------------------

.. code-block:: bash

   $ docker run -d --tmpfs /run:rw,noexec,nosuid,size=65536k my_image

.. The --tmpfs flag mounts an empty tmpfs into the container with the rw, noexec, nosuid, size=65536k options.

``--tmpfs`` フラグはコンテナに対して空の tmfps をマウントします。この時、オプション ``rw`` 、 ``noexec`` 、``nosuid`` 、 ``size=65536k`` オプションを指定しています。

.. Mount volume (-v, --read-only)
.. _docker_run-mount-volume:

ボリュームのマウント（-v, --read-only）
----------------------------------------

.. code-block:: bash

   $ docker  run  -v `pwd`:`pwd` -w `pwd` -i -t  ubuntu pwd

.. The -v flag mounts the current working directory into the container. The -w lets the command being executed inside the current working directory, by changing into the directory to the value returned by pwd. So this combination executes the command using the container, but inside the current working directory.

``-v`` フラグは現在の作業ディレクトリをコンテナ内にマウントします。 ``-w`` によって、コマンドは現在の作業用ディレクトリの中で実行されます。ディレクトリとは、 ``pwd`` を実行して得られるディレクトリが該当します。このコマンドを組み合わせててコンテナを実行しても、現在の作業ディレクトリの中で実行されるのです。

.. code-block:: bash

   $ docker run -v /doesnt/exist:/foo -w /foo -i -t ubuntu bash

.. When the host directory of a bind-mounted volume doesn’t exist, Docker will automatically create this directory on the host for you. In the example above, Docker will create the /doesnt/exist folder before starting your container.

ボリュームとしてマウントするホスト側のディレクトリが存在しなければ、Docker は自動的にホスト上にディレクトリを作成します。先ほどの例では、Docker はコンテナ起動前に ``/doesnt/exit`` ディレクトリを作成します。

.. code-block:: bash

   $ docker run --read-only -v /icanwrite busybox touch /icanwrite here

.. Volumes can be used in combination with --read-only to control where a container writes files. The --read-only flag mounts the container’s root filesystem as read only prohibiting writes to locations other than the specified volumes for the container.

ボリュームに ``--read-only`` を指定して使うことで、コンテナの書き込み可能なファイルを制御できます。 ``--read-only`` フラグはコンテナのルート・ファイルシステムを読み込み専用としてマウントし、コンテナで指定したボリューム以外での書き込みを禁止します。

.. code-block:: bash

   $ docker run -t -i -v /var/run/docker.sock:/var/run/docker.sock -v /path/to/static-docker-binary:/usr/bin/docker busybox sh

.. By bind-mounting the docker unix socket and statically linked docker binary (refer to get the linux binary), you give the container the full access to create and manipulate the host’s Docker daemon.

Docker Unix ソケットと docker バイナリ（ https://get.docker.com から入手）に対するマウントにより、コンテナはホスト側の Docker デーモンに対して作成や各種操作といった完全アクセスをもたらします。

.. On Windows, the paths must be specified using Windows-style semantics.

Windows では、Windows 方式の記法を使ってパスを指定する必要があります。

.. code-block:: bash

   PS C:\> docker run -v c:\foo:c:\dest microsoft/nanoserver cmd /s /c type c:\dest\somefile.txt
   Contents of file
   
   PS C:\> docker run -v c:\foo:d: microsoft/nanoserver cmd /s /c type d:\somefile.txt
   Contents of file

.. The following examples will fail when using Windows-based containers, as the destination of a volume or bind mount inside the container must be one of: a non-existing or empty directory; or a drive other than C:. Further, the source of a bind mount must be a local directory, not a file.

以下の例は、 Windows ベースのコンテナを使おうとしますが、失敗します。コンテナ内へのボリュームのマウント先やバインド・マウントは、存在していないか、空っぽのディレクトリの必要があります。また、C: ドライブの必要があります。さらに、バインド・マウントの元になるのはディレクトリの必要があり、ファイルではありません。

.. code-block:: bash

   net use z: \\remotemachine\share
   docker run -v z:\foo:c:\dest ...
   docker run -v \\uncpath\to\directory:c:\dest ...
   docker run -v c:\foo\somefile.txt:c:\dest ...
   docker run -v c:\foo:c: ...
   docker run -v c:\foo:c:\existing-directory-with-contents ...

.. For in-depth information about volumes, refer to manage data in containers

ボリュームに関する詳しい情報は、 :doc:`コンテナのデータ管理 </storage/volume>` をご覧ください。

.. Add bind mounts or volumes using the --mount flag
.. _docker_run-add-bind-mounts-or-volumes-using-the---mount-flag:

``--mount`` フラグによって、ボリューム、ホスト上のディレクトリや ``tmpfs`` をコンテナ内にマウントできます。

.. The --mount flag allows you to mount volumes, host-directories and tmpfs mounts in a container.

.. The --mount flag supports most options that are supported by the -v or the --volume flag, but uses a different syntax. For in-depth information on the --mount flag, and a comparison between --volume and --mount, refer to the service create command reference.

``--mount`` フラグは ``-v`` または ``--volume`` フラグの大部分をサポートしますが、構文が異なります。 ``--mount`` フラグについてや、 ``--volume`` と ``--mount`` 間の比較は :ref:`service create コマンドリファレンス <service_create-add-bind-mounts-volumes-or-memory-filesystems>` をご覧ください。

.. Even though there is no plan to deprecate --volume, usage of --mount is recommended.

``--volume`` を非推奨にする計画はありませんが、 ``--mount`` の利用を推奨します。

.. Examples:

使用例：

.. code-block:: bash

   $ docker run --read-only --mount type=volume,target=/icanwrite busybox touch /icanwrite/here

.. code-block:: bash

   $ docker run -t -i --mount type=bind,src=/data,dst=/data busybox sh

.. Publish or expose port (-p, --expose)
.. _docker_run-publish-or-expose-port:

ポートの公開と露出（-p、--expose）
----------------------------------------

.. code-block:: bash

  $ docker run -p 127.0.0.1:80:8080 ubuntu bash

.. This binds port 8080 of the container to port 80 on 127.0.0.1 of the host machine. The Docker User Guide explains in detail how to manipulate ports in Docker.

コンテナのポート ``8080`` を ``127.0.0.1`` 上のポート ``80`` にバインド（割り当て）します。 :doc:`Docker ユーザ・ガイド </engine/userguide/networking/default_network/dockerlinks>` で Docker がどのようにポートを操作するか詳細を説明しています。

.. Note that ports which are not bound to the host (i.e., -p 80:80 instead of -p 127.0.0.1:80:80) will be accessible from the outside. This also applies if you configured UFW to block this specific port, as Docker manages his own iptables rules. Read more

ホストにバインドしていないポート（例： ``-p 127.0.0.1:80:80`` ではなく ``-p 80:80`` の場合）は、外からアクセスできるので、注意してください。また、 UFW を設定し、Docker が自身で管理する iptables ルールはそのままに、特定のポートをブロックできます。 :doc:`こちらをご覧ください </network/iptables>` 。

.. code-block:: bash

   $ docker run --expose 80 ubuntu bash

.. This exposes port 80 of the container without publishing the port to the host system’s interfaces.

これは、コンテナのポート ``80`` を露出（expose）しますが、ホストシステム側のインターフェースにはポートを公開しません。

.. Set environment variables (-e, --env, --env-file)
.. _docker_run-set-environment-variable:

環境変数の設定（-e、--env、--env-file）
----------------------------------------

.. code-block:: bash

   $ docker run -e MYVAR1 --env MYVAR2=foo --env-file ./env.list ubuntu bash

.. Use the -e, --env, and --env-file flags to set simple (non-array) environment variables in the container you’re running, or overwrite variables that are defined in the Dockerfile of the image you’re running.

``-e`` 、 ``--env`` 、 ``--env-file`` フラグを使い、シンプルに（配列ではない）環境変数を実行中のコンテナ内で指定できます。あるいは、実行中のイメージの Dockerfile 内で定義済みの環境変数を上書きします。

.. You can define the variable and its value when running the container:

コンテナの実行時に、変数と値を定義できます。

.. code-block:: bash

   $ docker run --env VAR1=value1 --env VAR2=value2 ubuntu env | grep VAR
   VAR1=value1
   VAR2=value2

.. You can also use variables that you’ve exported to your local environment:

また、ローカル環境で export した変数も使えます。

.. code-block:: bash

   export VAR1=value1
   export VAR2=value2
   
   $ docker run --env VAR1 --env VAR2 ubuntu env | grep VAR
   VAR1=value1
   VAR2=value2

.. When running the command, the Docker CLI client checks the value the variable has in your local environment and passes it to the container. If no = is provided and that variable is not exported in your local environment, the variable won’t be set in the container.

コマンドの実行時、 Docker CLI クライアントはローカル環境上の環境変数を確認し、それをコンテナに渡します。 ``=`` の指定が無い変数は、ローカル環境からエクスポートされず、コンテナ内には設定されません。

.. You can also load the environment variables from a file. This file should use the syntax <variable>=value (which sets the variable to the given value) or <variable> (which takes the value from the local environment), and # for comments.

また、ファイルからも環境変数を読み込めます。このファイルで使える構文は ``<変数>=値`` （変数に対して値を指定）か、 ``<変数>`` （ローカル環境変数から値を取得）か、コメント用の ``#`` です。

.. code-block:: bash

   $ cat env.list
   # This is a comment
   VAR1=value1
   VAR2=value2
   USER
   
   $ docker run --env-file env.list ubuntu env | grep VAR
   VAR1=value1
   VAR2=value2
   USER=denis

.. Set metadata on container (-l, --label, --label-file)
.. _docker_run-set-metadata-on-container:

メタデータをコンテナに設定（-l、--label、--label-file）
------------------------------------------------------------

.. A label is a key=value pair that applies metadata to a container. To label a container with two labels:

ラベルとは ``key=value`` のペアであり、コンテナにメタデータを提供します。コンテナに２つのラベルをラベル付けします：

.. code-block:: bash

   $ docker run -l my-label --label com.example.foo=bar ubuntu bash

.. The my-label key doesn’t specify a value so the label defaults to an empty string(""). To add multiple labels, repeat the label flag (-l or --label).

``my-label`` キーが値を指定しなければ、対象のラベルは空の文字列（ ``""`` ）がデフォルトで割り当てられます。複数のラベルを追加するには、ラベルのフラグ（ ``-l`` か ``--label`` ）を繰り返します。

.. The key=value must be unique to avoid overwriting the label value. If you specify labels with identical keys but different values, each subsequent value overwrites the previous. Docker uses the last key=value you supply.

``key=value`` はラベル値を上書きしないよう、ユニークにする必要があります。ラベルが値の違う特定のキーを指定した場合は、以前の値が新しい値に上書きされます。Docker は最新の ``key=value`` 指定を使います。

.. Use the --label-file flag to load multiple labels from a file. Delimit each label in the file with an EOL mark. The example below loads labels from a labels file in the current directory:

``--label-file`` フラグはファイルから複数のラベルを読み込みます。ラベルとしての区切りは各行の EOL マークが現れるまでです。

.. code-block:: bash

   $ docker run --label-file ./labels ubuntu bash

.. The label-file format is similar to the format for loading environment variables. (Unlike environment variables, labels are not visible to processes running inside a container.) The following example illustrates a label-file format:

label-file の書式は、環境変数の読み込み書式と似ています（環境変数との違いは、ラベルはコンテナ内で実行中のプロセスから見えません）。以下は label-file 形式の記述例です。

.. code-block:: bash

   com.example.label1="a label"
   
   # これはコメントです
   com.example.label2=another\ label
   com.example.label3

.. You can load multiple label-files by supplying multiple --label-file flags.

複数のラベル用ファイルを読み込むには、複数回 ``--label-file`` フラグを使います。

.. For additional information on working with labels, see Labels - custom metadata in Docker in the Docker User Guide.

ラベルの動作に関する詳しい情報は、Docker ユーザ・ガイドの :doc:`Label - Docker でカスタム・メタデータを使う </engine/userguide/labels-custom-metadata>` をご覧ください。

.. Connect a container to a network (--network)
.. _docker_run-connect-a-container-to-a-network:

コンテナをネットワークに接続（--network）
--------------------------------------------------

.. When you start a container use the --net flag to connect it to a network. This adds the busybox container to the my-net network.

コンテナ実行時に ``--net`` フラグを付けるとネットワークに接続します。次の例は ``busybox`` コンテナに ``my-net`` ネットワークを追加します。

.. code-block:: bash

   $ docker run -itd --network=my-net busybox

.. You can also choose the IP addresses for the container with --ip and --ip6 flags when you start the container on a user-defined network.

また、ユーザ定義ネットワーク上でコンテナを起動時、 ``--ip`` と ``--ipv6`` フラグを使い、コンテナに対して IP アドレスを割り当て可能です。

.. code-block:: bash

   $ docker run -itd --network=my-net --ip=10.10.9.75 busybox

.. If you want to add a running container to a network use the docker network connect subcommand.

実行中のコンテナに対してネットワークを追加する時は、 ``docker network connect`` サブコマンドを使います。

.. You can connect multiple containers to the same network. Once connected, the containers can communicate easily need only another container’s IP address or name. For overlay networks or custom plugins that support multi-host connectivity, containers connected to the same multi-host network but launched from different Engines can also communicate in this way.

同じネットワークに複数のコンテナを接続できます。接続したら、コンテナは別のコンテナの IP アドレスや名前で簡単に通信できるようになります。 ``overlay`` ネットワークやカスタム・プラグインは複数のホストへの接続をサポートしています。異なった Docker エンジンが起動していても、コンテナが同じマルチホスト・ネットワーク上であれば、相互に通信できます。

.. Note: Service discovery is unavailable on the default bridge network. Containers can communicate via their IP addresses by default. To communicate by name, they must be linked.

.. note::

   サービス・ディスカバリはデフォルトの bridge ネットワークで利用できません。そのため、デフォルトでは、コンテナは IP アドレスで通信します。コンテナ名で通信するには、リンクされている必要があります。

.. You can disconnect a container from a network using the docker network disconnect command.

ネットワークからコンテナを切断するには、 ``docker network disconnect`` コマンドを使います。

.. Mount volumes from container (--volumes-from)
.. _docker_run-mount-volumes-from-container:

コンテナからボリュームをマウント（--volumes-from）
--------------------------------------------------

.. code-block:: bash

   $ docker run --volumes-from 777f7dc92da7 --volumes-from ba8c0c54f0f2:ro -i -t ubuntu pwd

.. The --volumes-from flag mounts all the defined volumes from the referenced containers. Containers can be specified by repetitions of the --volumes-from argument. The container ID may be optionally suffixed with :ro or :rw to mount the volumes in read-only or read-write mode, respectively. By default, the volumes are mounted in the same mode (read write or read only) as the reference container.

``--volumes-from`` フラグは、参照するコンテナで定義されたボリュームをマウントできます。コンテナは ``--volumes-from`` 引数を何度も指定できます。コンテナ ID はオプションで末尾に ``:ro`` か ``:rw`` を指定し、読み込み専用か読み書き可能なモードを個々に指定できます。デフォルトでは、ボリュームは参照しているコンテナと同じモード（読み書き可能か読み込み専用）です。

.. Labeling systems like SELinux require that proper labels are placed on volume content mounted into a container. Without a label, the security system might prevent the processes running inside the container from using the content. By default, Docker does not change the labels set by the OS.

SELinux のようなラベリング・システムは、コンテナ内にボリューム内容をマウントするにあたり、適切なラベルを必要とします。ラベルが無ければ、対象の領域を使ったコンテナの中では、セキュリティ・システムがプロセスの実行を阻止します。デフォルトでは、Docker は OS によってセットされるラベルを変更しません。

.. To change the label in the container context, you can add either of two suffixes :z or :Z to the volume mount. These suffixes tell Docker to relabel file objects on the shared volumes. The z option tells Docker that two containers share the volume content. As a result, Docker labels the content with a shared content label. Shared volume labels allow all containers to read/write content. The Z option tells Docker to label the content with a private unshared label. Only the current container can use a private volume.

コンテナ内にあるラベルを変更するには、ボリュームのマウントに ``:z`` か ``:Z`` の２つを末尾に追加できます。これらのサフィックスは、Docker に対して共有ボリューム上のファイル・オブジェクトに対して再度ラベル付けするように伝えます。その結果、Docker は共有コンテントのラベルを使ってラベル付けします。共有ボリュームのラベルは、全てのコンテナを読み書き可能なコンテントにします。 ``Z`` オプションは Docker に対してプライベートな共有されないラベルであると伝えます。現在のコンテナのみ、プライベート・ボリュームが使えます。

.. Attach to STDIN/STDOUT/STDERR (-a)
.. _docker_run-attach-to-stdin-stdout-stderr:

STDIN・STDOUT・STDERRのアタッチ（-a）
----------------------------------------

.. The -a flag tells docker run to bind to the container’s STDIN, STDOUT or STDERR. This makes it possible to manipulate the output and input as needed.

``-a`` フラグは ``docker run`` 時にコンテナの ``STDIN`` 、 ``STDOUT`` 、 ``STDERR`` をバインドします。これにより、必要に応じて入出力を操作できるようにします。

.. code-block:: bash

   $ echo "test" | docker run -i -a stdin ubuntu cat -

.. This pipes data into a container and prints the container’s ID by attaching only to the container’s STDIN.

これはコンテナの中にデータをパイプし、コンテナ ID をコンテナの ``STDIN`` にアタッチして表示します。

.. code-block:: bash

   $ docker run -a stderr ubuntu echo test

.. This isn’t going to print anything unless there’s an error because we’ve only attached to the STDERR of the container. The container’s logs still store what’s been written to STDERR and STDOUT.

これはエラーでない限り、何も表示しません。これはコンテナの ``STDIRR`` にしかアタッチしていないためです。コンテナのログに ``STDERR`` と ``STDOUT`` が書き込まれます。

.. code-block:: bash

   $ cat somefile | docker run -i -a stdin mybuilder dobuild

.. This is how piping a file into a container could be done for a build. The container’s ID will be printed after the build is done and the build logs could be retrieved using docker logs. This is useful if you need to pipe a file or something else into a container and retrieve the container’s ID once the container has finished running.

これはファイルの内容をコンテナにパイプし、構築するものです。構築が完了するとコンテナ ID が表示され、構築ログは ``docker logs`` で取得できます。これはファイルや何かをコンテナ内にパイプし、コンテナで処理が終わるとコンテナ ID を表示するので便利です。

.. Add host device to container (--device)

.. _add-host-device-to-container:

ホスト・デバイスをコンテナに追加（--device）
--------------------------------------------------

.. code-block:: bash

   $ docker run --device=/dev/sdc:/dev/xvdc \
                --device=/dev/sdd --device=/dev/zero:/dev/nulo \
                -i -t \
                ubuntu ls -l /dev/{xvdc,sdd,nulo}   brw-rw---- 1 root disk 8, 2 Feb  9 16:05 /dev/xvdc
   
   brw-rw---- 1 root disk 8, 3 Feb  9 16:05 /dev/sdd
   crw-rw-rw- 1 root root 1, 5 Feb  9 16:05 /dev/nulo

.. It is often necessary to directly expose devices to a container. The --device option enables that. For example, a specific block storage device or loop device or audio device can be added to an otherwise unprivileged container (without the --privileged flag) and have the application directly access it.

デバイスをコンテナに直接さらす必要が度々あります。 ``--device`` オプションは、これを可能にします。例えば、特定のブロック・ストレージ・デバイス、ループ・デバイス、オーディオ・デバイスを使うにあたり、コンテナに特権を与えなくても（ ``--privileged`` フラグを使わずに ）追加でき、アプリケーションが直接使えるようになります。

.. By default, the container will be able to read, write and mknod these devices. This can be overridden using a third :rwm set of options to each --device flag:

デフォルトでは、コンテナは ``read`` 、``write`` 、 ``mknod`` を各デバイスに指定できます。各 ``--device`` フラグのオプション設定で、３つの ``:rwm`` を利用できます。コンテナが :ruby:`特権モード <privileged mode>` で動作している場合、パーミッションの指定は無視されます。

.. code-block:: bash

   $ docker run --device=/dev/sda:/dev/xvdc --rm -it ubuntu fdisk  /dev/xvdc
   
   Command (m for help): q
   $ docker run --device=/dev/sda:/dev/xvdc:r --rm -it ubuntu fdisk  /dev/xvdc
   You will not be able to write the partition table.
   
   Command (m for help): q
   
   $ docker run --device=/dev/sda:/dev/xvdc:rw -it ubuntu fdisk  /dev/xvdc
   
   Command (m for help): q
   
   $ docker run --device=/dev/sda:/dev/xvdc:m --rm -it ubuntu fdisk  /dev/xvdc
   fdisk: unable to open /dev/xvdc: Operation not permitted

..    Note: --device cannot be safely used with ephemeral devices. Block devices that may be removed should not be added to untrusted containers with --device.

.. note::

   ``--device`` は一時的に利用するデバイスでは使うべきではありません。削除できるブロックデバイスは、信頼できないコンテナに ``--device`` で追加すべきではありません。

.. For Windows, the format of the string passed to the --device option is in the form of --device=<IdType>/<Id>. Beginning with Windows Server 2019 and Windows 10 October 2018 Update, Windows only supports an IdType of class and the Id as a device interface class GUID. Refer to the table defined in the Windows container docs for a list of container-supported device interface class GUIDs.

Windows では、 ``--device`` オプションで文字を渡す形式は ``--device=<IdType>/<Id>`` です。Windows Server 2019 と Windows 10 Octover 2018 アップデート以降、Windows でサポートしている IdType は ``class `` のみで、 Id とは `デバイス インターフェーイス クラス GUID <https://docs.microsoft.com/ja-jp/windows-hardware/drivers/install/overview-of-device-interface-classes>`_ です。コンテナがサポートしているデバイスインターフェースクラス GUID の一覧は、 `Windows コンテナのドキュメント <https://docs.microsoft.com/ja-jp/virtualization/windowscontainers/deploy-containers/hardware-devices-in-containers>`_ で定義された表をご覧ください。

.. If this option is specified for a process-isolated Windows container, all devices that implement the requested device interface class GUID are made available in the container. For example, the command below makes all COM ports on the host visible in the container.

プロセスを隔離した Windows コンテナのオプションを指定する場合は、要求したデバイスインターフェースクラス GUID の全デバイスがコンテナ内で利用可能になります。たとえば、以下のコマンドは、ホスト上にある全ての COM ポートをコンテナ内で見えるようにします。

.. code-block:: bash

   PS C:\> docker run --device=class/86E0D1E0-8089-11D0-9CE4-08003E301F73 mcr.microsoft.com/windows/servercore:ltsc2019

..    Note
    The --device option is only supported on process-isolated Windows containers. This option fails if the container isolation is hyperv or when running Linux Containers on Windows (LCOW).

.. note::

   ``--device`` オプションはプロセス隔離 Windows コンテナでのみサポートしています。コンテナ隔離が ``hyperv`` や Windows 上の LInux コンテナ（LCOW）の実行時には失敗します。

.. Access an NVIDIA GPU
.. _docker_run-access-an-nvidia-gpu:
NVIDIA GPU にアクセス
------------------------------

.. The --gpus­ flag allows you to access NVIDIA GPU resources. First you need to install nvidia-container-runtime. Visit Specify a container’s resources for more information.

``--gpus`` フラグによって、NVIDIA GPU リソースにアクセス可能になります。はじめに、 `nvidia-container-runtime <https://nvidia.github.io/nvidia-container-runtime/>`_ のインストールが必要です。詳しい情報は :doc:`コンテナのリソースを指定 </config/containers/resource_constraints>` をご覧ください。

.. To use --gpus, specify which GPUs (or all) to use. If no value is provied, all available GPUs are used. The example below exposes all available GPUs.

``--gpus`` には、どの GPU （あるいは全て）を使うか指定します。値の指定がなければ、利用可能な GPU 全てを使います。以下の例は利用可能なすべての GPU を見えるようにします。

.. code-block:: bash

   $ docker run -it --rm --gpus all ubuntu nvidia-smi

.. Use the device option to specify GPUs. The example below exposes a specific GPU.

``device`` オプションを使い、 GPUS を指定します。以下の例は、特定の GPU を見えるようにします。

.. code-block:: bash

   $ docker run -it --rm --gpus device=GPU-3a23c669-1f69-c64e-cf85-44e9b07e7a2a ubuntu nvidia-smi

.. The example below exposes the first and third GPUs.

以下の例は、1番目と3番目の GPU を見えるようにします。

.. code-block:: bash

   $ docker run -it --rm --gpus device=0,2 nvidia-smi


.. Restart policies (--restart)
.. _docker_run-restart-policies:

再起動ポリシー
------------------------------

.. Use Docker’s --restart to specify a container’s restart policy. A restart policy controls whether the Docker daemon restarts a container after exit. Docker supports the following restart policies:

Docker の ``--restart`` はコンテナの *再起動ポリシー* を指定します。再起動ポリシーは、コンテナの終了後、Docker デーモンが再起動するかどうかを管理します。Docker は次の再起動ポリシーをサポートしています。

.. Policy 	Result
.. no 	Do not automatically restart the container when it exits. This is the default.
.. on-failure[:max-retries] 	Restart only if the container exits with a non-zero exit status. Optionally, limit the number of restart retries the Docker daemon attempts.
.. always 	Always restart the container regardless of the exit status. When you specify always, the Docker daemon will try to restart the container indefinitely. The container will also always start on daemon startup, regardless of the current state of the container.
.. unless-stopped 	Always restart the container regardless of the exit status, but do not start it on daemon startup if the container has been put to a stopped state before.

.. list-table::
   :header-rows: 1
   
   * -  ポリシー
     - 結果
   * - **no**
     - 終了してもコンテナを自動的に再起動しません。これがデフォルトです。
   * - **on-failure** [:最大リトライ数]
     - コンテナが 0 以外のステータスで終了すると、再起動します。オプションで Docker デーモンが何度再起動するかを指定できます。
   * - **unless-stopped**
     - 終了コードの状態に関わらず、常に再起動します。しかし、以前に停止した状態であれば、Docker デーモンの起動時にコンテナを開始しません。
   * - **always**
     - 終了コードの状態に関わらず、常に再起動します。always を指定すると、 Docker デーモンは無制限に再起動を試みます。また、現在の状況に関わらず、デーモンの起動時にもコンテナの起動を試みます。


.. code-block:: bash

   $ docker run --restart=always redis

.. This will run the redis container with a restart policy of always so that if the container exits, Docker will restart it.

これは ``redis`` コンテナを再起動ポリシー **always** で起動するものです。つまり、コンテナが終了したら Docker がコンテナを再起動します。

.. More detailed information on restart policies can be found in the Restart Policies (--restart) section of the Docker run reference page.

再起動ポリシーに関するより詳しい情報は、 :doc:`Docker run リファレンス・ページ </engine/reference/run>` の :ref:`再起動ポリシー（--restart） <restart-policies-restart>` をご覧ください。

.. Add entries to container hosts file (--add-host)
.. _docker_run-add-entries-to-container-hosts-file:

コンテナの hosts ファイルにエントリ追加（--add-host）
------------------------------------------------------------

.. You can add other hosts into a container’s /etc/hosts file by using one or more --add-host flags. This example adds a static address for a host named docker:

``--add-host`` フラグを使い、コンテナの ``/etc/hosts`` ファイルに１つもしくは複数のホストを追加できます。次の例はホスト名 ``docker`` に静的なアドレスを追加しています。

.. code-block:: bash

   $ docker run --add-host=docker:93.184.216.34 --rm -it alpine
   / # ping docker
   PING docker (93.184.216.34): 56 data bytes
   64 bytes from 93.184.216.34: seq=0 ttl=37 time=93.052 ms
   64 bytes from 93.184.216.34: seq=1 ttl=37 time=92.467 ms
   64 bytes from 93.184.216.34: seq=2 ttl=37 time=92.252 ms
   ^C
   --- docker ping statistics ---
   4 packets transmitted, 4 packets received, 0% packet loss
   round-trip min/avg/max = 92.209/92.495/93.052 ms

.. Sometimes you need to connect to the Docker host from within your container. To enable this, pass the Docker host’s IP address to the container using the --add-host flag. To find the host’s address, use the ip addr show command.

時々、コンテナ内から Docker ホストに対して接続する必要があります。接続のためには、 ``--add-host`` フラグをコンテナに使い、Docker ホストの IP アドレスを与えます。ホスト側の IP アドレスを確認するには、 ``ip addr show`` コマンドを使います。

.. The flags you pass to ip addr show depend on whether you are using IPv4 or IPv6 networking in your containers. Use the following flags for IPv4 address retrieval for a network device named eth0:

コンテナが何の IPv4 ないし IPv6 ネットワークを使っているかは、 ``ip addr show`` の結果次第です。次のフラグは、ネットワーク・デバイス ``eth0`` の IPv4 アドレスを指定します。

.. code-block:: bash

   $ HOSTIP=`ip -4 addr show scope global dev eth0 | grep inet | awk '{print \$2}' | cut -d / -f 1`
   $ docker run  --add-host=docker:${HOSTIP} --rm -it debian

.. For IPv6 use the -6 flag instead of the -4 flag. For other network devices, replace eth0 with the correct device name (for example docker0 for the bridge device).

IPv6 は ``-4`` フラグの替わりに ``-6`` を指定します。他のネットワーク・デバイスの場合は ``eth0`` を適切なデバイス名に置き換えます（例えば ``docker0`` ブリッジ・デバイス ）。

.. Set ulimits in container (--ulimit)
.. _docker_run-set-ulimits-in-container-ulimit:

コンテナ内の ulimits を指定（--ulimit）
--------------------------------------------

.. Since setting ulimit settings in a container requires extra privileges not available in the default container, you can set these using the --ulimit flag. --ulimit is specified with a soft and hard limit as such: <type>=<soft limit>[:<hard limit>], for example:

コンテナ内で ``ulimit`` 設定をするには追加特権が必要であり、デフォルトのコンテナでは指定できません。そこで ``--ulimit`` フラグを指定できます。 ``--ulimit`` はソフト・リミットとハード・リミットを指定できます。 ``<type>=<ソフト・リミット>[:<ハード・リミット>]`` の形式です。例：

.. code-block:: bash

   $ docker run --ulimit nofile=1024:1024 --rm debian sh -c "ulimit -n"
   1024

..    Note: If you do not provide a hard limit, the soft limit will be used for both values. If no ulimits are set, they will be inherited from the default ulimits set on the daemon. as option is disabled now. In other words, the following script is not supported: $ docker run -it --ulimit as=1024 fedora /bin/bash

.. note::

   ``ハード・リミット`` を指定しなければ、 ``ソフト・リミット`` が両方の値として使われます。 ``ulimits`` を指定しなければ、デーモンのデフォルト ``ulimits`` を継承します。 ``as`` オプションは無効化されました。言い換えるますと、次のようなスクリプトはサポートされていません： ``$ docker run -it --ulimit as=1024 fedora /bin/bash``

.. The values are sent to the appropriate syscall as they are set. Docker doesn’t perform any byte conversion. Take this into account when setting the values.

設定したら適切な ``syscall`` が送信されます。Docker は転送に何ら介在しません。値が設定された時のみ処理されます。

.. For nproc usage
.. _docker_run-for-nproc-usage:

``nproc`` を使うには
------------------------------

.. Be careful setting nproc with the ulimit flag as nproc is designed by Linux to set the maximum number of processes available to a user, not to a container. For example, start four containers with daemon user:

``ulimit`` フラグに ``nproc`` を設定する時とは、 ``nproc`` で Linux 利用者が利用可能な最大プロセス数をセットするものであり、コンテナに対してではないので注意してください。次の例は、 ``daemon`` ユーザとして４つのコンテナを起動します。

.. code-block:: bash

   docker run -d -u daemon --ulimit nproc=3 busybox top
   
   docker run -d -u daemon --ulimit nproc=3 busybox top
   
   docker run -d -u daemon --ulimit nproc=3 busybox top
   
   docker run -d -u daemon --ulimit nproc=3 busybox top

.. The 4th container fails and reports “[8] System error: resource temporarily unavailable” error. This fails because the caller set nproc=3 resulting in the first three containers using up the three processes quota set for the daemon user.

４番めのコンテナは失敗し、“[8] System error: resource temporarily unavailable” エラーを表示します。これが失敗するのは、実行時に ``nproc=3`` を指定したからです。３つのコンテナが起動したら、 ``daemon`` ユーザに指定されたプロセスの上限（quota）に達してしまうからです。

.. Stop container with signal (--stop-signal)
.. _docker_run-stop-container-with-signal:

コンテナをシグナルで停止
------------------------------

.. The --stop-signal flag sets the system call signal that will be sent to the container to exit. This signal can be a valid unsigned number that matches a position in the kernel’s syscall table, for instance 9, or a signal name in the format SIGNAME, for instance SIGKILL.

``--stop-signal`` フラグは、システムコールのシグナルを設定します。これは、コンテナを終了する時に送るものです。このシグナルはカーネルの syscall テーブルにある適切な数値と一致する必要があります。例えば 9 や、SIGNAME のような形式のシグナル名（例：SIGKILL）です。

.. Optional security options (--security-opt)
.. _docker_run-optional-security-options:
セキュリティ・オプションの追加（--security-opt）
-------------------------------------------------

.. On Windows, this flag can be used to specify the credentialspec option. The credentialspec must be in the format file://spec.txt or registry://keyname.

Windows では、このフラグが ``credentialspec`` オプションを指定するのに使えます。 ``credentialspec`` は ``file://spec.txt`` もしくは ``registry://keyname`` の形式にする必要があります。

.. Stop container with timeout (--stop-timeout)
.. _docker_run-stop-container-with-timeout:
コンテナ停止のタイムアウト（--stop-timeout）
--------------------------------------------------

.. The --stop-timeout flag sets the number of seconds to wait for the container to stop after sending the pre-defined (see --stop-signal) system call signal. If the container does not exit after the timeout elapses, it is forcibly killed with a SIGKILL signal.

``--stop-timeout`` フラグは、コンテナを停止するために定義済みの（ ``--stop-signal`` を参照 ）システムコール・シグナルを送った後、何秒待機するかを指定します。タイムアウトを経過してもコンテナが停止しない場合は、 ``KILLSIG`` シグナルで強制停止します。

.. If --stop-timeout is set to -1, no timeout is applied, and the daemon will wait indefinitely for the container to exit.

``--stop-timeout`` に ``-1`` を指定すると、タイムアウトは適用されず、デーモンはコンテナが終了するまで無期限に待機します。

.. The default is determined by the daemon, and is 10 seconds for Linux containers, and 30 seconds for Windows containers.

デーモンでのデフォルトは、 Linux コンテナでは 10 秒、 Windows コンテナでは 30 秒です。

.. Specify isolation technology for container (--isolation)
.. _docker_run-specify-isolation-technology-for-container-isolation:

コンテナの分離技術を指定（--isolation）
----------------------------------------

.. This option is useful in situations where you are running Docker containers on Microsoft Windows. The --isolation <value> option sets a container’s isolation technology. On Linux, the only supported is the default option which uses Linux namespaces. These two commands are equivalent on Linux:

このオプションは Docker コンテナを Microsoft Windows 上で使う状況で便利です。 ``--isolation <値>`` オプションでコンテナの分離（isolation）技術を指定します。 Linux 上では Linux 名前空間（namespaces）を使う ``default`` しかサポートしていません。Linux 上では次の２つのコマンドが同等です。

.. code-block:: bash

   $ docker run -d busybox top
   $ docker run -d --isolation default busybox top

.. On Microsoft Windows, can take any of these values:
   Value 	Description
   default 	Use the value specified by the Docker daemon’s --exec-opt . If the daemon does not specify an isolation technology, Microsoft Windows uses process as its default value.
   process 	Namespace isolation only.
   hyperv 	Hyper-V hypervisor partition-based isolation.

.. list-table:
   :header-rows: 1
   
   * - 値
     - 説明
   * - ``default``
     - Docker デーモンの ``--exec-opt`` 値を使います。分離技術に ``daemon`` を指定しなければ、Microsoft Windows はデフォルト値の ``process`` を使います。
   * - ``process``
     - 名前空間（namespace）の分離のみです。
   * - ``hyperv``
     - Hyper-V ハイパーバイザをベースとする分離です。

.. The default isolation on Windows server operating systems is process. The default isolation on Windows client operating systems is hyperv. An attempt to start a container on a client operating system older than Windows 10 1809 with --isolation process will fail.

Windows server オペレーティングシステム上のデフォルト分離は ``process`` です。Windows クライアントのオペレーティングシステム上のデフォルト分離は ``hyperv`` です。Windows 10 1809 よりも古いクライアントのオペレーティングシステム上で、 ``--isolation process`` でコンテナの起動を試みても、失敗します。

.. On Windows server, assuming the default configuration, these commands are equivalent and result in process isolation:

Windows server 上では、デフォルトの設定であれば、以下のコマンドは同等で、結果 ``process`` 分離となります。

.. code-block:: bash

   PS C:\> docker run -d microsoft/nanoserver powershell echo process
   PS C:\> docker run -d --isolation default microsoft/nanoserver powershell echo process
   PS C:\> docker run -d --isolation process microsoft/nanoserver powershell echo process

.. If you have set the --exec-opt isolation=hyperv option on the Docker daemon, or are running against a Windows client-based daemon, these commands are equivalent and result in hyperv isolation:

Docker ``daemon`` 上で ``--exec-opt isolation=hyperv`` オプションを指定するか、WIndows クライアント・ベース上で動作するデーモンの場合は、以下のコマンドは同等で、結果 ``hyperv`` 分離となります。

.. code-block:: bash

   PS C:\> docker run -d microsoft/nanoserver powershell echo hyperv
   PS C:\> docker run -d --isolation default microsoft/nanoserver powershell echo hyperv
   PS C:\> docker run -d --isolation hyperv microsoft/nanoserver powershell echo hyperv

.. Specify hard limits on memory available to containers (-m, --memory)
.. _docker_run-specify-hard-limits-on-memory-available-to-containers:
コンテナで利用可能なメモリのハードリミットを指定（-m, --memory）
----------------------------------------------------------------------

.. These parameters always set an upper limit on the memory available to the container. On Linux, this is set on the cgroup and applications in a container can query it at /sys/fs/cgroup/memory/memory.limit_in_bytes.

これらのパラメータは、コンテナが常時利用可能なメモリの上限を指定します。Linux 上では、 cgorup に設定され、コンテナ内のアプリケーションは ``/sys/fs/cgroup/memory/memory.limit_in_bytes`` で確認できます。

.. On Windows, this will affect containers differently depending on what type of isolation is used.

Windows 上では、コンテナに対する影響は、何を隔離技術で使うかに依存します。

..    With process isolation, Windows will report the full memory of the host system, not the limit to applications running inside the container

* ``process`` 分離では、Windows はホストシステム上の全メモリを報告し、コンテナ内で実行しているアプリケーションに制限できません。
   
   .. code-block:: bash
   
      PS C:\> docker run -it -m 2GB --isolation=process microsoft/nanoserver powershell Get-ComputerInfo *memory*
      CsTotalPhysicalMemory      : 17064509440
      CsPhyicallyInstalledMemory : 16777216
      OsTotalVisibleMemorySize   : 16664560
      OsFreePhysicalMemory       : 14646720
      OsTotalVirtualMemorySize   : 19154928
      OsFreeVirtualMemory        : 17197440
      OsInUseVirtualMemory       : 1957488
      OsMaxProcessMemorySize     : 137438953344

* `hyperv` 分離では、 Windows はメモリ上限を十分維持できるユーティリティ VM を作成し、コンテナを保持するために必要な最小の OS を加えます。
   
   .. code-block:: bash
   
      PS C:\> docker run -it -m 2GB --isolation=hyperv microsoft/nanoserver powershell Get-ComputerInfo *memory*
      CsTotalPhysicalMemory      : 2683355136
      CsPhyicallyInstalledMemory :
      OsTotalVisibleMemorySize   : 2620464
      OsFreePhysicalMemory       : 2306552
      OsTotalVirtualMemorySize   : 2620464
      OsFreeVirtualMemory        : 2356692
      OsInUseVirtualMemory       : 263772
      OsMaxProcessMemorySize     : 137438953344

.. Configure namespaced kernel parameters (sysctls) at runtime
.. _configure-namespaced-kernel-parameters-at-runtime:

実行時に名前空間のカーネル・パラメータ（sysctl）を設定
------------------------------------------------------------

.. The --sysctl sets namespaced kernel parameters (sysctls) in the container. For example, to turn on IP forwarding in the containers network namespace, run this command:

``--sysctl`` はコンテナ内の名前空間におけるカーネル・パラメータ（sysctl）を設定します。例えば、コンテナのネットワーク名前空間で IP 転送を有効にするには、次のようにコマンドを実行します。

.. code-block:: bash

   $ docker run --sysctl net.ipv4.ip_forward=1 someimage

..    Note: Not all sysctls are namespaced. docker does not support changing sysctls inside of a container that also modify the host system. As the kernel evolves we expect to see more sysctls become namespaced.

.. note::

   全ての sysctl が名前空間で使えるわけではありません。Docker はコンテナ内の sysctl の変更をサポートしません。つまり、コンテナ内だけでなくホスト側も変更します。カーネルが改良されれば、更に多くの sysctl を名前空間内で利用可能になると考えています。

.. Currently supported sysctls

.. _currently-supprted-sysctls:

サポート中の sysctl
^^^^^^^^^^^^^^^^^^^^

.. IPC Namespace:

``IPC 名前空間`` ：

.. kernel.msgmax, kernel.msgmnb, kernel.msgmni, kernel.sem, kernel.shmall, kernel.shmmax, kernel.shmmni, kernel.shm_rmid_forced Sysctls beginning with fs.mqueue.*

*  ``kernel.msgmax`` 、 ``kernel.msgmnb`` 、 ``kernel.msgmni`` 、 ``kernel.sem`` 、 ``kernel.shmall`` 、 ``kernel.shmmax`` 、 ``kernel.shmmni`` 、 ``kernel.shm_rmid_forced``
* ``fs.mqueue.*`` で始まる sysctl 。
* ``--ipc=host`` オプションを使う場合は、これら sysctl のオプション指定が許可されません。

.. Network Namespace: Sysctls beginning with net.*
.. If you use the --net=host option using these sysctls will not be allowed.

``ネットワーク名前空間`` ：

*  ``net.*`` で始まる sysctl
* ``--ipc=host`` オプションを使う場合は、これら sysctl のオプション指定が許可されません。


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker run
      https://docs.docker.com/engine/reference/commandline/run/
