.. *- coding: utf-8 -*-
.. URL: https://docs.docker.com/faqs/troubleshoot/
.. check date: 2016/04/04
.. -------------------------------------------------------------------

.. Troubleshooting:

.. _docker-toolbox-troubleshooting:

========================================
トラブルシューティング
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Typically, the QuickStart works out-of-the-box, but some scenarios can cause problems.

通常 QuickStart は難しい設定など一切なく利用できます。しかし、いくつかの場合に問題が起こるかもしれません。

.. Example errors

.. _example-errors:

エラー例
==========

.. You might get errors when attempting to connect to a machine (such as with docker-machine env default) or pull an image from Docker Hub (as with docker run hello-world).

マシン（ ``docker-machine env default`` など）に接続しようとする時や Docker Hub からイメージの取得時（ ``docker run hello-world`` ）に、エラーが発生するかもしれません。

.. The errors you get might be specific to certificates, like this:

エラーは次のように証明書に関するものかもしれません。

.. code-block:: bash

   Error checking TLS connection: Error checking and/or regenerating the certs: There was an error validating certificates for host "192.168.99.100:2376": dial tcp 192.168.99.100:2376: i/o timeout

.. Others will explicitly suggest regenerating certificates:

あるいは、証明書の再作成を促すでしょう。

.. code-block:: bash

   Error checking TLS connection: Error checking and/or regenerating the certs: There was an error validating certificates for host "192.168.99.100:2376": x509: certificate is valid for 192.168.99.101, not 192.168.99.100
   You can attempt to regenerate them using 'docker-machine regenerate-certs [name]'.
   Be advised that this will trigger a Docker daemon restart which will stop running containers.

.. Or, indicate a network timeout, like this:

あるいは、ネットワークのタイムアウトを表示するかもしれません。

.. code-block:: bash

   bash-3.2$ docker run hello-world
   Unable to find image 'hello-world:latest' locally
   Pulling repository docker.io/library/hello-world
   Network timed out while trying to connect to https://index.docker.io/v1/repositories/library/hello-world/images. You may want to check your internet connection or if you are behind a proxy.
   bash-3.2$

.. Solutions

.. _toolbox-soluitons:

解決法
==========

.. Here are some quick solutions to help get back on track. These examples assume the Docker host is a machine called default.

正しい状態に戻すために、迅速な解決方法を示します。これらの例では Docker ホストが動くマシンを ``default`` と呼びます。

.. Regenerate certificates

.. _regenerate-certificate:

証明書の再作成
--------------------

.. Some errors explicitly tell you to regenerate certificates. You might also try this for other errors that are certificate and /or connectivity related.

エラー発生時、証明書の再作成が指示される場合があります。エラーを出なくするためには、接続可能な証明書の再作成を試みてください。

.. code-block:: bash

   $ docker-machine regenerate-certs default
   Regenerate TLS machine certs?  Warning: this is irreversible. (y/n): y
   Regenerating TLS certificates

.. Restart the Docker host

.. _restart-the-docker-host:

Docker ホストの再起動
------------------------------

.. code-block:: bash

   $ docker-machine restart default

.. After the machine starts, set the environment variables for the command window.

Machine を起動したら、コマンドライン上で環境変数を指定します。

.. code-block:: bash

   $ eval $(docker-machine env default)

.. Run docker-machine ls to verify that the machine is running and that this command window is configured to talk to it, as indicated by an asterisk for the active machine (*).

``docker-machine ls`` コマンドを実行し、マシンが実行中であることと、コマンドライン上で通信可能なことを確認します。アクティブなマシン（ACTIVE の列）にアスタリスク（*）が付いているのがわかります。

.. code-block:: bash

   $ docker-machine ls
   NAME             ACTIVE   DRIVER         STATE     URL                         SWARM   DOCKER    ERRORS
   default          *        virtualbox     Running   tcp://192.168.99.101:2376           v1.10.1

.. Stop the machine, remove it, and create a new one.

マシンを停止・削除し、あたらしいマシンを作成
--------------------------------------------------

.. code-block:: bash

   $ docker-machine stop default
     Stopping "default"...
     Machine "default" was stopped.
   
   $ docker-machine rm default
     About to remove default
     Are you sure? (y/n): y
     Successfully removed default

.. You can use the command docker-machine create command with the virtualbox driver to create a new machine called default (or any name you want for the machine).

``docker-machine create`` コマンドに ``virtualbox`` ドライバを指定し、 ``default`` という名前のマシン（あるいは任意のマシン名称）を作成できます。

.. code-block:: bash

   $ docker-machine create --driver virtualbox default
     Running pre-create checks...
     (default) Default Boot2Docker ISO is out-of-date, downloading the latest release...
     (default) Latest release for github.com/boot2docker/boot2docker is v1.10.1
     (default) Downloading
     ...
     Docker is up and running!
     To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env default

.. Set the environment variables for the command window.

環境変数を指定するには、以下のコマンドを実行します。

.. code-block:: bash

   $ eval $(docker-machine env default)

.. Run docker-machine ls to verify that the new machine is running and that this command window is configured to talk to it, as indicated by an asterisk for the active machine (*).

``docker-machine ls`` コマンドを実行し、マシンが実行中であることと、コマンドライン上で通信可能なことを確認します。アクティブなマシン（ACTIVE の列）にアスタリスク（*）が付いているのがわかります。

.. HTTP proxies and connectivity errors

.. _HTTP-proxies-and-connectivity-erros:

HTTP プロキシと接続に関するエラー
========================================

.. A special brand of connectivity errors can be caused by HTTP proxy. If you install Docker Toolbox on a system using a virtual private network (VPN) that uses an HTTP proxy (such as a corporate network), you might encounter errors when the client attempts to connect to the server.

HTTP プロキシによって接続に関する特殊なエラーが発生する場合があります。VPN を使うシステム上に Docker Toolbox をインストールしている時、HTTP プロキシを使うと（あるいは企業内のネットワークにおいて）、クライアントがサーバに接続できないというエラーが発生します。

.. Here are examples of this type of error:

この種のエラーは以下のようなものです。

.. code-block:: bash

   $ docker run hello-world
   An error occurred trying to connect: Post https://192.168.99.100:2376/v1.20/containers/create: Forbidden
   
   $ docker run ubuntu echo "hi"
   An error occurred trying to connect: Post https://192.168.99.100:2376/v1.20/containers/create: Forbidden

.. Configuring HTTP proxy settings on Docker machines

.. _configuring-http-proxy-settings-on-docker-mahines:

Docker マシンに HTTP プロキシを設定
----------------------------------------

.. When Toolbox creates virtual machines (VMs) it runs start.sh, where it gets values for HTTP_PROXY, HTTPS_PROXY and NO_PROXY, and passes them as create options to create the default machine.

Toolbox は仮想マシンを作成するため ``start.sh`` を実行します。ここに ``HTTP_PROXY`` や ``HTTPS_PROXY`` や ``NO_PROXY``  など ``default machine`` の ``create`` （作成時）オプションを指定します。

.. You can reconfigure HTTP proxy settings for private networks on already-created Docker machines (e.g., default), then change the configuration when you are using the same system on a different network.

既に作成された Docker Machine （例： ``default`` ）でも、プライベートのネットワーク上に対応した HTTP プロキシの再設定を行えます。設定を変えると、異なったネットワーク上でも同じシステムを利用可能です。

.. Alternatively, you can modify proxy settings on your machine(s) manually through the configuration file at /var/lib/boot2docker/profile inside the VM, or configure proxy settings as a part of a docker-machine create command.

他にも、仮想マシン内にある ``/var/lib/boot2docker/profile``  ファイルのプロキシ設定を自分で直接書き換える方法と、 ``docker-machine create`` コマンド実行時にプロキシの指定をする方法があります。

.. Both solutions are described below.

どちらも詳細な方法は、以下で説明します。

.. Update /var/lib/boot2docker/profile on the Docker machine

.. _update-profile-on-the-docker-mahicne:

Docker マシン上の ``/var/lib/boot2docker/profile`` を更新
------------------------------------------------------------

.. One way to solve this problem is to update the file /var/lib/boot2docker/profile on an existing machine to specify the proxy settings you want.

この問題を解決する方法の１つに、既存マシン上の ``/var/lib/boot2docker/profile`` ファイルを編集し、任意のプロキシを指定することです。

.. This file lives on the VM itself, so you have to ssh into the machine, then edit and save the file there.

ファイルは仮想マシン自身が持っているため、マシンには ``ssh`` でログインしてファイルを編集・保存する必要があります。

.. You can add your machine addresses as values for a NO_PROXY setting, and also speicify proxy servers that you know about and you want to use. Typically setting your Docker machine URLs to NO_PROXY solves this type of connectivity problem, so that example is shown here.

マシンの設定で``NO_PROXY`` の値を指定すると、ここで指定した環境はプロキシ・サーバを通らないようにします。URL に対して接続の問題が起こる典型的な例が、Docker Machine の URL です。具体的には以下の通りです。

..    Use ssh to log in to the virtual machine (e.g., default).

1. 仮想マシン（例： ``default`` ）にログインします。

.. code-block:: bash

   $ docker-machine ssh default
   docker@default:~$ sudo vi /var/lib/boot2docker/profile

..    Add a NO_PROXY setting to the end of the file similar to the example below.

2. 以下の例のように、ファイルの末尾に ``NO_PROXY`` の設定を追加します。

    # 以下は皆さんのオフィスの PROXY 環境に置き換えてください
    export "HTTP_PROXY=http://PROXY:PORT"
    export "HTTPS_PROXY=http://PROXY:PORT"
    # プロキシを通したくない環境を NO_PROXY で指定します
    export "NO_PROXY=192.168.99.*,*.local,169.254/16,*.example.com,192.168.59.*"

..    Restart Docker.

3. Docker を再起動します。

..     After you modify the profile on your VM, restart Docker and log out of the machine.

仮想マシンの ``profile`` を変更したら、Docker を再起動して、マシンからログアウトします。

.. code-block:: bash

   docker@default:~$ sudo /etc/init.d/docker restart
   docker@default:~$ exit

.. Re-try Docker commands. Both Docker and Kitematic should run properly now.

Docker コマンドを再度試します。これで Docker も Kitematic も適切に動作するでしょう。

.. When you move to a different network (for example, leave the office’s corporate network and return home), remove or comment out these proxy settings in /var/lib/boot2docker/profile and restart Docker.

異なるネットワークに移動する時は（例えば会社のオフィス・ネットワークを離れ、家に帰った時）、 ``/var/lib/boot2docker/profile`` の設定を変更し、Docker を再起動します。

.. Create machines manually using --engine env to specify proxy settings

マシン作成時に ``--engine env`` でプロキシ設定をする方法
------------------------------------------------------------

.. Rather than reconfigure automatically-created machines, you can delete them and create your default machine and others manually with the docker-machine create command, using the --engine env flag to specify the proxy settings you want.

自動作成されたマシンの設定を変えると、 ``default`` として作成したマシンを削除できます。他の方法として ``docker-machine create``  時に ``--engine env`` フラグで任意のプロキシを設定する方法があります。

.. Here is an example of creating a default machine with proxies set to http://example.com:8080 and https://example.com:8080, and a N0_PROXY setting for the server example2.com.

次の例は ``default`` マシンの作成時、PROXY として ``http://example.com:8080`` と ``https://example.com:8080``  を指定し、 ```NO_PROXY` として ``example2.com``  を指定しています。

.. code-block:: bash

   docker-machine create -d virtualbox \
   --engine-env HTTP_PROXY=http://example.com:8080 \
   --engine-env HTTPS_PROXY=https://example.com:8080 \
   --engine-env NO_PROXY=example2.com \
   default

.. To learn more about using docker-machine create, see the create command in the Docker Machine reference.

``docker-machine create`` の詳しい使い方は :doc:`Docker Machine </machine/overview>` リファレンスの :doc:`create </machine/reference/create>` をご覧ください。

.. seealso:: 

   Troubleshooting
      https://docs.docker.com/faqs/troubleshoot/

