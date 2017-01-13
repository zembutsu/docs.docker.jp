.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/run/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/run.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/run.md
.. check date: 2016/06/16
.. Commits on Jun 15, 2016 c97fdbe3c5954b2685a8b140f595f06b09191956
.. -------------------------------------------------------------------

.. run

=======================================
run
=======================================


.. code-block:: bash

   使い方: docker run [オプション] イメージ [コマンド] [引数...]
   
   新しいコンテナを実行する命令
   
     -a, --attach=[]               STDIN、STDOUT、STDERR にアタッチする
     --add-host=[]                 ホストから IP アドレスのマッピングをカスタマイズして追加 (host:ip)
     --blkio-weight=0              ブロック IO ウエイト (相対ウエイト)
     --blkio-weight-device=[]      ブロック IO ウエイト (相対デバイス・ウエイト。書式： `デバイス名:ウエイト`)
     --cpu-shares=0                CPU 共有 (相対ウエイト)
     --cap-add=[]                  Linux ケーパビリティの追加
     --cap-drop=[]                 Linux ケーパビリティの削除
     --cgroup-parent=""            コンテナ用のオプション親 cgroup を指定
     --cidfile=""                  コンテナ ID をファイルに書き出し
     --cpu-percent=0               コンテナが実行可能な CPU 使用率のパーセントを制限。Windowsのみ
     --cpu-period=0                CPU CFS (Completely Fair Scheduler) ペイロードの制限
     --cpu-quota=0                 CPU CFS (Completely Fair Scheduler) クォータの制限
     --cpuset-cpus=""              実行を許可する CPU (0-3, 0,1)
     --cpuset-mems=""              実行を許可するメモリ必要量 (0-3, 0,1)
     -d, --detach                  コンテナをバックグラウンドで実行し、コンテナ ID を表示
     --detach-keys                 コンテナのデタッチに使うエスケープ・キー・シーケンスを設定
     --device=[]                   ホスト・デバイスをコンテナに追加
     --device-read-bps=[]          デバイスからの読み込みレート (バイト/秒) を制限 (例: --device-read-bps=/dev/sda:1mb)
     --device-read-iops=[]         デバイスからの読み込みレート (IO/秒) を制限 (例: --device-read-iops=/dev/sda:1000)
     --device-write-bps=[]         デバイスへの書き込みレート (バイト/秒) を制限  (例: --device-write-bps=/dev/sda:1mb)
     --device-write-iops=[]        デバイスへの書き込みレート (IO/秒) を制限 (例: --device-write-bps=/dev/sda:1000)
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
     -i, --interactive             コンテナの STDIN にアタッチ
     --ip=""                       コンテナの IPv4 アドレス (例: 172.30.100.104)
     --ip6=""                      コンテナの IPv6 アドレス (例: 2001:db8::33)
     --ipc=""                      使用する IPC 名前空間
     --isolation=""                コンテナの分離（独立）技術
     --kernel-memory=""            Kernel メモリ上限
     -l, --label=[]                コンテナにメタデータを指定 (例: --label=com.example.key=value)
     --label-file=[]               行ごとにラベルを記述したファイルを読み込み
     --link=[]                     他のコンテナへのリンクを追加
     --link-local-ip=[]            コンテナとリンクするローカルの IPv4/IPv6 アドレス (例: 169.254.0.77, fe80::77)
     --log-driver=""               コンテナ用のログ記録ドライバを追加
     --log-opt=[]                  ログドライバのオプションを指定
     -m, --memory=""               メモリ上限
     --mac-address=""              コンテナの MAC アドレス (例： 92:d0:c6:0a:29:33)
     --io-maxbandwidth=""          システム・デバイスの IO 帯域に対する上限を指定（Windowsのみ）。
                                   書式は `<数値><単位>`。単位はオプションで `b` (バイト/秒)、
                                   `k` (キロバイト/秒)、 `m` (メガバイト/秒)、 `g` (ギガバイト/秒)。
                                   単位を指定しなければ、システムはバイト/秒とみなす。
                                   --io-maxbandwidth と --io-maxiops は相互排他オプション
     --io-maxiops=0                システム・ドライブの最大 IO/秒に対する上限を指定 *Windowsのみ)
                                   --io-maxbandwidth と --io-maxiops は相互排他オプション
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
     --rm                          コンテナ終了時、自動的に削除
     --runtime=""                  コンテナで使うランタイム名を指定
     --shm-size=[]                 `/dev/shm` のサイズ。書式は `<数値><単位>`. `数値` は必ず `0` より大きい。単位はオプションで `b` (bytes)、 `k` (kilobytes)、 `m` (megabytes)、 `g` (gigabytes) を指定可能。単位を指定しなければ、システムは bytes を使う。数値を指定しなければ、システムは `64m` を使う
     --security-opt=[]             セキュリティ・オプション
     --sig-proxy=true              受信したシグナルをプロセスにプロキシ
     --stop-signal="SIGTERM"       コンテナの停止シグナル
     --storage-opt=[]              コンテナごとにストレージ・ドライバのオプションを指定
     --sysctl[=*[]*]]              実行時に名前空間カーネル・パラメータを調整
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


.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. The docker run command first creates a writeable container layer over the specified image, and then starts it using the specified command. That is, docker run is equivalent to the API /containers/create then /containers/(id)/start. A stopped container can be restarted with all its previous changes intact using docker start. See docker ps -a to view a list of all containers.

``docker run`` コマンドは、まず指定されたイメージ上に書き込み可能なコンテナ・レイヤを ``create`` （作成）します。それから、指定されたコマンドを使って ``start`` （開始）します。この ``docker run`` は、 API の ``/containers/create`` の後で ``/containers/(id)/start`` を実行するのと同じです。以前に使っていたコンテナは ``docker start`` で再起動できます。全てのコンテナを表示するには ``docker ps -a`` を使います。

.. The docker run command can be used in combination with docker commit to change the command that a container runs. There is additional detailed information about docker run in the Docker run reference.

``docker run`` コマンドは、 :doc:`コンテナの内容を確定するため <commit>` に、 ``docker commit`` コマンドと連携して使えます。

.. For information on connecting a container to a network, see the “Docker network overview“.

コンテナをネットワークで接続する詳細については、 :doc:`Docker ネットワーク概要 </engine/userguide/networking/index>` をご覧ください。

.. Examples

例
==========

.. Assign name and allocate pseudo-TTY (--name, -it)

.. _assign-name-and-allocalte-pseudo-tty:

名前と疑似 TTY の割り当て（--name、-it）
----------------------------------------

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

コンテナ ID の取得（--cidfile）
----------------------------------------

.. code-block:: bash

   $ docker run --cidfile /tmp/docker_test.cid ubuntu echo "test"

.. This will create a container and print test to the console. The cidfile flag makes Docker attempt to create a new file and write the container ID to it. If the file exists already, Docker will return an error. Docker will close this file when docker run exits.

これはコンテナを作成し、コンソール上に ``test`` を表示します。 ``cidfile`` フラグは Docker に新しいファイルを作成させ、そこにコンテナ ID を書かせるものです。もしファイルが既に存在している場合、Docker はエラーを返します。 ``docker run`` を終了したら、Docker はこのファイルを閉じます。

.. Full container capabilities (--privileged)

.. _full-container-capabilities:

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

.. _set-working-directory:

作業ディレクトリを指定（-w）
----------------------------------------

.. code-block:: bash

   $ docker  run -w /path/to/dir/ -i -t  ubuntu pwd

.. The -w lets the command being executed inside directory given, here /path/to/dir/. If the path does not exists it is created inside the container.

``-w`` は、指定したディレクトリの中でコマンドを実行します。この例では ``/path/to/dir`` で実行します。コンテナ内にパスが存在しなければ、作成されます。

.. Set storage driver options per container

.. _set-storage-driver-options-per-container:

コンテナごとにストレージ・オプションを指定
--------------------------------------------------

.. code-block:: bash

   $ docker create -it --storage-opt size=120G fedora /bin/bash

.. This (size) will allow to set the container rootfs size to 120G at creation time.  User cannot pass a size less than the Default BaseFS Size.

これ（容量）はコンテナの作成時にルート・ファイルシステムの容量を 120GB に指定しています。ただし、デフォルトの BaseFS 容量よりも小さく指定できません。

.. Mount tmpfs (--tmpfs)

.. _mount-tmpfs:

tmpfs のマウント（--tmpfs）
------------------------------

.. code-block:: bash

   $ docker run -d --tmpfs /run:rw,noexec,nosuid,size=65536k my_image

.. The --tmpfs flag mounts an empty tmpfs into the container with the rw, noexec, nosuid, size=65536k options.

``--tmpfs`` フラグはコンテナに対して空の tmfps をマウントします。この時、オプション ``rw`` 、 ``noexec`` 、``nosuid`` 、 ``size=65536k`` オプションを指定しています。

.. Mount volume (-v, --read-only)

.. _mount-volume:

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

.. Publish or expose port (-p, --expose)

ポートの公開と露出（-p、--expose）
----------------------------------------

.. code-block:: bash

  $ docker run -p 127.0.0.1:80:8080 ubuntu bash

.. This binds port 8080 of the container to port 80 on 127.0.0.1 of the host machine. The Docker User Guide explains in detail how to manipulate ports in Docker.

コンテナのポート ``8080`` を ``127.0.0.1`` 上のポート ``80`` にバインド（割り当て）します。 :doc:`Docker ユーザ・ガイド </engine/userguide/networking/default_network/dockerlinks>` で Docker がどのようにポートを操作するか詳細を説明しています。

.. code-block:: bash

   $ docker run --expose 80 ubuntu bash

.. This exposes port 80 of the container without publishing the port to the host system’s interfaces.

コンテナのポート ``80`` を露出（expose）しますが、ホストシステム側のインターフェースには公開しません。

.. Set environment variables (-e, --env, --env-file)

.. _set-environment-variable:

環境変数の設定（-e、--env、--env-file）
----------------------------------------

.. code-block:: bash

   $ docker run -e MYVAR1 --env MYVAR2=foo --env-file ./env.list ubuntu bash


.. This sets simple (non-array) environmental variables in the container. For illustration all three flags are shown here. Where -e, --env take an environment variable and value, or if no = is provided, then that variable's current value, set via export, is passed through (i.e. $MYVAR1 from the host is set to $MYVAR1 in the container). When no = is provided and that variable is not defined in the client's environment then that variable will be removed from the container's list of environment variables. All three flags, -e, --env and --env-file can be repeated.

これはコンテナ内におけるシンプルな（配列ではない）環境変数を設定します。この３つのフラグについて説明します。 ``-e`` と ``--env`` は環境変数と値を指定する場所です。あるいは、もし ``=`` を ``export`` で指定しなければ、現在の環境変数がそのまま送られます（例： ホスト上の ``$MYVAR1`` がコンテナ内の ``$MYVAR1`` にセットされます ）。 ``=`` が指定されず、クライアント側の環境変数が無い場合は、コンテナ内の環境変数からは削除されます。この３つのフラグ ``-e`` 、 ``--env`` 、``--env-file`` は何度でも指定できます。

.. Regardless of the order of these three flags, the --env-file are processed first, and then -e, --env flags. This way, the -e or --env will override variables as needed.

これらの３つのフラグに関係なく、 ``--env-file`` が始めに処理され、その後 ``-e`` と ``--env`` フラグが処理されます。この方法は、必要な時に ``-e`` と ``--env`` で変数を上書きするために使えます。

.. code-block:: bash

   $ cat ./env.list
   TEST_FOO=BAR
   $ docker run --env TEST_FOO="This is a test" --env-file ./env.list busybox env | grep TEST_FOO
   TEST_FOO=This is a test

.. The --env-file flag takes a filename as an argument and expects each line to be in the VAR=VAL format, mimicking the argument passed to --env. Comment lines need only be prefixed with #

``--env-file`` フラグは、ファイル名を引数として使います。ファイルの内容は、それぞれの行が ``VAR=VAL`` の形式であり、 ``--env`` のようなものです。コメント行は、行頭に ``#`` を付けます。

.. An example of a file passed with --env-file

.. code-block:: bash

   $ cat ./env.list
   TEST_FOO=BAR
   
   # ここはコメント
   TEST_APP_DEST_HOST=10.10.0.127
   TEST_APP_DEST_PORT=8888
   _TEST_BAR=FOO
   TEST_APP_42=magic
   helloWorld=true
   123qwe=bar
   org.spring.config=something
   
   # 実行者は環境変数を渡す
   TEST_PASSTHROUGH
   $ TEST_PASSTHROUGH=howdy docker run --env-file ./env.list busybox env
   PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   HOSTNAME=5198e0745561
   TEST_FOO=BAR
   TEST_APP_DEST_HOST=10.10.0.127
   TEST_APP_DEST_PORT=8888
   _TEST_BAR=FOO
   TEST_APP_42=magic
   helloWorld=true
   TEST_PASSTHROUGH=howdy
   HOME=/root
   123qwe=bar
   org.spring.config=something
   
   $ docker run --env-file ./env.list busybox env
   PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
   HOSTNAME=5198e0745561
   TEST_FOO=BAR
   TEST_APP_DEST_HOST=10.10.0.127
   TEST_APP_DEST_PORT=8888
   _TEST_BAR=FOO
   TEST_APP_42=magic
   helloWorld=true
   TEST_PASSTHROUGH=
   HOME=/root
   123qwe=bar
   org.spring.config=something

.. Set metadata on container (-l, --label, --label-file)

.. _set-metadata-on-container:

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

.. Connect a container to a network (--net)

.. _connect-a-container-to-a-network:

コンテナをネットワークに接続（--net）
----------------------------------------

.. When you start a container use the --net flag to connect it to a network. This adds the busybox container to the my-net network.

コンテナ実行時に ``--net`` フラグを付けるとネットワークに接続します。次の例は ``busybox`` コンテナに ``my-net`` ネットワークを追加します。

.. code-block:: bash

   $ docker run -itd --net=my-net busybox

.. You can also choose the IP addresses for the container with --ip and --ip6 flags when you start the container on a user-defined network.

また、ユーザ定義ネットワーク上でコンテナを起動時、 ``--ip`` と ``--ipv6`` フラグを使い、コンテナに対して IP アドレスを割り当て可能です。

.. code-block:: bash

   $ docker run -itd --net=my-net --ip=10.10.9.75 busybox

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

.. _mount-volumes-from-container:

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

.. _attach-to-stdin-stdout-stderr:

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

   $ docker run --device=/dev/sdc:/dev/xvdc --device=/dev/sdd --device=/dev/zero:/dev/nulo -i -t ubuntu ls -l /dev/{xvdc,sdd,nulo}
   brw-rw---- 1 root disk 8, 2 Feb  9 16:05 /dev/xvdc
   brw-rw---- 1 root disk 8, 3 Feb  9 16:05 /dev/sdd
   crw-rw-rw- 1 root root 1, 5 Feb  9 16:05 /dev/nulo

.. It is often necessary to directly expose devices to a container. The --device option enables that. For example, a specific block storage device or loop device or audio device can be added to an otherwise unprivileged container (without the --privileged flag) and have the application directly access it.

デバイスをコンテナに直接さらす必要が度々あります。 ``--device`` オプションは、これを可能にします。例えば、特定のブロック・ストレージ・デバイス、ループ・デバイス、オーディオ・デバイスを使うにあたり、コンテナに特権を与えなくても（ ``--privileged`` フラグを使わずに ）追加でき、アプリケーションが直接使えるようになります。

.. By default, the container will be able to read, write and mknod these devices. This can be overridden using a third :rwm set of options to each --device flag:

デフォルトでは、コンテナは ``read`` 、``write`` 、 ``mknod`` を各デバイスに指定できます。各 ``--device`` フラグのオプション設定で、３つの ``:rwm`` を利用できます。

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

   ``--device`` はエフェメラルな（短命な）デバイスでは使うべきではありません。信頼できないコンテナが ``--device`` を追加しようとしても、ブロック・デバイスは除外されるでしょう。

.. Restart policies (--restart)

.. _restart-policies:

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
   * - **always**
     - 終了コードの状態に関わらず、常に再起動します。always を指定すると、 Docker デーモンは無制限に再起動を試みます。また、現在の状況に関わらず、デーモンの起動時にもコンテナの起動を試みます。
   * - **unless-stopped**
     - 終了コードの状態に関わらず、常に再起動します。しかし、以前に停止した状態であれば、Docker デーモンの起動時にコンテナを開始しません。

.. code-block:: bash

   $ docker run --restart=always redis

.. This will run the redis container with a restart policy of always so that if the container exits, Docker will restart it.

これは ``redis`` コンテナを再起動ポリシー **always** で起動するものです。つまり、コンテナが終了したら Docker がコンテナを再起動します。

.. More detailed information on restart policies can be found in the Restart Policies (--restart) section of the Docker run reference page.

再起動ポリシーに関するより詳しい情報は、 :doc:`Docker run リファレンス・ページ </engine/reference/run>` の :ref:`再起動ポリシー（--restart） <restart-policies-restart>` をご覧ください。

.. Add entries to container hosts file (--add-host)

.. _add-entries-to-container-hosts-file:

コンテナの hosts ファイルにエントリ追加（--add-host）
------------------------------------------------------------

.. You can add other hosts into a container’s /etc/hosts file by using one or more --add-host flags. This example adds a static address for a host named docker:

``--add-host`` フラグを使い、コンテナの ``/etc/hosts`` ファイルに１つもしくは複数のホストを追加できます。次の例はホスト名 ``docker`` に静的なアドレスを追加しています。

.. code-block:: bash

   $ docker run --add-host=docker:10.180.0.1 --rm -it debian
   $$ ping docker
   PING docker (10.180.0.1): 48 data bytes
   56 bytes from 10.180.0.1: icmp_seq=0 ttl=254 time=7.600 ms
   56 bytes from 10.180.0.1: icmp_seq=1 ttl=254 time=30.705 ms
   ^C--- docker ping statistics ---
   2 packets transmitted, 2 packets received, 0% packet loss
   round-trip min/avg/max/stddev = 7.600/19.152/30.705/11.553 ms

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

.. _set-ulimits-in-container-ulimit:

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

.. _for-nproc-usage:

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

.. _stop-container-with-signal:

コンテナをシグナルで停止
------------------------------

.. The --stop-signal flag sets the system call signal that will be sent to the container to exit. This signal can be a valid unsigned number that matches a position in the kernel’s syscall table, for instance 9, or a signal name in the format SIGNAME, for instance SIGKILL.

``--stop-signal`` フラグは、システムコールのシグナルを設定します。これは、コンテナを終了する時に送るものです。このシグナルはカーネルの syscall テーブルにある適切な数値と一致する必要があります。例えば 9 や、SIGNAME のような形式のシグナル名（例：SIGKILL）です。

.. Specify isolation technology for container (--isolation)

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

.. On Windows, the default isolation for client is hyperv, and for server is process. Therefore when running on Windows server without a daemon option set, these two commands are equivalent:

Windows 上では、クライアントはデフォルトの分離に ``nyperv`` を使い、server は ``process`` を使います。そのため、Windows サーバ上でデーモンのオプションの設定をしなければ、次の２つのコマンドは同等です。

.. code-block:: bash

   $ docker run -d --isolation default busybox top
   $ docker run -d --isolation process busybox top

.. If you have set the --exec-opt isolation=hyperv option on the Docker daemon, if running on Windows server, any of these commands also result in hyperv isolation:

Docker ``daemon`` 上で ``--exec-opt isolation=hyperv`` オプションを指定すると、WIndows server 上であれば、各コマンドの実行に ``hyperv`` 分離を使った結果を表示します。

.. code-block:: bash

   $ docker run -d --isolation default busybox top
   $ docker run -d --isolation hyperv busybox top

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

kernel.msgmax、 kernel.msgmnb、 kernel.msgmni、 kernel.sem、 kernel.shmall、 kernel.shmmax、 kernel.shmmni、 kernel.shm_rmid_forced、 fs.mqueue.* で始まる sysctl 。

.. If you use the --ipc=host option these sysctls will not be allowed.

``--ipc=host`` オプションを使う場合は、これら sysctl のオプション指定が許可されません。

.. Network Namespace: Sysctls beginning with net.*

``ネットワーク名前空間`` ： net.* で始まる sysctl

.. If you use the --net=host option using these sysctls will not be allowed.

``--ipc=host`` オプションを使う場合は、これら sysctl のオプション指定が許可されません。


.. seealso:: 

   run
      https://docs.docker.com/engine/reference/commandline/run/
