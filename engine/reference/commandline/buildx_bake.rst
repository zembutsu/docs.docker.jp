.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/buildx_bake/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/buildx_bake.md
.. check date: 2022/02/26
.. -------------------------------------------------------------------

.. build

=======================================
docker buildx bake
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Build from a file

ファイルから構築します。


使い方
==========

.. code-block:: dockerfile

   $ docker buildx bake [オプション] [対象...]

.. Extended description

補足説明
==========

.. Bake is a high-level build command. Each specified target will run in parallel as part of the build.

bake はハイレベルな構築コマンドです。構築時に、それぞれの指定対象を並列実行します。

.. Read High-level build options for introduction.

導入には `High-level build options <https://github.com/docker/buildx#high-level-build-options>`_ をご覧ください。

.. Please note that buildx bake command may receive backwards incompatible features in the future if needed. We are looking for feedback on improving the command and extending the functionality further.

注意点として、今後に必要性があれば、 ``buildx bake`` コマンドに後方互換機能を追加する場合があります。私達は、このコマンドの改善や更なる機能拡張についてのフィードバックをお待ちしています。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <buildx_bake-examples>` をご覧ください。

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--file`` , ``-f``
     - 
     - 構築定義ファイル
   * - ``--load``
     - 
     - ``--set=*.output=type=docker`` の簡易形
   * - ``--metadata-file``
     - 
     - 構築結果のメタデータをファイルに書き込む
   * - ``--no-cache``
     - 
     - イメージ構築時、キャッシュを使用しない
   * - ``--print``
     - 
     - 構築時以外のオプションを表示
   * - ``--progress``
     - ``auto``
     - 進行状況の表示種類を設定（ ``auto`` , ``plain``, ``tty`` ）。plain を使うと、コンテナの出力を表示
   * - ``--pull``
     - 
     - 常にイメージの新しいバージョンの取得を試みる
   * - ``--push``
     - 
     - ``--set=*.output=type=registry`` の簡易形
   * - ``--set``
     - 
     - 対象の値を上書き（例： ``targetpattern.key=value`` ）
   * - ``--builder``
     - 
     - ビルダー・インスタンスの設定を上書き

.. _buildx_bake-examples:

使用例
==========

.. Override the configured builder instance (--builder)

builder 対象の設定を上書き (--builder)
----------------------------------------

.. Same as buildx --builder.

``buildx --builder`` と同じです。

.. Specify a build definition file (-f, --file)

.. _buildx_bake-file

:ruby:`構築定義ファイル <build definition file>` を指定 (-f, --file)
----------------------------------------------------------------------

.. By default, buildx bake looks for build definition files in the current directory, the following are parsed:

デフォルトでは、 ``buildx bake`` は現在のディレクトリで、次のような定義ファイルを探します。

* ``docker-compose.yml``
* ``docker-compose.yaml``
* ``docker-bake.json``
* ``docker-bake.override.json``
* ``docker-bake.hcl``
* ``docker-bake.override.hcl``

.. Use the -f / --file option to specify the build definition file to use. The file can be a Docker Compose, JSON or HCL file. If multiple files are specified they are all read and configurations are combined.

構築定義ファイルとして使うファイルを、 ``-f`` または ``--file`` オプションを使って指定します。ここでのファイルとは、Docker Compose、JSON、HCL ファイルです。複数のファイが指定された場合には、読み込み可能な設定すべてを連結します。

.. The following example uses a Docker Compose file named docker-compose.dev.yaml as build definition file, and builds all targets in the file:

以下の例は、 ``docker-compose.dev.yaml`` という名前の Docker Compose ファイルを構築定義ファイルとして使い、ファイル内の全てのターゲットを構築します。

.. code-block:: dockerfile

   $  docker buildx bake -f docker-compose.dev.yaml
   
   [+] Building 66.3s (30/30) FINISHED
     =>  [frontend internal] load build definition from Dockerfile  0.1s
     => => transferring dockerfile: 36B                            0.0s
     => [backend internal] load build definition from Dockerfile   0.2s
     => => transferring dockerfile: 3.73kB                         0.0s
     => [database internal] load build definition from Dockerfile  0.1s
     => => transferring dockerfile: 5.77kB                         0.0s
     ...

.. Pass the names of the targets to build, to build only specific target(s). The following example builds the backend and database targets that are defined in the docker-compose.dev.yaml file, skipping the build for the frontend target:

構築対象の名前を指定すると、指定したターゲット（対象）のみ構築します。以下の例は、 ``docker-compose.dev.yaml`` ファイル内で定義された、 ``backend`` と ``database`` ターゲットを構築します。 ``frontend`` ターゲットは構築をスキップします。

.. code-block:: bash

   $ docker buildx bake -f docker-compose.dev.yaml backend database
   
   [+] Building 2.4s (13/13) FINISHED
     =>  [backend internal] load build definition from Dockerfile  0.1s
     =>  => transferring dockerfile: 81B                           0.0s
     =>  [database internal] load build definition from Dockerfile 0.2s
     =>  => transferring dockerfile: 36B                           0.0s
     =>  [backend internal] load .dockerignore                     0.3s
     ...

.. You can also use a remote git bake definition:

また、リモート ``bake`` 定義も使えます。

.. code-block:: bash

   $ docker buildx bake "git://github.com/docker/cli#v20.10.11" --print
   1 [internal] load git source git://github.com/docker/cli#v20.10.11
   1 0.745 e8f1871b077b64bcb4a13334b7146492773769f7       refs/tags/v20.10.11
   1 2.022 From git://github.com/docker/cli
   1 2.022  * [new tag]         v20.10.11  -> v20.10.11
   1 DONE 2.9s
   {
     "group": {
       "default": {
         "targets": [
           "binary"
         ]
       }
     },
     "target": {
       "binary": {
         "context": "git://github.com/docker/cli#v20.10.11
         "dockerfile": "Dockerfile",
         "args": {
           "BASE_VARIANT": "alpine",
           "GO_STRIP": "",
           "VERSION": ""
         },
         "target": "binary",
         "platforms": [
           "local"
         ],
         "output": [
           "build"
         ]
       }
     }
   }

.. As you can see the context is fixed to git://github.com/docker/cli even if no context is actually defined in the definition.

見ての通り、定義において `コンテクストが存在していない <https://github.com/docker/cli/blob/2776a6d694f988c0c1df61cad4bfac0f54e481c8/docker-bake.hcl#L17-L26>`_ 場合でも、 ``git://github.com/docker/cli`` をコンテクストとします。

.. If you want to access the main context for bake command from a bake file that has been imported remotely, you can use the BAKE_CMD_CONTEXT builtin var:

bake コマンドを使い、リモートから読み込む bake ファイルが 主となるコンテクストを使いたい場合には、内蔵されている変数 ``BAKE_CMD_CONTEXT`` が利用できます。

.. code-block:: bash

   $ cat https://raw.githubusercontent.com/tonistiigi/buildx/remote-test/docker-bake.hcl
   target "default" {
     context = BAKE_CMD_CONTEXT
     dockerfile-inline = &lt;&lt;EOT
   FROM alpine
   WORKDIR /src
   COPY . .
   RUN ls -l &amp;&amp; stop
   EOT
   }

.. code-block:: bash

   $ docker buildx bake "git://github.com/tonistiigi/buildx#remote-test" --print
   {
     "target": {
       "default": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "dockerfile-inline": "FROM alpine\nWORKDIR /src\nCOPY . .\nRUN ls -l \u0026\u0026 stop\n"
       }
     }
   }

.. code-block:: bash

   $ touch foo bar
   $ docker buildx bake "git://github.com/tonistiigi/buildx#remote-test"
   ...
     > [4/4] RUN ls -l && stop:
   #8 0.101 total 0
   #8 0.102 -rw-r--r--    1 root     root             0 Jul 27 18:47 bar
   #8 0.102 -rw-r--r--    1 root     root             0 Jul 27 18:47 foo
   #8 0.102 /bin/sh: stop: not found

.. code-block:: bash

   $ docker buildx bake "git://github.com/tonistiigi/buildx#remote-test" "git://github.com/docker/cli#v20.10.11" --print
   #1 [internal] load git source git://github.com/tonistiigi/buildx#remote-test
   #1 0.429 577303add004dd7efeb13434d69ea030d35f7888       refs/heads/remote-test
   #1 CACHED
   {
     "target": {
       "default": {
         "context": "git://github.com/docker/cli#v20.10.11
         "dockerfile": "Dockerfile",
         "dockerfile-inline": "FROM alpine\nWORKDIR /src\nCOPY . .\nRUN ls -l \u0026\u0026 stop\n"
       }
     }
   }

.. code-block:: bash

   $ docker buildx bake "git://github.com/tonistiigi/buildx#remote-test" "git://github.com/docker/cli#v20.10.11"
   ...
    >  [4/4] RUN ls -l && stop:
   #8 0.136 drwxrwxrwx    5 root     root          4096 Jul 27 18:31 kubernetes
   #8 0.136 drwxrwxrwx    3 root     root          4096 Jul 27 18:31 man
   #8 0.136 drwxrwxrwx    2 root     root          4096 Jul 27 18:31 opts
   #8 0.136 -rw-rw-rw-    1 root     root          1893 Jul 27 18:31 poule.yml
   #8 0.136 drwxrwxrwx    7 root     root          4096 Jul 27 18:31 scripts
   #8 0.136 drwxrwxrwx    3 root     root          4096 Jul 27 18:31 service
   #8 0.136 drwxrwxrwx    2 root     root          4096 Jul 27 18:31 templates
   #8 0.136 drwxrwxrwx   10 root     root          4096 Jul 27 18:31 vendor
   #8 0.136 -rwxrwxrwx    1 root     root          9620 Jul 27 18:31 vendor.conf
   #8 0.136 /bin/sh: stop: not found

.. Do not use cache when building the image (--no-cache)

イメージ構築時にキャッシュを使わない(--no-cache)
--------------------------------------------------

.. Same as build --no-cache. Do not use cache when building the image.

``build --no-cahe`` と同じです。イメージの構築中にキャッシュを使いません。

.. Print the options without building (--print)

構築時のオプションを表示 (--print)
--------------------------------------------------

.. Prints the resulting options of the targets desired to be built, in a JSON format, without starting a build.

任意のターゲットを構築するにあたり、構築せずに結果を JSON 形式で表示します。

.. code-block:: bash

   $  docker buildx bake -f docker-bake.hcl --print db
   {
     "group": {
       "default": {
         "targets": [
           "db"
         ]
       }
     },
     "target": {
       "db": {
         "context": "./",
         "dockerfile": "Dockerfile",
         "tags": [
           "docker.io/tiborvass/db"
         ]
       }
     }
   }

.. Set type of progress output (--progress)

進捗出力の形式を設定 (--progress)
----------------------------------------

.. Same as build --progress. Set type of progress output (auto, plain, tty). Use plain to show container output (default “auto”).

``build --progress`` と同じです。進捗の出力形式（auto, plain, tty）を指定します。plain を使うとコンテナの出力を表示します（デフォルトは ``auto`` ）。

..    You can also use the BUILDKIT_PROGRESS environment variable to set its value.

.. note::

   ``BUILDKIT_PROGRESS` 環境変数を使っても値が指定できます。

.. The following example uses plain output during the build:

以下は構築中の出力に ``plain`` を使う例です。

.. code-block:: bash

   $ docker buildx bake --progress=plain
   
   #2 [backend internal] load build definition from Dockerfile.test
   #2 sha256:de70cb0bb6ed8044f7b9b1b53b67f624e2ccfb93d96bb48b70c1fba562489618
   #2 ...
   
   #1 [database internal] load build definition from Dockerfile.test
   #1 sha256:453cb50abd941762900a1212657a35fc4aad107f5d180b0ee9d93d6b74481bce
   #1 transferring dockerfile: 36B done
   #1 DONE 0.1s
   ...

.. Always attempt to pull a newer version of the image (--pull)

常にイメージの新しいバージョンの取得を試みる (--pull)
------------------------------------------------------------

.. Same as build --pull.

``build --pull`` と同じです。

.. Override target configurations from command line (--set)

コマンドラインからターゲットの設定を上書き (--set)
------------------------------------------------------------

.. code-block:: bash

   --set targetpattern.key[.subkey]=value

.. Override target configurations from command line. The pattern matching syntax is defined in https://golang.org/pkg/path/#Match.

コマンドラインからターゲットの設定を上書きします。パターンマッチ構文は  https://golang.org/pkg/path/#Match で定義されています。

.. Examples

例
^^^^^^^^^^

.. code-block:: bash

   $ docker buildx bake --set target.args.mybuildarg=value
   $ docker buildx bake --set target.platform=linux/arm64
   $ docker buildx bake --set foo*.args.mybuildarg=value # 「foo」で始まる全てのターゲットに対し、構築の引数を上書き
   $ docker buildx bake --set *.platform=linux/arm64     # 全てのターゲットに対するプラットフォームを上書き
   $ docker buildx bake --set foo*.no-cache              #「with」で始まるターゲットのみ、キャッシュをしない（回避）

.. Complete list of overridable fields: args, cache-from, cache-to, context, dockerfile, labels, no-cache, output, platform, pull, secrets, ssh, tags, target

上書きできるフィールドの一覧はこちらです： ``args`` , `` cache-from`` , `` cache-to`` , `` context`` , `` dockerfile`` , `` labels`` , `` no-cache`` , `` output`` , `` platform`` , `` pull`` , `` secrets`` , `` ssh`` , `` tags`` , `` target``

.. File definition

.. _buildx_bake_file-definition:

ファイル定義
--------------------

.. In addition to compose files, bake supports a JSON and an equivalent HCL file format for defining build groups and targets.

構築グループとターゲットを定義するため bake がサポートしているのは、 compose ファイルに加え、JSON 形式と HCL ファイル互換形式です。

.. A target reflects a single docker build invocation with the same options that you would specify for docker build. A group is a grouping of targets.

ターゲットに対しては、単一の docker build として、 ``docker build .`` を指定した時と同じオプションで実行した結果が反映されます。グループはターゲットをグループにしたものです。

.. Multiple files can include the same target and final build options will be determined by merging them together.

複数のファイルに、同じターゲットと最終構築オプションを記載できます。これらは最終的に1つにまとめられます。

.. In the case of compose files, each service corresponds to a target.

compose ファイルの各サービスは、ターゲットに相当します。

.. A group can specify its list of targets with the targets option. A target can inherit build options by setting the inherits option to the list of targets or groups to inherit from.

グループは ``targets`` オプションでターゲット一覧を指定できます。ターゲットでは構築オプションに ``inherits`` （継承）オプションの設定を使えば、ターゲットやグループに対してそれぞれ継承できます。

.. Note: Design of bake command is work in progress, the user experience may change based on feedback.

メモ：bake コマンドの設計は作業を行っている途中のため、フィードバックを元に挙動が変わる場合があります。

HCL 定義例
^^^^^^^^^^

.. code-block:: hcl

   group "default" {
       targets = ["db", "webapp-dev"]
   }
   
   target "webapp-dev" {
       dockerfile = "Dockerfile.webapp"
       tags = ["docker.io/username/webapp"]
   }
   
   target "webapp-release" {
       inherits = ["webapp-dev"]
       platforms = ["linux/amd64", "linux/arm64"]
   }
   
   target "db" {
       dockerfile = "Dockerfile.db"
       tags = ["docker.io/username/db"]
   }

.. Complete list of valid target fields:

有効なターゲット・フィールドの一覧はこちらです。

``args`` , ``cache-from`` , ``cache-to`` , ``context`` , ``dockerfile`` , ``inherits`` , ``labels`` , ``no-cache`` , ``output`` , ``platform`` , ``pull`` , ``secrets`` , ``ssh`` , ``tags`` , ``target``

.. Global scope attributes

:ruby:`グローバル範囲 <global scope>` の属性
--------------------------------------------------

.. You can define global scope attributes in HCL/JSON and use them for code reuse and setting values for variables. This means you can do a “data-only” HCL file with the values you want to set/override and use it in the list of regular output files.

HCL や JSON でグローバル範囲の属性（attribute）を定義し、それらをコードでの再利用や、変数の値の設定で利用できます。これが意味するのは、指定するか上書きしたい値が入った「データだけを持つ」HCL ファイルを利用し、それを通常のファイル出力に使えます。

.. code-block:: hcl

   # docker-bake.hcl
   variable "FOO" {
       default = "abc"
   }
   
   target "app" {
       args = {
           v1 = "pre-${FOO}"
       }
   }

.. You can use this file directly:

このファイルは直接使えます。

.. code-block:: bash

   $ docker buildx bake --print app
   {
     "group": {
       "default": {
         "targets": [
           "app"
         ]
       }
     },
     "target": {
       "app": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "args": {
           "v1": "pre-abc"
         }
       }
     }
   }

.. Or create an override configuration file:

あるいは、上書き用の設定ファイルを作成します。

.. code-block:: hcl

   # env.hcl
   WHOAMI="myuser"
   FOO="def-${WHOAMI}"

.. And invoke bake together with both of the files:

それから、両方のファイルを使って bake を実行します。

.. code-block:: bash

   $ docker buildx bake -f docker-bake.hcl -f env.hcl --print app
   {
     "group": {
       "default": {
         "targets": [
           "app"
         ]
       }
     },
     "target": {
       "app": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "args": {
           "v1": "pre-def-myuser"
         }
       }
     }
   }

.. HCL variables and functions

HCL 変数とファンクション
------------------------------

.. Similar to how Terraform provides a way to define variables, the HCL file format also supports variable block definitions. These can be used to define variables with values provided by the current environment, or a default value when unset.

Terraform プロバイダで `変数を定義 <https://www.terraform.io/docs/configuration/variables.html#declaring-an-input-variable>`_ するのと同じような方法で、HCL フェア形式も :ruby:`変数ブロック定義 <variable block definition>` をサポートしています。これにより、現在の環境上で提供されている値を元に変数を定義したり、変数の定義がなければデフォルト値を指定できます。

.. A set of generally useful functions provided by go-cty are available for use in HCL files. In addition, user defined functions are also supported.

HCL ファイルでは `go-cty <https://github.com/zclconf/go-cty/tree/main/cty/function/stdlib>`_ によって提供されている `広く役立つ機能群 <https://github.com/docker/buildx/blob/master/bake/hclparser/stdlib.go>`_ が使えます。さらに、 `ユーザ定義ファンクション <https://github.com/hashicorp/hcl/tree/main/ext/userfunc>`_ もサポートされています。

.. Using interpolation to tag an image with the git sha

イメージのタグに git sha を書き込むには
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Bake supports variable blocks which are assigned to matching environment variables or default values.

bake はマッチした環境変数やデフォルト値を割り当てる、変数ブロックをサポートしています。

.. code-block:: hcl

   # docker-bake.hcl
   variable "TAG" {
       default = "latest"
   }
   
   group "default" {
       targets = ["webapp"]
   }
   
   target "webapp" {
       tags = ["docker.io/username/webapp:${TAG}"]
   }

.. code-block:: bash

   $ docker buildx bake --print webapp
   {
     "group": {
       "default": {
         "targets": [
           "webapp"
         ]
       }
     },
     "target": {
       "webapp": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "tags": [
           "docker.io/username/webapp:latest"
         ]
       }
     }
   }

.. code-block:: bash

   $ TAG=$(git rev-parse --short HEAD) docker buildx bake --print webapp
   {
     "group": {
       "default": {
         "targets": [
           "webapp"
         ]
       }
     },
     "target": {
       "webapp": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "tags": [
           "docker.io/username/webapp:985e9e9"
         ]
       }
     }
   }


.. Using the add function

``add`` ファンクションを使う
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You can use go-cty stdlib functions. Here we are using the add function.

``go-cty``  `stdlib ファンクション <https://github.com/zclconf/go-cty/tree/main/cty/function/stdlib>`_ を使えます。以下は ``add`` ファンクションを使っています。

.. code-block:: hcl

   # docker-bake.hcl
   variable "TAG" {
       default = "latest"
   }
   
   group "default" {
       targets = ["webapp"]
   }
   
   target "webapp" {
       args = {
           buildno = "${add(123, 1)}"
       }
   }

.. code-block:: bash

   $ docker buildx bake --print webapp
   {
     "group": {
       "default": {
         "targets": [
           "webapp"
         ]
       }
     },
     "target": {
       "webapp": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "args": {
           "buildno": "124"
         }
       }
     }
   }

.. Defining an increment function

``increment`` ファンクションの定義
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. It also supports user defined functions. The following example defines a simple an increment function.

`ユーザ定義ファンクション <https://github.com/hashicorp/hcl/tree/main/ext/userfunc>`_ もサポートしています。以下の例はシンプルな ``increment`` ファンクションを定義する例です。

.. code-block:: hcl

   # docker-bake.hcl
   function "increment" {
       params = [number]
       result = number + 1
   }
   
   group "default" {
       targets = ["webapp"]
   }
   
   target "webapp" {
       args = {
           buildno = "${increment(123)}"
       }
   }

.. code-block:: bash

   $ docker buildx bake --print webapp
   {
     "group": {
       "default": {
         "targets": [
           "webapp"
         ]
       }
     },
     "target": {
       "webapp": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "args": {
           "buildno": "124"
         }
       }
     }
   }

.. Only adding tags if a variable is not empty using an notequal

変数が空でない場合のみ ``notequal`` を使ってタグを追加
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

以下は条件付きの ``notequal`` ファンクションを使い、 ``equal`` と同等の働きをします。

.. code-block:: hcl

   # docker-bake.hcl
   variable "TAG" {default="" }
   
   group "default" {
       targets = [
           "webapp",
       ]
   }
   
   target "webapp" {
       context="."
       dockerfile="Dockerfile"
       tags = [
           "my-image:latest",
           notequal("",TAG) ? "my-image:${TAG}": "",
       ]
   }

.. code-block:: bash

   $ docker buildx bake --print webapp
   {
     "group": {
       "default": {
         "targets": [
           "webapp"
         ]
       }
     },
     "target": {
       "webapp": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "tags": [
           "my-image:latest"
         ]
       }
     }
   }

.. Using variables in functions

ファンクションで変数を使う
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You can refer variables to other variables like the target blocks can. Stdlib functions can also be called but user functions can’t at the moment.

他の変数をターゲット・ブロックにように扱い、変数を参照できます。stdlib ファンクションも呼び出せますが、その場合にユーザ・ファンクションは使えません。

.. code-block:: hcl

   # docker-bake.hcl
   variable "REPO" {
       default = "user/repo"
   }
   
   function "tag" {
       params = [tag]
       result = ["${REPO}:${tag}"]
   }
   
   target "webapp" {
       tags = tag("v1")
   }

.. code-block:: bash

   {
     "group": {
       "default": {
         "targets": [
           "webapp"
         ]
       }
     },
     "target": {
       "webapp": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "tags": [
           "user/repo:v1"
         ]
       }
     }
   }

.. Using variables in variables across files

ファイルを横断して変数を使う
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. When multiple files are specified, one file can use variables defined in another file.

複数のファイルを指定する場合は、あるファイル定義した変数が、別のファイルでも使えます。

.. code-block:: hcl

   # docker-bake1.hcl
   variable "FOO" {
       default = upper("${BASE}def")
   }
   
   variable "BAR" {
       default = "-${FOO}-"
   }
   
   target "app" {
       args = {
           v1 = "pre-${BAR}"
       }
   }

.. code-block:: hcl

   # docker-bake2.hcl
   variable "BASE" {
       default = "abc"
   }
   
   target "app" {
       args = {
           v2 = "${FOO}-post"
       }
   }

.. code-block:: bash

   $ docker buildx bake -f docker-bake1.hcl -f docker-bake2.hcl --print app
   {
     "group": {
       "default": {
         "targets": [
           "app"
         ]
       }
     },
     "target": {
       "app": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "args": {
           "v1": "pre--ABCDEF-",
           "v2": "ABCDEF-post"
         }
       }
     }
   }

.. Using typed variables

typed 変数を使う
^^^^^^^^^^^^^^^^^^^^

.. Non-string variables are also accepted. The value passed with env is parsed into suitable type first.

文字列以外の変数も利用できます。この値は適切なタイプの env （環境変数）に渡されます。

.. code-block:: hcl

   # docker-bake.hcl
   variable "FOO" {
       default = 3
   }
   
   variable "IS_FOO" {
       default = true
   }
   
   target "app" {
       args = {
           v1 = FOO > 5 ? "higher" : "lower"
           v2 = IS_FOO ? "yes" : "no"
       }
   }

.. code-block:: bash

   $ docker buildx bake --print app
   {
     "group": {
       "default": {
         "targets": [
           "app"
         ]
       }
     },
     "target": {
       "app": {
         "context": ".",
         "dockerfile": "Dockerfile",
         "args": {
           "v1": "lower",
           "v2": "yes"
         }
       }
     }
   }

.. Extension field with Compose🔗

Compose での拡張フィールド
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Special extension field x-bake can be used in your compose file to evaluate fields that are not (yet) available in the build definition.

`special extention <https://github.com/compose-spec/compose-spec/blob/master/spec.md#extension>`_ フィールド ``x-bake`` は compose ファイルでフィールドとして使えますが、（まだ今は） `build 定義 <https://github.com/compose-spec/compose-spec/blob/master/build.md#build-definition>`_ では使えません。

.. code-block:: yaml

   # docker-compose.yml
   services:
     addon:
       image: ct-addon:bar
       build:
         context: .
         dockerfile: ./Dockerfile
         args:
           CT_ECR: foo
           CT_TAG: bar
         x-bake:
           tags:
             - ct-addon:foo
             - ct-addon:alp
           platforms:
             - linux/amd64
             - linux/arm64
           cache-from:
             - user/app:cache
             - type=local,src=path/to/cache
           cache-to: type=local,dest=path/to/cache
           pull: true
   
     aws:
       image: ct-fake-aws:bar
       build:
         dockerfile: ./aws.Dockerfile
         args:
           CT_ECR: foo
           CT_TAG: bar
         x-bake:
           secret:
             - id=mysecret,src=./secret
             - id=mysecret2,src=./secret2
           platforms: linux/arm64
           output: type=docker
           no-cache: true

.. code-block:: bash

   $ docker buildx bake --print
   {
     "group": {
       "default": {
         "targets": [
           "aws",
           "addon"
         ]
       }
     },
     "target": {
       "addon": {
         "context": ".",
         "dockerfile": "./Dockerfile",
         "args": {
           "CT_ECR": "foo",
           "CT_TAG": "bar"
         },
         "tags": [
           "ct-addon:foo",
           "ct-addon:alp"
         ],
         "cache-from": [
           "user/app:cache",
           "type=local,src=path/to/cache"
         ],
         "cache-to": [
           "type=local,dest=path/to/cache"
         ],
         "platforms": [
           "linux/amd64",
           "linux/arm64"
         ],
         "pull": true
       },
       "aws": {
         "context": ".",
         "dockerfile": "./aws.Dockerfile",
         "args": {
           "CT_ECR": "foo",
           "CT_TAG": "bar"
         },
         "tags": [
           "ct-fake-aws:bar"
         ],
         "secret": [
           "id=mysecret,src=./secret",
           "id=mysecret2,src=./secret2"
         ],
         "platforms": [
           "linux/arm64"
         ],
         "output": [
           "type=docker"
         ],
         "no-cache": true
       }
     }
   }

.. Complete list of valid fields for x-bake:

``x-bake`` で有効なフィールドの全一覧：

.. tags, cache-from, cache-to, secret, ssh, platforms, output, pull, no-cache

``tags`` , ``cache-from`` , ``cache-to`` , ``secret`` , ``ssh`` , ``platforms`` , ``output`` , ``pull`` , ``no-cache``

.. Built-in variables

内蔵している変数
^^^^^^^^^^^^^^^^^^^^

..    BAKE_CMD_CONTEXT can be used to access the main context for bake command from a bake file that has been imported remotely.
    BAKE_LOCAL_PLATFORM returns the current platform’s default platform specification (e.g. linux/amd64).

- ``BAKE_CMD_CONTEXT`` は :ref:`リモートから読み込んだ <buildx_bake-file>` bake ファイルから、メインの ``context`` （コンテクスト）に bake コマンドでアクセスできるようにします。
- ``BAKE_LOCAL_PLATFORM`` は現在のプラットフォームとして指定されているデフォルトのプラットフォームを返します（例： ``linux/amd64`` ）。


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`buildx`
     - Docker Buildx


.. Related commands

関連コマンド
====================

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker buildx bake<buildx_bake>`
     - ファイルから構築
   * - :doc:`docker buildx build<buildx_build>`
     - 構築開始
   * - :doc:`docker buildx create<buildx_create>`
     - 新しいビルダー・インスタンスを作成
   * - :doc:`docker buildx du<buildx_du>`
     - ディスク使用量
   * - :doc:`docker buildx imagetools<buildx_imagetools>`
     - レジストリにあるイメージを操作するコマンド
   * - :doc:`docker buildx inspect<buildx_inspect>`
     - 現在のビルダー・インスタンスを調査
   * - :doc:`docker buildx ls<buildx_ls>`
     - ビルダー・インスタンス一覧
   * - :doc:`docker buildx prune<buildx_prune>`
     - 構築キャッシュの削除
   * - :doc:`docker buildx rm<buildx_rm>`
     - ビルダー・インスタンスの削除
   * - :doc:`docker buildx stop<buildx_stop>`
     - ビルダー・インスタンスの停止
   * - :doc:`docker buildx use<buildx_use>`
     - 現在のビルダー・インスタンスを設定
   * - :doc:`docker buildx version<buildx_version>`
     - buildx バージョン情報を表示



.. seealso:: 

   docker buildx bake
      https://docs.docker.com/engine/reference/commandline/buildx_bake/
