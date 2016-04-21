.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/completion/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/completion.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/completion.md
.. check date: 2016/03/09
.. Commits on Feb 11, 2016 0eb405f1d7ea3ad4c3595fb2c97d856d3e2d9c5c
.. -------------------------------------------------------------------

.. Command-line Completion

.. _machine-completion:

==================================================
コマンドライン補完
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker Machine comes with command completion for the bash shell.

Docker Machine は bash シェルで `コマンド補完 <https://en.wikipedia.org/wiki/Command-line_completion>`_ が使えます。


.. Installing Command Completion

.. _installing-command-completion-machine:

コマンド補完のインストール
==============================

.. Bash

bash
----------

.. Make sure bash completion is installed. If you use a current Linux in a non-minimal installation, bash completion should be available. On a Mac, install with brew install bash-completion

bash 補完（bash completion) がインストールされているかどうか確認します。お使いの Linux 環境が最小インストールでなければ、おそらく補完機能が利用できます。 Mac では ``brew install bash-completion`` でインストールします。

.. Place the completion scripts in /etc/bash_completion.d/ (`brew --prefix`/etc/bash_completion.d/ on a Mac), using e.g.

補完スクリプトを ``/etc/bash_completion.d/`` に置きます（ Mac の場合は ``brew --prefix`/etc/bash_completion.d/`` ）。例：

.. code-block:: bash

   files=(docker-machine docker-machine-wrapper docker-machine-prompt)
   for f in "${files[@]}"; do
     curl -L https://raw.githubusercontent.com/docker/machine/v$(docker-machine --version | tr -ds ',' ' ' | awk 'NR==1{print $(3)}')/contrib/completion/bash/$f.bash > `brew --prefix`/etc/bash_completion.d/$f
   done

.. Completion will be available upon next login.

次回ログイン時から補完機能が使えます。

.. seealso:: 

   Command-line Completion
      https://docs.docker.com/machine/completion/
