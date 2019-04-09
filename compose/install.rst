.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/install/
.. SOURCE: https://github.com/docker/compose/blob/master/docs/install.md
   doc version: 1.11
      https://github.com/docker/compose/commits/master/docs/install.md
.. check date: 2016/04/28
.. Commits on Mar 18, 2016 50fe014ba9f6af3dc75cb5f5548dcf0c9825cd05
.. -------------------------------------------------------------------

.. Install Docker Compose

.. _install-docker-compose:

=======================================
Docker Compose のインストール
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. You can run Compose on macOS, Windows and 64-bit Linux.

Compose は macOS、Windows、64-bit Linux で実行可能です。

..   ## Prerequisites

必要条件
==========

..   Docker Compose relies on Docker Engine for any meaningful work, so make sure you
     have Docker Engine installed either locally or remote, depending on your setup.

Docker Compose は数々の動作を行うために Docker Engine を必要とします。したがって Docker Engine がインストール済であることを確認してください。設定状況に合わせてインストール先はローカルでもリモートでも構いません。

..   - On desktop systems like Docker for Mac and Windows, Docker Compose is
     included as part of those desktop installs.

* Docker for Mac や Docker for Windows のようなデスクトップの場合、Docker Compose はその一部に含まれてすでにインストールされているはずです。

..   - On Linux systems, first install the
     [Docker](/engine/installation/index.md#server){: target="_blank" class="_"}
     for your OS as described on the Get Docker page, then come back here for
     instructions on installing Compose on
     Linux systems.

* Linux システムの場合はまずはじめに、Docker を手に入れるのページに示している各 OS ごとの :doc:`Docker </engine/installation/index>` をインストールします。そしてここの手順に戻り Linux システム向けの Compose をインストールします。

..   ## Install Compose

Compose のインストール
======================

..   Follow the instructions below to install Compose on Mac, Windows, Windows Server
     2016, or Linux systems, or find out about alternatives like using the `pip`
     Python package manager or installing Compose as a container.

Compose を Mac、Windows、Windows Server 2016、Linux にインストールする場合は、以下の手順に従ってください。他の方法として Python パッケージ・マネージャである ``pip`` を使う方法や、コンテナとして Compose をインストールする方法もあります。

.. raw:: html

   <!-- href タグを workaround として追加 -->
   <ul class="nav nav-tabs">
   <li class="active"><a data-toggle="tab" data-target="#macOS" href="#macOS">Mac</a></li>
   <li><a data-toggle="tab" data-target="#windows" href="#windows">Windows</a></li>
   <li><a data-toggle="tab" data-target="#linux" href="#linux">Linux</a></li>
   <li><a data-toggle="tab" data-target="#alternatives" href="#alternatives">その他のインストール</a></li>
   </ul>
   <div class="tab-content">
   <div id="macOS" class="tab-pane fade in active" markdown="1">

..   ### Install Compose on macOS

macOS における Compose のインストール
-------------------------------------

..   **Docker for Mac** and **Docker Toolbox** already include Compose along
     with other Docker apps, so Mac users do not need to install Compose separately.
     Docker install instructions for these are here:

**Docker for Mac** と **Docker Toolbox** には、Compose も各種 Docker アプリもすべて含んでいます。したがって Mac ユーザは個別に Compose をインストールする必要はありません。Docker のインストール手順は以下となります。

..     * [Get Docker for Mac](/docker-for-mac/install.md)
       * [Get Docker Toolbox](/toolbox/overview.md) (for older systems)

* :doc:`Docker for Mac の入手</docker-for-mac/index>`
* :doc:`Docker Toolbox の入手</toolbox/overview>` (古いシステム向け)

.. raw:: html

   </div>
   <div id="windows" class="tab-pane fade" markdown="1">

..   ### Install Compose on Windows desktop systems

Windows における Compose のインストール
---------------------------------------------------

..   **Docker for Windows** and **Docker Toolbox** already include Compose
     along with other Docker apps, so most Windows users do not need to
     install Compose separately. Docker install instructions for these are here:

**Docker for Windows** と **Docker Toolbox** には、Compose も各種 Docker アプリもすべて含んでいます。したがって Windows ユーザは個別に Compose をインストールする必要はありません。Docker のインストール手順は以下となります。

..   * [Get Docker for Windows](/docker-for-windows/install.md)
     * [Get Docker Toolbox](/toolbox/overview.md) (for older systems)

* :doc:`Docker for Windows の入手</docker-for-windows/index>`
* :doc:`Docker Toolbox の入手</toolbox/overview>` (古いシステム向け)

..   **If you are running the Docker daemon and client directly on Microsoft
     Windows Server 2016** (with [Docker EE for Windows Server 2016](/engine/installation/windows/docker-ee.md), you _do_ need to install
     Docker Compose. To do so, follow these steps:

:doc:`Docker Engine - Enterprise</engine/installation/docker-ee>` を使って Microsoft Windows Server 上において Docker デーモンやクライアントを 直接動かしている場合は、Docker Compose をインストールする必要があります。以下の３つの手順を進めてください。

..   1.  Start an "elevated" PowerShell (run it as administrator).
         Search for PowerShell, right-click, and choose
         **Run as administrator**. When asked if you want to allow this app
         to make changes to your device, click **Yes**.

1. PowerShell を管理者権限で起動します。つまり PowerShell を見つけたら右クリックして **管理者として実行** を選びます。PowerShell がデバイスへの変更をしても良いかどうかを尋ねられたら **Yes** をクリックします。

..       In PowerShell, run the following command to download
         Docker Compose, replacing `$dockerComposeVersion` with the specific
         version of Compose you want to use:

PowerShell において以下のコマンドを実行して Docker Compose をダウンロードします。``$dockerComposeVersion`` の部分は、インストールしたい Compose のバージョンに置き換えてください。

..    ```none
      Invoke-WebRequest "https://github.com/docker/compose/releases/download/$dockerComposeVersion/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\docker\docker-compose.exe

.. code-block:: powershell

   Invoke-WebRequest "https://github.com/docker/compose/releases/download/$dockerComposeVersion/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\docker\docker-compose.exe

..       For example, to download Compose version {{composeversion}},
         the command is:

例えば Compose バージョン 1.16.1 をダウンロードするには、以下のコマンドを実行します。

..    ```none
      Invoke-WebRequest "https://github.com/docker/compose/releases/download/{{composeversion}}/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\docker\docker-compose.exe

.. code-block:: powershell

   Invoke-WebRequest "https://github.com/docker/compose/releases/download/1.16.1/docker-compose-Windows-x86_64.exe" -UseBasicParsing -OutFile $Env:ProgramFiles\docker\docker-compose.exe

..    >  Use the latest Compose release number in the download command.
      >
      > As already mentioned, the above command is an _example_, and
      it may become out-of-date once in a while. Always follow the
      command pattern shown above it. If you cut-and-paste an example,
      check which release it specifies and, if needed,
      replace `$dockerComposeVersion` with the release number that
      you want. Compose releases are also available for direct download
      on the [Compose repository release page on GitHub](https://github.com/docker/compose/releases){:target="_blank" class="_"}.
      {: .important}

.. important::

   ダウンロードコマンド内での Compose 最新リリース番号の利用
      すでに説明しているように、上に示したコマンドは一つの例ですから、すでに古いリリース番号になっているかもしれません。
      コマンドの入力方法は上に示すものと同様に行ってください。
      上の例をカット・アンド・ペーストして利用する場合は、必ずリリース番号を確認してください。
      そして必要に応じて、``$dockerComposeVersion`` の部分は必要としているリリース番号に書き換えてください。
      Compose の各リリースは、`GitHub 上にある Compose リポジトリのリリースページ <https://github.com/docker/compose/releases>`_ から入手することができます。

..  2.  Run the executable to install Compose.

2.  実行モジュールを実行して Compose をインストールします。

.. raw:: html

   </div>
   <div id="linux" class="tab-pane fade" markdown="1">

..   ### Install Compose on Linux systems

Linux における Compose のインストール
-------------------------------------

..   On **Linux**, you can download the Docker Compose binary from the [Compose
     repository release page on GitHub](https://github.com/docker/compose/releases){:
     target="_blank" class="_"}. Follow the instructions from the link, which involve
     running the `curl` command in your terminal to download the binaries. These step
     by step instructions are also included below.

**Linux** においては `GitHub 上の Compose リポジトリのリリースページ <https://github.com/docker/compose/releases>`_ から Docker Compose のバイナリをダウンロードします。リンク先にある手順に従い、端末から ``curl`` コマンドを実行してバイナリをダウンロードします。この手順は以下にも示します。

..  1.  Run this command to download the latest version of Docker Compose:

1.  以下のコマンドを実行して Docker Compose 最新版をダウンロードします。

..    ```bash

.. code-block:: bash

   sudo curl -L https://github.com/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose

..     > Use the latest Compose release number in the download command.
       >
       The above command is an _example_, and it may become out-of-date. To ensure you have the latest version, check the [Compose repository release page on GitHub](https://github.com/docker/compose/releases){: target="_blank" class="_"}.
       {: .important}

.. important::

   ダウンロードコマンド内での Compose 最新リリース番号の利用
      上に示したコマンドは一つの例ですから、すでに古いリリース番号になっているかもしれません。
      最新版であるかどうかは `GitHub 上にある Compose リポジトリのリリースページ <https://github.com/docker/compose/releases>`_ を確認してください。

..       If you have problems installing with `curl`, see
         [Alternative Install Options](install.md#alternative-install-options).

``curl`` でのインストールに問題がある場合は、 :ref:`alternative-install-option` をご覧ください。

..   2.  Apply executable permissions to the binary:

2. バイナリに対して実行権限を付与します。

..       ```bash

.. code-block:: bash

   sudo chmod +x /usr/local/bin/docker-compose

..   3.  Optionally, install [command completion](completion.md) for the
         `bash` and `zsh` shell.

3. オプションとして、``bash`` や ``zsh`` シェルの :doc:`コマンドライン補完 </compose/completion>` をインストールします。

..   4.  Test the installation.

4. インストールを確認します。

..    ```bash

.. code-block:: bash

   $ docker-compose --version
   docker-compose version 1.16.1, build 1719ceb

.. raw:: html

   </div>
   <div id="alternatives" class="tab-pane fade" markdown="1">

.. Alternative install options

その他のインストール
--------------------

..   - [Install using pip](#install-using-pip)
     - [Install as a container](#install-as-a-container)

- :ref:`install-using-pip`
- :ref:`install-as-a-container`

..   #### Install using pip

.. _install-using-pip:

pip を利用したインストール
^^^^^^^^^^^^^^^^^^^^^^^^^^

..   Compose can be installed from
     [pypi](https://pypi.python.org/pypi/docker-compose) using `pip`. If you install
     using `pip`, we recommend that you use a
     [virtualenv](https://virtualenv.pypa.io/en/latest/) because many operating
     systems have python system packages that conflict with docker-compose
     dependencies. See the [virtualenv
     tutorial](http://docs.python-guide.org/en/latest/dev/virtualenvs/) to get
     started.

Compose は、``pip`` を使って `pypi <https://pypi.python.org/pypi/docker-compose>`_ からインストールできます。インストールに ``pip`` を使う場合、 `virtualenv <https://virtualenv.pypa.io/en/latest/>`_ の利用をお奨めします。なぜなら多くのオペレーティング・システムにおいて、docker-compose が依存するパッケージ類が、システム内の python パッケージと競合することがあるためです。`virtualenv チュートリアル（英語） <http://docs.python-guide.org/en/latest/dev/virtualenvs/>`_ をご覧ください。

..  ```bash
.. code-block:: bash

   pip install docker-compose

..   if you are not using virtualenv,

virtualenv を利用しない場合は以下を実行します。

..   ```bash
.. code-block:: bash

   sudo pip install docker-compose

..   > pip version 6.0 or greater is required.
.. note::

   pip バージョンは 6.0 以上が必要です。


..   #### Install as a container

.. _install-as-a-container:

コンテナとしてのインストール
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

..   Compose can also be run inside a container, from a small bash script wrapper. To
     install compose as a container run this command. Be sure to replace the version
     number with the one that you want, if this example is out-of-date:

Compose コンテナの中でも、小さな bash スクリプトのラッパーを通することが可能です。
Compose をコンテナとして実行・インストールするには、次のようにします。

..   ```bash
.. code-block:: bash

   $ sudo curl -L --fail https://github.com/docker/compose/releases/download/1.16.1/run.sh -o /usr/local/bin/docker-compose
   $ sudo chmod +x /usr/local/bin/docker-compose

..   >  Use the latest Compose release number in the download command.
     >
     The above command is an _example_, and it may become out-of-date once in a
     while. Check which release it specifies and, if needed, replace the given
     release number with the one that you want. Compose releases are also listed and
     available for direct download on the [Compose repository release page on
     GitHub](https://github.com/docker/compose/releases){: target="_blank"
     class="_"}.
     {: .important}

.. important::

   ダウンロードコマンド内での Compose 最新リリース番号の利用
      上に示したコマンドは一つの例ですから、すでに古いリリース番号になっているかもしれません。
      必ずリリース番号を確認してください。
      そして必要に応じてリリース番号を書き換えてください。
      Compose の各リリースは、`GitHub 上にある Compose リポジトリのリリースページ <https://github.com/docker/compose/releases>`_ から入手することができます。

.. raw:: html

   </div>
   </div>

.. ## Master builds

マスターのビルド
=================

..   If you're interested in trying out a pre-release build you can download a binary
     from
     [https://dl.bintray.com/docker-compose/master/](https://dl.bintray.com/docker-compose/master/).
     Pre-release builds allow you to try out new features before they are released,
     but may be less stable.

プレリリース版を試してみたい方は、https://dl.bintray.com/docker-compose/master/ からバイナリをダウンロードできます。
プレリリース版を使えば、正式リリース前に新たな機能を試すことができます。ただし安定性に欠けるかもしれません。

.. Upgrading

アップグレード方法
====================

.. If you’re upgrading from Compose 1.2 or earlier, you’ll need to remove or migrate your existing containers after upgrading Compose. This is because, as of version 1.3, Compose uses Docker labels to keep track of containers, and so they need to be recreated with labels added.

Compose 1.2 以前からアップグレードする場合、Compose を更新後、既存のコンテナの削除・移行が必要です。これは Compose バージョン 1.3 がコンテナ追跡用に Docker ラベルを用いているためであり、ラベルを追加したものへと置き換える必要があります。

.. If Compose detects containers that were created without labels, it will refuse to run so that you don’t end up with two sets of them. If you want to keep using your existing containers (for example, because they have data volumes you want to preserve) you can use compose 1.5.x to migrate them with the following command:

Compose は作成されたコンテナにラベルがないことを検出したら、実行を拒否し、処理停止と表示します。既存のコンテナを Compose 1.5.x 以降も使い続けたい場合（たとえば、コンテナにデータ・ボリュームがあり、使い続けたい場合）は、次のコマンドで移行できます。

.. code-block:: bash

   $ docker-compose migrate-to-labels

.. Alternatively, if you’re not worried about keeping them, you can remove them. Compose will just create new ones.

あるいは、コンテナを持ち続ける必要がなければ、削除できます。Compose は新しいコンテナを作成します。

.. code-block:: bash

   $ docker rm -f -v myapp_web_1 myapp_db_1 ...

.. Unistallation

アンインストール方法
====================

.. To uninstall Docker Compose if you installed using curl:

``curl`` を使って Docker Compose をインストールした場合は、次のように削除します。

.. code-block:: bash

   $ rm /usr/local/bin/docker-compose

.. To uninstall Docker Compose if you installed using pip:

``pip`` を使って Docker Compose をインストールした場合は、次のように削除します。

.. code-block:: bash

   $ pip uninstall docker-compose

.. Note: If you get a “Permission denied” error using either of the above methods, you probably do not have the proper permissions to remove docker-compose. To force the removal, prepend sudo to either of the above commands and run again.

.. note::

   もし "Permission denied" エラーが表示される場合は、コマンドを実行する前に、``docker-compose`` を削除するための適切な権限が必要です。強制的に削除するには ``sudo`` をあらかじめ実行してから、再度先ほどのコマンドを実行します。

.. Where to go next

次はどこへ行きますか
====================

.. 
    User guide
    Getting Started
    Get started with Django
    Get started with Rails
    Get started with WordPress
    Command line reference
    Compose file reference

* :doc:`ユーザガイド <index>`
* :doc:`gettingstarted`
* :doc:`django`
* :doc:`rails`
* :doc:`wordpress`
* :doc:`reference/index`
* :doc:`compose-file`

.. seealso:: 

   Install Docker Compose
      https://docs.docker.com/compose/install/
