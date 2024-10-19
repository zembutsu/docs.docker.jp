.. H-*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/troubleshoot/overview/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/troubleshoot/overview.md
.. check date: 2022/09/17
.. Commits on Sep 7, 2022 cbbb9f1fac9289c0d2851584010559f8f03846f0
.. -----------------------------------------------------------------------------

.. |whale| image:: /desktop/install/images/whale-x.png
      :width: 50%

.. Overview
.. _desktop-troubleshoot-overview:

==================================================
概要
==================================================

.. Did you know that Docker Desktop offers support for developers on a paid Docker subscription (Pro, Team, or Business)? Upgrade now to benefit from Docker Support. Click here to learn more.

.. hint:

   Docker Desktop は開発者をサポートする Docker サブスクリプション（Pro、Team、Business）を提供しているのをご存じでしょうか。アップグレードによって Docker サポートのメリットを得られます。詳細は :ruby:`こちら<mac-troubleshoot-support>` をご覧ください。
   
   * `今すぐアップグレード <https://www.docker.com/pricing>`_ 

.. This page contains information on:

このページに含む情報：

..  How to diagnose and troubleshoot Docker Desktop issues
    Check the logs
    Find workarounds for common problems

* Docker Desktop で問題発生時、診断とトラブルシュートの仕方
* ログの確認
* 共通する問題の回避策を見つける

.. Troubleshoot menu
.. _desktop-troubleshoot-menu:

トラブルシュートのメニュー
==============================

.. To navigate to Troubleshoot either:

**Troubleshoot** （トラブルシュート）に移動するには、以下のいずれかです：

..  Select the Docker menu whale menu and then Troubleshoot
    Select the Troubleshoot icon from the Docker Dashboard

* Docker メニュー |whale| から、 **Troubleshoot** を選ぶ
* Docker ダッシュボードから **Troubleshoot** アイコンを選ぶ

.. image:: ../images/troubleshoot.png
   :width: 60%
   :alt: Docker Desktop のトラブルシュート


.. The Troubleshoot page contains the following options:

トラブルシュートのページには、以下のオプションを含みます。

..    Restart Docker Desktop: Select to restart Docker Desktop.

* **Restart Docker Desktop** （Docker Desktop の再起動）：選択すると、Docker Desktop を再起動します。

.. Support: Users with a paid Docker subscription can use this option to send a support request. Other users can use this option to diagnose any issues in Docker Desktop. For more information, see Diagnose and feedback and Support.

* **Support** ：有償 Docker サブスクリプション利用者は、このオプションを使ってサポートリクエストを送信できます。他の利用者がこのオプションを使うと、Docker Desktop 上のあらゆる問題を診断します。診断に関する詳細情報は、 :ref:`mac-diagnose-and-feedback` をご覧ください。

..    Reset Kubernetes cluster: Select this option to delete all stacks and Kubernetes resources. For more information, see Kubernetes.

* **Reset Kubernetes cluster** （Kubernetes クラスタのリセット）：このオプションを選択すると、全てのスタックと Kubernetes リソースを削除します。詳しい情報は :ref:`Kubernetes <mac-kubernetes>` をご覧ください。

.. Clean / Purge data: This option resets all Docker data without a reset to factory defaults. Selecting this option results in the loss of existing settings.

* **Clean / Purge data** （データ除去 / 削除）：設定などを初期値のデフォルトに戻さず、全ての Docker データをリセットします。このオプションを選択した結果、既存の設定は消滅します。

..    Reset to factory defaults: Choose this option to reset all options on Docker Desktop to their initial state, the same as when Docker Desktop was first installed.

* **Reset to factory defaults** （初期値のデフォルトにリセット）：このオプションを選択すると、Docker Desktop の全てのオプションを初期値にリセットし、Docker Desktop が始めてインストールされたのと同じ状態にします。

.. If you are a Mac user, you also have the option to Uninstall Docker Desktop from your system.

Mac ユーザの場合、Docker Desktop をシステム上から **Uninstall** （アンインストール）するオプションもあります。

.. Diagnose
.. _desktop-diagnose:

診断
==========

.. Diagnose from the app
.. _desktop-diagnose-from-the-app:

アプリから診断
------------------------------

.. Make sure you are signed in to Docker Desktop and your Docker Hub account.

 Docker Desktop にサインインし、自分の `Docker アカウント <https://hub.docker.com/>`_ で入っているのを確認します。

..    From Troubleshoot, select Get support. This opens the in-app Support page and starts collecting the diagnostics. 

1. **Troubleshoot** から **Get support** を選びます。これはアプリ内の **Support** ページを開き、診断情報の収集を開始します。

   .. image:: ../images/diagnose-support.png
      :width: 60%
      :alt: 診断とフィードバック

.. When the diagnostics collection process is complete, click Upload to get a Diagnostic ID.

2. 診断情報の収集が終われば、 **Upload to get a Diagnostic ID** をクリックします。

.. When the diagnostics have been uploaded, Docker Desktop prints a diagnostic ID. Copy this ID.

3. 診断情報のアップロードが完了すると、 Docker Desktop は Diagnostic ID（診断 ID）を表示します。この ID をコピーします。

.. If you have a paid Docker subscription, click Contact Support. This opens the Docker Desktop support form. Fill in the information required and add the ID you copied in step four to the Diagnostics ID field.

4. 有償 Docker サブスクリプションを持っている場合は、 **Contact Support** をクリック。これは `Docker Desktop サポート <https://hub.docker.com/support/desktop/>`_ フォームを開きます。必要な情報を入力し、Diagnostics ID フィールドには先ほどコピーした ID を入れます。

.. Click Submit to request Docker Desktop support. 

5. Docker Desktop のサポートをリクエストするには **Submit** をクリックします。

   ..    Note
      You must be signed in to Docker Desktop using your Pro, Team, or Business tier credentials to access the support form. For information on what’s covered as part of Docker Desktop support, see Support.

   .. note::
   
      サポートフォームにアクセスするには、Docker Desktop に Pro、Team、Business いずれかの認証賞情報でサインインしている必要があります。Docker Desktop サポートで扱う情報については、 :ref:`サポート <mac-troubleshoot-support>` をご覧ください。

.. If you don’t have a paid Docker subscription, click Upgrade to benefit from Docker Support to upgrade your existing account. Alternatively, click Report a Bug to open a new Docker Desktop issue on GitHub. Complete the information required and ensure you add the diagnostic ID you copied earlier.

6. 有償 Docker サブスクリプションが無い場合、既存のアカウントをアップグレードするために **Upgrade to benefit from Docker Support** がクリックできます。あるいは、 **Report a Bug** をクリックし、GitHub に新しい Docker Desktop の issue を開きます。必要情報を入力し、先ほどコピーした診断 ID を追加します。

.. Click submit new issue to create a new issue.

7. **submit new issue** をクリックすると新しい issue を作成します。

.. Diagnosing from the terminal
.. _desktop-diagnosing-from-the-terminal:

ターミナルから診断
--------------------------------------------------

.. In some cases, it is useful to run the diagnostics yourself, for instance, if Docker Desktop cannot start.

Docker Desktop が起動できない状況など、場合によっては自分での診断実行が役立つ場合もあります。

.. First, locate the com.docker.diagnose tool. It is located at:

まず、 ``com.docker.diagnose`` ツールを探します。通常の場所は以下の通りです：

* Windows

   .. code-block:: bash
   
      $ C:\Program Files\Docker\Docker\resources\com.docker.diagnose.exe

* Mac

   .. code-block:: bash
   
      $ /Applications/Docker.app/Contents/MacOS/com.docker.diagnose

* Linux

   .. code-block:: bash
   
      $ /opt/docker-desktop/bin/com.docker.diagnose

.. To create and upload diagnostics, run:

診断の作成とアップロードをするには、次のコマンドを実行します：

.. code-block:: bash

   $ <tool location> gather -upload

.. After the diagnostics have finished, the terminal displays your diagnostics ID. The diagnostics ID is composed of your user ID and a timestamp. Ensure you provide the full diagnostics ID, and not just the user ID.

診断が終了したら、ターミナルには診断 ID を含む出力があります。診断 ID にはユーザ ID とタイムスタンプも組み込まれています。ユーザ ID だけでなく、診断 ID 全体が必要になります。

.. To view the contents of the diagnostic file, run:

診断ファイルの内容を表示するには、次のように実行します：


* Mac

   .. code-block:: bash
   
      $ open /tmp/BE9AFAAF-F68B-41D0-9D12-84760E6B8740/20190905152051.zip

* Linux

   .. code-block:: bash
   
      $ unzip –l /tmp/BE9AFAAF-F68B-41D0-9D12-84760E6B8740/20190905152051.zip

.. If you have a paid Docker subscription, open the Docker Desktop support form. Fill in the information required and add the ID to the Diagnostics ID field. Click Submit to request Docker Desktop support.

有償 Docker サブスクリプションを持っている場合は、 `Docker Desktop サポート <https://hub.docker.com/support/desktop/>`_ フォームを開きます。必要な情報を入力し、Diagnostics ID フィールドには先ほどコピーした ID を入れます。Docker Desktop サポートをリクエストするには **Submit** をクリックします。

.. Self-diagnose tool
.. _desktop-self-diagnose-tool:

:ruby:`自己診断ツール <self-diagnose tool>`
--------------------------------------------------

.. Docker Desktop contains a self-diagnose tool which helps you to identify some common problems.

Docker Desktop には、共通する問題を確認するのに役立つ自己診断ツールが入っています。

.. First, locate the com.docker.diagnose tool. It is located at:

まず、 ``com.docker.diagnose`` ツールを探します。通常の場所は以下の通りです：

* Windows

   .. code-block:: bash
   
      $ C:\Program Files\Docker\Docker\resources\com.docker.diagnose.exe

* Mac

   .. code-block:: bash
   
      $ /Applications/Docker.app/Contents/MacOS/com.docker.diagnose

* Linux

   .. code-block:: bash
   
      $ /opt/docker-desktop/bin/com.docker.diagnose


.. To run the self-diagnose tool, run:

自己診断ツールを実行するには、次のように実行します。

.. code-block:: bash

   $ <tool location> check

.. The tool runs a suite of checks and displays PASS or FAIL next to each check. If there are any failures, it highlights the most relevant at the end of the report.

ツールはチェックの一式を実行し、それぞれのチェックごとに **PASS** か **FAIL** を表示します。何らかのエラーがあれば、レポートの最後で最も関連する情報をハイライトで表示します。

.. You can then create and issue on GitHub:

それから、 GitHub で issue を作成できます。

* `Linux 版 <https://github.com/docker/desktop-linux/issues>`_ 
* `Mac 版 <https://github.com/docker/for-mac/issues>`_ 
* `Windows 版 <https://github.com/docker/for-win/issues>`_ 

.. Check the logs
.. desktop-check-the-logs:

ログの確認
==================================================

.. In addition to using the diagnose and feedback option to submit logs, you can browse the logs yourself.

診断とフィードバックオプションによるログ送信だけでなく、自分自身でログを確認できます。

Mac の場合
----------

.. In a terminal
.. _desktop-mac-in-a-terminal:

ターミナル上で
^^^^^^^^^^^^^^^^^^^^

.. To watch the live flow of Docker Desktop logs in the command line, run the following script from your favorite shell.

コマンドライン上で Docker Desktop ログのライブフロー（live flow）を表示するには、任意のシェルで以下のスクリプトを実行します。

.. code-block:: bash

   $ pred='process matches ".*(ocker|vpnkit).*" || (process in {"taskgated-helper", "launchservicesd", "kernel"} && eventMessage contains[c] "docker")'
   $ /usr/bin/log stream --style syslog --level=debug --color=always --predicate "$pred"

.. Alternatively, to collect the last day of logs (1d) in a file, run:

あるいは、直近1日のログ（ :code:`1d` ） をファイルに集めるには、次の様に実行します。

.. code-block:: bash

   $ /usr/bin/log show --debug --info --style syslog --last 1d --predicate "$pred" >/tmp/logs.txt

.. In the Console app
.. _desktop-mac-in-the-console-app:

アプリケーション上で
^^^^^^^^^^^^^^^^^^^^

.. Macs provide a built-in log viewer, named “Console”, which you can use to check Docker logs.

Mac には "Console" という内蔵ログビュアーがあります。これを使って Docker のログを確認できます。

.. The Console lives in /Applications/Utilities; you can search for it with Spotlight Search.

Console は :code:`/Applications/Utilities` にあります。これはスポットライト検索で見つけられます。

.. To read the Docker app log messages, type docker in the Console window search bar and press Enter. Then select ANY to expand the drop-down list next to your docker search entry, and select Process.

Docker アプリのログ・メッセージを読むには、 Console ウインドウの検索バーで :code:`docker` と入力し、エンターを押します。それから `ANY` を選択肢、ドロップダウンリストを展開し、その横にある :code:`docker` と検索語を入力し、 `Press` を押します。

.. Mac Console search for Docker app

.. You can use the Console Log Query to search logs, filter the results in various ways, and create reports.

Console ログクエリを使ってログを検索でき、様々な方法で結果をフィルだしたり、レポートを作成したりできます。

Lnux の場合
--------------------

.. You can access Docker Desktop logs by running the following command:

以下のコマンドを実行し、 Docker Desktop のログにアクセスできます。

.. code-block:: bash

   $ journalctl --user --unit=docker-desktop

.. You can also find the logs for the internal components included in Docker Desktop at $HOME/.docker/desktop/log/.

また、 Docker Desktop に含まれる内部コンポーネントに関するログは、 ``$HOME/.docker/desktop/log/`` にあります。


.. View the Docker Daemon logs
.. _desktop-view-the-docker-daemon-logs:

Docker デーモンのログを表示
------------------------------

.. Refer to the read the logs section to learn how to view the Docker Daemon logs.

Docker デーモンのログを表示する方法を知るには、 :ref:`ログを読む <config-daemon-read-the-logs>` をご覧ください。

.. What's next?

次はどこへ？
====================

* :doc:`トラブルシュートのトピック <topics>` を表示
* :doc:`共通する問題の回避策 <workarounds>` を準備
* Mac ユーザの場合、 :doc:`Mac 版の既に分かっている問題 <known-issues>` を参照



.. seealso::

   Overview
      https://docs.docker.com/desktop/troubleshoot/overview/
