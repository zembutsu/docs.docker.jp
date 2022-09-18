.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/dev-environments/create-dev-env/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/dev-environments/create-dev-env.md
.. check date: 2022/09/18
.. Commits on Jul 27, 2022 fd9fe19061121287e75faebf973a3e1546f71190
.. -----------------------------------------------------------------------------

.. Create a Dev Environment
.. _create-a-dev-environment:

==================================================
Dev Environment の作成
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can create a Dev Environment from a:

Dev Environment は、以下より作成できます：

..   Git repository
    Branch or tag of a Git repository
    Subfolder of a Git repository
    Local folder

* Git リポジトリ
* Git リポジトリのブランチやタグ
* Git リポジトリのサブフォルダ
* ローカルフォルダ

.. This did not conflict with any of the local files or local tooling set up on your host.

これは、ホスト上にセットアップされたローカルファイルやローカルツールと競合しません。

.. Create a Dev Environment from a Git repository
.. _create-a-dev-environment-from-a-git-repository:

Git リポジトリから Dev Environment を作成
==================================================

.. The simplest way to get started with Dev Environments is to create a new environment by cloning the Git repository of the project you are working on.

Dev Environments を始めるのに最も簡単な方法は、作業しているプロジェクトの Git リポジトリをクローンし、新しい環境を作成します。

.. For example, create a new Dev Environment using the simple single-dev-env project from the Docker Samples GitHub repository.

例として、 `Docker Samples <https://github.com/dockersamples/single-dev-env>`_ GitHub リポジトリにあるシンプルな ``single-dev-env`` プロジェクトを使って、新しい Dev Environment を作成します。

..  Note
    When cloning a Git repository using SSH, ensure you’ve added your SSH key to the ssh-agent. To do this, open a terminal and run ssh-add <path to your private ssh key>.

.. note::

   SSH を使って Git リポジトリをクローンする場合、自分の SSH 鍵を ssh-agent に追加する必要があります。そのためには、ターミナルを開き ``ssh-add <path to your private ssh key>`` を実行します。

..  Important
    If you have enabled the WSL 2 integration in Docker Desktop for Windows, make sure you have an SSH agent running in your WSL 2 distribution.

.. important::

   Docker Desktop for Windows で WSL 2 統合を有効化している場合、 WSL 2 ディストリビューション内で SSH エージェントが実行中かどうか確認してください。

* WSL2 内で SSH エージェントを起動する方法：

   .. If your WSL 2 distribution doesn't have an `ssh-agent` running, you can append this script at the end of your profile file (that is: ~/.profile, ~/.zshrc, ...). 

   WSL 2 ディストリビューションが ``ssh-agent`` を実行していなければ、自分の profile ファイル（これは ~/.profile や ~/.zshrc 等）の最後に、以下のスクリプトを追加します。

   .. code-block:: bash
   
      SSH_ENV="$HOME/.ssh/agent-environment"
      function start_agent {
          echo "Initialising new SSH agent..."
          /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
          echo succeeded
          chmod 600 "${SSH_ENV}"
          . "${SSH_ENV}" > /dev/null
      }
      # Source SSH settings, if applicable
      if [ -f "${SSH_ENV}" ]; then
          . "${SSH_ENV}" > /dev/null
          ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
              start_agent;
          }
      else
          start_agent;
      fi

.. To create a Dev Environment:

Dev Environment を作成するには：

..    From Under Dev Environments in Docker Dashboard, click Create. The Create a Dev Environment dialog displays.

1. Docker ダッシュボードの **Dev Environments 以下** から **Create** をクリックします。 **Create a Dev Environment** ダイアログが表示されます。

..     Select Get Started and then copy https://github.com/dockersamples/single-dev-env.git and add it to the Enter the Git Repository field on the Existing Git repo tab.

2. **Get Stated** をクリックし、 ``https://github.com/dockersamples/single-dev-env.git`` をコピーし、それを **Existing Dev Environment** の **Enter the Git Repository** フィールドに追加します。

..    Select Continue.
..    This detects the main language of your repository, clones the Git code inside a volume, determines the best image for your Dev Environment, and opens VS Code inside the Dev Environment container.

3. **Continue** をクリックします。

   これでリポジトリの主な言語を検出し、ボリューム内の Git コードをクローンし、Dev Environment に適したイメージを決定し、 Dev Environment コンテナ内で VS Code を開きます。

..    Hover over the container and select Open in VS Code to start working. You can also open a terminal in VS Code, and use Git to push or pull code to your repository, or switch between branches and work as you would normally.

4. 開始するには、コンテナの上にマウスカーソルを移動し、 **Open in VS Code** を選びます。 VS Code 内でもターミナルを開き、 Git を使ってリポジトリとのコードの push や pull をしたり、通常の作業のようにブランチ間を切り替えられます。

..    To launch the application, run the command make run in your terminal. This opens an http server on port 8080. Open http://localhost:8080 in your browser to see the running application.

5. アプリケーションを起動するには、ターミナル内で ``make run`` コマンドを実行します。これはポート 8080 上に http サーバを開きます。実行中のアプリケーションをみるには、ブラウザで http://localhost:8080 を開きます。

.. Create a Dev Environment from a specific branch or tag
.. _create-a-dev-environment-from-a-specific-branch-or-tag:

ブランチやタグを指定して Dev Environment を作成
==================================================

.. You can create a dev environment from a specific branch (for example, a branch corresponding to a Pull Request) or a tag by adding @mybranch or @tag as a suffix to your Git URL:

ブランチの指定（例：Pull Request を送るために適切なブランチ）やタグを指定して Dev Environment を作成するには、Git URL の末尾に ``@mybranch`` や ``@tag`` を追加して指定できます。

``https://github.com/dockersamples/single-dev-env@mybranch``

.. or

または

``git@github.com:dockersamples/single-dev-env.git@mybranch``

.. Docker then clones the repository with your specified branch or tag.

Docker は指定したブランチやタグでリポジトリをクローンします。

.. Create a Dev Environment from a subdirectory of a Git repository
.. _create-a-dev-environment-from-a-subdirectory-of-a-git-repository:

Git リポジトリのサブディレクトリから Dev Environment を作成
============================================================

..  Note
    Currently, Dev Environments is not able to detect the main language of the subdirectory. You need to define your own base image or compose file in a .docker folder located in your subdirectory. For more information on how to configure, see the React application with a Spring backend and a MySQL database sample or the Go server with an Nginx proxy and a Postgres database sample.

.. note::

   現時点では、 Dev Environment はサブディレクトリの主な言語を検出できません。自分のベースイメージか、サブディレクトリ内の .docker フォルダ内にある compose ファイルで定義する必要があります。設定の仕方についての詳しい情報は、 `React application with a Spring backend and a MySQL database sample <https://github.com/docker/awesome-compose/tree/master/react-java-mysql>`_ や `Go server with an Nginx proxy and a Postgres database sample <https://github.com/docker/awesome-compose/tree/master/nginx-golang-postgres>`_ をご覧ください。

..    From Dev Environments in Docker Dashboard, click Create. The Create a Dev Environment dialog displays.

1. Docker ダッシュボードの **Dev Environments 以下** から **Create** をクリックします。 **Create a Dev Environment** ダイアログが表示されます。

..    Select Get Started and then copy your Git subfolder link into the Enter the Git Repository field on the Existing Git repo tab.

2. **Get Stated** をクリックし、自分の Git サブフォルダへのリンクをコピーし、それを **Existing Dev Environment** の **Enter the Git Repository** フィールドに追加します。

..    Select Continue.
    This clones the Git code inside a volume, determines the best image for your Dev Environment, and opens VS Code inside the Dev Environment container.

3. **Continue** をクリックします。

   これでリポジトリの主な言語を検出し、ボリューム内の Git コードをクローンし、Dev Environment に適したイメージを決定し、 Dev Environment コンテナ内で VS Code を開きます。


..    Hover over the container and select Open in VS Code to start working. You can also open a terminal in VS Code, and use Git to push or pull code to your repository, or switch between branches and work as you would normally.

4. 開始するには、コンテナの上にマウスカーソルを移動し、 **Open in VS Code** を選びます。 VS Code 内でもターミナルを開き、 Git を使ってリポジトリとのコードの push や pull をしたり、通常の作業のようにブランチ間を切り替えられます。

..    To launch the application, run the command make run in your terminal. This opens an http server on port 8080. Open http://localhost:8080 in your browser to see the running application.

5. アプリケーションを起動するには、ターミナル内で ``make run`` コマンドを実行します。これはポート 8080 上に http サーバを開きます。実行中のアプリケーションをみるには、ブラウザで http://localhost:8080 を開きます。

.. Create a Dev Environment from a local folder
.. _create-a-dev-environment-from-a-local-folder:

ローカルフォルダから Dev Environment を作成
==================================================

..    From Dev Environments in Docker Dashboard, click Create. The Create a Dev Environment dialog displays.

1. Docker ダッシュボードの **Dev Environments 以下** から **Create** をクリックします。 **Create a Dev Environment** ダイアログが表示されます。

..     Select Get Started and then the Local Folder tab.

2. **Get Stated** をクリックし、 **Local Folder** タブをクリックします。

..     Select Select directory to open the root of the code that you would like to work on.

3. **Select directory** で作業対象としたいコードのルートを開きます。

..    Select Continue.
    This detects the main language of your local folder, creates a Dev Environment using your local folder, and bind-mounts your local code in the Dev Environment. It then opens VS Code inside the Dev Environment container.

4. **Continue** をクリックします。

   これはローカルフォルダ内の主な言語を検出し、ローカルフォルダを使って Dev Environment を作成します。それから、 Dev Environment 内にローカルコードをバインド マウントします。それから、 Dev Environment コンテナ内で VS Code が開きます。

..    Note
    When using a local folder for a Dev Environment, file changes are synchronized between your Dev Environment container and your local files. This can affect the performance inside the container, depending on the number of files in your local folder and the operations performed in the container.

.. note::

   Dev Environment にローカルフォルダを使う場合、自分の Dev Environment コンテナとローカルファイル間でのファイル変更は同期します。これはコンテナ内のパフォーマンスに影響を与える可能性があり、ローカルフォルダ内のファイル数や、コンテナ内で処理する操作に依存します。


.. What’s next?

次はどうしますか？
====================

.. Learn how to share your Dev Environment

:doc:`Dev Environment を共有 <share>` する方法を学びます。

.. seealso::

   Create a Dev Environment
      https://docs.docker.com/desktop/dev-environments/create-dev-env/

