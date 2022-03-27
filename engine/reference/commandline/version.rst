.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/version/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/version.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_version.yaml
.. check date: 2022/03/27
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker version

=======================================
docker version
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_version-description:

説明
==========

.. Show the Docker version information

Docker バージョン情報を表示します。

.. _docker_version -usage:

使い方
==========

.. code-block:: bash

   $ docker version [OPTIONS]

.. Extended description
.. _docker_version-extended-description:

補足説明
==========

.. By default, this will render all version information in an easy to read layout. If a format is specified, the given template will be executed instead.

デフォルトでは、全てのバージョン情報を読みやすい形式で表示します。フォーマットを指定したら、特定のテンプレートで処理します。

.. Go’s text/template package describes all the details of the format.

Go 言語の `text/template <http://golang.org/pkg/text/template/>`_ パッケージにフォーマットの全ての詳細が記載されています。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_version-examples>` をご覧ください。

.. _docker_version-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format`` , ``-f``
     - 
     - 指定した Go テンプレート使って出力を整形
   * - ``--kubeconfig``
     - 
     - 【非推奨】【Kubernetes】Kubernetes config ファイル

.. Examples
.. _docker_version-examples:

使用例
==========

.. Default output:
.. _docker_version-default-output:

デフォルトの出力
------------------------------

.. code-block:: bash

   $ docker version
   Client:
    Version:           19.03.8
    API version:       1.40
    Go version:        go1.12.17
    Git commit:        afacb8b
    Built:             Wed Mar 11 01:21:11 2020
    OS/Arch:           darwin/amd64
    Context:           default
    Experimental:      true
    
   Server:
    Engine:
     Version:          19.03.8
     API version:      1.40 (minimum version 1.12)
     Go version:       go1.12.17
     Git commit:       afacb8b
     Built:            Wed Mar 11 01:29:16 2020
     OS/Arch:          linux/amd64
     Experimental:     true
    containerd:
     Version:          v1.2.13
     GitCommit:        7ad184331fa3e55e52b890ea95e65ba581ae3429
    runc:
     Version:          1.0.0-rc10
     GitCommit:        dc9208a3303feef5b3839f4323d9beb36df0a9dd
    docker-init:
     Version:          0.18.0
     GitCommit:        fec3683

.. Get server version
.. _docker_version-get-server-version:
サーバのバージョンを取得
------------------------------

.. code-block:: bash

   $ docker version --format '{{.Server.Version}}'
   19.03.8

.. Dump raw JSON data
.. _docker_version-dump-raw-json-data:
raw JSON データのダンプ
------------------------------

.. code-block:: bash

   $ docker version --format '{{json .}}'
   
    {"Client":{"Platform":{"Name":"Docker Engine - Community"},"Version":"19.03.8","ApiVersion":"1.40","DefaultAPIVersion":"1.40","GitCommit":"afacb8b","GoVersion":"go1.12.17","Os":"darwin","Arch":"amd64","BuildTime":"Wed Mar 11 01:21:11 2020","Experimental":true},"Server":{"Platform":{"Name":"Docker Engine - Community"},"Components":[{"Name":"Engine","Version":"19.03.8","Details":{"ApiVersion":"1.40","Arch":"amd64","BuildTime":"Wed Mar 11 01:29:16 2020","Experimental":"true","GitCommit":"afacb8b","GoVersion":"go1.12.17","KernelVersion":"4.19.76-linuxkit","MinAPIVersion":"1.12","Os":"linux"}},{"Name":"containerd","Version":"v1.2.13","Details":{"GitCommit":"7ad184331fa3e55e52b890ea95e65ba581ae3429"}},{"Name":"runc","Version":"1.0.0-rc10","Details":{"GitCommit":"dc9208a3303feef5b3839f4323d9beb36df0a9dd"}},{"Name":"docker-init","Version":"0.18.0","Details":{"GitCommit":"fec3683"}}],"Version":"19.03.8","ApiVersion":"1.40","MinAPIVersion":"1.12","GitCommit":"afacb8b","GoVersion":"go1.12.17","Os":"linux","Arch":"amd64","KernelVersion":"4.19.76-linuxkit","Experimental":true,"BuildTime":"2020-03-11T01:29:16.000000000+00:00"}}

.. Print the current context
.. _dokcer_version-print-the-current-context:

現在の context を表示
------------------------------

.. The following example prints the currently used docker context:

以下の例は、現在使っている ``docker context`` を表示します。

   $ docker version --format='{{.Client.Context}}'
   default

.. As an example, this output can be used to dynamically change your shell prompt to indicate your active context. The example below illustrates how this output could be used when using Bash as your shell.

例では、シェルプロンプト上で動的に変わるアクティブな context を表示できます。以下の例が示すのは、シェルとして Bash を使う場合に、どのように表示するかです。

.. Declare a function to obtain the current context in your ~/.bashrc, and set this command as your PROMPT_COMMAND

``~/.bashrc`` で現在の context を取得する関数を宣言し、このコマンドを ``PROMPT_COMMAND`` として指定します。

.. code-block:: bash

   function docker_context_prompt() {
           PS1="context: $(docker version --format='{{.Client.Context}}')> "
   }
   PROMPT_COMMAND=docker_context_prompt

.. After reloading the ~/.bashrc, the prompt now shows the currently selected docker context:

``~/.bashrc`` の再読み込み後、現在選択している ``docker context`` をプロンプトで表示します。

.. code-block:: bash

   $ source ~/.bashrc
   context: default> docker context create --docker host=unix:///var/run/docker.sock my-context
   my-context
   Successfully created context "my-context"
   context: default> docker context use my-context
   my-context
   Current context is now "my-context"
   context: my-context> docker context use default
   default
   Current context is now "default"
   context: default>

.. Refer to the docker context section in the command line reference for more information about docker context.

``docker context`` に関する詳しい情報は、コマンドライン・リファレンスの :doc:`docker context セクション <context>` を参照ください。


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker version
      https://docs.docker.com/engine/reference/commandline/version/
