.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/login/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/login.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/login.md
.. check date: 2016/06/12
.. Commits on Mar 14, 2016 b9361f02da25108af75238093959634e433d72a0
.. -------------------------------------------------------------------

.. login

=======================================
login
=======================================

.. code-block:: bash

   使い方: docker login [オプション] [サーバ]
   
   Docker レジストリ・サーバに登録またはログインする
   サーバの指定が無ければデフォルトで "https://index.docker.io/v1/" を使用
   
     -e, --email=""       メールアドレス
     --help               使い方の表示
     -p, --password=""    パスワード
     -u, --username=""    ユーザ名
   
.. If you want to login to a self-hosted registry you can specify this by adding the server name.

自分でホストしているレジストリにログインするには、サーバ名を指定します。

.. example:

例：

.. code-block:: bash

   $ docker login localhost:8080

.. docker login requires user to use sudo or be root, except when:

``docker login`` の実行には ``sudo`` か ``root`` になる必要があります。ただし次の場合は除外します。

..    connecting to a remote daemon, such as a docker-machine provisioned docker engine.
..    user is added to the docker group. This will impact the security of your system; the docker group is root equivalent. See Docker Daemon Attack Surface for details.

1. ``docker-machine`` を使い、 ``docker engine`` を自動設定したようなリモート・デーモンに接続時。
2. ``docker`` グループに追加されたユーザ。システム上のセキュリティ・リスクになります。 ``docker`` グループは ``root`` と同等のためです。詳細は :ref:`Docker デーモンが直面する攻撃 <docker-daemon-attack-surface>` をご覧ください。

.. You can log into any public or private repository for which you have credentials. When you log in, the command stores encoded credentials in $HOME/.docker/config.json on Linux or %USERPROFILE%/.docker/config.json on Windows.

証明書（credential）があれば、あらゆるパブリックないしプライベートなリポジトリにログインできます。ログインしたら、コマンドは符号化（エンコード）した証明書を Linux であれば ``$HOME/.docker/config.json`` に、Windows であれば ``%USERPROFILE%/.docker/config.json`` に保管します。

..    Note: When running sudo docker login credentials are saved in /root/.docker/config.json.

.. note::

   ``sudo docker login`` を実行したら、証明書は ``/root/.docker/config.json`` に保管されます。

.. Credentials store

.. _creadentials-store:

証明書ストア
====================

.. The Docker Engine can keep user credentials in an external credentials store, such as the native keychain of the operating system. Using an external store is more secure than storing credentials in the Docker configuration file.

Docker Engine はユーザの証明書（credential）を外部の証明書ストアに保存できます。外部の証明書ストアとは、オペレーティング・システムのネイティブなキーチェーン（keychain）です。Docker 設定ファイルに証明書を保管するよりも、外部のストアを使う方がセキュリティは高いです。

.. To use a credentials store, you need an external helper program to interact with a specific keychain or external store. Docker requires the helper program to be in the client’s host $PATH.

証明書ストアを使うには、キーチェーンや外部ストアと接続する外部のヘルパー・プログラムが必要です。Docker はクライアント・ホスト上の ``$PATH`` にヘルパー・プログラムが必要です。

.. This is the list of currently available credentials helpers and where you can download them from:

こちらは現時点で利用可能な証明書ヘルパー・プログラムと、ダウンロード先の一覧です。

..    D-Bus Secret Service: https://github.com/docker/docker-credential-helpers/releases
    Apple OS X keychain: https://github.com/docker/docker-credential-helpers/releases
    Microsoft Windows Credential Manager: https://github.com/docker/docker-credential-helpers/releases

* D-Bus シークレット・サービス： https://github.com/docker/docker-credential-helpers/releases
* Apple OS X キーチェーン：https://github.com/docker/docker-credential-helpers/releases
* Microsoft Windows 資格情報マネージャ：https://github.com/docker/docker-credential-helpers/releases

.. Usage

使い方
----------

.. You need to speficy the credentials store in $HOME/.docker/config.json to tell the docker engine to use it:

証明書ストアを使うには ``$HOME/.docker/config.json`` で Docker Engine に対して指定する必要があります。

.. code-block:: json

   {
   	"credsStore": "osxkeychain"
   }

.. If you are currently logged in, run docker logout to remove the credentials from the file and run docker login again.

既にログイン状態であれば、 ``docker logout`` を実行し、ファイルから認証情報を削除します。それから ``docker login`` を再び実行します。

.. Protocol

プロトコル
----------

.. Credential helpers can be any program or script that follows a very simple protocol. This protocol is heavily inspired by Git, but it differs in the information shared.

証明書ヘルパーは、どのようなプログラムやスクリプトでも扱える非常にシンプルなプロトコルです。このプロトコルは Git のアイディアに強く影響を受けていますが、情報を共有する仕組みは違います。

.. The helpers always use the first argument in the command to identify the action. There are only three possible values for that argument: store, get, and erase.

ヘルパーはコマンドのアクションを決めるため、常に１番めの引数を使います。ここで利用可能な引数とは ``store``  ``get`` ``erase`` のいずれかです。

.. The store command takes a JSON payload from the standard input. That payload carries the server address, to identify the credential, the user name, and either a password or an identity token.

``store`` 命令は標準入力の JSON ペイロードを取得します。ペイロードではサーバのアドレス、証明書の指定、ユーザ名、パスワードあるいは識別用トークンを渡します。

.. code-block:: json

   {
   	"ServerURL": "https://index.docker.io/v1",
   	"Username": "david",
   	"Secret": "passw0rd1"
    }

.. If the secret being stored is an identity token, the Username should be set to <token>.

もしシークレット（訳者注：証明書やトークンなどの秘密情報の意味）が識別用トークンを保管する場合、ユーザ名にあたる部分は ``<token>`` がセットされます。

.. The store command can write error messages to STDOUT that the docker engine will show if there was an issue.

``store`` 命令は何らかの問題が Docker Engine で発生したとき、 ``STDOUT`` （標準出力に）エラーを表示できます。

.. The get command takes a string payload from the standard input. That payload carries the server address that the docker engine needs credentials for. This is an example of that payload: https://index.docker.io/v1.

``get`` 命令は ``STDIN`` （標準入力）からの文字列をペイロードとして読み込みます。Docker Engine が必要とする証明書を持っているサーバのアドレスをペイロードで渡します。 ``https://index.docker.io/v1`` はペイロードの例です。

.. The get command writes a JSON payload to STDOUT. Docker reads the user name and password from this payload:

``get`` 命令は JSON ペイロードを ``STDOUT`` （標準出力）に書き出します。Docker は、このペイロードからユーザ名とパスワードを読み込みます。読み込みます。

.. code-block:: json

   {
   	"Username": "david",
   	"Secret": "passw0rd1"
   }

.. The erase command takes a string payload from STDIN. That payload carries the server address that the docker engine wants to remove credentials for. This is an example of that payload: https://index.docker.io/v1.

``erase`` 命令は ``STDIN`` （標準入力）からの文字列をペイロードとして読み込みます。Docker Engine が必要とする証明書を持っているサーバのアドレスをペイロードで渡します。 ``https://index.docker.io/v1`` はペイロードの例です。

.. The erase command can write error messages to STDOUT that the docker engine will show if there was an issue.

``store`` 命令は何らかの問題が Docker Engine で発生したとき、 ``STDOUT`` （標準出力に）エラーを表示できます。

.. seealso:: 

   login
      https://docs.docker.com/engine/reference/commandline/login/
