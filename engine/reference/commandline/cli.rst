.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/cli/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/cli/blob/master/docs/reference/commandline/cli.md
.. check date: 2022/03/28
.. Commits on Feb 24, 2022 6ea2767289d3ae7a65183da1758f4753d5053bd8
.. -------------------------------------------------------------------

.. Use the Docker command line

.. _user-the-docker-command-line:

=======================================
Docker コマンドラインを使う
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

==========
docker
==========

.. To list available commands, either run docker with no parameters or execute docker help:

利用可能なコマンドを一覧表示するには、パラメータを付けずに ``docker`` を実行するか、``docker help`` を実行します。

.. code-block:: bash

   $ docker
   Usage: docker [OPTIONS] COMMAND [ARG...]
          docker [ --help | -v | --version ]
   
   A self-sufficient runtime for containers.
   
   Options:
         --config string      Location of client config files (default "/root/.docker")
     -c, --context string     Name of the context to use to connect to the daemon (overrides DOCKER_HOST env var and default context set with "docker context use")
     -D, --debug              Enable debug mode
         --help               Print usage
     -H, --host value         Daemon socket(s) to connect to (default [])
     -l, --log-level string   Set the logging level ("debug"|"info"|"warn"|"error"|"fatal") (default "info")
         --tls                Use TLS; implied by --tlsverify
         --tlscacert string   Trust certs signed only by this CA (default "/root/.docker/ca.pem")
         --tlscert string     Path to TLS certificate file (default "/root/.docker/cert.pem")
         --tlskey string      Path to TLS key file (default "/root/.docker/key.pem")
         --tlsverify          Use TLS and verify the remote
     -v, --version            Print version information and quit
   
   Commands:
       attach    Attach to a running container
       # […]

.. Description

.. _cli-description:

説明
==========

.. Depending on your Docker system configuration, you may be required to preface each docker command with sudo. To avoid having to use sudo with the docker command, your system administrator can create a Unix group called docker and add users to it.

Docker のシステム構成によっては、それぞれの ``docker`` コマンドの前に ``sudo`` を付ける必要があるかもしれません。 ``docker`` コマンドを実行する度に ``sudo`` を実行しないようするには、システム管理者は ``docker`` という Unix グループを作成し、そこへのユーザを追加できます。

.. For more information about installing Docker or sudo configuration, refer to the installation instructions for your operating system.

Docker のインストールや ``sudo`` 設定については、各オペレーティング・システム向けの :doc:`インストール方法 </get-docker>` をご覧ください。

.. Environment variables

.. _environment-variables-cli:

環境変数
====================

.. The following list of environment variables are supported by the docker command line:

以下は、 docker コマンドラインでサポートされている環境変数の一覧です。

.. list-table::
   :header-rows: 1

   * - 変数
     - 説明
   * - ``DOCKER_API_VERSION``
     - デバッグ用に通信時の API バージョンを上書き（例： ``1.19`` ）
   * - ``DOCKER_CERT_PATH``
     - :ruby:`認証鍵 <authentication keys>` の場所。この変数は、 ``docker`` CLI と :doc:`dockerd デーモン <dockerd>` の両方で使用
   * - ``DOCKER_CONFIG``
     - クライアント設定ファイルの場所
   * - ``DOCKER_CONTENT_TRUST_SERVER``
     - 使用する Notary サーバの URL。デフォルトはレジストリと同じ URL
   * - ``DOCKER_CONTENT_TRUST``
     - Docker が Notary を使ってイメージの署名と確認をする場合に指定。 build、 careate、 pull、 push 、 run 用の  ``--disable-content-trust=false`` と同じ
   * - ``DOCKER_CONTEXT``
     - 使用する ``docker context`` の名前（ ``DOCKER_HOST`` 環境変数と、 ``docker context use`` によるデフォルトの context 設定を上書き）
   * - ``DOCKER_DEFAULT_PLATFORM``
     - コマンドを扱うデフォルトのプラットフォームで、 ``--platform`` プラグでも指定可能
   * - ``DOCKER_HIDE_LEGACY_COMMANDS``
     - これを指定すると、Docker は「レガシーな」（過去の）トップレベルコマンド（ ``docker rm`` や ``docker pull`` ）を非表示にし、オブジェクト型の管理コマンド（例： ``docker container`` ）のみ表示します。将来のリリースでは、この環境変数が削除される時点で、デフォルトになる可能性があります。
   * - ``DOCKER_HOST``
     - 接続しようとするデーモンのソケット
   * - ``DOCKER_STACK_ORCHESTRATOR``
     - ``docker stack`` 管理コマンドの利用時に使う、デフォルトのオーケストレータを設定
   * - ``DOCKER_TLS_VERIFY``
     - Docker で TLS を使い、リモート認証をする時に指定。この変数は、 ``docker`` CLI と :doc:`dockerd デーモン <dockerd>` の両方で使用
   * - ``BUILDKIT_PROGRESS``
     - :doc:`構築 <build>` に :ruby:`BuildKit バックエンド <builder-buildkit>` を使用時、進捗の出力タイプ（ ``auto`` 、 ``plain`` 、 ``tty`` ）を指定。plain を使うと、コンテナの出力を表示（デフォルト ``auto`` ）


.. Because Docker is developed using ‘Go’, you can also use any environment variables used by the ‘Go’ runtime. In particular, you may find these useful:

Docker は Go 言語で開発されているので、 Go ランタイムが利用する環境変数も使えます。特に次のものは便利です。

* ``HTTP_PROXY``
* ``HTTPS_PROXY``
* ``NO_PROXY``

.. These Go environment variables are case-insensitive. See the Go specification for details on these variables.

これら Go 言語の環境変数は大文字と小文字を区別しません。変数の詳細については `Go 言語の仕様 <http://golang.org/pkg/net/http/>`_ をご確認ください。

.. Configuration files

.. _configuration-files:

設定ファイル
====================

.. By default, the Docker command line stores its configuration files in a directory called .docker within your HOME directory.

Docker コマンドラインは、ホームディレクトリ ``$HOME`` にある ``.docker`` ディレクトリ内に保管されている設定ファイルを、デフォルトで使います。

.. Docker manages most of the files in the configuration directory and you should not modify them. However, you can modify the config.json file to control certain aspects of how the docker command behaves.

Docker は設定用ディレクトリ内にある大部分のファイルを管理しますので、自分ではこれらを変更すべきではありません。しかしながら、 ``docker`` コマンドの挙動については ``config.json`` ファイルによって詳細に調整できます。

.. You can modify the docker command behavior using environment variables or command-line options. You can also use options within config.json to modify some of the same behavior. If an environment variable and the --config flag are set, the flag takes precedent over the environment variable. Command line options override environment variables and environment variables override properties you specify in a config.json file.

環境変数やコマンドラインのオプションによって、 ``docker`` コマンドの挙動を変更可能です。また、オプションとして ``config.json`` でも同様にいくつかの挙動を変更できます。環境変数と ``--config`` フラグが指定された場合、環境変数よりもフラグが優先されます。コマンドラインのオプションは環境変数による属性を上書きするだけでなく、 ``config.json`` ファイルで指定した :ruby:`属性 <proterty>` も上書きします。

.. Change the .docker directory
.. _change-the-docker-directory:
``.docker`` ディレクトリの変更
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To specify a different directory, use the DOCKER_CONFIG environment variable or the --config command line option. If both are specified, then the --config option overrides the DOCKER_CONFIG environment variable. The example below overrides the docker ps command using a config.json file located in the ~/testconfigs/ directory.

異なるディレクトリを指定するには、 ``DOCKER_CONFIG`` 環境変数か ``--config`` コマンドライン・オプションを使います。両方の指定がある場合、 ``--config`` オプションが ``DOCKER_CONFIG`` 環境変数を上書きします。以下の例は、 ``~/testconfigs/`` ディレクトリに置かれている ``config.json`` ファイルを使って、 ``docker ps`` コマンドを上書きします。

.. code-block:: bash

   $ docker --config ~/testconfigs/ ps

.. This flag only applies to whatever command is being ran. For persistent configuration, you can set the DOCKER_CONFIG environment variable in your shell (e.g. ~/.profile or ~/.bashrc). The example below sets the new directory to be HOME/newdir/.docker.

このフラグが適用できるのは、対象コマンドの実行時のみです。設定を維持し続けたい場合は、シェル上（例 ``~/.profile`` や ``~/.bashrc`` ）で環境変数 ``DOCKER_CONFIG`` を指定してください。以下の例は ``HOME/newdir/.dokcer`` を新しいディレクトリとして指定します。

.. code-block:: bash

   $ echo export DOCKER_CONFIG=$HOME/newdir/.docker > ~/.profile

.. Docker CLI configuration file (config.json) properties
.. _docker cli configuration file configjson properties:
Docker CLI 設定ファイル（ ``config.json`` ）の属性
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Use the Docker CLI configuration to customize settings for the docker CLI. The configuration file uses JSON formatting, and properties:

 ``docker`` CLI の設定をカスタマイズするには、Docker CLI 設定を使います。設定ファイルは JSON 形式を使い、 :ruby:`属性 <proterty>` を持ちます。

.. By default, configuration file is stored in ~/.docker/config.json. Refer to the change the .docker directory section to use a different location.

デフォルトでは、設定ファイルは ``~/.docker/config.json`` に保管されます。異なる場所を使うには、 :ruby:`.docker ディレクトリの変更 <change-the-docker-directory>` を参照ください。

..    Warning
    The configuration file and other files inside the ~/.docker configuration directory may contain sensitive information, such as authentication information for proxies or, depending on your credential store, credentials for your image registries. Review your configuration file’s content before sharing with others, and prevent committing the file to version control.

.. warning::

   ``~/.docker`` 設定ディレクトリ内の設定ファイルと他のファイルには、プロキシの認証情報や、証明書ストア関連、イメージレジストリの証明書といった、機微情報を含む可能性があります。他人と設定ファイル内容を共有する前にレビューを行い、バージョン管理システムにファイルをコミットするのを防いでください。

.. Customize the default output format for commands
.. _customize-the-default-output-format-for-commands:

.. These fields allow you to customize the default output format for some commands if no --format flag is provided.

``--format`` フラグの指定が無い場合、いくつかのコマンドは、以下のフィールドによってデフォルトの出力をカスタマイズできます。

.. list-table::
   :header-rows: 1

   * - :ruby:`属性 <property>`
     - 説明
   * - ``configFormat``
     - ``docker config ls`` 出力のデフォルト形式を変更します。サポートしているフォーマット命令の一覧は、 ``docker config ls`` ドキュメントの :ruby:`出力形式 <config_ls-format-the-output>` セクションを参照
   * - ``imagesFormat``
     - ``docker images`` / ``docker image ls`` 出力のデフォルト形式を変更します。サポートしているフォーマット命令の一覧は、 ``docker image ls`` ドキュメントの :ruby:`出力形式 <image_ls-format-the-output>` セクションを参照
   * - ``nodesFormat``
     - ``docker node ls`` 出力のデフォルト形式を変更します。サポートしているフォーマット命令の一覧は、 ``docker node ls`` ドキュメントの :ruby:`出力形式 <node_ls-format-the-output>` セクションを参照
   * - ``pluginsFormat``
     - ``docker plugin ls`` 出力のデフォルト形式を変更します。サポートしているフォーマット命令の一覧は、 ``docker plugin ls`` ドキュメントの :ruby:`出力形式 <plugin_ls-format-the-output>` セクションを参照
   * - ``psFormat``
     - ``docker ps`` / ``docker container ps`` 出力のデフォルト形式を変更します。サポートしているフォーマット命令の一覧は、 ``docker ps ls`` ドキュメントの :ruby:`出力形式 <docker_ps-format-the-output>` セクションを参照
   * - ``secretFormat``
     - ``docker secret ls`` 出力のデフォルト形式を変更します。サポートしているフォーマット命令の一覧は、 ``docker secret ls`` ドキュメントの :ruby:`出力形式 <secret_ls-format-the-output>` セクションを参照
   * - ``serviceInspectFormat``
     - ``docker service inspect`` 出力のデフォルト形式を変更します。サポートしているフォーマット命令の一覧は、 ``docker service inspect`` ドキュメントの :ruby:`出力形式 <service_inspect-format-the-output>` セクションを参照
   * - ``servicesFormat``
     - ``docker service ls`` 出力のデフォルト形式を変更します。サポートしているフォーマット命令の一覧は、 ``docker service ls`` ドキュメントの :ruby:`出力形式 <service_ls-format-the-output>` セクションを参照
   * - ``statsFormat``
     - ``docker stats`` 出力のデフォルト形式を変更します。サポートしているフォーマット命令の一覧は、 ``docker stats`` ドキュメントの :ruby:`出力形式 <docker_stats-format-the-output>` セクションを参照

.. Custom HTTP headers
.. _custom-http-headers:
HTTP ヘッダの調整
^^^^^^^^^^^^^^^^^^^^

.. The property HttpHeaders specifies a set of headers to include in all messages sent from the Docker client to the daemon. Docker does not try to interpret or understand these header; it simply puts them into the messages. Docker does not allow these headers to change any headers it sets for itself.

``HttpHeader`` 属性は、Docker クライアントがデーモンに対して送信するとき、全てのメッセージに含めるヘッダを指定します。Docker は、これらのヘッダを解釈したり理解しようとしません。つまり、単純にメッセージの中に追加するだけです。Docker は設定したヘッダ自身に対する変更を許可しません。

.. Credential store options
.. _cli-credentail-store-options:
認証情報ストアのオプション
------------------------------

.. The property credsStore specifies an external binary to serve as the default credential store. When this property is set, docker login will attempt to store credentials in the binary specified by docker-credential-<value> which is visible on $PATH. If this property is not set, credentials will be stored in the auths property of the config. For more information, see the Credentials store section in the docker login documentation

属性 ``credsStore`` は、デフォルトの証明書ストアを提供する、外部のバイナリを指定します。この属性を指定すると、 ``docker login`` は、 ``$PATH`` 上に見える ``docker-credentail-<value>`` で指定したバイナリに、認証情報の保管を試みます。この属性を指定しなければ、認証情報は設定上の ``auths`` 属性に保管されます。詳しい情報は ``docker login`` ドキュメントの :ruby:`認証情報ストア <docker_login-credentials-store>` のドキュメントをご覧ください。

.. The property credHelpers specifies a set of credential helpers to use preferentially over credsStore or auths when storing and retrieving credentials for specific registries. If this property is set, the binary docker-credential-<value> will be used when storing or retrieving credentials for a specific registry. For more information, see the Credential helpers section in the docker login documentation

属性 ``credsHelpers`` は、指定のレジストリに対する認証情報の保管・収集時、 ``credSotre`` や ``auths`` よりも優先して使う :ruby:`認証情報ヘルパー <credential helper>` を指定します。この属性を指定しなければ、指定のレジストリに対して認証情報の保管・収集時、 ``docker-credential-<value>`` バイナリの利用を試みます。詳しい情報は ``docker login`` ドキュメントの :ruby:`認証情報ヘルパー <docker_login-credential-helper>` のドキュメントをご覧ください。

.. Orchestrator options for docker stacks
.. _orchestrator-options-for-docker-stacks:
docker stack 用のオーケストレータ・オプション
--------------------------------------------------

.. The property stackOrchestrator specifies the default orchestrator to use when running docker stack management commands. Valid values are "swarm", "kubernetes", and "all". This property can be overridden with the DOCKER_STACK_ORCHESTRATOR environment variable, or the --orchestrator flag.

属性 ``stackOrchestrator`` は、 ``docker stack`` 管理コマンドの実行時に使われる、デフォルトのオーケストレータを指定します。有効な値は ``"swarm"`` 、 ``"kubernetes"`` 、 ``"all"`` です。ｋの属性は ``DOCKER_STACK_ORCHESTRATOR`` 環境変数や、 ``--orchestrator`` フラグで上書きできます。

.. Automatic proxy configuration for containers
.. _automatic-proxy-configuration-for-containers:
コンテナ用のプロキシ設定を自動化
----------------------------------------

.. The property proxies specifies proxy environment variables to be automatically set on containers, and set as --build-arg on containers used during docker build. A "default" set of proxies can be configured, and will be used for any docker daemon that the client connects to, or a configuration per host (docker daemon), for example, “https://docker-daemon1.example.com”. The following properties can be set for each environment:

属性 ``proxies`` は、コンテナ上へ自動的にプロキシ環境変数を設定します。また、コンテナを ``docker build`` する時の、 ``--build-arg`` にも設定できます。プロキシの ``"default"`` を設定すると、クライアントが接続する、あらゆる docker デーモンに対して適用するか、ホスト（docker デーモン）ごとの設定で適用します。設定は “https://docker-daemon1.example.com” のようにします。以下の属性が、各環境で設定できます。

.. list-table::
   :header-rows: 1

   * - :ruby:`属性 <property>`
     - 説明
   * - ``httpProxy``
     - コンテナに対する ``HTTP_PROXY`` と ``http_proxy`` のデフォルト値であり、 ``docker build`` 時の ``--build-arg`` でも同じ
   * - ``httpsProxy``
     - コンテナに対する ``HTTPS_PROXY`` と ``https_proxy`` のデフォルト値であり、 ``docker build`` 時の ``--build-arg`` でも同じ
   * - ``ftpProxy``
     - コンテナに対する ``FTP_PROXY`` と ``ftp_proxy`` のデフォルト値であり、 ``docker build`` 時の ``--build-arg`` でも同じ
   * - ``noProxy``
     - コンテナに対する ``NO_PROXY`` と ``no_proxy`` のデフォルト値であり、 ``docker build`` 時の ``--build-arg`` でも同じ

.. These settings are used to configure proxy settings for containers only, and not used as proxy settings for the docker CLI or the dockerd daemon. Refer to the environment variables and HTTP/HTTPS proxy sections for configuring proxy settings for the cli and daemon.

..    Warning
    Proxy settings may contain sensitive information (for example, if the proxy requires authentication). Environment variables are stored as plain text in the container’s configuration, and as such can be inspected through the remote API or committed to an image when using docker commit.

.. warning::

   プロキシ設定には機微情報を含む場合があります（たとえば、プロキシで認証が必要な場合）。環境変数はコンテナの設定に平文として保管されるため、リモート API を通した調査や、 ``docker commit`` を使ったイメージのコミット時に調査される可能性があります。

.. Default key-sequence to detach from containers
.. _default-key-sequence-to-detach-from-containers:
コンテナからデタッチするデフォルトのキー手順
--------------------------------------------------

.. Once attached to a container, users detach from it and leave it running using the using CTRL-p CTRL-q key sequence. This detach key sequence is customizable using the detachKeys property. Specify a <sequence> value for the property. The format of the <sequence> is a comma-separated list of either a letter [a-Z], or the ctrl- combined with any of the following:

コンテナにアタッチ後は、 ``CTRL-p CTRL-q`` キー・シーケンスで使ってデタッチできます。このデタッチ用キー・シーケンスは ``detachKeys`` 属性を使ってカスタマイズできます。カスタマイズでは ``<シーケンス>`` 値の属性を指定します。 ``<シーケンス>`` の書式は [a-Z] までの文字列をカンマ区切りにしたリストにするか、 ``ctrl-`` に以下のいずれかを組み合わせます。

..    a-z (a single lowercase alpha character )
    @ (at sign)
    [ (left bracket)
    \\ (two backward slashes)
    _ (underscore)
    ^ (caret)

* ``a-z`` （小文字のアルファベット文字列）
* ``@`` （アット記号）
* ``[`` （左かっこ）
* ``\\`` （２つのバックスラッシュ）
* ``_`` （アンダースコア）
* ``^`` （キャレット）

.. Your customization applies to all containers started in with your Docker client. Users can override your custom or the default key sequence on a per-container basis. To do this, the user specifies the --detach-keys flag with the docker attach, docker exec, docker run or docker start command.

Docker クライアントで起動するコンテナ全てにカスタマイズが適用されます。ユーザはコンテナごとにデフォルトのキー・シーケンスを変更可能です。ユーザが指定するには、 ``--detach-keys`` フラグを ``docker attach`` 、 ``docker exec`` 、 ``docker run`` 、 ``docker start`` コマンドで使います。

.. CLI Plugin options
.. _cli-plugin-options:
CLI プラグインのオプション
------------------------------

.. The property plugins contains settings specific to CLI plugins. The key is the plugin name, while the value is a further map of options, which are specific to that plugin.

属性 ``plugin`` には CLI プラグインに対する設定を含みます。キーはプラグイン名で、値にはオプションを割り当てます。いずれもプラグインによって指定されているものです。

.. Sample configuration file
.. _cli-sample-configuration-file:
設定ファイル例
--------------------

.. Following is a sample config.json file to illustrate the format used for various fields:

以下は、様々な形式のフィールドを利用する ``config.json`` ファイルの例です。

.. code-block:: json

   {
     "HttpHeaders": {
       "MyHeader": "MyValue"
     },
     "psFormat": "table {{.ID}}\\t{{.Image}}\\t{{.Command}}\\t{{.Labels}}",
     "imagesFormat": "table {{.ID}}\\t{{.Repository}}\\t{{.Tag}}\\t{{.CreatedAt}}",
     "pluginsFormat": "table {{.ID}}\t{{.Name}}\t{{.Enabled}}",
     "statsFormat": "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}",
     "servicesFormat": "table {{.ID}}\t{{.Name}}\t{{.Mode}}",
     "secretFormat": "table {{.ID}}\t{{.Name}}\t{{.CreatedAt}}\t{{.UpdatedAt}}",
     "configFormat": "table {{.ID}}\t{{.Name}}\t{{.CreatedAt}}\t{{.UpdatedAt}}",
     "serviceInspectFormat": "pretty",
     "nodesFormat": "table {{.ID}}\t{{.Hostname}}\t{{.Availability}}",
     "detachKeys": "ctrl-e,e",
     "credsStore": "secretservice",
     "credHelpers": {
       "awesomereg.example.org": "hip-star",
       "unicorn.example.com": "vcbait"
     },
     "plugins": {
       "plugin1": {
         "option": "value"
       },
       "plugin2": {
         "anotheroption": "anothervalue",
         "athirdoption": "athirdvalue"
       }
     },
     "proxies": {
       "default": {
         "httpProxy":  "http://user:pass@example.com:3128",
         "httpsProxy": "https://my-proxy.example.com:3129",
         "noProxy":    "intra.mycorp.example.com",
         "ftpProxy":   "http://user:pass@example.com:3128",
         "allProxy":   "socks://example.com:1234"
       },
       "https://manager1.mycorp.example.com:2377": {
         "httpProxy":  "http://user:pass@example.com:3128",
         "httpsProxy": "https://my-proxy.example.com:3129"
       }
     }
   }

.. Experimental features
.. _cli-experimental-features:
:ruby:`実験的機能 <experimetal features>`
--------------------------------------------------

.. Experimental features provide early access to future product functionality. These features are intended for testing and feedback, and they may change between releases without warning or can be removed from a future release.

実験的機能により、今後追加されるプロダクト機能に :ruby:`早期アクセス <early access>` できます。これら機能はテストとフィードバックを意図しているため、今後のリリースでは警告のない機能変更や、機能削除の可能性があります。

.. Starting with Docker 20.10, experimental CLI features are enabled by default, and require no configuration to enable them.

Docker 20.10 からは、デフォルトでは実験的 CLI 機能は有効であり、有効化する設定は不要です。

.. Notary
.. cli-notary:
Notary
----------

.. If using your own notary server and a self-signed certificate or an internal Certificate Authority, you need to place the certificate at tls/<registry_url>/ca.crt in your docker config directory.

自身で Notary サーバを使っている場合で、もしも自己証明の証明書や、内部の証明機関を使っているのであれば、docker 設定ディレクトリにある ``tls/<レジストリのURL>/ca.crt`` 証明書を置き換える必要があります。

.. Alternatively you can trust the certificate globally by adding it to your system’s list of root Certificate Authorities.

あるいは、自分の証明書を信頼できるようにするためには、自分のシステム上のルート証明機関一覧に証明書を追加する方法もあります。

.. Examples
.. _docker_cli-examples:

使用例
==========

.. Display help text
.. _cli-display-help-text
ヘルプ文字の表示
--------------------

.. To list the help on any command just execute the command, followed by the --help option.

あらゆるコマンドでヘルプ一覧を表示するには、実行するコマンドの後に ``--help`` オプションを付けます。

.. code-block:: bash

   $ docker run --help
   
   Usage: docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
   
   Run a command in a new container
   
   Options:
         --add-host value             Add a custom host-to-IP mapping (host:ip) (default [])
     -a, --attach value               Attach to STDIN, STDOUT or STDERR (default [])
   <...>

.. Option types
.. _docker-cli-option-types:
オプションのタイプ
--------------------

.. Single character command line options can be combined, so rather than typing docker run -i -t --name test busybox sh, you can write docker run -it --name test busybox sh.

１文字のコマンドラインのオプションは、連結できます。 ``docker run -i -t --name test busybox sh`` は、 ``docker run -it -name test busybox sh`` に書き換えられます。

.. Boolean
.. _cli-boolean:

ブール値
^^^^^^^^^^

.. Boolean options take the form -d=false. The value you see in the help text is the default value which is set if you do not specify that flag. If you specify a Boolean flag without a value, this will set the flag to true, irrespective of the default value.

ブール値のオプションとは ``-d=false`` のような形式です。何らかのフラグを設定 **しない** 場合のデフォルト値は、ヘルプテキストで確認できます。ブール値にフラグ値を指定しなければ、デフォルト値に関係なくフラグは ``true`` になります。

.. For example, running docker run -d will set the value to true, so your container will run in “detached” mode, in the background.

例えば、 ``docker run -d`` を実行すると、値は ``true`` になります。そのため、コンテナは「デタッチド」モードとしてバックグラウンドで動作します。

.. Options which default to true (e.g., docker build --rm=true) can only be set to the non-default value by explicitly setting them to false:

オプションのデフォルトは ``true`` （例： ``docker build --rm=true`` ）ですが、デフォルトではない値を指定するには ``false`` を明示します。

.. code-block:: bash

   $ docker build --rm=false .

.. Multi
.. _cli-multi:
複数回の指定
^^^^^^^^^^^^^^^^^^^^

.. You can specify options like -a=[] multiple times in a single command line, for example in these commands:

``-a=[]`` のようなオプションは、コマンドライン上で複数回使えます。例えば、次のようなコマンドです。

.. code-block:: bash

   $ docker run -a stdin -a stdout -i -t ubuntu /bin/bash
   
   $ docker run -a stdin -a stdout -a stderr ubuntu /bin/ls

.. Sometimes, multiple options can call for a more complex value string as for -v:

オプションによっては、 ``-v`` のように複雑になる場合もあります。

.. code-block:: bash

   $ docker run -v /host:/container example/mysql

..    Note: Do not use the -t and -a stderr options together due to limitations in the pty implementation. All stderr in pty mode simply goes to stdout.

.. note::

   ``pty`` 実装に限界があるため、 ``-t`` と ``-a stderr`` オプションを同時に使わないでください。 ``pty`` モードの ``stderr`` （標準エラー出力）は、単純に ``stdout`` （標準出力）になります。

..  Strings and Integers
.. _cli-strings-and-integers:

文字列と整数
--------------------

.. Options like --name="" expect a string, and they can only be specified once. Options like -c=0 expect an integer, and they can only be specified once.

``--name=""`` のように文字が含まれるオプションは、１つしか指定できません。 ``-c=0`` のように整数の場合も、１つしか指定できません。


