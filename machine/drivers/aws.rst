.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/drivers/aws/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/drivers/aws.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/drivers/aws.md
.. check date: 2016/04/28
.. Commits on Mar 16, 2016 ab559c542f2a3a4534b14b4c16300344412a93a3
.. ----------------------------------------------------------------------------

.. Amazon Web Services

.. _driver-amazon-web-services:

=======================================
Amazon Web Services
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Create machines on Amazon Web Services. 

`Amazon Web Services <http://aws.amazon.com/>`_ 上にマシンを作成します。

.. To create machines on Amazon Web Services, you must supply two parameters: the AWS Access Key ID and the AWS Secret Access Key.

 `Amazon Seb Services <http://aws.amazon.com/>`__ 上にマシンを作成するには、次の３つのパラメータが必要です：アクセス・キー ID、シークレット・アクセスキー、VPC ID 。

.. Configuring credentials

.. _configuring-credentials:

認証ファイルの設定
====================

.. Before using the amazonec2 driver, ensure that you’ve configured credentials.

.. AWS credential file

AWS 認証情報ファイル
--------------------

amazonec2 ドライバを使う前に、認証情報の設定が必要です。

.. One way to configure credentials is to use the standard credential file for Amazon AWS ~/.aws/credentials file, which might look like:

認証情報を設定する１つの方法は、Amazon AWS用の認証情報をファイル ``~/.aws/credentials`` に置くことです。次のような書式です。

.. code-block:: bash

   [default]
   aws_access_key_id = AKID1234567890
   aws_secret_access_key = MY-SECRET-KEY

.. You can learn more about the credentials file from this blog post.

.. このファイルの詳細な使い方は、こちらの `ブログ投稿 <http://blogs.aws.amazon.com/security/post/Tx3D6U6WSFGOK2H/A-New-and-Standardized-Way-to-Manage-Credentials-in-the-AWS-SDKs>`_  をご覧ください。


.. On Mac OS or various flavors of Linux you can install the AWS Command Line Interface (aws cli) in the terminal and use the aws configure command which guides you through the creation of the credentials file.

Mac や Linux ディストリビューションでは、 `AWS コマンドライン・インターフェース <http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html#cli-quick-configuration>`_ （ ``aws cli`` ）をターミナルにインストールし、 ``aws configure`` コマンドで認証情報ファイルを作成します。

.. This is the simplest method, you can then create a new machine with:

これが最も簡単にマシンを作成できる方法です。

.. code-block:: bash

   $ docker-machine create --driver amazonec2 aws01

コマンドラインのフラグ
------------------------------

他には、コマンドライン上で ``--amazonec2-access-key`` と ``--amazonec2-secret-key`` フラグを使う方法があります。

.. code-block:: bash

   $ docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key 8T93C*******  aws01

環境変数
----------

環境変数も使えます。

.. code-block:: bash

   $ export AWS_ACCESS_KEY_ID=AKID1234567890
   $ export AWS_SECRET_ACCESS_KEY=MY-SECRET-KEY
   $ docker-machine create --driver amazonec2 aws01


.. Options

オプション
==========

..    --amazonec2-access-key: required Your access key id for the Amazon Web Services API.
    --amazonec2-secret-key: required Your secret access key for the Amazon Web Services API.
    --amazonec2-session-token: Your session token for the Amazon Web Services API.
    --amazonec2-ami: The AMI ID of the instance to use.
    --amazonec2-region: The region to use when launching the instance.
    --amazonec2-vpc-id: required Your VPC ID to launch the instance in.
    --amazonec2-zone: The AWS zone to launch the instance in (i.e. one of a,b,c,d,e).
    --amazonec2-subnet-id: AWS VPC subnet id.
    --amazonec2-security-group: AWS VPC security group name.
    --amazonec2-instance-type: The instance type to run.
    --amazonec2-root-size: The root disk size of the instance (in GB).
    --amazonec2-iam-instance-profile: The AWS IAM role name to be used as the instance profile.
    --amazonec2-ssh-user: SSH Login user name.
    --amazonec2-request-spot-instance: Use spot instances.
    --amazonec2-spot-price: Spot instance bid price (in dollars). Require the --amazonec2-request-spot-instance flag.
    --amazonec2-private-address-only: Use the private IP address only.
    --amazonec2-monitoring: Enable CloudWatch Monitoring.

* ``--amazonec2-access-key`` : **必須** 自分の Amazon Web Services API 用のアクセス・キー緒です。
* ``--amazonec2-secret-key`` : **必須** 自分の Amazon Web Services API 用のシークレット・アクセスキーです。
* ``--amazonec2-session-token`` :  自分の Amazon Web Services API 用のセッション・トークンです。
* ``--amazonec2-ami`` : インスタンスに使用する AMI ID です。
* ``--amazonec2-region`` : インスタンスを起動するリージョンです。
* ``--amazonec2-vpc-id`` : **必須** 起動したインスタンスを置く VPC ID です。
* ``--amazonec2-zone`` : インスタンスを置く AWS ゾーンです（例： a, b, c, d, e のいずれか）。
* ``--amazonec2-subnet-id`` : AWS VPC サブネット ID です。
* ``--amazonec2-security-group`` : AWS VPC セキュリティ・グループ名です。
* ``--amazonec2-tags`` : AWS タグをキーバリューのペアで指定します（カンマ区切りです。例： key1,value1,key2,value2）。
* ``--amazonec2-instance-type`` : 実行するインスタンス・タイプです。
* ``--amazonec2-device-name`` : 実行するデバイス名です。
* ``--amazonec2-root-size`` : インスタンスのルート・ディスク容量（単位：GB）。
* ``--amazonec2-volume-type`` : インスタンスにアタッチする Amazon EBS の種類を指定。
* ``--amazonec2-iam-instance-profile`` : インスタンスのプロファイルに使われる AWS IAM ロール名。
* ``--amazonec2-ssh-user`` : SSH ログイン・ユーザ名です。ここには AMI が使うデフォルトの SSH ユーザと一致する必要があります。
* ``--amazonec2-request-spot-instance`` : スポット・インスタンスを使用。
* ``--amazonec2-spot-price`` : スポット・インスタンスの bid 価格（単位：ドル）。 ``--amazonec2-request-spot-instance`` フラグが必要です。
* ``--amazonec2-use-private-addressce`` : docker-machine の通信にプライベート IP アドレスを使います。ですがパブリックな IP アドレスも作成されます。
* ``--amazonec2-private-address-only`` : プライベート・アドレスのみ使います。
* ``--amazonec2-monitoring`` : CloudWatch モニタリングを有効化します。
* ``--amazonec2-user-ebs-optimized-instance`` :  EBS 最適化インスタンスを作成します。インスタンス・タイプが対応している必要があります。
* ``--amazonec2-ssh-keypath`` : インスタンス用のプライベート・キーに使うファイルのパスを指定します。対応する公開鍵の拡張子は .pub になっている必要があります。


.. Environment variables and default values:

環境変数とデフォルト値は以下の通りです。

.. list-table::
   :header-rows: 1
   
   * - コマンドライン・オプション
     - 環境変数
     - デフォルト値
   * - ``--amazonec2-access-key``
     - ``AWS_ACCESS_KEY_ID``
     - -
   * - ``--amazonec2-secret-key``
     - ``AWS_SECRET_ACCESS_KEY``
     - -
   * - ``--amazonec2-session-token``
     - ``AWS_SESSION_TOKEN``
     - -
   * - ``--amazonec2-ami``
     - ``AWS_AMI``
     - ``ami-5f709f34``
   * - ``--amazonec2-region``
     - ``AWS_DEFAULT_REGION``
     - ``us-east-1``
   * - ``--amazonec2-vpc-id``
     - ``AWS_VPC_ID``
     - -
   * - ``--amazonec2-vpc-id``
     - ``AWS_VPC_ID``
     - -
   * - ``--amazonec2-zone``
     - ``AWS_ZONE``
     - ``a``
   * - ``--amazonec2-subnet-id``
     - ``AWS_SUBNET_ID``
     - -
   * - ``--amazonec2-security-group``
     - ``AWS_SECURITY_GROUP``
     - ``docker-machine``
   * - ``--amazonec2-instance-type``
     - ``AWS_INSTANCE_TYPE``
     - ``t2.micro``
   * - ``--amazonec2-device-name``
     - ``AWS_DEVICE_NAME``
     - ``/dev/sda``
   * - ``--amazonec2-root-size``
     - ``AWS_ROOT_SIZE``
     - ``16``
   * - ``--amazonec2-volume-type``
     - ``AWS_VOLUME_TYPE``
     - ``gp2``
   * - ``--amazonec2-iam-instance-profile``
     - ``AWS_INSTANCE_PROFILE``
     - -
   * - ``--amazonec2-ssh-user``
     - ``AWS_SSH_USER``
     - ``ubuntu``
   * - ``--amazonec2-request-spot-instance``
     - -
     - ``false``
   * - ``--amazonec2-spot-price``
     - -
     - ``0.50``
   * - ``--amazonec2-user-private-address``
     - -
     - ``false``
   * - ``--amazonec2-private-address-only``
     - -
     - ``false``
   * - ``--amazonec2-monitoring``
     - -
     - ``false``
   * - ``--amazonec2-use-ebs-optimized-instance``
     - -
     - ``false``
   * - ``--amazonec2-ssh-keypath``
     - ``AWS_SSH_KEYPATH``
     - -

.. Default AMIs

デフォルト AMI
====================

.. By default, the Amazon EC2 driver will use a daily image of Ubuntu 15.10 LTS.

デフォルトでは、Amazon EC2 ドライバは Ubuntu 15.10 LTS の daily イメージを使います。

.. list-table::
   :header-rows: 1
   
   * - リージョン
     - AMI ID
   * - ap-northeast-1
     - ami-b36d4edd
   * - ap-southeast-1
     - ami-1069af73
   * - ap-southeast-2
     - ami-1d336a7e
   * - cn-north-1
     - ami-79eb2214
   * - eu-west-1
     - ami-8aa67cf9
   * - eu-central-1
     - ami-ab0210c7
   * - sa-east-1
     - ami-185de774
   * - us-east-1
     - ami-26d5af4c
   * - us-west-1
     - ami-9cbcd2fc
   * - us-west-2
     - ami-16b1a077
   * - us-gov-west-1
     -  ami-b0bad893

.. Security Group

.. _machine-security-group:

セキュリティ・グループ
==============================

.. Note that a security group will be created and associated to the host. This security group will have the following ports opened inbound:

セキュリティ・グループが作成され、ホストに関連付けられるのでご注意ください。セキュリティ・グループは以下のインバウンド通信を許可します。

* ssh (22/tcp)
* docker (2376/tcp)
* swarm (3376/tcp) ノードが Swarm マスタの場合のみです

.. If you specify a security group yourself using the --amazonec2-security-group flag, the above ports will be checked and opened and the security group modified. If you want more ports to be opened, like application specific ports, use the aws console and modify the configuration manually.

このポート以外にポートを開くには、 ``--amazonec2-security-group`` フラグを使って自分でセキュリティ・グループを指定し、ポートが開かれたか確認します。特定のアプリケーションが必要とするポートを開きたい場合は、AWS コンソールで設定を調整ください。

.. VPC ID

.. _machine-vpc-id:

VPC ID
==========

.. We determine your default vpc id at the start of a command. In some cases, either because your account does not have a default vpc, or you don’t want to use the default one, you can specify a vpc with the --amazonec2-vpc-id flag.

コマンドを実行する前に、自分のデフォルト VPC を確認します。時々、デフォルトの VPC がなかったり、あるいはデフォルトの VPC を使いたくない場合があるでしょう。VPC を指定するには ``--amazonec2-vpc-id`` フラグを使います。

.. To find the VPC ID:

VPC ID を確認するには：

..    Login to the AWS console
    Go to Services -> VPC -> Your VPCs.
    Locate the VPC ID you want from the VPC column.
    Go to Services -> VPC -> Subnets. Examine the Availability Zone column to verify that zone a exists and matches your VPC ID.

1. AWS コンソールにログインします。
2. **Services -> VPC -> VPC -> 自分の VPC** に移動します。
3. *VPC* 列から使用する VPC ID を選びます。
4. **Services -> VPC -> Subnets** に移動します。 *Availability Zones* 列を確認し、ゾーン ``a`` が存在しているのと、自分の VPC ID と一致していることを確認します。

..    For example, us-east1-a is in the a availability zone. If the a zone is not present, you can create a new subnet in that zone or specify a different zone when you create the machine.

例えば、 ``us-east1-a`` にはアベイラビリティ・ゾーン ``a`` が存在しています。もし ``a`` ゾーンが表示されなければ、マシンを作成するために、新しいサブネットを作成するか別のゾーンを指定します。

.. To create the machine instance, specify --driver amazonec2 and the three required parameters.

マシン・インスタンスを作成するには、 ``--driver amazonec2`` と３つの必須パラメータを指定します。

.. code-block:: bash

   $ docker-machine create --driver amazonec2 --amazonec2-access-key AKI******* --amazonec2-secret-key 8T93C********* --amazonec2-vpc-id vpc-****** aws01

.. This example assumes the VPC ID was found in the a availability zone. Use the--amazonec2-zone flag to specify a zone other than the a zone. For example, --amazonec2-zone c signifies us-east1-c.

この例では、 VPC ID が ``a`` アベイラビリティ・ゾーンに存在しているものと想定されます。 ``a`` ゾーン以外を指定するには、 ``--amazonec2-zone`` フラグを使います。例えば、 ``--amazonec2-zone c`` は ``us-east1-c`` を表しています。

.. VPC Connectivity

.. _vpc-connectivity:

VPC の接続性
====================

.. Machine uses SSH to complete the set up of instances in EC2 and requires the ability to access the instance directly.

Machine は SSH を使い EC2 インスタンス上にセットアップします。その時、インスタンスに直接接続できるようにする必要があります。

.. If you use the flag --amazonec2-private-address-only, you will need to ensure that you have some method of accessing the new instance from within the internal network of the VPC (e.g. a corporate VPN to the VPC, a VPN instance inside the VPC or using Docker-machine from an instance within your VPC).

フラグ ``--amazonec2-private-address-only``  を使うときは、VPC の内部ネットワーク内で新しいインスタンスを作成できるようにする必要があります（例：社内の VPN から VPC の接続、VPC 内の VPN インスタンス、VPC 内で Docker Machine インスタンスを使う）。

.. VPC Set up

.. _vpc-set-up:

VPC セットアップ
====================

.. Configuration of VPCs is beyond the scope of this guide, however the first step in troubleshooting is ensuring if you are using private subnets that you follow the design guidance in the AWS VPC User Guide and have some form of NAT available so that the set up process can access the internet to complete set up.

VPC の設定はこのドキュメントの範囲外ですが、トラブルシューティングの始めのステップとして、 `AWS VPC ユーザガイド <http://docs.aws.amazon.com/ja_jp/AmazonVPC/latest/UserGuide/VPC_Scenario2.html>`_ のガイダンスから、NAT の利用に関する情報をご覧ください。インターネットに接続するためのセットアップに関する、全ての手順が書かれています。

.. Custom AMI and SSH username

.. _custom-ami-and-ssh-username:

カスタム AMI と SSH ユーザ名
==============================

.. The default SSH username for the default AMIs is ubuntu.

デフォルト AMI 用のデフォルト SSH ユーザ名は ``ubuntu`` です。

.. You need to change the SSH username only if the custom AMI you use has a different SSH username.

カスタム AMI が異なった SSH ユーザ名を使っている場合、この SSH ユーザ名の設定を変更する必要があります。

.. You can change the SSH username with the --amazonec2-ssh-user according to the AMI you selected with the --amazonec2-ami.

``--amazonec2-ami`` で指定した AMI が必要とする SSH ユーザ名を ``--amazonec2-ssh-user``  で指定します。

.. seealso:: 

   Amazon Web Services
      https://docs.docker.com/machine/drivers/aws/
