.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/login/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/login.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_login.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker login

=======================================
docker login
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_login-description:

説明
==========

.. Log in to a Docker registry

Docker レジストリに :ruby:`ログイン <log in>` します。

.. _docker_login-usage:

使い方
==========

.. code-block:: bash

   $ docker login [OPTIONS] [SERVER]

.. Extended description
.. _docker_login-extended-description:

補足説明
==========

.. Login to a registry.

レジストリにログインします。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_login-examples>` をご覧ください。

.. _docker_login-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--password`` , ``-p``
     - 
     - パスワード
   * - ``--password-stdin``
     - 
     - 標準入力からパスワードを取得
   * - ``--username`` , ``-u``
     - 
     - ユーザ名

.. Examples
.. _docker_login-examples:

使用例
==========

.. Login to a self-hosted registry
.. _docker-login-login-to-a-self-hosted-registry:
自己ホストしているレジストリにログイン
-------------------------------------------------

.. If you want to login to a self-hosted registry you can specify this by adding the server name.

自分でホストしているレジストリにログインするには、サーバ名を指定します。

.. code-block:: bash

   $ docker login localhost:8080


.. Provide a password using STDIN
.. _docker-login-provide-a-password-using-stdin:
標準入力を使ってパスワードを与える
----------------------------------------

.. To run the docker login command non-interactively, you can set the --password-stdin flag to provide a password through STDIN. Using STDIN prevents the password from ending up in the shell’s history, or log-files.

``docker login`` コマンドの実行とは、双方向ではありません。ですが、 ``--password-stdin`` フラグをを使えば、 ``STDIN`` を通してパスワードを与えられます。 ``STDIN`` の使用により、シェルの履歴やログファイル上にパスワードが記録されるのを防ぎます。

.. The following example reads a password from a file, and passes it to the docker login command using STDIN:

以下の例は、パスワードをファイルから読み込み、それを ``STDIN`` を使う ``docker login`` コマンドに渡します。

.. code-block:: bash

   $ cat ~/my_password.txt | docker login --username foo --password-stdin

.. Privileged user requirement
.. _docker-login-privileged-user-requirement:
:ruby:`特権ユーザ <privileged user>` の必要条件
--------------------------------------------------

.. docker login requires user to use sudo or be root, except when:

``docker login`` の実行には ``sudo`` か ``root`` になる必要があります。ただし次の場合は除外します。

..    connecting to a remote daemon, such as a docker-machine provisioned docker engine.
..    user is added to the docker group. This will impact the security of your system; the docker group is root equivalent. See Docker Daemon Attack Surface for details.

1. ``docker-machine`` を使い、 ``docker engine`` が自動設定されたようなリモート・デーモンへの接続時。
2. ``docker`` グループに追加されたユーザ。システム上のセキュリティ・リスクになります。 ``docker`` グループは ``root`` と同等のためです。詳細は :ref:`Docker デーモンが直面する攻撃 <docker-daemon-attack-surface>` をご覧ください。

.. You can log into any public or private repository for which you have credentials. When you log in, the command stores credentials in $HOME/.docker/config.json on Linux or %USERPROFILE%/.docker/config.json on Windows, via the procedure described below

:ruby:`認証情報 <credentia>` があれば、あらゆるパブリックないしプライベートなリポジトリにログインできます。ログインしたら、コマンドは :ruby:`認証情報 <credential>` を Linux であれば ``$HOME/.docker/config.json`` に、Windows であれば ``%USERPROFILE%/.docker/config.json`` に保管します。手順は以降で説明します。

.. Credentials store
.. _docker_login-creadentials-store:

認証情報の保存場所
--------------------

.. The Docker Engine can keep user credentials in an external credentials store, such as the native keychain of the operating system. Using an external store is more secure than storing credentials in the Docker configuration file.

Docker Engine はユーザの認証情報を外部の認証情報ストアに保存できます。外部の認証情報ストアとは、オペレーティング・システムに搭載するキーチェーン（keychain）です。Docker 設定ファイルに認証情報を保管するより、外部のストアを使う方が、より安全です。

.. To use a credentials store, you need an external helper program to interact with a specific keychain or external store. Docker requires the helper program to be in the client’s host $PATH.

認証情報ストアを使うには、キーチェーンや外部ストアと接続するための、外部のヘルパー・プログラムが必要です。Docker はクライアント・ホスト上の ``$PATH`` にヘルパー・プログラムを必要とします。

.. This is the list of currently available credentials helpers and where you can download them from:

こちらは現時点で利用可能な認証情報ヘルパー・プログラムと、ダウンロード先の一覧です。

..    D-Bus Secret Service: https://github.com/docker/docker-credential-helpers/releases
    Apple macOS keychain: https://github.com/docker/docker-credential-helpers/releases
    Microsoft Windows Credential Manager: https://github.com/docker/docker-credential-helpers/releases
    pass: https://github.com/docker/docker-credential-helpers/releases

* D-Bus シークレット・サービス： https://github.com/docker/docker-credential-helpers/releases
* Apple OS X キーチェーン： https://github.com/docker/docker-credential-helpers/releases
* Microsoft Windows 資格情報マネージャ： https://github.com/docker/docker-credential-helpers/releases
* `pass <https://www.passwordstore.org/>`_ ： https://github.com/docker/docker-credential-helpers/releases

.. Configure the credentials store
.. _docker_login-configure-the-credentials-store:
認証情報ストアの設定方法
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You need to specify the credentials store in $HOME/.docker/config.json to tell the docker engine to use it. The value of the config property should be the suffix of the program to use (i.e. everything after docker-credential-). For example, to use docker-credential-osxkeychain:

認証情報ストアは ``$HOME/.docker/config.json`` で指定し、 Docker Engine にこれを使うよう指定する必要があります。設定項目の値には、プログラムが使用する接頭句を使う必要があります（例： すべて ``docker-credential-`` に続きます）。たとえば、 ``docker-credential-osxkeychain`` には、次のようにします。

.. code-block:: json

   {
   	"credsStore": "osxkeychain"
   }

.. If you are currently logged in, run docker logout to remove the credentials from the file and run docker login again.

既にログイン状態であれば、 ``docker logout`` を実行し、ファイルから認証情報を削除します。それから ``docker login`` を再び実行します。

.. Default behavior
.. _docker_login-default-behavior:
デフォルトの挙動
^^^^^^^^^^^^^^^^^^^^

.. By default, Docker looks for the native binary on each of the platforms, i.e. “osxkeychain” on macOS, “wincred” on windows, and “pass” on Linux. A special case is that on Linux, Docker will fall back to the “secretservice” binary if it cannot find the “pass” binary. If none of these binaries are present, it stores the credentials (i.e. password) in base64 encoding in the config files described above.

デフォルトでは、Docker は各プラットフォームのネイティブなバイナリを探します。たとえば、 macOS であれば「osxkeychain」、Windows であれば「wincerd」、Linux であれば「pass」です。Linux では特別な状況で、Docker は「pass」バイナリが見つからない場合、「secretservice」を頼りにします。もしも、これらのバイナリが存在しなければ、先ほど記述した設定ファイル中に、 base64 エンコーディングした認証情報（例：パスワード）を保管します。

.. Credential helper protocol
.. _docker_login-credential-helper-protocol:
認証情報ヘルパーのプロトコル
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Credential helpers can be any program or script that follows a very simple protocol. This protocol is heavily inspired by Git, but it differs in the information shared.

: ruby:`認証情報ヘルパー <credential helper>` は、どのようなプログラムやスクリプトでも扱える非常にシンプルなプロトコルです。このプロトコルは Git のアイディアに強く影響を受けていますが、情報を共有する仕組みは違います。

.. The helpers always use the first argument in the command to identify the action. There are only three possible values for that argument: store, get, and erase.

ヘルパーはコマンドのアクションを決めるため、常に１番めの引数を使います。ここで利用可能な引数とは ``store``  ``get`` ``erase`` のいずれかです。

.. The store command takes a JSON payload from the standard input. That payload carries the server address, to identify the credential, the user name, and either a password or an identity token.

``store`` 命令は標準入力の JSON ペイロードを取得します。ペイロードではサーバのアドレス、認証情報の指定、ユーザ名、パスワードあるいは識別用トークンを渡します。

.. code-block:: json

   {
   	"ServerURL": "https://index.docker.io/v1",
   	"Username": "david",
   	"Secret": "passw0rd1"
    }

.. If the secret being stored is an identity token, the Username should be set to <token>.

もしシークレット（訳者注：認証情報やトークンなどの秘密情報の意味）が識別用トークンを保管する場合、ユーザ名にあたる部分は ``<token>`` がセットされます。

.. The store command can write error messages to STDOUT that the docker engine will show if there was an issue.

``store`` 命令は何らかの問題が Docker Engine で発生したとき、 ``STDOUT`` （標準出力に）エラーを表示できます。

.. The get command takes a string payload from the standard input. That payload carries the server address that the docker engine needs credentials for. This is an example of that payload: https://index.docker.io/v1.

``get`` 命令は ``STDIN`` （標準入力）からの文字列をペイロードとして読み込みます。Docker Engine が必要とする認証情報を持っているサーバのアドレスをペイロードで渡します。 ``https://index.docker.io/v1`` はペイロードの例です。

.. The get command writes a JSON payload to STDOUT. Docker reads the user name and password from this payload:

``get`` 命令は JSON ペイロードを ``STDOUT`` （標準出力）に書き出します。Docker は、このペイロードからユーザ名とパスワードを読み込みます。

.. code-block:: json

   {
   	"Username": "david",
   	"Secret": "passw0rd1"
   }

.. The erase command takes a string payload from STDIN. That payload carries the server address that the docker engine wants to remove credentials for. This is an example of that payload: https://index.docker.io/v1.

``erase`` 命令は ``STDIN`` （標準入力）からの文字列をペイロードとして読み込みます。Docker Engine が必要とする認証情報を持っているサーバのアドレスをペイロードで渡します。 ``https://index.docker.io/v1`` はペイロードの例です。

.. The erase command can write error messages to STDOUT that the docker engine will show if there was an issue.

``store`` 命令は何らかの問題が Docker Engine で発生したとき、 ``STDOUT`` （標準出力に）エラーを表示できます。

.. Credential helpers
.. _docker_login-credential-helpers:
認証情報ヘルパー
--------------------

.. Credential helpers are similar to the credential store above, but act as the designated programs to handle credentials for specific registries. The default credential store (credsStore or the config file itself) will not be used for operations concerning credentials of the specified registries.

:ruby:`認証情報ヘルパー <credential helpers>` は、先述の認証情報ストアと似ていますが、プログラムは「特定のレジストリ」に対応する認証情報を扱うように設計されています。特定のレジストリで認証情報を処理する場合、デフォルトの認証情報ストア（ ``credsStore`` あるいは設定ファイル自身）を使いません。

.. Configure credential helpers
.. _docker_login-configure-credential-helpers:

認証情報ヘルパーの設定
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. If you are currently logged in, run docker logout to remove the credentials from the default store.

既にログイン中の場合は、 ``docker logout`` を実行し、デフォルトのストアから認証情報を削除します。

.. Credential helpers are specified in a similar way to credsStore, but allow for multiple helpers to be configured at a time. Keys specify the registry domain, and values specify the suffix of the program to use (i.e. everything after docker-credential-). For example:

認証情報ヘルパーは ``credsStore`` と似たような方法で指定しますが、同時に複数のヘルパーを設定できます。キーではレジストリのドメインを指定し、バリューではプログラムが使用する接頭句（例：すべて ``docker-credential-`` に続きます）を指定します。以下は例です。

.. code-block:: yaml

   {
     "credHelpers": {
       "registry.example.com": "registryhelper",
       "awesomereg.example.org": "hip-star",
       "unicorn.example.io": "vcbait"
     }
   }


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker login
      https://docs.docker.com/engine/reference/commandline/login/
