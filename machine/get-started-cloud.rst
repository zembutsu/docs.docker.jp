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



To prepare the Docker client to send commands to the remote server we have created, we can use the subshell method again:

$ eval "$(docker-machine env staging)"

From this point, the remote host behaves much like the local host we created in the last section. If we look at docker-machine ls, we’ll see it is now the “active” host, indicated by an asterisk (*) in that column:


