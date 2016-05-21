.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/examples/ocean/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/examples/ocean.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/examples/ocean.md
.. check date: 2016/04/28
.. Commits on Apr 1, 2016 5d92f351de71ff4d842fd39b42e8fda738458965
.. ----------------------------------------------------------------------------

.. Digital Ocean example

==================================================
Digital Ocean の例
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Follow along with this example to create a Dockerized Digital Ocean Droplet (cloud host).

以下の例では Docker に対応した `Digital Ocean <https://digitalocean.com/>`_ ドロップレット（クラウド・ホスト）を作成します。

.. Step 1. Create a Digital Ocean account

ステップ１：Digital Ocean アカウントの作成
==================================================

.. If you have not done so already, go to Digital Ocean, create an account, and log in.

アカウントの取得がまだであれば、 `Digital Ocean <https://digitalocean.com/>`__ 上にアカウントを作成し、それからログインします。

.. Step 2. Generate a personal access token

ステップ２：自分のアクセス・トークンを生成
==================================================

.. To generate your access token:

アクセス・トークンを生成します。

..    Go to the Digital Ocean administrator console and click API in the header.

1. Digital Ocean 管理コンソールに移動し、ページ上方にある **API** をクリックします。

..    Click API in Digital Ocean console

..    Click Generate New Token to get to the token generator.

2. **Generate New Token** （新しいトークンの生成）をクリックして、トークンの生成に進みます。

..    Generate token

..    Give the token a clever name (e.g. “machine”), make sure the Write (Optional) checkbox is checked, and click Generate Token.

3. トークン名を指定し（例「machine」）、 **Write (Optional)** にチェックが入っているのを確認してから **Generate Token** （トークン生成）をクリックします。

..    Name and generate token

..    Grab (copy to clipboard) the generated big long hex string and store it somewhere safe.

4. 生成された長いバイナリ文字列を取得し（クリップボードにコピーします）、どこか安全な場所に保管します。

..    Copy and save personal access token

..    This is the personal access token you’ll use in the next step to create your cloud server.

これが次のクラウド・サーバの作成に必要となる、個人のアクセス・トークンです。

.. Step 3. Use Machine to create the Droplet

ステップ３：Machineを使ってドロップレットを作成
==================================================

..     Run docker-machine create with the digitalocean driver and pass your key to the --digitalocean-access-token flag, along with a name for the new cloud server.

1. ``docker-machine create`` コマンドの実行時に、 ``digitalocean`` ドライバと ``--digitalocean-access-token`` フラグで自分のキーを指定します。あわせて新しいクラウド・サーバ名も指定します。

..    For this example, we’ll call our new Droplet “docker-sandbox”.

次の例は、「docker-sandbox」という名前の新しいドロップレットを作成します。

.. code-block:: bash

   $ docker-machine create --driver digitalocean --digitalocean-access-token xxxxx docker-sandbox
   Running pre-create checks...
   Creating machine...
   (docker-sandbox) OUT | Creating SSH key...
   (docker-sandbox) OUT | Creating Digital Ocean droplet...
   (docker-sandbox) OUT | Waiting for IP address to be assigned to the Droplet...
   Waiting for machine to be running, this may take a few minutes...
   Machine is running, waiting for SSH to be available...
   Detecting operating system of created instance...
   Detecting the provisioner...
   Provisioning created instance...
   Copying certs to the local machine directory...
   Copying certs to the remote machine...
   Setting Docker configuration on the remote daemon...
   To see how to connect Docker to this machine, run: docker-machine env docker-sandbox

..    When the Droplet is created, Docker generates a unique SSH key and stores it on your local system in ~/.docker/machines. Initially, this is used to provision the host. Later, it’s used under the hood to access the Droplet directly with the docker-machine ssh command. Docker Engine is installed on the cloud server and the daemon is configured to accept remote connections over TCP using TLS for authentication.

Droplet が作成されたら、Docker はユニークな SSH 鍵を生成し、自分のローカル・システム上の ``~/.docker/machines`` に保存します。当初、この鍵はホストのプロビジョニング用に使われます。後ほど、 ``docker-machine ssh`` コマンドでドロップレットに簡単にアクセスするときにも使います。Docker Engine はクラウド・サーバ上にインストールされます。そして、TCP を通してリモートからの通信を受け付けられるように TLS 認証を使います。

..    Go to the Digital Ocean console to view the new Droplet.

2. Digital Ocean コンソールに移動し、新しいドロップレットの情報を確認します。

..    Droplet in Digital Ocean created with Machine

..    At the command terminal, run docker-machine ls.

3. コマンド・ターミナル上で ``docker-machine ls`` を実行します。

.. code-block:: bash

   $ docker-machine ls
   NAME             ACTIVE   DRIVER         STATE     URL                         SWARM
   default          -        virtualbox     Running   tcp://192.168.99.100:2376
   docker-sandbox   *        digitalocean   Running   tcp://45.55.139.48:2376

..    The new docker-sandbox machine is running, and it is the active host as indicated by the asterisk (*). When you create a new machine, your command shell automatically connects to it. If for some reason your new machine is not the active host, you’ll need to run docker-machine env docker-sandbox, followed by eval $(docker-machine env docker-sandbox) to connect to it.

新しい ``docker-sandbox`` マシンが実行されています。そして、アクティブなホストはアスタリスク（*）印が付いています。新しいマシンを作成したら、コマンド・シェルから自動的に接続できます。何らかの理由により、新しいマシンがアクティブなホストでない場合は ``docker-machine env docker-sandbox`` を実行し、反映するためには ``eval $(docker-machine env docker-sandbox)`` の実行が必要です。

.. Step 4. Run Docker commands on the Droplet

ステップ４：ドロップレット上で Docker コマンドを実行
====================================================

..    Run some docker-machine commands to inspect the remote host. For example, docker-machine ip <machine> gets the host IP adddress and docker-machine inspect <machine> lists all the details.

1. ``docker-machine`` コマンドを使ってリモート・ホストの情報を確認できます。例えば、 ``docker-machine ip <マシン名>`` はホスト側の IP アドレスを取得します。より詳しい情報は ``docker-machine inspect <マシン名>`` で確認できます。

.. code-block:: bash

   $ docker-machine ip docker-sandbox
   104.131.43.236
   
   $ docker-machine inspect docker-sandbox
   {
       "ConfigVersion": 3,
       "Driver": {
       "IPAddress": "104.131.43.236",
       "MachineName": "docker-sandbox",
       "SSHUser": "root",
       "SSHPort": 22,
       "SSHKeyPath": "/Users/samanthastevens/.docker/machine/machines/docker-sandbox/id_rsa",
       "StorePath": "/Users/samanthastevens/.docker/machine",
       "SwarmMaster": false,
       "SwarmHost": "tcp://0.0.0.0:3376",
       "SwarmDiscovery": "",
       ...

..    Verify Docker Engine is installed correctly by running docker commands.

2. Docker Engine が正しくインストールされたかどうか確認するため、 ``docker`` コマンドを実行します。

..    Start with something basic like docker run hello-world, or for a more interesting test, run a Dockerized webserver on your new remote machine.

``docker run hello-world`` のような基本的なコマンドを、新しいリモート・マシン上で実行します。あるいは、より面白いテストとなるよう Docker に対応したウェブサーバを実行します。

..    In this example, the -p option is used to expose port 80 from the nginx container and make it accessible on port 8000 of the docker-sandbox host.

次の例は ``-p`` オプションで ``nginx`` コンテナのポート 80 を公開できるようにし、それを ``docker-sandbox`` ホスト上のポート ``8000``  に割り当てます。

.. code-block:: bash

    $ docker run -d -p 8000:80 --name webserver kitematic/hello-world-nginx
    Unable to find image 'kitematic/hello-world-nginx:latest' locally
    latest: Pulling from kitematic/hello-world-nginx
    a285d7f063ea: Pull complete
    2d7baf27389b: Pull complete
    ...
    Digest: sha256:ec0ca6dcb034916784c988b4f2432716e2e92b995ac606e080c7a54b52b87066
    Status: Downloaded newer image for kitematic/hello-world-nginx:latest
    942dfb4a0eaae75bf26c9785ade4ff47ceb2ec2a152be82b9d7960e8b5777e65

..    In a web browser, go to http://<host_ip>:8000 to bring up the webserver home page. You got the <host_ip> from the output of the docker-machine ip <machine> command you ran in a previous step. Use the port you exposed in the docker run command.

ウェブブラウザで ``http://<ホストIP>:8000`` を開き、ウェブサーバのホームページを開きます。 ``ホストIP`` の確認は、先ほどの ``docker-machine ip <マシン名>`` コマンドで行いました。 ``docker run`` コマンドを実行したら、指定したポートを開きます。

..    nginx webserver

.. Step 5. Use Machine to remove the Droplet

ステップ５：Machineでドロップレットを削除
=========================================

.. To remove a host and all of its containers and images, first stop the machine, then use docker-machine rm:

ホストだけでなく全てのコンテナとイメージを削除するには、マシンを停止するために ``docker-machine rm`` を使います。

.. code-block:: bash

   $ docker-machine stop docker-sandbox
   $ docker-machine rm docker-sandbox
   Do you really want to remove "docker-sandbox"? (y/n): y
   Successfully removed docker-sandbox
   
   $ docker-machine ls
   NAME      ACTIVE   DRIVER       STATE     URL                         SWARM
   default   *        virtualbox   Running   tcp:////xxx.xxx.xx.xxx:xxxx

.. If you monitor the Digital Ocean console while you run these commands, you will see it update first to reflect that the Droplet was stopped, and then removed.

コマンドを実行後に Digital Ocean コンソールを確認したら、すぐにドロップレットが停止し、削除されるのが分かるでしょう。

.. If you create a host with Docker Machine, but remove it through the cloud provider console, Machine will lose track of the server status. So please use the docker-machine rm command for hosts you create with docker-machine create.

Docker Machine は作成したホストは、クラウド・プロバイダのコンソールからも削除できます。ただし Machine からは状況が追跡できなくなります。そのため、 ``docker-machine create`` で作成したホストは ``docker-machine rm`` をお使いください。

.. Where to go next

次はどちらへ
====================

..    Understand Machine concepts
    Docker Machine driver reference
    Docker Machine subcommand reference
    Provision a Docker Swarm cluster with Docker Machine

* :doc:`/machine/concepts`
* :doc:`/machine/drivers/index`
* :doc:`/machine/reference/index`
* :doc:`/swarm/provision-with-machine`

.. seealso:: 

   Digital Ocean example
      https://docs.docker.com/machine/examples/ocean/
