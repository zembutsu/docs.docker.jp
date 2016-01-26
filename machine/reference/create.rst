.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/reference/create/
.. doc version: 1.9
.. check date: 2016/01/26
.. -----------------------------------------------------------------------------

.. create

.. _machine-create:

=======================================
create
=======================================

.. Create a machine. Requires the --driver flag to indicate which provider (VirtualBox, DigitalOcean, AWS, etc.) the machine should be created on, and an argument to indicate the name of the created machine.

マシンを作成します。どのプロバイダ（VirtualBox、DigitalOcean、AWS等）でマシンを作成するかを ``--driver`` フラグで指定します。さらに、引数で作成するマシンの名前も指定します。

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

``docker-machine crate`` コマンドには全てのドライバで適用できる共通のフラグがあります。主に、マシンのプロビジョニング手順における挙動を制御するもので（Docker Swarm コンテナの作成も含みます）、利用者がカスタマイズできます。

.. code-block:: bash

   $ docker-machine create
   Docker Machine Version: 0.5.0 (45e3688)
   Usage: docker-machine create [OPTIONS] [arg...]
   
   Create a machine.
   
   Run 'docker-machine create --driver name' to include the create flags for that driver in the help text.
   
   Options:
   
      --driver, -d "none"                                                                                  Driver to create machine with.
      --engine-install-url "https://get.docker.com"                                                        Custom URL to use for engine installation [$MACHINE_DOCKER_INSTALL_URL]
      --engine-opt [--engine-opt option --engine-opt option]                                               Specify arbitrary flags to include with the created engine in the form flag=value
      --engine-insecure-registry [--engine-insecure-registry option --engine-insecure-registry option]     Specify insecure registries to allow with the created engine
      --engine-registry-mirror [--engine-registry-mirror option --engine-registry-mirror option]           Specify registry mirrors to use
      --engine-label [--engine-label option --engine-label option]                                         Specify labels for the created engine
      --engine-storage-driver                                                                              Specify a storage driver to use with the engine
      --engine-env [--engine-env option --engine-env option]                                               Specify environment variables to set in the engine
      --swarm                                                                                              Configure Machine with Swarm
      --swarm-image "swarm:latest"                                                                         Specify Docker image to use for Swarm [$MACHINE_SWARM_IMAGE]
      --swarm-master                                                                                       Configure Machine to be a Swarm master
      --swarm-discovery                                                                                    Discovery service to use with Swarm
      --swarm-strategy "spread"                                                                            Define a default scheduling strategy for Swarm
      --swarm-opt [--swarm-opt option --swarm-opt option]                                                  Define arbitrary flags for swarm
      --swarm-host "tcp://0.0.0.0:3376"                                                                    ip/socket to listen on for Swarm master
      --swarm-addr                                                                                         addr to advertise for Swarm (default: detect and use the machine IP)

.. Additionally, drivers can specify flags that Machine can accept as part of their plugin code. These allow users to customize the provider-specific parameters of the created machine, such as size (--amazonec2-instance-type m1.medium), geographical region (--amazonec2-region us-west-1), and so on.

さらに、Machine は各プラグイン・コードに含むフラグも受け付けることができ、これをドライバのフラグで指定できます。これにより、利用者は作成するマシン向けプロバイダ固有のパラメータをカスタマイズできます。例えば、容量（ ``--amazonec2-instance-type m1.medium`` ）や地理的なリージョン（ ``--amazonec2-region us-west-1`` ）などです。

.. To see the provider-specific flags, simply pass a value for --driver when invoking the create help text.

プロバイダ固有のフラグを確認するには ``create`` ヘルプ・テキストを表示するときに ``--deriver`` を単純に指定するだけです。

.. code-block:: bash

   $ docker-machine create --driver virtualbox --help
   Usage: docker-machine create [OPTIONS] [arg...]
   
   Create a machine.
   
   Run 'docker-machine create --driver name' to include the create flags for that driver in the help text.
   
   Options:
   
      --driver, -d "none"                                                                                  Driver to create machine with.
      --engine-env [--engine-env option --engine-env option]                                               Specify environment variables to set in the engine
      --engine-insecure-registry [--engine-insecure-registry option --engine-insecure-registry option]     Specify insecure registries to allow with the created engine
      --engine-install-url "https://get.docker.com"                                                        Custom URL to use for engine installation [$MACHINE_DOCKER_INSTALL_URL]
      --engine-label [--engine-label option --engine-label option]                                         Specify labels for the created engine
      --engine-opt [--engine-opt option --engine-opt option]                                               Specify arbitrary flags to include with the created engine in the form flag=value
      --engine-registry-mirror [--engine-registry-mirror option --engine-registry-mirror option]           Specify registry mirrors to use
      --engine-storage-driver                                                                              Specify a storage driver to use with the engine
      --swarm                                                                                              Configure Machine with Swarm
      --swarm-addr                                                                                         addr to advertise for Swarm (default: detect and use the machine IP)
      --swarm-discovery                                                                                    Discovery service to use with Swarm
      --swarm-host "tcp://0.0.0.0:3376"                                                                    ip/socket to listen on for Swarm master
      --swarm-image "swarm:latest"                                                                         Specify Docker image to use for Swarm [$MACHINE_SWARM_IMAGE]
      --swarm-master                                                                                       Configure Machine to be a Swarm master
      --swarm-opt [--swarm-opt option --swarm-opt option]                                                  Define arbitrary flags for swarm
      --swarm-strategy "spread"                                                                            Define a default scheduling strategy for Swarm
      --virtualbox-boot2docker-url                                                                         The URL of the boot2docker image. Defaults to the latest available version [$VIRTUALBOX_BOOT2DOCKER_URL]
      --virtualbox-cpu-count "1"                                                                           number of CPUs for the machine (-1 to use the number of CPUs available) [$VIRTUALBOX_CPU_COUNT]
      --virtualbox-disk-size "20000"                                                                       Size of disk for host in MB [$VIRTUALBOX_DISK_SIZE]
      --virtualbox-host-dns-resolver                                                                       Use the host DNS resolver [$VIRTUALBOX_HOST_DNS_RESOLVER]
      --virtualbox-dns-proxy                                                                               Proxy all DNS requests to the host [$VIRTUALBOX_DNS_PROXY]
      --virtualbox-hostonly-cidr "192.168.99.1/24"                                                         Specify the Host Only CIDR [$VIRTUALBOX_HOSTONLY_CIDR]
      --virtualbox-hostonly-nicpromisc "deny"                                                              Specify the Host Only Network Adapter Promiscuous Mode [$VIRTUALBOX_HOSTONLY_NIC_PROMISC]
      --virtualbox-hostonly-nictype "82540EM"                                                              Specify the Host Only Network Adapter Type [$VIRTUALBOX_HOSTONLY_NIC_TYPE]
      --virtualbox-import-boot2docker-vm                                                                   The name of a Boot2Docker VM to import
      --virtualbox-memory "1024"                                                                           Size of memory for host in MB [$VIRTUALBOX_MEMORY_SIZE]
      --virtualbox-no-share                                                                                Disable the mount of your home directory

.. You may notice that some flags specify environment variables that they are associated with as well (located to the far left hand side of the row). If these environment variables are set when docker-machine create is invoked, Docker Machine will use them for the default value of the flag.

環境変数を使ってもフラグと同様の指定ができるので、覚えておいてください（列の左側にあります）。環境変数は ``docker-machine create`` の実行時に読み込まれ、Docker machine はフラグのデフォルト値を上書きします。

.. Specifying configuration options for the created Docker engine

.. _specifying-configuration-options-for-the-created-docker-engine:

Docker エンジン作成用のオプションを指定
========================================

.. As part of the process of creation, Docker Machine installs Docker and configures it with some sensible defaults. For instance, it allows connection from the outside world over TCP with TLS-based encryption and defaults to AUFS as the storage driver when available.

作成時の手順において、Docker Machine は Docker をインストールし、適切な初期設定をします。たとえば、外の世界から TLS をベースとした暗号化 TCP を通して通信できるようにし、:ref:`ストレージ・ドライバ <daemon-storage-driver-option>` が利用可能であれば AUFS を設定します。

.. There are several cases where the user might want to set options for the created Docker engine (also known as the Docker daemon) themselves. For example, they may want to allow connection to a registry that they are running themselves using the --insecure-registry flag for the daemon. Docker Machine supports the configuration of such options for the created engines via the create command flags which begin with --engine.

Docker エンジン（あるいは Docker *デーモン* ）に対して、利用者は自分自身でオプションを設定すべきケースが複数あります。例えば、自分たちで実行している :doc:`レジストリ </registry/index>` に接続するには、デーモンに対して ``--insecure-registry`` フラグを使う必要があります。Docker Machine で ``create`` コマンドを使ってエンジンを作成する場合、 ``--engine`` で始まるフラグを設定できます。

.. Note that Docker Machine simply sets the configured parameters on the daemon and does not set up any of the “dependencies” for you. For instance, if you specify that the created daemon should use btrfs as a storage driver, you still must ensure that the proper dependencies are installed, the BTRFS filesystem has been created, and so on.

Docker Machine は、デーモンに対するパラメータを単にセットするだけであり、「依存関係」については設定しないので、ご注意ください。たとえば、デーモンでストレージ・ドライバに ``btrfs`` を指定する場合は、自分自身で依存関係のインストールと、BTRFS ファイルシステムの作成等が必要です。

.. The following is an example usage:

$ docker-machine create -d virtualbox \
    --engine-label foo=bar \
    --engine-label spam=eggs \
    --engine-storage-driver overlay \
    --engine-insecure-registry registry.myco.com \
    foobarmachine

.. This will create a virtual machine running locally in Virtualbox which uses the overlay storage backend, has the key-value pairs foo=bar and spam=eggs as labels on the engine, and allows pushing / pulling from the insecure registry located at registry.myco.com. You can verify much of this by inspecting the output of docker info:

これはローカルの VirtualBox に仮想マシンを作成するにあたり、ストレージのバックエンドには ``overlay`` を使用し、エンジンのラベルとしてキーバリュー・ペアの ``foo-bar`` と ``spam=enngs`` を指定します。さらに、 ``registry.myco.com`` にある非安全なレジストリへのイメージ送信・取得を許可します。詳細情報は ``docker info`` の出力結果から確認できます。

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

エンジンは複数回のラベル指定（ ``--label`` を使用）をサポートしており、Docker  Machine によって設定できます。

.. In addition to this subset of daemon flags which are directly supported, Docker Machine also supports an additional flag, --engine-opt, which can be used to specify arbitrary daemon options with the syntax --engine-opt flagname=value. For example, to specify that the daemon should use 8.8.8.8 as the DNS server for all containers, and always use the syslog log driver you could run the following create command:

デーモンのフラグを直接指定できるのに加え、Docker Machine は ``--engine-opt`` という追加フラグもサポートしています。これは ``--engine-opt flagname=value`` の形式で、特別な属性を持つデーモンのオプション指定に使います。例えば、全てのコンテナが DNS サーバに ``8.8.8.8`` を使うようデーモンに指定したり、常に ``syslog`` :ref:`ログ・ドライバ <logging-drivers-log-driver>` を使って実行させたりするには、次のように create コマンドを使います。

.. code-block:: bash

   $ docker-machine create -d virtualbox \
       --engine-opt dns=8.8.8.8 \
       --engine-opt log-driver=syslog \
       gdns

.. Additionally, Docker Machine supports a flag, --engine-env, which can be used to specify arbitrary environment variables to be set within the engine with the syntax --engine-env name=value. For example, to specify that the engine should use example.com as the proxy server, you could run the following create command:

さらに、Docker Machine は ``--engine-env`` フラグをサポートしています。これは外部の環境変数を指定するものであり、エンジンに適用するには ``--engine-env name=value`` の形式で指定します。例えば、エンジンが ``example.com`` をプロキシ・サーバとして使うには、crate コマンドで次のように実行します。

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

.. In addition to being able to configure Docker Engine options as listed above, you can use Machine to specify how the created Swarm master should be configured). There is a --swarm-strategy flag, which you can use to specify the scheduling strategy which Docker Swarm should use (Machine defaults to the spread strategy). There is also a general purpose --swarm-opt option which works similar to how the aforementioned --engine-opt option does, except that it specifies options for the swarm manage command (used to boot a master node) instead of the base command. You can use this to configure features that power users might be interested in, such as configuring the heartbeat interval or Swarm’s willingness to over-commit resources.

先ほどの Docker Engine オプションの設定を指定できるだけではありません。Docker Machine を使えば、 Swarm マスタをどのように作成するかも指定できます。 ``--swarm-strategy`` フラグを使うと、Docker Swarm が使うべき :doc:`スケジューリング・ストラテジ </swarm/scheduler/strategy>` （デフォルトは ``spread`` ストラテジ ）を指定できます。また前述した ``--engine-opt`` オプションで指定したように、 ``--swarm-opt`` オプションで一般的なオプションを設定できますが、違いは ``swarm manage`` コマンドに対するオプション（マスタ・ノードの起動時に使用）を指定するものです。これらの機能設定を使うことで、パワーユーザであれば beartbeat 間隔の調整や、Swarm のオーバーコミット・リソースの調整に活用できるでしょう。

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

