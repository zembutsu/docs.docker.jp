.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/build/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/build.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/reference/commandline/build.md
.. check date: 2016/04/25
.. Commits on May 28, 2016 ab391c9ab595f01e76b82edda0800e13655cc6f3
.. -------------------------------------------------------------------

.. build

=======================================
build
=======================================

.. code-block:: bash

   使い方: docker build [オプション] パス | URL | -
   
   パスにあるソースコードから新しいイメージを構築
   
     --build-arg=[]                  構築時の変数を指定
     --cpu-shares                    CPU 共有 (相対ウエイト)
     --cgroup-parent=""              コンテナ用のオプション親 cgroup 
     --cpu-period=0                  CPU CFS (Completely Fair Scheduler) 間隔の制限
     --cpu-quota=0                   CPU CFS (Completely Fair Scheduler) クォータの制限
     --cpuset-cpus=""                実行時に許可する CPU。例 `0-3`, `0,1`
     --cpuset-mems=""                実行時に許可するメモリ。例 `0-3`, `0,1`
     --disable-content-trust=true    イメージの認証をスキップ
     -f, --file=""                   Dockerfileの名前 (デフォルトは 'PATH/Dockerfile')
     --force-rm                      常に中間コンテナを削除
     --help                          使い方を表示
     --isolation=""                  コンテナの隔離（独立）技術
     --label=[]                      イメージ用のメタデータを指定
     -m, --memory=""                 構築コンテナのメモリ上限を指定
     --memory-swap=""                整数値の指定はメモリにスワップ値を追加。-1は無制限スワップを有効化
     --no-cache                      イメージ構築時にキャッシュを使わない
     --pull                          常に新しいイメージのダウンロードを試みる
     -q, --quiet                     構築時の表示を抑制し、成功時はイメージ ID を表示
     --rm=true                       構築に成功したら、全ての中間コンテナを削除
     --shm-size=[]                   `/dev/shm` のサイズ。書式は `<数値><単位>`。 `数値` は `0` 以上。単位は `b` (bytes)、`k` (kilobytes)、 `m` (megabytes)、 `g` (gigabytes) のどれか。単位を省略するとバイトになる。サイズを省略すると `64m` になる。
     -t, --tag=[]                    '名前:タグ' 形式で名前とオプションのタグを指定
     --ulimit=[]                     Ulimit オプション

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. Builds Docker images from a Dockerfile and a “context”. A build’s context is the files located in the specified PATH or URL. The build process can refer to any of the files in the context. For example, your build can use an ADD instruction to reference a file in the context.

Docker イメージは Dockerfile と「コンテクスト」（context）を使って構築します。構築時のコンテクストとは、特定の ``パス`` や ``URL`` の場所にあるファイルのことです。構築中のステップで、対象コンテクスト内のファイルを参照できます。

.. The URL parameter can specify the location of a Git repository; the repository acts as the build context. The system recursively clones the repository and its submodules using a git clone --depth 1 --recursive command. This command runs in a temporary directory on your local host. After the command succeeds, the directory is sent to the Docker daemon as the context. Local clones give you the ability to access private repositories using local user credentials, VPNs, and so forth.

``URL`` パラメータは Git リポジトリの場所を指定できます。つまり、リポジトリの内容をコンテクストとして構築できます。システムでリポジトリの再帰的なクローンを作成するには ``git clone --depth 1 --recursive`` コマンドを使います。このコマンドはローカルホスト上の一時ディレクトリで実行されます。コマンドが成功したら、ディレクトリが Docker デーモンにコンテクストとして送信されます。ローカルのクローンであれば、ローカルなユーザ認証や VPN などを使うプライベート・リポジトリへのアクセスも可能にします。

.. Git URLs accept context configuration in their fragment section, separated by a colon :. The first part represents the reference that Git will check out, this can be either a branch, a tag, or a commit SHA. The second part represents a subdirectory inside the repository that will be used as a build context.

Git の URL は、コロン ``:`` がコンテクストのセクションを分割する設定に使えます。１つめの場所は Git が調査用に参照します。これはブランチ、タグ、コミット SHA が使えます。２つめの場所はリポジトリ内にあるサブディレクトリであり、構築時のコンテクストとして使われます。

.. For example, run this command to use a directory called docker in the branch container:

例えば、 ``container`` ブランチを ``docker`` という名称のディレクトリでコマンドを実行するには：

.. code-block:: bash

   $ docker build https://github.com/docker/rootfs.git#container:docker

.. The following table represents all the valid suffixes with their build contexts:

次の表は構築コンテクストで有効なサフィックスの一覧です。

.. list-table::
   :header-rows: 1
   
   * - 構築構文のサフィックス
     - コミットで利用
     - 構築コンテクストに利用
   * - ``myrepo.git``
     - ``refs/heads/master``
     - ``/``
   * - ``myrepo.git#mytag``
     - ``refs/heads/mytag``
     - ``/``
   * - ``myrepo.git#mybranch``
     - ``refs/heads/mybranch``
     - ``/``
   * - ``myrepo.git#abcdef``
     - ``sha1 = abcdef``
     - ``/``
   * - ``myrepo.git#:myfolder``
     - ``refs/heads/master``
     - ``/myfolder``
   * - ``myrepo.git#master:myfolder``
     - ``refs/heads/master``
     - ``/myfolder``
   * - ``myrepo.git#mytag:myfolder``
     - ``refs/heads/mytag``
     - ``/myfolder``
   * - ``myrepo.git#mybranch:myfolder``
     - ``refs/heads/mybranch``
     - ``/myfolder``
   * - ``myrepo.git#abcdef:myfolder``
     - ``sha1 = abcdef``
     - ``/myfolder``

.. Instead of specifying a context, you can pass a single Dockerfile in the URL or pipe the file in via STDIN. To pipe a Dockerfile from STDIN:

コンテクストを指定する代わりに、Dockerfile の ``URL`` や ``STDIN`` （標準入力）のファイルをパイプできます。 ``STDIN`` から Dockerfile をパイプするには：

.. code-block:: bash

   $ docker build - < Dockerfile

.. With Powershell on Windows, you can run:

Windows 上の Powershell では、次のように実行します：

.. code-block:: powershell

   Get-Content Dockerfile | docker build -

.. If you use STDIN or specify a URL, the system places the contents into a file called Dockerfile, and any -f, --file option is ignored. In this scenario, there is no context.

STDIN や ``URL`` を指定したら　、システムはコンテクストを ``Dockerfile`` という名称のファイルに置き換えるため、 ``-f`` および ``--file`` オプションは無視されます。今回の例では、コンテクストは指定していません。

.. By default the docker build command will look for a Dockerfile at the root of the build context. The -f, --file, option lets you specify the path to an alternative file to use instead. This is useful in cases where the same set of files are used for multiple builds. The path must be to a file within the build context. If a relative path is specified then it must to be relative to the current directory.

デフォルトの ``docker build`` コマンドは、構築コンテクストのルートにある ``Dockerfile`` を探します。 ``-f`` および ``--file`` オプションは、内容が含まれている代替ファイルのパスを指定します。これは複数のファイル群を使って、複数の構築をする場合に便利です。パスには構築コンテクスト用のファイルが必要です。相対パスを指定する時は、現在のディレクトリに対する相対パスを指定する必要があります。

.. In most cases, it’s best to put each Dockerfile in an empty directory. Then, add to that directory only the files needed for building the Dockerfile. To increase the build’s performance, you can exclude files and directories by adding a .dockerignore file to that directory as well. For information on creating one, see the .dockerignore file.

多くの場合、それぞれの Dockerfile を空のディレクトに入れるのがベストな方法です。それから、ディレクトリ内には Dockerfile の構築に必要なものしか置きません。構築のパフォーマンスを向上するには、 ``.dockerignore`` ファイルを設置し、特定のファイルやディレクトリを除外する設定が使えます。このファイルを作るための詳しい方法は、 :ref:`.dockerignore ファイル <dockerignore-file>` をご覧ください。

.. If the Docker client loses connection to the daemon, the build is canceled. This happens if you interrupt the Docker client with ctrl-c or if the Docker client is killed for any reason.

Docker クライアントがデーモンと通信できなければ、構築はキャンセルされます。Docker クライアントで ``ctrl-c`` を使うか、何らかの理由により Docker クライアントが停止されても、構築は中断されます。

..    Note: Currently only the “run” phase of the build can be canceled until pull cancellation is implemented).

.. note::

   現時点で中断できるのは構築を「実行中」の段階のみです（pull の中断が実装されるまで）。

.. Return code

戻り値（リターンコード）
==============================

.. On a successful build, a return code of success 0 will be returned. When the build fails, a non-zero failure code will be returned.

構築に成功したら、成功の 0 という戻り値を返します。構築に失敗したら、ゼロ以外の戻り値を返します。

.. There should be informational output of the reason for failure output to STDERR:

失敗理由に関する情報は ``STDERR`` に表示されます。

.. code-block:: bash

   $ docker build -t fail .
   Sending build context to Docker daemon 2.048 kB
   Sending build context to Docker daemon
   Step 1 : FROM busybox
    ---> 4986bf8c1536
   Step 2 : RUN exit 13
    ---> Running in e26670ec7a0a
   INFO[0000] The command [/bin/sh -c exit 13] returned a non-zero code: 13
   $ echo $?
   1

.. See also:

こちらもご覧ください：

.. Dockerfile Reference.

:doc:`Dockerfile リファレンス </engine/reference/builder>`


.. Examples

例
==========

.. Build with PATH

.. _build-with-path:

PATH で構築
--------------------

.. code-block:: bash

   $ docker build .
   Uploading context 10240 bytes
   Step 1 : FROM busybox
   Pulling repository busybox
    ---> e9aa60c60128MB/2.284 MB (100%) endpoint: https://cdn-registry-1.docker.io/v1/
   Step 2 : RUN ls -lh /
    ---> Running in 9c9e81692ae9
   total 24
   drwxr-xr-x    2 root     root        4.0K Mar 12  2013 bin
   drwxr-xr-x    5 root     root        4.0K Oct 19 00:19 dev
   drwxr-xr-x    2 root     root        4.0K Oct 19 00:19 etc
   drwxr-xr-x    2 root     root        4.0K Nov 15 23:34 lib
   lrwxrwxrwx    1 root     root           3 Mar 12  2013 lib64 -> lib
   dr-xr-xr-x  116 root     root           0 Nov 15 23:34 proc
   lrwxrwxrwx    1 root     root           3 Mar 12  2013 sbin -> bin
   dr-xr-xr-x   13 root     root           0 Nov 15 23:34 sys
   drwxr-xr-x    2 root     root        4.0K Mar 12  2013 tmp
   drwxr-xr-x    2 root     root        4.0K Nov 15 23:34 usr
    ---> b35f4035db3f
   Step 3 : CMD echo Hello world
    ---> Running in 02071fceb21b
    ---> f52f38b7823e
   Successfully built f52f38b7823e
   Removing intermediate container 9c9e81692ae9
   Removing intermediate container 02071fceb21b

.. This example specifies that the PATH is ., and so all the files in the local directory get tard and sent to the Docker daemon. The PATH specifies where to find the files for the “context” of the build on the Docker daemon. Remember that the daemon could be running on a remote machine and that no parsing of the Dockerfile happens at the client side (where you’re running docker build). That means that all the files at PATH get sent, not just the ones listed to ADD in the Dockerfile.

この例では ``PATH`` に ``.`` を指定しています。このローカルディレクトリにある全てのファイルは ``tar`` 化され、Docker デーモンに送られます。 ``PATH`` が示すのは、Docker デーモンが構築時に使う「コンテクスト」（内容物）としてのファイルを見つけるための場所です。デーモンはリモート上のマシンでも操作できるのを思い出してください。これは、クライアント側（ ``docker build`` コマンドを実行した場所 ）では Dockerfile は何らパース（解析）されません。つまり、 ``PATH`` に含まれる *すべて* のファイルが送信されるだけでなく、Dockerfile の :ref:`ADD <add>` 命令で追加した場所も含みます。

.. The transfer of context from the local machine to the Docker daemon is what the docker client means when you see the “Sending build context” message.

ローカルのマシンから Docker デーモンにコンテクストを送信時、docker クライアントには「Sending build context」（構築コンテクストの送信中）とメッセージが表示されます。

.. If you wish to keep the intermediate containers after the build is complete, you must use --rm=false. This does not affect the build cache.

構築が完了しても中間コンテナをそのまま維持したい場合は、 ``--rm=false`` の指定が必要です。こちらを指定すると構築キャッシュに何もしません。

.. Build with URL

.. _build-with-url:

URL で構築
--------------------

.. code-block:: bash

    $ docker build github.com/creack/docker-firefox

.. This will clone the GitHub repository and use the cloned repository as context. The Dockerfile at the root of the repository is used as Dockerfile. Note that you can specify an arbitrary Git repository by using the git:// or git@ schema.

これは GitHub リポジトリのクローンを作成し、クローンしたリポジトリをコンテクストとして利用します。リポジトリのルートにある Dockerfile を、構築時の Dockerfile として使います。 ``git://`` や ``git@`` など、その他の Git リポジトリのスキーマを使っても指定可能です。

.. Build with -

.. _build-with:

\- で構築
--------------------

.. code-block:: bash

   $ docker build - < Dockerfile

.. This will read a Dockerfile from STDIN without context. Due to the lack of a context, no contents of any local directory will be sent to the Docker daemon. Since there is no context, a Dockerfile ADD only works if it refers to a remote URL.

これはコンテクストを使わずに ``STDIN`` から Dockerfile を読み込みます。コンテクストが無く、内容物の無いローカルのディレクトリが Docker デーモンに送信されます。コンテクストがありませんので、 Dockerfile の ``ADD`` はリモートの URL の参照に使えます。

.. code-block:: bash

   $ docker build - < context.tar.gz

.. This will build an image for a compressed context read from STDIN. Supported formats are: bzip2, gzip and xz.

これは ``STDIN`` から圧縮されたコンテクストを読み込み、イメージを構築しています。サポートしているフォーマットは、bzip2、gzip、xz です。

.. Usage of .dockerignore

.. _usage-of-dockerignore:

.dockerignore の使い方
------------------------------

.. code-block:: bash

   $ docker build .
   Uploading context 18.829 MB
   Uploading context
   Step 1 : FROM busybox
    ---> 769b9341d937
   Step 2 : CMD echo Hello world
    ---> Using cache
    ---> 99cc1ad10469
   Successfully built 99cc1ad10469
   $ echo ".git" > .dockerignore
   $ docker build .
   Uploading context  6.76 MB
   Uploading context
   Step 1 : FROM busybox
    ---> 769b9341d937
   Step 2 : CMD echo Hello world
    ---> Using cache
    ---> 99cc1ad10469
   Successfully built 99cc1ad10469

.. This example shows the use of the .dockerignore file to exclude the .git directory from the context. Its effect can be seen in the changed size of the uploaded context. The builder reference contains detailed information on creating a .dockerignore file

この例で表示しているのは、 ``.dockerignore`` ファイルを使い、コンテクストから ``.git`` ディレクトリを除外しています。この効果により、アップロードされるコンテクストの容量を小さくしています。構築時のリファレンス :ref:`.dockerignore ファイルの作成 <dockerignore-file>` に、より詳しい情報があります。

.. Tag image (-t)

.. _tag-image:

イメージのタグ（-t）
--------------------

.. code-block:: bash

   $ docker build -t vieux/apache:2.0 .

.. This will build like the previous example, but it will then tag the resulting image. The repository name will be vieux/apache and the tag will be 2.0. Read more about valid tags.

これまでの例のように構築していますが、作成されるイメージに対してタグ付けをしています。リポジトリ名は ``vieux/apache`` になり、タグは ``2.0`` になります。詳細は :doc:`有効なタグ <tag>` についてをご覧ください。

.. You can apply multiple tags to an image. For example, you can apply the latest tag to a newly built image and add another tag that references a specific version. For example, to tag an image both as whenry/fedora-jboss:latest and whenry/fedora-jboss:v2.1, use the following:

イメージに対して複数のタグを適用できます。例えば、最も新しい構築イメージに対して ``latest`` タグを付け、他にもバージョンを参照用タグも付けられます。例えば、イメージに対して ``whenry/fedora-jboss:latest`` と ``whenry/fedora-jboss:v2.1`` をタグ付けするには、次のコマンドを実行します。

.. code-block:: bash

   $ docker build -t whenry/fedora-jboss:latest -t whenry/fedora-jboss:v2.1 .

.. Specify Dockerfile (-f)

.. _specify-dockerfile:

Dockerfile の指定（-f）
------------------------------

.. code-block:: bash

   $ docker build -f Dockerfile.debug .

.. This will use a file called Dockerfile.debug for the build instructions instead of Dockerfile.

構築時の命令に ``Dockerfile`` ではなく、 ``Dockerfile.debug``  を使うように呼び出しています。

.. code-block:: bash

   $ docker build -f dockerfiles/Dockerfile.debug -t myapp_debug .
   $ docker build -f dockerfiles/Dockerfile.prod  -t myapp_prod .

.. The above commands will build the current build context (as specified by the .) twice, once using a debug version of a Dockerfile and once using a production version.

上記のコマンドは、どちらも現在のディレクトリにあるコンテント（ ``.`` で場所を指定 ）を使い構築するものです。デバッグ用とプロダクション用で別々の ``Dockerfile`` を使いますが、コンテクストは同じです。

.. code-block:: bash

   $ cd /home/me/myapp/some/dir/really/deep
   $ docker build -f /home/me/myapp/dockerfiles/debug /home/me/myapp
   $ docker build -f ../../../../dockerfiles/debug /home/me/myapp

.. These two docker build commands do the exact same thing. They both use the contents of the debug file instead of looking for a Dockerfile and will use /home/me/myapp as the root of the build context. Note that debug is in the directory structure of the build context, regardless of how you refer to it on the command line.

２つの ``docker build`` コマンドは同じことをしています。いずれの ``Dockerfile`` にも ``debug`` ファイルが含まれており、構築コンテクストのルートとして ``/home/me/myapp`` を使います。なお注意点として、 ``debug`` は構築コンテクストのサブディレクトリにあるもので、先ほどのコマンドライン上では指定の必要がありませんでした。

..    Note: docker build will return a no such file or directory error if the file or directory does not exist in the uploaded context. This may happen if there is no context, or if you specify a file that is elsewhere on the Host system. The context is limited to the current directory (and its children) for security reasons, and to ensure repeatable builds on remote Docker hosts. This is also the reason why ADD ../file will not work.

.. note::

   ``docker build`` が ``no such file or directory`` エラーを返すのは、アップロードすべきコンテクストとしてのファイルやディレクトリが存在しない時です。これは、コンテクストが存在しないか、指定したファイルがホストシステム上に存在していない可能性があります。コンテクストはカレント・ディレクトリ（と、その子ディレクトリ）のみに安全上の理由で制限されています。これはリモートの Docker ホスト上でも、繰り返し構築できるようにするためです。これが ``ADD ../file`` が動作しない理由でもあります。

.. Optional parent cgroup (--cgroup-parent)

.. _optional-parent-cgroup:

親 cgroup のオプション（--cgroup-parent）
--------------------------------------------------

.. When docker build is run with the --cgroup-parent option the containers used in the build will be run with the corresponding docker run flag.

``docker build`` に ``--cgroup-parent`` オプションを付けて構築すると、構築時の ``docker run`` 実行時に :ref:`適切なフラグを付けて実行 <specifying-custom-cgroups>` します。

.. Set ulimits in container (--ulimit)

.. _set-ulimits-in-container:

コンテナの ulimit をセット（--ulimit）
----------------------------------------

.. Using the --ulimit option with docker build will cause each build step’s container to be started using those --ulimit flag values.

``docker build`` に ``--ulimit`` オプションを付けて実行したら、コンテナの構築ステップを開始する時、都度 ``--ulimit`` :doc:`フラグの値を設定 <run>` します。

.. Set build-time variables (--build-arg)

.. _set-build-time-variables:

構築時の変数を指定（--build-arg）
----------------------------------------

.. You can use ENV instructions in a Dockerfile to define variable values. These values persist in the built image. However, often persistence is not what you want. Users want to specify variables differently depending on which host they build an image on.

Dockerfile の ``ENV`` 命令を使い、変数を定義できます。これらの値は構築時に一定のものです。しかし、一定の値が必要でない場合もあります。ユーザがイメージを構築するホストによっては、依存性に対する変数が必要になるかもしれません。

.. A good example is http_proxy or source versions for pulling intermediate files. The ARG instruction lets Dockerfile authors define values that users can set at build-time using the --build-arg flag:

良い例が ``http_proxy`` や中間ファイルの取得に使うソースのバージョン指定です。 ``ARG`` 命令は Dockerfile の作者が定義する値であり、ユーザが構築時に ``--build-arg`` フラグを指定できます。

.. code-block:: bash

   $ docker build --build-arg HTTP_PROXY=http://10.20.30.2:1234 .

.. This flag allows you to pass the build-time variables that are accessed like regular environment variables in the RUN instruction of the Dockerfile. Also, these values don’t persist in the intermediate or final images like ENV values do.

このフラグを使うことで、構築時の変数が Dockerfile の ``RUN`` 命令で通常の環境変数のように扱えます。それだけでなく、これらの値は ``ENV`` のように使えますが、中間ファイルや最終的なイメージでは一定ではありません。

.. Using this flag will not alter the output you see when the `ARG` lines from the Dockerfile are echoed during the build process.

フラグ使用時、Dockerfile で構築プロセスが進行しても ``ARG`` 行は画面には表示されません。

.. For detailed information on using ARG and ENV instructions, see the Dockerfile reference.

``ARG`` と ``ENV`` 命令の詳細については、 :doc:`Dockerfile リファレンス </engine/reference/builder>` をご覧ください。

.. seealso:: 

   build
      https://docs.docker.com/engine/reference/commandline/build/
