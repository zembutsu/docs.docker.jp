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

.. On macOS and Windows, Machine is installed along with other Docker products when
   you install the [Docker for Mac](/docker-for-mac/index.md), [Docker for
   Windows](/docker-for-windows/index.md), or [Docker
   Toolbox](/toolbox/overview.md).

macOS と Windows の場合 :doc:`Docker for Mac </docker-for-mac/index>` 、 :doc:`Docker for Windows </docker-for-windows/index>` 、 :doc:`Docker Toolbox </toolbox/overview>` をインストールしたら、数ある Docker 製品とともに Docker Machine が同時にインストールされます。

.. If you want only Docker Machine, you can install the Machine binaries directly
   by following the instructions in the next section. You can find the latest
   versions of the binaries on the [docker/machine release
   page](https://github.com/docker/machine/releases/){: target="_blank" class="_" }
   on GitHub.

Docker Machine だけをインストールしたい場合は、次の節で示す手順に従って Docker Machine のバイナリを直接インストールすることができます。
GitHub 上の `docker/machine リリース・ページ <https://github.com/docker/machine/releases/>`_ に、最新のバイナリバージョンがあります。

.. ## Installing Machine directly

.. _installing-machine-directly:

Docker Machine の直接インストール
=================================

.. 1.  Install [Docker](/engine/installation/index.md){: target="_blank" class="_" }.

1.  :doc:`Docker </engine/installation/index>` をインストールします。

.. 2.  Download the Docker Machine binary and extract it to your PATH.

2.  Docker Machine のバイナリをダウンロードして実行パスに展開します。

   .. If you are running on **macOS**:

   **macOS** を利用している場合:

   ..  ```console
       $ curl -L https://github.com/docker/machine/releases/download/v{{machineversion}}/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine && \
     chmod +x /usr/local/bin/docker-machine
       ```

   .. code-block:: bash

      $ curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine && \
      chmod +x /usr/local/bin/docker-machine

   .. If you are running on **Linux**:

   **Linux** を利用している場合:

   ..  ```console
       $ curl -L https://github.com/docker/machine/releases/download/v{{machineversion}}/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
       chmod +x /tmp/docker-machine &&
       sudo cp /tmp/docker-machine /usr/local/bin/docker-machine
       ```

   .. code-block:: bash

      $ curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
      chmod +x /tmp/docker-machine &&
      sudo cp /tmp/docker-machine /usr/local/bin/docker-machine

   .. If you are running with **Windows** with [Git BASH](https://git-for-windows.github.io/){: target="_blank" class="_"}:

   **Windows** 上において `Git BASH <https://git-for-windows.github.io/>`_ を利用している場合:

   .. code-block:: bash

      $ if [[ ! -d "$HOME/bin" ]]; then mkdir -p "$HOME/bin"; fi && \
      curl -L https://github.com/docker/machine/releases/download/v0.12.2/docker-machine-Windows-x86_64.exe > "$HOME/bin/docker-machine.exe" && \
      chmod +x "$HOME/bin/docker-machine.exe"

   ..  > The above command will work on Windows only if you use a
       terminal emulater such as [Git BASH](https://git-for-windows.github.io/){: target="_blank" class="_"}, which supports Linux commands like `chmod`.
       {: .important}

   .. important::

      上のコマンドは Windows 上において実行していますが、これができるのは `Git BASH <https://git-for-windows.github.io/>`_ などを利用して、 ``chmod`` といった Linux コマンドをサポートしている端末エミュレーターを使っているからです。

   ..  Otherwise, download one of the releases from the [docker/machine release
       page](https://github.com/docker/machine/releases/){: target="_blank" class="_" } directly.

   上記以外は `docker/machine リリース・ページ <https://github.com/docker/machine/releases/>`_ からバイナリ・リリースを直接ダウンロードしてください。

.. 3.  Check the installation by displaying the Machine version:

3.  インストール後の確認として Machine のバージョンを表示してみます。

   ..      $ docker-machine version
           docker-machine version {{machineversion}}, build 9371605

   .. code-block:: bash

      $ docker-machine version
      docker-machine version 0.12.2, build 9371605

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
