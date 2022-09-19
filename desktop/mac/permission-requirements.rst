.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/mac/permission-requirements/
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/mac/permission-requirements.md
.. check date: 2022/09/10
.. Commits on Aug 31, 2022 9e193c06a8412a8f27e6f9b45de86dd06e95f335
.. -----------------------------------------------------------------------------

.. Understand permission requirements for Mac
.. _understand-permission-requirements-for-mac:

==================================================
Mac のアクセス権要求を理解
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. This page contains information about the permission requirements for running and installing Docker Desktop on Mac, the functionality of the privileged helper process com.docker.vmnetd and the reasoning behind this approach.

このページには、 Docker Desktop を Mac 上にインストールして実行するために必要な、アクセス権の要求についての情報が入っています。プロセス ``com.docker.vmnetd`` に対する :ruby:`特権ヘルパーサービス <privileged helper process>` について、この手法の背景にある理由を扱います。

.. It also provides clarity on running containers as root as opposed to having root access on the host.

また、ホスト上で ``root`` アクセス権を持つのではなく、コンテナを ``root`` として実行するのも明確にします。

.. Permission requirements
.. _mac-permission-requirements:

:ruby:`アクセス権の要求 <permission requirements>`
==================================================

.. In the default set up flow, Docker Desktop for Mac does not require root privileges for installation but does require root access to be granted on the first run. The first time that Docker Desktop is launched the user receives an admin prompt to grant permissions for a privileged helper service to be installed. For subsequent runs, no root privileges are required.

標準のセットアップ手順では、 Docker Desktop for Mac のインストールに管理者権限を必要としません。ですが、初めての実行時、 ``root`` 権限の許可が必要です。Docker Desktop の初回起動時、特権ヘルパーサービスをインストールする権限を与えるよう、管理者としてログインするようユーザに求めます。以降の実行では、 ``root`` 権限は不要です。

.. The reason for this is that Docker Desktop needs to perform a limited set of privileged operations using the privileged helper process com.docker.vmnetd. This approach allows, following the principle of least privilege, root access to be used only for the operations for which it is absolutely necessary, while still being able to use Docker Desktop as an unprivileged user.

Docker Desktop が特権ヘルパープロセス ``com.docker.vmnetd`` を使うようにしている理由は、限定的な一連の特権が必要な操作を処理するためです。この手法は、最小限の権限という原則に従い、間違いなく必要な処理のみ ``root`` にアクセスできるようにするため、Docker Desktop に特権を与えないまま利用できます。

.. In version 4.11 and above of Docker Desktop for Mac you can avoid running the privileged helper service in the background by using the --user flag on the install command. This will result in com.docker.vmnetd being used for set up during installation and then disabled at runtime. In this case, the user will not be prompted to grant root privileges on the first run of Docker Desktop. Specifically, the --user flag:

Docker Desktop for Mac のバージョン 4.11 以上からは、 :ref:`コマンドでのインストール <mac-install-from-the-command-line>` に ``--user`` フラグを使うと、バックグランドで特権ヘルパーサービスが実行するのを阻止します。この結果、 ``com.docker.vmnet`` はインストール中のみ利用されますが、実行時には無効化されます。そうすると、 Docker Desktop を初めて実行する時に、管理者としてのログインを求める画面が表示されません。具体的に、 ``--user`` フラグとは：

..  Uninstalls the previous com.docker.vmnetd if present
    Sets up symlinks for the user
    Ensures that localhost and kubernetes.docker.internal are present in /etc/hosts

* 以前の ``com.docker.vmnetd`` が存在する場合、アンインストール
* ユーザに対する :ruby;`シンボリックリンク <symlinks>` のセットアップ
* ``localhost`` と ``kubernetes.docker.internal`` が ``/etc/hosts`` に確実に現れるようにする

.. This approach has the following limitations:

この手法には、以下の制限があります：

..  Docker Desktop can only be run by one user account per machine, namely the one specified in the -–user flag.
    Binding privileged ports (<1024) on 127.0.0.1 will not work. For example, docker run -p 127.0.0.1:80:80 docker/getting-started will fail, docker run -p 80:80 docker/getting-started however will succeed as binding privileged ports on 0.0.0.0 is no longer a privileged operation on recent versions of MacOS.
    Spindump diagnostics for fine grained CPU utilization are not gathered.

.. Privileged Helper
.. _mac-privileged-helper:

:ruby:`特権ヘルパー <privileged helper>`
==================================================

.. The privileged helper is started by launchd and runs in the background unless it is disabled at runtime as previously described. The Docker Desktop backend communicates with it over the UNIX domain socket /var/run/com.docker.vmnetd.sock. The functionalities it performs are:

特権ヘルパーは ``launched`` によって起動され、前述の通り、無効化しなければ実行時にバックグラウンドで動き続けます。Docker Desktop バックエンドとは、 Unix ドメインソケット ``/var/run/com.docker.vmnetd.sock`` で通信します。次のような処理が行われます：

..  Installing and uninstalling symlinks in /usr/local/bin. This ensures the docker CLI is on the user’s PATH without having to reconfigure shells, log out then log back in for example.
    Binding privileged ports that are less than 1024. The so-called “privileged ports” have not generally been used as a security boundary, however OSes still prevent unprivileged processes from binding them which breaks commands like docker run -p 80:80 nginx
    Ensuring localhost and kubernetes.docker.internal are defined in /etc/hosts. Some old macOS installs did not have localhost in /etc/hosts, which caused Docker to fail. Defining the DNS name kubernetes.docker.internal allows us to share Kubernetes contexts with containers.
    Securely caching the Registry Access Management policy which is read-only for the developer.
    Performing some diagnostic actions, in particular gathering a performance trace of Docker itself.
    Uninstalling the privileged helper.

* ``/usr/local/bin`` にシンボリックリンクをインストールまたはアンインストールする。これにより ``docker`` CLI がユーザのシェル上のパスになくても、ログアウトやログアウトせずに利用できる。
* 特権ポートの :ruby:`確保 <bind>` は 1024 以下。いわゆる「 :ruby:`特権ポート <privileged ports>` 」は一般的にセキュリティ境界として使用していない。しかし、 OS では依然として特権のないプロセスによるポート確保を防ごうとするので、 ``docker run -p 80:80 nginx`` のようなコマンドは使えない。
* ``localhost`` と ``kubernetes.docker.internal` が ``/etc/hosts`` で定義されるようにする。いくつかの古い macOS へのインストールでは、 ``/etc/hosts`` に ``localhost`` がないため、 Docker は起動失敗します。 DNS 名 ``kubernetes.docker.internal`` の定義により、Kubernetes のコンテキストにコンテナを共有できる。
* 開発者には、読み込み専用のレジストリ アクセス管理ポリシーを、安全にキャッシュする。
* 特権へルパをアンインストールする。

.. Containers running as root within the Linux VM
.. _mac-containers-running-as-root-within-the-linux-vm:

Linux VM 内で root としてコンテナを実行
========================================

.. The Docker daemon and containers run in a lightweight Linux VM managed by Docker. This means that although containers run by default as root, this does not grant root access to the Mac host machine. The Linux VM serves as a security boundary and limits what resources can be accessed from the host. Any directories from the host bind mounted into Docker containers still retain their original permissions.

Docker デーモンとコンテナは、Docker によって管理されている軽量な Linux VM 内で実行されます。これはつまり、コンテナはデフォルトでは ``root`` として実行しているとはいえ、Mac ホストマシンに対しての ``root`` アクセス許可ではありません。Linux VM サーバはセキュリティ境界であり、ホストからどのリソースにアクセスできるか制限があります。ホストから Docker コンテナ内にバインド マウントされるあらゆるディレクトリは、元々のパーミッションを維持したままです。

.. seealso:: 

   Understand permission requirements for Mac
      https://docs.docker.com/desktop/mac/permission-requirements/
