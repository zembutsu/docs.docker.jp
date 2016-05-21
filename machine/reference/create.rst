.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/create/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/create.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/create.md
.. check date: 2016/04/28
.. Commits on Feb 14, 2016 1eaf5a464f44066e57628218995c8b7d80c825cd
.. ----------------------------------------------------------------------------

.. create

.. _machine-create:

=======================================
create
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Create a machine. Requires the --driver flag to indicate which provider (VirtualBox, DigitalOcean, AWS, etc.) the machine should be created on, and an argument to indicate the name of the created machine.

マシンを作成します。どのプロバイダ（VirtualBox、Digital Ocean、AWS等）でマシンを作成するかを ``--driver`` フラグで指定します。更に、引数で作成するマシンの名前も指定します。

.. code-block:: bash

   $ docker-machine create --driver virtualbox dev
   Creating CA: /home/username/.docker/machine/certs/ca.pem
   Creating client certificate: /home/username/.docker/machine/certs/cert.pem
   Image cache does not exist, creating it at /home/username/.docker/machine/cache...
   No default boot2docker iso found locally, downloading the latest release...
   Downloading https://github.com/boot2docker/boot2docker/releases/download/v1.6.2/boot2docker.iso to /home/username/.docker/machine/cache/boot2docker.iso...
   Creating VirtualBox VM...
   Creating SSH key...
   Starting VirtualBox VM...
   Starting VM...
   To see how to connect Docker to this machine, run: docker-machine env dev

.. Accessing driver-specific flags in the help text

.. _accessing-driver-specific-flags:

ヘルプ・テキストで、ドライバを指定するフラグを使う
==================================================

.. The docker-machine create command has some flags which are applicable to all drivers. These largely control aspects of Machine’s provisoning process (including the creation of Docker Swarm containers) that the user may wish to customize.

``docker-machine create`` コマンドには全てのドライバで適用できる共通のフラグがあります。主に、マシンのプロビジョニング手順における挙動を制御するもので（Docker Swarm コンテナの作成も含みます）、利用者がカスタマイズできます。

.. code-block:: bash

   $ docker-machine create
   Docker Machine Version: 0.5.0 (45e3688)
   使い方: docker-machine create [オプション] [引数...]
   
   マシンを作成する。
   
   'docker-machine create --driver 名前' を実行すると、対象ドライバで作成時のヘルプ文字列を表示。
   
   オプション:
   
      --driver, -d "none"                                                                                  マシン作成に使うドライバ
      --engine-install-url "https://get.docker.com"                                                        エンジンをインストールするカスタム URL [$MACHINE_DOCKER_INSTALL_URL]
      --engine-opt [--engine-opt option --engine-opt option]                                               engine 作成時に任意のフラグを flag=value 形式で指定
      --engine-insecure-registry [--engine-insecure-registry option --engine-insecure-registry option]     作成するエンジンで安全では無いレジストリ (insecure registry) を指定
      --engine-registry-mirror [--engine-registry-mirror option --engine-registry-mirror option]           レジストリのミラーを使う指定 [$ENGINE_REGISTRY_MIRROR]
      --engine-label [--engine-label option --engine-label option]                                         engine 作成時にラベルを指定
      --engine-storage-driver                                                                              engine が使うストレージ・ドライバの指定
      --engine-env [--engine-env option --engine-env option]                                               engine で使う環境変数を指定
      --swarm                                                                                              Swarm と Machine を使う設定
      --swarm-image "swarm:latest"                                                                         Swarm が使う Docker イメージの指定 [$MACHINE_SWARM_IMAGE]
      --swarm-master                                                                                       Machine で Swarm マスタ用の設定
      --swarm-discovery                                                                                    Swarm で使うディスカバリ・サービス
      --swarm-strategy "spread"                                                                            Swarm のデフォルト・スケジューリング・ストラテジを指定
      --swarm-opt [--swarm-opt option --swarm-opt option]                                                  swarm に任意のフラグを指定
      --swarm-host "tcp://0.0.0.0:3376"                                                                    Swarm マスタ上でリッスンする ip/socket 
      --swarm-addr                                                                                         Swarm のアドバタイズ・アドレス (デフォルト: 検出、もしくはマシン IP を使用)
      --swarm-experimental                 


.. Additionally, drivers can specify flags that Machine can accept as part of their plugin code. These allow users to customize the provider-specific parameters of the created machine, such as size (--amazonec2-instance-type m1.medium), geographical region (--amazonec2-region us-west-1), and so on.

更に、Machine は各プラグイン・コードに含むフラグも受け付けることができ、これをドライバのフラグで指定できます。これにより、利用者は作成するマシン向けプロバイダ固有のパラメータをカスタマイズできます。例えば、容量（ ``--amazonec2-instance-type m1.medium`` ）や地理的なリージョン（ ``--amazonec2-region us-west-1`` ）などです。

.. To see the provider-specific flags, simply pass a value for --driver when invoking the create help text.

プロバイダ固有のフラグを確認するには ``create`` と ``--driver`` にヘルプ・テキストの表示を単純に指定するだけです。

.. code-block:: bash

   $ docker-machine create --driver virtualbox --help
   使い方: docker-machine create [オプション] [引数...]
   
   マシンを作成。
   
   'docker-machine create --driver 名前' を実行すると、対象ドライバで作成時のヘルプ文字列を表示。
   
   オプション:
   
      --driver, -d "none"                                                                                  マシン作成に使うドライバ
      --engine-env [--engine-env option --engine-env option]                                               engine で使う環境変数を指定
      --engine-insecure-registry [--engine-insecure-registry option --engine-insecure-registry option]     作成するエンジンで安全では無いレジストリ (insecure registry) を指定
      --engine-install-url "https://get.docker.com"                                                        エンジンをインストールするカスタム URL [$MACHINE_DOCKER_INSTALL_URL]
      --engine-label [--engine-label option --engine-label option]                                         engine 作成時にラベルを指定
      --engine-opt [--engine-opt option --engine-opt option]                                               engine 作成時に任意のフラグを flag=value 形式で指定
      --engine-registry-mirror [--engine-registry-mirror option --engine-registry-mirror option]           レジストリのミラーを使う指定 [$ENGINE_REGISTRY_MIRROR]
      --engine-storage-driver                                                                              engine が使うストレージ・ドライバの指定
      --swarm                                                                                              Swarm と Machine を使う設定
      --swarm-addr                                                                                         Swarm のアドバタイズ・アドレス (デフォルト: 検出、もしくはマシン IP を使用)
      --swarm-discovery                                                                                    Swarm で使うディスカバリ・サービス
      --swarm-experimental                                                                                 Swarm の実験的機能を有効化
      --swarm-host "tcp://0.0.0.0:3376"                                                                    Swarm マスタ上でリッスンする ip/socket 
      --swarm-image "swarm:latest"                                                                         Swarm が使う Docker イメージの指定 [$MACHINE_SWARM_IMAGE]
      --swarm-master                                                                                       Machine で Swarm マスタ用の設定
      --swarm-opt [--swarm-opt option --swarm-opt option]                                                  swarm に任意のフラグを指定
      --swarm-strategy "spread"                                                                            Swarm のデフォルト・スケジューリング・ストラテジを指定
      --virtualbox-boot2docker-url                                                                         boot2docker イメージの URL を指定。デフォルトは利用可能な最新バージョン [$VIRTUALBOX_BOOT2DOCKER_URL]
      --virtualbox-cpu-count "1"                                                                           マシンで使う CPU 数 (-1 は利用可能な CPU 全て) [$VIRTUALBOX_CPU_COUNT]
      --virtualbox-disk-size "20000"                                                                       ホストのディスク容量を MB 単位で指定 [$VIRTUALBOX_DISK_SIZE]
      --virtualbox-host-dns-resolver                                                                       ホストが使う DNS リゾルバ [$VIRTUALBOX_HOST_DNS_RESOLVER]
      --virtualbox-dns-proxy                                                                               全ての DNS リクエストをホストへプロキシ [$VIRTUALBOX_DNS_PROXY]
      --virtualbox-hostonly-cidr "192.168.99.1/24"                                                         ホスト・オンリー CIDR の指定 [$VIRTUALBOX_HOSTONLY_CIDR]
      --virtualbox-hostonly-nicpromisc "deny"                                                              ホスト・オンリー・ネットワーク・アダプタをプロミスキャスト・モードに指定 [$VIRTUALBOX_HOSTONLY_NIC_PROMISC]
      --virtualbox-hostonly-nictype "82540EM"                                                              ホスト・オンリー・ネットワーク・アダプタの種類を指定 [$VIRTUALBOX_HOSTONLY_NIC_TYPE]
      --virtualbox-import-boot2docker-vm                                                                   取り込む  Boot2Docker VM のイメージ名
      --virtualbox-memory "1024"                                                                           ホスト側のメモリ容量を MB で指定 [$VIRTUALBOX_MEMORY_SIZE]
      --virtualbox-no-share   


.. You may notice that some flags specify environment variables that they are associated with as well (located to the far left hand side of the row). If these environment variables are set when docker-machine create is invoked, Docker Machine will use them for the default value of the flag.

環境変数を使ってもフラグと同様の指定ができますので、覚えておいてください（列の左側にあります）。環境変数は ``docker-machine create`` の実行時に読み込まれ、Docker machine はフラグのデフォルト値を上書きします。

.. Specifying configuration options for the created Docker engine

.. _specifying-configuration-options-for-the-created-docker-engine:

Docker エンジン作成用のオプションを指定
========================================

.. As part of the process of creation, Docker Machine installs Docker and configures it with some sensible defaults. For instance, it allows connection from the outside world over TCP with TLS-based encryption and defaults to AUFS as the storage driver when available.

作成時の手順において、Docker Machine は Docker をインストールし、適切な初期設定をします。例えば、外の世界から TLS をベースとした暗号化 TCP を通して通信できるようにし、:ref:`ストレージ・ドライバ <daemon-storage-driver-option>` が利用可能であれば AUFS を設定します。

.. There are several cases where the user might want to set options for the created Docker engine (also known as the Docker daemon) themselves. For example, they may want to allow connection to a registry that they are running themselves using the --insecure-registry flag for the daemon. Docker Machine supports the configuration of such options for the created engines via the create command flags which begin with --engine.

Docker エンジン（あるいは Docker *デーモン* ）に対して、利用者は自分自身でオプションを設定すべきケースが複数あります。例えば、自分たちで実行している :doc:`レジストリ </registry/index>` に接続するには、デーモンに対して ``--insecure-registry`` フラグを使う必要があります。Docker Machine で ``create`` コマンドを使ってエンジンを作成する場合、 ``--engine`` で始まるフラグを設定できます。

.. Note that Docker Machine simply sets the configured parameters on the daemon and does not set up any of the “dependencies” for you. For instance, if you specify that the created daemon should use btrfs as a storage driver, you still must ensure that the proper dependencies are installed, the BTRFS filesystem has been created, and so on.

Docker Machine は、デーモンに対するパラメータを単にセットするだけであり、「依存関係」については設定しませんので、ご注意ください。例えば、デーモンでストレージ・ドライバに ``btrfs`` を指定する場合は、自分自身で依存関係のインストールと、BTRFS ファイルシステムの作成等が必要です。

.. The following is an example usage:

.. code-block:: bash

   $ docker-machine create -d virtualbox \
       --engine-label foo=bar \
       --engine-label spam=eggs \
       --engine-storage-driver overlay \
       --engine-insecure-registry registry.myco.com \
       foobarmachine

.. This will create a virtual machine running locally in Virtualbox which uses the overlay storage backend, has the key-value pairs foo=bar and spam=eggs as labels on the engine, and allows pushing / pulling from the insecure registry located at registry.myco.com. You can verify much of this by inspecting the output of docker info:

これはローカルの VirtualBox に仮想マシンを作成するにあたり、ストレージのバックエンドには ``overlay`` を使用し、エンジンのラベルとしてキーバリュー・ペアの ``foo=bar`` と ``spam=eggs`` を指定します。更に、 ``registry.myco.com`` にある非安全なレジストリへのイメージ送信・取得を許可します。詳細情報は ``docker info`` の出力結果から確認できます。

.. code-block:: bash

   $ eval $(docker-machine env foobarmachine)
   $ docker info
   Containers: 0
   Images: 0
   Storage Driver: overlay
   ...
   Name: foobarmachine
   ...
   Labels:
    foo=bar
    spam=eggs
    provider=virtualbox

.. The supported flags are as follows:

ここでは次のフラグが使えます。

..    --engine-insecure-registry: Specify insecure registries to allow with the created engine
    --engine-registry-mirror: Specify registry mirrors to use
    --engine-label: Specify labels for the created engine
    --engine-storage-driver: Specify a storage driver to use with the engine

* ``--engine-insecure-registry`` : 作成するエンジンが、指定した :ref:`非安全なレジストリ <insecure-registries>` と通信できるようにする。
* ``--engine-registry-mirror`` : 使用する `レジストリ・ミラー <https://github.com/docker/distribution/blob/master/docs/mirror.md>`_ を指定。
* ``--engine-label`` : 作成するエンジン用の :ref:`ラベル <daemon-labels>` を指定。
* ``--engine-storage-driver`` : エンジンが使う :ref:`ストレージ・ドライバ <daemon-storage-driver-option>` を指定。

.. If the engine supports specifying the flag multiple times (such as with --label), then so does Docker Machine.

エンジンは複数回のラベル指定（ ``--label`` を使用）をサポートしており、Docker  Machine で設定できます。

.. In addition to this subset of daemon flags which are directly supported, Docker Machine also supports an additional flag, --engine-opt, which can be used to specify arbitrary daemon options with the syntax --engine-opt flagname=value. For example, to specify that the daemon should use 8.8.8.8 as the DNS server for all containers, and always use the syslog log driver you could run the following create command:

デーモンのフラグを直接指定できるのに加え、Docker Machine は ``--engine-opt`` という追加フラグもサポートしています。これは ``--engine-opt flagname=value`` の形式で、特別な属性を持つデーモンのオプション指定に使います。例えば、全てのコンテナが DNS サーバに ``8.8.8.8`` を使うようデーモンに指定したり、常に ``syslog`` :ref:`ログ・ドライバ <logging-drivers-log-driver>` を使って実行させたりするには、次のように create コマンドを使います。

.. code-block:: bash

   $ docker-machine create -d virtualbox \
       --engine-opt dns=8.8.8.8 \
       --engine-opt log-driver=syslog \
       gdns

.. Additionally, Docker Machine supports a flag, --engine-env, which can be used to specify arbitrary environment variables to be set within the engine with the syntax --engine-env name=value. For example, to specify that the engine should use example.com as the proxy server, you could run the following create command:

更に、Docker Machine は ``--engine-env`` フラグをサポートしています。これは外部の環境変数を指定するものであり、エンジンに適用するには ``--engine-env name=value`` の形式で指定します。例えば、エンジンが ``example.com`` をプロキシ・サーバとして使うには、create コマンドで次のように実行します。

.. code-block:: bash

   $ docker-machine create -d virtualbox \
       --engine-env HTTP_PROXY=http://example.com:8080 \
       --engine-env HTTPS_PROXY=https://example.com:8080 \
       --engine-env NO_PROXY=example2.com \
       proxbox

.. Specifying Docker Swarm options for the created machine

.. _specifying-docker-swarm-options-for-the-created-machine:

マシン作成時に Docker Swarm オプションを指定
==================================================

.. In addition to being able to configure Docker Engine options as listed above, you can use Machine to specify how the created Swarm master should be configured. There is a --swarm-strategy flag, which you can use to specify the scheduling strategy which Docker Swarm should use (Machine defaults to the spread strategy). There is also a general purpose --swarm-opt option which works similar to how the aforementioned --engine-opt option does, except that it specifies options for the swarm manage command (used to boot a master node) instead of the base command. You can use this to configure features that power users might be interested in, such as configuring the heartbeat interval or Swarm’s willingness to over-commit resources. There is also the --swarm-experimental flag, that allows you to access experimental features in Docker Swarm.

先ほどの Docker Engine オプションの設定を指定できるだけではありません。Docker Machine を使えば、 Swarm マスタをどのように作成するかも指定できます。 ``--swarm-strategy`` フラグを使えば、Docker Swarm が使うべき :doc:`スケジューリング・ストラテジ </swarm/scheduler/strategy>` （デフォルトは ``spread`` ストラテジ ）を指定できます。また前述した ``--engine-opt`` オプションで指定したように、 ``--swarm-opt`` オプションで一般的なオプションを設定できますが、違いは ``swarm manage`` コマンドに対するオプション（マスタ・ノードの起動時に使用）を指定するものです。これらの機能設定を使うことで、パワーユーザであれば heartbeat 間隔の調整や、Swarm のオーバーコミット・リソースの調整に活用できるでしょう。また、 ``--swarm-experimental`` フラグを使えば Docker Swarm の `実験的機能 <https://github.com/docker/swarm/tree/master/experimental>`_ が利用可能になります。

.. If you’re not sure how to configure these options, it is best to not specify configuration at all. Docker Machine will choose sensible defaults for you and you won’t have to worry about it.

どのようにオプションを設定するか分からない場合は、何も指定しないのがベストな方法です。何も心配しなくても、Docker Machine は適切に初期設定を行います。

.. Example create:

作成例：

.. code-block:: bash

   $ docker-machine create -d virtualbox \
       --swarm \
       --swarm-master \
       --swarm-discovery token://<token> \
       --swarm-strategy binpack \
       --swarm-opt heartbeat=5 \
       upbeat

.. This will set the swarm scheduling strategy to “binpack” (pack in containers as tightly as possible per host instead of spreading them out), and the “heartbeat” interval to 5 seconds.

こちらは Swarm スケジューリング・ストラテジに「binpack」を指定し（ホストに広く展開するのではなく、できるだけコンテナをホストに集約する設定）、「heartbeat」間隔を５秒にします。

.. Pre-create check

作成の事前確認
====================

.. Since many drivers require a certain set of conditions to be in place before they can successfully perform a create (e.g. VirtualBox should be installed, or the provided API credentials should be valid), Docker Machine has a “pre-create check” which is specified at the driver level.

多くのドライバで、それぞれの場所で実際に作成可能どうか確認する必要があるでしょう（例：VirtualBox がインストールされているかや、指定する API 証明書が有効かどうか）。Docker Machine は「作成の事前確認」（pre-create check）をドライバごとに行えます。

.. .If this pre-create check succeeds, Docker Machine will proceed with the creation as normal. If the pre-create check fails, the Docker Machine process will exit with status code 3 to indicate that the source of the non-zero exit was the pre-create check failing.

事前確認が成功すると、Docker Machine は通常通り作成手順を進行します。事前確認に失敗すると、 Docker Machine のプロセスは終了コード 3 で終了します。つまり、ゼロ以外の終了コードを返す場合は、事前作成に失敗したのが分かります。

.. seealso:: 

   create
      https://docs.docker.com/machine/reference/create/
