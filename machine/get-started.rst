.. http://docs.docker.com/machine/get-started/

.. _get-started:

.. Get started with Docker Machine and local VM

=========================================
Docker Machine をローカル VM で始めるには
=========================================

.. Let’s take a look at using docker-machine for creating, using, and managing a Docker host inside of VirtualBox.

`VirtualBox <https://www.virtualbox.org/>`_ 上で、``docker-machine`` を使った Docker ホストの作成・使用・管理を見ていきましょう。

.. First, ensure that VirtualBox 4.3.28 is correctly installed on your system.

まず、 `VirtualBox 4.3.28 <https://www.virtualbox.org/wiki/Downloads>`_ がシステム上に正しくインストールしているのを確認します。

.. If you run the docker-machine ls command to show all available machines, you will see that none have been created so far.

ここで ``docker-machine ls`` コマンドを実行すると、利用可能な全てのマシンを表示しますが、この時点ではまだホストを作成していません。

.. code-block:: bash

   $ docker-machine ls
   NAME   ACTIVE   DRIVER   STATE   URL

.. To create one, we run the docker-machine create command, passing the string virtualbox to the --driver flag. The final argument we pass is the name of the machine - in this case, we will name our machine “dev”.

``docker-machine create`` コマンドを使い、１つ作成します。ここでは ``--driver`` フラグに ``virtualbox`` 文字列を与えます。最後の引数はマシン名を追加します。この例ではマシンに対して "dev" という名前を付けます。

このコマンドは軽量な Linux ディストリビューション（ `boot2docker <https://github.com/boot2docker/boot2docker>`_ ）をダウンロードし、Docker デーモンをインストールします。それから Docker が実行する VirtualBox 仮想マシンを起動します。

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

.. You can see the machine you have created by running the docker-machine ls command again:

作成したマシンを見るには、再び ``docker-machine ls`` コマンドを実行します。

.. code-block:: bash

   $ docker-machine ls
   NAME   ACTIVE   DRIVER       STATE     URL                         SWARM
   dev             virtualbox   Running   tcp://192.168.99.100:2376

.. Next, as noted in the output of the docker-machine create command, we have to tell Docker to talk to that machine. You can do this with the docker-machine env command. For example,

次に、 ``docker-machine create`` コマンドの出力に注目します。その仮想マシンに対して Docker が通信できるようにしなくてはいけません。これを ``docker-machine env`` コマンドによって行います。例えば,次のように実行します。

.. code-block:: bash

   $ eval "$(docker-machine env dev)"
   $ docker ps

..    Note: If you are using fish, or a Windows shell such as Powershell/cmd.exe the above method will not work as described. Instead, see the env command’s documentation to learn how to set the environment variables for your shell.

.. note::

   もし ``fish`` や Powershell や ``cmd.exe`` のような Windows シェルを使っている場合、先ほどのコマンドをそのまま入力しても動作しません。その代わり、 :doc:`envコマンドのドキュメント </machine/#env>` を参照し、シェルに適した環境変数の設定方法を学んでください。

.. This will set environment variables that the Docker client will read which specify the TLS settings. Note that you will need to do that every time you open a new tab or restart your machine.

これは Docker クライアントが特定の TLS 設定を読み込むよう環境変数を指定します。新しいタブを開いたり、マシンを再起動する度に、毎回実行する必要があるので注意してください。

.. To see what will be set, run docker-machine env dev.

何が設定されるか確認するには、 ``docker-machine env dev`` コマンドを実行します。

.. code-block:: bash

   $ docker-machine env dev
   export DOCKER_TLS_VERIFY="1"
   export DOCKER_HOST="tcp://172.16.62.130:2376"
   export DOCKER_CERT_PATH="/Users/<your username>/.docker/machine/machines/dev"
   export DOCKER_MACHINE_NAME="dev"
   # Run this command to configure your shell:
   # eval "$(docker-machine env dev)"

..You can now run Docker commands on this host:

これで対象となるホスト上で Docker コマンドを実行できます。

.. code-block:: bash

   $ docker run busybox echo hello world
   Unable to find image 'busybox' locally
   Pulling repository busybox
   e72ac664f4f0: Download complete
   511136ea3c5a: Download complete
   df7546f9f060: Download complete
   e433a6c5b276: Download complete
   hello world

.. Any exposed ports are available on the Docker host’s IP address, which you can get using the docker-machine ip command:

Docker ホスト上でポートを公開している場合、ホストの IP アドレスは ``docker-machine ip`` コマンドで調べられます。

.. code-block:: bash

   $ docker-machine ip dev
   192.168.99.100

.. For instance, you can try running a webserver (nginx in a container with the following command:

例えば、ウェブサーバ（コンテナ内には `nginx <https://www.nginx.com/>`_ ）を次のように実行します。

.. code-block::bash

   $ docker run -d -p 8000:80 nginx

.. When the image is finished pulling, you can hit the server at port 8000 on the IP address given to you by docker-machine ip. For instance:

イメージの取得が終われば、``docker-machine ip`` コマンドで取得した IP アドレスで、サーバの 8000 ポートにアクセスします。以下は実行例です。

.. code-block:: bash

   $ curl $(docker-machine ip dev):8000
   <!DOCTYPE html>
   <html>
   <head>
   <title>Welcome to nginx!</title>
   <style>
       body {
           width: 35em;
           margin: 0 auto;
           font-family: Tahoma, Verdana, Arial, sans-serif;
       }
   </style>
   </head>
   <body>
   <h1>Welcome to nginx!</h1>
   <p>If you see this page, the nginx web server is successfully installed and
   working. Further configuration is required.</p>
   
   <p>For online documentation and support please refer to
   <a href="http://nginx.org/">nginx.org</a>.<br/>
   Commercial support is available at
   <a href="http://nginx.com/">nginx.com</a>.</p>
   
   <p><em>Thank you for using nginx.</em></p>
   </body>
   </html>

.. You can create and manage as many local VMs running Docker as you please- just run docker-machine create again. All created machines will appear in the output of docker-machine ls.

ローカルで Docker が動く仮想環境を多く作成・管理するには、同様に ``docker-machine create`` を実行します。作成したマシンを全て表示するには ``docker-machine ls`` を実行します。

.. If you are finished using a host for the time being, you can stop it with docker-machine stop and later start it again with docker-machine start. Make sure to specify the machine name as an argument:

対象のホストを暫く使わないのであれば、 ``docker-machine stop`` で停止し、後から再び ``docker-machine start`` で開始できます。マシン名を引数として必ず指定してください。

.. code-block:: bash

   $ docker-machine stop dev
   $ docker-machine start dev
