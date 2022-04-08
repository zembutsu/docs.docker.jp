.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/completion/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/completion.md
   doc version: 1.13
      https://github.com/docker/compose/commits/master/docs/completion.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/compose/completion.md
.. check date: 2022/04/07
.. Commits on Nov 19, 2021 93fe0d15dd53d99407504dde1ecdd0dd81238a7b
.. ----------------------------------------------------------------------------

.. Command-line Completion

==============================
コマンドライン補完
==============================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose comes with command completion for the bash and zsh shell.

Compose は bash と zsh シェル対応の `コマンド補完 <https://en.wikipedia.org/wiki/Command-line_completion>`_ を搭載しています。

.. Installing Command Completion

コマンドライン補完のインストール
========================================

.. Bash

Bash
--------------------

.. Make sure bash completion is installed.

bash 補完（completion）がインストールされているかどうか確認します。

Linux
^^^^^^^^^^

.. On a current Linux OS (in a non-minimal installation), bash completion should be available.
1. 現在の Linux OSでは（最小インストールでなければ）、bash 補完を利用可能でしょう。

.. Place the completion script in /etc/bash_completion.d/.
2. 補完スクリプトを ``/etc/bash_completion.d/`` に置きます。

.. code-block:: bash

   $ sudo curl \
       -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose \
       -o /etc/bash_completion.d/docker-compose

3. ターミナルを再読み込みします。ターミナルを閉じて新しいものを開くか、あるいは現在のターミナルで ``source ~/.bashrc`` コマンドで再読み込みします。

Mac
^^^^^^^^^^

.. Install via Homebrew
Homebrew 経由でインストール
++++++++++++++++++++++++++++++

..    Install with brew install bash-completion.

1. ``brew install bash-completion`` でインストールします。

..    After the installation, Brew displays the installation path. Make sure to place the completion script in the path.

2. インストール後、 Brew はインストールのパスを表示します。そのパスに補完スクリプトを置きます。

..    For example, place the completion script in /usr/local/etc/bash_completion.d/.

次の例は ``/usr/local/etc/bash_completion.d/`` に補完スクリプトを置きます。

.. code-block:: bash

   sudo curl \
       -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose \
       -o /usr/local/etc/bash_completion.d/docker-compose

.. Add the following to your ~/.bash_profile:

3. 自分の ``~/.bash_profile`` に以下を追加します。

.. code-block:: bash

   if [ -f $(brew --prefix)/etc/bash_completion ]; then
       . $(brew --prefix)/etc/bash_completion
   fi

.. You can source your ~/.bash_profile or launch a new terminal to utilize completion.

4. 補完を使えるようにするには、 ``~/.bash_profile`` を source で読み直すか、新しいターミナルを起動します。

.. Install via MacPorts
MacPorts 経由でインストール
++++++++++++++++++++++++++++++

..    Run sudo port install bash-completion to install bash completion.

1. bash 補完をインストールするには ``sudo port install bash-completion`` を実行します。

..    Add the following lines to ~/.bash_profile:

2. ``~/.bash_profile`` に以下の行を追加します。

.. code-block:: bash

    if [ -f /opt/local/etc/profile.d/bash_completion.sh ]; then
        . /opt/local/etc/profile.d/bash_completion.sh
    fi

..    You can source your ~/.bash_profile or launch a new terminal to utilize completion.

3. 補完を使えるようにするには、 ``~/.bash_profile`` を source で読み直すか、新しいターミナルを起動します。


Zsh
--------------------

.. Make sure you have installed oh-my-zsh on your computer.

コンピュータ上に `oh-my-zsh がインストールされている <https://ohmyz.sh/>`_ のを確認します。

.. With oh-my-zsh shell
oh-my-zsh シェルを使う
+++++++++++++++++++

.. Add docker and docker-compose to the plugins list in ~/.zshrc to run autocompletion within the oh-my-zsh shell. In the following example, ... represent other Zsh plugins you may have installed. After that, type source ~/.zshrc to bring the changes. To test whether it is successful, type docker ps and then press the Tab key.

oh-my-zsh シェル上で自動補完を使うには、 ``~/.zshrc`` のプラグイン一覧に ``docker`` と ``docker-compose`` を追加します。以下の例で ``...``  が示すのは、インストール済みの他の Zsh プラグインです。その後、変更を反映するために ``source ~/.zshrc`` を入力します。成功したかどうかを試すには、 ``docker ps`` を入力し、 **Tab** キーを押します。

.. code-block:: bash

   plugins=(... docker docker-compose)

.. Without oh-my-zsh shell
oh-my-zsh シェルを使わない
++++++++++++++++++++++++++++++

.. Place the completion script in your /path/to/zsh/completion (typically ~/.zsh/completion/):

1. 補完スクリプトを ``/path/to/zsh/completion`` に置きます（通常は ``~/.zsh/completion/`` ）。

.. code-block:: bash

   mkdir -p ~/.zsh/completion
   
   curl \
       -L https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/zsh/_docker-compose \
       -o ~/.zsh/completion/_docker-compose

.. Include the directory in your $fpath by adding in ~/.zshrc:

2. ``~/.zshrc`` の ``$fpath`` のディレクトリに追加します。

.. code-block:: bash

   fpath=(~/.zsh/completion $fpath)

.. Make sure compinit is loaded or do it by adding in ~/.zshrc

3. ``compinit`` を読み込み ``~/.zshrc`` に追加されているか確認します。

.. code-block:: bash

   autoload -Uz compinit && compinit -i

.. Then reload your shell

4. それからシェルを再読み込みします。

.. code-block:: bash

   exec $SHELL -l

.. Available completions

利用可能な補完について
==============================

.. Depending on what you typed on the command line so far, it completes:

コマンドラインの補完は、入力する内容に依存します。

..    available docker-compose commands
    options that are available for a particular command
    service names that make sense in a given context, such as services with running or stopped instances or services based on images vs. services based on Dockerfiles. For docker-compose scale, completed service names automatically have “=” appended.
    arguments for selected options. For example, docker-compose kill -s completes some signals like SIGHUP and SIGUSR1.

* 利用可能な docker-compose コマンド
* 個々のコマンドで利用可能なオプション
* 指定した状態にあるサービス名（例：サービスが実行中、停止中、サービスの元になったイメージ、あるいは Dockerfile の元となるサービス）。``docker-compose scale`` の補完では、サービス名に自動的に "=" を追加します。
* 選択したオプションに対する引数。たとえば ``docker-compose kill -s`` は SIGHUP や SIGUSR1 のようなシグナルを補完します。

.. Enjoy working with Compose faster and with less typos!

Compose をより速く、 :ruby:`入力ミス <typo>` なく楽しんで使いましょう！

.. Compose documentation
Compose のドキュメント
==============================

* :doc:`ユーザ・ガイド </compose/index>`
* :doc:`Compose のインストール </compose/install>`
* :doc:`コマンドライン・インターフェース </compose/reference/index>`
* :doc:`Compose ファイルのリファレンス </compose/compose-file>`
* :doc:`Compose のアプリ例 </compose/samples-for-compose>` 



.. seealso:: 

   Command-line Completion
      https://docs.docker.com/compose/completion/

