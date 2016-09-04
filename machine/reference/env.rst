.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/reference/env/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/reference/env.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/reference/env.md
.. check date: 2016/04/29
.. Commits on Jan 9, 2016 b585ca631b53fb54591b044764198f863b490816
.. ----------------------------------------------------------------------------

.. env

.. _machine-env:

=======================================
env
=======================================

.. Set environment variables to dictate that docker should run a command against a particular machine.

``docker`` コマンドの実行時に、特定のマシンを指し示せるような環境変数を表示します。

.. code-block:: bash

   $ docker-machine env --help
   
   使い方: docker-machine env [オプション] [引数...]
   
   Docker クライアント用の環境変数をセットアップするコマンドを表示
   
   説明:
      引数はマシン名。
   
   オプション:
   
      --swarm  Docker デーモンの代わりに Swarm の設定を表示
      --shell  環境変数を設定するシェルを指定: [fish, cmd, powershell, tcsh], デフォルトは sh/bash
      --unset, -u  環境変数の値を指定せずにリセット
      --no-proxy   マシンの IP アドレスに NO_PROXY 環境変数の追加

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. docker-machine env machinename will print out export commands which can be run in a subshell. Running docker-machine env -u will print unset commands which reverse this effect.

``docker-machine env マシン名`` を実行したら、サブシェル上で実行可能な ``export`` コマンドが表示されます。 ``docker-machine env -u`` を実行したら、この効果を無効化する ``unset`` コマンドを表示します。

.. code-block:: bash

   $ env | grep DOCKER
   $ eval "$(docker-machine env dev)"
   $ env | grep DOCKER
   DOCKER_HOST=tcp://192.168.99.101:2376
   DOCKER_CERT_PATH=/Users/nathanleclaire/.docker/machines/.client
   DOCKER_TLS_VERIFY=1
   DOCKER_MACHINE_NAME=dev
   $ # If you run a docker command, now it will run against that host.
   $ eval "$(docker-machine env -u)"
   $ env | grep DOCKER
   $ # The environment variables have been unset.

.. The output described above is intended for the shells bash and zsh (if you’re not sure which shell you’re using, there’s a very good possibility that it’s bash). However, these are not the only shells which Docker Machine supports. Depending of the environment you’re running your command into we will print them for the proper system. We support bash, cmd, powershell and emacs.

上の出力は ``bash`` や ``zsh`` シェル上での実行を想定したものです（どのシェルを使っているか分からなくても、大抵の場合は ``bash`` でしょう）。しかし、Docker Machine がサポートしているシェルはこれだけではありません。どのようなコマンドを使うかは、それぞれの環境にあわせる必要があります。現時点では ``bash`` 、 ``cmd`` 、 ``powershell`` 、 ``emacs`` のシステムをサポートしています。

.. If you are using fish and the SHELL environment variable is correctly set to the path where fish is located, docker-machine env name will print out the values in the format which fish expects:

もし ``fish`` を使っており、 ``SHELL`` 環境変数が ``fish`` のパスを適切に設定しているのであれば、 ``docker-machine env マシン名`` を実行したら、 ``fish`` を想定した形式で値を表示します。

.. code-block:: bash

   set -x DOCKER_TLS_VERIFY 1;
   set -x DOCKER_CERT_PATH "/Users/nathanleclaire/.docker/machine/machines/overlay";
   set -x DOCKER_HOST tcp://192.168.99.102:2376;
   set -x DOCKER_MACHINE_NAME overlay
   # Run this command to configure your shell:
   # eval "$(docker-machine env overlay)"

.. If you are on Windows and using either Powershell or cmd.exe, docker-machine env Docker Machine should now detect your shell automatically. If the automagic detection does not work you can still override it using the --shell flag for docker-machine env.

``docker-machine env`` コマンドはシェルを自動的に検出します。しかし、もし Windows でパワーシェルや ``cmd.exe`` を使う場合であれば、自動検出できません。そのため、 ``docker-machine env`` に自分で ``--shell`` フラグのオプションを上書き指定する必要があります。

.. For Powershell:

パワーシェルの例：

.. code-block:: bash

   $ docker-machine.exe env --shell powershell dev
   $Env:DOCKER_TLS_VERIFY = "1"
   $Env:DOCKER_HOST = "tcp://192.168.99.101:2376"
   $Env:DOCKER_CERT_PATH = "C:\Users\captain\.docker\machine\machines\dev"
   $Env:DOCKER_MACHINE_NAME = "dev"
   # Run this command to configure your shell:
   # docker-machine.exe env --shell=powershell dev | Invoke-Expression

.. For cmd.exe:

cmd.exe の例：

.. code-block:: bash

   $ docker-machine.exe env --shell cmd dev
   set DOCKER_TLS_VERIFY=1
   set DOCKER_HOST=tcp://192.168.99.101:2376
   set DOCKER_CERT_PATH=C:\Users\captain\.docker\machine\machines\dev
   set DOCKER_MACHINE_NAME=dev
   # Run this command to configure your shell: copy and paste the above values into your command prompt

.. Excluding the created machine from proxies

.. _excluding-the-created-machine-from-proxies:

プロキシを使わずにマシンを作成
==============================

.. The env command supports a --no-proxy flag which will ensure that the created machine’s IP address is added to the NO_PROXY/no_proxy environment variable.

env コマンドは ``--no-proxy`` フラグをサポートしています。これは、作成するマシンの IP アドレスに ``NO_PROXY`` / ``no_proxy`` `環境変数 <https://wiki.archlinux.org/index.php/Proxy_settings>`_ を追加します。

.. This is useful when using docker-machine with a local VM provider (e.g. virtualbox or vmwarefusion) in network environments where a HTTP proxy is required for internet access.

インターネットへのアクセスに HTTP プロキシが必要なネットワーク環境では、ローカルの仮想マシン・プロバイダ（例： ``virtualbox`` や ``vmwarefusion`` ）で ``docker-machine`` を使うのにこれが役立ちます。

.. code-block:: bash

   $ docker-machine env --no-proxy default
   export DOCKER_TLS_VERIFY="1"
   export DOCKER_HOST="tcp://192.168.99.104:2376"
   export DOCKER_CERT_PATH="/Users/databus23/.docker/machine/certs"
   export DOCKER_MACHINE_NAME="default"
   export NO_PROXY="192.168.99.104"
   # Run this command to configure your shell:
   # eval "$(docker-machine env default)"

.. You may also want to visit the documentation on setting HTTP_PROXY for the created daemon using the --engine-env flag for docker-machine create.

また、 :ref:`create 用の設定ドキュメント <specifying-configuration-options-for-the-created-docker-engine>` では、 ``docker-machine create`` コマンドで作成時に ``--engine-env`` フラグでデーモンの ``HTTP_PROXY`` を指定する方法も参考になるでしょう。

.. seealso:: 

   env
      https://docs.docker.com/machine/reference/env/

