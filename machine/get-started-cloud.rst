.. http://docs.docker.com/machine/get-started-cloud/

.. _get-started-cloud:

.. Using Docker Machine with a cloud provider

==================================================
Docker Machine をクラウド・プロバイダで始めるには
==================================================

.. Creating a local virtual machine running Docker is useful and fun, but it is not the only thing Docker Machine is capable of. Docker Machine supports several “drivers” which let you use the same interface to create hosts on many different cloud or local virtualization platforms. This is accomplished by using the docker-machine create command with the --driver flag. Here we will be demonstrating the Digital Ocean driver (called digitalocean), but there are drivers included for several providers including Amazon Web Services, Google Compute Engine, and Microsoft Azure.

ローカルの仮想環境を作り Docker を実行するのは、使いやすく面白いものです。しかし、Docker Machine には、複数の "ドライバ" をサポートする能力があります。そのため、同じインターフェースを使いながらも、多くのクラウドまたはローカルの仮想化プラットフォームで Docker を実行するホストを作れます。これには ``docker-machine create`` コマンドで ``--driver`` フラグを指定するだけです。ここでは例として `Digital Ocean <https://digitalocean.com/>`_ ドライバ（ ``digitalocean`` と呼びます ）を扱います。しかし、 Amazon Web Services、Google Compute Engine、Microsoft Azure をはじめとしたドライバがあります。

.. Usually it is required that you pass account verification credentials for these providers as flags to docker-machine create. These flags are unique for each driver. For instance, to pass a Digital Ocean access token you use the --digitalocean-access-token flag.

通常、``docker-machine`` でこれらのプロバイダを利用する時、アカウント認証用の証明書（credentaial）が必要です。このフラグは、ドライバ毎に指定方法が異なります。例えば、DigitalOcean のアクセス・トークンを使うには、``--digitalocean-access-token`` フラグを使います。

.. Let’s take a look at how to do this.

それでは実際に作業してみましょう。

..    Go to the Digital Ocean administrator console and click on “API” in the header.
    Click on “Generate New Token”.
    Give the token a clever name (e.g. “machine”), make sure the “Write” checkbox is checked, and click on “Generate Token”.
    Grab the big long hex string that is generated (this is your token) and store it somewhere safe.

1. Digital Ocean の管理コンソールに移動し、ページ上方の "API" をクリックする。
2. "Generate New Token"（新しいトークンの生成）をクリックする。
3. トークンに適切な名前（例："machine"）を指定し、"Write" チェックボックスにチェックを入れ、"Generate Token"（トークン生成）をクリックします。
4. 長い16進数列を取得します。これが生成された（自分用のトークン）ものであり、安全な場所に保管します。

.. Now, run docker-machine create with the digitalocean driver and pass your key to the --digitalocean-access-token flag.

これで、``docker-machine create`` 時に ``digitalocean`` ドライバを指定し、自分の鍵を ``--digitalocean-access-token`` フラグで指定します。

.. Example:

実行例：

.. code-block:: bash

   $ docker-machine create \
       --driver digitalocean \
       --digitalocean-access-token 0ab77166d407f479c6701652cee3a46830fef88b8199722b87821621736ab2d4 \
       staging
   Creating SSH key...
   Creating Digital Ocean droplet...
   To see how to connect Docker to this machine, run: docker-machine env staging

.. For convenience, docker-machine will use sensible defaults for choosing settings such as the image that the VPS is based on, but they can also be overridden using their respective flags (e.g. --digitalocean-image). This is useful if, for instance, you want to create a nice large instance with a lot of memory and CPUs (by default docker-machine creates a small VPS). For a full list of the flags/settings available and their defaults, see the output of docker-machine create -h.

便利な機能として、``docker-machine`` には仮想マシンの作成s時、対象となるイメージに応じて、適切な設定となるようデフォルト値を持っています。それだけではなく、必要があればフラグを指定し、その値の上書きも可能です（例： ``--digitalocean-image`` ）。これは扱いやすいもので、例えば、多くのメモリや CPU を必要とする大きなインスタンスを作成できます（デフォルトの ``docker-machine`` が作成するのは、小さな仮想マシンです ）。利用可能なフラグや値、デフォルト設定については ``docker-machine create -h`` の出力をご確認ください。

.. When the creation of a host is initiated, a unique SSH key for accessing the host (initially for provisioning, then directly later if the user runs the docker-machine ssh command) will be created automatically and stored in the client’s directory in ~/.docker/machines. After the creation of the SSH key, Docker will be installed on the remote machine and the daemon will be configured to accept remote connections over TCP using TLS for authentication. Once this is finished, the host is ready for connection.

ホスト作成時の初期設定では、ホストに接続するためのユニークな SSH 鍵（初期のプロビジョン具だけではなく、後で ``docker-machine ssh` コマンドでも使用）が自動的に作成され、クライアントの ``/.docker/machine`` ディレクトリに保管されます。SSH 鍵を作成後、Docker はリモートマシン上にデーモンをインストールし、リモートマシンとは TCP 上の TLS を使った通信ができるよう、自動的に設定します。これが終わればホストとの通信準備が整います。

To prepare the Docker client to send commands to the remote server we have created, we can use the subshell method again:

Docker クライアントから作成したリモートのサーバに対してコマンドを送るには、シェル上で再びコマンドを実行します。

.. code-block:: bash

   $ eval "$(docker-machine env staging)"

.. From this point, the remote host behaves much like the local host we created in the last section. If we look at docker-machine ls, we’ll see it is now the “active” host, indicated by an asterisk (*) in that column:

これを実行することで、先ほど作成したリモートホストが、ローカルホストのように振る舞います。ここで ``docker-machine ls`` を見てみると、"active"（アクティブ）ホストの列に、アスタリスク（*）の印が表示されます。

.. code-block:: bash

   $ docker-machine ls
   NAME      ACTIVE   DRIVER         STATE     URL
   dev                virtualbox     Running   tcp://192.168.99.103:2376
   staging   *        digitalocean   Running   tcp://104.236.50.118:2376

.. To remove a host and all of its containers and images, use docker-machine rm:

ホストとホスト上の全てのコンテナとイメージを削除するには ``docker-machine rm`` を使います。

.. code-block:: bash

    $ docker-machine rm dev staging
   $ docker-machine ls
   NAME      ACTIVE   DRIVER       STATE     URL

.. Adding a host without a driver

ドライバを使わずにホストを追加
========================================

.. You can add a host to Docker which only has a URL and no driver. Therefore it can be used an alias for an existing host so you don’t have to type out the URL every time you run a Docker command.

Docker ホストの追加は、ドライバを使わず URL でも可能です。URL で追加すると、移行は追加したホストに対するエイリアス（別名）として利用できますので、毎回 Docker コマンドで URL を指定する必要がなくなります。

.. code-block:: bash

   $ docker-machine create --url=tcp://50.134.234.20:2376 custombox
   $ docker-machine ls
   NAME        ACTIVE   DRIVER    STATE     URL
   custombox   *        none      Running   tcp://50.134.234.20:2376

.. Uisng Docker Machine with Docker Swarm

Docker Machine で Docker Swarm を扱う
========================================

.. Docker Machine can also provision Swarm clusters. This can be used with any driver and will be secured with TLS.

Docker Machine は `Swarm <https://github.com/docker/swarm>`_ クラスタのプロビジョニングも可能です。これにより、どのドライバを使っている場合でも、TLS で安全に通信できます。

.. First, create a Swarm token. Optionally, you can use another discovery service. See the Swarm docs for details.

使うためには、まず Swarm トークンを作成します。オプションとして、他のディスカバリ・サービスを使うことも可能です。詳細は Swarm のドキュメントをご覧ください。

.. To create the token, first create a Machine. This example will use VirtualBox.

トークンを作成したら、マシンを作成します。この例では VirtualBox を使います。

.. code-block:: bash

   $ docker-machine create -d virtualbox local

.. Load the Machine configuration into your shell:

マシンの設定をシェル上に読み込みます。

.. code-block:: bash

   $ eval "$(docker-machine env local)"

.. Then run generate the token using the Swarm Docker image:

それから、Swarm の Docker イメージを使い、トークンを生成します。

.. code-block:: bash

   $ docker run swarm create
   1257e0f0bbb499b5cd04b4c9bdb2dab3

トークンを作成後は、これを使ってクラスタを作成できます。

.. Swarm master

Swarm マスタ
--------------------

Swarm マスタを次のように作成します。

.. code-block:: bash

   docker-machine create \
       -d virtualbox \
       --swarm \
       --swarm-master \
       --swarm-discovery token://<先ほどのトークン> \
       swarm-master

.. Replace <TOKEN-FROM-ABOVE> with your random token. This will create the Swarm master and add itself as a Swarm node.

上の ``<先ほどのトークン>`` の場所には、先ほど作成したランダムなトークンを入れます。このコマンドは、Swarm マスタを作成すると同時に、自分自身を Swarm ノードに追加します。

.. Swarm nodes

Swarm ノード
====================

.. Now, create more Swarm nodes:

次は追加の Swarm ノードを作成します。

.. code-block:: bash

   docker-machine create \
       -d virtualbox \
       --swarm \
       --swarm-discovery token://<TOKEN-FROM-ABOVE> \
       swarm-node-00

.. You now have a Swarm cluster across two nodes. To connect to the Swarm master, use eval $(docker-machine env --swarm swarm-master)

これで２つのノードにまたがる Swarm クラスタができました。Swarm マスタに接続するには、``$(docker-machine env --swarm swarm-master)`` を使います。

.. For example:

実行例：

.. code-block:: bash

   $ docker-machine env --swarm swarm-master
   export DOCKER_TLS_VERIFY=1
   export DOCKER_CERT_PATH="/home/ehazlett/.docker/machines/.client"
   export DOCKER_HOST=tcp://192.168.99.100:3376

.. You can load this into your environment using eval "$(docker-machine env --swarm swarm-master)".

この環境を読み込むには、 ``eval "$(docker-machine env --swarm swarm-master)"`` を使います。

.. Now you can use the Docker CLI to query:

Docker CLI を使うと、次のように表示されます。

.. code-block:: bash

   $ docker info
   Containers: 1
   Nodes: 1
    swarm-master: 192.168.99.100:2376
     └ Containers: 2
     └ Reserved CPUs: 0 / 4
     └ Reserved Memory: 0 B / 999.9 MiB


