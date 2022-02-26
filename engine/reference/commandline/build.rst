.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/build/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/cli/blob/master/docs/reference/commandline/build.md
.. check date: 2022/02/26
.. Commits on Aug 22, 2016 47ba76afb159273e35326bd0cb548e960c51fbc7
.. -------------------------------------------------------------------

.. build

=======================================
docker build
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

説明
==========

.. Build an image from a Dockerfile

Dockerfile からイメージを :ruby:`構築 <build>` します。

使い方
==========

.. code-block:: bash

  $ docker build [オプション] パス | URL | -

詳細説明
==========

.. The docker build command builds Docker images from a Dockerfile and a “context”. A build’s context is the set of files located in the specified PATH or URL. The build process can refer to any of the files in the context. For example, your build can use a COPY instruction to reference a file in the context.

``docker build`` コマンドは、 Dockerfile と「 :ruby:`コンテクスト <context>` 」から Docker イメージを構築するコマンドです。構築のコンテクストとは、指定した ``パス`` や ``URL`` に置かれているファイル全てです。構築の過程で、そのコンテクストにある全てのファイルを参照できます。たとえば、 :ref:`COPY <builder-copy>` 命令を使う時に、コンテクスト内にあるファイルを参照して構築できます。

.. The URL parameter can refer to three kinds of resources: Git repositories, pre-packaged tarball contexts and plain text files.

``URL`` パラメータでは、3種類のリソースを参照できます： Git リポジトリ、パッケージ済みの tar ボールコンテキスト、テキストファイル。

.. Git repositories

Git リポジトリ
--------------------

.. When the URL parameter points to the location of a Git repository, the repository acts as the build context. The system recursively fetches the repository and its submodules. The commit history is not preserved. A repository is first pulled into a temporary directory on your local host. After that succeeds, the directory is sent to the Docker daemon as the context. Local copy gives you the ability to access private repositories using local user credentials, VPN’s, and so forth.

``URL`` パラメータが Git リポジトリの場所を示す場合、そのリポジトリが構築コンテクストになります。システムはリポジトリとサブモジュールを再帰的に取得します。コミット履歴は保持しません。まず、ローカルホスト上の一時ディレクトリに、リポジトリをダウンロードします。それが成功してから、そのディレクトリをコンテクストとして Docker デーモンに送信されます。ローカルでのコピーであれば、ローカルのユーザ認証や VPN 等を使うプライベート・リポジトリへのアクセスも可能にします。

.. If the URL parameter contains a fragment the system will recursively clone the repository and its submodules using a git clone --recursive command.

.. note::

   ``URL`` パラメータにフラグメント（ハッシュ）が含まれている場合、システムはリポジトリを再帰的にクローンし、サブモジュールには ``git clone --recursive`` コマンドを使います。

.. Git URLs accept context configuration in their fragment section, separated by a colon (:). The first part represents the reference that Git will check out, and can be either a branch, a tag, or a remote reference. The second part represents a subdirectory inside the repository that will be used as a build context.

Git の URL には、セクションをコロン（ ``:`` ）で分ける記述ができます。前半部分はチェックアウトする Git を参照し、ブランチ、タグ、リモートリファレンスも表せます。後半部分はリポジトリ内のサブディレクトリを表し、これが構築コンテキストになります。

.. For example, run this command to use a directory called docker in the branch container:

例えば、 ``container`` ブランチを ``docker`` という名称のディレクトリで使うには、このコマンドを実行します：

.. code-block:: bash

   $ docker build https://github.com/docker/rootfs.git#container:docker

.. The following table represents all the valid suffixes with their build contexts:

次の表は構築コンテクストで有効なサフィックスの一覧です。

.. list-table::
   :header-rows: 1
   
   * - 構築構文のサフィックス
     - 使用するコミット
     - 構築コンテクストの場所
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

.. You cannot specify the build-context directory (myfolder in the examples above) when using BuildKit as builder (DOCKER_BUILDKIT=1). Support for this feature is tracked in buildkit#1684.

.. note::

   BuildKit をビルダとして使う場合（ ``DOCKER_BUILDKIT=1`` ）、構築コンテキストのディレクトリを指定できません（先の例では ``myfolder`` ）。この機能のサポートについては `buildkit#1684 <https://github.com/moby/buildkit/issues/1684>`_ に経緯があります。


.. _dokcer-build-tarball-contexts:

tar ボールのコンテクスト
------------------------------

.. If you pass an URL to a remote tarball, the URL itself is sent to the daemon:

URL にリモートの tar ボールを指定すると、URL そのものがデーモンに送られます：

.. code-block:: bash

   $ docker build http://server/context.tar.gz

.. The download operation will be performed on the host the Docker daemon is running on, which is not necessarily the same host from which the build command is being issued. The Docker daemon will fetch context.tar.gz and use it as the build context. Tarball contexts must be tar archives conforming to the standard tar UNIX format and can be compressed with any one of the ‘xz’, ‘bzip2’, ‘gzip’ or ‘identity’ (no compression) formats.

ダウンロード処理が行われるのは、Docker デーモンが動作しているホスト上です。このホストは build コマンドを実行するホストと同じである必要はありません。Docker デーモンは ``context.tar.gz`` を取得し、それを構築コンテクストとして使います。tar ボールコンテクストは、標準の ``tar``  UNIX フォーマットに適合している必要があり、そのためには ``xz`` 、 ``bzip2`` 、 ``gzip`` 、 ``identity`` （圧縮なし）のいずれかのフォーマットで圧縮が必要です。

.. _docker-build-text-files:

テキストファイル
--------------------

.. Instead of specifying a context, you can pass a single Dockerfile in the URL or pipe the file in via STDIN. To pipe a Dockerfile from STDIN:

コンテクストを指定する代わりに、Dockerfile の ``URL`` や ``STDIN`` （標準入力）のファイルをパイプできます。 ``STDIN`` から Dockerfile をパイプするには：

.. code-block:: bash

   $ docker build - < Dockerfile

.. With Powershell on Windows, you can run:

Windows 上の Powershell では、次のように実行します：

.. code-block:: powershell

   Get-Content Dockerfile | docker build -

.. If you use STDIN or specify a URL pointing to a plain text file, the system places the contents into a file called Dockerfile, and any -f, --file option is ignored. In this scenario, there is no context.

STDIN や ``URL`` で単なるテキストファイルを指定すると、システムはコンテクストを ``Dockerfile`` という名称のファイルに置き換えるため、 ``-f`` および ``--file`` オプションは無視されます。今回の例では、コンテクストは指定していません。

.. By default the docker build command will look for a Dockerfile at the root of the build context. The -f, --file, option lets you specify the path to an alternative file to use instead. This is useful in cases where the same set of files are used for multiple builds. The path must be to a file within the build context. If a relative path is specified then it is interpreted as relative to the root of the context.

デフォルトの ``docker build`` コマンドは、構築コンテクストのルートにある ``Dockerfile`` を探します。 ``-f`` および ``--file`` オプションは、内容が含まれている代替ファイルのパスを指定します。これは複数のファイル群を使って、複数の構築をする場合に便利です。パスには構築コンテクスト用のファイルが必要です。相対パスを指定すると、コンテクストのルートからの相対パスとして解釈されます。

.. In most cases, it’s best to put each Dockerfile in an empty directory. Then, add to that directory only the files needed for building the Dockerfile. To increase the build’s performance, you can exclude files and directories by adding a .dockerignore file to that directory as well. For information on creating one, see the .dockerignore file.

多くの場合、それぞれの Dockerfile を空のディレクトに入れるのがベストな方法です。それから、ディレクトリ内には Dockerfile の構築に必要なものしか置きません。構築のパフォーマンスを向上するには、 ``.dockerignore`` ファイルを設置し、特定のファイルやディレクトリを除外する設定が使えます。このファイルを作るための詳しい方法は、 :ref:`.dockerignore ファイル <dockerignore-file>` をご覧ください。

.. If the Docker client loses connection to the daemon, the build is canceled. This happens if you interrupt the Docker client with CTRL-c or if the Docker client is killed for any reason. If the build initiated a pull which is still running at the time the build is cancelled, the pull is cancelled as well.


.. If the Docker client loses connection to the daemon, the build is canceled. This happens if you interrupt the Docker client with ctrl-c or if the Docker client is killed for any reason.

Docker クライアントがデーモンと通信できない場合、構築は中止されます。Docker クライアントで ``ctrl-c`` を使うか、何らかの理由により Docker クライアントが停止された場合も、構築は中止されます。構築中止の段階で取得処理（pull）が進行している場合は、同様に pull 処理も中止されます。

.. For example uses of this command, refer to the examples section below.

このコマンドの使用例は、後述の :ref:`サンプル <docker-build-examples>` をご覧ください。

.. _docker-build-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前、省略形
     - デフォルト
     - 説明
   * - ``--add-host``
     - 
     - 任意のホストに対し IP を割り当てを追加（host:ip）
   * - ``--build-arg``
     - 
     - 構築時の変数を設定
   * - ``--cache-from``
     - 
     - イメージに対してキャッシュ元を指定
   * - ``--cgroup-parent``
     - 
     - コンテナに対する任意の親 cgroup
   * - ``--compress``
     - 
     - 構築コンテクストを gzip を使って圧縮
   * - ``--cpu-period``
     - 
     - CPU CFS (completely Fair Scheduler)期間を制限
   * - ``--cpu-quota``
     - 
     - CPU CFS (completely Fair Scheduler)クォータを制限
   * - ``--cpu-shares`` 、 ``-c``
     - 
     - CPU :ruby:`配分 <share>` （相対ウェイト）
   * - ``--cpuset-cpus``
     - 
     - アクセスを許可する CPU を指定（ 0-3, 0, 1 ）
   * - ``--cpuset-mems``
     - 
     - アクセスを許可するメモリノードを指定（ 0-3, 0, 1 ）
   * - ``--disable-context-trust``
     - ``true``
     - イメージの検証を無効化
   * - ``--file`` 、 ``-f``
     - 
     - Dockerfile の名前（デフォルトは ``パス/Dockerfile`` ）
   * - ``--force-rm``
     - 
     - 中間コンテナを常に削除
   * - ``--iidfile``
     - 
     - イメージ ID をファイルに書き込む
   * - ``--isolation``
     - 
     - コンテナ分離技術
   * - ``--label``
     - 
     - イメージにメタデータを設定
   * - ``--memory`` 、 ``-m``
     - 
     - メモリの上限
   * - ``--memory-swap``
     - 
     - スワップの上限は、メモリとスワップの合計と同じ： ``-1`` はスワップを無制限にする
   * - ``--network``
     - 
     - 【API 1.25+】 構築中の RUN 命令で使うネットワークモードを指定
   * - ``--no-cache``
     - 
     - イメージの構築時にキャッシュを使用しない
   * - ``--output`` 、 ``-o``
     - 
     - 【API 1.40+】 アウトプット先を指定（書式：type=local,dest=path）
   * - ``--platform``
     - 
     - 【API 1.38+】 サーバがマルチプラットフォーム対応であれば、プラットフォームを指定
   * - ``--progress``
     - ``auto``
     - 進行状況の出力タイプを設定（auto、plain、tty）。plain を使うと、コンテナの出力を表示
   * - ``--pull``
     - 
     - イメージは、常に新しいバージョンのダウンロードを試みる
   * - ``--quiet`` 、 ``-q``
     - 
     - 構築時の出力と成功時のイメージ ID 表示を抑制
   * - ``--rm``
     - ``true``
     - 構築に成功後、中間コンテナを削除
   * - ``--secret``
     - 
     - 【API 1.39+】 構築時に利用するシークレットファイル（BuildKit 有効時のみ）： id=mysecret,src=/local/secret
   * - ``--security-opt``
     - 
     - セキュリティのオプション
   * - ``--shm-size``
     - 
     - /dev/shm の容量
   * - ``--squash``
     - 
     - 【experimental (daemon) | API 1.25+】 構築するレイヤを、単一の新しいレイヤに :ruby:`押し込む <squash>`
   * - ``--ssh``
     - 
     - 【API 1.39+】 構築時に利用する SSH エージェントのソケットやキー（BuildKit 有効時のみ）（書式：default | <id>[=<socket>] | <key>[,<key>]] ）
   * - ``--stream``
     - 
     - サーバにアクセスし、構築コンテクストの状況を表示し続ける
   * - ``--tag`` 、 ``-t``
     - 
     - 名前と、オプションでタグを ``名前:タグ`` の形式で指定
   * - ``--target``
     - 
     - 構築する対象の構築ステージを指定
   * - ``--ulimit``
     - 
     - ulimit オプション

.. _docker-build-examples:


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

この例では ``PATH`` に ``.`` を指定しています。このローカルディレクトリにある全てのファイルは ``tar`` 化され、Docker デーモンに送られます。 ``PATH`` で示すのは、Docker デーモンが構築時に使う「コンテクスト」（内容物）としてのファイルを見つけるための場所です。デーモンはリモート上のマシンでも操作できるのを思い出してください。これは、クライアント側（ ``docker build`` コマンドを実行した場所 ）では Dockerfile は何らパース（解析）されません。つまり、 ``PATH`` に含まれる *すべて* のファイルが送信されるだけでなく、Dockerfile の :ref:`ADD <builder-add>` 命令で追加した場所も含みます。

.. The transfer of context from the local machine to the Docker daemon is what the docker client means when you see the “Sending build context” message.

ローカルのマシンから Docker デーモンにコンテクストを送信時、 ``docker`` クライアントには「Sending build context」（構築コンテクストの送信中）とメッセージが表示されます。

.. If you wish to keep the intermediate containers after the build is complete, you must use --rm=false. This does not affect the build cache.

構築完了後、中間コンテナをそのまま維持したい場合は、 ``--rm=false`` の指定が必要です。こちらを指定すると、構築キャッシュに何もしません。

.. Build with URL

.. _build-with-url:

URL で構築
--------------------

.. code-block:: bash

    $ docker build github.com/creack/docker-firefox

.. This will clone the GitHub repository and use the cloned repository as context. The Dockerfile at the root of the repository is used as Dockerfile. You can specify an arbitrary Git repository by using the git:// or git@ scheme.

これは GitHub リポジトリのクローンを作成し、クローンしたリポジトリをコンテクストとして利用します。リポジトリのルートにある Dockerfile を、構築時の Dockerfile として使います。 ``git://`` や ``git@`` などを使って、その他の Git リポジトリも指定可能です。

.. code-block:: bash

   $ docker build -f ctx/Dockerfile http://server/ctx.tar.gz
   
   Downloading context: http://server/ctx.tar.gz [===================>]    240 B/240 B
   Step 1/3 : FROM busybox
    ---> 8c2e06607696
   Step 2/3 : ADD ctx/container.cfg /
    ---> e7829950cee3
   Removing intermediate container b35224abf821
   Step 3/3 : CMD /bin/ls
    ---> Running in fbc63d321d73
    ---> 3286931702ad
   Removing intermediate container fbc63d321d73
   Successfully built 377c409b35e4

.. This sends the URL http://server/ctx.tar.gz to the Docker daemon, which downloads and extracts the referenced tarball. The -f ctx/Dockerfile parameter specifies a path inside ctx.tar.gz to the Dockerfile that is used to build the image. Any ADD commands in that Dockerfile that refers to local paths must be relative to the root of the contents inside ctx.tar.gz. In the example above, the tarball contains a directory ctx/, so the ADD ctx/container.cfg / operation works as expected.

これは Docker デーモンに対して URL ``http://server/ctx.tar.gz`` を送り、Docker デーモンが指定された tar ボールのダウンロードと展開をします。 ``-f ctx/Dockerfile`` パラメータが示すのは、 ``ctx.tar.gz`` の中にある ``Dockerfile`` のパスで、これをイメージ構築時に使います。 ``Dockerfile`` 内のあらゆる ``ADD`` コマンドは、 ``ctx.tar.gz`` 内にあるルートからの相対パスで指定する必要があります。先の例では、 tar ボールには ``ctx/`` ディレクトリを含むので、 ``ADD ctx/container.cfg /`` は動作するでしょう。

.. Build with -

.. _docker-build-build-with:

\- で構築
--------------------

.. code-block:: bash

   $ docker build - < Dockerfile

.. This will read a Dockerfile from STDIN without context. Due to the lack of a context, no contents of any local directory will be sent to the Docker daemon. Since there is no context, a Dockerfile ADD only works if it refers to a remote URL.

これはコンテクストを使わずに ``STDIN`` から Dockerfile を読み込みます。コンテクストが無いため、中身の無いローカルのディレクトリが Docker デーモンに送信されます。コンテクストがありませんので、 Dockerfile の ``ADD`` はリモートの URL の参照に使えます。

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

.. This example shows the use of the .dockerignore file to exclude the .git directory from the context. Its effect can be seen in the changed size of the uploaded context. The builder reference contains detailed information on creating a .dockerignore file.

この例で表示しているのは、 ``.dockerignore`` ファイルを使い、コンテクストから ``.git`` ディレクトリを除外しています。この効果により、アップロードされるコンテクストの容量を小さくしています。構築時のリファレンス :ref:`.dockerignore ファイルの作成 <dockerignore-file>` に、より詳しい情報があります。

.. When using the BuildKit backend, docker build searches for a .dockerignore file relative to the Dockerfile name. For example, running docker build -f myapp.Dockerfile . will first look for an ignore file named myapp.Dockerfile.dockerignore. If such a file is not found, the .dockerignore file is used if present. Using a Dockerfile based .dockerignore is useful if a project contains multiple Dockerfiles that expect to ignore different sets of files.

:ref:`BuildKit バックエンド <builder-buildkit>` の利用時、 ``docker build`` は Dockerfile 名に関連する ``.dockerignore`` ファイルを探します。たとえば、 ``docker build -f myapp.Dockerfile .`` を実行すると、最初に ``myapp.Dockerfile.dockerignore``  という名前の無視ファイルを探します。そのようなファイルがない場合、 ``.dockerignore`` があれば使います。プロジェクトに複数の Dockerfile がある場合は、様々なファイルと混在しないようにするため、 Dockerfile をベースとする ``.dockerignore`` の利用が便利です。

.. Tag image (-t)

.. _docker-build-tag-image:

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

.. _docker-build-specify-dockerfile:

Dockerfile の指定（-f）
------------------------------

.. code-block:: bash

   $ docker build -f Dockerfile.debug .

.. This will use a file called Dockerfile.debug for the build instructions instead of Dockerfile.

構築時の命令は ``Dockerfile`` ではなく、 ``Dockerfile.debug`` という名前のファイルを使います。

.. code-block:: bash

   $ curl example.com/remote/Dockerfile | docker build -f - .

.. The above command will use the current directory as the build context and read a Dockerfile from stdin.

この上のコマンドは、現在のディレクトリを構築コンテクストとして使い、標準入力から Dockerfile を読み込みます。

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

   ``docker build`` で ``no such file or directory`` エラーを返すのは、アップロードすべきコンテクストとしてのファイルやディレクトリが存在しない時です。これは、コンテクストが存在しないか、指定したファイルがホストシステム上に存在していない可能性があります。コンテクストはカレント・ディレクトリ（と、その子ディレクトリ）のみに安全上の理由で制限されています。これはリモートの Docker ホスト上でも、繰り返し構築できるようにするためです。これが ``ADD ../file`` が動作しない理由でもあります。

.. Optional parent cgroup (--cgroup-parent)

.. _docker-build-optional-parent-cgroup:

親 cgroup のオプション（--cgroup-parent）
--------------------------------------------------

.. When docker build is run with the --cgroup-parent option the containers used in the build will be run with the corresponding docker run flag.

``docker build`` に ``--cgroup-parent`` オプションを付けて構築すると、構築時の ``docker run`` 実行時に :ref:`適切なフラグを付けて実行 <specifying-custom-cgroups>` します。

.. Set ulimits in container (--ulimit)

.. _docker-build-set-ulimits-in-container:

コンテナの ulimit をセット（--ulimit）
----------------------------------------

.. Using the --ulimit option with docker build will cause each build step’s container to be started using those --ulimit flag values.

``docker build`` に ``--ulimit`` オプションを付けて実行したら、コンテナの構築ステップを開始する時、都度 ``--ulimit`` :doc:`フラグの値を設定 <run>` します。

.. Set build-time variables (--build-arg)

.. _docker-build-set-build-time-variables:

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

.. You may also use the --build-arg flag without a value, in which case the value from the local environment will be propagated into the Docker container being built:

また、値のない ``--build-arg`` フラグも使うこともでき、その場合、ローカル環境の値が、構築時の Docker コンテナ内に継承されます。

.. code-block:: bash

   export HTTP_PROXY=http://10.20.30.2:1234
   docker build --build-arg HTTP_PROXY .

.. This is similar to how docker run -e works. Refer to the docker run documentation for more information.

これは ``docker run -e`` の挙動に似ています。詳しい情報は :ref:`docker run ドキュメント <set-environment-variable>` をご覧ください。

.. Optional security options (--security-opt)

.. _docker-build-optional-security-options:

オプションのセキュリティオプション（--security-opt）
------------------------------------------------------------

.. This flag is only supported on a daemon running on Windows, and only supports the credentialspec option. The credentialspec must be in the format file://spec.txt or registry://keyname.

このフラグをサポートしているのは、 Windows 上で実行しているデーモンで、かつ ``credentialspec`` オプションをサポートしている場合のみです。 ``credentialspec`` の形式は ``file://spec.txt`` か ``registry://keyname`` どちらかの必要があります。

.. Specify isolation technology for container (--isolation)

.. _docker-build-specify-isolation-technology-for-container:

コンテナの隔離技術を指定（--isolation）
----------------------------------------

.. This option is useful in situations where you are running Docker containers on Windows. The --isolation=<value> option sets a container’s isolation technology. On Linux, the only supported is the default option which uses Linux namespaces. On Microsoft Windows, you can specify these values:

このオプションは Windows 上で Docker コンテナを実行する状況で役立ちます。 ``--isolation=<値>`` オプションは、コンテナの隔離技術を指定します。Linux 上では Linux 名前空間を使う ``default`` オプションしかサポートしていません。Microsoft Windows 上では、これらの値を指定できます。

.. list-table::
   :header-rows: 1

   * - 値
     - 説明
   * - ``default``
     - Docker デーモンの ``--exec-opt`` で指定している値を使います。隔離技術に ``daemon`` の指定がなければ、 Microsoft Windows はデフォルトの値として ``process`` を使います。
   * - ``process``
     - 名前空間の分離のみです。
   * - ``hyperv``
     - Hyper-V ハイパーバイザ・パーティションをベースとする隔離です。

.. Specifying the --isolation flag without a value is the same as setting --isolation="default".

値の無い ``--isolation`` フラグの指定は、 ``--isolation="default"`` を指定するのと同じです。

.. Add entries to container hosts file (--add-host)

コンテナの hosts ファイルにエントリを追加（--add-host）
------------------------------------------------------------

.. You can add other hosts into a container’s /etc/hosts file by using one or more --add-host flags. This example adds a static address for a host named docker:

1つまたは複数の ``--add-host`` を使い、コンテナ内の ``/etc/hosts`` ファイルに他のホスト情報を追加できます。

.. code-block:: bash

   $ docker build --add-host=docker:10.180.0.1 .

.. Specifying target build stage (--target)

構築ステージの対象を指定（--target）
----------------------------------------

.. When building a Dockerfile with multiple build stages, --target can be used to specify an intermediate build stage by name as a final stage for the resulting image. Commands after the target stage will be skipped.

複数の構築ステージがある Dockerfile を使って構築する時に、中間構築ステージを  ``--target`` の名前で指定すると、そこを最終ステージとするイメージを作成できます。コマンドで指定した対象以降のステージはスキップされます。

.. code-block:: dockerfile

   FROM debian AS build-env
   ...
   
   FROM alpine AS production-env
   ...

.. code-block:: bash

   docker build -t mybuildimage --target build-env .

.. Custom build outputs

構築時の出力を変更
------------------------------

.. By default, a local container image is created from the build result. The --output (or -o) flag allows you to override this behavior, and a specify a custom exporter. For example, custom exporters allow you to export the build artifacts as files on the local filesystem instead of a Docker image, which can be useful for generating local binaries, code generation etc.

デフォルトでは、構築処理の結果を元に、ローカルのコンテナイメージが作成されます。 ``--output`` （あるいは ``-o`` ）フラグによって、この挙動を変更し、任意の :ruby:`出力形式 <exporter>` を指定できます。たとえば、任意の出力指定によって、Docker イメージではなくローカルファイルシステム上にファイルとして構築時の成果物を出力できるため、ローカルでのバイナリ生成やコード生成等に役立てるでしょう。

.. The value for --output is a CSV-formatted string defining the exporter type and options. Currently, local and tar exporters are supported. The local exporter writes the resulting build files to a directory on the client side. The tar exporter is similar but writes the files as a single tarball (.tar).

``--output`` の値は、出力形式とオプションを CSV 形式の文字で定義します。現時点では ``local`` と ``tar`` の出力形式をサポートします。 ``local`` 出力形式では、構築結果のファイルをクライアント側ディレクトリ上に書き出します。 ``tar`` 出力形式は似ていますが、単一の tar ボール（ ``.tar`` ）としてファイルを書き出します。

.. If no type is specified, the value defaults to the output directory of the local exporter. Use a hyphen (-) to write the output tarball to standard output (STDOUT).

出力形式の指定が無ければ、値はデフォルトでローカルのディレクトリに出力します。ハイフン（ ``-`` ）を使えば、tar ボールへの出力を標準出力（ ``STDOUT`` ）に書き出します。

.. The following example builds an image using the current directory (.) as build context, and exports the files to a directory named out in the current directory. If the directory does not exist, Docker creates the directory automatically:

以下の例は、現在のディレクトリ（ ``.`` ）を構築コンテクストとしてイメージを構築し、このディクトリ以下に、 ``out`` という名前のディレクトリへファイルを出力します。もしもディレクトリが存在しなければ、Docker はディレクトリを自動的に作成します。

.. code-block:: bash

   $ docker build -o out .

.. The example above uses the short-hand syntax, omitting the type options, and thus uses the default (local) exporter. The example below shows the equivalent using the long-hand CSV syntax, specifying both type and dest (destination path):

上の例では ``type`` オプションを省略した短い構文を使いましたので、この場合はデフォルト（ ``local`` ）出力形式が使われました。以下の例では同じ内容を、 ``type`` と ``dest`` （出力先のパス）の両方を記載する、 CSV 形式の長い構文を使って表しています。

.. code-block:: bash

   $ docker build --output type=local,dest=out .

.. Use the tar type to export the files as a .tar archive:

``tar`` タイプを使うと、ファイルを ``.tar`` アーカイブとして出力します。

.. code-block:: bash

   $ docker build --output type=tar,dest=out.tar .

.. The example below shows the equivalent when using the short-hand syntax. In this case, - is specified as destination, which automatically selects the tar type, and writes the output tarball to standard output, which is then redirected to the out.tar file:

短い構文を使い、同等の処理を行うのが以下の例です。こちらの場合、 ``-`` は出力先の指定となり、自動的に ``tar`` タイプが選ばれます。そして、 tar ボールへの出力として書き出されるよう、標準出力は ``out.tar`` ファイルにリダイレクトします。

.. code-block:: bash

   docker build -o - . > out.tar

.. The --output option exports all files from the target stage. A common pattern for exporting only specific files is to do multi-stage builds and to copy the desired files to a new scratch stage with COPY --from.

``--output`` オプションは対象となる構築ステージすべてのファイルを書き出します。ファイルを指定して出力する一般的なパターンは、マルチステージでの構築において、 ``COPY --from`` でゼロから新しいステージの構築時、必要なファイルをコピーするためです。

.. The example Dockerfile below uses a separate stage to collect the build-artifacts for exporting:

以下の ``Dockerfile`` 例は、構築による成果物を集めて出力するため、構築ステージを分けています。

.. code-block:: dockerfile

   FROM golang AS build-stage
   RUN go get -u github.com/LK4D4/vndr
   
   FROM scratch AS export-stage
   COPY --from=build-stage /go/bin/vndr /

.. When building the Dockerfile with the -o option, only the files from the final stage are exported to the out directory, in this case, the vndr binary:

Dockerfile を ``-o`` オプションで構築する時は、最終ステージのファイルのみが ``out`` ディレクトリに出力されます。この例では ``nvdr`` バイナリです。

.. code-block:: bash

   $ docker build -o out .
   
   [+] Building 2.3s (7/7) FINISHED
    => [internal] load build definition from Dockerfile                                                                          0.1s
    => => transferring dockerfile: 176B                                                                                          0.0s
    => [internal] load .dockerignore                                                                                             0.0s
    => => transferring context: 2B                                                                                               0.0s
    => [internal] load metadata for docker.io/library/golang:latest                                                              1.6s
    => [build-stage 1/2] FROM docker.io/library/golang@sha256:2df96417dca0561bf1027742dcc5b446a18957cd28eba6aa79269f23f1846d3f   0.0s
    => => resolve docker.io/library/golang@sha256:2df96417dca0561bf1027742dcc5b446a18957cd28eba6aa79269f23f1846d3f               0.0s
    => CACHED [build-stage 2/2] RUN go get -u github.com/LK4D4/vndr                                                              0.0s
    => [export-stage 1/1] COPY --from=build-stage /go/bin/vndr /                                                                 0.2s
    => exporting to client                                                                                                       0.4s
    => => copying files 10.30MB                                                                                                  0.3s
   
   $ ls ./out
   vndr

.. This feature requires the BuildKit backend. You can either enable BuildKit or use the buildx plugin which provides more output type options.

.. note::

   この機能は BuildKit バックエンドが必要です。 :ref:`BuildKit の有効化 <builder-buildkit>` か :doc:`buildx </docker/buildx>` プラグインを使うかどちらかにより、さらに出力形式のオプションが使えるようになります。

.. Specifying external cache sources

.. _specifying-external-cache-sources:

外部キャッシュ・ソースの指定
------------------------------

.. In addition to local build cache, the builder can reuse the cache generated from previous builds with the --cache-from flag pointing to an image in the registry.

ローカルの構築キャッシュに加え、ビルダーは以前のビルドで生成したキャッシュを再利用できます。そのためには、 ``--cache-from`` フラグでレジストリのイメージを指定します。

.. To use an image as a cache source, cache metadata needs to be written into the image on creation. This can be done by setting --build-arg BUILDKIT_INLINE_CACHE=1 when building the image. After that, the built image can be used as a cache source for subsequent builds.

イメージをキャッシュのソースとして使うには、作成するイメージ上にキャッシュのメタデータを書き込めるようにする必要があります。そのためには、イメージの構築時に ``--build-arg BUILDKIT_INLINE_CACHE=1`` を実行します。その後、構築イメージを以降の構築時にキャッシュ元として利用できます。

.. Upon importing the cache, the builder will only pull the JSON metadata from the registry and determine possible cache hits based on that information. If there is a cache hit, the matched layers are pulled into the local environment.

キャッシュを取り込んだ結果、ビルダはレジストリからは JSON メタデータのみ取得し、その情報を元にキャッシュになりうる可能性があるかどうかを決めます。キャッシュに一致すると、対象のレイヤがローカル環境に渡されます。

.. In addition to images, the cache can also be pulled from special cache manifests generated by buildx or the BuildKit CLI (buildctl). These manifests (when built with the type=registry and mode=max options) allow pulling layer data for intermediate stages in multi-stage builds.

イメージに加え、キャッシュは ``buildx`` や BuildKit CLI （ ``buildctl`` ）によって生成された特別なキャッシュ・マニフェストからも取得できます。これらのマニフェスト（ ``type=registry`` と ``mode=max`` オプションを指定して構築時 ）により、レイヤデータやマルチステージ・ビルドにおける中間ステージから取得できるようになります。

.. The following example builds an image with inline-cache metadata and pushes it to a registry, then uses the image as a cache source on another machine:

以下の例は、中間キャッシュのメタデータでイメージを構築し、レジストリにそれを送ります。以降は、他のマシンでのキャッシュソースとしてイメージが利用できます。

.. code-block:: bash

   $ docker build -t myname/myapp --build-arg BUILDKIT_INLINE_CACHE=1 .
   $ docker push myname/myapp

.. After pushing the image, the image is used as cache source on another machine. BuildKit automatically pulls the image from the registry if needed.

イメージの送信後、イメージは他マシンでのキャッシュソースとして利用できます。 BuildKit は必要があれば、自動的にレジストリからイメージを取得します。

.. On another machine:

他のマシン上で：

.. code-block:: bash

   $ vdocker build --cache-from myname/myapp .

..    Note
    This feature requires the BuildKit backend. You can either enable BuildKit or use the buildx plugin. The previous builder has limited support for reusing cache from pre-pulled images.

.. note::

   この機能には BuildKit バックエンドが必要です。 :ref:`BuildKit を有効化 <builder-buildkit>` するか、 `buildx <https://github.com/docker/buildx>`_ プラグインを使用するかのいずれかです。BuildKit は、必要があればレジストリから自動的にイメージを取得します。

.. Squash an image's layers (--squash) (experimental)

.. _squash-an-images-layers---squash:

イメージのレイヤを :ruby:`スカッシュ <squash>` (--squash) (実験的機能)
--------------------------------------------------------------------------------

.. Overview

概要
^^^^^^^^^^

.. Once the image is built, squash the new layers into a new image with a single new layer. Squashing does not destroy any existing image, rather it creates a new image with the content of the squashed layers. This effectively makes it look like all Dockerfile commands were created with a single layer. The build cache is preserved with this method.

イメージを構築次第、新しいレイヤを、新しいイメージの1つのレイヤに :ruby:`スカッシュ <squash>` （訳者注：「押し潰す」あるいは「圧縮」の意味合い）します。スカッシュでは既存のレイヤを一切破棄しません。まあ、スカッシュしたレイヤの内容を元に、新しいイメージを作成した場合も同様です。これは事実上、 ``Dockerfile`` 命令で全てによって、1つのレイヤを作成したかのように見えます。なおスカッシュ時に構築イメージは保持されます。

.. The --squash option is an experimental feature, and should not be considered stable.

``--squash`` オプションは実験的機能です。そのため、安定していないと考えるべきです。

.. Squashing layers can be beneficial if your Dockerfile produces multiple layers modifying the same files, for example, files that are created in one step, and removed in another step. For other use-cases, squashing images may actually have a negative impact on performance; when pulling an image consisting of multiple layers, layers can be pulled in parallel, and allows sharing layers between images (saving space).

レイヤの圧縮が役立つのは、同じ Dockerfile から複数のレイヤをに修正を加える場合です。たとえば、ステップ1でファイルを作成し、それを他のステップに移動する場合です。一方で、使用例によっては、イメージの圧縮が性能に悪影響をあたえてしまうかもしれません。具体的には、イメージが複数のレイヤで構成されている場合は、各レイヤは並列に取得でき、かつ、イメージ間でレイヤを共有できるためです（容量の節約）。

.. For most use cases, multi-stage builds are a better alternative, as they give more fine-grained control over your build, and can take advantage of future optimizations in the builder. Refer to the use multi-stage builds section in the userguide for more information.

ほとんどの場合、マルチステージ・ビルドは望ましい手法です。構築における詳細な制御が出来るため、以降の構築を最適化する利点があります。詳しい情報はユーザガイドの :doc:`マルチステージ・ビルド </develop/develop-images/multistage-build>` セクションをご覧ください。

.. Known limitations

判明している制限
^^^^^^^^^^^^^^^^^^^^

.. The --squash option has a number of known limitations:

``--squash`` オプションには、いくつかの制限が判明しています：

..  When squashing layers, the resulting image cannot take advantage of layer sharing with other images, and may use significantly more space. Sharing the base image is still supported.
    When using this option you may see significantly more space used due to storing two copies of the image, one for the build cache with all the cache layers intact, and one for the squashed version.
    While squashing layers may produce smaller images, it may have a negative impact on performance, as a single layer takes longer to extract, and downloading a single layer cannot be parallelized.
    When attempting to squash an image that does not make changes to the filesystem (for example, the Dockerfile only contains ENV instructions), the squash step will fail (see issue #33823).

- レイヤの圧縮で作成されたイメージは、他のイメージとレイヤを共有できる利点を得られません。また、より多くの容量を必要とする場合もあります。ベース・イメージの共有はサポートしています。
- このオプションを使うことで、イメージのコピーを2つ持つため、著しく容量を使う場合があります。1つは、各キャッシュレイヤの原型となる構築キャッシュです。もう1つは、圧縮されたイメージです。
- レイヤの圧縮で小さなイメージが作成できるかもしれませんが、性能に悪影響をあたえる可能性があります。単一のレイヤは以後展開できませんし、並列ダウンロードもできません。
- イメージ圧縮を試みる時、ファイルシステムの変更を伴わなければ、圧縮ステップは失敗します（ `issue #33823 <https://github.com/moby/moby/issues/33823>`_ をご覧ください）。

.. Prerequisites

動作条件
^^^^^^^^^^

.. The example on this page is using experimental mode in Docker 19.03.

このページの例は Docker 19.03 の :ruby:`実験的モード <experimental mode>` を使っています。

.. Experimental mode can be enabled by using the --experimental flag when starting the Docker daemon or setting experimental: true in the daemon.json configuration file.

実験的モードを有効にするには、 Docker デーモンのの起動時に ``--experimental`` フラグを付けるか、 ``daemon.json`` 設定ファイル内で ``experimental: true`` を指定します

.. By default, experimental mode is disabled. To see the current configuration of the docker daemon, use the docker version command and check the Experimental line in the Engine section:

デフォルトでは、実験的モードは無効化されています。

.. code-block:: bash

   Client: Docker Engine - Community
    Version:           19.03.8
    API version:       1.40
    Go version:        go1.12.17
    Git commit:        afacb8b
    Built:             Wed Mar 11 01:21:11 2020
    OS/Arch:           darwin/amd64
    Experimental:      false
   
   Server: Docker Engine - Community
    Engine:
     Version:          19.03.8
     API version:      1.40 (minimum version 1.12)
     Go version:       go1.12.17
     Git commit:       afacb8b
     Built:            Wed Mar 11 01:29:16 2020
     OS/Arch:          linux/amd64
     Experimental:     true
    [...]

.. To enable experimental mode, users need to restart the docker daemon with the experimental flag enabled.

実験的モードを有効化するには、実験的（experimental）フラグを有効にして Docker デーモンを再起動する必要があります。

.. Enable Docker experimental

Docker 実験的モードの有効化
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To enable experimental features, you need to start the Docker daemon with --experimental flag. You can also enable the daemon flag via /etc/docker/daemon.json, for example:

実験的モードを湯考課するには、 ``--experimental`` フラグを付けて Docker デーモンを再起動する必要があります。あるいは、 ``/etc/docker/daemon.json`` を通してデーモンのフラグを有効化できます。以下は例です。

.. code-block:: yaml

   {
       "experimental": true
   }

.. Then make sure the experimental flag is enabled:

それから、実験的フラグの有効化を確認します：

.. code-block:: bash

   $ docker version -f '{{.Server.Experimental}}'
   true

..   Build an image with --squash argument

``--squash`` 引数でイメージを構築
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. The following is an example of docker build with --squash argument

以下は、 docker build で ``--squash`` 引数を付ける例です。

.. code-block:: dockerfile

   FROM busybox
   RUN echo hello > /hello
   RUN echo world >> /hello
   RUN touch remove_me /remove_me
   ENV HELLO=world
   RUN rm /remove_me

.. An image named test is built with --squash argument.

イメージ名 ``test`` に、 ``--squash`` 引数を付けて構築します。

.. code-block:: dockerfile

   $ docker build --squash -t test .
   
   <...>

.. If everything is right, the history looks like this:

すべてが正しければ、history はこのようになります。

.. code-block:: dockerfile

   $ docker history test
   
   IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
   4e10cb5b4cac        3 seconds ago                                                       12 B                merge sha256:88a7b0112a41826885df0e7072698006ee8f621c6ab99fca7fe9151d7b599702 to sha256:47bcc53f74dc94b1920f0b34f6036096526296767650f223433fe65c35f149eb
   <missing>           5 minutes ago       /bin/sh -c rm /remove_me                        0 B
   <missing>           5 minutes ago       /bin/sh -c #(nop) ENV HELLO=world               0 B
   <missing>           5 minutes ago       /bin/sh -c touch remove_me /remove_me           0 B
   <missing>           5 minutes ago       /bin/sh -c echo world >> /hello                 0 B
   <missing>           6 minutes ago       /bin/sh -c echo hello > /hello                  0 B
   <missing>           7 weeks ago         /bin/sh -c #(nop) CMD ["sh"]                    0 B
   <missing>           7 weeks ago         /bin/sh -c #(nop) ADD file:47ca6e777c36a4cfff   1.113 MB

.. We could find that a layer's name is <missing>, and there is a new layer with COMMENT merge.

ここから分かるのは、レイヤ名は `<missing>` （不明）となり、新しいレイヤにコメント ``merge`` があります。

.. Test the image, check for /remove_me being gone, make sure hello\nworld is in /hello, make sure the HELLO environment variable's value is world.

このイメージを調べ、 ``/remove_me`` は消失し、 ``hello\nworld`` は ``/hello`` の中にあり、環境変数 ``HELLO`` の値が ``world`` になっているのを確認しましょう。

.. seealso:: 

   build
      https://docs.docker.com/engine/reference/commandline/build/
