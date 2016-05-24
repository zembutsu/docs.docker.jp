.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/completion/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/completion.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/completion.md
.. check date: 2016/04/28
.. Commits on Jan 28, 2016 3fc72038c56482e63dbb2e1341f8475cf6bb5350
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

Compose は bash と zsh シェル向けの `コマンド補完 <https://en.wikipedia.org/wiki/Command-line_completion>`_ を搭載しています。

.. Installing Command Completion

コマンドライン補完のインストール
========================================

.. Bash

Bash
--------------------

.. Make sure bash completion is installed. If you use a current Linux in a non-minimal installation, bash completion should be available. On a Mac, install with brew install bash-completion

bash 補完（completion）がインストールされているかどうか確認します。現在の Linux が最小インストールでなければ、bash 補完は利用可能です。Mac は ``brew install bash-completion`` でインストールします。

.. Place the completion script in /etc/bash_completion.d/ (/usr/local/etc/bash_completion.d/ on a Mac), using e.g.

次のようにして、補完スクリプトを ``/etc/bash_completion.d/`` （ Mac は ``/usr/local/etc/bash_completion.d/`` ）に置きます。

.. code-block:: bash

   curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose

.. Completion will be available upon next login.

次回ログイン時から補完機能が利用可能になります。


Zsh
--------------------

.. Place the completion script in your /path/to/zsh/completion, using e.g. ~/.zsh/completion/

補完スクリプトを ``/path/to/zsh/completion`` や、``~/.zsh/completion/`` に置きます。

.. code-block:: bash

   mkdir -p ~/.zsh/completion
   curl -L https://raw.githubusercontent.com/docker/compose/$(docker-compose version --short)/contrib/completion/zsh/_docker-compose > ~/.zsh/completion/_docker-compose

.. Include the directory in your $fpath, e.g. by adding in ~/.zshrc

``$fpath`` には ``~/.zshrc`` ディレクトリを追加します。

.. code-block:: bash

   fpath=(~/.zsh/completion $fpath)

.. Make sure compinit is loaded or do it by adding in ~/.zshrc

``compinit`` で読み込まれて ``~/.zshrc`` に追加されているか確認します。

.. code-block:: bash

   autoload -Uz compinit && compinit -i

.. Then reload your shell

それからシェルを再読み込みします。

.. code-block:: bash

   exec $SHELL -l

.. Available completions

利用可能な補完
====================

.. Depending on what you typed on the command line so far, it will complete

コマンドラインの補完は、入力する内容に依存します。

..    available docker-compose commands
    options that are available for a particular command
    service names that make sense in a given context (e.g. services with running or stopped instances or services based on images vs. services based on Dockerfiles). For docker-compose scale, completed service names will automatically have “=” appended.
    arguments for selected options, e.g. docker-compose kill -s will complete some signals like SIGHUP and SIGUSR1.

* 利用可能な docker-compose コマンド
* 個々のコマンドで利用可能なオプション
* 指定した状態にあるサービス名（例：サービスが実行中、停止中、サービスの元になったイメージ、あるいは Dockerfile の元となるサービス）。``docker-compose scale`` の補完では、サービス名に自動的に "=" を追加します。
* 選択したオプションに対する引数。たとえば ``docker-compose kill -s`` は SIGHUP や SIGUSR1 のようなシグナルを補完します。

.. Enjoy working with Compose faster and with less typos!

Compose をより速く・入力ミス（typo）なく楽しんで使いましょう！

.. seealso:: 

   Command-line Completion
      https://docs.docker.com/compose/completion/

