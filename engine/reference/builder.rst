.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/builder/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/builder.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/builder.md
.. check date: 2016/06/14
.. Commits on Jun 12, 2016 c9a68ffb2ae7b2ac13a2febab82b3d7a824eb97f
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

Docker は ``Dockerfile`` から命令を読み込み、自動的にイメージを構築できます。 ``Dockerfile`` はテキスト形式のドキュメントであり、コマンドライン上でイメージを作り上げる命令を全て記述します。ユーザは ``docker build`` を使い、複数のコマンド行の命令を順次実行し、イメージを自動構築します。

.. This page describes the commands you can use in a Dockerfile. When you are done reading this page, refer to the Dockerfile Best Practices for a tip-oriented guide.

このページでは ``Dockerfile`` 内で利用可能な命令を説明します。ページを読み終えたら、より便利に使うための ``Dockerfile`` の :doc:`ベスト・プラクティス </engine/userguide/eng-image/dockerfile_best-practice>` もご覧ください。

.. Usage

使い方
==========

.. The docker build command builds an image from a Dockerfile and a context. The build’s context is the files at a specified location PATH or URL. The PATH is a directory on your local filesystem. The URL is a the location of a Git repository.

``docker build`` コマンドは ``Dockerfile`` と *コンテクスト(context；イメージに含まれる「内容」の意味)* に従ってイメージを構築します。構築用コンテクストとは、ファイルを示す ``PATH``  や ``URL`` の場所です。 ``PATH`` はローカルのファイルシステム上のディレクトリです。 ``URL`` は Git リポジトリの場所です。

.. A context is processed recursively. So, a PATH includes any subdirectories and the URL includes the repository and its submodules. A simple build command that uses the current directory as context:

コンテクストの処理は再帰的です。そのため、 ``PATH`` にはサブディレクトリを含みます。また ``URL`` であればリポジトリと、そのサブモジュールも含みます。単に build コマンドを実行したら、現在のディレクトリをコンテクストとして使います。

.. code-block:: bash

   $ docker build .
   Sending build context to Docker daemon  6.51 MB
   ...

.. The build is run by the Docker daemon, not by the CLI. The first thing a build process does is send the entire context (recursively) to the daemon. In most cases, it’s best to start with an empty directory as context and keep your Dockerfile in that directory. Add only the files needed for building the Dockerfile.

構築を処理するのは Docker デーモンであり、 CLI ではありません。まずはじめの構築プロセスは、対象のコンテクスト（再帰的）をデーモンに送信することです。多くの場合、空のディレクトリをコンテクストとして使いますので、Dockerfile をそのディレクトリ設置できます。Dockerfile の構築に必要なファイルのみを（ディレクトリに）追加します。

..    Warning: Do not use your root directory, /, as the PATH as it causes the build to transfer the entire contents of your hard drive to the Docker daemon.

.. warning::

   ``PATH`` として自分のルート・ディレクトリ ``/`` を使わないでください。これは、自分のハードディスクに含まれる内容を、Docker デーモンに転送しようとするためです。

.. To use a file in the build context, the Dockerfile refers to the file specified in an instruction, for example, a COPY instruction. To increase the build’s performance, exclude files and directories by adding a .dockerignore file to the context directory. For information about how to create a .dockerignore file see the documentation on this page.

``Dockerfile`` に記述した ``COPY`` 命令などで使うファイル指定を参照し、コンテクスト（内容物の意味）を構築します。構築パフォーマンスを向上するためには、 ``.dockerignore`` ファイルにファイルやディレクトリを追加し、コンテクスト・ディレクトリから除外できます。より詳しい情報は、 :ref:`.dockerignore ファイルの作成 <dockerignore-file>` をご覧ください。

.. Traditionally, the Dockerfile is called Dockerfile and located in the root of the context. You use the -f flag with docker build to point to a Dockerfile anywhere in your file system.

伝統的に ``Dockerfile`` は、``Dockerfile`` とコンテクストがあるルートの場所を示します。 ``docker build`` 時に ``-f`` フラグを使えば、システム上のどこに Dockerfile があるか指定できます。

.. code-block:: bash

   $ docker build -f /path/to/a/Dockerfile .

.. You can specify a repository and tag at which to save the new image if the build succeeds:

新しいイメージの構築に成功する時は、新しいイメージにリポジトリとタグを指定できます。

.. code-block:: bash

   $ docker build -t shykes/myapp .

.. The Docker daemon runs the instructions in the Dockerfile one-by-one, committing the result of each instruction to a new image if necessary, before finally outputting the ID of your new image. The Docker daemon will automatically clean up the context you sent.

Docker デーモンは ``Dockerfile`` の命令を1行ずつ実行し、必要があれば命令ごとにイメージをコミットし、最終的に新しいイメージ ID を出力します。Docker デーモンは送信したコンテクストを自動的に削除します。

.. Note that each instruction is run independently, and causes a new image to be created - so RUN cd /tmp will not have any effect on the next instructions.

各命令は独立して実行されるのでご注意ください。新しいイメージの作成時、 ``RUN cd /tmp`` を実行したとしても、次の命令には何ら影響を与えません。

.. Whenever possible, Docker will re-use the intermediate images (cache), to accelerate the docker build process significantly. This is indicated by the Using cache message in the console output. (For more information, see the Build cache section) in the Dockerfile best practices guide:

Docker は可能であればいつでも中間イメージ（キャッシュ）を再利用します。これは ``docker build`` 処理を速くするためです。コンソール出力に ``Using cache`` （キャッシュを利用中）の文字列が表示されます。より詳しい情報は ``Dockerfile`` ベスト・プラクティス・ガイドの :ref:`構築キャッシュ <build-cache>` をご覧ください。

.. code-block:: bash

   $ docker build -t svendowideit/ambassador .
   Sending build context to Docker daemon 15.36 kB
   Step 0 : FROM alpine:3.2
    ---> 31f630c65071
   Step 1 : MAINTAINER SvenDowideit@home.org.au
    ---> Using cache
    ---> 2a1c91448f5f
   Step 2 : RUN apk update &&      apk add socat &&        rm -r /var/cache/
    ---> Using cache
    ---> 21ed6e7fbb73
   Step 3 : CMD env | grep _TCP= | sed 's/.*_PORT_\([0-9]*\)_TCP=tcp:\/\/\(.*\):\(.*\)/socat -t 100000000 TCP4-LISTEN:\1,fork,reuseaddr TCP4:\2:\3 \&/' && echo wait) | sh
    ---> Using cache
    ---> 7ea8aef582cc
   Successfully built 7ea8aef582cc

.. When you’re done with your build, you’re ready to look into Pushing a repository to its registry.

構築が終わったら、:doc:`レジストリにリポジトリを送信 </engine/userguide/containers/dockerrepos>` する準備が整います。

.. Format

書式
==========

.. Here is the format of the Dockerfile:

ここでは ``Dockerfile`` の書式を説明します。

.. code-block:: dockerfile

   # コメント
   命令 引数

.. The instruction is not case-sensitive, however convention is for them to be UPPERCASE in order to distinguish them from arguments more easily.

命令（instruction）は大文字と小文字を区別しません。しかし引数（arguments）を簡単に見分けられるよう、大文字にするのが便利です。

.. Docker runs the instructions in a Dockerfile in order. The first instruction must be `FROM` in order to specify the Base Image from which you are building.

Docker は ``Dockerfile`` の命令を順番に実行します。イメージ構築にあたり :ref:`ベース・イメージ <base-image>` を指定するため、 **１行めの命令は「FROM」であるべき** です。


.. Docker treats lines that begin with # as a comment, unless the line is a valid parser directive. A # marker anywhere else in a line is treated as an argument. This allows statements like:

Docker は有効な :ref:`パーサ・ディレクティブ <parser-directives>` でなければ、 ``#`` で *始まる* 行をコメントとみなします。 ``#`` マークは行における以降の文字をコメントとみなします。コメントは次のような書き方ができます。

.. code-block:: dockerfile

   # コメント
   RUN echo '良い感じもの何かを # 実行しています'

.. Line continuation characters are not supported in comments.

行中で命令の文字列が継続している場合は、コメント扱いしません。

.. Parser directives

.. _parser-directives:

パーサ・ディレクティブ（parser directive）
==================================================

.. Parser directives are optional, and affect the way in which subsequent lines in a Dockerfile are handled. Parser directives do not add layers to the build, and will not be shown as a build step. Parser directives are written as a special type of comment in the form # directive=value. A single directive may only be used once.

パーサ・ディレクティブはオプションです。 ``Dockerfile`` 中では、次に続く行にも影響を与えます。パーサ・ディレクティブは構築時にレイヤを追加しませんので、構築ステップでは表示されません。パーサ・ディレクティブは ``# ディレクティブ=値`` という特別な種類のコメントとして記述します。１つのディレクティブは１度しか使われません。

.. Once a comment, empty line or builder instruction has been processed, Docker no longer looks for parser directives. Instead it treats anything formatted as a parser directive as a comment and does not attempt to validate if it might be a parser directive. Therefore, all parser directives must be at the very top of a Dockerfile.

コメントがあれば、空行または構築命令があったとしても、 Docker はパーサ・ディレクティブを探しません。そのかわり、あらゆる書式をパーサ・ディレクティブではなくコメントとみなすため、有効なパーサ・ディレクティブとはみなしません。そのため、全てのパーサ・ディレクティブは ``Dockerfile``  の限りなく上に書くべきです。

.. Parser directives are not case-sensitive. However, convention is for them to be lowercase. Convention is also to include a blank line following any parser directives. Line continuation characters are not supported in parser directives.

パーサ・ディレクティブは大文字と小文字を区別しません。しかしながら、小文字での記述が便利です。パーサ・ディレクティブの後に空白行を入れるのも便利です。行を継続する文字列は、パーサ・ディレクティブではサポートされません。

.. Due to these rules, the following examples are all invalid:

これらのルールがあるため、以下の例は全て無効です。

.. Invalid due to line continuation:

行の継続は無効：

.. code-block:: dockerfile

   # direc \
   tive=value

.. Invalid due to appearing twice:

２つ並ぶ場合は無効：

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

.. Non line-breaking whitespace is permitted in a parser directive. Hence, the following lines are all treated identically:

行を壊さない空白行はパーサ・ディレクティブとして使えます。従って、以下の行はすべて同一として扱う：

.. code-block:: dockerfile

   #directive=value
   # directive =value
   #   directive= value
   # directive = value
   #     dIrEcTiVe=value

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

.. The escape directive sets the character used to escape characters in a Dockerfile. If not specified, the default escape character is \.

``escape`` ディレクティブは ``Dockerfile`` で使うエスケープ文字をセットします。指定しなければ、デフォルトのエスケープ文字は ``\`` です。

.. The escape character is used both to escape characters in a line, and to escape a newline. This allows a Dockerfile instruction to span multiple lines. Note that regardless of whether the escape parser directive is included in a Dockerfile, escaping is not performed in a RUN command, except at the end of a line.

エスケープ文字を使うのは、行におけるエスケープ文字と、新しい行にエスケープする（つなげる）ための両方です。これにより、 ``Dockerfile`` の命令を複数行に記述できます。 ``Dockerfile`` で ``escape`` パーサ・ディレクティブを指定しなければ ``RUN`` 命令でもエスケープ処理はされませんが、行の最後は除くのでご注意ください。

.. Setting the escape character to ` is especially useful on Windows, where \ is the directory path separator. ` is consistent with Windows PowerShell.

エスケープ文字に 「`」 を指定するのは ``Windows`` 上で役立ちます。 ``\`` はディレクトリのパスのパーサ（区切り）だからです。 「`」 は `Windows PowerShell <https://technet.microsoft.com/en-us/library/hh847755.aspx>`_ で次の行をつなぎます。

.. Consider the following example which would fail in a non-obvious way on Windows. The second \ at the end of the second line would be interpreted as an escape for the newline, instead of a target of the escape from the first \. Similarly, the \ at the end of the third line would, assuming it was actually handled as an instruction, cause it be treated as a line continuation. The result of this dockerfile is that second and third lines are considered a single instruction:

以下では Windows では明確にエラーが出る例を考えます。２行目末尾の２つめの ``\`` は、１つめの ``\`` のエスケープとして処理されるのではなく、新しい行のためのエスケープとして扱われます。同様に３行目末尾の ``\`` は次の行に命令が継続するものとして扱われます。この dockerfile を使った結果、２行目と３行目は１つの命令として見なされます。

.. code-block:: dockerfile

   FROM windowsservercore
   COPY testfile.txt c:\\
   RUN dir c:\

.. Results in:

実行結果：

.. code-block:: powershell

   PS C:\John> docker build -t cmd .
   Sending build context to Docker daemon 3.072 kB
   Step 1 : FROM windowsservercore
    ---> dbfee88ee9fd
   Step 2 : COPY testfile.txt c:RUN dir c:
   GetFileAttributesEx c:RUN: The system cannot find the file specified.
   PS C:\John>

.. One solution to the above would be to use / as the target of both the COPY instruction, and dir. However, this syntax is, at best, confusing as it is not natural for paths on Windows, and at worst, error prone as not all commands on Windows support / as the path separator.

解決方法の１つは、 ``COPY``  命令とディレクトリで ``/`` を使う方法です。しかしながら、構文上ベストなのは ``Windows`` 上のパスを普通に扱うことであり、最悪なのは ``Windows`` 上でパスの区切りとして ``/`` を指定するとエラーを起こしがちです。

.. By adding the escape parser directive, the following Dockerfile succeeds as expected with the use of natural platform semantics for file paths on Windows:

``escape`` パーサ・ディレクティブを追加することで、次の ``Dockerfile`` は ``Windows`` 上のファイル・パスを期待通りに処理します。

.. code-block:: dockerfile

   # escape=`
   
   FROM windowsservercore
   COPY testfile.txt c:\
   RUN dir c:\

.. Results in:

実行結果：

.. code-block:: powershell

   PS C:\John> docker build -t succeeds --no-cache=true .
   Sending build context to Docker daemon 3.072 kB
   Step 1 : FROM windowsservercore
    ---> dbfee88ee9fd
   Step 2 : COPY testfile.txt c:\
    ---> 99ceb62e90df
   Removing intermediate container 62afbe726221
   Step 3 : RUN dir c:\
    ---> Running in a5ff53ad6323
    Volume in drive C has no label.
    Volume Serial Number is 1440-27FA
   
    Directory of c:\
   
   03/25/2016  05:28 AM    <DIR>          inetpub
   03/25/2016  04:22 AM    <DIR>          PerfLogs
   04/22/2016  10:59 PM    <DIR>          Program Files
   03/25/2016  04:22 AM    <DIR>          Program Files (x86)
   04/18/2016  09:26 AM                 4 testfile.txt
   04/22/2016  10:59 PM    <DIR>          Users
   04/22/2016  10:59 PM    <DIR>          Windows
                  1 File(s)              4 bytes
                  6 Dir(s)  21,252,689,920 bytes free
    ---> 2569aa19abef
   Removing intermediate container a5ff53ad6323
   Successfully built 2569aa19abef
   PS C:\John>

.. Environment replacement:

.. _environment-replacement:

環境変数の置き換え
====================

.. Environment variables (declared with the ENV statement) can also be used in certain instructions as variables to be interpreted by the Dockerfile. Escapes are also handled for including variable-like syntax into a statement literally.

``Dockerfile`` は環境変数（ :ref:`env 命令 <env>` で宣言）も解釈できます。命令文字（ステートメント・リテラル）中では、変数の様な構文でエスケープ・シーケンスも扱えます。

.. Environment variables are notated in the Dockerfile either with $variable_name or ${variable_name}. They are treated equivalently and the brace syntax is typically used to address issues with variable names with no whitespace, like ${foo}_bar.

``Dockerfile`` の中では、環境変数を ``$variable_name`` または ``${variable_name}`` の形式で記述します。これらは同等に扱われます。固定用の構文として典型的に使われるのは、空白スペースを変数名に入れず ``${foo}_bar`` のような変数名で割り当てることです。

.. The ${variable_name} syntax also supports a few of the standard bash modifiers as specified below:

``${変数の_名前}`` 構文は、次のような ``bash`` の変更をサポートしています。

..    ${variable:-word} indicates that if variable is set then the result will be that value. If variable is not set then word will be the result.
    ${variable:+word} indicates that if variable is set then word will be the result, otherwise the result is the empty string.

* ``${変数:-文字}`` は、 ``変数`` を設定したら、その値を使うことを意味します。もし ``変数`` がセットされ無ければ、 ``文字`` が設定されます。
* ``${変数:+文字}`` は、 ``変数`` を設定したら、``文字`` を使います。 ``変数`` がセットされなければ、空白のままにします。

.. In all cases, word can be any string, including additional environment variables.

いずれの場合でも、 ``文字`` とは何らかの文字列であり、追加の環境変数を含みます。

.. Escaping is possible by adding a \ before the variable: \$foo or \${foo}, for example, will translate to $foo and ${foo} literals respectively.

エスケープするには ``\$foo`` や ``\${foo}`` のように、変数名の前に ``\`` を付けます。例えば、 ``$foo`` と ``${foo}`` リテラルは別々のものです。

.. Example (parsed representation is displayed after the #):

例（変数展開したものは、 ``#`` のあとに表示）：

.. code-block:: dockerfile

   FROM busybox
   ENV foo /bar
   WORKDIR ${foo}   # WORKDIR /bar
   ADD . $foo       # ADD . /bar
   COPY \$foo /quux # COPY $foo /quux

.. Environment variables are supported by the following list of instructions in the Dockerfile:

以下の命令で ``Dockerfile`` における環境変数の利用がサポートされています。

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

..    ONBUILD (when combined with one of the supported instructions above)

* ``ONBLIUD`` （上記の命令と組み合わせて使う場合にサポートされます）

..    Note: prior to 1.4, ONBUILD instructions did NOT support environment variable, even when combined with any of the instructions listed above.

.. note::

   1.4 より前のバージョンでは、環境変数における ``ONBUILD`` 命令と上記の命令の組み合わせはサポート **していません** 。

.. Environment variable substitution will use the same value for each variable throughout the entire command. In other words, in this example:

環境変数を使う代わりに、各変数をコマンド上で利用できます。次の例を見ましょう。

.. code-block:: dockerfile

   ENV abc=hello
   ENV abc=bye def=$abc
   ENV ghi=$abc

.. will result in def having a value of hello, not bye. However, ghi will have a value of bye because it is not part of the same command that set abc to bye.

この結果は、 ``def`` の値が ``hello`` であり、 ``bye`` ではありません。しかしながら ``ghi`` の値は ``bye`` になります。これは ``abc`` を ``bye`` に設定するのと同じコマンド行ではないためです。

.. _dockerignore-file:

.dockerignore ファイル
==============================

.. Before the docker CLI sends the context to the docker daemon, it looks for a file named .dockerignore in the root directory of the context. If this file exists, the CLI modifies the context to exclude files and directories that match patterns in it. This helps to avoid unnecessarily sending large or sensitive files and directories to the daemon and potentially adding them to images using ADD or COPY.

docker CLI がコンテクストを docker デーモンに送る前に、コンテクストのルートディレクトリ内の ``.dockerignore`` ファイルを探します。もしファイルが存在していれば、CLI はコンテクストからパターンに一致するファイルとディレクトリを除外します。これは不必要に大きくならないようにします。また、取り扱いに注意が必要なファイルやディレクトリをデーモンに送らないようにします。ですが、 ``ADD`` や ``COPY`` でイメージに追加されるかもしれません。

.. The CLI interprets the .dockerignore file as a newline-separated list of patterns similar to the file globs of Unix shells. For the purposes of matching, the root of the context is considered to be both the working and the root directory. For example, the patterns /foo/bar and foo/bar both exclude a file or directory named bar in the foo subdirectory of PATH or in the root of the git repository located at URL. Neither excludes anything else.

CLI は ``.dockerignore`` ファイルを行ごとに隔てて解釈します。行の一致パターンは Unix シェル上のものに似ています。パターンがコンテクストの root に一致すると考えられる場合は、root ディレクトリとして動作します。例えば、パターン ``/foo/bar`` と ``foo/bar`` がある場合、いずれも ``PATH`` における ``foo`` サブディレクトリの ``bar`` ファイルを削除します。あるいは ``URL`` の場所にある git のルートでもです。どちらでも除外されます。

.. If a line in `.dockerignore` file starts with `#` in column 1, then this line is considered as a comment and is ignored before interpreted by the CLI.

``.dockerignore`` ファイルの１行目が ``#`` で始まる場合は、この合はコメントであると見なされ、CLI の処理からは無視されます。

.. Here is an example .dockerignore file:

これは ``.dockerignore`` ファイルの例です：

.. code-block:: bash

   # コメント
   */temp*
   */*/temp*
   temp?

.. This file causes the following build behavior:

このファイルは構築時に以下の動作をします。

.. Rule 	Behavior
.. 表にする(todo)

.. */temp* 	Exclude files and directories whose names start with temp in any immediate subdirectory of the root. For example, the plain file /somedir/temporary.txt is excluded, as is the directory /somedir/temp.
   */*/temp* 	Exclude files and directories starting with temp from any subdirectory that is two levels below the root. For example, /somedir/subdir/temporary.txt is excluded.
   temp? 	Exclude files and directories in the root directory whose names are a one-character extension of temp. For example, /tempa and /tempb are excluded.

* ``# コメント`` … 無視します。
* ``*/temp*`` … ルート以下のあらゆるサブディレクトリを含め、 ``temp`` で始まる名称のファイルとディレクトリを除外します。例えば、テキストファイル ``/somedir/temporary.txt`` は除外しますし、ディレクトリ ``/somedir/temp`` も除外します。
* ``*/*/temp*`` … ルートから２レベル以下の ``temp`` で 始まる名称のファイルとディレクトリを除外します。例えば ``/somedir/subdir/temporary.txt`` を除外します。
* ``temp?`` … ルートディレクトリにあるファイル名が ``temp`` と１文字一致するファイルとディレクトリを除外します。例えば、 ``/tempa`` と ``/tempb`` を除外します。

.. Matching is done using Go’s filepath.Match rules. A preprocessing step removes leading and trailing whitespace and eliminates . and .. elements using Go’s filepath.Clean. Lines that are blank after preprocessing are ignored.

一致には Go 言語の `filepath.Match <http://golang.org/pkg/path/filepath#Match>`_ ルールを使います。処理前のステップでは、空白スペースと ``.`` と ``..`` 要素を Go 言語の `filepath.Clean <http://golang.org/pkg/path/filepath/#Clean>`_ を用いて除外します。

.. Lines starting with ! (exclamation mark) can be used to make exceptions to exclusions. The following is an example .dockerignore file that uses this mechanism:

行を ``!`` （エクスクラメーション・マーク）で始めると、除外ルールとして使えます。以下の例は ``.dockerignore`` ファイルでこの仕組みを使ったものです。

.. code-block:: bash

   *.md
   !README.md

.. All markdown files except README.md are excluded from the context.

`README.md` を除く全てのマークダウンファイルが、コンテントから除外されます。

.. The placement of ! exception rules influences the behavior: the last line of the .dockerignore that matches a particular file determines whether it is included or excluded. Consider the following example:

``!`` 除外ルールが影響を与えるのは、 ``.dockerignore`` ファイルに書いた場所以降に一致するパターンが現れた時、含めるか除外するかを決めます。次の例で考えて見ましょう。

.. code-block:: bash

   *.md
   !README*.md
   README-secret.md

.. No markdown files are included in the context except README files other than README-secret.md.

README を含むファイル以外は、``README-secret.md`` も含め、残り全てのマークダウンファイルが除外対象です。

.. Now consider this example:

その次の例を考えましょう。

.. code-block:: bash

   *.md
   README-secret.md
   !README*.md

.. All of the README files are included. The middle line has no effect because !README*.md matches README-secret.md and comes last.

README を含む全てのファイル除外します。真ん中の行 ``README-secret.md`` は最終行の ``!README*.md`` に一致するため、何の影響もありません。

.. You can even use the .dockerignore file to exclude the Dockerfile and .dockerignore files. These files are still sent to the daemon because it needs them to do its job. But the ADD and COPY commands do not copy them to image.

``.dockerignore`` ファイルは ``Dockerfile`` と ``.dockerignore`` ファイルの除外にも使えます。それでも、これらのファイルはジョブを処理するためデーモンに送信されます。しかし ``ADD`` と ``COPY`` コマンドは、これらをイメージ内にコピーしません。

.. Finally, you may want to specify which files to include in the context, rather than which to exclude. To achieve this, specify * as the first pattern, followed by one or more ! exception patterns.

最後に、特定のファイルのみコンテクストに含め、他を除外したい場合があるでしょう。実行するには、始めに ``*`` パターンに指定し、以下１つまたは複数の ``!`` 例外パターンを記述します。

.. Note: For historical reasons, the pattern . is ignored.

.. note::

   歴史的な理由により、 ``.`` パターンは無視されます。

.. _from:

FROM
==========

.. code-block:: dockerfile

   FROM <イメージ>

または

.. code-block:: dockerfile

   FROM <イメージ>:<タグ>

または

.. code-block:: dockerfile

   FROM <イメージ>@<digest>

.. The FROM instruction sets the Base Image for subsequent instructions. As such, a valid Dockerfile must have FROM as its first instruction. The image can be any valid image -- it is especially easy to start by pulling an image from the Public Repositories.

``FROM`` 命令は、以降の命令で使う :ref:`ベース・イメージ <base-image>` を指定します。あるいは、有効な ``Dockerfile`` は、１行めを ``FROM`` 命令で指定する必要があります。イメージとは、あらゆる有効なものが利用できます。 :doc:`パブリック・リポジトリ </engine/userguide/containers/dockerrepos>` から **イメージを取得する** 方法が一番簡単です。

..    FROM must be the first non-comment instruction in the Dockerfile.

* ``Dockerfile`` では、コメント以外では ``FROM`` を一番始めに書く必要があります。

..    FROM can appear multiple times within a single Dockerfile in order to create multiple images. Simply make a note of the last image ID output by the commit before each new FROM command.

* 単一の ``Dockerfile`` から複数のイメージを作成するため、複数の ``FROM`` を指定できます。各 ``FROM`` 命令ごとに自動的にコミットし、最新のイメージ ID が出力されるのを覚えておいてください。

..    The tag or digest values are optional. If you omit either of them, the builder assumes a latest by default. The builder returns an error if it cannot match the tag value.

* ``タグ`` や ``digest`` 値はオプションです。省略した場合、ビルダーはデフォルトの ``latest`` とみなします。ビルダーは一致する ``tag`` 値が無ければエラーを返します。

.. _maintainer:

MAINTAINER
==========

.. code-block:: dockerfile

    MAINTAINER <名前>

.. The MAINTAINER instruction allows you to set the Author field of the generated images.

``MAINTAINER`` 命令は、生成するイメージの *Author* （作者）フィールドを指定します。

.. _run:

RUN
==========

.. RUN has 2 forms:

RUN には２つの形式があります。

..  RUN <command> (shell form, the command is run in a shell - /bin/sh -c)
    RUN ["executable", "param1", "param2"] (exec form)

* ``RUN <コマンド>`` （シェル形式、コマンドを実行する。Linux 上のデフォルトは ``/bin/sh -c`` であり、Windows 上 ``cmd /S /C`` ）
* ``RUN ["実行バイナリ", "パラメータ１", "パラメータ２"]`` （ *exec* 形式）

.. The RUN instruction will execute any commands in a new layer on top of the current image and commit the results. The resulting committed image will be used for the next step in the Dockerfile.

``RUN`` 命令は既存イメージ上の新しいレイヤで、あらゆるコマンドを実行し、その結果をコミットする命令です。コミットの結果得られたイメージは、 ``Dockerfile`` の次のステップで使われます。

.. Layering RUN instructions and generating commits conforms to the core concepts of Docker where commits are cheap and containers can be created from any point in an image’s history, much like source control.

``RUN`` 命令の積み重ねとコミットによるイメージ生成は、 Docker の中心となるコンセプト（概念）に従ったものです。コミットは簡単であり、ソース・コントロールのように、イメージの履歴上のあらゆる場所からコンテナを作成可能です。

.. The exec form makes it possible to avoid shell string munging, and to RUN commands using a base image that does not contain the specified shell executable.

*exec* 形式はシェルの文字列を変更できないようにします。また、 指定されたシェル実行環境がベース・イメージに含まれなくても ``RUN`` コマンドを使えます。

.. The default shell for the *shell* form can be changed using the `SHELL` command.

デフォルトの *shell* のシェルを変更するには ``SHELL`` コマンドで変更できます。
 
.. In the shell form you can use a \ (backslash) to continue a single RUN instruction onto the next line. For example, consider these two lines:

*シェル* 形式では、RUN 命令を ``\`` （バックスラッシュ）を使い、次の行と連結します。例えば、次の２行があるとします。

.. code-block:: dockerfile

   RUN /bin/bash -c 'source $HOME/.bashrc ;\
   echo $HOME'

.. Together they are equivalent to this single line:

これは、次のように１行にできます。

.. code-block:: dockerfile

   RUN /bin/bash -c 'source $HOME/.bashrc ; echo $HOME'

..    Note: To use a different shell, other than ‘/bin/sh’, use the exec form passing in the desired shell. For example, RUN ["/bin/bash", "-c", "echo hello"]

.. note::

   「/bin/sh/」以外のシェルを使いたい場合は、exec 形式で任意のシェルを指定します。例： ``RUN ["/bin/bash", "-c", "echo hello"]`` 。

..    Note: The exec form is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘).

.. note::

   exec 形式は JSON 配列でパースされます。つまり、文字を囲むのはシングル・クォート(') ではなくダブル・クォート(")を使う必要があります。

..    Note: Unlike the shell form, the exec form does not invoke a command shell. This means that normal shell processing does not happen. For example, RUN [ "echo", "$HOME" ] will not do variable substitution on $HOME. If you want shell processing then either use the shell form or execute a shell directly, for example: RUN [ "sh", "-c", "echo", "$HOME" ].

.. note::

   *シェル* 形式と異なり、 *exec* 形式はコマンド・シェルを呼び出しません。つまり、通常のシェルによる処理が行われません。例えば ``RUN [ "echo", "$HOME" ]`` は ``$HOME`` の変数展開を行いません。シェルによる処理を行いたい場合は、 *シェル* 形式を使うか、あるいはシェルを直接指定します。例： ``RUN [ "sh", "-c", "echo", "$HOME" ]`` 。

.. Note: In the JSON form, it is necessary to escape backslashes. This is particularly relevant on Windows where the backslash is the path seperator. The following line would otherwise be treated as shell form due to not being valid JSON, and fail in an unexpected way: RUN ["c:\windows\system32\tasklist.exe"] The correct syntax for this example is: RUN ["c:\\windows\\system32\\tasklist.exe"]

.. note::

   JSON 形式では、バック・スラッシュはエスケープが必要です。特に関係があるのは Windows でパス区切りにバック・スラッシュを使う場合です。次の行は JSON 形式ではなくシェル形式と見なされエラーになります： ``RUN ["c:\windows\system32\tasklist.exe"]`` 。適切な構文は ``RUN ["c:\\windows\\system32\\tasklist.exe"]`` です。

.. The cache for RUN instructions isn’t invalidated automatically during the next build. The cache for an instruction like RUN apt-get dist-upgrade -y will be reused during the next build. The cache for RUN instructions can be invalidated by using the --no-cache flag, for example docker build --no-cache.

次の構築時、``RUN`` 命令によるキャッシュは自動的に無効化できません。 ``RUN apt-get dist-upgrade -y`` のような命令のキャッシュがあれば、次の構築時に再利用されます。 ``RUN`` 命令でキャッシュを使いたくない場合は、 ``--no-cache`` フラグを使います。例： ``docker build --no-cache`` .

.. See the Dockerfile Best Practices guide for more information.

より詳しい情報は ``Dockerfile`` :ref:`ベスト・プラクティス・ガイド <build-cache>` をご覧ください。

.. The cache for RUN instructions can be invalidated by ADD instructions. See below for details.

``RUN`` 命令のキャッシュは、　``ADD`` 命令によって無効化されます。詳細は :ref:`以下 <add>` をご覧ください。

.. Known issues (RUN)

既知の問題(RUN)
--------------------

..    Issue 783 is about file permissions problems that can occur when using the AUFS file system. You might notice it during an attempt to rm a file, for example.

* `Issue 783 <https://github.com/docker/docker/issues/783>`_ は、AUFS ファイルシステム使用時、ファイルのパーミッションに関する問題が起こり得ます。例えば、ファイルを ``rm`` しようとする場合は注意が必要です。

.. For systems that have recent aufs version (i.e., dirperm1 mount option can be set), docker will attempt to fix the issue automatically by mounting the layers with dirperm1 option. More details on dirperm1 option can be found at aufs man page

最近の aufs バージョンを使っているシステムでは（例： ``dirperm1`` マウント・オプションが利用可能 ）、docker は ``dirperm1`` オプションのレイヤをマウント時、自動的に問題を修正しようとします。 ``dirperm1`` オプションに関する詳細は、 ``aufs`` `man ページ <http://aufs.sourceforge.net/aufs3/man.html>`_ をご覧ください。

.. If your system doesn’t have support for dirperm1, the issue describes a workaround.

システムが ``dirperm1`` をサポートしていない場合は、issue に回避方法があります。

.. _cmd:

CMD
==========

.. The CMD instruction has three forms:

``CMD`` には３つの形式があります。

..    CMD ["executable","param1","param2"] (exec form, this is the preferred form)
    CMD ["param1","param2"] (as default parameters to ENTRYPOINT)
    CMD command param1 param2 (shell form)

* ``CMD ["実行バイナリ", "パラメータ１", "パラメータ２"]`` （ *exec* 形式、推奨する形式）
* ``CMD ["パラメータ１", "パラメータ２"]`` （ *ENTRYPOINT* のデフォルト・パラメータ）
* ``CMD <コマンド>`` （シェル形式）

.. There can only be one CMD instruction in a Dockerfile. If you list more than one CMD then only the last CMD will take effect.

``Dockerfile`` で ``CMD`` 命令を一度だけ指定できます。複数の ``CMD`` がある場合、最も後ろの ``CMD`` のみ有効です。

.. The main purpose of a CMD is to provide defaults for an executing container. These defaults can include an executable, or they can omit the executable, in which case you must specify an ENTRYPOINT instruction as well.

``CMD`` の主な目的は、 **コンテナ実行時のデフォルトを提供します** 。 デフォルトには、実行可能なコマンドが含まれているか、あるいは省略されるかもしれません。省略時は ``ENTRYPOINT`` 命令で同様に指定する必要があります。

..     Note: If CMD is used to provide default arguments for the ENTRYPOINT instruction, both the CMD and ENTRYPOINT instructions should be specified with the JSON array format.

.. note::

   ``ENTRYPOINT`` 命令のデフォルトの引数として ``CMD`` を使う場合、 ``CMD`` と ``ENTRYPOINT`` 命令の両方が JSON 配列フォーマットになっている必要があります。

..     Note: The exec form is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘).

.. note::

   *exec* 形式は JSON 配列でパースされます。つまり、文字を囲むのはシングル・クォート(') ではなくダブル・クォート(")を使う必要があります。

..     Note: Unlike the shell form, the exec form does not invoke a command shell. This means that normal shell processing does not happen. For example, CMD [ "echo", "$HOME" ] will not do variable substitution on $HOME. If you want shell processing then either use the shell form or execute a shell directly, for example: CMD [ "sh", "-c", "echo", "$HOME" ].

.. note::

   *シェル* 形式と異なり、 *exec* 形式はコマンド・シェルを呼び出しません。つまり、通常のシェルによる処理が行われません。例えば ``CMD [ "echo", "$HOME" ]`` は ``$HOME`` の変数展開を行いません。シェルによる処理を行いたい場合は、 *シェル* 形式を使うか、あるいはシェルを直接使います。例： ``CMD [ "sh", "-c", "echo", "$HOME" ]`` 。

.. When used in the shell or exec formats, the CMD instruction sets the command to be executed when running the image.

シェルあるいは exec 形式を使う時、 ``CMD`` 命令はイメージで実行するコマンドを指定します。

.. If you use the shell form of the CMD, then the <command> will execute in /bin/sh -c:

``CMD`` を *シェル* 形式で使えば、 ``<コマンド>`` は ``/bin/sh -c`` で実行されます。

.. code-block:: dockerfile

   FROM ubuntu
   CMD echo "This is a test." | wc -

.. If you want to run your <command> without a shell then you must express the command as a JSON array and give the full path to the executable. This array form is the preferred format of CMD. Any additional parameters must be individually expressed as strings in the array:

**<コマンド>をシェルを使わずに実行** したい場合、コマンドを JSON 配列で記述し、実行可能なフルパスで指定する必要があります。 **配列の形式が CMD では望ましい形式です** 。あらゆる追加パラメータは個々の配列の文字列として指定する必要があります。

.. code-block:: dockerfile

   FROM ubuntu
   CMD ["/usr/bin/wc","--help"]

.. If you would like your container to run the same executable every time, then you should consider using ENTRYPOINT in combination with CMD. See ENTRYPOINT.

もしコンテナで毎回同じものを実行するのであれば、 ``CMD`` と ``ENTRYPOINT`` の使用を検討ください。詳細は :ref:`ENTRYPOINT <entrypoint>` をご覧ください。

.. If the user specifies arguments to docker run then they will override the default specified in CMD.

ユーザが ``docker run`` で引数を指定した時、これらは ``CMD`` で指定したデフォルトを上書きします。

..    Note: don’t confuse RUN with CMD. RUN actually runs a command and commits the result; CMD does not execute anything at build time, but specifies the intended command for the image.

.. note::

   ``RUN`` と ``CMD`` を混同しないでください。 ``RUN`` が実際に行っているのは、コマンドの実行と結果のコミットです。一方の ``CMD`` は構築時には何もしませんが、イメージで実行するコマンドを指定します。

.. _label:

LABEL
==========

.. code-block:: dockerfile

   LABEL <key>=<value> <key>=<value> <key>=<value> ...

.. The LABEL instruction adds metadata to an image. A LABEL is a key-value pair. To include spaces within a LABEL value, use quotes and backslashes as you would in command-line parsing. A few usage examples:

``LABEL`` 命令はイメージにメタデータを追加します。 ``LABEL`` はキーとバリューのペアです。 ``LABEL`` の値に空白スペースを含む場合はクォートを使いますし、コマンドラインの分割にバックスラッシュを使います。使用例：

.. code-block:: dockerfile

   LABEL "com.example.vendor"="ACME Incorporated"
   LABEL com.example.label-with-value="foo"
   LABEL version="1.0"
   LABEL description="This text illustrates \
   that label-values can span multiple lines."

.. An image can have more than one label. To specify multiple labels, Docker recommends combining labels into a single LABEL instruction where possible. Each LABEL instruction produces a new layer which can result in an inefficient image if you use many labels. This example results in a single image layer.

イメージは複数のラベルを持てます。複数のラベルを指定したら、 Docker は可能であれば１つの ``LABEL`` にすることをお勧めします。各 ``LABEL`` 命令は新しいレイヤを準備しますが、多くのラベルを使えば、それだけレイヤを使います。次の例は１つのイメージ・レイヤを使うものです。

.. code-block:: dockerfile

   LABEL multi.label1="value1" multi.label2="value2" other="value3"

.. The above can also be written as:

上記の例は、次のようにも書き換えられます。

.. code-block:: dockerfile

   LABEL multi.label1="value1" \
         multi.label2="value2" \
         other="value3"

.. Labels are additive including LABELs in FROM images. If Docker encounters a label/key that already exists, the new value overrides any previous labels with identical keys.

ラベルには、``FROM`` イメージが使う ``LABEL`` も含まれています。ラベルのキーが既に存在している時、Docker は特定のキーを持つラベルの値を上書きします。

.. To view an image’s labels, use the docker inspect command.

イメージが使っているラベルを確認するには、 ``docker inspect`` コマンドを使います。

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

.. _expose:

EXPOSE
==========

.. code-block:: dockerfile

   EXPOSE <port> [<port>...]

.. The EXPOSE instruction informs Docker that the container listens on the specified network ports at runtime. EXPOSE does not make the ports of the container accessible to the host. To do that, you must use either the -p flag to publish a range of ports or the -P flag to publish all of the exposed ports. You can expose one port number and publish it externally under another number.

``EXPOSE`` 命令は、特定のネットワーク・ポートをコンテナが実行時にリッスンすることを Docker に伝えます。 ``EXPOSE`` があっても、これだけではホストからコンテナにアクセスできるようにしません。アクセスするには、 ``-p`` フラグを使ってポートの公開範囲を指定するか、 ``-P`` フラグで全ての露出ポートを公開する必要があります。外部への公開時は他のポート番号も利用可能です。

.. To set up port redirection on the host system, see using the -P flag. The Docker network feature supports creating networks without the need to expose ports within the network, for detailed information see the overview of this feature).

ホストシステム上でポート転送を使うには、 :ref:`-P フラグを使う <expose-incoming-ports>` をご覧ください。Docker のネットワーク機能は、ネットワーク内でポートを公開しないネットワークを作成可能です。詳細な情報は :doc:`機能概要 </engine/userguide/networking/index>` をご覧ください。

.. _env:

ENV
==========

.. code-block:: dockerfile

   ENV <key> <value>
   ENV <key>=<value> ...

.. The ENV instruction sets the environment variable <key> to the value <value>. This value will be in the environment of all “descendant” Dockerfile commands and can be replaced inline in many as well.

``ENV`` 命令は、環境変数 ``<key>`` と 値 ``<value>`` のセットです。値は ``Dockerfile`` から派生する全てのコマンド環境で利用でき、 :ref:`インラインで置き換え <environment-replacement>` も可能です。

.. The ENV instruction has two forms. The first form, ENV <key> <value>, will set a single variable to a value. The entire string after the first space will be treated as the <value> - including characters such as spaces and quotes.

``ENV`` 命令は２つの形式があります。１つめは、 ``ENV <key> <value>`` であり、変数に対して１つの値を設定します。はじめの空白以降の文字列が ``<value>`` に含まれます。ここには空白もクォートも含まれます。

.. The second form, ENV <key>=<value> ..., allows for multiple variables to be set at one time. Notice that the second form uses the equals sign (=) in the syntax, while the first form does not. Like command line parsing, quotes and backslashes can be used to include spaces within values.

２つめの形式は ``ENV <key>=<value> ...`` です。これは一度に複数の変数を指定できます。先ほどと違い、構文の２つめにイコールサイン（=）があるので気を付けてください。コマンドラインの分割、クォート、バックスラッシュは、空白スペースも含めて値になります。

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

.. will yield the same net results in the final container, but the first form is preferred because it produces a single cache layer.

この例では、どちらも最終的に同じ結果をコンテナにもたらしますが、私たちが推奨するのは前者です。理由は前者であれば単一のキャッシュ・レイヤしか使わないからです。

.. The environment variables set using ENV will persist when a container is run from the resulting image. You can view the values using docker inspect, and change them using docker run --env <key>=<value>.

環境変数の設定に ``ENV`` を使えば、作成したイメージを使ってコンテナを実行しても有効です。どのような値が設定されているかは ``docker inspect`` で確認でき、変更するには ``docker run --env <key>=<value>`` を使います。

..    Note: Environment persistence can cause unexpected side effects. For example, setting ENV DEBIAN_FRONTEND noninteractive may confuse apt-get users on a Debian-based image. To set a value for a single command, use RUN <key>=<value> <command>.

.. note::

   環境変数の一貫性は予期しない影響を与える場合があります。例えば、 ``ENV DEBIAN_FRONTEND noninteractive`` が設定されていると、Debian ベースのイメージで apt-get の利用者が混乱するかもしれません。１つのコマンドだけで値を設定するには、 ``RUN <key>=<value> <コマンド>`` を使います。

.. _add:

ADD
==========

.. ADD has two forms:

Add は２つの形式があります。

..    ADD <src>... <dest>
    ADD ["<src>",... "<dest>"] (this form is required for paths containing whitespace)

* ``ADD <ソース>... <送信先>``
* ``ADD ["<ソース>", ... "<送信先>"]`` （この形式はパスに空白スペースを使う場合に必要）

.. The ADD instruction copies new files, directories or remote file URLs from <src> and adds them to the filesystem of the container at the path <dest>.

``ADD`` 命令は ``<ソース>`` にある新しいファイルやディレクトリをコピー、あるいはリモートの URL からコピーします。それから、コンテナ内のファイルシステム上にある ``送信先`` に指定されたパスに追加します。

.. Multiple <src> resource may be specified but if they are files or directories then they must be relative to the source directory that is being built (the context of the build).

複数の ``<ソース>`` リソースを指定できます。この時、ファイルやディレクトリはソースディレクトリ（構築時のコンテクスト）からの相対パス上に存在しないと構築できません。

.. Each <src> may contain wildcards and matching will be done using Go’s filepath.Match rules. For example:

それぞれの ``<ソース>`` にはワイルドカードと Go 言語の `filepath.Match <http://golang.org/pkg/path/filepath#Match>`_ ルールに一致するパターンが使えます。例えば、次のような記述です。

.. code-block:: dockerfile

   ADD hom* /mydir/        # "hom" で始まる全てのファイルを追加
   ADD hom?.txt /mydir/    # ? は１文字だけ一致します。例： "home.txt"

.. The <dest> is an absolute path, or a path relative to WORKDIR, into which the source will be copied inside the destination container.

``<送信先>`` は絶対パスです。あるいは、パスは ``WORKDIR`` からの相対パスです。ソースにあるものが、対象となる送信先コンテナの中にコピーされます。

.. code-block:: dockerfile

   ADD test relativeDir/          # "test" を `WORKDIR`/relativeDir/ （相対ディレクトリ）に追加
   ADD test /absoluteDir/          # "test" を /absoluteDir/ （絶対ディレクトリ）に追加

.. All new files and directories are created with a UID and GID of 0.

追加される新しいファイルやディレクトリは、全て UID と GID が 0 として作成されます。

.. In the case where <src> is a remote file URL, the destination will have permissions of 600. If the remote file being retrieved has an HTTP Last-Modified header, the timestamp from that header will be used to set the mtime on the destination file. However, like any other file processed during an ADD, mtime will not be included in the determination of whether or not the file has changed and the cache should be updated.

``<ソース>`` がリモート URL の場合は、送信先のパーミッションは 600 にします。もしリモートのファイルが HTTP ``Last-Modified`` ヘッダを返す場合は、このヘッダの情報を元に送信先ファイルの ``mtime`` を指定するのに使います。しかしながら、 ``ADD`` を使ったファイルをコピーする手順では、 ``mtime`` はファイルが更新されたかどうかの決定には使われず、ファイルが更新されればキャッシュも更新されます。

..    Note: If you build by passing a Dockerfile through STDIN (docker build - < somefile), there is no build context, so the Dockerfile can only contain a URL based ADD instruction. You can also pass a compressed archive through STDIN: (docker build - < archive.tar.gz), the Dockerfile at the root of the archive and the rest of the archive will get used at the context of the build.

.. note::

   ``Dockerfile`` を標準入力（ ``docker build - < 何らかのファイル`` ）を通して構築しようとしても。構築時のコンテントは存在しないため、 ``Dockerfile`` には URL を指定する ``ADD`` 命令のみ記述可能です。また、圧縮ファイルを標準入力（ ``docker build - < archive.tar.gz`` ）を通すことができ、アーカイブに含まれるルートに ``Dockerfile`` があれば、構築時のコンテクストとしてアーカイブが使われます。

..    Note: If your URL files are protected using authentication, you will need to use RUN wget, RUN curl or use another tool from within the container as the ADD instruction does not support authentication.

.. note::

   URL で指定したファイルに認証がかかっている場合は、 ``RUN wget`` や ``RUN curl`` や他のツールを使う必要があります。これは ``ADD`` 命令が認証機能をサポートしていないからです。

..    Note: The first encountered ADD instruction will invalidate the cache for all following instructions from the Dockerfile if the contents of <src> have changed. This includes invalidating the cache for RUN instructions. See the Dockerfile Best Practices guide for more information.

.. note::

   ``ADD`` 命令の処理時、まず ``<ソース>`` に含まれる内容が変更されていれば、以降の ``Dockerfile`` に書かれている命令のキャッシュを全て無効化します。これは ``RUN`` 命令のキャッシュ無効化も含まれます。より詳細な情報については ``Dockerfile`` の :ref:`ベスト・プラクティス・ガイド <build-cache>` をご覧ください。

.. ADD obeys the following rules:

``ADD`` は以下のルールに従います。

..    The <src> path must be inside the context of the build; you cannot ADD ../something /something, because the first step of a docker build is to send the context directory (and subdirectories) to the docker daemon.

* ``<ソース>`` パスは、構築時の *コンテント* 内にある必要があります。そのため、 ``ADD ../something /something`` の指定はできません。 ``docker build`` の最初のステップで、コンテクストのディレクトリ（と、サブディレクトリ）を docker デーモンに送るためです。

..    If <src> is a URL and <dest> does not end with a trailing slash, then a file is downloaded from the URL and copied to <dest>.

* ``<ソース>`` が URL であり、 ``<送信先>`` の末尾にスラッシュが無い場合、URL からファイルをダウンロードし、 ``<送信先>`` にコピーします。

..    If <src> is a URL and <dest> does end with a trailing slash, then the filename is inferred from the URL and the file is downloaded to <dest>/<filename>. For instance, ADD http://example.com/foobar / would create the file /foobar. The URL must have a nontrivial path so that an appropriate filename can be discovered in this case (http://example.com will not work).

* もし ``<ソース>`` が URL であり、 ``<送信先>`` の末尾がスラッシュの場合、URL からファイル名を推測し、ファイルを ``<送信先>/<ファイル名>`` にダウンロードします。例えば、 ``ADD http://example.com/foobar /`` は、 ``/foobar`` ファイルを作成します。URL には何らかのパスが必要です。これは適切なファイル名を見つけられない場合があるためです（今回の例では、 ``http://example.com`` の指定は動作しません）。

..    If <src> is a directory, the entire contents of the directory are copied, including filesystem metadata.

* ``<ソース>`` がディレクトリの場合、ディレクトリの内容の全てをコピーします。これにはファイルシステムのメタデータを含みます。

..    Note: The directory itself is not copied, just its contents.

.. note::

   ディレクトリ自身はコピーされません。ディレクトリは単なるコンテントの入れ物です。

..    If <src> is a local tar archive in a recognized compression format (identity, gzip, bzip2 or xz) then it is unpacked as a directory. Resources from remote URLs are not decompressed. When a directory is copied or unpacked, it has the same behavior as tar -x: the result is the union of:

* もし ``<ソース>`` が *ローカル* にある tar アーカイブの場合、圧縮フォーマットを認識します（gzip、bzip2、xz を認識）。それからディレクトリに展開します。 *リモート* の URL が指定された場合は展開 **しません**。ディレクトリにコピーまたは展開する時は、 ``tar -x`` と同じ働きをします。結果は次の処理を同時に行います。

..        Whatever existed at the destination path and
..        The contents of the source tree, with conflicts resolved in favor of “2.” on a file-by-file basis.

1. 送信先のパスが存在しているかどうか
2. ファイル単位の原則に従って、ソース・ツリーの内容と衝突しないかどうか「2」を繰り返す

.. Note: Whether a file is identified as a recognized compression format or not is done solely based on the contents of the file, not the name of the file. For example, if an empty file happens to end with .tar.gz this will not be recognized as a compressed file and will not generate any kind of decompression error message, rather the file will simply be copied to the destination.

.. note::

   ファイルが圧縮フォーマットと認識するか、あるいはファイルの集まりをベースにしているのかは、ファイルの名前では判断しません。例えば、空のファイル名の拡張子が ``.tar.gz`` だとしても、圧縮ファイルと認識しないため、展開エラーのメッセージを表示 **しません** 。そして単純に送信先にファイルをコピーします。

..    If <src> is any other kind of file, it is copied individually along with its metadata. In this case, if <dest> ends with a trailing slash /, it will be considered a directory and the contents of <src> will be written at <dest>/base(<src>).

* もし ``<ソース>`` がファイル以外であれば、個々のメタデータと一緒にコピーします。 ``<送信先>`` の末尾がスラッシュ ``/`` で終わる場合は、ディレクトリであるとみなし、 ``<ソース>`` の内容を ``<送信先>/base(<ソース>)`` に書き込みます。

..    If multiple <src> resources are specified, either directly or due to the use of a wildcard, then <dest> must be a directory, and it must end with a slash /.

* もし複数の ``<ソース>`` リソースが指定された場合や、ディレクトリやワイルドカードを使った場合、 ``<送信先>`` は必ずディレクトリになり、最後はスラッシュ ``/`` にしなければいけません。

..    If <dest> does not end with a trailing slash, it will be considered a regular file and the contents of <src> will be written at <dest>.

* もし ``<送信先>`` の末尾がスラッシュで終わらなければ、通常のファイルとみなされ、 ``<ソース>`` の内容は ``<送信先>`` として書き込まれます。

..    If <dest> doesn’t exist, it is created along with all missing directories in its path.

* ``<送信先>`` が存在しなければ、パスに存在しないディレクトリを作成します。

.. _copy:

COPY
==========

.. COPY has two forms:

COPY は２つの形式があります。

..    COPY <src>... <dest>
    COPY ["<src>",... "<dest>"] (this form is required for paths containing whitespace)

* ``COPY <ソース>... <送信先>``
* ``COPY ["<ソース>",... "<送信先>"]`` （この形式はパスに空白スペースを使う場合に必要）

.. The COPY instruction copies new files or directories from <src> and adds them to the filesystem of the container at the path <dest>.

``COPY`` 命令は ``<ソース>`` にある新しいファイルやディレクトリをコピーするもので、コンテナ内のファイルシステム上にある ``<送信先>`` に指定されたパスに追加します。

.. Multiple <src> resource may be specified but they must be relative to the source directory that is being built (the context of the build).

複数の ``<ソース>`` リソースを指定できます。この時、ソースディレクトリ（構築時のコンテクスト）からの相対パス上に存在しないと構築できません。

.. Each <src> may contain wildcards and matching will be done using Go’s filepath.Match rules. For example:

それぞれの ``<ソース>`` にはワイルドカードと Go 言語の `filepath.Match <http://golang.org/pkg/path/filepath#Match>`_ ルールに一致するパターンが使えます。例えば、次のような記述です。

.. code-block:: dockerfile

   COPY hom* /mydir/        # "hom" で始まる全てのファイルを追加
   COPY hom?.txt /mydir/    # ? は１文字だけ一致します。例： "home.txt"

.. The <dest> is an absolute path, or a path relative to WORKDIR, into which the source will be copied inside the destination container.

``<送信先>`` は絶対パスです。あるいは、パスは ``WORKDIR`` からの相対パスです。ソースにあるものが、対象となる送信先コンテナの中にコピーされます。

.. code-block:: dockerfile

   COPY test relativeDir/   # "test" を `WORKDIR`/relativeDir/ （相対ディレクトリ）に追加
   COPY test /absoluteDir/   # "test" を /absoluteDir/ （絶対ディレクトリ）に追加

.. All new files and directories are created with a UID and GID of 0.

追加される新しいファイルやディレクトリは、全て UID と GID が 0 として作成されます。

..    Note: If you build using STDIN (docker build - < somefile), there is no build context, so COPY can’t be used.

.. note::

   標準入力（ ``docker build - < 何らかのファイル`` ）を使って構築しようとしても、構築時のコンテントは存在しないため、 ``COPY`` を使えません。

.. COPY obeys the following rules:

``COPY`` は以下のルールに従います。

..    The <src> path must be inside the context of the build; you cannot COPY ../something /something, because the first step of a docker build is to send the context directory (and subdirectories) to the docker daemon.

* ``<ソース>`` パスは、構築時の *コンテント* 内にある必要があります。そのため、 ``COPY ../something /something`` の指定はできません。 ``docker build`` の最初のステップで、コンテクストのディレクトリ（と、サブディレクトリ）を docker デーモンに送るためです。

..    If <src> is a directory, the entire contents of the directory are copied, including filesystem metadata.

* ``<ソース>`` がディレクトリの場合、ディレクトリ内容の全てをコピーします。これにはファイルシステムのメタデータを含みます。

..    Note: The directory itself is not copied, just its contents.

.. note::

   ディレクトリ自身はコピーしません。ディレクトリは単なるコンテントの入れ物です。

..     If <src> is any other kind of file, it is copied individually along with its metadata. In this case, if <dest> ends with a trailing slash /, it will be considered a directory and the contents of <src> will be written at <dest>/base(<src>).

* もし ``<ソース>`` がファイル以外であれば、個々のメタデータと一緒にコピーします。 ``<送信先>`` の末尾がスラッシュ ``/`` で終わる場合は、ディレクトリであるとみなし、 ``<ソース>`` の内容を ``<送信先>/base(<ソース>)`` に書き込みます。

..    If multiple <src> resources are specified, either directly or due to the use of a wildcard, then <dest> must be a directory, and it must end with a slash /.

* もし複数の ``<ソース>`` リソースが指定された場合や、ディレクトリやワイルドカードを使った場合、 ``<送信先>`` は必ずディレクトリになり、最後はスラッシュ ``/`` にしなければいけません。

..    If <dest> does not end with a trailing slash, it will be considered a regular file and the contents of <src> will be written at <dest>.

* もし ``<送信先>`` の末尾がスラッシュで終わらなければ、通常のファイルとみなされ、 ``<ソース>`` の内容は ``<送信先>`` として書き込まれます。

..    If <dest> doesn’t exist, it is created along with all missing directories in its path.

* ``<送信先>`` が存在しなければ、パスに存在しないディレクトリを作成します。

.. _entrypoint:

ENTRYPOINT
==========

.. ENTRYPOINT has two forms:

ENTRYPOINT には２つの形式があります。

..    ENTRYPOINT ["executable", "param1", "param2"] (exec form, preferred)
    ENTRYPOINT command param1 param2 (shell form)

* ``ENTRYPOINT ["実行可能なもの", "パラメータ１", "パラメータ２"]`` （ *exec* 形式、推奨）
* ``ENTRYPOINT コマンド パラメータ１ パラメータ２`` （ *シェル* 形式）

.. An ENTRYPOINT allows you to configure a container that will run as an executable.

``ENTRYPOINT`` はコンテナが実行するファイルを設定します。

.. For example, the following will start nginx with its default content, listening on port 80:

例えば、次の例は nginx をデフォルトの内容で開始し、ポート 80 を開きます。

.. code-block:: bash

    docker run -i -t --rm -p 80:80 nginx

.. Command line arguments to docker run <image> will be appended after all elements in an exec form ENTRYPOINT, and will override all elements specified using CMD. This allows arguments to be passed to the entry point, i.e., docker run <image> -d will pass the -d argument to the entry point. You can override the ENTRYPOINT instruction using the docker run --entrypoint flag.

コマンドラインで ``docker run <イメージ>`` コマンドに引数を付けますと、*exec* 形式 の ``ENTRYPOINT`` で指定した全要素の後に追加します。そして、この時に ``CMD`` を使って指定していた要素を上書きします。この動きにより、引数はエントリ・ポイント（訳者注：指定されたバイナリ）に渡されます。例えば、 ``docker run <イメージ> -d`` は、引数 ``-d`` をエントリポイントに渡します。 ``ENTRYPOINT`` 命令を上書きするには、 ``docker run --entrypoint`` フラグを使います。

.. The shell form prevents any CMD or run command line arguments from being used, but has the disadvantage that your ENTRYPOINT will be started as a subcommand of /bin/sh -c, which does not pass signals. This means that the executable will not be the container’s PID 1 - and will not receive Unix signals - so your executable will not receive a SIGTERM from docker stop <container>.

*シェル* 形式では ``CMD`` や ``run`` コマンド行の引数を使えないという不利な点があります。 ``ENTRYPOINT`` は ``/bin/sh -c`` のサブコマンドとして実行されるため、シグナルを渡せません。つまり、何かを実行してもコンテナの ``PID 1`` にはなりません。そして、 Unix シグナルを受け付け *ません*。そのため、実行ファイルは ``docker stop <コンテナ>`` を実行しても、 ``SIGTERM``  を受信しません。

.. Only the last ENTRYPOINT instruction in the Dockerfile will have an effect.

なお、 ``Dockerfile`` の最後に現れた ``ENTRYPOINT`` 命令のみ有効です。

.. Exec form ENTRYPOINT example

exec 形式の ENTRYPOINT 例
------------------------------

.. You can use the exec form of ENTRYPOINT to set fairly stable default commands and arguments and then use either form of CMD to set additional defaults that are more likely to be changed.

``ENTRYPOINT`` の *exec* 形式を使い、適切なデフォルトのコマンドと引数を指定します。それから ``CMD`` を使い、変更する可能性のある追加のデフォルト引数も指定します。

.. code-block:: dockerfile

   FROM ubuntu
   ENTRYPOINT ["top", "-b"]
   CMD ["-c"]

.. When you run the container, you can see that top is the only process:

コンテナを実行したら、 ``top`` のプロセスが１つだけ見えます。

.. code-block:: bash

   $ docker run -it --rm --name test  top -H
   top - 08:25:00 up  7:27,  0 users,  load average: 0.00, 0.01, 0.05
   Threads:   1 total,   1 running,   0 sleeping,   0 stopped,   0 zombie
   %Cpu(s):  0.1 us,  0.1 sy,  0.0 ni, 99.7 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
   KiB Mem:   2056668 total,  1616832 used,   439836 free,    99352 buffers
   KiB Swap:  1441840 total,        0 used,  1441840 free.  1324440 cached Mem
   
     PID USER      PR  NI    VIRT    RES    SHR S %CPU %MEM     TIME+ COMMAND
       1 root      20   0   19744   2336   2080 R  0.0  0.1   0:00.04 top

.. To examine the result further, you can use docker exec:

より詳細なテストをするには、 ``docker exec`` コマンドが使えます。

.. code-block:: bash

   $ docker exec -it test ps aux
   USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
   root         1  2.6  0.1  19752  2352 ?        Ss+  08:24   0:00 top -b -H
   root         7  0.0  0.1  15572  2164 ?        R+   08:25   0:00 ps aux

.. And you can gracefully request top to shut down using docker stop test.

それから、``docker stop test`` を使い ``top`` を停止するよう、通常のリクエストを行えます。

.. The following Dockerfile shows using the ENTRYPOINT to run Apache in the foreground (i.e., as PID 1):

次の ``Dockerfile`` は ``ENTRYPOINT`` を使って Apache をフォアグラウンドで実行します（つまり、 ``PID 1`` として）。

.. code-block:: dockerfile

   FROM debian:stable
   RUN apt-get update && apt-get install -y --force-yes apache2
   EXPOSE 80 443
   VOLUME ["/var/www", "/var/log/apache2", "/etc/apache2"]
   ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]

.. If you need to write a starter script for a single executable, you can ensure that the final executable receives the Unix signals by using exec and gosu commands:

もし実行するだけの起動スクリプトを書く必要があれば、最後に実行するコマンドが Unix シグナルを受信できるよう、 ``exec`` と ``gosu`` コマンドを使うことで可能になります。

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

.. Lastly, if you need to do some extra cleanup (or communicate with other containers) on shutdown, or are co-ordinating more than one executable, you may need to ensure that the ENTRYPOINT script receives the Unix signals, passes them on, and then does some more work:

もしも、シャットダウン時に何らかの追加クリーンアップ（あるいは、他のコンテナとの通信）が必要な場合や、１つ以上の実行ファイルと連携したい場合は、 ``ENTRYPOINT`` のスクリプトが Unix シグナルを受信出来るようにし、それを使って様々な処理を行います。

.. code-block:: bash

   #!/bin/sh
   # メモ：これは sh を使っていますので、busyboy コンテナでも動きます
   
   # サービス停止時に手動でもクリーンアップが必要な場合は trap を使います。
   # あるいは１つのコンテナ内に複数のサービスを起動する必要があります。
   trap "echo TRAPed signal" HUP INT QUIT TERM
   
   # ここからバックグラウンドでサービスを開始します
   /usr/sbin/apachectl start
   
   echo "[hit enter key to exit] or run 'docker stop <container>'"
   read
   
   # ここからサービスを停止し、クリーンアップします
   echo "stopping apache"
   /usr/sbin/apachectl stop
   
   echo "exited $0"

.. If you run this image with docker run -it --rm -p 80:80 --name test apache, you can then examine the container’s processes with docker exec, or docker top, and then ask the script to stop Apache:

このイメージを ``docker run -it --rm -p 80:80 --name test apache`` で実行したら、コンテナのプロセス状態を ``docker exec`` や ``docker top`` で調べられます。それから、スクリプトに Apache 停止を依頼します。

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

..    Note: you can over ride the ENTRYPOINT setting using --entrypoint, but this can only set the binary to exec (no sh -c will be used).

.. note::

   ``ENTRYPIONT`` 設定は ``--entrypoint``  を使って上書きできますが、設定できるのはバイナリが実行可能な場合のみです（ ``sh -c`` が使われていない時のみ ）。

..    Note: The exec form is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘).

.. note::

   *exec* 形式は JSON 配列でパースされます。つまり、語句はシングルクォート(')ではなく、ダブルクォート(")で囲む必要があります。

..    Note: Unlike the shell form, the exec form does not invoke a command shell. This means that normal shell processing does not happen. For example, ENTRYPOINT [ "echo", "$HOME" ] will not do variable substitution on $HOME. If you want shell processing then either use the shell form or execute a shell directly, for example: ENTRYPOINT [ "sh", "-c", "echo $HOME" ]. Variables that are defined in the Dockerfileusing ENV, will be substituted by the Dockerfile parser.

.. note::

   *シェル* 形式とは異なり、 *exec* 形式はシェルを呼び出しません。つまり、通常のシェル上の処理はされません。例えば、 ``ENTRYPOINT ["echo", "$HOME"]`` は ``$HOME`` を変数展開しません。シェル上の処理が必要であれば、 *シェル* 形式を使うか、シェルを直接実行します。例： ``ENTRYPOINT [ "sh", "-c", "echo $HOME" ]``。変数は ``Dockerfile`` で ``ENV`` を使って定義することができ、 ``Dockerfile`` パーサー上で展開されます。

.. Shell form ENTRYPOINT example

シェル形式の ENTRYPOINT 例
------------------------------

.. You can specify a plain string for the ENTRYPOINT and it will execute in /bin/sh -c. This form will use shell processing to substitute shell environment variables, and will ignore any CMD or docker run command line arguments. To ensure that docker stop will signal any long running ENTRYPOINT executable correctly, you need to remember to start it with exec:

``ENTRYPOINT`` に文字列を指定したら、 ``/bin/sh -c`` で実行されます。この形式はシェルの処理を使いますので、シェル上の環境変数を展開し、 ``CMD`` や ``docker run`` コマンド行の引数を無視します。 ``docker stop`` で ``ENTRYPOINT`` で指定している実行ファイルにシグナルを送りたい場合は、 ``exec`` を使う必要があるのを思い出してください。

.. code-block:: dockerfile

   FROM ubuntu
   ENTRYPOINT exec top -b

.. When you run this image, you’ll see the single PID 1 process:

このイメージを実行したら、単一の ``PID 1`` プロセスが表示されます。

.. code-block:: bash

   $ docker run -it --rm --name test top
   Mem: 1704520K used, 352148K free, 0K shrd, 0K buff, 140368121167873K cached
   CPU:   5% usr   0% sys   0% nic  94% idle   0% io   0% irq   0% sirq
   Load average: 0.08 0.03 0.05 2/98 6
     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
       1     0 root     R     3164   0%   0% top -b

.. Which will exit cleanly on docker stop:

終了するには、 ``docker stop`` を実行します。

.. code-block:: bash

   $ /usr/bin/time docker stop test
   test
   real    0m 0.20s
   user    0m 0.02s
   sys 0m 0.04s

.. If you forget to add exec to the beginning of your ENTRYPOINT:

``ENTRYPOINT`` に ``exec`` を追加し忘れたとします。

.. code-block:: dockerfile

   FROM ubuntu
   ENTRYPOINT top -b
   CMD --ignored-param1

.. You can then run it (giving it a name for the next step):

次のように実行します（次のステップで名前を使います）。

.. code-block:: bash

   $ docker run -it --name test top --ignored-param2
   Mem: 1704184K used, 352484K free, 0K shrd, 0K buff, 140621524238337K cached
   CPU:   9% usr   2% sys   0% nic  88% idle   0% io   0% irq   0% sirq
   Load average: 0.01 0.02 0.05 2/101 7
     PID  PPID USER     STAT   VSZ %VSZ %CPU COMMAND
       1     0 root     S     3168   0%   0% /bin/sh -c top -b cmd cmd2
       7     1 root     R     3164   0%   0% top -b

.. You can see from the output of top that the specified ENTRYPOINT is not PID 1.

``top`` の出力から、 ``ENTRYPOINT`` が ``PID 1`` ではないことが分かるでしょう。

.. If you then run docker stop test, the container will not exit cleanly - the stop command will be forced to send a SIGKILL after the timeout:

それから ``docker stop test`` を実行しても、コンテナはすぐに終了しません。これは ``stop`` コマンドがタイムアウト後、``SIGKILL`` を強制送信したからです。

.. code-block:: bash

   $ docker exec -it test ps aux
   PID   USER     COMMAND
       1 root     /bin/sh -c top -b cmd cmd2
       7 root     top -b
       8 root     ps aux
   $ /usr/bin/time docker stop test
   test
   real    0m 10.19s
   user    0m 0.04s
   sys 0m 0.03s

.. Understand how CMD and ENTRYPOINT interact

.. _understand-how-cmd-and-entrypoint-interact:

CMD と ENTRYPOINT がどのように作用するか学ぶ
==================================================

.. Both CMD and ENTRYPOINT instructions define what command gets executed when running a container. There are few rules that describe their co-operation.

``CMD`` と ``ENTRYPOINT`` 命令はコンテナ起動時に実行するコマンドを定義します。両方を記述する時、動作には複数のルールがあります。

..    Dockerfile should specify at least one of CMD or ENTRYPOINT commands.

1. Dockerfile には少なくとも１つの ``CMD`` または ``ENTRYPOINT`` 命令を含むべきです。

..    ENTRYPOINT should be defined when using the container as an executable.

2. ``ENTRYPOINT`` は実行可能なコンテナとして定義する時に使うべきです。

..    CMD should be used as a way of defining default arguments for an ENTRYPOINT command or for executing an ad-hoc command in a container.

3. コンテナをアドホック（その場その場）で実行するコマンドを ``ENTRYPOINT`` にする場合、そのデフォルトの引数の指定として ``CMD`` を指定すべきです。

..    CMD will be overridden when running the container with alternative arguments.

4. ``CMD`` はコンテナ実行時に引数を指定すると上書します。

.. The table below shows what command is executed for different ENTRYPOINT / CMD combinations:

以下の表は ``ENTRYPOINT`` / ``CMD`` を組み合わせたコマンドの実行結果です。

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

.. The VOLUME instruction creates a mount point with the specified name and marks it as holding externally mounted volumes from native host or other containers. The value can be a JSON array, VOLUME ["/var/log/"], or a plain string with multiple arguments, such as VOLUME /var/log or VOLUME /var/log /var/db. For more information/examples and mounting instructions via the Docker client, refer to Share Directories via Volumes documentation.

``VOLUME`` 命令は指定した名前でマウントポイントを作成し、他のホストやコンテナから外部マウント可能なボリュームにします。指定する値は ``VOLUME ["/var/log"]`` といったJSON 配列になるべきです。あるいは文字列で ``VOLUME /var/log`` や ``VOLUME /var/log /var/db`` のように、複数の引数を書くこともできます。Docker クライアントを使ったマウント命令や詳しい情報やサンプルは :ref:`ボリュームを経由してディレクトリを共有 <mount-a-host-directory-as-a-data-volume>` をご覧ください。

.. The docker run command initializes the newly created volume with any data that exists at the specified location within the base image. For example, consider the following Dockerfile snippet:

``docker run`` コマンドは、ベース・イメージから指定した場所に、データを保存する場所として新規作成したボリュームを初期化します。例えば、次の Dockerfile をご覧ください。

.. code-block:: dockerfile

   FROM ubuntu
   RUN mkdir /myvol
   RUN echo "hello world" > /myvol/greeting
   VOLUME /myvol

.. This Dockerfile results in an image that causes docker run, to create a new mount point at /myvol and copy the greeting file into the newly created volume.

この Dockerfile によって作られたイメージは、 ``docker run`` を実行したら、新しいマウント・ポイント ``/myvol`` を作成し、``greeting`` ファイルを直近で作成したボリュームにコピーします。

..     Note: If any build steps change the data within the volume after it has been declared, those changes will be discarded.

.. note::

   構築ステップでボリューム内においてあらゆる変更を加えても、宣言後に内容は破棄されます。

..    Note: The list is parsed as a JSON array, which means that you must use double-quotes (“) around words not single-quotes (‘).

.. note::

   リストは JSON 配列でパースされます。これが意味するのは、単語はシングルクォート(')で囲むのではなく、ダブルクォート(")を使う必要があります。

.. _user:

USER
==========

.. code-block:: dockerfile

   USER daemon

.. The USER instruction sets the user name or UID to use when running the image and for any RUN, CMD and ENTRYPOINT instructions that follow it in the Dockerfile.

``USER`` 命令セットはユーザ名か UID を使います。これはイメージを ``RUN`` 、 ``CMD`` 、 ``ENTRYPOINT`` 命令で実行時のものであり、 ``Dockerfile`` で指定します。

.. _workdir:

WORKDIR
==========

.. code-block:: dockerfile

   WORKDIR /path/to/workdir

.. The WORKDIR instruction sets the working directory for any RUN, CMD, ENTRYPOINT, COPY and ADD instructions that follow it in the Dockerfile. If the WORKDIR doesn't exist, it will be created even if it's not used in any subsequent `Dockerfile` instruction.

``WORKDIR`` 命令セットは ``Dockerfile`` で ``RUN`` 、 ``CMD`` 、 ``ENTRYPOINT`` 、 ``COPY`` 、 ``ADD`` 命令実行時の作業ディレクトリ（working directory）を指定します。もし ``WORKDIR`` が存在しなければ、 ``Dockerfile`` 命令内で使用しなくてもディレクトリを作成します。

.. It can be used multiple times in the one Dockerfile. If a relative path is provided, it will be relative to the path of the previous WORKDIR instruction. For example:

１つの ``Dockerfile`` で複数回の利用が可能です。パスを指定したら、 ``WORKDIR`` 命令は直前に指定した相対パスに切り替えます。例：

.. code-block:: dockerfile

   WORKDIR /a
   WORKDIR b
   WORKDIR c
   RUN pwd

.. The output of the final pwd command in this Dockerfile would be /a/b/c.

この ``Dockerfile`` を使えば、最後の ``pwd`` コマンドの出力は ``/a/b/c`` になります。

.. The WORKDIR instruction can resolve environment variables previously set using ENV. You can only use environment variables explicitly set in the Dockerfile. For example:

``WORKDIR`` 命令は ``ENV`` 命令を使った環境変数も展開できます。環境変数を使うには ``Dockerfile`` で明確に定義する必要があります。例：

.. code-block:: dockerfile

   ENV DIRPATH /path
   WORKDIR $DIRPATH/$DIRNAME
   RUN pwd

..    The output of the final pwd command in this Dockerfile would be /path/$DIRNAME

この ``Dockerfile`` を使えば、最後の ``pwd`` コマンドの出力は ``/path/$DIRNAME`` になります。

.. _arg:

ARG
==========

.. code-block:: dockerfile

   ARG <名前>[=<デフォルト値>]

.. The ARG instruction defines a variable that users can pass at build-time to the builder with the docker build command using the --build-arg <varname>=<value> flag. If a user specifies a build argument that was not defined in the Dockerfile, the build outputs an error.

``ARG`` 命令は、構築時に作業者が ``docker build`` コマンドで使う変数、 ``--build-arg <変数名>=<値>`` フラグを定義するものです。ユーザが構築時に引数を指定しても Dockerfile で定義されていなければ、構築時に次のようなエラーが出ます。

.. code-block:: bash

   One or more build-args were not consumed, failing build.

.. The Dockerfile author can define a single variable by specifying ARG once or many variables by specifying ARG more than once. For example, a valid Dockerfile:

Dockerfile の作者は ``ARG`` 変数を１度だけ定義するだけでなく、複数の ``ARG`` を指定可能です。有効な Dockerfile の例：

.. code-block:: dockerfile

   FROM busybox
   ARG user1
   ARG buildno
   ...

.. A Dockerfile author may optionally specify a default value for an ARG instruction:

Dockerfile の作者は、オプションで ``ARG`` 命令のデフォルト値を指定できます。

.. code-block:: dockerfile

   FROM busybox
   ARG user1=someuser
   ARG buildno=1
   ...

.. If an ARG value has a default and if there is no value passed at build-time, the builder uses the default.

``ARG`` がデフォルト値を持っている場合、構築時に値の指定が無ければ、このデフォルト値を使います。

.. An ARG variable definition comes into effect from the line on which it is defined in the Dockerfile not from the argument’s use on the command-line or elsewhere. For example, consider this Dockerfile:

``ARG`` 変数は ``Dockerfile`` で記述した行以降で効果があります。ただし、コマンドライン上で引数の指定が無い場合です。次の Dockerfile の例を見てみましょう。

.. code-block:: dockerfile

   FROM busybox
   USER ${user:-some_user}
   ARG user
   USER $user
   ...

.. A user builds this file by calling:

   ユーザは構築時に次のように呼び出します。

.. code-block:: bash

   $ docker build --build-arg user=what_user Dockerfile

.. The USER at line 2 evaluates to some_user as the user variable is defined on the subsequent line 3. The USER at line 4 evaluates to what_user as user is defined and the what_user value was passed on the command line. Prior to its definition by an ARG instruction, any use of a variable results in an empty string.

２行めの ``USER`` は ``some_user`` を、３行めサブシーケントで定義された ``user`` 変数として評価します。４行めでは ``what_user`` を ``USER`` で定義したものと評価し、 ``what_user`` 値はコマンドラインで指定したものになります。 ``ARG`` 命令で定義するまで、あらゆる変数は空の文字列です。

..    Note: It is not recommended to use build-time variables for passing secrets like github keys, user credentials etc.

.. note::

   構築時の変数として、GitHub の鍵やユーザの証明書などの秘密情報を含むのは、推奨される使い方ではありません。

.. You can use an ARG or an ENV instruction to specify variables that are available to the RUN instruction. Environment variables defined using the ENV instruction always override an ARG instruction of the same name. Consider this Dockerfile with an ENV and ARG instruction.

``ARG`` や ``ENV`` 命令を ``RUN`` 命令のための環境変数にも利用できます。 ``ENV`` 命令を使った環境変数の定義は、常に同じ名前の ``ARG`` 命令を上書きします。Dockerfile における ``ENV`` と ``ARG`` 命令を考えましょう。

.. code-block:: dockerfile

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER v1.0.0
   RUN echo $CONT_IMG_VER

.. Then, assume this image is built with this command:

それから、イメージを次のように起動します。

.. code-block:: bash

   $ docker build --build-arg CONT_IMG_VER=v2.0.1 Dockerfile

.. In this case, the RUN instruction uses v1.0.0 instead of the ARG setting passed by the user:v2.0.1 This behavior is similar to a shell script where a locally scoped variable overrides the variables passed as arguments or inherited from environment, from its point of definition.

この例では、 ``RUN`` 命令は ``v1.0.0`` の代わりに、 ``ARG`` でユーザから渡された ``v2.0.1`` を使います。この動作はシェルスクリプトの挙動に似ています。ローカルのスコープにある環境変数が、与えられた引数や上位の環境変数によって上書きするようなものです。

.. Using the example above but a different ENV specification you can create more useful interactions between ARG and ENV instructions:

上記の ``ENV`` 指定の他にも、更に ``ARG`` と ``ENV`` を使いやすくする指定も可能です。

.. code-block:: dockerfile

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER ${CONT_IMG_VER:-v1.0.0}
   RUN echo $CONT_IMG_VER

.. Unlike an ARG instruction, ENV values are always persisted in the built image. Consider a docker build without the --build-arg flag:

``ARG`` 命令とは異なり、構築時の ``ENV`` 値は常に一定です。docker build で --build-arg フラグを使わない場合を考えてみましょう。

.. code-block:: bash

   $ docker build Dockerfile

.. Using this Dockerfile example, CONT_IMG_VER is still persisted in the image but its value would be v1.0.0 as it is the default set in line 3 by the ENV instruction.

この Dockerfile の例では、 ``CONT_IMG_VER`` はイメージの中では変わりませんが、３行めの ``ENV`` 命令でデフォルト値を設定することにより、値は ``v1.0.0`` となります。

.. The variable expansion technique in this example allows you to pass arguments from the command line and persist them in the final image by leveraging the ENV instruction. Variable expansion is only supported for a limited set of Dockerfile instructions.

この例における変数展開のテクニックは、コマンドラインから引数を渡せるようにし、 ``ENV`` 命令を使うことで最終的に一貫したイメージを作成します。サポートされている変数展開は :ref:`Dockerfile 命令の一部 <environment-replacement>` のみです。

.. Docker has a set of predefined ARG variables that you can use without a corresponding ARG instruction in the Dockerfile.

Docker は Dockerfile に対応する ``ARG`` 命令が無くても、既定の ``ARG`` 変数セットを持っています。

* ``HTTP_PROXY``
* ``http_proxy``
* ``HTTPS_PROXY``
* ``https_proxy``
* ``FTP_PROXY``
* ``ftp_proxy``
* ``NO_PROXY``
* ``no_proxy``

.. To use these, simply pass them on the command line using the --build-arg <varname>=<value> flag.

これらを使うには、コマンドラインで ``--build-arg <変数名>=<値>`` フラグを単に渡すだけです。

.. Impact on build caching

.. _impact-on-build-caching:

構築キャッシュの影響
--------------------

.. ARG variables are not persisted into the built image as ENV variables are. However, ARG variables do impact the build cache in similar ways. If a Dockerfile defines an ARG variable whose value is different from a previous build, then a "cache miss" occurs upon its first usage, not its definition. In particular, all `RUN` instructions following an `ARG` instruction use the `ARG` variable implicitly (as an environment variable), thus can cause a cache miss.

``ARG`` 変数は、イメージ構築時の ``ENV`` 変数のように残り続けません。しかし、 ``ARG`` 変数は構築キャッシュで似たような方法として扱えます。もし Dockerfile で ``ARG`` 変数を定義したら、この値が以前の値と違う時は、以降で ``ARG`` 変数が出た時「キャッシュ・ミス」を発生します。これは、値を定義していなくても発生します。特に、すべての ``RUN`` 命令は ``ARG`` 変数を（環境変数から）暗黙的に使おうとするため、結果としてキャッシュ・ミスを引き起こします。

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

.. If you specify --build-arg CONT_IMG_VER=<value> on the command line, in both cases, the specification on line 2 does not cause a cache miss; line 3 does cause a cache miss.ARG CONT_IMG_VER causes the RUN line to be identified as the same as running CONT_IMG_VER=<value> echo hello, so if the <value> changes, we get a cache miss.

``--build-arg CONT_IMG_VER=<値>`` をコマンドライン上で指定すると、どちらの場合も２行目はキャッシュ・ミスを引き起こします。さらに３行目もキャッシュ・ミスになります。 ``ARG CONT_IMG_VER`` は RUN 行で ``CONT_IMG_VER=<値>`` で echo hello と同じにしたいのであれば、 ``<値>`` の編億がキャッシュ・ミスになります。

.. Consider another example under the same command line:

同じコマンド行で別の例を考えます。

.. code-block:: dockerfile
   :linenos:

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER $CONT_IMG_VER
   RUN echo $CONT_IMG_VER

.. In this example, the cache miss occurs on line 3. The miss happens because the variable’s value in the ENV references the ARG variable and that variable is changed through the command line. In this example, the ENV command causes the image to include the value.

この例では、キャッシュミスが３行めで発生します。ミスが起こるのは ``ENV`` 変数が ``ARG`` 変数を参照しているのと、この変数がコマンドラインで変わるためです。例における ``ENV`` コマンドはイメージの中で処理されるものです。

.. If an ENV instruction overrides an ARG instruction of the same name, like this Dockerfile:

もし ``ENV`` 命令を同じ名前の ``ARG`` 命令で、次のように上書きしたらどうでしょう。

.. code-block:: dockerfile
   :linenos:

   FROM ubuntu
   ARG CONT_IMG_VER
   ENV CONT_IMG_VER hello
   RUN echo $CONT_IMG_VER

.. Line 3 does not cause a cache miss because the value of CONT_IMG_VER is a constant (hello). As a result, the environment variables and values used on the RUN (line 4) doesn’t change between builds.

３行めはキャッシュミスを引き起こしません。 ``CONT_IMG_VAR`` は固定（ ``hello`` ）だからです。そのため、環境変数と値は ``RUN``  （４行め）で使われますが、構築時に変わりません。


.. _onbuild:

ONBUILD
==========

.. ONBUILD [INSTRUCTION]

.. code-block:: dockerfile

   ONBUILD [命令]

.. The ONBUILD instruction adds to the image a trigger instruction to be executed at a later time, when the image is used as the base for another build. The trigger will be executed in the context of the downstream build, as if it had been inserted immediately after the FROM instruction in the downstream Dockerfile.

イメージは他で構築したイメージを元にしている時、``ONBUILD`` 命令はイメージに対して最終的に実行する *トリガ* 命令を追加します。トリガは構築後に行うもので、 ``Dockerfile`` で ``FROM`` 命令のあとに書くことができます。

.. Any build instruction can be registered as a trigger.

あらゆる構築時の命令をトリガとして登録可能です。

.. This is useful if you are building an image which will be used as a base to build other images, for example an application build environment or a daemon which may be customized with user-specific configuration.

これは他のイメージからイメージを構築する時に役立つでしょう。例えば、アプリケーションの開発環境やデーモンは、ユーザごとに設定をカスタマイズする可能性があります。

.. For example, if your image is a reusable Python application builder, it will require application source code to be added in a particular directory, and it might require a build script to be called after that. You can’t just call ADD and RUN now, because you don’t yet have access to the application source code, and it will be different for each application build. You could simply provide application developers with a boilerplate Dockerfile to copy-paste into their application, but that is inefficient, error-prone and difficult to update because it mixes with application-specific code.

例えば、イメージが Python アプリケーション・ビルダーを再利用する時、アプリケーションのソースコードを適切なディレクトリに追加し、その後、構築スクリプトを実行することもあるでしょう。この時点では ``ADD`` と ``RUN`` を呼び出せません。なぜなら、まだアプリケーションのソースコードにアクセスしておらず、個々のアプリケーション構築によって異なるからです。アプリケーションの開発者は、ボイラープレートである ``Dockerfile`` をコピーペーストでアプリケーションを入れるように編集するだけです。ですが、これは効率的ではなく、エラーを引き起こしやすく、アプリケーション固有のコードが混在することで更新が大変になります。

.. The solution is to use ONBUILD to register advance instructions to run later, during the next build stage.

この解決方法として、 ``ONBLUID`` を使い、実行後に別の構築ステージに進む上位命令を登録することです。

.. Here’s how it works:

これは次のように動作します。

..    When it encounters an ONBUILD instruction, the builder adds a trigger to the metadata of the image being built. The instruction does not otherwise affect the current build.

1. ``ONBUILD`` 命令が呼び出されると、ビルダーはイメージ構築時のメタデータの中にトリガを追加します。

..     At the end of the build, a list of all triggers is stored in the image manifest, under the key OnBuild. They can be inspected with the docker inspect command.

2. 構築が完了したら、全てのトリガはイメージのマニフェスト内の  ``OnBuild`` キー配下に保管されます。この構築時点では、命令は何ら影響を与えません。

..    Later the image may be used as a base for a new build, using the FROM instruction. As part of processing the FROM instruction, the downstream builder looks for ONBUILD triggers, and executes them in the same order they were registered. If any of the triggers fail, the FROM instruction is aborted which in turn causes the build to fail. If all triggers succeed, the FROM instruction completes and the build continues as usual.

3. このイメージは後で何らかのイメージの元になります。その時は ``FROM`` 命令で呼び出されます。 ``FROM`` 命令の処理の一部として、ダウンストリームのビルダーは ``ONBULID`` トリガを探し、登録された順番で実行します。もしトリガが失敗したら、 ``FROM`` 命令は処理を中断し、ビルドを失敗とします。もし全てのトリガが成功したら、 ``FROM`` 命令は完了し、以降は通常の構築が進みます。

..    Triggers are cleared from the final image after being executed. In other words they are not inherited by “grand-children” builds.

4. 実行する前に、最終的なイメージ上からトリガが削除されます。言い替えると構築された「孫」には、何ら親子関係がありません。

.. For example you might add something like this:

次のような例の記述を追加するでしょう。

.. code-block:: dockerfile

   [...]
   ONBUILD ADD . /app/src
   ONBUILD RUN /usr/local/bin/python-build --dir /app/src
   [...]

..     Warning: Chaining ONBUILD instructions using ONBUILD ONBUILD isn’t allowed.

.. warning::

   ``ONBUILD ONBUILD`` 命令を使って ``ONBULID`` 命令の上書きはできません。

..     Warning: The ONBUILD instruction may not trigger FROM or MAINTAINER instructions.

.. ``ONBUILD`` 命令は ``FROM`` や ``MAINTAINER`` をトリガとしてみなさないでしょう。

.. _stopsignal:

STOPSIGNAL
==========

.. STOPSIGNAL signal

.. code-block:: dockerfile

   STOPSIGNAL シグナル

.. The STOPSIGNAL instruction sets the system call signal that will be sent to the container to exit. This signal can be a valid unsigned number that matches a position in the kernel’s syscall table, for instance 9, or a signal name in the format SIGNAME, for instance SIGKILL.

``STOPSIGNAL`` 命令は、コンテナを終了する時に送信するための、システム・コール・シグナルを設定します。シグナルはカーネルの syscall テーブルと一致する、有効な番号の必要があります。例えば、9 あるいはシグナル名 SIGNAME や、 SIGKILL などです。

.. HEALTHCHECK

.. _build-healthcheck:

HEALTHCHECK
====================

.. The HEALTHCHECK instruction has two forms:

``HEALTHCHECK`` 命令は２つの形式があります：

..    HEALTHCHECK [OPTIONS] CMD command (check container health by running a command inside the container)
    HEALTHCHECK NONE (disable any healthcheck inherited from the base image)

* ``HEALTHCHECK [オプション] CMD コマンド`` （コンテナ内でコマンドを実行して、コンテナの正常性を確認）
* ``HEALTHCHECK NONE``  （ベース・イメージからのヘルスチェック継承を無効化）

.. The HEALTHCHECK instruction tells Docker how to test a container to check that it is still working. This can detect cases such as a web server that is stuck in an infinite loop and unable to handle new connections, even though the server process is still running.

``HEALTHCHECK`` 命令は、 Docker に対してコンテナの正常性をどのように確認（テスト）するかを伝えます。これはウェブ・サーバがループで塞がってしまい、新しい接続を受け付けられないような状態を検出できます。サーバプロセスが実行中でも、応答が無ければ検出します。

.. When a container has a healthcheck specified, it has a health status in addition to its normal status. This status is initially starting. Whenever a health check passes, it becomes healthy (whatever state it was previously in). After a certain number of consecutive failures, it becomes unhealthy.

コンテナのヘルスチェック（healthcheck）を有効化すると、通常の状態に加え、ヘルス・ステータス（health status）を追加します。こちらの初期ステータスは ``starting`` （起動中）です。ヘルスチェックが正常であれば、ステータスは（以前の状態にかかわらず） ``healthy`` （正常）になります。特定回、連続して失敗したら、ステータスは ``unhealthy``  （異常）になります。

.. The options that can appear before CMD are:

``CMD`` より前に記述するオプションは、以下の通りです。

* ``--interval=間隔`` (デフォルト: 30s)
* ``--timeout=間隔`` (デフォルト: 30s)
* ``--retries=N``  (デフォルト: 3)

.. The health check will first run interval seconds after the container is started, and then again interval seconds after each previous check completes.

ヘルス・チェックは、まず最初の **interval** （間隔）秒の後、コンテナを起動します。そして **interval** 秒後に直近の確認を行います。

.. If a single run of the check takes longer than timeout seconds then the check is considered to have failed.

確認に **timeout** （タイムアウト）秒を越えるようであれば、確認は失敗とみなします。

.. It takes retries consecutive failures of the health check for the container to be considered unhealthy.

コンテナに対するヘルスチェックが連続して失敗したら、コンテナは ``unhealthy`` とみなします。

.. There can only be one HEALTHCHECK instruction in a Dockerfile. If you list more than one then only the last HEALTHCHECK will take effect.

これらの処理は ``Dockerfile`` で命令がある場合のみです。複数の ``HEALTHCHECK`` があれば、最後の１つだけ有効です。

.. The command after the CMD keyword can be either a shell command (e.g. HEALTHCHECK CMD /bin/check-running) or an exec array (as with other Dockerfile commands; see e.g. ENTRYPOINT for details).

``CMD`` キーワード後のコマンドは、シェル・コマンド（例： ``HEALTHCHECK CMD /bin/check-running`` ）あるいは exec 配列（こちらは Dockerfile の他コマンドと同様です。例えば ``ENTRYPOINT`` の詳細をご覧ください ）です。

.. The command's exit status indicates the health status of the container. The possible values are:

コマンドはコンテナのヘルス・ステータスの終了コードを検出できます。値は以下の通りです。

..    0: success - the container is healthy and ready for use
    1: unhealthy - the container is not working correctly
    2: starting - the container is not ready for use yet, but is working correctly

* 0: success（成功） - コンテナは正常であり、使う準備が整っています
* 1: unhealthy（障害） - コンテナは正常に動作していません
* 2: starting（起動中） - まだコンテナの利用準備が整っていませんが、正常に動作しています

.. If the probe returns 2 ("starting") when the container has already moved out of the "starting" state then it is treated as "unhealthy" instead.

監視結果が 2（"starting"）であれば、コンテナは起動しはじめており「起動中」の状態であり、「unhealthy」状態ではありません。

.. For example, to check every five minutes or so that a web-server is able to serve the site's main page within three seconds:

たとえば、５分ごとにウエブ・サーバがサイトのメインページを３秒以内に表示するかどうかを確認するには、次のように指定します。

.. code-block:: dockerfile

   HEALTHCHECK --interval=5m --timeout=3s \
     CMD curl -f http://localhost/ || exit 1

.. To help debug failing probes, any output text (UTF-8 encoded) that the command writes on stdout or stderr will be stored in the health status and can be queried with docker inspect. Such output should be kept short (only the first 4096 bytes are stored currently).

監視失敗時はデバッグしやすくなるように、コマンド実行時の標準出力や標準エラー出力といった、あらゆる出力テキスト（UTF-8 エンコード）はヘルス・ステータスに格納され、 ``docker inspect`` で確認可能です。この出力結果は短くして保存されます（現時点では始めから 4096 バイトのみ保存）。

.. When the health status of a container changes, a health_status event is generated with the new status.

コンテナのヘルス・ステータスが変われば、 ``health_status`` イベントが新しいステータスを生成します。

.. The HEALTHCHECK feature was added in Docker 1.12.

``HEALTHCHECK``  機能は Docker 1.12 で追加されました。

.. SHELL

.. _builder-shell:

SHELL
==========

.. code-block:: dockerfile

   SHELL ["実行可能なファイル", "パラメータ"]

.. The SHELL instruction allows the default shell used for the shell form of commands to be overridden. The default shell on Linux is ["/bin/sh", "-c"], and on Windows is ["cmd", "/S", "/C"]. The SHELL instruction must be written in JSON form in a Dockerfile.

``SHELL`` 命令は、シェル形式でコマンド実行時における、デフォルトのシェルを上書きします。 Linux 上でのデフォルトのシェルは ``["/bin/sh", "-c"]`` です。Windows は ``["cmd", "/S", "/C"]`` です。 ``SHELL`` 命令は Dockerfile で JSON 形式での記述が必要です。

.. The SHELL instruction is particularly useful on Windows where there are two commonly used and quite different native shells: cmd and powershell, as well as alternate shells available including sh.

``SHELL`` 命令はとりわけ Windows で便利です。全く異なるネイティブなシェル ``cmd`` と ``powershell``  だけでなく、代わりのシェルとして ``sh`` も指定できます。

.. The SHELL instruction can appear multiple times. Each SHELL instruction overrides all previous SHELL instructions, and affects all subsequent instructions. For example:

``SHELL`` 命令は複数回指定できます。 ``SHELL`` 命令ごとに、これまでの ``SHELL`` 命令を上書きし、以降の命令全てに反映します。例：

.. code-block:: dockerfile

   FROM windowsservercore
   
   # cmd /S /C echo default として実行する
   RUN echo default
   
   # cmd /S /C powershell -command Write-Host default として実行する
   RUN powershell -command Write-Host default
   
   # powershell -command Write-Host hello として実行する
   SHELL ["powershell", "-command"]
   RUN Write-Host hello
   
   # cmd /S /C echo hello として実行する
   SHELL ["cmd", "/S"", "/C"]
   RUN echo hello

.. The following instructions can be affected by the SHELL instruction when the shell form of them is used in a Dockerfile: RUN, CMD and ENTRYPOINT.

Dockerfile の ``RUN``  、 ``CMD`` 、``ENTRYPOINT`` のシェルは、 ``SHELL`` 命令以後にあれば影響を受けます。

.. The following example is a common pattern found on Windows which can be streamlined by using the SHELL instruction:

次の例は Windows で一般的に見受けられるパターンですが、 ``SHELL`` 命令で簡素化できます。

.. code-block:: dockerfile

   ...
   RUN powershell -command Execute-MyCmdlet -param1 "c:\foo.txt"
   ...

.. The command invoked by docker will be:

このコマンドは、Docker によって次のように処理されます。

.. code-block:: shell

   cmd /S /C powershell -command Execute-MyCmdlet -param1 "c:\foo.txt"

.. This is inefficient for two reasons. First, there is an un-necessary cmd.exe command processor (aka shell) being invoked. Second, each RUN instruction in the shell form requires an extra powershell -command prefixing the command.

これが非効率なのは、２つの理由があります。１つは不要な cmd.exe プロセッサ（いわゆるシェル）が呼び出されること。もう１つは各 ``RUN`` 命令ごとに追加の ``powershell -command`` コマンドが実行されるためです。

.. To make this more efficient, one of two mechanisms can be employed. One is to use the JSON form of the RUN command such as:

効率的にするには、２つの仕組みを採用します。１つは RUN 命令を次のように JSON 形式で使います。

.. code-block:: dockerfile

   ...
   RUN ["powershell", "-command", "Execute-MyCmdlet", "-param1 \"c:\\foo.txt\""]
   ...

.. While the JSON form is unambiguous and does not use the un-necessary cmd.exe, it does require more verbosity through double-quoting and escaping. The alternate mechanism is to use the SHELL instruction and the shell form, making a more natural syntax for Windows users, especially when combined with the escape parser directive:

JSON 形式は明確なものであり、不確実な cmd.exe を使いません。そのため、JSON 形式はダブル・クォートで囲み、エスケープするといった冗長な記述が必要です。他の方法としては、 ``SHELL`` 命令でシェル形式を使えば、Windows 利用者にとっても自然な構文になります。 ``escape`` パーサ・ディレクティブと一緒に使えば尚更です。

.. code-block:: dockerfile

   # escape=`
   
   FROM windowsservercore
   SHELL ["powershell","-command"]
   RUN New-Item -ItemType Directory C:\Example
   ADD Execute-MyCmdlet.ps1 c:\example\
   RUN c:\example\Execute-MyCmdlet -sample 'hello world'

.. Resulting in:

実行結果：

.. code-block:: shell

   PS E:\docker\build\shell> docker build -t shell .
   Sending build context to Docker daemon 3.584 kB
   Step 1 : FROM windowsservercore
    ---> 5bc36a335344
   Step 2 : SHELL powershell -command
    ---> Running in 87d7a64c9751
    ---> 4327358436c1
   Removing intermediate container 87d7a64c9751
   Step 3 : RUN New-Item -ItemType Directory C:\Example
    ---> Running in 3e6ba16b8df9
   
   
       Directory: C:\
   
   
   Mode                LastWriteTime         Length Name
   ----                -------------         ------ ----
   d-----         6/2/2016   2:59 PM                Example
   
   
    ---> 1f1dfdcec085
   Removing intermediate container 3e6ba16b8df9
   Step 4 : ADD Execute-MyCmdlet.ps1 c:\example\
    ---> 6770b4c17f29
   Removing intermediate container b139e34291dc
   Step 5 : RUN c:\example\Execute-MyCmdlet -sample 'hello world'
    ---> Running in abdcf50dfd1f
   Hello from Execute-MyCmdlet.ps1 - passed hello world
    ---> ba0e25255fda
   Removing intermediate container abdcf50dfd1f
   Successfully built ba0e25255fda
   PS E:\docker\build\shell>

.. The SHELL instruction could also be used to modify the way in which a shell operates. For example, using SHELL cmd /S /C /V:ON|OFF on Windows, delayed environment variable expansion semantics could be modified.

``SHELL`` 命令はシェルの実行者でも変更できます。たとえば Windows 上で ``SHELL cmd /S /C /V:ON|OFF`` を使うと、環境変数の遅延拡張セマンティクス（delayed environment variable expansion semantics）を変更できます。

.. The SHELL instruction can also be used on Linux should an alternate shell be required such zsh, csh, tcsh and others.

``SHELL`` 命令は Linux 上でも利用できます。 ``zsh`` 、 ``csh`` 、``tcsh``  など別のシェルを指定できます。

.. The SHELL feature was added in Docker 1.12.

``SHELL`` 機能は Docker 1.12 で追加されました。

.. Dockerfile examples

Dockerfile の例
====================

.. Below you can see some examples of Dockerfile syntax. If you’re interested in something more realistic, take a look at the list of Dockerization examples.

以下で Dockerfile 構文の例を参照できます。実際の環境に興味があれば、 :doc:`Docker 化の例 </engine/examples/index>` をご覧ください。

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
