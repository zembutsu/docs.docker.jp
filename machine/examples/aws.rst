.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/examples/aws/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/examples/aws.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/examples/aws.md
.. check date: 2016/04/28
.. Commits on Apr 1, 2016 5d92f351de71ff4d842fd39b42e8fda738458965
.. ----------------------------------------------------------------------------

.. Amazon Web Services (AWS) EC2 example

==================================================
Amazon Web Services (AWS) EC2 の例
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Follow along with this example to create a Dockerized Amazon Web Services (AWS) EC2 instance.

以下の例では Docker に対応した `Amazon Web Services (AWS) <https://aws.amazon.com/>`_ EC2 インスタンスを作成します。

.. Step 1. Sign up for AWS and configure credentials

ステップ１：AWS にサインアップして証明書を取得
==================================================

..    If you are not already an AWS user, sign up for AWS to create an account and get root access to EC2 cloud computers.

1. まだ AWS の利用者でなければ、 `AWS <https://aws.amazon.com/>`__ にサインアップし、EC2 クラウド・コンピュータに対して root アクセスを持つアカウントを作成します。

..    If you have an Amazon account, you can use it as your root user account.

既に Amazon アカウントをお持ちであれば、自分の root ユーザ・アカウントを利用できます。

..    Create an IAM (Identity and Access Management) administrator user, an admin group, and a key pair associated with a region.

2. IAM (Identity and Access Management) 管理ユーザと管理グループを作成し、リージョンに鍵ペアを関連づけます。

..    From the AWS menus, select Services > IAM to get started.

まず、AWS メニューの **サービス** から **IAM** を選びます。

..    To create machines on AWS, you must supply two parameters:

AWS 上でマシンを作成するには、２つのパラメータが必要です。

..        an AWS Access Key ID
..        an AWS Secret Access Key

* AWS アクセスキー
* AWS シークレットアクセスキー

..    See the AWS documentation on Setting Up with Amazon EC2. Follow the steps for “Create an IAM User” and “Create a Key Pair”.

AWS にある `Amazon EC2 でのセットアップ <http://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/get-set-up-for-amazon-ec2.html>`_ のドキュメントをご覧ください。この中にある「IAM ユーザーを作成する」「キーペアを作成する」の各手順を進めます。

.. Step 2. Use Machine to create the instance

ステップ２：Machine でインスタンスを作成
========================================

..    Optionally, create an AWS credential file.

1. オプションで AWS 認証用ファイルを作成できます。

..    You can create an ~/.aws/credentials file to hold your AWS keys so that you don’t have to type them every time you run the docker-machine create command. Here is an example of a credentials file.

``~/.aws/credentials`` ファイルを作成し、AWS 鍵を記述できます。そうしておけば、 ``docker-machine create`` コマンドを実行する度に入力する必要はありません。以下が認証用ファイルの例です。

::

   [default]
   aws_access_key_id = AKID1234567890
    aws_secret_access_key = MY-SECRET-KEY

..    Run docker-machine create with the amazonec2 driver, your keys, and a name for the new instance.

2. ``docker-machine create`` コマンドの実行時、 ``amazonec2`` ドライバと鍵と新しいインスタンス名を指定します。

..    Using a credentials file

**認証用ファイルを使う場合**

..    If you specified your keys in a credentials file, this command looks like this to create an instance called aws-sandbox:

鍵を認証用ファイルに入れている場合は、次のコマンドを実行すると ``aws-sandbox`` という名前のインスタンスを起動します。

.. code-block:: bash

   $ docker-machine create --driver amazonec2 aws-sandbox

..    Specifying keys at the command line

**鍵をコマンドラインで指定する場合**

..    If you don’t have a credentials file, you can use the flags --amazonec2-access-key and --amazonec2-secret-key on the command line:

認証用ファイルを使わない場合は、コマンドラインで ``--amazonec2-access-key`` と ``--amazonec2-secret-key`` を指定します。

.. code-block:: bash

   $ docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key 8T93C*******  aws-sandbox

..    Specifying a region

**リージョンの指定**

..    By default, the driver creates new instances in region us-east-1 (North Virginia). You can specify a different region by using the --amazonec2-region flag. For example, this command creates a machine called “aws-01” in us-west-1 (Northern California).

デフォルトでは、ドライバは新しいインスタンスを us-east-1 (North Virginia) リージョンで作成します。別のリージョンで作成するには ``--amazonec2-region`` フラグを使います。例えば「aws-01」マシンを us-west-1 (Northern California)で作成するには、次のように実行します。

.. code-block:: bash

   $ docker-machine create --driver amazonec2 --amazonec2-region us-west-1 aws-01

..    Go to the AWS EC2 Dashboard to view the new instance.

3. AWS EC2 ダッシュボードに移動し、新しいインスタンスを確認します。

..    Log into AWS with your IAM credentials, and navigate to your EC2 Running Instances.

AWS に IAM 証明書でログインし、EC2 実行中のインスタンスの画面に移動します。

..    instance on AWS EC2 Dashboard

..    Note: Make sure you set the region appropriately from the menu in the upper right; otherwise, you won’t see the new instance. If you did not specify a region as part of docker-machine create (with the optional --amazonec2-region flag), then the region will be US East, which is the default.

.. note::

   メニュー右上で対象のリージョンを選択してください。そうすると、インスタンスが見えるでしょう。 ``docker-machine create`` 実行時にリージョンを指定しなければ（オプションの ``--amazonec2-region`` フラグを使う）、デフォルトでは US East リージョンになります。

..    At the command terminal, run docker-machine ls.

4. コマンド・ターミナル上で ``docker-machine ls`` を実行します。

.. code-block:: bash

   $ docker-machine ls
   NAME             ACTIVE   DRIVER         STATE     URL                         SWARM   DOCKER        ERRORS      
   aws-sandbox      *        amazonec2      Running   tcp://52.90.113.128:2376            v1.10.0       
   default          -        virtualbox     Running   tcp://192.168.99.100:2376           v1.10.0-rc4   
   aws-sandbox      -        digitalocean   Running   tcp://104.131.43.236:2376           v1.9.1        

..     The new aws-sandbox instance is running, and it is the active host as indicated by the asterisk (*). When you create a new machine, your command shell automatically connects to it. If for some reason your new machine is not the active host, you’ll need to run docker-machine env aws-sandbox, followed by eval $(docker-machine env aws-sandbox) to connect to it.

新しい ``aws-sandbox`` マシンが実行されています。そして、アクティブなホストはアスタリスク（*）印が付いています。新しいマシンを作成すると、コマンド・シェルから自動的に接続できます。何らかの理由により、新しいマシンがアクティブなホストでない場合は ``docker-machine env aws-sandbox`` を実行し、反映するためには ``eval $(docker-machine env aws-sandbox)`` の実行が必要です。

.. Step 3. Run Docker commands on the instance

ステップ３：インスタンス上で Docker コマンドを実行
==================================================

..    Run some docker-machine commands to inspect the remote host. For example, docker-machine ip <machine> gets the host IP address and docker-machine inspect <machine> lists all the details.

1. ``docker-machine`` コマンドを使ってリモート・ホストの上方を確認できます。例えば、 ``docker-machine ip <マシン名>`` はホスト側の IP アドレスを取得します。より詳しい情報は ``docker-machine inspect <マシン名>`` で確認できます。

.. code-block:: bash

   $ docker-machine ip
   192.168.99.100
   
   $ docker-machine inspect aws-sandbox
   {
       "ConfigVersion": 3,
       "Driver": {
        "IPAddress": "52.90.113.128",
        "MachineName": "aws-sandbox",
        "SSHUser": "ubuntu",
        "SSHPort": 22,
        ...

..     Verify Docker Engine is installed correctly by running docker commands.

2. Docker Engine が正しくインストールされたかどうか確認するため、 ``docker`` コマンドを実行します。

..    Start with something basic like docker run hello-world, or for a more interesting test, run a Dockerized webserver on your new remote machine.

``docker run hello-world`` のような基本的なコマンドを、新しいリモート・マシン上で実行します。あるいは、より面白いテストとなるよう Docker に対応したウェブサーバを実行します。

..    In this example, the -p option is used to expose port 80 from the nginx container and make it accessible on port 8000 of the aws-sandbox host.

次の例は ``-p`` オプションで ``nginx`` コンテナのポート 80 を公開できるようにし、それを ``aws-sandbox`` ホスト上のポート ``8000``  に割り当てます。

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

ウェブブラウザで ``http://<ホストIP>:8000`` を開き、ウェブサーバのホームページを開きます。 ``ホストIP`` の確認は、先ほどの ``docker-machine ip <マシン名>`` コマンドで行いました。 ``docker run`` コマンドを実行すると、指定したポートを開きます。

..    nginx webserver

.. Step 4. Use Machine to remove the instance

ステップ４：Machineでインスタンスを削除
========================================

.. To remove an instance and all of its containers and images, first stop the machine, then use docker-machine rm:

ホストだけでなく全てのコンテナとイメージを削除するには、マシンを停止するために ``docker-machine rm`` を使います。

.. code-block:: bash

   $ docker-machine stop aws-sandbox
   $ docker-machine rm aws-sandbox
   Do you really want to remove "aws-sandbox"? (y/n): y
   Successfully removed aws-sandbox

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

   Amazon Web Services (AWS) EC2 example
      https://docs.docker.com/machine/examples/aws/

