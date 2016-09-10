.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/install-machine/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/install-machine.md
   doc version: 1.11
      https://github.com/docker/machine/commits/master/docs/install-machine.md
.. check date: 2016/04/28
.. Commits on Apr 22, 2016 a3af149774645d61187ab0989d1e5f103bf667ad
.. -------------------------------------------------------------------

.. Install Docker Machine

=======================================
Docker Machine のインストール
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. On OS X and Windows, Machine is installed along with other Docker products when you install the Docker Toolbox. For details on installing Docker Toolbox, see the Mac OS X installation instructions or Windows installation instructions.

OS X と Windows の場合は、Docker Toolbox をインストールしたら、他の Docker プロダクトと一緒にインストールします。Docker Toolbox の詳細は、:doc:`Mac OS X インストールガイド</engine/installation/mac>`  か :doc:`Windows インストールガイド</engine/installation/windows>` をご覧ください。

.. If you want only Docker Machine, you can install the Machine binaries directly by following the instructions in the next section. You can find the latest versions of the binaries are on the docker/machine release page on GitHub.

Docker Machine だけインストールしたい場合は、Machine のバイナリを直接インストールできます。詳細は次のセクションをご覧ください。また、最新版のバイナリは GitHub 上の `docker/machine リリース・ページ <https://github.com/docker/machine/releases/>`_ 上で確認できます。

.. Installing Machine Directly

.. _installing-machine-directly:

Machine を直接インストール
==============================

..    Install the Docker binary.

1. :doc:`Docker クライアント（docker という名称のバイナリ・ファイル </engine/installation/index>` をインストールします。

..    Download the Docker Machine binary and extract it to your PATH.

2. Docker Machine のバイナリ・ファイル（docker-machine）をダウンロードし、PATH に展開します。

Mac OS X もしくは Linux の場合：

.. code-block:: bash

   $ curl -L https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-`uname -s`-`uname -m` > /usr/local/bin/docker-machine && \
   chmod +x /usr/local/bin/docker-machine

Windows 上の git bash の場合：

.. code-block:: bash

   $ if [[ ! -d "$HOME/bin" ]]; then mkdir -p "$HOME/bin"; fi && \
   curl -L https://github.com/docker/machine/releases/download/v0.7.0/docker-machine-Windows-x86_64.exe > "$HOME/bin/docker-machine.exe" && \
   chmod +x "$HOME/bin/docker-machine.exe"

.. Otherwise, download one of the releases from the docker/machine release page directly.

あるいは、 `docker/machine リリース・ページ <https://github.com/docker/machine/releases/>`_ から直接ダウンロードします。

..    Check the installation by displaying the Machine version:

3. Machine のバージョンを表示して、インストールを確認します。

.. code-block:: bash

   $ docker-machine version
   docker-machine version 0.7.0, build 61388e9

.. Installing bash completion scripts

bash 補完スクリプトのインストール
========================================

.. The Machine repository supplies several bash scripts that add features such as:

Machine 用のリポジトリには次の機能を持つ ``bash`` スクリプトがあります。

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

詳細なドキュメントは、 `各スクリプト <https://github.com/docker/machine/tree/master/contrib/completion/bash>`_ の文頭にあるコメントをご覧ください。

.. Where to go next

次はどこへ
==========

..    Docker Machine overview
    Docker Machine driver reference
    Docker Machine subcommand reference

* :doc:`overview`
* machine を :doc:`ローカルの VirtualBox を使ったシステム </machine/get-started>` にインストール
* 複数の machine を :doc:`クラウド・プロバイダ </machine/get-started-cloud/>` にインストール
* :doc:`Docker Machine ドライバ・リファレンス </machine/drivers/index>`
* :doc:`Docker Machine サブコマンド・リファレンス </machine/reference/index>`

.. seealso:: 

   Install Docker Machine
      https://docs.docker.com/machine/install-machine/
