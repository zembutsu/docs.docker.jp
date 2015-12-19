.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/install-machine/
.. doc version: 1.9
.. check date: 2015/12/19
.. -----------------------------------------------------------------------------

.. Install Docker Machine

=======================================
Docker Machine のインストール
=======================================

.. On OS X and Windows, Machine is installed along with other Docker products when you install the Docker Toolbox. For details on installing Docker Toolbox, see the Mac OS X installation instructions or Windows installation instructions.

OS X と Windows の場合、Docker Toolbox をインストールすることで、他の Docker プロダクトと一緒にインストールされます。Docker Toolbox の詳細は、:doc:`Mac OS X インストールガイド</engine/installation/mac>`  か :doc:`Windows インストールガイド</engine/installation/windows>` をご覧ください。

.. If you only want Docker Machine, you can install the Machine binaries (the latest versions of which are located at https://github.com/docker/machine/releases/ ) directly by following the instructions in the next section.

Docker Machine だけインストールしたい場合は、Machine のバイナリを（最新版は https://github.com/docker/machine/releases/ です）を直接インストールできます。詳細は次のセクションをご覧ください。

.. Installing Machine Directly

Machine を直接インストール
==============================

..    Install the Docker binary.

1. :doc:`Docker エンジン </engine/installation/index>` をインストールします。

..    Download the archive containing the Docker Machine binaries and extract them to your PATH.

2. Docker Machine のバイナリを含むアーカイブをダウンロードし、PATH に展開します。

..    Linux:

Linux：

.. code-block:: bash

   $ curl -L https://github.com/docker/machine/releases/download/v0.5.0/docker-machine_linux-amd64.zip >machine.zip && \
        unzip machine.zip && \
        rm machine.zip && \
        mv docker-machine* /usr/local/bin

..    OSX:

OS X：

.. code-block:: bash

   $ curl -L https://github.com/docker/machine/releases/download/v0.5.0/docker-machine_darwin-amd64.zip >machine.zip && \
        unzip machine.zip && \
        rm machine.zip && \
        mv docker-machine* /usr/local/bin


..    Windows (using Git Bash):

Windows（Git Bash を使う場合）：

.. code-block:: bash

   $ curl -L https://github.com/docker/machine/releases/download/v0.5.0/docker-machine_windows-amd64.zip >machine.zip && \
        unzip machine.zip && \
        rm machine.zip && \
        mv docker-machine* /usr/local/bin

..    Check the installation by displaying the Machine version:

3. Machine のバージョンを表示して、インストールを確認します。

.. code-block:: bash

   $ docker-machine -v
   machine version 0.5.0 (3e06852)

.. Installing bash completion scripts

bash 補完スクリプトのインストール
========================================

.. The Machine repository supplies several bash scripts that add features such as:

Machine 用のレポジトリには次の機能を持つ ``bash`` スクリプトがあります。

..    command completion
    a function that displays the active machine in your shell prompt
    a function wrapper that adds a docker-machine use subcommand to switch the active machine

* コマンド補完
* シェル・プロンプトにアクティブなホストを表示
* ``docker-machine use`` サブコマンドを追加し、アクティブなマシンを切り替えるラッパー

.. To install the scripts, copy or link them into your /etc/bash_completion.d or /usr/local/etc/bash_completion.d file. To enable the docker-machine shell prompt, add $(__docker-machine-ps1) to your PS1 setting in ~/.bashrc.

スクリプトをインストールするには、 ``/etc/bash_completion.d`` か ``/usr/local/etc/bash_completion.d`` にファイルをコピーするかリンクします。 ``docker-machine`` シェル・プロンプトを有効化するには、 ``~/.bashrc``  の ``PS1`` に ``$(__docker-machine-ps1)`` を追加します。

.. code-block:: bash

   PS1='[\u@\h \W$(__docker-machine-ps1)]\$ '

.. You can find additional documentation in the comments at the top of each script.

詳細なドキュメントについては、 `各スクリプト <https://github.com/docker/machine/tree/master/contrib/completion/bash>`_ の文頭にあるコメントをご覧ください。

.. Where to go next

次はどこへ
==========

..    Docker Machine overview
    Docker Machine driver reference
    Docker Machine subcommand reference

* :doc:`Docker Machine 概要 </machine/index>`
* :doc:`Docker Machine ドライバ・リファレンス </machine/drivers>`
* :doc:`Docker Machine サブコマンド・リファレンス </machine/reference>`



