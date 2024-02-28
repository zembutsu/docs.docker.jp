.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/cli-command-compatibility/
.. SOURCE: 
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/cli-command-compatibility.md
.. check date: 2022/07/18
.. Commits on May 3, 2022 30a338564016300483f30f6beb3ec7d280a0bd3e
.. -------------------------------------------------------------------

.. Compose command compatibility with docker-compose
.. _compose-command-compatibility-with-docker-compose:

==================================================
compose コマンドと docker-compose の互換性
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The compose command in the Docker CLI supports most of the docker-compose commands and flags. It is expected to be a drop-in replacement for docker-compose.

Docker CLI の ``compose`` コマンドは、 ``docker-compose`` コマンドとフラグの大部分をサポートします。このコマンドは、いずれ ``docker-comopse`` を置き換えるものとして期待されています。

.. If you see any Compose functionality that is not available in the compose command, create an issue in the Compose GitHub repository, so we can prioritize it.

``compose`` コマンド内で利用できない Compose 機能が見つかれば、 `Compose <https://github.com/docker/compose/issues>`_ GitHub リポジトリに issue を作成してください。そうすると、私たちが優先度付けします。

.. Commands or flags not yet implemented
.. _commands-or-flags-not-yet-implemented:

未実装のコマンドやフラグ
==============================

.. The following commands have not been implemented yet, and may be implemented at a later time. Let us know if these commands are a higher priority for your use cases.

以下のコマンドは未実装ですが、後に実装される可能性があります。みなさんの利用例で、各コマンドの優先度が高ければ、私たちに教えてください。

.. compose build --memory: This option is not yet supported by buildkit. The flag is currently supported, but is hidden to avoid breaking existing Compose usage. It does not have any effect.

``compose build --memory`` ：このオプションは buildkit で未実装です。フラグはサポートしていますが、既存の Compose の使用を中断しないよう、隠されています。何ら影響も与えません。

.. Flags that will not be implemented
.. _Flags that will not be implemented:

実装されないフラグ
==============================

.. The list below includes the flags that we are not planning to support in Compose in the Docker CLI, either because they are already deprecated in docker-compose, or because they are not relevant for Compose in the Docker CLI.

以下のリストに含まれるフラグは、 Docker CLI の Compose 内でサポートする計画がありません。理由は既に ``docker-compose`` で非推奨になっているだけでなく、Docker CLI の Compose には対応する機能が無いからです。

..  compose ps --filter KEY-VALUE Not relevant due to its complicated usage with the service command and also because it is not documented properly in docker-compose.
    compose rm --all Deprecated in docker-compose.
    compose scale Deprecated in docker-compose (use compose up --scale instead)

* ``compose ps --filter KEY-VALUE`` - ``service`` コマンドに相当する機能が無く、かつ、 ``docker-compose`` でも対応するドキュメントが無いため
* ``compose rm --all`` - docker-compose で非推奨
* ``compose scal`` - docker-compose で非推奨（代わりに ``compose up --scale`` を使う）

.. Global flags:
グローバル フラグ：

..  --compatibility has been resignified Docker Compose V2. This now means that in the command running V2 will behave as V1 used to do.
        One difference is in the word separator on container names. V1 used to use _ as separator while V2 uses - to keep the names more hostname friendly. So when using --compatibility Docker Compose should use _ again. Just make sure to stick to one of them otherwise Docker Compose will not be able to recognize the container as an instance of the service.

* ``--compatibility`` は Docker Compose V2 で廃止済み。つまり、 V2 で実行するコマンドの挙動は V1 を使うのと同じ。

  * １つの違いは、コンテナ名の単語をつなぐ文字。 V1 は ``_`` をセパレータとして使ったが、 V2 では ``-`` を使い、ホスト名に近い名前を維持する。つまり ``--compatibility`` Docker Compose は、再び ``_`` を使う。どちらか一方に固定しないと、 Docker Compose はコンテナをサービスの実態として認識できなくなる。

.. Config command
.. _compose-config-command:

``config`` コマンド
====================

.. The config command is intended to show the configuration used by Docker Compose to run the actual project. As we know, at some parts of the Compose file have a short and a long format. For example, the ports entry. In the example below we can see the config command expanding the ports section:

config コマンドが意図するのは、 Docker Compose によって実行している、実際のプロジェクトが使う設定情報の表示です。知っての通り、 Compose ファイルの一部には短い形式と長い形式があります。たとえば、 ``ports`` エントリです。以下の例では、 config コマンドによって ``ports`` セクションが拡張されているのが分かります。


docker-compose.yml:

.. code-block:: yaml

   services:
     web:
       image: nginx
       ports:
         - 80:80

.. With $ docker compose config the output turns into:

これを使い、 ``$ docker compose config`` で帰ってくる結果を見ると、

.. code-block:: yaml

   services:
     web:
       image: nginx
       networks:
         default: null
       ports:
       - mode: ingress
         target: 80
         published: 80
         protocol: tcp
   networks:
     default:
       name: workspace_default

.. The result above is a full size configuration of what will be used by Docker Compose to run the project.

このような結果にあるように、 Docker Compose がプロジェクトを実行するためにつかわれる、全ての設定情報を表示します。

.. New commands introduced in Compose v2
.. _new-commands-introduced-in-compose-v2:

Compose v2 で導入された新しいコマンド
==================================================

.. Copy
.. _compose-v2-copy:

コピー
----------

.. The cp command is intended to copy files or folders between service containers and the local filesystem.
.. This command is a bidirectional command, we can copy from or to the service containers.

``cp`` コマンドはサービス コンテナとローカル ファイルシステム間で、ファイルやフォルダをコピーする目的があります。
このコマンドは双方向のコマンドであり、 **from** か **to** でサービス コンテナから、あるいは、サービス コンテナにコピーできます。

.. Copy a file from a service container to the local filesystem:

サービス コンテナからローカル ファイルシステムにファイルをコピーします：

.. code-block:: bash

   $ docker compose cp my-service:~/path/to/myfile ~/local/path/to/copied/file

.. We can also copy from the local filesystem to all the running containers of a service:

また、ローカル ファイルシステム上から、サービスとして実行中の全コンテナにもコピーできます：

.. code-block:: bash

   $ docker compose cp --all ~/local/path/to/source/file my-service:~/path/to/copied/file

.. List
.. _compose-v2-list:

一覧
----------

.. The ls command is intended to list the Compose projects. By default, the command only lists the running projects, we can use flags to display the stopped projects, to filter by conditions and change the output to json format for example.

``ls`` コマンドは Compose プロジェクトの一覧を表示する目的があります。デフォルトでは、このコマンドは実行中のプロジェクトのみ表示します。フラグを追加すると、停止しているプロジェクトも表示でき、次の例にあるように ``json`` 形式に出力の状態を変えれば、フィルタも可能です。

.. code-block:: bash

   $ docker compose ls --all --format json

.. Use --project-name with Compose commands
.. _use---project-name-with-compose-commands:

Compose コマンドで ``--project-name`` を使う
==================================================

.. With the GA version of Compose, you can run some commands:

Compose の GA（一般提供開始）バージョンは、いずれも同じようにコマンドを実行できます。

..  outside of directory containing the project compose file
    or without specifying the path of the Compose with the --file flag
    or without specifying the project directory with the --project-directory flag

* プロジェクトの compose ファイルを含むディレクトリの外
* あるいは、 ``--file`` フラグで Compose のパスを指定しない場合
* あるいは、 ``--project-directory`` フラグでプロジェクトのディレクトリを指定しない場合

.. When a compose project has been loaded once, we can just use the -p or --project-name to reference it:

Compose プロジェクトを一度読み込めば、 ``-p`` や ``--project-name`` を使ってプロジェクトを参照できます。

.. code-block:: bash

   $ docker compose -p my-loaded-project restart my-service

.. This option works with the start, stop, restart and down commands.

このオプションは ``start`` 、 ``stop`` 、 ``restart`` 、 ``down`` でも機能します。

.. seealso:: 

   Compose command compatibility with docker-compose
      https://docs.docker.com/compose/cli-command-compatibility/

