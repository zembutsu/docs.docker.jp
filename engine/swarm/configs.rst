.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/swarm/configs/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/swarm/configs.md
   doc version: 19.03
.. -----------------------------------------------------------------------------

.. Store configuration data using Docker Configs

.. _store-configuration-data-using-docker-configs:

==========================================
Docker configs を利用した設定データの保存
==========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. ## About configs

.. _about-configs:

configs について
=================

.. Docker 17.06 introduces swarm service configs, which allow you to store
   non-sensitive information, such as configuration files, outside a service's
   image or running containers. This allows you to keep your images as generic
   as possible, without the need to bind-mount configuration files into the
   containers or use environment variables.

Docker 17.06 からスウォームサービスの configs が導入されました。
これは設定ファイルのようにそれほど重要ではない情報を、サービスイメージや稼働中のコンテナの外部に保存できる機能です。
これがあれば、ビルドイメージをできるだけ汎用的なものとして維持できます。
また設定ファイルをコンテナにバインドマウントしたり、環境変数を利用したりすることも不要になります。

.. Configs operate in a similar way to [secrets](secrets.md), except that they are
   not encrypted at rest and are mounted directly into the container's filesystem
   without the use of RAM disks. Configs can be added or removed from a service at
   any time, and services can share a config. You can even use configs in
   conjunction with environment variables or labels, for maximum flexibility.

configs は :doc:`secrets <secrets>` と同じように機能します。
ただし configs は保存の際に暗号化はされません。
またコンテナのファイルシステム内に直接マウントされますが、RAM ディスクは消費しません。
configs はサービスに対して、どのタイミングであっても追加および削除ができます。
またサービス間で 1 つの config を共有することもできます。
さらに configs と環境変数や Docker labels を組み合わせて利用できるので、最大限に柔軟性を持たせることができます。
configs の値には、通常の文字列やバイナリ（500 KB まで）を指定します。

.. > **Note**: Docker configs are only available to swarm services, not to
   > standalone containers. To use this feature, consider adapting your container
   > to run as a service with a scale of 1.

.. note::

   Docker configs はスウォームサービスにおいて利用可能であり、スタンドアロンのコンテナでは利用できません。
   この機能を利用するには、コンテナをサービスとして稼動させ、スケールは 1 としてください。

.. Configs are supported on both Linux and Windows services.

configs は Linux と Windows においてサポートされます。

.. ## How Docker manages configs

.. _how-docker-manages-configs:

Docker は configs をどう管理しているか
=======================================

.. When you add a config to the swarm, Docker sends the config to the swarm manager
   over a mutual TLS connection. The config is stored in the Raft log, which is
   encrypted. The entire Raft log is replicated across the other managers, ensuring
   the same high availability guarantees for configs as for the rest of the swarm
   management data.

スウォームに対して config を追加すると、Docker は TLS 相互接続によりスウォームマネージャーに対して config を送信します。
この config は Raft ログとして暗号化され保存されます。
Raft ログ全体は、他のマネージャーに向けて複製されますが、スウォームが管理するデータとともに configs の高可用性は確保されます。

.. When you grant a newly-created or running service access to a config, the config
   is mounted as a file in the container. The location of the mount point within
   the container defaults to `/<config-name>` in Linux containers. In Windows
   containers, configs are all mounted into `C:\ProgramData\Docker\configs` and
   symbolic links are created to the desired location, which defaults to
   `C:\<config-name>`.

新規生成したサービス、あるいは既存のサービスに対して config へのアクセス許可を行うと、config はコンテナ内において 1 つのファイルとしてマウントされます。
コンテナ内のマウントポイントのデフォルトは、Linux コンテナでは ``/<config-name>`` となります。
Windows コンテナの場合、configs はすべて ``C:\ProgramData\Docker\configs`` にマウントされ、
コンテナ内に必要となる config ターゲットが、シンボリックリンクとして生成されます。
config ターゲットのデフォルトは ``C:\<config-name>`` です。

.. You can update a service to grant it access to additional configs or revoke its
   access to a given config at any time.

configs を追加した際に、configs にアクセスできるようにサービスをアップデートしたり、configs を再読み込みしたりすることは、どのタイミングでも可能です。

.. A node only has access to configs if the node is a swarm manager or if it is
   running service tasks which have been granted access to the config. When a
   container task stops running, the configs shared to it are unmounted from the
   in-memory filesystem for that container and flushed from the node's memory.

configs へアクセスできるノードはスウォームマネージャか、あるいはその configs へのアクセスが許可された稼働中のサービスタスクです。
コンテナタスクが停止すると、共有されていた configs は、そのコンテナのメモリ内ファイルシステムからアンマウントされ、ノードのメモリからも消去されます。

.. If a node loses connectivity to the swarm while it is running a task container
   with access to a config, the task container still has access to its configs, but
   cannot receive updates until the node reconnects to the swarm.

config にアクセスしている稼働中のタスクコンテナが、スウォームとの接続を失った場合、そのタスクコンテナの config へのアクセスは維持されます。
ただし config の更新を受け取ることはできず、これができるようになるのはスウォームに再接続した後です。

.. You can add or inspect an individual config at any time, or list all
   configs. You cannot remove a config that a running service is
   using. See [Rotate a config](configs.md#example-rotate-a-config) for a way to
   remove a config without disrupting running services.

個々の config を追加したり確認したり、configs すべてを一覧したりすることはいつでもできます。
ただし稼働中のサービスが config を利用している場合は、それを削除できません。
:ref:`config の入れ替え <example-rotate-a-config>` では、実行中のサービスを中断することなく config を削除する方法について説明しています。

.. In order to update or roll back configs more easily, consider adding a version
   number or date to the config name. This is made easier by the ability to control
   the mount point of the config within a given container.

configs のアップデートやロールバックをより簡単に行うために、config 名にバージョン番号や日付をつけることを考えてみてください。
取り扱うコンテナの config マウントポイントを自由に管理できれば、より一層簡単になります。

.. ## Read more about `docker config` commands

.. _read-more-about-docker-config-commands:

``docker config`` コマンドについての詳細
=========================================

.. Use these links to read about specific commands, or continue to the
   [example about using configs with a service](configs.md#example-use-configs-with-a-service).

コマンドの詳細は以下のリンクを参照してください。
また :ref:`サービスにおける configs の利用例 <example-use-configs-with-a-service>` も参照してください。

.. - [`docker config create`](/engine/reference/commandline/config_create.md)
   - [`docker config inspect`](/engine/reference/commandline/config_inspect.md)
   - [`docker config ls`](/engine/reference/commandline/config_ls.md)
   - [`docker config rm`](/engine/reference/commandline/config_rm.md)

* :doc:`docker config create </engine/reference/commandline/config_create>`
* :doc:`docker config inspect </engine/reference/commandline/config_inspect>`
* :doc:`docker config ls </engine/reference/commandline/config_ls>`
* :doc:`docker config rm </engine/reference/commandline/config_rm>`

.. ## Examples

.. _examples:

利用例
=======

.. This section includes graduated examples which illustrate how to use
   Docker configs.

本節では Docker configs の利用例を段階的に示します。

.. > **Note**: These examples use a single-Engine swarm and unscaled services for
   > simplicity. The examples use Linux containers, but Windows containers also
   > support configs.

.. note::

   ここでの利用例では説明を簡単にするために、単一エンジンによるスウォームとスケールアップしていないサービスを用いることにします。
   Linux コンテナを例に用いますが、Windows コンテナでも configs はサポートされています。

.. ### Simple example: Get started with configs

.. _simple-example-get-started-with-configs:

簡単な例： configs を利用する
------------------------------

.. This simple example shows how configs work in just a few commands. For a
   real-world example, continue to
   [Intermediate example: Use configs with a Nginx service](#advanced-example-use-configs-with-a-nginx-service).

この簡単な例では、コマンドを少し書くだけで configs が動作することを示します。
現実的な例としては、:ref:`応用例: Nginx サービスに configs を利用する <advanced-example-use-configs-with-a-nginx-service>` に進んでください。

.. 1.  Add a config to Docker. The `docker config create` command reads standard
       input because the last argument, which represents the file to read the
       config from, is set to `-`.

1. Docker に config を追加します。
   この ``docker config create`` コマンドは、最後の引数により標準入力から読み込みを行います。
   最後の引数は config をどのファイルから読み込むかを示すものであって、ここではそれを ``-`` としています。

   .. ```bash
      $ echo "This is a config" | docker config create my-config -
      ```

   .. code-block:: bash

      $ echo "This is a config" | docker config create my-config -

   .. 2.  Create a `redis` service and grant it access to the config. By default,
          the container can access the config at `/my-config`, but
          you can customize the file name on the container using the `target` option.

2. ``redis`` サービスを生成し、config に対してのアクセスを許可します。
   デフォルトでコンテナは ``/my-config`` にある config へのアクセスが可能です。
   コンテナ内のそのファイル名は、``target`` オプションを使って変更することができます。

   ..  ```bash
       $ docker service  create --name redis --config my-config redis:alpine
       ```

   .. code-block:: bash

      $ docker service  create --name redis --config my-config redis:alpine

   .. 3.  Verify that the task is running without issues using `docker service ps`. If
          everything is working, the output looks similar to this:

3. ``docker service ps`` を実行して、タスクが問題なく実行しているかを確認します。
   問題がなければ、出力結果は以下のようになります。

   ..  ```bash
       $ docker service ps redis
   
       ID            NAME     IMAGE         NODE              DESIRED STATE  CURRENT STATE          ERROR  PORTS
       bkna6bpn8r1a  redis.1  redis:alpine  ip-172-31-46-109  Running        Running 8 seconds ago  
       ```

   .. code-block:: bash

      $ docker service ps redis

      ID            NAME     IMAGE         NODE              DESIRED STATE  CURRENT STATE          ERROR  PORTS
      bkna6bpn8r1a  redis.1  redis:alpine  ip-172-31-46-109  Running        Running 8 seconds ago  

   .. 4.  Get the ID of the `redis` service task container using `docker ps`, so that
          you can use `docker exec` to connect to the container and read the contents
          of the config data file, which defaults to being readable by all and has the
          same name as the name of the config. The first command below illustrates
          how to find the container ID, and the second and third commands use shell
          completion to do this automatically.

4. ``docker ps`` を実行して、``redis`` サービスのタスクコンテナに対する ID を取得します。
   これを使って ``docker container exec`` によりコンテナにアクセスして、config データファイルの内容を読み込むことができます。
   config データファイルはデフォルトで誰でも読むことができ、ファイル名は config 名と同じです。
   以下の最初のコマンドは、コンテナ ID を調べるものです。
   そして 2 つめと 3 つめは、シェルのコマンド補完を用いて自動的に入力しました。

   ..  ```bash
       $ docker ps --filter name=redis -q

       5cb1c2348a59

       $ docker exec $(docker ps --filter name=redis -q) ls -l /my-config

       -r--r--r--    1 root     root            12 Jun  5 20:49 my-config

       $ docker exec $(docker ps --filter name=redis -q) cat /my-config

       This is a config
       ```

   .. code-block:: bash

      $ docker ps --filter name=redis -q

      5cb1c2348a59

      $ docker exec $(docker ps --filter name=redis -q) ls -l /my-config

      -r--r--r--    1 root     root            12 Jun  5 20:49 my-config                                    


      $ docker exec $(docker ps --filter name=redis -q) cat /my-config

      This is a config

   .. 5.  Try removing the config. The removal fails because the `redis` service is
          running and has access to the config.

5. config を削除してみます。
   ただし削除には失敗します。
   これは ``redis`` サービスが稼働中であり、config にアクセスしているためです。

   ..  ```bash

       $ docker config ls

       ID                          NAME                CREATED             UPDATED
       fzwcfuqjkvo5foqu7ts7ls578   hello               31 minutes ago      31 minutes ago


       $ docker config rm my-config

       Error response from daemon: rpc error: code = 3 desc = config 'my-config' is
       in use by the following service: redis 
       ```

   .. code-block:: bash

      $ docker config ls

      ID                          NAME                CREATED             UPDATED
      fzwcfuqjkvo5foqu7ts7ls578   hello               31 minutes ago      31 minutes ago


      $ docker config rm my-config

      Error response from daemon: rpc error: code = 3 desc = config 'my-config' is
      in use by the following service: redis 

   .. 6.  Remove access to the config from the running `redis` service by updating the
          service.

6. ``redis`` サービスを更新して、稼働中のサービスからの config へのアクセスを取り除きます。

   ..  ```bash
       $ docker service update --config-rm my-config redis
       ```

   .. code-block:: bash

      $ docker service update --config-rm my-config redis

   .. 7.  Repeat steps 3 and 4 again, verifying that the service no longer has access
          to the config. The container ID will be different, because the
          `service update` command redeploys the service.

7. 手順の 3 と 4 を繰り返してみます。
   このときには、もう config へのアクセスが行われていません。
   コンテナ ID は異なるものになっています。
   ``service update`` コマンドを実行したので、サービスが再デプロイされたためです。

   ..  ```none
       $ docker exec -it $(docker ps --filter name=redis -q) cat /my-config

       cat: can't open '/my-config': No such file or directory
       ```

   .. code-block:: bash

      $ docker exec -it $(docker ps --filter name=redis -q) cat /my-config

      cat: can't open '/my-config': No such file or directory

   .. 8.  Stop and remove the service, and remove the config from Docker.

8. サービスを停止して削除します。
   そして Docker から config も削除します。

   ..  ```bash
       $ docker service rm redis

       $ docker config rm my-config
       ```

   .. code-block:: bash

      $ docker service rm redis

      $ docker config rm my-config

.. ### Simple example: Use configs in a Windows service

.. _simple-example-use-configs-in-a-windows-service:

簡単な例： Windows サービスにて configs を利用する
---------------------------------------------------

.. This is a very simple example which shows how to use configs with a Microsoft
   IIS service running on Docker 17.06 EE on Microsoft Windows Server 2016 or Docker
   for Windows 17.06 CE on Microsoft Windows 10. It stores the webpage in a config.

ここでの簡単な例は Windows 上において configs を利用するものです。
利用にあたっては、Microsoft Windows Server 2016 上の Docker 17.06 EE、または Microsoft Windows 10 上の Docker Windows 17.06 CE を用いて Microsoft IIS サービスを稼動させます。
この例は config 内にウェブページを保存します。

.. This example assumes that you have PowerShell installed.

PowerShell はインストール済であるとします。

.. 1.  Save the following into a new file `index.html`.

1. 以下のような ``index.html`` を新規生成して保存します。

   ..  ```html
       <html>
         <head><title>Hello Docker</title></head>
         <body>
           <p>Hello Docker! You have deployed a HTML page.</p>
         </body>
       </html>
       ```

   .. code-block:: html

      <html>
        <head><title>Hello Docker</title></head>
        <body>
          <p>Hello Docker! You have deployed a HTML page.</p>
        </body>
      </html>

.. 2.  If you have not already done so, initialize or join the swarm.

2. スウォームの初期化と参加を行っていない場合は、これを行います。

   ..  ```powershell
       PS> docker swarm init
       ```

   .. code-block:: powershell

      PS> docker swarm init

.. 3.  Save the `index.html` file as a swarm config named `homepage`.

3. ``index.html`` ファイルを、スウォームの config ファイルとして ``homepage`` という名前により保存します。

   ..  ```powershell
       PS> docker config create homepage index.html
       ```

   .. code-block:: powershell

      PS> docker config create homepage index.html

.. 4.  Create an IIS service and grant it access to the `homepage` config.

4. IIS サービスを生成して ``homepage`` config へのアクセスを許可します。

   ..  ```powershell
       PS> docker service create
           --name my-iis
           -p 8000:8000
           --config src=homepage,target="\inetpub\wwwroot\index.html"
           microsoft/iis:nanoserver  
       ```

   .. code-block:: powershell

      PS> docker service create
          --name my-iis
          -p 8000:8000
          --config src=homepage,target="\inetpub\wwwroot\index.html"
          microsoft/iis:nanoserver  

.. 5.  Access the IIS service at `http://localhost:8000/`. It should serve
       the HTML content from the first step.

5. IIS サービスを通じて ``http://localhost:8000/`` にアクセスします。
   手順 1 で作り出した HTML 内容が表示されるはずです。

.. 6.  Remove the service and the config.

6. サービスと config を削除します。

   ..  ```powershell
       PS> docker service rm my-iis

       PS> docker config rm homepage
       ```

   .. code-block:: powershell

      PS> docker service rm my-iis

      PS> docker config rm homepage

.. ### Advanced example: Use configs with a Nginx service

.. _advanced-example-use-configs-with-a-nginx-service:

応用例: Nginx サービスに configs を利用する
--------------------------------------------

.. This example is divided into two parts.
   [The first part](#generate-the-site-certificate) is all about generating
   the site certificate and does not directly involve Docker configs at all, but
   it sets up [the second part](#configure-the-nginx-container), where you store
   and use the site certificate as a series of secrets and the  Nginx configuration
   as a config.

この例は 2 つの部分から構成されます。
:ref:`1 つめの部分 <generate-the-site-certificate>` は、サーバ証明書の生成に関してです。
Docker configs とは直接関係がありません。
ただし :ref:`2 つめの部分 <configure-the-nginx-container>` において、一連の機密情報としてそのサーバ証明書を保存して利用します。
また Nginx の設定を config として保存します。
この例では config におけるオプションの設定方法を示しており、たとえばコンテナ内のターゲットを指定したり、ファイルパーミッションを指定したりしています。

.. #### Generate the site certificate

.. _generate-the-site-certificate:

サーバ証明書の生成
^^^^^^^^^^^^^^^^^^^

.. Generate a root CA and TLS certificate and key for your site. For production
   sites, you may want to use a service such as `Let’s Encrypt` to generate the
   TLS certificate and key, but this example uses command-line tools. This step
   is a little complicated, but is only a set-up step so that you have
   something to store as a Docker secret. If you want to skip these sub-steps,
   you can [use Let's Encrypt](https://letsencrypt.org/getting-started/) to
   generate the site key and certificate, name the files `site.key` and
   `site.crt`, and skip to
   [Configure the Nginx container](#configure-the-nginx-container).

自サイトに対しての root CA と TLS 証明書および鍵を生成します。
本番環境向けでは ``Let’s Encrypt`` のようなサービスを利用して、TLS 証明書や鍵を生成するかもしれませんが、この例ではコマンドラインツールを用いることにします。
ここでの手順は多少複雑です。
ただしここでは唯一、Docker secret を使って情報を保存する手順を示すものです。
この手順を行わない場合は、`Let's Encrypt の利用 <https://letsencrypt.org/getting-started/>`_ を通じて、サイトの鍵と証明書を生成し、それぞれを ``site.key``、``site.crt`` としてください。
その場合は :ref:`Nginx コンテナーの設定 <configure-the-nginx-container>` に進んでください。

.. 1.  Generate a root key.

1. root 鍵を生成します。

   ..  ```bash
       $ openssl genrsa -out "root-ca.key" 4096
       ```

   .. code-block:: bash

      $ openssl genrsa -out "root-ca.key" 4096

   .. 2.  Generate a CSR using the root key.

2. root 鍵を使って CSR を生成します。

   ..  ```bash
       $ openssl req \
                 -new -key "root-ca.key" \
                 -out "root-ca.csr" -sha256 \
                 -subj '/C=US/ST=CA/L=San Francisco/O=Docker/CN=Swarm Secret Example CA'
       ```

   .. code-block:: bash

      $ openssl req \
                -new -key "root-ca.key" \
                -out "root-ca.csr" -sha256 \
                -subj '/C=US/ST=CA/L=San Francisco/O=Docker/CN=Swarm Secret Example CA'

   .. 3.  Configure the root CA. Edit a new file called `root-ca.cnf` and paste
          the following contents into it. This constrains the root CA to only be
          able to sign leaf certificates and not intermediate CAs.

3. root CA を設定します。
   新規に ``root-ca.cnf`` というファイルを生成して、以下の内容を書き込みます。
   ここでは root CA をリーフ証明書として生成し、中間証明書とはしません。

   ..  ```none
       [root_ca]
       basicConstraints = critical,CA:TRUE,pathlen:1
       keyUsage = critical, nonRepudiation, cRLSign, keyCertSign
       subjectKeyIdentifier=hash
       ```

   ::

      [root_ca]
      basicConstraints = critical,CA:TRUE,pathlen:1
      keyUsage = critical, nonRepudiation, cRLSign, keyCertSign
      subjectKeyIdentifier=hash

   .. 4.  Sign the certificate.

4. 証明書にサインします。

   ..  ```bash
       $ openssl x509 -req  -days 3650  -in "root-ca.csr" \
                      -signkey "root-ca.key" -sha256 -out "root-ca.crt" \
                      -extfile "root-ca.cnf" -extensions \
                      root_ca
       ```

   .. code-block:: bash

      $ openssl x509 -req  -days 3650  -in "root-ca.csr" \
                     -signkey "root-ca.key" -sha256 -out "root-ca.crt" \
                     -extfile "root-ca.cnf" -extensions \
                     root_ca

   .. 5.  Generate the site key.

5. サイト鍵を生成します。

   ..  ```bash
       $ openssl genrsa -out "site.key" 4096
       ```

   .. code-block:: bash

      $ openssl genrsa -out "site.key" 4096

   .. 6.  Generate the site certificate and sign it with the site key.

6. サイト証明書を生成し、サイト鍵を用いてサインします。

   ..  ```bash
       $ openssl req -new -key "site.key" -out "site.csr" -sha256 \
                 -subj '/C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost'
       ```

   .. code-block:: bash

      $ openssl req -new -key "site.key" -out "site.csr" -sha256 \
                -subj '/C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost'

   .. 7.  Configure the site certificate. Edit a new file  called `site.cnf` and
          paste the following contents into it. This constrains the site
          certificate so that it can only be used to authenticate a server and
          can't be used to sign certificates.

7. サイト証明書を設定します。
   新規に ``site.cnf`` というファイルを生成して、以下の内容を書き込みます。
   この証明書はサーバを認証するためだけに用いるものとし、他の証明書のサインには用いることができないようにします。

   ..  ```none
       [server]
       authorityKeyIdentifier=keyid,issuer
       basicConstraints = critical,CA:FALSE
       extendedKeyUsage=serverAuth
       keyUsage = critical, digitalSignature, keyEncipherment
       subjectAltName = DNS:localhost, IP:127.0.0.1
       subjectKeyIdentifier=hash
       ```

   ::

      [server]
      authorityKeyIdentifier=keyid,issuer
      basicConstraints = critical,CA:FALSE
      extendedKeyUsage=serverAuth
      keyUsage = critical, digitalSignature, keyEncipherment
      subjectAltName = DNS:localhost, IP:127.0.0.1
      subjectKeyIdentifier=hash

   .. 8.  Sign the site certificate.

8. サイト証明書にサインします。

   ..  ```bash
       $ openssl x509 -req -days 750 -in "site.csr" -sha256 \
           -CA "root-ca.crt" -CAkey "root-ca.key"  -CAcreateserial \
           -out "site.crt" -extfile "site.cnf" -extensions server
       ```

   .. code-block:: bash

      $ openssl x509 -req -days 750 -in "site.csr" -sha256 \
          -CA "root-ca.crt" -CAkey "root-ca.key"  -CAcreateserial \
          -out "site.crt" -extfile "site.cnf" -extensions server

   .. 9.  The `site.csr` and `site.cnf` files are not needed by the Nginx service, but
          you will need them if you want to generate a new site certificate. Protect
          the `root-ca.key` file.

9. ``site.csr`` と ``site.cnf`` は Nginx サービスにとっては不要です。
   ただし新たなサイト証明書を生成する際には必要になります。
   ``root-ca.key`` は大事に保管しておきます。

.. #### Configure the Nginx container

.. _configure-the-nginx-container:

Nginx コンテナの設定
^^^^^^^^^^^^^^^^^^^^^

.. 1.  Produce a very basic Nginx configuration that serves static files over HTTPS.
       The TLS certificate and key will be stored as Docker secrets so that they
       can be rotated easily.

1. Nginx の基本的な設定として、HTTPS 越しにスタティックファイルを提供するものを用意します。
   TLS 証明書と鍵は Docker secrets として保存します。
   こうしておけば config の入れ替えも簡単に行うことができます。

   ..  In the current directory, create a new file called `site.conf` with the
       following contents:

   カレントディレクトリにおいて ``site.conf`` というファイルを新規生成し、内容を以下のようにします。

   ..  ```none
       server {
           listen                443 ssl;
           server_name           localhost;
           ssl_certificate       /run/secrets/site.crt;
           ssl_certificate_key   /run/secrets/site.key;

           location / {
               root   /usr/share/nginx/html;
               index  index.html index.htm;
           }
       }
       ```

   ::

      server {
          listen                443 ssl;
          server_name           localhost;
          ssl_certificate       /run/secrets/site.crt;
          ssl_certificate_key   /run/secrets/site.key;

          location / {
              root   /usr/share/nginx/html;
              index  index.html index.htm;
          }
      }

.. 2.  Create two secrets, representing the key and the certificate. You can store
       any file as a secret as long as it is smaller than 500 KB. This allows you
       to decouple the key and certificate from the services that will use them.
       In these examples, the secret name and the file name are the same.

2. 鍵と証明書を表わす Docker secrets を 2 つ生成します。
   Docker secrets はどのようなファイルであっても、サイズが 500 KB 以下であれば保存できます。
   こうして鍵と証明書は、これを利用するサービスから切り離すことができます。
   ここでの例では、secrets とファイル名は同一にしています。

   ..  ```bash
       $ docker secret create site.key site.key

       $ docker secret create site.crt site.crt
       ```

   .. code-block:: bash

      $ docker secret create site.key site.key

      $ docker secret create site.crt site.crt

.. 3.  Save the `site.conf` file in a Docker config. The first parameter is the
       name of the config, and the second parameter is the file to read it from.

3. Docker config の中に ``site.conf`` ファイルを保存します。
   第 1 パラメータは config 名、第 2 パラメータはそれを読み込むファイル名です。

   ..  ```bash
       $ docker config create site.conf site.conf
       ```

   .. code-block:: bash

      $ docker config create site.conf site.conf

   .. List the configs:

   configs の一覧を確認します。

   ..  ```bash
       $ docker config ls

       ID                          NAME                CREATED             UPDATED
       4ory233120ccg7biwvy11gl5z   site.conf           4 seconds ago       4 seconds ago
       ```

   .. code-block:: bash

      $ docker config ls

      ID                          NAME                CREATED             UPDATED
      4ory233120ccg7biwvy11gl5z   site.conf           4 seconds ago       4 seconds ago

.. 4.  Create a service that runs Nginx and has access to the two secrets and the
       config.

4. Nginx を起動するサービスを生成し、2 つの secrets と config へのアクセスを許可します。

   ..  ```bash
       $ docker service create \
            --name nginx \
            --secret site.key \
            --secret site.crt \
            --config source=site.conf,target=/etc/nginx/conf.d/site.conf \
            --publish 3000:443 \
            nginx:latest \
            sh -c "exec nginx -g 'daemon off;'"
       ```

   .. code-block:: bash

      $ docker service create \
           --name nginx \
           --secret site.key \
           --secret site.crt \
           --config source=site.conf,target=/etc/nginx/conf.d/site.conf \
           --publish 3000:443 \
           nginx:latest \
           sh -c "exec nginx -g 'daemon off;'"

   .. Within the running containers, the following three files now exist:

   稼動中のコンテナ内部では、以下の 3 つのファイルが存在しています。

   ..  - `/run/secrets/site.key`
       - `/run/secrets/site.crt`
       - `/etc/nginx/conf.d/site.conf`

   * ``/run/secrets/site.key``
   * ``/run/secrets/site.crt``
   * ``/etc/nginx/conf.d/site.conf``

.. 5.  Verify that the Nginx service is running.

5. Nginx サービスが起動していることを確認します。

   ..  ```bash
       $ docker service ls

       ID            NAME   MODE        REPLICAS  IMAGE
       zeskcec62q24  nginx  replicated  1/1       nginx:latest

       $ docker service ps nginx

       NAME                  IMAGE         NODE  DESIRED STATE  CURRENT STATE          ERROR  PORTS
       nginx.1.9ls3yo9ugcls  nginx:latest  moby  Running        Running 3 minutes ago
       ```

   .. code-block:: bash

      $ docker service ls

      ID            NAME   MODE        REPLICAS  IMAGE
      zeskcec62q24  nginx  replicated  1/1       nginx:latest

      $ docker service ps nginx

      NAME                  IMAGE         NODE  DESIRED STATE  CURRENT STATE          ERROR  PORTS
      nginx.1.9ls3yo9ugcls  nginx:latest  moby  Running        Running 3 minutes ago

.. 6.  Verify that the service is operational: you can reach the Nginx
       server, and that the correct TLS certificate is being used.

6. そのサービスが操作可能であることを確認します。
   つまり Nginx サーバーへアクセスができ、正しい TLS 証明書が用いられていることを確認します。

   ..  ```bash
       $ curl --cacert root-ca.crt https://0.0.0.0:3000

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
       ```

   .. code-block:: bash

      $ curl --cacert root-ca.crt https://0.0.0.0:3000

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

   ..  ```bash
       $ openssl s_client -connect 0.0.0.0:3000 -CAfile root-ca.crt

       CONNECTED(00000003)
       depth=1 /C=US/ST=CA/L=San Francisco/O=Docker/CN=Swarm Secret Example CA
       verify return:1
       depth=0 /C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost
       verify return:1
       ---
       Certificate chain
        0 s:/C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost
          i:/C=US/ST=CA/L=San Francisco/O=Docker/CN=Swarm Secret Example CA
       ---
       Server certificate
       -----BEGIN CERTIFICATE-----
       …
       -----END CERTIFICATE-----
       subject=/C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost
       issuer=/C=US/ST=CA/L=San Francisco/O=Docker/CN=Swarm Secret Example CA
       ---
       No client certificate CA names sent
       ---
       SSL handshake has read 1663 bytes and written 712 bytes
       ---
       New, TLSv1/SSLv3, Cipher is AES256-SHA
       Server public key is 4096 bit
       Secure Renegotiation IS supported
       Compression: NONE
       Expansion: NONE
       SSL-Session:
           Protocol  : TLSv1
           Cipher    : AES256-SHA
           Session-ID: A1A8BF35549C5715648A12FD7B7E3D861539316B03440187D9DA6C2E48822853
           Session-ID-ctx:
           Master-Key: F39D1B12274BA16D3A906F390A61438221E381952E9E1E05D3DD784F0135FB81353DA38C6D5C021CB926E844DFC49FC4
           Key-Arg   : None
           Start Time: 1481685096
           Timeout   : 300 (sec)
           Verify return code: 0 (ok)
       ```

   .. code-block:: bash

      $ openssl s_client -connect 0.0.0.0:3000 -CAfile root-ca.crt

      CONNECTED(00000003)
      depth=1 /C=US/ST=CA/L=San Francisco/O=Docker/CN=Swarm Secret Example CA
      verify return:1
      depth=0 /C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost
      verify return:1
      ---
      Certificate chain
       0 s:/C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost
         i:/C=US/ST=CA/L=San Francisco/O=Docker/CN=Swarm Secret Example CA
      ---
      Server certificate
      -----BEGIN CERTIFICATE-----
      …
      -----END CERTIFICATE-----
      subject=/C=US/ST=CA/L=San Francisco/O=Docker/CN=localhost
      issuer=/C=US/ST=CA/L=San Francisco/O=Docker/CN=Swarm Secret Example CA
      ---
      No client certificate CA names sent
      ---
      SSL handshake has read 1663 bytes and written 712 bytes
      ---
      New, TLSv1/SSLv3, Cipher is AES256-SHA
      Server public key is 4096 bit
      Secure Renegotiation IS supported
      Compression: NONE
      Expansion: NONE
      SSL-Session:
          Protocol  : TLSv1
          Cipher    : AES256-SHA
          Session-ID: A1A8BF35549C5715648A12FD7B7E3D861539316B03440187D9DA6C2E48822853
          Session-ID-ctx:
          Master-Key: F39D1B12274BA16D3A906F390A61438221E381952E9E1E05D3DD784F0135FB81353DA38C6D5C021CB926E844DFC49FC4
          Key-Arg   : None
          Start Time: 1481685096
          Timeout   : 300 (sec)
          Verify return code: 0 (ok)

.. 7.  Unless you are going to continue to the next example, clean up after running
       this example by removing the `nginx` service and the stored secrets and
       config.

7. この例を実行した後に、次に示す例は確認しないのであれば、``nginx`` サービスと保存した secrets、config を削除します。

   ..  ```bash
       $ docker service rm nginx

       $ docker secret rm site.crt site.key

       $ docker config rm site.conf
       ```

   .. code-block:: bash

      $ docker service rm nginx

      $ docker secret rm site.crt site.key

      $ docker config rm site.conf

.. You have now configured a Nginx service with its configuration decoupled from
   its image. You could run multiple sites with exactly the same image but
   separate configurations, without the need to build a custom image at all.

ここまでの例から Nginx サービスの設定内容を、そのイメージから切り離した形で実現しました。
まったく同じイメージを使い異なる設定によって複数サイトを提供しようと思ったら、もう新たなイメージをビルドする必要はなくなったわけです。

.. ### Example: Rotate a config

.. _example-rotate-a-config:

例： config の入れ替え
-----------------------

.. To rotate a config, you first save a new config with a different name than the
   one that is currently in use. You then redeploy the service, removing the old
   config and adding the new config at the same mount point within the container.
   This example builds upon the previous one by rotating the `site.conf`
   configuration file.

config を入れ替えるには、まず新たな config を、現在利用している config とは別の名前で保存しておきます。
そしてサービスを再デプロイし、古い config を削除して、コンテナ内の同一マウントポイントに新たな config を追加します。
ここに示す例では、前述の例をもとにして、``site.conf`` という設定ファイルを切り替える方法を示します。

.. 1.  Edit the `site.conf` file locally. Add `index.php` to the `index` line, and
       save the file.

1. ローカルの ``site.conf`` ファイルを編集します。
   ``index`` 行に ``index.php`` を追加し保存します。

   ..  ```none
       server {
           listen                443 ssl;
           server_name           localhost;
           ssl_certificate       /run/secrets/site.crt;
           ssl_certificate_key   /run/secrets/site.key;

           location / {
               root   /usr/share/nginx/html;
               index  index.html index.htm index.php;
           }
       }
       ```

   ::

      server {
          listen                443 ssl;
          server_name           localhost;
          ssl_certificate       /run/secrets/site.crt;
          ssl_certificate_key   /run/secrets/site.key;

          location / {
              root   /usr/share/nginx/html;
              index  index.html index.htm index.php;
          }
      }

.. 2.  Create a new Docker config using the new `site.conf`, called `site-v2.conf`.

2. 上の ``site.conf`` ファイルを使って、新たな ``site-v2.conf`` という Docker config を生成します。

   ..  ```bah
       $ docker config create site-v2.conf site.conf
       ```

   .. code-block:: bash

      $ docker config create site-v2.conf site.conf

.. 3.  Update the `nginx` service to use the new config instead of the old one.

3. ``nginx`` サービスを更新して、古い config から新しい config を利用するようにします。

   ..  ```bash
       $ docker service update \
         --config-rm site.conf \
         --config-add source=site-v2.conf,target=/etc/nginx/conf.d/site.conf \
         nginx
       ```

   .. code-block:: bash

      $ docker service update \
        --config-rm site.conf \
        --config-add source=site-v2.conf,target=/etc/nginx/conf.d/site.conf \
        nginx

.. 4.  Verify that the `nginx` service is fully re-deployed, using
       `docker service ls nginx`. When it is, you can remove the old `site.conf`
       config.

4. ``docker service ps nginx`` を実行して、``nginx`` サービスが問題なく再デプロイされていることを確認します。
   正常であれば、古い config つまり ``site.conf`` を削除します。

   ..  ```bash
       $ docker config rm site.conf
       ```

   .. code-block:: bash

      $ docker config rm site.conf

.. 5.  To clean up, you can remove the `nginx` service, as well as the secrets and
       configs.

5. クリーンアップします。
   ``nginx`` サービスを削除し、同じく secrets と configs も削除します。

   ..  ```bash
       $ docker service rm nginx

       $ docker secret rm site.crt site.key

       $ docker config rm site-v2.conf
       ```

   .. code-block:: bash

      $ docker service rm nginx

      $ docker secret rm site.crt site.key

      $ docker config rm site-v2.conf

.. You have now updated your `nginx` service's configuration without the need to
   rebuild its image.

こうして ``nginx`` サービスの設定は、イメージを再ビルドすることなく更新することができました。


.. seealso:: 

   Store configuration data using Docker Configs
      https://docs.docker.com/engine/swarm/configs/
