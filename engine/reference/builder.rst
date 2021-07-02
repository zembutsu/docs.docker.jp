.. -*- coding: utf-8 -*-:
.. URL: https://docs.docker.com/engine/reference/builder/
.. SOURCE: https://github.com/docker/cli/blob/master/docs/reference/builder.md
   doc version: 20.10
.. check date: 2021/07/02
.. Commits on May 5, 2021 782192a6e50bacd73dcd2e9f9128f1708435b555
.. -------------------------------------------------------------------

.. Dockerfile reference

=======================================
Dockerfile リファレンス
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker can build images automatically by reading the instructions from a Dockerfile. A Dockerfile is a text document that contains all the commands a user could call on the command line to assemble an image. Using docker build users can create an automated build that executes several command-line instructions in succession.

Docker は ``Dockerfile`` から命令を読み込み、自動的にイメージをビルドできます。 ``Dockerfile`` はテキストファイルであり、イメージを作り上げるために実行するコマンドライン命令を、すべてこのファイルに含められます。 ``docker build`` を実行すると、順次コマンドライン命令を自動化した処理を行い、ビルド結果となるイメージが得られます。

.. This page describes the commands you can use in a Dockerfile. When you are done reading this page, refer to the Dockerfile Best Practices for a tip-oriented guide.

このページでは、 ``Dockerfile`` で利用可能なコマンドを説明します。このページを読み終えたら、 ``Dockerfile`` の :doc:`ベストプラクティス </develop/develop-images/dockerfile_best-practices/>` を開き、理解を重視するガイドをご覧ください。

.. ## Usage

使用法
==========

.. The docker build command builds an image from a Dockerfile and a context. The build’s context is the set of files at a specified location PATH or URL. The PATH is a directory on your local filesystem. The URL is a Git repository location.

:doc:`docker build </engine/reference/commandline/build>` コマンドは、 ``Dockerfile`` と :ruby:`コンテキスト <context>` からイメージを :ruby:`構築 <build>` （ビルド）します。構築におけるコンテキストとは、指定された ``PATH`` （場所）または ``URL`` にあるファイル一式です。 ``PATH`` はローカル・ファイルシステム上のディレクトリです。 ``URL`` は Git リポジトリの場所です。

.. The build context is processed recursively. So, a PATH includes any subdirectories and the URL includes the repository and its submodules. This example shows a build command that uses the current directory (.) as build context:

:ruby:`構築コンテキスト <build context>` は再帰的に処理されます。つまり、 ``PATH`` にはすべてのサブディレクトリが含まれ、 ``URL`` にはリポジトリとサブモジュールが含まれます。以下の例における構築コマンドは、現在のディレクトリ（ ``.`` ）を構築コンテキストとして使用します。

.. code-block:: bash

   $ docker build .
   
   Sending build context to Docker daemon  6.51 MB
   ...

.. The build is run by the Docker daemon, not by the CLI. The first thing a build process does is send the entire context (recursively) to the daemon. In most cases, it’s best to start with an empty directory as context and keep your Dockerfile in that directory. Add only the files needed for building the Dockerfile.

構築は Docker デーモンが実行するものであり、 CLI によるものではありません。構築処理でまず行われるのは、コンテキスト全体を（再帰的に）デーモンに送信します。たいていの場合、コンテキストとして空のディレクトリを用意し、そこに Dockerfile を置くのがベストです。そのディレクトリへは、Dockerfile の構築に必要なファイルのみ追加します。

..     Warning
    Do not use your root directory, /, as the PATH for your build context, as it causes the build to transfer the entire contents of your hard drive to the Docker daemon.

.. warning::

   ルート・ディレクトリ ``/`` を構築コンテキストの ``PATH`` として指定しないでください。構築時、ハードディスクの内容すべてを Docker デーモンに転送してしまうからです。

.. To use a file in the build context, the Dockerfile refers to the file specified in an instruction, for example, a COPY instruction. To increase the build’s performance, exclude files and directories by adding a .dockerignore file to the context directory. For information about how to create a .dockerignore file see the documentation on this page.

構築コンテキスト内にあるファイルを使う場合、 ``COPY`` 命令など、 ``Dockerfile`` の命令で指定されたファイルを参照します。構築時の処理性能を上げるには、コンテキスト・ディレクトリに ``.dockerignore`` ファイルを追加し、不要なファイルやディレクトリを除外します。 ``.dockerignore`` ファイルを作成する詳細は、このページ内の :ref:`ドキュメント <dockerignore-file>` を参照ください。

.. Traditionally, the Dockerfile is called Dockerfile and located in the root of the context. You use the -f flag with docker build to point to a Dockerfile anywhere in your file system

もともと、 ``Dockerfile``  は ``Dockerfile`` と呼ばれ、コンテキストのルート（対象ディレクトリのトップ）に置かれました。 ``docker build`` で ``-f`` フラグを使えば、Dockerfile がファイルシステム上のどこにあっても指定できます。

.. code-block:: bash

   $ docker build -f /path/to/a/Dockerfile .

.. You can specify a repository and tag at which to save the new image if the build succeeds:

構築の成功時、新しいイメージを保存する :ruby:`リポジトリ <repository>` と :ruby:`タグ <tag>` を指定できます。


.. code-block:: bash

   $ docker build -t shykes/myapp .

.. To tag the image into multiple repositories after the build, add multiple -t parameters when you run the build command:

構築後、複数のリポジトリに対してイメージをタグ付けするには、 ``biuld`` コマンドの実行時、複数の ``-t`` パラメータを追加します。

.. code-block:: bash

   docker build -t shykes/myapp:1.0.2 -t shykes/myapp:latest .

.. Before the Docker daemon runs the instructions in the Dockerfile, it performs a preliminary validation of the Dockerfile and returns an error if the syntax is incorrect:

Docker デーモンは ``Dockerfile`` 内に書かれた命令を実行する前に、事前に ``Dockerfile`` を検証し、構文が間違っている場合はエラーを返します。

.. code-block:: bash

   $ docker build -t test/myapp .
   
   [+] Building 0.3s (2/2) FINISHED
    => [internal] load build definition from Dockerfile                       0.1s
    => => transferring dockerfile: 60B                                        0.0s
    => [internal] load .dockerignore                                          0.1s
    => => transferring context: 2B                                            0.0s
   error: failed to solve: rpc error: code = Unknown desc = failed to solve with frontend dockerfile.v0: failed to create LLB definition:
   dockerfile parse error line 2: unknown instruction: RUNCMD

.. The Docker daemon runs the instructions in the Dockerfile one-by-one, committing the result of each instruction to a new image if necessary, before finally outputting the ID of your new image. The Docker daemon will automatically clean up the context you sent.

Docker デーモンは ``Dockerfile`` 内の命令を 1 つずつ実行し、必要な場合にはビルドイメージ内にその処理結果を :ruby:`確定 <commit>` （コミット）し、最後に新しいイメージの ID を出力します。Docker デーモンは、送信されたコンテキスト内容を自動的に :ruby:`除去 <clean up>` します。

.. Note that each instruction is run independently, and causes a new image to be created - so RUN cd /tmp will not have any effect on the next instructions.

各命令は個別に実行され、都度、新しいイメージが生成されますのでご注意ください。したがって、たとえば ``RUN cd /tmp`` という命令があっても、その次の命令には何ら影響を与えません。

.. Whenever possible, Docker uses a build-cache to accelerate the docker build process significantly. This is indicated by the CACHED message in the console output. (For more information, see the Dockerfile best practices guide:

Docker は可能な限り :ruby:`構築キャッシュ <build-cache>` を使用し、 ``docker build`` の処理を著しく高速にします。その場合はコンソール出力に ``CACHED`` というメッセージが出ます。（詳細については、 :doc:`Dockerfile のベストプラクティスガイド </develop/develop-images/dockerfile_best-practices/>` を参照ください。）

.. code-block:: bash

   $ docker build -t svendowideit/ambassador .
   
   [+] Building 0.7s (6/6) FINISHED
    => [internal] load build definition from Dockerfile                       0.1s
    => => transferring dockerfile: 286B                                       0.0s
    => [internal] load .dockerignore                                          0.1s
    => => transferring context: 2B                                            0.0s
    => [internal] load metadata for docker.io/library/alpine:3.2              0.4s
    => CACHED [1/2] FROM docker.io/library/alpine:3.2@sha256:e9a2035f9d0d7ce  0.0s
    => CACHED [2/2] RUN apk add --no-cache socat                              0.0s
    => exporting to image                                                     0.0s
    => => exporting layers                                                    0.0s
    => => writing image sha256:1affb80ca37018ac12067fa2af38cc5bcc2a8f09963de  0.0s
    => => naming to docker.io/svendowideit/ambassador                         0.0s

.. By default, the build cache is based on results from previous builds on the machine on which you are building. The --cache-from option also allows you to use a build-cache that's distributed through an image registry refer to the specifying external cache sources section in the docker build command reference.

構築キャッシュとは、デフォルトでは、構築するマシン上で以前に構築された結果に基づきます。 ``--cache-from`` オプションの指定により、イメージ・レジストリを通して配布された構築キャッシュも使えます。 ``docker build`` コマンドリファレンスの :ref:`外部のキャッシュをソースとして指定 <specifying-external-cache-sources>` セクションをご覧ください。

.. When you’re done with your build, you’re ready to look into scanning your image with docker scan, and pushing your image to Docker Hub.

構築が終われば、 ``docker scan`` で  :doc:`イメージを検査 </engine/scan>` したり、 :doc:`Docker Hub にイメージを送信 </docker-hub/repos>` したりできます。

.. BuildKit

.. _dockerfile-buildkit:

:ruby:`BuildKit <ビルドキット>`
========================================

.. Starting with version 18.09, Docker supports a new backend for executing your builds that is provided by the moby/buildkit project. The BuildKit backend provides many benefits compared to the old implementation. For example, BuildKit can:

バージョン 18.09 から、Docker は `moby/buildkit <https://github.com/moby/buildkit>`_ プロジェクトによって提供された新しい構築用バックエンドをサポートしています。

..  Detect and skip executing unused build stages
    Parallelize building independent build stages
    Incrementally transfer only the changed files in your build context between builds
    Detect and skip transferring unused files in your build context
    Use external Dockerfile implementations with many new features
    Avoid side-effects with rest of the API (intermediate images and containers)
    Prioritize your build cache for automatic pruning

To use the BuildKit backend, you need to set an environment variable DOCKER_BUILDKIT=1 on the CLI before invoking docker build.

To learn about the experimental Dockerfile syntax available to BuildKit-based builds refer to the documentation in the BuildKit repository.




.. Format

書式
==========

.. Here is the format of the `Dockerfile`:

ここに ``Dockerfile`` の記述書式を示します。

.. ```Dockerfile
   # Comment
   INSTRUCTION arguments

.. code-block:: dockerfile

   # Comment
   INSTRUCTION arguments


.. The instruction is not case-sensitive. However, convention is for them to
   be UPPERCASE to distinguish them from arguments more easily.

命令（instruction）は大文字小文字を区別しません。
ただし慣習として大文字とします。
そうすることで引数（arguments）との区別をつけやすくします。

.. Docker runs instructions in a `Dockerfile` in order. A `Dockerfile` **must
   start with a \`FROM\` instruction**. The `FROM` instruction specifies the [*Base
   Image*](glossary.md#base-image) from which you are building. `FROM` may only be
   preceded by one or more `ARG` instructions, which declare arguments that are used
   in `FROM` lines in the `Dockerfile`.

Docker は ``Dockerfile`` 内の命令を記述順に実行します。
``Dockerfile`` は必ず ``FROM`` **命令で** 始めなければなりません。
``FROM`` 命令は、ビルドするイメージに対しての :ref:`ベースイメージ <base-image>` を指定するものです。
``FROM`` よりも先に記述できる命令として ``ARG`` があります。
これは ``FROM`` において用いられる引数を宣言するものです。


.. Docker treats lines that *begin* with `#` as a comment, unless the line is
   a valid [parser directive](#parser-directives). A `#` marker anywhere
   else in a line is treated as an argument. This allows statements like:

行頭が ``#`` で始まる行はコメントとして扱われます。
ただし例外として :ref:`パーサ・ディレクティブ <parser-directives>` があります。
行途中の ``#`` は単なる引数として扱われます。
以下のような行記述が可能です。

.. ```Dockerfile
   # Comment
   RUN echo 'we are running some # of cool things'
   ```

.. code-block:: dockerfile

   # Comment
   RUN echo 'we are running some # of cool things'

.. Line continuation characters are not supported in comments.

コメントにおいて行継続を指示する文字はサポートされていません。

.. ## Parser directives

.. _parser-directives:

パーサ・ディレクティブ
==================================================

.. Parser directives are optional, and affect the way in which subsequent lines
   in a `Dockerfile` are handled. Parser directives do not add layers to the build,
   and will not be shown as a build step. Parser directives are written as a
   special type of comment in the form `# directive=value`. A single directive
   may only be used once.

パーサ・ディレクティブ（parser directive）を利用することは任意です。
これは ``Dockerfile`` 内のその後に続く記述行を取り扱う方法を指示するものです。
パーサ・ディレクティブはビルドされるイメージにレイヤを追加しません。
したがってビルドステップとして表示されることはありません。
パーサ・ディレクティブは、特別なコメントの記述方法をとるもので、`# ディレクティブ＝値` という書式です。
同一のディレクティブは一度しか記述できません。

.. Once a comment, empty line or builder instruction has been processed, Docker
   no longer looks for parser directives. Instead it treats anything formatted
   as a parser directive as a comment and does not attempt to validate if it might
   be a parser directive. Therefore, all parser directives must be at the very
   top of a `Dockerfile`.

コメント、空行、ビルド命令が一つでも読み込まれたら、それ以降 Docker はパーサ・ディレクティブの処理を行いません。
その場合、パーサ・ディレクティブの書式で記述されていても、それはコメントとして扱われます。
そしてパーサ・ディレクティブとして適切な書式であるかどうかも確認しません。
したがってパーサ・ディレクティブは ``Dockerfile`` の冒頭に記述しなければなりません。

.. Parser directives are not case-sensitive. However, convention is for them to
   be lowercase. Convention is also to include a blank line following any
   parser directives. Line continuation characters are not supported in parser
   directives.

パーサ・ディレクティブは大文字小文字を区別しません。
ただし慣習として小文字とします。
同じく慣習として、パーサ・ディレクティブの次には空行を 1 行挿入します。
パーサ・ディレクティブにおいて、行継続を指示する文字はサポートされていません。

.. Due to these rules, the following examples are all invalid:

これらのルールがあるため、以下の例は全て無効です。

.. Invalid due to line continuation:

行の継続は無効：

.. code-block:: dockerfile

   # direc \
   tive=value

.. Invalid due to appearing twice:

二度出現するため無効：

.. code-block:: dockerfile

   # directive=value1
   # directive=value2
   
   FROM ImageName

.. Treated as a comment due to appearing after a builder instruction:

構築命令の後にあれば、コメントとして扱う：

.. code-block:: dockerfile

   FROM ImageName
   # directive=value

.. Treated as a comment due to appearing after a comment which is not a parser directive:

パーサ・ディレクティブでないコメントがあれば、以降のものはコメントとして扱う：

.. code-block:: dockerfile

   # About my dockerfile
   FROM ImageName
   # directive=value

.. The unknown directive is treated as a comment due to not being recognized. In addition, the known directive is treated as a comment due to appearing after a comment which is not a parser directive.

不明なディレクティブは認識できないため、コメントとして扱う。さらに、パーサ・ディレクティブではないコメントの後にディレクティブがあったとしても、コメントとして扱う：

# unknowndirective=value
# knowndirective=value

.. Non line-breaking whitespace is permitted in a parser directive. Hence, the
   following lines are all treated identically:

改行ではないホワイトスペースは、パーサ・ディレクティブにおいて記述することができます。
そこで、以下の各行はすべて同一のものとして扱われます。

.. ```Dockerfile
   #directive=value
   # directive =value
   #	directive= value
   # directive = value
   #	  dIrEcTiVe=value
   ```

.. code-block:: dockerfile

   #directive=value
   # directive =value
   #	directive= value
   # directive = value
   #	  dIrEcTiVe=value

.. The following parser directive is supported:

以下のパーサ・ディレクティブをサポートします：

* ``escape``

.. escape

.. _parser-directive-escape:

escape
--------------------

.. code-block:: dockerfile

   # escape=\ (バックスラッシュ)

.. Or

または

.. code-block:: dockerfile

   # escape=` (バッククォート)

.. The `escape` directive sets the character used to escape characters in a
   `Dockerfile`. If not specified, the default escape character is `\`.

ディレクティブ ``escape`` は、``Dockerfile`` 内でエスケープ文字として用いる文字を設定します。
設定していない場合は、デフォルトとして `\` が用いられます。


.. The escape character is used both to escape characters in a line, and to
   escape a newline. This allows a `Dockerfile` instruction to
   span multiple lines. Note that regardless of whether the `escape` parser
   directive is included in a `Dockerfile`, *escaping is not performed in
   a `RUN` command, except at the end of a line.*

エスケープ文字は行途中での文字をエスケープするものと、行継続をエスケープするものがあります。
行継続のエスケープを使うと ``Dockerfile`` 内の命令を複数行に分けることができます。
``Dockerfile`` に ``escape`` パーサ・ディレクティブを記述していたとしても、``RUN`` コマンドの途中でのエスケープは無効であり、行末の行継続エスケープのみ利用することができます。

.. Setting the escape character to `` ` `` is especially useful on
   `Windows`, where `\` is the directory path separator. `` ` `` is consistent
   with [Windows PowerShell](https://technet.microsoft.com/en-us/library/hh847755.aspx).

``Windows`` においてはエスケープ文字を「`」とします。
``\`` はディレクトリ・セパレータとなっているためです。
「`」は `Windows PowerShell <https://technet.microsoft.com/en-us/library/hh847755.aspx>`_ 上でも利用できます。

.. Consider the following example which would fail in a non-obvious way on
   `Windows`. The second `\` at the end of the second line would be interpreted as an
   escape for the newline, instead of a target of the escape from the first `\`.
   Similarly, the `\` at the end of the third line would, assuming it was actually
   handled as an instruction, cause it be treated as a line continuation. The result
   of this dockerfile is that second and third lines are considered a single
   instruction:

以下のような ``Windows`` 上の例を見てみます。
これはよく分からずに失敗してしまう例です。
2 行めの行末にある 2 つめの ``\`` は、次の行への継続を表わすエスケープと解釈されます。
つまり 1 つめの ``\`` をエスケープするものとはなりません。
同様に 3 行めの行末にある ``\`` も、この行が正しく命令として解釈されるものであっても、行継続として扱われることになります。
結果としてこの Dockerfile の 2 行めと 3 行めは、一続きの記述行とみなされます。

.. ```Dockerfile
   FROM microsoft/nanoserver
   COPY testfile.txt c:\\
   RUN dir c:\
   ```

.. code-block:: dockerfile

   FROM microsoft/nanoserver
   COPY testfile.txt c:\\
   RUN dir c:\

.. Results in:

この Dockerfile を用いると以下の結果になります。

   ..  PS C:\John> docker build -t cmd .
       Sending build context to Docker daemon 3.072 kB
       Step 1/2 : FROM microsoft/nanoserver
        ---> 22738ff49c6d
       Step 2/2 : COPY testfile.txt c:\RUN dir c:
       GetFileAttributesEx c:RUN: The system cannot find the file specified.
       PS C:\John>

.. code-block:: powershell

   PS C:\John> docker build -t cmd .
   Sending build context to Docker daemon 3.072 kB
   Step 1/2 : FROM microsoft/nanoserver
    ---> 22738ff49c6d
   Step 2/2 : COPY testfile.txt c:\RUN dir c:
   GetFileAttributesEx c:RUN: The system cannot find the file specified.
   PS C:\John>

.. One solution to the above would be to use `/` as the target of both the `COPY`
   instruction, and `dir`. However, this syntax is, at best, confusing as it is not
   natural for paths on `Windows`, and at worst, error prone as not all commands on
   `Windows` support `/` as the path separator.

上を解決するには ``COPY`` 命令と ``dir`` の対象において ``/`` を用います。
ただし ``Windows`` 上における普通のパス記述とは違う文法であるため混乱しやすく、さらに ``Windows`` のあらゆるコマンドがパス・セパレータとして  ``/`` をサポートしているわけではないので、エラーになることもあります。

.. By adding the `escape` parser directive, the following `Dockerfile` succeeds as
   expected with the use of natural platform semantics for file paths on `Windows`:

パーサ・ディレクティブ ``escape`` を利用すれば、``Windows`` 上のファイル・パスの文法をそのままに、期待どおりに ``Dockerfile`` が動作してくれます。

   ..  # escape=`

       FROM microsoft/nanoserver
       COPY testfile.txt c:\
       RUN dir c:\

.. code-block:: dockerfile

   # escape=`

   FROM microsoft/nanoserver
   COPY testfile.txt c:\
   RUN dir c:\

.. Results in:

上を処理に用いると以下のようになります。

   ..  PS C:\John> docker build -t succeeds --no-cache=true .
       Sending build context to Docker daemon 3.072 kB
       Step 1/3 : FROM microsoft/nanoserver
        ---> 22738ff49c6d
       Step 2/3 : COPY testfile.txt c:\
        ---> 96655de338de
       Removing intermediate container 4db9acbb1682
       Step 3/3 : RUN dir c:\
        ---> Running in a2c157f842f5
        Volume in drive C has no label.
        Volume Serial Number is 7E6D-E0F7

        Directory of c:\

       10/05/2016  05:04 PM             1,894 License.txt
       10/05/2016  02:22 PM    <DIR>          Program Files
       10/05/2016  02:14 PM    <DIR>          Program Files (x86)
       10/28/2016  11:18 AM                62 testfile.txt
       10/28/2016  11:20 AM    <DIR>          Users
       10/28/2016  11:20 AM    <DIR>          Windows
                  2 File(s)          1,956 bytes
                  4 Dir(s)  21,259,096,064 bytes free
        ---> 01c7f3bef04f
       Removing intermediate container a2c157f842f5
       Successfully built 01c7f3bef04f
       PS C:\John>

.. code-block:: powershell

   PS C:\John> docker build -t succeeds --no-cache=true .
   Sending build context to Docker daemon 3.072 kB
   Step 1/3 : FROM microsoft/nanoserver
    ---> 22738ff49c6d
   Step 2/3 : COPY testfile.txt c:\
    ---> 96655de338de
   Removing intermediate container 4db9acbb1682
   Step 3/3 : RUN dir c:\
    ---> Running in a2c157f842f5
    Volume in drive C has no label.
    Volume Serial Number is 7E6D-E0F7

    Directory of c:\

   10/05/2016  05:04 PM             1,894 License.txt
   10/05/2016  02:22 PM    <DIR>          Program Files
   10/05/2016  02:14 PM    <DIR>          Program Files (x86)
   10/28/2016  11:18 AM                62 testfile.txt
   10/28/2016  11:20 AM    <DIR>          Users
   10/28/2016  11:20 AM    <DIR>          Windows
              2 File(s)          1,956 bytes
              4 Dir(s)  21,259,096,064 bytes free
    ---> 01c7f3bef04f
   Removing intermediate container a2c157f842f5
   Successfully built 01c7f3bef04f
   PS C:\John>

.. ## Environment replacement

.. _environment-replacement:

環境変数の置換
====================

.. Environment variables (declared with [the `ENV` statement](#env)) can also be
   used in certain instructions as variables to be interpreted by the
   `Dockerfile`. Escapes are also handled for including variable-like syntax
   into a statement literally.

``Dockerfile`` の :ref:`ENV 構文 <#env>` により宣言される環境変数は、特定の命令において変数として解釈されます。
エスケープについても構文内にリテラルを含めることから、変数と同様の扱いと考えられます。

.. Environment variables are notated in the `Dockerfile` either with
   `$variable_name` or `${variable_name}`. They are treated equivalently and the
   brace syntax is typically used to address issues with variable names with no
   whitespace, like `${foo}_bar`.

``Dockerfile`` における環境変数の記述書式は、``$variable_name`` あるいは ``${variable_name}`` のいずれかが可能です。
両者は同等のものですが、ブレースを用いた記述は ``${foo}_bar`` といった記述のように、変数名にホワイトスペースを含めないようにするために利用されます。

.. The `${variable_name}` syntax also supports a few of the standard `bash`
   modifiers as specified below:

``${variable_name}`` という書式は、標準的な ``bash`` の修飾書式をいくつかサポートしています。
たとえば以下のものです。

.. * `${variable:-word}` indicates that if `variable` is set then the result
     will be that value. If `variable` is not set then `word` will be the result.
   * `${variable:+word}` indicates that if `variable` is set then `word` will be
     the result, otherwise the result is the empty string.

* ``${variable:-word}`` は、``variable`` が設定されているとき、この結果はその値となります。
  ``variable`` が設定されていないとき、``word`` が結果となります。
* ``${variable:+word}`` は、``variable`` が設定されているとき、この結果は ``word`` となります。
  ``variable`` が設定されていないとき、結果は空文字となります。

.. In all cases, `word` can be any string, including additional environment
   variables.

どの例においても、``word`` は文字列であれば何でもよく、さらに別の環境変数を含んでいても構いません。

.. Escaping is possible by adding a `\` before the variable: `\$foo` or `\${foo}`,
   for example, will translate to `$foo` and `${foo}` literals respectively.

変数名をエスケープすることも可能で、変数名の前に ``\$foo`` や ``\${foo}`` のように ``\`` をつけます。
こうすると、この例はそれぞれ ``$foo``、``${foo}`` という文字列そのものとして解釈されます。

.. Example (parsed representation is displayed after the `#`):

記述例 （`#` の後に変数解釈した結果を表示）

.. code-block:: dockerfile

   FROM busybox
   ENV foo /bar
   WORKDIR ${foo}   # WORKDIR /bar
   ADD . $foo       # ADD . /bar
   COPY \$foo /quux # COPY $foo /quux

.. Environment variables are supported by the following list of instructions in
   the `Dockerfile`:

環境変数は、以下に示す ``Dockerfile`` 内の命令においてサポートされます。

* ``ADD``
* ``COPY``
* ``ENV``
* ``EXPOSE``
* ``LABEL``
* ``USER``
* ``WORKDIR``
* ``VOLUME``
* ``STOPSIGNAL``

.. as well as:

同様に、

.. * `ONBUILD` (when combined with one of the supported instructions above)

* ``ONBUILD`` （上記のサポート対象の命令と組み合わせて用いる場合）

.. > **Note**:
   > prior to 1.4, `ONBUILD` instructions did **NOT** support environment
   > variable, even when combined with any of the instructions listed above.

.. note::

   Docker バージョン 1.4 より以前では ``ONBUILD`` 命令は環境変数をサポートしていません。
   一覧にあげた命令との組み合わせで用いる場合も同様です。

.. Environment variable substitution will use the same value for each variable
   throughout the entire instruction. In other words, in this example:

環境変数の置換は、命令全体の中で個々の変数ごとに同一の値が用いられます。
これを説明するために以下の例を見ます。

.. code-block:: dockerfile

   ENV abc=hello
   ENV abc=bye def=$abc
   ENV ghi=$abc

.. will result in `def` having a value of `hello`, not `bye`. However,
   `ghi` will have a value of `bye` because it is not part of the same instruction 
   that set `abc` to `bye`.

この結果、``def`` は ``hello`` になります。
``bye`` ではありません。
しかし ``ghi`` は ``bye`` になります。
``ghi`` を設定している行は、 ``abc`` に ``bye`` を設定している命令と同一箇所ではないからです。

.. _dockerignore-file:

.dockerignore ファイル
==============================

.. Before the docker CLI sends the context to the docker daemon, it looks
   for a file named `.dockerignore` in the root directory of the context.
   If this file exists, the CLI modifies the context to exclude files and
   directories that match patterns in it.  This helps to avoid
   unnecessarily sending large or sensitive files and directories to the
   daemon and potentially adding them to images using `ADD` or `COPY`.

Docker の CLI によってコンテキストが Docker デーモンに送信される前には、コンテキストのルートディレクトリの ``.dockerignore`` というファイルが参照されます。
このファイルが存在したら、CLI はそこに記述されたパターンにマッチするようなファイルやディレクトリを除外した上で、コンテキストを扱います。
必要もないのに、巨大なファイルや取り扱い注意のファイルを不用意に送信してしまうことが避けられ、``ADD`` や ``COPY`` を使ってイメージに間違って送信してしまうことを防ぐことができます。

.. The CLI interprets the `.dockerignore` file as a newline-separated
   list of patterns similar to the file globs of Unix shells.  For the
   purposes of matching, the root of the context is considered to be both
   the working and the root directory.  For example, the patterns
   `/foo/bar` and `foo/bar` both exclude a file or directory named `bar`
   in the `foo` subdirectory of `PATH` or in the root of the git
   repository located at `URL`.  Neither excludes anything else.

CLI は ``.dockerignore`` ファイルを各行ごとに区切られた設定一覧として捉えます。
ちょうど Unix シェルにおけるファイルグロブ（glob）と同様です。
マッチング処理の都合上、コンテキストのルートは、ワーキングディレクトリとルートディレクトリの双方であるものとしてみなされます。
たとえばパターンとして ``/foo/bar`` と ``foo/bar`` があったとすると、``PATH`` 上であればサブディレクトリ ``foo`` 内、``URL`` であればその git レポジトリ内の、いずれも ``bar`` というファイルまたはディレクトリを除外します。
その他のものについては除外対象としません。

.. If a line in `.dockerignore` file starts with `#` in column 1, then this line is
   considered as a comment and is ignored before interpreted by the CLI.

``.dockerignore`` ファイルの各行頭の第 1 カラムめに ``#`` があれば、その行はコメントとみなされて、CLI による解釈が行われず無視されます。

.. Here is an example .dockerignore file:

これは ``.dockerignore`` ファイルの例です：

.. code-block:: bash

   # コメント
   */temp*
   */*/temp*
   temp?

.. This file causes the following build behavior:

このファイルは構築時に以下の動作をします。

.. | Rule           | Behavior                                                                                                                                                                     |
   |----------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
   | `# comment`    | Ignored.                 |
   | `*/temp*`      | Exclude files and directories whose names start with `temp` in any immediate subdirectory of the root.  For example, the plain file `/somedir/temporary.txt` is excluded, as is the directory `/somedir/temp`.                 |
   | `*/*/temp*`    | Exclude files and directories starting with `temp` from any subdirectory that is two levels below the root. For example, `/somedir/subdir/temporary.txt` is excluded. |
   | `temp?`        | Exclude files and directories in the root directory whose names are a one-character extension of `temp`.  For example, `/tempa` and `/tempb` are excluded.

.. 表にする(todo)

* ``# comment`` … 無視されます。
* ``*/temp*`` … ルートディレクトリの直下にあるサブディレクトリ内にて、``temp`` で始まる名称のファイルまたはディレクトリすべてを除外します。たとえば通常のファイル ``/somedir/temporary.txt`` は除外されます。ディレクトリ ``/somedir/temp`` も同様です。
* ``*/*/temp*`` … ルートから 2 階層下までのサブディレクトリ内にて、``temp`` で始まる名称のファイルまたはディレクトリすべてを除外します。たとえば ``/somedir/subdir/temporary.txt`` は除外されます。
* ``temp?`` … ルートディレクトリにあるファイルやディレクトリであって、``temp`` にもう 1 文字ついた名前のものを除外します。たとえば ``/tempa`` や ``/tempb`` が除外されます。

.. Matching is done using Go's
   [filepath.Match](http://golang.org/pkg/path/filepath#Match) rules.  A
   preprocessing step removes leading and trailing whitespace and
   eliminates `.` and `..` elements using Go's
   [filepath.Clean](http://golang.org/pkg/path/filepath/#Clean).  Lines
   that are blank after preprocessing are ignored.

パターンマッチングには Go 言語の `filepath.Match <http://golang.org/pkg/path/filepath#Match>`_ ルールが用いられています。
マッチングの前処理として、文字列前後のホワイトスペースは取り除かれ、Go 言語の `filepath.Clean <http://golang.org/pkg/path/filepath/#Clean>`_ によって ``.`` と ``..`` が除外されます。
前処理を行った後の空行は無視されます。

.. Beyond Go's filepath.Match rules, Docker also supports a special
   wildcard string `**` that matches any number of directories (including
   zero). For example, `**/*.go` will exclude all files that end with `.go`
   that are found in all directories, including the root of the build context.

Docker では Go 言語の filepath.Match ルールを拡張して、特別なワイルドカード文字列 ``**`` をサポートしています。
これは複数のディレクトリ（ゼロ個を含む）にマッチします。
たとえば ``**/*.go`` は、ファイル名が ``.go`` で終わるものであって、どのサブディレクトリにあるものであってもマッチします。
ビルドコンテキストのルートも含まれます。

.. Lines starting with `!` (exclamation mark) can be used to make exceptions
   to exclusions.  The following is an example `.dockerignore` file that
   uses this mechanism:

行頭を感嘆符 ``!`` で書き始めると、それは除外に対しての例外を指定するものとなります。
以下の ``.dockerignore`` はこれを用いる例です。

.. code-block:: bash

   *.md
   !README.md

.. All markdown files *except* `README.md` are excluded from the context.

マークダウンファイルがすべてコンテキストから除外されますが、``README.md`` だけは **除外されません** 。

.. The placement of `!` exception rules influences the behavior: the last
   line of the `.dockerignore` that matches a particular file determines
   whether it is included or excluded.  Consider the following example:

``!`` による例外ルールは、それを記述した位置によって処理に影響します。
特定のファイルが含まれるのか除外されるのかは、そのファイルがマッチする ``.dockerignore`` 内の最終の行によって決まります。
以下の例を考えてみます。

.. code-block:: bash

   *.md
   !README*.md
   README-secret.md

.. No markdown files are included in the context except README files other than
   `README-secret.md`.

コンテキストにあるマークダウンファイルはすべて除外されます。
例外として README ファイルは含まれることになりますが、ただし ``README-secret.md`` は除外されます。

.. Now consider this example:

その次の例を考えましょう。

.. code-block:: bash

   *.md
   README-secret.md
   !README*.md

.. All of the README files are included.  The middle line has no effect because
   `!README*.md` matches `README-secret.md` and comes last.

README ファイルはすべて含まれます。
2 行めは意味をなしていません。
なぜなら ``!README*.md`` には ``README-secret.md`` がマッチすることになり、しかも ``!README*.md`` が最後に記述されているからです。

.. You can even use the `.dockerignore` file to exclude the `Dockerfile`
   and `.dockerignore` files.  These files are still sent to the daemon
   because it needs them to do its job.  But the `ADD` and `COPY` instructions
   do not copy them to the image.

``.dockerignore`` ファイルを使って ``Dockerfile`` や ``.dockerignore`` ファイルを除外することもできます。
除外したとしてもこの 2 つのファイルはデーモンに送信されます。
この 2 つのファイルはデーモンの処理に必要なものであるからです。
ただし ``ADD`` 命令や ``COPY`` 命令では、この 2 つのファイルはイメージにコピーされません。

.. Finally, you may want to specify which files to include in the
   context, rather than which to exclude. To achieve this, specify `*` as
   the first pattern, followed by one or more `!` exception patterns.

除外したいファイルを指定するのではなく、含めたいファイルを指定したい場合があります。
これを実現するには、冒頭のマッチングパターンとして ``*`` を指定します。
そしてこれに続けて、例外となるパターンを ``!`` を使って指定します。

.. **Note**: For historical reasons, the pattern `.` is ignored.

.. note::

   これまでの開発経緯によりパターン ``.`` は無視されます。

.. _from:

FROM
==========

   ..  FROM <image> [AS <name>]

.. code-block:: dockerfile

   FROM <image> [AS <name>]

または

   ..  FROM <image>[:<tag>] [AS <name>]

.. code-block:: dockerfile

   FROM <image>[:<tag>] [AS <name>]

または

   ..  FROM <image>[@<digest>] [AS <name>]

.. code-block:: dockerfile

   FROM <image>[@<digest>] [AS <name>]

.. The `FROM` instruction initializes a new build stage and sets the 
   [*Base Image*](glossary.md#base-image) for subsequent instructions. As such, a 
   valid `Dockerfile` must start with a `FROM` instruction. The image can be
   any valid image – it is especially easy to start by **pulling an image** from 
   the [*Public Repositories*](https://docs.docker.com/engine/tutorials/dockerrepos/).

``FROM`` 命令は、イメージビルドのための処理ステージを初期化し、:ref:`ベース・イメージ <base-image>` を設定します。後続の命令がこれに続きます。
このため、正しい ``Dockerfile`` は ``FROM`` 命令から始めなければなりません。
ベース・イメージは正しいものであれば何でも構いません。
簡単に取り掛かりたいときは、`公開リポジトリ <https://docs.docker.com/engine/tutorials/dockerrepos/>`_ から **イメージを取得** します。

.. - `ARG` is the only instruction that may precede `FROM` in the `Dockerfile`.
     See [Understand how ARG and FROM interact](#understand-how-arg-and-from-interact).

* ``Dockerfile`` 内にて ``ARG`` は、``FROM`` よりも前に記述できる唯一の命令です。
  :ref:`ARG と FROM の関連について <understand-how-arg-and-from-interact>` を参照してください。

.. - `FROM` can appear multiple times within a single `Dockerfile` to 
     create multiple images or use one build stage as a dependency for another.
     Simply make a note of the last image ID output by the commit before each new 
     `FROM` instruction. Each `FROM` instruction clears any state created by previous
     instructions.

* 1 つの ``Dockerfile`` 内に ``FROM`` を複数記述することが可能です。
  これは複数のイメージを生成するため、あるいは 1 つのビルドステージを使って依存イメージをビルドするために行います。
  各 ``FROM`` 命令までのコミットによって出力される最終のイメージ ID は書き留めておいてください。
  個々の ``FROM`` 命令は、それ以前の命令により作り出された状態を何も変更しません。

.. - Optionally a name can be given to a new build stage by adding `AS name` to the 
     `FROM` instruction. The name can be used in subsequent `FROM` and
     `COPY --from=<name|index>` instructions to refer to the image built in this stage.

* オプションとして、新たなビルドステージに対しては名前をつけることができます。
  これは ``FROM`` 命令の ``AS name`` により行います。
  この名前は後続の ``FROM`` や ``COPY --from=<name|index>`` 命令において利用することができ、このビルドステージにおいてビルドされたイメージを参照します。

.. - The `tag` or `digest` values are optional. If you omit either of them, the 
     builder assumes a `latest` tag by default. The builder returns an error if it
     cannot find the `tag` value.

* ``tag`` と ``digest`` の設定はオプションです。
  これを省略した場合、デフォルトである ``latest`` タグが指定されたものとして扱われます。
  ``tag`` の値に合致するものがなければ、エラーが返されます。

.. ### Understand how ARG and FROM interact

.. _understand-how-arg-and-from-interact:

ARG と FROM の関連について
--------------------------

.. `FROM` instructions support variables that are declared by any `ARG` 
   instructions that occur before the first `FROM`.

``FROM`` 命令では、``ARG`` 命令によって宣言された変数すべてを参照できます。
この ``ARG`` 命令は、初出の ``FROM`` 命令よりも前に記述します。


.. ```Dockerfile
   ARG  CODE_VERSION=latest
   FROM base:${CODE_VERSION}
   CMD  /code/run-app
   
   FROM extras:${CODE_VERSION}
   CMD  /code/run-extras
   ```

.. code-block:: dockerfile

   ARG  CODE_VERSION=latest
   FROM base:${CODE_VERSION}
   CMD  /code/run-app

   FROM extras:${CODE_VERSION}
   CMD  /code/run-extras

.. An `ARG` declared before a `FROM` is outside of a build stage, so it
   can't be used in any instruction after a `FROM`. To use the default value of
   an `ARG` declared before the first `FROM` use an `ARG` instruction without
   a value inside of a build stage:

``FROM`` よりも前に宣言されている ``ARG`` は、ビルドステージ内に含まれるものではありません。
したがって ``FROM`` 以降の命令において利用することはできません。
初出の ``FROM`` よりも前に宣言された ``ARG`` の値を利用するには、ビルドステージ内において ``ARG`` 命令を、値を設定することなく利用します。

.. ```Dockerfile
   ARG VERSION=latest
   FROM busybox:$VERSION
   ARG VERSION
   RUN echo $VERSION > image_version
   ```

.. code-block:: dockerfile

   ARG VERSION=latest
   FROM busybox:$VERSION
   ARG VERSION
   RUN echo $VERSION > image_version

.. _run:

RUN
==========

.. RUN has 2 forms:

RUN には２つの形式があります。

.. - `RUN <command>` (*shell* form, the command is run in a shell, which by
   default is `/bin/sh -c` on Linux or `cmd /S /C` on Windows)
   - `RUN ["executable", "param1", "param2"]` (*exec* form)

* ``RUN <command>`` （シェル形式、コマンドはシェル内で実行される、シェルとはデフォルトで Linux なら ``/bin/sh -c``、Windows なら ``cmd /S /C``）
* ``RUN ["executable", "param1", "param2"]`` （exec 形式）

.. The `RUN` instruction will execute any commands in a new layer on top of the
   current image and commit the results. The resulting committed image will be
   used for the next step in the `Dockerfile`.

``RUN`` 命令は、現在のイメージの最上位の最新レイヤーにおいて、あらゆるコマンドを実行します。
そして処理結果を確定します。
結果が確定したイメージは、``Dockerfile`` の次のステップにおいて利用されていきます。

.. Layering `RUN` instructions and generating commits conforms to the core
   concepts of Docker where commits are cheap and containers can be created from
   any point in an image's history, much like source control.

``RUN`` 命令をレイヤー上にて扱い処理確定を行うこの方法は、Docker の根本的な考え方に基づいています。
この際の処理確定は容易なものであって、イメージの処理履歴上のどの時点からでもコンテナーを復元できます。
この様子はソース管理システムに似ています。

.. The *exec* form makes it possible to avoid shell string munging, and to `RUN`
   commands using a base image that does not contain the specified shell executable.

exec 形式は、シェル文字列が置換されないようにします。
そして ``RUN`` の実行にあたっては、特定のシェル変数を含まないベースイメージを用います。

.. The default shell for the *shell* form can be changed using the `SHELL`
   command.

シェル形式にて用いるデフォルトのシェルを変更するには ``SHELL`` コマンドを使います。

.. In the *shell* form you can use a `\` (backslash) to continue a single
   RUN instruction onto the next line. For example, consider these two lines:

シェル形式においては ``\``（バックスラッシュ）を用いて、1 つの RUN 命令を次行にわたって記述することができます。
たとえば以下のような 2 行があるとします。

.. code-block:: dockerfile

   RUN /bin/bash -c 'source $HOME/.bashrc ;\
   echo $HOME'

.. Together they are equivalent to this single line:

上は 2 行を合わせて、以下の 1 行としたものと同じです。

.. code-block:: dockerfile

   RUN /bin/bash -c 'source $HOME/.bashrc ; echo $HOME'

.. > **Note**:
   > To use a different shell, other than '/bin/sh', use the *exec* form
   > passing in the desired shell. For example,
   > `RUN ["/bin/bash", "-c", "echo hello"]`

.. note::

   '/bin/sh' 以外の別のシェルを利用する場合は、exec 形式を用いて、目的とするシェルを引数に与えます。
   たとえば ``RUN ["/bin/bash", "-c", "echo hello"]`` とします。

.. > **Note**:
   > The *exec* form is parsed as a JSON array, which means that
   > you must use double-quotes (") around words not single-quotes (').

.. note::

   exec 形式は JSON 配列として解釈されます。
   したがって文字列をくくるのはダブル・クォート（"）であり、シングル・クォート（'）は用いてはなりません。

.. > **Note**:
   > Unlike the *shell* form, the *exec* form does not invoke a command shell.
   > This means that normal shell processing does not happen. For example,
   > `RUN [ "echo", "$HOME" ]` will not do variable substitution on `$HOME`.
   > If you want shell processing then either use the *shell* form or execute
   > a shell directly, for example: `RUN [ "sh", "-c", "echo $HOME" ]`.
   > When using the exec form and executing a shell directly, as in the case for
   > the shell form, it is the shell that is doing the environment variable
   > expansion, not docker.

.. note::

   シェル形式とは違って exec 形式はコマンドシェルを起動しません。
   これはつまり、ごく普通のシェル処理とはならないということです。
   たとえば ``RUN [ "echo", "$HOME" ]`` を実行したとすると、``$HOME`` の変数置換は行われません。
   シェル処理が行われるようにしたければ、シェル形式を利用するか、あるいはシェルを直接実行するようにします。
   たとえば ``RUN [ "sh", "-c", "echo $HOME" ]`` とします。
   exec 形式によってシェルを直接起動した場合、シェル形式の場合でも同じですが、変数置換を行うのはシェルであって、docker ではありません。

.. > **Note**:
   > In the *JSON* form, it is necessary to escape backslashes. This is
   > particularly relevant on Windows where the backslash is the path separator.
   > The following line would otherwise be treated as *shell* form due to not
   > being valid JSON, and fail in an unexpected way:
   > `RUN ["c:\windows\system32\tasklist.exe"]`
   > The correct syntax for this example is:
   > `RUN ["c:\\windows\\system32\\tasklist.exe"]`

.. note::

   JSON 記述においてバックスラッシュはエスケープする必要があります。
   特に関係してくるのは Windows であり、Windows ではパス・セパレータにバックスラッシュを用います。
   ``RUN ["c:\windows\system32\tasklist.exe"]`` という記述例は、適正な JSON 記述ではないことになるため、シェル形式として扱われ、思いどおりの動作はせずエラーとなります。
   正しくは ``RUN ["c:\\windows\\system32\\tasklist.exe"]`` と記述します。

.. The cache for `RUN` instructions isn't invalidated automatically during
   the next build. The cache for an instruction like
   `RUN apt-get dist-upgrade -y` will be reused during the next build. The
   cache for `RUN` instructions can be invalidated by using the `--no-cache`
   flag, for example `docker build --no-cache`.

``RUN`` 命令に対するキャッシュは、次のビルドの際、その無効化は自動的に行われません。
``RUN apt-get dist-upgrade -y`` のような命令に対するキャッシュは、次のビルドの際にも再利用されます。
``RUN`` 命令に対するキャッシュを無効にするためには ``--no-cache`` フラグを利用します。
たとえば ``docker build --no-cache`` とします。

.. See the Dockerfile Best Practices guide for more information.

より詳しい情報は ``Dockerfile`` :ref:`ベスト・プラクティス・ガイド <build-cache>` をご覧ください。

.. The cache for RUN instructions can be invalidated by ADD instructions. See below for details.

``RUN`` 命令のキャッシュは、　``ADD`` 命令によって無効化されます。詳細は :ref:`以下 <add>` をご覧ください。

.. Known issues (RUN)

既知の問題(RUN)
--------------------

.. - [Issue 783](https://github.com/docker/docker/issues/783) is about file
     permissions problems that can occur when using the AUFS file system. You
     might notice it during an attempt to `rm` a file, for example.

* `Issue 783 <https://github.com/docker/docker/issues/783>`_ はファイル・パーミッションに関する問題を取り上げていて、ファイルシステムに AUFS を用いている場合に発生します。
  たとえば ``rm`` によってファイルを削除しようとしたときに、これが発生する場合があります。

  .. For systems that have recent aufs version (i.e., `dirperm1` mount option can
     be set), docker will attempt to fix the issue automatically by mounting
     the layers with `dirperm1` option. More details on `dirperm1` option can be
     found at [`aufs` man page](https://github.com/sfjro/aufs3-linux/tree/aufs3.18/Documentation/filesystems/aufs)

  aufs の最新バージョンを利用するシステム（つまりマウントオプション ``dirperm1`` を設定可能なシステム）の場合、docker はレイヤーに対して ``dirperm1`` オプションをつけてマウントすることで、この問題を自動的に解消するように試みます。
  ``dirperm1`` オプションに関する詳細は ``aufs`` の `man ページ <https://github.com/sfjro/aufs3-linux/tree/aufs3.18/Documentation/filesystems/aufs>`_ を参照してください。

  .. If your system doesn't have support for `dirperm1`, the issue describes a workaround.

  ``dirperm1`` をサポートしていないシステムの場合は、issue に示される回避方法を参照してください。

.. _cmd:

CMD
==========

.. The CMD instruction has three forms:

``CMD`` には３つの形式があります。

.. - `CMD ["executable","param1","param2"]` (*exec* form, this is the preferred form)
   - `CMD ["param1","param2"]` (as *default parameters to ENTRYPOINT*)
   - `CMD command param1 param2` (*shell* form)

* ``CMD ["executable","param1","param2"]`` (exec 形式、この形式が推奨される)
* ``CMD ["param1","param2"]`` ( ``ENTRYPOINT`` のデフォルト・パラメータとして)
* ``CMD command param1 param2`` (シェル形式)

.. There can only be one `CMD` instruction in a `Dockerfile`. If you list more than one `CMD`
   then only the last `CMD` will take effect.

``Dockerfile`` では ``CMD`` 命令を 1 つしか記述できません。
仮に複数の ``CMD`` を記述しても、最後の ``CMD`` 命令しか処理されません。

.. **The main purpose of a `CMD` is to provide defaults for an executing
   container.** These defaults can include an executable, or they can omit
   the executable, in which case you must specify an `ENTRYPOINT`
   instruction as well.

``CMD`` 命令の主目的は、**コンテナの実行時のデフォルト処理を設定することです。**
この処理設定においては、実行モジュールを含める場合と、実行モジュールを省略する場合があります。
省略する場合は ``ENTRYPOINT`` 命令を合わせて指定する必要があります。

.. > **Note**:
   > If `CMD` is used to provide default arguments for the `ENTRYPOINT`
   > instruction, both the `CMD` and `ENTRYPOINT` instructions should be specified
   > with the JSON array format.

.. note::

   ``ENTRYPOINT`` 命令に対するデフォルト引数を設定する目的で ``CMD`` 命令を用いる場合、``CMD`` と ``ENTRYPOINT`` の両命令とも、JSON 配列形式で指定しなければなりません。

.. > **Note**:
   > The *exec* form is parsed as a JSON array, which means that
   > you must use double-quotes (") around words not single-quotes (').

.. note::

   exec 形式は JSON 配列として解釈されます。
   したがって文字列をくくるのはダブル・クォート（"）であり、シングル・クォート（'）は用いてはなりません。

.. > **Note**:
   > Unlike the *shell* form, the *exec* form does not invoke a command shell.
   > This means that normal shell processing does not happen. For example,
   > `CMD [ "echo", "$HOME" ]` will not do variable substitution on `$HOME`.
   > If you want shell processing then either use the *shell* form or execute
   > a shell directly, for example: `CMD [ "sh", "-c", "echo $HOME" ]`.
   > When using the exec form and executing a shell directly, as in the case for
   > the shell form, it is the shell that is doing the environment variable
   > expansion, not docker.

.. note::

   シェル形式とは違って exec 形式はコマンドシェルを起動しません。
   これはつまり、ごく普通のシェル処理とはならないということです。
   たとえば ``RUN [ "echo", "$HOME" ]`` を実行したとすると、``$HOME`` の変数置換は行われません。
   シェル処理が行われるようにしたければ、シェル形式を利用するか、あるいはシェルを直接実行するようにします。
   たとえば ``RUN [ "sh", "-c", "echo $HOME" ]`` とします。
   exec 形式によってシェルを直接起動した場合、シェル形式の場合でも同じですが、変数置換を行うのはシェルであって、docker ではありません。

.. When used in the shell or exec formats, the `CMD` instruction sets the command
   to be executed when running the image.

シェル形式または exec 形式を用いる場合、``CMD`` 命令は、イメージが起動されたときに実行するコマンドを指定します。

.. If you use the *shell* form of the `CMD`, then the `<command>` will execute in
   `/bin/sh -c`:

シェル形式を用いる場合、``<command>`` は ``/bin/sh -c`` の中で実行されます。

.. code-block:: dockerfile

   FROM ubuntu
   CMD echo "This is a test." | wc -

.. If you want to **run your** `<command>` **without a shell** then you must
   express the command as a JSON array and give the full path to the executable.
   **This array form is the preferred format of `CMD`.** Any additional parameters
   must be individually expressed as strings in the array:

``<command>`` **をシェル実行することなく実行** したい場合は、そのコマンドを JSON 配列として表現し、またそのコマンドの実行モジュールへのフルパスを指定しなければなりません。
**この配列書式は** ``CMD`` **において推奨される記述です。**
パラメータを追加する必要がある場合は、配列内にて文字列として記述します。

.. code-block:: dockerfile

   FROM ubuntu
   CMD ["/usr/bin/wc","--help"]

.. If you would like your container to run the same executable every time, then
   you should consider using `ENTRYPOINT` in combination with `CMD`. See
   [*ENTRYPOINT*](#entrypoint).

コンテナにおいて毎回同じ実行モジュールを起動させたい場合は、``CMD`` 命令と ``ENTRYPOINT`` 命令を合わせて利用することを考えてみてください。
:ref:`ENTRYPOINT <entrypoint>` を参照のこと。

.. If the user specifies arguments to `docker run` then they will override the
   default specified in `CMD`.

``docker run`` において引数を指定することで、``CMD`` 命令に指定されたデフォルトを上書きすることができます。

.. > **Note**:
   > Don't confuse `RUN` with `CMD`. `RUN` actually runs a command and commits
   > the result; `CMD` does not execute anything at build time, but specifies
   > the intended command for the image.

.. note::

   ``RUN`` と ``CMD`` を混同しないようにしてください。
   ``RUN`` は実際にコマンドが実行されて、結果を確定させます。
   一方 ``CMD`` はイメージビルド時には何も実行しません。
   イメージに対して実行する予定のコマンドを指示するものです。

.. _builder-label:

LABEL
==========

.. code-block:: dockerfile

   LABEL <key>=<value> <key>=<value> <key>=<value> ...

.. The `LABEL` instruction adds metadata to an image. A `LABEL` is a
   key-value pair. To include spaces within a `LABEL` value, use quotes and
   backslashes as you would in command-line parsing. A few usage examples:

``LABEL`` 命令はイメージに対してメタデータを追加します。
``LABEL`` ではキーバリューペアによる記述を行います。
値に空白などを含める場合は、クォートとバックスラッシュを用います。
これはコマンドライン処理において行うことと同じです。
以下に簡単な例を示します。

.. code-block:: dockerfile

   LABEL "com.example.vendor"="ACME Incorporated"
   LABEL com.example.label-with-value="foo"
   LABEL version="1.0"
   LABEL description="This text illustrates \
   that label-values can span multiple lines."

.. An image can have more than one label. To specify multiple labels,
   Docker recommends combining labels into a single `LABEL` instruction where
   possible. Each `LABEL` instruction produces a new layer which can result in an
   inefficient image if you use many labels. This example results in a single image
   layer.

イメージには複数のラベルを含めることができます。
複数のラベルを指定する場合、可能であれば ``LABEL`` 命令の記述を 1 行とすることをお勧めします。
``LABEL`` 命令 1 つからは新しいレイヤが生成されますが、多数のラベルを利用すると、非効率なイメージがビルドされてしまいます。
以下の例は、ただ 1 つのイメージ・レイヤを作るものです。

.. code-block:: dockerfile

   LABEL multi.label1="value1" multi.label2="value2" other="value3"

.. The above can also be written as:

上記の例は、以下のように書くこともできます。

.. code-block:: dockerfile

   LABEL multi.label1="value1" \
         multi.label2="value2" \
         other="value3"

.. Labels are additive including `LABEL`s in `FROM` images. If Docker
   encounters a label/key that already exists, the new value overrides any previous
   labels with identical keys.

ラベルには ``FROM`` に指定されたイメージ内の ``LABEL`` 命令も含まれます。
ラベルのキーが既に存在していた場合、そのキーに対応する古い値は、新しい値によって上書きされます。

.. To view an image's labels, use the `docker inspect` command.

イメージのラベルを参照するには ``docker inspect`` コマンドを用います。

.. code-block:: bash

   "Labels": {
       "com.example.vendor": "ACME Incorporated"
       "com.example.label-with-value": "foo",
       "version": "1.0",
       "description": "This text illustrates that label-values can span multiple lines.",
       "multi.label1": "value1",
       "multi.label2": "value2",
       "other": "value3"
   },

.. ## MAINTAINER (deprecated)

.. _maintainer:

MAINTAINER（廃止予定）
=======================

   ..  MAINTAINER <name>

.. code-block:: dockerfile

    MAINTAINER <name>

.. The `MAINTAINER` instruction sets the *Author* field of the generated images.
   The `LABEL` instruction is a much more flexible version of this and you should use
   it instead, as it enables setting any metadata you require, and can be viewed
   easily, for example with `docker inspect`. To set a label corresponding to the
   `MAINTAINER` field you could use:

``MAINTAINER`` 命令は、ビルドされるイメージの *Author* フィールドを設定します。
``LABEL`` 命令を使った方がこれよりも柔軟に対応できるため、``LABEL`` を使うようにします。
そうすれば必要なメタデータとしてどのようにでも設定ができて、``docker inspect`` を用いて簡単に参照することができます。
``MAINTAINER`` フィールドに相当するラベルを作るには、以下のようにします。

   ..  LABEL maintainer="SvenDowideit@home.org.au"

.. code-block:: dockerfile

   LABEL maintainer="SvenDowideit@home.org.au"

.. This will then be visible from `docker inspect` with the other labels.

こうすれば ``docker inspect`` によってラベルをすべて確認することができます。

.. _expose:

EXPOSE
==========

.. code-block:: dockerfile

   EXPOSE <port> [<port>...]

.. The `EXPOSE` instruction informs Docker that the container listens on the
   specified network ports at runtime. `EXPOSE` does not make the ports of the
   container accessible to the host. To do that, you must use either the `-p` flag
   to publish a range of ports or the `-P` flag to publish all of the exposed
   ports. You can expose one port number and publish it externally under another
   number.

``EXPOSE`` 命令はコンテナの実行時に、所定ネットワーク上のどのポートをリッスンするかを指定します。
``EXPOSE`` はコンテナーのポートをホストが利用できるようにするものではありません。
利用できるようにするためには ``-p`` フラグを使ってポートの公開範囲を指定するか、 ``-P`` フラグによって expose したポートをすべて公開する必要があります。
1 つのポート番号を expose して、これを外部に向けては別の番号により公開することも可能です。

.. To set up port redirection on the host system, see [using the -P
   flag](run.md#expose-incoming-ports). The Docker network feature supports
   creating networks without the need to expose ports within the network, for
   detailed information see the  [overview of this
   feature](https://docs.docker.com/engine/userguide/networking/)).

ホストシステム上にてポート転送を行う場合は、:ref:`-P フラグの利用 <expose-incoming-ports>` を参照してください。
Docker のネットワークにおいては、ネットワーク内でポートを expose しなくてもネットワークを生成できる機能がサポートされています。
詳しくは :doc:`ネットワーク機能の概要 </engine/userguide/networking/index>` を参照してください。

.. _env:

ENV
==========

.. code-block:: dockerfile

   ENV <key> <value>
   ENV <key>=<value> ...

.. The `ENV` instruction sets the environment variable `<key>` to the value
   `<value>`. This value will be in the environment of all "descendant"
   `Dockerfile` commands and can be [replaced inline](#environment-replacement) in
   many as well.

``ENV`` 命令は、環境変数 ``<key>`` に ``<value>`` という値を設定します。
``Dockerfile`` 内の後続命令の環境において、環境変数の値は維持されます。
また、いろいろと :ref:`インラインにて変更 <environment-replacement>` することもできます。

.. The `ENV` instruction has two forms. The first form, `ENV <key> <value>`,
   will set a single variable to a value. The entire string after the first
   space will be treated as the `<value>` - including characters such as
   spaces and quotes.

``ENV`` 命令には 2 つの書式があります。
1 つめの書式は ``ENV <key> <value>`` です。
1 つの変数に対して 1 つの値を設定します。
全体の文字列のうち、最初の空白文字以降がすべて ``<value>`` として扱われます。
そこには空白やクォートを含んでいて構いません。

.. The second form, `ENV <key>=<value> ...`, allows for multiple variables to
   be set at one time. Notice that the second form uses the equals sign (=)
   in the syntax, while the first form does not. Like command line parsing,
   quotes and backslashes can be used to include spaces within values.

2 つめの書式は ``ENV <key>=<value> ...`` です。
これは一度に複数の値を設定できる形です。
この書式では等号（=）を用いており、1 つめの書式とは異なります。
コマンドライン上の解析で行われることと同じように、クォートやバックスラッシュを使えば、値の中に空白などを含めることができます。

.. For example:

例：

.. code-block:: dockerfile

   ENV myName="John Doe" myDog=Rex\ The\ Dog \
       myCat=fluffy

.. and

そして

.. code-block:: dockerfile

   ENV myName John Doe
   ENV myDog Rex The Dog
   ENV myCat fluffy

.. will yield the same net results in the final image, but the first form
   is preferred because it produces a single cache layer.

上の 2 つは最終的に同じ結果をイメージに書き入れます。
ただし 1 つめの書式が望ましいものです。
1 つめは単一のキャッシュ・レイヤしか生成しないからです。

.. The environment variables set using `ENV` will persist when a container is run
   from the resulting image. You can view the values using `docker inspect`, and
   change them using `docker run --env <key>=<value>`.

``ENV`` を用いて設定された環境変数は、そのイメージから実行されたコンテナであれば維持されます。
環境変数の参照は ``docker inspect`` を用い、値の変更は ``docker run --env <key>=<value>`` により行うことができます。

.. > **Note**:
   > Environment persistence can cause unexpected side effects. For example,
   > setting `ENV DEBIAN_FRONTEND noninteractive` may confuse apt-get
   > users on a Debian-based image. To set a value for a single command, use
   > `RUN <key>=<value> <command>`.

.. note::

   環境変数が維持されると、思わぬ副作用を引き起こすことがあります。
   たとえば ``ENV DEBIAN_FRONTEND noninteractive`` という設定を行なっていると、Debian ベースのイメージにおいて apt-get を使う際には混乱を起こすかもしれません。
   1 つのコマンドには 1 つの値のみを設定するには ``RUN <key>=<value> <command>`` を実行します。

.. _add:

ADD
==========

.. ADD has two forms:

ADD には 2 つの書式があります。

.. - `ADD <src>... <dest>`
   - `ADD ["<src>",... "<dest>"]` (this form is required for paths containing
   whitespace)

* ``ADD <src>... <dest>``
* ``ADD ["<src>",... "<dest>"]`` （この書式はホワイトスペースを含むパスを用いる場合に必要）

.. The `ADD` instruction copies new files, directories or remote file URLs from `<src>`
   and adds them to the filesystem of the image at the path `<dest>`.

``ADD`` 命令は ``<src>`` に示されるファイル、ディレクトリ、リモートファイル URL をコピーして、イメージ内のファイルシステム上のパス ``<dest>`` にこれらを加えます。

.. Multiple `<src>` resource may be specified but if they are files or
   directories then they must be relative to the source directory that is
   being built (the context of the build).

``<src>`` には複数のソースを指定することが可能です。
ソースとしてファイルあるいはディレクトリが指定されている場合、そのパスは生成されたソース・ディレクトリ（ビルド・コンテキスト）からの相対パスでなければなりません。

.. Each `<src>` may contain wildcards and matching will be done using Go's
   [filepath.Match](http://golang.org/pkg/path/filepath#Match) rules. For example:

``<src>`` にはワイルドカードを含めることができます。
その場合、マッチング処理は Go 言語の `filepath.Match <http://golang.org/pkg/path/filepath#Match>`_ ルールに従って行われます。
記述例は以下のとおりです。

.. code-block:: dockerfile

   ADD hom* /mydir/        # "hom" で始まる全てのファイルを追加
   ADD hom?.txt /mydir/    # ? は１文字だけ一致します。例： "home.txt"

.. The `<dest>` is an absolute path, or a path relative to `WORKDIR`, into which
   the source will be copied inside the destination container.

``<dest>`` は絶対パスか、あるいは ``WORKDIR`` からの相対パスにより指定します。
対象としているコンテナ内において、そのパスに対してソースがコピーされます。

.. code-block:: dockerfile

   ADD test relativeDir/          # "test" を `WORKDIR`/relativeDir/ （相対ディレクトリ）に追加
   ADD test /absoluteDir/          # "test" を /absoluteDir/ （絶対ディレクトリ）に追加

.. When adding files or directories that contain special characters (such as `[`
   and `]`), you need to escape those paths following the Golang rules to prevent
   them from being treated as a matching pattern. For example, to add a file
   named `arr[0].txt`, use the following;

ファイルやディレクトリを追加する際に、その名前の中に（ ``[`` や ``]`` のような）特殊な文字が含まれている場合は、Go 言語のルールに従ってパス名をエスケープする必要があります。
これはパターン・マッチングとして扱われないようにするものです。
たとえば ``arr[0].txt`` というファイルを追加する場合は、以下のようにします。

   ..  ADD arr[[]0].txt /mydir/    # copy a file named "arr[0].txt" to /mydir/

.. code-block:: dockerfile

   ADD arr[[]0].txt /mydir/    # "arr[0].txt" というファイルを /mydir/ へコピー

.. All new files and directories are created with a UID and GID of 0.

ADD されるファイルやディレクトリの UID と GID は、すべて 0 として生成されます。

.. In the case where `<src>` is a remote file URL, the destination will
   have permissions of 600. If the remote file being retrieved has an HTTP
   `Last-Modified` header, the timestamp from that header will be used
   to set the `mtime` on the destination file. However, like any other file
   processed during an `ADD`, `mtime` will not be included in the determination
   of whether or not the file has changed and the cache should be updated.

``<src>`` にリモートファイル URL が指定された場合、コピー先のパーミッションは 600 となります。
リモートファイルの取得時に HTTP の ``Last-Modified`` ヘッダが含まれている場合は、ヘッダに書かれたタイムスタンプを利用して、コピー先ファイルの ``mtime`` を設定します。
ただし ``ADD`` によって処理されるファイルが何であっても、ファイルが変更されたかどうか、そしてキャッシュを更新するべきかどうかは ``mtime`` によって判断されるわけではありません。

.. > **Note**:
   > If you build by passing a `Dockerfile` through STDIN (`docker
   > build - < somefile`), there is no build context, so the `Dockerfile`
   > can only contain a URL based `ADD` instruction. You can also pass a
   > compressed archive through STDIN: (`docker build - < archive.tar.gz`),
   > the `Dockerfile` at the root of the archive and the rest of the
   > archive will be used as the context of the build.

.. note::

   ``Dockerfile`` を標準入力から生成する場合（ ``docker build - < somefile`` ）は、ビルド・コンテキストが存在していないことになるので、``ADD`` 命令には URL の指定しか利用できません。
   また標準入力から圧縮アーカイブを入力する場合（ ``docker build - < archive.tar.gz`` ）は、そのアーカイブのルートにある ``Dockerfile`` と、アーカイブ内のファイルすべてが、ビルド時のコンテキストとなります。

.. > **Note**:
   > If your URL files are protected using authentication, you
   > will need to use `RUN wget`, `RUN curl` or use another tool from
   > within the container as the `ADD` instruction does not support
   > authentication.

.. note::

   URL ファイルが認証によって保護されている場合は、``RUN wget`` や ``RUN curl`` あるいは同様のツールをコンテナ内から利用する必要があります。``ADD`` 命令は認証処理をサポートしていません。

.. > **Note**:
   > The first encountered `ADD` instruction will invalidate the cache for all
   > following instructions from the Dockerfile if the contents of `<src>` have
   > changed. This includes invalidating the cache for `RUN` instructions.
   > See the [`Dockerfile` Best Practices
   guide](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/#/build-cache) for more information.

.. note::

   ``ADD`` 命令の ``<src>`` の内容が変更されていた場合、その ``ADD`` 命令以降に続く命令のキャッシュはすべて無効化されます。
   そこには ``RUN`` 命令に対するキャッシュの無効化も含まれます。
   詳しくは ``Dockerfile`` の :ref:`ベスト・プラクティス・ガイド <build-cache>` を参照してください。

.. ADD obeys the following rules:

``ADD`` は以下のルールに従います。

.. - The `<src>` path must be inside the *context* of the build;
     you cannot `ADD ../something /something`, because the first step of a
     `docker build` is to send the context directory (and subdirectories) to the
     docker daemon.

* ``<src>`` のパス指定は、ビルド **コンテキスト** 内でなければならないため、たとえば ``ADD ../something /something`` といったことはできません。
  ``docker build`` の最初の処理ステップでは、コンテキスト・ディレクトリ（およびそのサブディレクトリ）を Docker デーモンに送信するところから始まるためです。

.. - If `<src>` is a URL and `<dest>` does not end with a trailing slash, then a
     file is downloaded from the URL and copied to `<dest>`.

* ``<src>`` が URL 指定であって ``<dest>`` の最後にスラッシュが指定されていない場合、そのファイルを URL よりダウンロードして ``<dest>`` にコピーします。

.. - If `<src>` is a URL and `<dest>` does end with a trailing slash, then the
     filename is inferred from the URL and the file is downloaded to
     `<dest>/<filename>`. For instance, `ADD http://example.com/foobar /` would
     create the file `/foobar`. The URL must have a nontrivial path so that an
     appropriate filename can be discovered in this case (`http://example.com`
     will not work).

* ``<src>`` が URL 指定であって ``<dest>`` の最後にスラッシュが指定された場合、ファイルが指定されたものとして扱われ、URL からダウンロードして ``<dest>/<filename>`` にコピーします。
  たとえば ``ADD http://example.com/foobar /`` という記述は ``/foobar`` というファイルを作ることになります。
  URL には正確なパス指定が必要です。
  上の記述であれば、適切なファイルが見つけ出されます。
  （ ``http://example.com`` では正しく動作しません。）

.. - If `<src>` is a directory, the entire contents of the directory are copied,
     including filesystem metadata.

* ``<src>`` がディレクトリである場合、そのディレクトリ内の内容がすべてコピーされます。
  ファイルシステムのメタデータも含まれます。

  .. > **Note**:
     > The directory itself is not copied, just its contents.

  .. note::

      ディレクトリそのものはコピーされません。
      コピーされるのはその中身です。

.. - If `<src>` is a *local* tar archive in a recognized compression format
     (identity, gzip, bzip2 or xz) then it is unpacked as a directory. Resources
     from *remote* URLs are **not** decompressed. When a directory is copied or
     unpacked, it has the same behavior as `tar -x`, the result is the union of:

* ``<src>`` が **ローカル** にある tar アーカイブであって、認識できるフォーマット（gzip、bzip2、xz）である場合、1 つのディレクトリ配下に展開されます。
  **リモート** URL の場合は展開 **されません** 。
  ディレクトリのコピーあるいは展開の仕方は ``tar -x`` と同等です。
  つまりその結果は以下の 2 つのいずれかに従います。

  ..  1. Whatever existed at the destination path and
      2. The contents of the source tree, with conflicts resolved in favor
         of "2." on a file-by-file basis.

  1. コピー先に指定されていれば、それが存在しているかどうかに関わらず。あるいは、
  2. ソース・ツリーの内容に従って各ファイルごとに行う。衝突が発生した場合は 2. を優先する。

  .. > **Note**:
     > Whether a file is identified as a recognized compression format or not
     > is done solely based on the contents of the file, not the name of the file.
     > For example, if an empty file happens to end with `.tar.gz` this will not
     > be recognized as a compressed file and **will not** generate any kind of
     > decompression error message, rather the file will simply be copied to the
     > destination.

  .. note::

     圧縮されたファイルが認識可能なフォーマットであるかどうかは、そのファイル内容に基づいて確認されます。
     名前によって判断されるわけではありません。
     たとえば、空のファイルの名前の末尾がたまたま ``.tar.gz`` となっていた場合、圧縮ファイルとして認識されないため、解凍に失敗したといったエラーメッセージは一切 **出ることはなく** 、このファイルはコピー先に向けて単純にコピーされるだけです。

.. - If `<src>` is any other kind of file, it is copied individually along with
     its metadata. In this case, if `<dest>` ends with a trailing slash `/`, it
     will be considered a directory and the contents of `<src>` will be written
     at `<dest>/base(<src>)`.

* ``<src>`` が上に示す以外のファイルであった場合、メタデータも含めて個々にコピーされます。
  このとき ``<dest>`` が ``/`` で終わっていたらディレクトリとみなされるので、``<src>`` の内容は ``<dest>/base(<src>)`` に書き込まれることになります。

.. - If multiple `<src>` resources are specified, either directly or due to the
     use of a wildcard, then `<dest>` must be a directory, and it must end with
     a slash `/`.

* 複数の ``<src>`` が直接指定された場合、あるいはワイルドカードを用いて指定された場合、``<dest>`` はディレクトリとする必要があり、末尾には ``/`` をつけなければなりません。

.. - If `<dest>` does not end with a trailing slash, it will be considered a
     regular file and the contents of `<src>` will be written at `<dest>`.

* ``<dest>`` の末尾にスラッシュがなかった場合、通常のファイルとみなされるため、``<src>`` の内容は ``<dest>`` に書き込まれることになります。

.. - If `<dest>` doesn't exist, it is created along with all missing directories
     in its path.

* ``<dest>`` のパス内のディレクトリが存在しなかった場合、すべて生成されます。

.. _copy:

COPY
==========

.. COPY has two forms:

COPY は２つの形式があります。

.. - `COPY <src>... <dest>`
   - `COPY ["<src>",... "<dest>"]` (this form is required for paths containing
   whitespace)

* ``COPY <src>... <dest>``
* ``COPY ["<src>",... "<dest>"]`` （パスにホワイトスペースを含む場合にこの書式が必要）

.. The `COPY` instruction copies new files or directories from `<src>`
   and adds them to the filesystem of the container at the path `<dest>`.

``COPY`` 命令は ``<src>`` からファイルやディレクトリを新たにコピーして、コンテナ内のファイルシステムのパス ``<dest>`` に追加します。

.. Multiple `<src>` resource may be specified but they must be relative
   to the source directory that is being built (the context of the build).

``<src>`` には複数のソースを指定することが可能です。
ソースとしてファイルあるいはディレクトリが指定されている場合、そのパスは生成されたソース・ディレクトリ（ビルド・コンテキスト）からの相対パスでなければなりません。

.. Each `<src>` may contain wildcards and matching will be done using Go's
   [filepath.Match](http://golang.org/pkg/path/filepath#Match) rules. For example:

``<src>`` にはワイルドカードを含めることができます。
その場合、マッチング処理は Go 言語の `filepath.Match <http://golang.org/pkg/path/filepath#Match>`_ ルールに従って行われます。
記述例は以下のとおりです。

.. code-block:: dockerfile

   COPY hom* /mydir/        # "hom" で始まる全てのファイルを追加
   COPY hom?.txt /mydir/    # ? は１文字だけ一致します。例： "home.txt"

.. The `<dest>` is an absolute path, or a path relative to `WORKDIR`, into which
   the source will be copied inside the destination container.

``<dest>`` は絶対パスか、あるいは ``WORKDIR`` からの相対パスにより指定します。
対象としているコンテナ内において、そのパスに対してソースがコピーされます。

.. code-block:: dockerfile

   COPY test relativeDir/   # "test" を `WORKDIR`/relativeDir/ （相対ディレクトリ）に追加
   COPY test /absoluteDir/   # "test" を /absoluteDir/ （絶対ディレクトリ）に追加

.. When copying files or directories that contain special characters (such as `[`
   and `]`), you need to escape those paths following the Golang rules to prevent
   them from being treated as a matching pattern. For example, to copy a file
   named `arr[0].txt`, use the following;

ファイルやディレクトリを追加する際に、その名前の中に（ ``[`` や ``]`` のような）特殊な文字が含まれている場合は、Go 言語のルールに従ってパス名をエスケープする必要があります。
これはパターン・マッチングとして扱われないようにするものです。
たとえば ``arr[0].txt`` というファイルを追加する場合は、以下のようにします。

   .. COPY arr[[]0].txt /mydir/    # copy a file named "arr[0].txt" to /mydir/

.. code-block:: dockerfile

   COPY arr[[]0].txt /mydir/    # "arr[0].txt" というファイルを /mydir/ へコピー

.. All new files and directories are created with a UID and GID of 0.

コピーされるファイルやディレクトリの UID と GID は、すべて 0 として生成されます。

.. > **Note**:
   > If you build using STDIN (`docker build - < somefile`), there is no
   > build context, so `COPY` can't be used.

.. note::

  ``Dockerfile`` を標準入力から生成する場合（ ``docker build - < somefile`` ）は、ビルド・コンテキストが存在していないことになるので、``COPY`` 命令は利用することができません。

.. Optionally `COPY` accepts a flag `--from=<name|index>` that can be used to set
   the source location to a previous build stage (created with `FROM .. AS <name>`)
   that will be used instead of a build context sent by the user. The flag also 
   accepts a numeric index assigned for all previous build stages started with 
   `FROM` instruction. In case a build stage with a specified name can't be found an 
   image with the same name is attempted to be used instead.

オプションとして ``COPY`` にはフラグ ``--from=<name|index>`` があります。
これは実行済のビルド・ステージ（ ``FROM .. AS <name>`` により生成）におけるソース・ディレクトリを設定するものです。
これがあると、ユーザーが指定したビルド・コンテキストのかわりに、設定されたディレクトリが用いられます。
このフラグは数値インデックスを指定することも可能です。
この数値インデックスは、``FROM`` 命令から始まる実行済のビルド・ステージすべてに割り当てられている値です。
指定されたビルド・ステージがその名前では見つけられなかった場合、指定された数値によって見つけ出します。

.. COPY obeys the following rules:

``COPY`` は以下のルールに従います。

.. - The `<src>` path must be inside the *context* of the build;
     you cannot `COPY ../something /something`, because the first step of a
     `docker build` is to send the context directory (and subdirectories) to the
     docker daemon.

* ``<src>`` のパス指定は、ビルド **コンテキスト** 内でなければならないため、たとえば ``COPY ../something /something`` といったことはできません。
  ``docker build`` の最初の処理ステップでは、コンテキスト・ディレクトリ（およびそのサブディレクトリ）を Docker デーモンに送信するところから始まるためです。

.. - If `<src>` is a directory, the entire contents of the directory are copied,
     including filesystem metadata.

* ``<src>`` がディレクトリである場合、そのディレクトリ内の内容がすべてコピーされます。
  ファイルシステムのメタデータも含まれます。

  .. > **Note**:
     > The directory itself is not copied, just its contents.

  .. note::

     ディレクトリそのものはコピーされません。
     コピーされるのはその中身です。

.. - If `<src>` is any other kind of file, it is copied individually along with
     its metadata. In this case, if `<dest>` ends with a trailing slash `/`, it
     will be considered a directory and the contents of `<src>` will be written
     at `<dest>/base(<src>)`.

* ``<src>`` が上に示す以外のファイルであった場合、メタデータも含めて個々にコピーされます。
  このとき ``<dest>`` が ``/`` で終わっていたらディレクトリとみなされるので、``<src>`` の内容は ``<dest>/base(<src>)`` に書き込まれることになります。

.. - If multiple `<src>` resources are specified, either directly or due to the
     use of a wildcard, then `<dest>` must be a directory, and it must end with
     a slash `/`.

* 複数の ``<src>`` が直接指定された場合、あるいはワイルドカードを用いて指定された場合、``<dest>`` はディレクトリとする必要があり、末尾には ``/`` をつけなければなりません。

.. - If `<dest>` does not end with a trailing slash, it will be considered a
     regular file and the contents of `<src>` will be written at `<dest>`.

* ``<dest>`` の末尾にスラッシュがなかった場合、通常のファイルとみなされるため、``<src>`` の内容が ``<dest>`` に書き込まれます。

.. - If `<dest>` doesn't exist, it is created along with all missing directories
     in its path.

* ``<dest>`` のパス内のディレクトリが存在しなかった場合、すべて生成されます。

.. _entrypoint:

ENTRYPOINT
==========

.. ENTRYPOINT has two forms:

ENTRYPOINT には２つの形式があります。

.. - `ENTRYPOINT ["executable", "param1", "param2"]`
     (*exec* form, preferred)
   - `ENTRYPOINT command param1 param2`
     (*shell* form)

* ``ENTRYPOINT ["executable", "param1", "param2"]`` （exec 形式、推奨）
* ``ENTRYPOINT command param1 param2`` （シェル形式）

.. An `ENTRYPOINT` allows you to configure a container that will run as an executable.

``ENTRYPOINT`` は、コンテナを実行モジュールのようにして実行する設定を行ないます。

.. For example, the following will start nginx with its default content, listening
   on port 80:

たとえば以下の例では、nginx をデフォルト設定で起動します。
ポートは 80 番を利用します。

.. code-block:: bash

    docker run -i -t --rm -p 80:80 nginx

.. Command line arguments to `docker run <image>` will be appended after all
   elements in an *exec* form `ENTRYPOINT`, and will override all elements specified
   using `CMD`.
   This allows arguments to be passed to the entry point, i.e., `docker run <image> -d`
   will pass the `-d` argument to the entry point.
   You can override the `ENTRYPOINT` instruction using the `docker run --entrypoint`
   flag.

``docker run <image>`` に対するコマンドライン引数は、exec 形式の ``ENTRYPOINT`` の指定要素の後に付け加えられます。
そして ``CMD`` において指定された引数は上書きされます。
これはつまり、引数をエントリーポイントに受け渡すことができるということです。
たとえば ``docker run <image> -d`` としたときの ``-d`` は、引数としてエントリーポイントに渡されます。
``docker run --entrypoint`` を利用すれば ``ENTRYPOINT`` の内容を上書きすることができます。

.. The *shell* form prevents any `CMD` or `run` command line arguments from being
   used, but has the disadvantage that your `ENTRYPOINT` will be started as a
   subcommand of `/bin/sh -c`, which does not pass signals.
   This means that the executable will not be the container's `PID 1` - and
   will _not_ receive Unix signals - so your executable will not receive a
   `SIGTERM` from `docker stop <container>`.

シェル形式では ``CMD`` や ``run`` のコマンドライン引数は受け付けずに処理を行います。
ただし ``ENTRYPOINT`` は ``/bin/sh -c`` のサブコマンドとして起動されるので、シグナルを送信しません。
これはつまり、実行モジュールがコンテナの ``PID 1`` にはならず、Unix のシグナルを受信しないということです。
したがって ``docker stop <container>`` が実行されても、その実行モジュールは ``SIGTERM`` を受信しないことになります。

.. Only the last `ENTRYPOINT` instruction in the `Dockerfile` will have an effect.

``ENTRYPOINT`` 命令は複数記述されていても、最後の命令しか処理されません。

.. Exec form ENTRYPOINT example

exec 形式の ENTRYPOINT 例
------------------------------

.. You can use the *exec* form of `ENTRYPOINT` to set fairly stable default commands
   and arguments and then use either form of `CMD` to set additional defaults that
   are more likely to be changed.

``ENTRYPOINT`` の exec 形式は、デフォルト実行するコマンドおよび引数として、ほぼ変わることがないものを設定します。
そして ``CMD`` 命令の 2 つある書式のいずれでもよいので、変更が必要になりそうな内容を追加で設定します。

.. code-block:: dockerfile

   FROM ubuntu
   ENTRYPOINT ["top", "-b"]
   CMD ["-c"]

.. When you run the container, you can see that `top` is the only process:

コンテナを実行すると、ただ 1 つのプロセスとして ``top`` があるのがわかります。

.. code-block:: bash

   $ docker run -it --rm --name test  top -H
   top - 08:25:00 up  7:27,  0 users,  load average: 0.00, 0.01, 0.05
   Threads:   1 total,   1 running,   0 sleeping,   0 stopped,   0 zombie
   %Cpu(s):  0.1 us,  0.1 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
   KiB Mem:   2056668 total,  1616832 used,   439836 free,    99352 buffers
   KiB Swap:  1441840 total,        0 used,  1441840 free.  1324440 cached Mem
   
     PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
       1 root      20   0   19744   2336   2080 R  0.0  0.1   0:00.04 top

.. To examine the result further, you can use `docker exec`:

さらに詳しく見るには ``docker exec`` を実行します。

.. code-block:: bash

   $ docker exec -it test ps aux
   USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
   root         1  2.6  0.1  19752  2352 ?        Ss+  08:24   0:00 top -b -H
   root         7  0.0  0.1  15572  2164 ?        R+   08:25   0:00 ps aux

.. And you can gracefully request `top` to shut down using `docker stop test`.

``top`` を適切に終了させるには ``docker stop test`` を実行します。

.. The following `Dockerfile` shows using the `ENTRYPOINT` to run Apache in the
   foreground (i.e., as `PID 1`):

次の ``Dockerfile`` は、Apache をフォアグラウンドで（つまり ``PID 1`` として）実行するような ``ENTRYPOINT`` の例を示しています。

.. code-block:: dockerfile

   FROM debian:stable
   RUN apt-get update && apt-get install -y --force-yes apache2
   EXPOSE 80 443
   VOLUME ["/var/www", "/var/log/apache2", "/etc/apache2"]
   ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

.. If you need to write a starter script for a single executable, you can ensure that
   the final executable receives the Unix signals by using `exec` and `gosu`
   commands:

1 つの実行モジュールを起動するスクリプトを書く場合、最終実行される実行モジュールが Unix シグナルを受信できるようにするには ``exec`` あるいは ``gosu`` を用います。

.. code-block:: bash

   #!/bin/bash
   set -e
   
   if [ "$1" = 'postgres' ]; then
       chown -R postgres "$PGDATA"
   
       if [ -z "$(ls -A "$PGDATA")" ]; then
           gosu postgres initdb
       fi
   
       exec gosu postgres "$@"
   fi
   
   exec "$@"

.. Lastly, if you need to do some extra cleanup (or communicate with other containers)
   on shutdown, or are co-ordinating more than one executable, you may need to ensure
   that the `ENTRYPOINT` script receives the Unix signals, passes them on, and then
   does some more work:

シャットダウンの際に追加でクリーンアップするようなコマンドを実行したい（他のコンテナとの通信を行ないたい）場合、あるいは複数の実行モジュールを連動して動かしている場合は、``ENTRYPOINT`` のスクリプトが確実に Unix シグナルを受信し、これを受けて動作するようにすることが必要になるかもしれません。

.. code-block:: bash

   #!/bin/sh
   # メモ: ここで sh を用いました。したがって busybox コンテナーでも動作します。
   
   # ここで trap を用います。サービスが停止した後に手動でクリーンアップする
   # コマンドを実行するにはこれも必要となります。
   # こうしておかないと、1 つのコンテナーで複数サービスを起動しなければなりません。
   trap "echo TRAPed signal" HUP INT QUIT TERM
   
   # ここからバックグラウンドでサービスを開始します
   /usr/sbin/apachectl start
   
   echo "[hit enter key to exit] or run 'docker stop <container>'"
   read
   
   # ここでサービスを停止しクリーンアップします。
   echo "stopping apache"
   /usr/sbin/apachectl stop
   
   echo "exited $0"

.. If you run this image with `docker run -it --rm -p 80:80 --name test apache`,
   you can then examine the container's processes with `docker exec`, or `docker top`,
   and then ask the script to stop Apache:

このイメージを ``docker run -it --rm -p 80:80 --name test apache`` により実行したら、このコンテナのプロセスは ``docker exec`` や ``docker top`` を使って確認することができます。
そしてこのスクリプトから Apache を停止させます。

.. code-block:: bash

   $ docker exec -it test ps aux
   USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
   root         1  0.1  0.0   4448   692 ?        Ss+  00:42   0:00 /bin/sh /run.sh 123 cmd cmd2
   root        19  0.0  0.2  71304  4440 ?        Ss   00:42   0:00 /usr/sbin/apache2 -k start
   www-data    20  0.2  0.2 360468  6004 ?        Sl   00:42   0:00 /usr/sbin/apache2 -k start
   www-data    21  0.2  0.2 360468  6000 ?        Sl   00:42   0:00 /usr/sbin/apache2 -k start
   root        81  0.0  0.1  15572  2140 ?        R+   00:44   0:00 ps aux
   $ docker top test
   PID                 USER                COMMAND
   10035               root                {run.sh} /bin/sh /run.sh 123 cmd cmd2
   10054               root                /usr/sbin/apache2 -k start
   10055               33                  /usr/sbin/apache2 -k start
   10056               33                  /usr/sbin/apache2 -k start
   $ /usr/bin/time docker stop test
   test
   real	0m 0.27s
   user	0m 0.03s
   sys	0m 0.03s

.. > **Note:** you can override the `ENTRYPOINT` setting using `--entrypoint`,
   > but this can only set the binary to *exec* (no `sh -c` will be used).

.. note::

   ``--entrypoint`` を使うと ``ENTRYPOINT`` の設定を上書きすることができます。
   ただしこの場合は、実行モジュールを exec 形式にできるだけです。
   （``sh -c`` は利用されません。）

.. > **Note**:
   > The *exec* form is parsed as a JSON array, which means that
   > you must use double-quotes (") around words not single-quotes (').

.. note::

   exec 形式は JSON 配列として解釈されます。
   したがって文字列をくくるのはダブルクォート（"）であり、シングルクォート（'）は用いてはなりません。

.. > **Note**:
   > Unlike the *shell* form, the *exec* form does not invoke a command shell.
   > This means that normal shell processing does not happen. For example,
   > `ENTRYPOINT [ "echo", "$HOME" ]` will not do variable substitution on `$HOME`.
   > If you want shell processing then either use the *shell* form or execute
   > a shell directly, for example: `ENTRYPOINT [ "sh", "-c", "echo $HOME" ]`.
   > When using the exec form and executing a shell directly, as in the case for
   > the shell form, it is the shell that is doing the environment variable
   > expansion, not docker.

.. note::

   シェル形式とは違って exec 形式はコマンドシェルを起動しません。
   これはつまり、ごく普通のシェル処理とはならないということです。
   たとえば ``ENTRYPOINT [ "echo", "$HOME" ]`` を実行したとすると、`$HOME` の変数置換は行われません。
   シェル処理が行われるようにしたければ、シェル形式を利用するか、あるいはシェルを直接実行するようにします。
   たとえば ``ENTRYPOINT [ "sh", "-c", "echo $HOME" ]`` とします。
   exec 形式によってシェルを直接起動した場合、シェル形式の場合でも同じですが、変数置換を行うのはシェルであって、docker ではありません。

.. Shell form ENTRYPOINT example

シェル形式の ENTRYPOINT 例
------------------------------

.. You can specify a plain string for the `ENTRYPOINT` and it will execute in `/bin/sh -c`.
   This form will use shell processing to substitute shell environment variables,
   and will ignore any `CMD` or `docker run` command line arguments.
   To ensure that `docker stop` will signal any long running `ENTRYPOINT` executable
   correctly, you need to remember to start it with `exec`:

``ENTRYPOINT`` に指定した文字列は、そのまま ``/bin/sh -c`` の中で実行されます。
この形式は、シェル環境変数を置換しながらシェル処理を実行します。
そして ``CMD`` や ``docker run`` におけるコマンドライン引数は無視します。
``ENTRYPOINT`` による実行モジュールがどれだけ実行し続けていても、確実に ``docker stop`` によりシグナル送信ができるようにするためには、忘れずに ``exec`` をつけて実行する必要があります。

.. code-block:: dockerfile

   FROM ubuntu
   ENTRYPOINT exec top -b

.. When you run this image, you'll see the single `PID 1` process:

上のイメージを実行すると、``PID 1`` のプロセスがただ 1 つだけあるのがわかります。

.. code-block:: bash

   $ docker run -it --rm --name test top
   Mem: 1704520K used, 352148K free, 0K shrd, 0K buff, 140368121167873K cached
   CPU:   5% usr   0% sys   0% nic  94% idle   0% io   0% irq   0% sirq
   Load average: 0.08 0.03 0.05 2/98 6
     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
       1     0 root     R     3164   0%   0% top -b

.. Which will exit cleanly on `docker stop`:

きれいに終了させるには ``docker stop`` を実行します。

   ..  $ /usr/bin/time docker stop test
       test
       real	0m 0.20s
       user	0m 0.02s
       sys	0m 0.04s

.. code-block:: bash

   $ /usr/bin/time docker stop test
   test
   real	0m 0.20s
   user	0m 0.02s
   sys	0m 0.04s

.. If you forget to add `exec` to the beginning of your `ENTRYPOINT`:

仮に ``ENTRYPOINT`` の先頭に ``exec`` を記述し忘れたとします。

.. code-block:: dockerfile

   FROM ubuntu
   ENTRYPOINT top -b
   CMD --ignored-param1

.. You can then run it (giving it a name for the next step):

そして以下のように実行したとします。
（名前をつけておいて次のステップで使います。）

.. code-block:: bash

   $ docker run -it --name test top --ignored-param2
   Mem: 1704184K used, 352484K free, 0K shrd, 0K buff, 140621524238337K cached
   CPU:   9% usr   2% sys   0% nic  88% idle   0% io   0% irq   0% sirq
   Load average: 0.01 0.02 0.05 2/101 7
     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
       1     0 root     S     3168   0%   0% /bin/sh -c top -b cmd cmd2
       7     1 root     R     3164   0%   0% top -b

.. You can see from the output of `top` that the specified `ENTRYPOINT` is not `PID 1`.

``ENTRYPOINT`` によって指定された ``top`` の出力は ``PID 1`` ではないことがわかります。

.. If you then run `docker stop test`, the container will not exit cleanly - the
   `stop` command will be forced to send a `SIGKILL` after the timeout:

この後に ``docker stop test`` を実行しても、コンテナはきれいに終了しません。
``stop`` コマンドは、タイムアウトの後に強制的に ``SIGKILL`` を送信することになるからです。

   ..  $ docker exec -it test ps aux
       PID   USER     COMMAND
           1 root     /bin/sh -c top -b cmd cmd2
           7 root     top -b
           8 root     ps aux
       $ /usr/bin/time docker stop test
       test
       real	0m 10.19s
       user	0m 0.04s
       sys	0m 0.03s

.. code-block:: bash

   $ docker exec -it test ps aux
   PID   USER     COMMAND
       1 root     /bin/sh -c top -b cmd cmd2
       7 root     top -b
       8 root     ps aux
   $ /usr/bin/time docker stop test
   test
   real	0m 10.19s
   user	0m 0.04s
   sys	0m 0.03s

.. ### Understand how CMD and ENTRYPOINT interact

.. _understand-how-cmd-and-entrypoint-interact:

CMD と ENTRYPOINT の関連について
==================================================

.. Both `CMD` and `ENTRYPOINT` instructions define what command gets executed when running a container.
   There are few rules that describe their co-operation.

``CMD`` 命令も ``ENTRYPOINT`` 命令も、ともにコンテナ起動時に実行するコマンドを定義するものです。
両方が動作する際に必要となるルールがいくらかあります。

.. 1. Dockerfile should specify at least one of `CMD` or `ENTRYPOINT` commands.

1. Dockerfile には、``CMD`` または ``ENTRYPOINT`` のいずれかが、少なくとも 1 つ必要です。

.. 2. `ENTRYPOINT` should be defined when using the container as an executable.

2. ``ENTRYPOINT`` は、コンテナを実行モジュールとして実行する際に利用します。

.. 3. `CMD` should be used as a way of defining default arguments for an `ENTRYPOINT` command
   or for executing an ad-hoc command in a container.

3. ``CMD`` は、``ENTRYPOINT`` のデフォルト引数を定義するため、あるいはその時点でのみコマンド実行を行うために利用します。

.. 4. `CMD` will be overridden when running the container with alternative arguments.

4. ``CMD`` はコンテナ実行時に、別の引数によって上書きされることがあります。

.. The table below shows what command is executed for different `ENTRYPOINT` / `CMD` combinations:

以下の表は、``ENTRYPOINT`` と ``CMD`` の組み合わせに従って実行されるコマンドを示しています。

.. list-table::
   :header-rows: 1
   
   * - 
     - ENTRYPOINT なし
     - ENTRYPOINT exec_entry p1_entry
     - ENTRYPOINT [“exec_entry”, “p1_entry”]
   * - **CMD なし**
     - エラー。実行できない。
     - /bin/sh -c exec_entry p1_entry
     - exec_entry p1_entry
   * - **CMD [“exec_cmd”, “p1_cmd”]**
     - exec_cmd p1_cmd
     - /bin/sh -c exec_entry p1_entry exec_cmd p1_cmd
     - exec_entry p1_entry exec_cmd p1_cmd
   * - **CMD [“p1_cmd”, “p2_cmd”]**
     - p1_cmd p2_cmd
     - /bin/sh -c exec_entry p1_entry p1_cmd p2_cmd
     - exec_entry p1_entry p1_cmd p2_cmd
   * - **CMD exec_cmd p1_cmd**
     - /bin/sh -c exec_cmd p1_cmd
     - /bin/sh -c exec_entry p1_entry /bin/sh -c exec_cmd p1_cmd
     - exec_entry p1_entry /bin/sh -c exec_cmd p1_cmd

.. _volume:

VOLUME
==========

.. code-block:: dockerfile

   VOLUME ["/data"]

.. The `VOLUME` instruction creates a mount point with the specified name
   and marks it as holding externally mounted volumes from native host or other
   containers. The value can be a JSON array, `VOLUME ["/var/log/"]`, or a plain
   string with multiple arguments, such as `VOLUME /var/log` or `VOLUME /var/log
   /var/db`. For more information/examples and mounting instructions via the
   Docker client, refer to
   [*Share Directories via Volumes*](https://docs.docker.com/engine/tutorials/dockervolumes/#/mount-a-host-directory-as-a-data-volume)
   documentation.

``VOLUME`` 命令は指定された名前を使ってマウントポイントを生成します。
そして自ホストまたは他のコンテナからマウントされたボリュームとして、そのマウントポイントを扱います。
指定する値は JSON 配列として ``VOLUME ["/var/log/"]`` のようにするか、あるいは単純な文字列を複数与えます。
たとえば ``VOLUME /var/log`` や ``VOLUME /var/log /var/db`` などです。
Docker クライアントを通じたマウントに関する情報、利用例などに関しては :ref:`ボリュームを通じたディレクトリの共有 <mount-a-host-directory-as-a-data-volume>` を参照してください。

.. The `docker run` command initializes the newly created volume with any data
   that exists at the specified location within the base image. For example,
   consider the following Dockerfile snippet:

``docker run`` コマンドは、新たに生成するボリュームを初期化します。
ベースイメージ内の指定したディレクトリに、データが存在していても構いません。
たとえば以下のような Dockerfile の記述部分があったとします。

.. code-block:: dockerfile

   FROM ubuntu
   RUN mkdir /myvol
   RUN echo "hello world" > /myvol/greeting
   VOLUME /myvol

.. This Dockerfile results in an image that causes `docker run`, to
   create a new mount point at `/myvol` and copy the  `greeting` file
   into the newly created volume.

この Dockerfile はイメージに対する処理として、``docker run`` により ``/myvol`` というマウントポイントを新たに生成し、そのボリュームの中に ``greeting`` ファイルをコピーします。

.. ### Notes about specifying volumes

.. _notes-about-specifying-volumes:

ボリュームの指定に関して
-------------------------

.. Keep the following things in mind about volumes in the `Dockerfile`.

``Dockerfile`` におけるボリューム設定に関しては、以下のことを覚えておいてください。

.. - **Volumes on Windows-based containers**: When using Windows-based containers,
     the destination of a volume inside the container must be one of:

* **Windows ベースのコンテナでのボリューム**: Windows ベースのコンテナを利用しているときは、コンテナ内部のボリューム先は、以下のいずれかでなければなりません。

  .. - a non-existing or empty directory
     - a drive other than `C:`

  * 存在していないディレクトリ、または空のディレクトリ
  * ``C:`` 以下のドライブ

.. - **Changing the volume from within the Dockerfile**: If any build steps change the
     data within the volume after it has been declared, those changes will be discarded.

* **Dockerfile 内からのボリューム変更**: ボリュームを宣言した後に、そのボリューム内のデータを変更する処理があったとしても、そのような変更は無視され処理されません。

.. - **JSON formatting**: The list is parsed as a JSON array.
     You must enclose words with double quotes (`"`)rather than single quotes (`'`).

* **JSON 形式**: 引数リストは JSON 配列として扱われます。
  したがって文字列をくくるのはダブルクォート（``"``）であり、シングルクォート（``'``）は用いてはなりません。

.. - **The host directory is declared at container run-time**: The host directory
     (the mountpoint) is, by its nature, host-dependent. This is to preserve image
     portability. since a given host directory can't be guaranteed to be available
     on all hosts.For this reason, you can't mount a host directory from
     within the Dockerfile. The `VOLUME` instruction does not support specifying a `host-dir`
     parameter.  You must specify the mountpoint when you create or run the container.

* **コンテナ実行時に宣言されるホストディレクトリ**: ホストディレクトリ（マウントポイント）は、その性質からして、ホストに依存するものです。
  これはイメージの可搬性を確保するためなので、設定されたホストディレクトリが、あらゆるホスト上にて利用可能になるかどうかの保証はありません。
  このため、Dockerfile の内部からホストディレクトリをマウントすることはできません。
  つまり ``VOLUME`` 命令は ``host-dir`` （ホストのディレクトリを指定する）パラメータをサポートしていません。
  マウントポイントの指定は、コンテナを生成、実行するときに行う必要があります。

.. _user:

USER
==========

..     USER <user>[:<group>]
   or
       USER <UID>[:<GID>]

.. code-block:: dockerfile

   USER <user>[:<group>]

または

.. code-block:: dockerfile

   USER <UID>[:<GID>]

.. The `USER` instruction sets the user name (or UID) and optionally the user
   group (or GID) to use when running the image and for any `RUN`, `CMD` and
   `ENTRYPOINT` instructions that follow it in the `Dockerfile`.

``USER`` 命令は、ユーザ名（または UID）と、オプションとしてユーザグループ（または GID）を指定します。
そしてイメージが実行されるとき、``Dockerfile`` 内の後続の ``RUN``、``CMD``、``ENTRYPOINT`` の各命令においてこの情報を利用します。

.. > **Warning**:
   > When the user does doesn't have a primary group then the image (or the next
   > instructions) will be run with the `root` group.

.. warning::

   ユーザにプライマリグループがない場合、イメージ（あるいは次の命令）は ``root`` グループとして実行されます。

.. _workdir:

WORKDIR
==========

.. code-block:: dockerfile

   WORKDIR /path/to/workdir

.. The `WORKDIR` instruction sets the working directory for any `RUN`, `CMD`,
   `ENTRYPOINT`, `COPY` and `ADD` instructions that follow it in the `Dockerfile`.
   If the `WORKDIR` doesn't exist, it will be created even if it's not used in any
   subsequent `Dockerfile` instruction.

``WORKDIR`` 命令はワークディレクトリを設定します。
``Dockerfile`` 内にてその後に続く ``RUN``、``CMD``、``ENTRYPOINT``、``COPY``、``ADD`` の各命令において利用することができます。
``WORKDIR`` が存在しないときは生成されます。
これはたとえ、この後にワークディレクトリが利用されていなくても生成されます。

.. The `WORKDIR` instruction can be used multiple times in a `Dockerfile`. If a
   relative path is provided, it will be relative to the path of the previous
   `WORKDIR` instruction. For example:

``WORKDIR`` 命令は ``Dockerfile`` 内にて複数利用することができます。
ディレクトリ指定に相対パスが用いられた場合、そのパスは、直前の ``WORKDIR`` 命令からの相対パスとなります。
たとえば以下のとおりです。

.. code-block:: dockerfile

   WORKDIR /a
   WORKDIR b
   WORKDIR c
   RUN pwd

.. The output of the final `pwd` command in this `Dockerfile` would be
   `/a/b/c`.

上の ``Dockerfile`` の最後の ``pwd`` コマンドは ``/a/b/c`` という出力結果を返します。

.. The `WORKDIR` instruction can resolve environment variables previously set using
   `ENV`. You can only use environment variables explicitly set in the `Dockerfile`.
   For example:

``WORKDIR`` 命令では、その前に ``ENV`` によって設定された環境変数を解釈します。
環境変数は ``Dockerfile`` の中で明示的に設定したものだけが利用可能です。
たとえば以下のようになります。

.. code-block:: dockerfile

   ENV DIRPATH /path
   WORKDIR $DIRPATH/$DIRNAME
   RUN pwd

.. The output of the final `pwd` command in this `Dockerfile` would be
   `/path/$DIRNAME`

上の ``Dockerfile`` の最後の ``pwd`` コマンドは  ``/path/$DIRNAME`` という出力結果を返します。

.. _arg:

ARG
==========

   ..  ARG <name>[=<default value>]

.. code-block:: dockerfile

   ARG <name>[=<default value>]

.. The `ARG` instruction defines a variable that users can pass at build-time to
   the builder with the `docker build` command using the `--build-arg <varname>=<value>`
   flag. If a user specifies a build argument that was not
   defined in the Dockerfile, the build outputs a warning.

``ARG`` 命令は変数を定義して、ビルド時にその値を受け渡します。
これは ``docker build`` コマンドにおいて ``--build-arg <varname>=<value>`` フラグを利用して行います。
指定したビルド引数（build argument）が Dockerfile 内において定義されていない場合は、ビルド処理時に警告メッセージが出力されます。

.. code-block:: bash

   One or more build-args were not consumed, failing build.

.. A Dockerfile may include one or more `ARG` instructions. For example,
   the following is a valid Dockerfile:

Dockerfile には複数の ``ARG`` 命令を含めることもできます。
たとえば以下の Dockerfile は有効な例です。

.. code-block:: dockerfile

   FROM busybox
   ARG user1
   ARG buildno
   ...

.. > **Warning:** It is not recommended to use build-time variables for
   >  passing secrets like github keys, user credentials etc. Build-time variable
   >  values are visible to any user of the image with the `docker history` command.

.. warning::

   ビルド時の変数として、github キーや認証情報などの秘密の情報を設定することは、お勧めできません。
   ビルド変数の値は、イメージを利用する他人が ``docker history`` コマンドを実行すれば容易に見ることができてしまうからです。

.. ### Default values

.. _default_values:

デフォルト値
-------------

.. An `ARG` instruction can optionally include a default value:

``ARG`` 命令にはオプションとしてデフォルト値を設定することができます。

.. code-block:: dockerfile

   FROM busybox
   ARG user1=someuser
   ARG buildno=1
   ...

.. If an `ARG` instruction has a default value and if there is no value passed
   at build-time, the builder uses the default.

``ARG`` 命令にデフォルト値が設定されていて、ビルド時に値設定が行われなければ、デフォルト値が用いられます。

.. ### Scope

.. _scope:

変数スコープ
-------------

.. An `ARG` variable definition comes into effect from the line on which it is
   defined in the `Dockerfile` not from the argument's use on the command-line or
   elsewhere.  For example, consider this Dockerfile:

``ARG`` による値定義が有効になるのは、``Dockerfile`` 内の記述行以降です。
コマンドラインなどにおいて用いられるときではありません。
たとえば以下のような Dockerfile を見てみます。

.. ```
   1 FROM busybox
   2 USER ${user:-some_user}
   3 ARG user
   4 USER $user
   ...
   ```

.. code-block:: dockerfile
   :linenos:

   FROM busybox
   USER ${user:-some_user}
   ARG user
   USER $user
   ...

.. A user builds this file by calling:

このファイルをビルドするには以下を実行します。

.. code-block:: bash

   $ docker build --build-arg user=what_user Dockerfile

.. The `USER` at line 2 evaluates to `some_user` as the `user` variable is defined on the
   subsequent line 3. The `USER` at line 4 evaluates to `what_user` as `user` is
   defined and the `what_user` value was passed on the command line. Prior to its definition by an
   `ARG` instruction, any use of a variable results in an empty string.

2 行めの ``USER`` が ``some-user`` として評価されます。
これは ``user`` 変数が、直後の 3 行めにおいて定義されているからです。
そして 4 行めの ``USER`` は ``what_user`` として評価されます。
``user`` が定義済であって、コマンドラインから ``what_user`` という値が受け渡されたからです。
``ARG`` 命令による定義を行うまで、その変数を利用しても空の文字列として扱われます。

.. An `ARG` instruction goes out of scope at the end of the build
   stage where it was defined. To use an arg in multiple stages, each stage must
   include the `ARG` instruction.

``ARG`` 命令の変数スコープは、それが定義されたビルドステージが終了するときまでです。
複数のビルドステージにおいて ``ARG`` を利用する場合は、個々に ``ARG`` 命令を指定する必要があります。

.. ```
   FROM busybox
   ARG SETTINGS
   RUN ./run/setup $SETTINGS
   
   FROM busybox
   ARG SETTINGS
   RUN ./run/other $SETTINGS
   ```

.. code-block:: dockerfile

   FROM busybox
   ARG SETTINGS
   RUN ./run/setup $SETTINGS

   FROM busybox
   ARG SETTINGS
   RUN ./run/other $SETTINGS

.. ### Using ARG variables

.. _using-arg-variables:

ARG 変数の利用
---------------

.. You can use an `ARG` or an `ENV` instruction to specify variables that are
   available to the `RUN` instruction. Environment variables defined using the
   `ENV` instruction always override an `ARG` instruction of the same name. Consider
   this Dockerfile with an `ENV` and `ARG` instruction.

``ARG`` 命令や ``ENV`` 命令において変数を指定し、それを ``RUN`` 命令にて用いることができます。
``ENV`` 命令を使って定義された環境変数は、``ARG`` 命令において同名の変数が指定されていたとしても優先されます。
以下のように ``ENV`` 命令と ``ARG`` 命令を含む Dockerfile があるとします。

.. 1 FROM ubuntu
   2 ARG CONT_IMG_VER
   3 ENV CONT_IMG_VER v1.0.0
   4 RUN echo $CONT_IMG_VER

.. code-block:: dockerfile
   :linenos:

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER v1.0.0
   RUN echo $CONT_IMG_VER

.. Then, assume this image is built with this command:

そしてこのイメージを以下のコマンドによりビルドしたとします。

.. code-block:: bash

   $ docker build --build-arg CONT_IMG_VER=v2.0.1 Dockerfile

.. In this case, the `RUN` instruction uses `v1.0.0` instead of the `ARG` setting
   passed by the user:`v2.0.1` This behavior is similar to a shell
   script where a locally scoped variable overrides the variables passed as
   arguments or inherited from environment, from its point of definition.

この例において ``RUN`` 命令は ``v1.0.0`` という値を採用します。
コマンドラインから ``v2.0.1`` が受け渡され ``ARG`` の値に設定されますが、それが用いられるわけではありません。
これはちょうどシェルスクリプトにおいて行われる動きに似ています。
ローカルなスコープを持つ変数は、指定された引数や環境から受け継いだ変数よりも優先されます。

.. Using the example above but a different `ENV` specification you can create more
   useful interactions between `ARG` and `ENV` instructions:

上の例を利用しつつ ``ENV`` のもう 1 つ別の仕様を用いると、さらに ``ARG`` と ``ENV`` の組み合わせによる以下のような利用もできます。

.. 1 FROM ubuntu
   2 ARG CONT_IMG_VER
   3 ENV CONT_IMG_VER ${CONT_IMG_VER:-v1.0.0}
   4 RUN echo $CONT_IMG_VER

.. code-block:: dockerfile
   :linenos:

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER ${CONT_IMG_VER:-v1.0.0}
   RUN echo $CONT_IMG_VER

.. Unlike an `ARG` instruction, `ENV` values are always persisted in the built
   image. Consider a docker build without the `--build-arg` flag:

``ARG`` 命令とは違って ``ENV`` による値はビルドイメージ内に常に保持されます。
以下のような ``--build-arg`` フラグのない ``docker build`` を見てみます。

.. ```
   $ docker build .
   ```

.. code-block:: bash

   $ docker build .

.. Using this Dockerfile example, `CONT_IMG_VER` is still persisted in the image but
   its value would be `v1.0.0` as it is the default set in line 3 by the `ENV` instruction.

上の Dockerfile の例を用いると、``CONT_IMG_VER`` の値はイメージ内に保持されますが、その値は ``v1.0.0`` になります。
これは 3 行めの ``ENV`` 命令で設定されているデフォルト値です。

.. The variable expansion technique in this example allows you to pass arguments
   from the command line and persist them in the final image by leveraging the
   `ENV` instruction. Variable expansion is only supported for [a limited set of
   Dockerfile instructions.](#environment-replacement)

この例で見たように変数展開の手法では、コマンドラインから引数を受け渡すことが可能であり、``ENV`` 命令を用いればその値を最終イメージに残すことができます。
変数展開は、:ref:`特定の Dockerfile 命令 <environment-replacement>` においてのみサポートされます。

.. ### Predefined ARGs

.. _predefined-args:

定義済 ARG 変数
----------------

.. Docker has a set of predefined `ARG` variables that you can use without a
   corresponding `ARG` instruction in the Dockerfile.

Docker にはあらかじめ定義された ``ARG`` 変数があります。
これは Dockerfile において ``ARG`` 命令を指定しなくても利用することができます。

* ``HTTP_PROXY``
* ``http_proxy``
* ``HTTPS_PROXY``
* ``https_proxy``
* ``FTP_PROXY``
* ``ftp_proxy``
* ``NO_PROXY``
* ``no_proxy``

.. To use these, simply pass them on the command line using the flag:

これを利用する場合は、コマンドラインから以下のフラグを与えるだけです。

.. ```
   --build-arg <varname>=<value>
   ```

.. code-block:: bash

   --build-arg <varname>=<value>

.. By default, these pre-defined variables are excluded from the output of
   `docker history`. Excluding them reduces the risk of accidentally leaking
   sensitive authentication information in an `HTTP_PROXY` variable.

デフォルトにおいて、これらの定義済変数は ``docker history`` による出力からは除外されます。
除外する理由は、``HTTP_PROXY`` などの各変数内にある重要な認証情報が漏洩するリスクを軽減するためです。

.. For example, consider building the following Dockerfile using
   `--build-arg HTTP_PROXY=http://user:pass@proxy.lon.example.com`

たとえば ``--build-arg HTTP_PROXY=http://user:pass@proxy.lon.example.com`` という引数を用いて、以下の Dockerfile をビルドするとします。

.. ``` Dockerfile
   FROM ubuntu
   RUN echo "Hello World"
   ```

.. code-block:: dockerfile

   FROM ubuntu
   RUN echo "Hello World"

.. In this case, the value of the `HTTP_PROXY` variable is not available in the
   `docker history` and is not cached. If you were to change location, and your
   proxy server changed to `http://user:pass@proxy.sfo.example.com`, a subsequent
   build does not result in a cache miss.

この場合、``HTTP_PROXY`` 変数の値は ``docker history`` から取得することはできず、キャッシュにも含まれていません。
したがって URL が変更され、プロキシサーバーも ``http://user:pass@proxy.sfo.example.com`` に変更したとしても、この後に続くビルド処理において、キャッシュ・ミスは発生しません。

.. If you need to override this behaviour then you may do so by adding an `ARG`
   statement in the Dockerfile as follows:

この動作を取り消す必要がある場合は、以下のように Dockerfile 内に ``ARG`` 命令を加えれば実現できます。

.. ``` Dockerfile
   FROM ubuntu
   ARG HTTP_PROXY
   RUN echo "Hello World"
   ```

.. code-block:: dockerfile

   FROM ubuntu
   ARG HTTP_PROXY
   RUN echo "Hello World"

.. When building this Dockerfile, the `HTTP_PROXY` is preserved in the
   `docker history`, and changing its value invalidates the build cache.

この Dockerfile がビルドされるとき、``HTTP_PROXY`` は ``docker history`` に保存されます。
そしてその値を変更すると、ビルドキャッシュは無効化されます。

.. ### Impact on build caching

.. _impact-on-build-caching:

ビルドキャッシュへの影響
-------------------------

.. `ARG` variables are not persisted into the built image as `ENV` variables are.
   However, `ARG` variables do impact the build cache in similar ways. If a
   Dockerfile defines an `ARG` variable whose value is different from a previous
   build, then a "cache miss" occurs upon its first usage, not its definition. In
   particular, all `RUN` instructions following an `ARG` instruction use the `ARG`
   variable implicitly (as an environment variable), thus can cause a cache miss.
   All predefined `ARG` variables are exempt from caching unless there is a
   matching `ARG` statement in the `Dockerfile`.

``ARG`` 変数は ``ENV`` 変数とは違って、ビルドイメージの中に保持されません。
しかし ``ARG`` 変数はビルドキャッシュへ同じような影響を及ぼします。
Dockerfile に ``ARG`` 変数が定義されていて、その値が前回のビルドとは異なった値が設定されたとします。
このとき「キャッシュ・ミス」（cache miss）が発生しますが、それは初めて利用されたときであり、定義された段階ではありません。
特に ``ARG`` 命令に続く ``RUN`` 命令は、``ARG`` 変数の値を（環境変数として）暗に利用しますが、そこでキャッシュ・ミスが起こります。
定義済の ``ARG`` 変数は、``Dockerfile`` 内に ``ARG`` 行がない限りは、キャッシュは行われません。

.. For example, consider these two Dockerfile:

たとえば、２つの Dockerfile を考えます。

.. code-block:: dockerfile
   :linenos:

   FROM ubuntu
   ARG CONT_IMG_VER
   RUN echo $CONT_IMG_VER

.. code-block:: dockerfile
   :linenos:

   FROM ubuntu
   ARG CONT_IMG_VER
   RUN echo hello

.. If you specify `--build-arg CONT_IMG_VER=<value>` on the command line, in both
   cases, the specification on line 2 does not cause a cache miss; line 3 does
   cause a cache miss.`ARG CONT_IMG_VER` causes the RUN line to be identified
   as the same as running `CONT_IMG_VER=<value>` echo hello, so if the `<value>`
   changes, we get a cache miss.

コマンドラインから ``--build-arg CONT_IMG_VER=<value>`` を指定すると 2 つの例ともに、2 行めの記述ではキャッシュ・ミスが起きず、3 行めで発生します。
``ARG CONT_IMG_VER`` は、``RUN`` 行において ``CONT_IMG_VER=<value>`` echo hello と同等のことが実行されるので、``<value>`` が変更されると、キャッシュ・ミスが起こるということです。

.. Consider another example under the same command line:

もう 1 つの例を、同じコマンドライン実行を行って利用するとします。

.. code-block:: dockerfile
   :linenos:

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER $CONT_IMG_VER
   RUN echo $CONT_IMG_VER

.. In this example, the cache miss occurs on line 3. The miss happens because
   the variable's value in the `ENV` references the `ARG` variable and that
   variable is changed through the command line. In this example, the `ENV`
   command causes the image to include the value.

この例においてキャッシュ・ミスは 3 行めで発生します。
これは ``ENV`` における変数値が ``ARG`` 変数を参照しており、その変数値がコマンドラインから変更されるために起きます。
この例では ``ENV`` コマンドがイメージに対して変数値を書き込むものとなります。

.. If an `ENV` instruction overrides an `ARG` instruction of the same name, like
   this Dockerfile:

``ENV`` 命令が ``ARG`` 命令の同一変数名を上書きする例を見てみます。

.. code-block:: dockerfile
   :linenos:

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER hello
   RUN echo $CONT_IMG_VER

.. Line 3 does not cause a cache miss because the value of `CONT_IMG_VER` is a
   constant (`hello`). As a result, the environment variables and values used on
   the `RUN` (line 4) doesn't change between builds.

3 行めにおいてキャッシュ・ミスは発生しません。
これは ``CONT_IMG_VER`` が定数（``hello``）であるからです。
その結果、4 行めの ``RUN`` 命令において用いられる環境変数およびその値は、ビルドの際に変更されません。


.. _onbuild:

ONBUILD
==========

   ..  ONBUILD [INSTRUCTION]

.. code-block:: dockerfile

   ONBUILD [INSTRUCTION]

.. The `ONBUILD` instruction adds to the image a *trigger* instruction to
   be executed at a later time, when the image is used as the base for
   another build. The trigger will be executed in the context of the
   downstream build, as if it had been inserted immediately after the
   `FROM` instruction in the downstream `Dockerfile`.

``ONBUILD`` 命令は、イメージに対して **トリガ** 命令（trigger instruction）を追加します。
トリガ命令は後々実行されるものであり、そのイメージが他のビルドにおけるベースイメージとして用いられたときに実行されます。
このトリガ命令は、後続のビルドコンテキスト内で実行されます。
後続の ``Dockerfile`` 内での ``FROM`` 命令の直後に、その命令が挿入されたかのようにして動作します。

.. Any build instruction can be registered as a trigger.

どのようなビルド命令でも、トリガ命令として登録することができます。

.. This is useful if you are building an image which will be used as a base
   to build other images, for example an application build environment or a
   daemon which may be customized with user-specific configuration.

この命令は、他のイメージのビルドに用いることを意図したイメージをビルドする際に利用できます。
たとえばアプリケーションやデーモンの開発環境であって、ユーザ特有の設定を行うような場合です。

.. For example, if your image is a reusable Python application builder, it
   will require application source code to be added in a particular
   directory, and it might require a build script to be called *after*
   that. You can't just call `ADD` and `RUN` now, because you don't yet
   have access to the application source code, and it will be different for
   each application build. You could simply provide application developers
   with a boilerplate `Dockerfile` to copy-paste into their application, but
   that is inefficient, error-prone and difficult to update because it
   mixes with application-specific code.

たとえば、繰り返し利用できる Python アプリケーション環境イメージがあるとします。
そしてこのイメージにおいては、アプリケーションソースコードを所定のディレクトリに配置することが必要であって、さらにソースを配置した後にソースビルドを行うスクリプトを加えたいとします。
このままでは ``ADD`` と ``RUN`` を単に呼び出すだけでは実現できません。
それはアプリケーションソースコードがまだわかっていないからであり、ソースコードはアプリケーション環境ごとに異なるからです。
アプリケーション開発者に向けて、ひながたとなる ``Dockerfile`` を提供して、コピーペーストした上でアプリケーションに組み入れるようにすることも考えられます。
しかしこれでは不十分であり、エラーも起こしやすくなります。
そしてアプリケーションに特有のコードが含まれることになるので、更新作業も大変になります。

.. The solution is to use `ONBUILD` to register advance instructions to
   run later, during the next build stage.

これを解決するには ``ONBUILD`` を利用します。
後々実行する追加の命令を登録しておき、次のビルドステージにおいて実行させるものです。

.. Here’s how it works:

これは次のように動作します。

.. 1. When it encounters an `ONBUILD` instruction, the builder adds a
      trigger to the metadata of the image being built. The instruction
      does not otherwise affect the current build.
.. 2. At the end of the build, a list of all triggers is stored in the
      image manifest, under the key `OnBuild`. They can be inspected with
      the `docker inspect` command.
.. 3. Later the image may be used as a base for a new build, using the
      `FROM` instruction. As part of processing the `FROM` instruction,
      the downstream builder looks for `ONBUILD` triggers, and executes
      them in the same order they were registered. If any of the triggers
      fail, the `FROM` instruction is aborted which in turn causes the
      build to fail. If all triggers succeed, the `FROM` instruction
      completes and the build continues as usual.
.. 4. Triggers are cleared from the final image after being executed. In
      other words they are not inherited by "grand-children" builds.

1. ``ONBUILD`` 命令があると、現在ビルドしているイメージのメタデータに対してトリガが追加されます。
   この命令は現在のビルドには影響を与えません。
2. ビルドの最後に、トリガの一覧がイメージマニフェスト内の ``OnBuild`` というキーのもとに保存されます。
   この情報は ``docker inspect`` コマンドを使って確認することができます。
3. 次のビルドにおけるベースイメージとして、このイメージを利用します。
   その指定には ``FROM`` 命令を用います。
   ``FROM`` 命令の処理の中で、後続ビルド処理が ``ONBUILD`` トリガを見つけると、それが登録された順に実行していきます。
   トリガが 1 つでも失敗したら、``FROM`` 命令は中断され、ビルドが失敗することになります。
   すべてのトリガが成功したら ``FROM`` 命令の処理が終わり、ビルド処理がその後に続きます。
4. トリガは、イメージが実行された後は、イメージ内から削除されます。
   別の言い方をすれば、「孫」のビルドにまでは受け継がれないということです。

.. For example you might add something like this:

例として以下のようなことを追加する場合が考えられます。

.. code-block:: dockerfile

   [...]
   ONBUILD ADD . /app/src
   ONBUILD RUN /usr/local/bin/python-build --dir /app/src
   [...]

.. > **Warning**: Chaining `ONBUILD` instructions using `ONBUILD ONBUILD` isn't allowed.

.. warning::

   ``ONBUILD`` 命令をつなぎ合わせた命令、``ONBUILD ONBUILD`` は実現することはできません。

.. > **Warning**: The `ONBUILD` instruction may not trigger `FROM` or `MAINTAINER` instructions.

.. warning::

   ``ONBUILD`` 命令は ``FROM`` 命令や ``MAINTAINER`` 命令をトリガーとすることはできません。

.. _stopsignal:

STOPSIGNAL
==========

   ..  STOPSIGNAL signal

.. code-block:: dockerfile

   STOPSIGNAL signal

.. The `STOPSIGNAL` instruction sets the system call signal that will be sent to the container to exit.
   This signal can be a valid unsigned number that matches a position in the kernel's syscall table, for instance 9,
   or a signal name in the format SIGNAME, for instance SIGKILL.

``STOPSIGNAL`` 命令はシステムコールシグナルを設定するものであり、コンテナが終了するときに送信されます。
シグナルは負ではない整数値であり、カーネルのシステムコールテーブル内に合致するものを指定します。
たとえば 9 などです。
あるいは SIGNAME という形式のシグナル名を指定します。
たとえば SIGKILL などです。

.. HEALTHCHECK

.. _build-healthcheck:

HEALTHCHECK
====================

.. The HEALTHCHECK instruction has two forms:

``HEALTHCHECK`` 命令は２つの形式があります：

.. * `HEALTHCHECK [OPTIONS] CMD command` (check container health by running a command inside the container)
   * `HEALTHCHECK NONE` (disable any healthcheck inherited from the base image)

* ``HEALTHCHECK [OPTIONS] CMD command`` (コンテナ内部でコマンドを実行し、コンテナをヘルスチェック)
* ``HEALTHCHECK NONE`` (ベースイメージが行うヘルスチェックを無効化)

.. The `HEALTHCHECK` instruction tells Docker how to test a container to check that
   it is still working. This can detect cases such as a web server that is stuck in
   an infinite loop and unable to handle new connections, even though the server
   process is still running.

``HEALTHCHECK`` 命令は、コンテナが動作していることをチェックする方法を指定するものです。
この機能はたとえば、ウェブサーバのプロセスが稼動はしているものの、無限ループに陥っていて新たな接続を受け入れられない状態を検知する場合などに利用できます。

.. When a container has a healthcheck specified, it has a _health status_ in
   addition to its normal status. This status is initially `starting`. Whenever a
   health check passes, it becomes `healthy` (whatever state it was previously in).
   After a certain number of consecutive failures, it becomes `unhealthy`.

コンテナーヘルスチェックが設定されていると、通常のステータスに加えて **ヘルスステータス** を持つことになります。
このステータスの初期値は ``starting`` です。
ヘルスチェックが行われると、このステータスは（それまでにどんなステータスであっても） ``healthy`` となります。
ある一定数、連続してチェックに失敗すると、そのステータスは ``unhealty`` となります。

.. The options that can appear before CMD are:

``CMD`` より前に記述するオプションは、以下の通りです。

.. * `--interval=DURATION` (default: `30s`)
   * `--timeout=DURATION` (default: `30s`)
   * `--start-period=DURATION` (default: `0s`)
   * `--retries=N` (default: `3`)

* ``--interval=DURATION`` (デフォルト: `30s`)
* ``--timeout=DURATION`` (デフォルト: `30s`)
* ``--start-period=DURATION`` (デフォルト: `0s`)
* ``--retries=N`` (default: `3`)

.. The health check will first run **interval** seconds after the container is
   started, and then again **interval** seconds after each previous check completes.

ヘルスチェックは、コンテナが起動した **interval** 秒後に最初に起動されます。
そして直前のヘルスチェックが完了した **interval** 秒後に、再び実行されます。

.. If a single run of the check takes longer than **timeout** seconds then the check
   is considered to have failed.

1 回のヘルスチェックが **timeout** 秒以上かかったとき、そのチェックは失敗したものとして扱われます。

.. It takes **retries** consecutive failures of the health check for the container
   to be considered `unhealthy`.

コンテナに対するヘルスチェックが **retries** 回分、連続して失敗した場合は ``unhealthy`` とみなされます。

.. **start period** provides initialization time for containers that need time to bootstrap.
   Probe failure during that period will not be counted towards the maximum number of retries.
   However, if a health check succeeds during the start period, the container is considered
   started and all consecutive failures will be counted towards the maximum number of retries.

**開始時間** （start period）は、コンテナが起動するまでに必要となる初期化時間を設定します。
この時間内にヘルスチェックの失敗が発生したとしても、 **retries** 数の最大を越えたかどうかの判断は行われません。
ただしこの開始時間内にヘルスチェックが 1 つでも成功したら、コンテナは起動済であるとみなされます。
そこで、それ以降にヘルスチェックが失敗したら、**retries** 数の最大を越えたかどうかがカウントされます。

.. There can only be one `HEALTHCHECK` instruction in a Dockerfile. If you list
   more than one then only the last `HEALTHCHECK` will take effect.

1 つの Dockerfile に記述できる ``HEALTHCHECK`` 命令はただ 1 つです。
複数の ``HEALTHCHECK`` を記述しても、最後の命令しか効果はありません。

.. The command after the `CMD` keyword can be either a shell command (e.g. `HEALTHCHECK
   CMD /bin/check-running`) or an _exec_ array (as with other Dockerfile commands;
   see e.g. `ENTRYPOINT` for details).

``CMD`` キーワードの後ろにあるコマンドは、シェルコマンド（たとえば ``HEALTHCHECK CMD /bin/check-running``）か、あるいは exec 形式の配列（他の Dockerfile コマンド、たとえば ``ENTRYPOINT`` にあるもの）のいずれかを指定します。

.. The command's exit status indicates the health status of the container.
   The possible values are:

そのコマンドの終了ステータスが、コンテナのヘルスステータスを表わします。
返される値は以下となります。

.. - 0: success - the container is healthy and ready for use
   - 1: unhealthy - the container is not working correctly
   - 2: reserved - do not use this exit code

* 0: 成功（success） - コンテナは健康であり、利用が可能です。
* 1: 不健康（unhealthy） - コンテナは正常に動作していません。
* 2: 予約（reserved） - このコードを戻り値として利用してはなりません。

.. For example, to check every five minutes or so that a web-server is able to
   serve the site's main page within three seconds:

たとえば 5 分間に 1 回のチェックとして、ウェブサーバが 3 秒以内にサイトのメインページを提供できているかを確認するには、以下のようにします。

.. code-block:: dockerfile

   HEALTHCHECK --interval=5m --timeout=3s \
     CMD curl -f http://localhost/ || exit 1

.. To help debug failing probes, any output text (UTF-8 encoded) that the command writes
   on stdout or stderr will be stored in the health status and can be queried with
   `docker inspect`. Such output should be kept short (only the first 4096 bytes
   are stored currently).

ヘルスチェックにが失敗しても、それをデバッグしやすくするために、そのコマンドが標準出力あるいは標準エラー出力へ書き込んだ文字列（UTF-8 エンコーディング）は、すべてヘルスステータス内に保存されます。
``docker inspect`` を使えば、すべて確認することができます。
ただしその出力は切り詰められます（現時点においては最初の 4096 バイト分のみを出力します）。

.. When the health status of a container changes, a `health_status` event is
   generated with the new status.

コンテナのヘルスステータスが変更されると、``health_status`` イベントが生成されて、新たなヘルスステータスになります。

.. The HEALTHCHECK feature was added in Docker 1.12.

``HEALTHCHECK``  機能は Docker 1.12 で追加されました。

.. SHELL

.. _builder-shell:

SHELL
==========

   ..  SHELL ["executable", "parameters"]

.. code-block:: dockerfile

   SHELL ["executable", "parameters"]

.. The `SHELL` instruction allows the default shell used for the *shell* form of
   commands to be overridden. The default shell on Linux is `["/bin/sh", "-c"]`, and on
   Windows is `["cmd", "/S", "/C"]`. The `SHELL` instruction *must* be written in JSON
   form in a Dockerfile.

``SHELL`` 命令は、各種コマンドのシェル形式において用いられるデフォルトのシェルを、上書き設定するために利用します。
デフォルトのシェルは Linux 上では ``["/bin/sh", "-c"]``、Windows 上では ``["cmd", "/S", "/C"]`` です。
``SHELL`` 命令は Dockerfile 内において JSON 形式で記述しなければなりません。

.. The `SHELL` instruction is particularly useful on Windows where there are
   two commonly used and quite different native shells: `cmd` and `powershell`, as
   well as alternate shells available including `sh`.

``SHELL`` 命令は特に Windows 上において利用されます。
Windows には主に 2 つのネイティブなシェル、つまり ``cmd`` と ``powershell`` があり、両者はかなり異なります。
しかも ``sh`` のような、さらに別のシェルも利用することができます。

.. The `SHELL` instruction can appear multiple times. Each `SHELL` instruction overrides
   all previous `SHELL` instructions, and affects all subsequent instructions. For example:

``SHELL`` 命令は、何度でも記述できます。
個々の ``SHELL`` 命令は、それより前の ``SHELL`` 命令の値を上書きし、それ以降の命令に効果を及ぼします。
たとえば以下のとおりです。

   ..  FROM microsoft/windowsservercore

       # Executed as cmd /S /C echo default
       RUN echo default

       # Executed as cmd /S /C powershell -command Write-Host default
       RUN powershell -command Write-Host default

       # Executed as powershell -command Write-Host hello
       SHELL ["powershell", "-command"]
       RUN Write-Host hello

       # Executed as cmd /S /C echo hello
       SHELL ["cmd", "/S"", "/C"]
       RUN echo hello

.. code-block:: dockerfile

   FROM microsoft/windowsservercore

   # 以下のように実行： cmd /S /C echo default
   RUN echo default

   # 以下のように実行： cmd /S /C powershell -command Write-Host default
   RUN powershell -command Write-Host default

   # 以下のように実行： powershell -command Write-Host hello
   SHELL ["powershell", "-command"]
   RUN Write-Host hello

   # 以下のように実行： cmd /S /C echo hello
   SHELL ["cmd", "/S", "/C"]
   RUN echo hello

.. The following instructions can be affected by the `SHELL` instruction when the
   *shell* form of them is used in a Dockerfile: `RUN`, `CMD` and `ENTRYPOINT`.

Dockerfile において ``RUN``、``CMD``、``ENTRYPOINT`` の各コマンドをシェル形式で記述した際には、``SHELL`` 命令の設定による影響が及びます。

.. The following example is a common pattern found on Windows which can be
   streamlined by using the `SHELL` instruction:

以下に示す例は、Windows 上において見られる普通の実行パターンですが、``SHELL`` 命令を使って簡単に実現することができます。

.. code-block:: dockerfile

   ...
   RUN powershell -command Execute-MyCmdlet -param1 "c:\foo.txt"
   ...

.. The command invoked by docker will be:

Docker によって実行されるコマンドは以下となります。

.. code-block:: shell

   cmd /S /C powershell -command Execute-MyCmdlet -param1 "c:\foo.txt"

.. This is inefficient for two reasons. First, there is an un-necessary cmd.exe command
   processor (aka shell) being invoked. Second, each `RUN` instruction in the *shell*
   form requires an extra `powershell -command` prefixing the command.

これは効率的ではなく、そこには 2 つの理由があります。
1 つめは、コマンドプロセッサー cmd.exe（つまりはシェル）が不要に呼び出されているからです。
2 つめは、シェル形式の ``RUN`` 命令において、常に ``powershell -command`` を各コマンドの頭につけて実行しなければならないからです。

.. To make this more efficient, one of two mechanisms can be employed. One is to
   use the JSON form of the RUN command such as:

これを効率化するには、2 つあるメカニズムの 1 つを取り入れることです。
1 つは、RUN コマンドの JSON 形式を使って、以下のようにします。

.. code-block:: dockerfile

   ...
   RUN ["powershell", "-command", "Execute-MyCmdlet", "-param1 \"c:\\foo.txt\""]
   ...

.. While the JSON form is unambiguous and does not use the un-necessary cmd.exe,
   it does require more verbosity through double-quoting and escaping. The alternate
   mechanism is to use the `SHELL` instruction and the *shell* form,
   making a more natural syntax for Windows users, especially when combined with
   the `escape` parser directive:

JSON 形式を使えば、あいまいさはなくなり、不要な cmd.exe を使うこともなくなります。
しかしダブルクォートやエスケープを行うことも必要となり、より多くを記述することにもなります。
もう 1 つの方法は ``SHELL`` 命令とシェル形式を使って、Windows ユーザーにとって、より自然な文法で実現するやり方です。
特にパーサーディレクティブ ``escape`` を組み合わせて実現します。

   ..  # escape=`

       FROM microsoft/nanoserver
       SHELL ["powershell","-command"]
       RUN New-Item -ItemType Directory C:\Example
       ADD Execute-MyCmdlet.ps1 c:\example\
       RUN c:\example\Execute-MyCmdlet -sample 'hello world'

.. code-block:: dockerfile

   # escape=`

   FROM microsoft/nanoserver
   SHELL ["powershell","-command"]
   RUN New-Item -ItemType Directory C:\Example
   ADD Execute-MyCmdlet.ps1 c:\example\
   RUN c:\example\Execute-MyCmdlet -sample 'hello world'

.. Resulting in:

これは以下のようになります。

.. code-block:: shell

   PS E:\docker\build\shell> docker build -t shell .
   Sending build context to Docker daemon 4.096 kB
   Step 1/5 : FROM microsoft/nanoserver
    ---> 22738ff49c6d
   Step 2/5 : SHELL powershell -command
    ---> Running in 6fcdb6855ae2
    ---> 6331462d4300
   Removing intermediate container 6fcdb6855ae2
   Step 3/5 : RUN New-Item -ItemType Directory C:\Example
    ---> Running in d0eef8386e97
   
   
       Directory: C:\
   
   
   Mode                LastWriteTime         Length Name
   ----                -------------         ------ ----
   d-----       10/28/2016  11:26 AM                Example
   
   
    ---> 3f2fbf1395d9
   Removing intermediate container d0eef8386e97
   Step 4/5 : ADD Execute-MyCmdlet.ps1 c:\example\
    ---> a955b2621c31
   Removing intermediate container b825593d39fc
   Step 5/5 : RUN c:\example\Execute-MyCmdlet 'hello world'
    ---> Running in be6d8e63fe75
   hello world
    ---> 8e559e9bf424
   Removing intermediate container be6d8e63fe75
   Successfully built 8e559e9bf424
   PS E:\docker\build\shell>

.. The `SHELL` instruction could also be used to modify the way in which
   a shell operates. For example, using `SHELL cmd /S /C /V:ON|OFF` on Windows, delayed
   environment variable expansion semantics could be modified.

``SHELL`` 命令はまた、シェルの動作を変更する際にも利用することができます。
たとえば Windows 上において ``SHELL cmd /S /C /V:ON|OFF`` を実行すると、遅延環境変数の展開方法を変更することができます。

.. The `SHELL` instruction can also be used on Linux should an alternate shell be
   required such as `zsh`, `csh`, `tcsh` and others.

``SHELL`` 命令は Linux において、``zsh``、``csh``、``tcsh`` などのシェルが必要となる場合にも利用することができます。

.. The SHELL feature was added in Docker 1.12.

``SHELL`` 機能は Docker 1.12 で追加されました。

.. ## Dockerfile examples

Dockerfile の記述例
====================

.. Below you can see some examples of Dockerfile syntax. If you're interested in
   something more realistic, take a look at the list of [Dockerization examples](https://docs.docker.com/engine/examples/).

以下では Dockerfile の文法例をいくつか示します。
より実践的なところに興味がある場合は :doc:`Docker 化のサンプル </engine/examples/index>` を参照してください。

.. code-block:: dockerfile

   # Nginx
   #
   # VERSION               0.0.1
   
   FROM      ubuntu
   MAINTAINER Victor Vieux <victor@docker.com>
   
   LABEL Description="This image is used to start the foobar executable" Vendor="ACME Products" Version="1.0"
   RUN apt-get update && apt-get install -y inotify-tools nginx apache2 openssh-server

.. code-block:: dockerfile

   # Firefox over VNC
   #
   # VERSION               0.3
   
   FROM ubuntu
   
   # 「フェイク」（偽）のディスプレイ用の vnc, xvfb と firefox をインストール
   RUN apt-get update && apt-get install -y x11vnc xvfb firefox
   RUN mkdir ~/.vnc
   # パスワードをセットアップ
   RUN x11vnc -storepasswd 1234 ~/.vnc/passwd
   # firefox の自動起動（ベストな方法ではありませんが、動きます）
   RUN bash -c 'echo "firefox" >> /.bashrc'
   
   EXPOSE 5900
   CMD    ["x11vnc", "-forever", "-usepw", "-create"]

.. code-block:: dockerfile

   # 複数のイメージ例
   #
   # VERSION               0.1
   
   FROM ubuntu
   RUN echo foo > bar
   # 「===> 907ad6c2736f」 のような出力があります
   
   FROM ubuntu
   RUN echo moo > oink
   # 「===> 695d7793cbe4」 のような出力があります
   
   # You᾿ll now have two images, 907ad6c2736f with /bar, and 695d7793cbe4 with
   # /oink.
   # これで２つのイメージができました。
   # /bar がある 907ad6c2736f と、/oink がある 695d7793cbe4 です

.. seealso:: 

   Dockerfile reference
      https://docs.docker.com/engine/reference/builder/
