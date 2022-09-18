.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/desktop/faqs/macfaqs/
   doc version: 19.03
      https://github.com/docker/docker.github.io/blob/master/docker-for-mac/faqs.md
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/desktop/faqs/macfaqs.md
.. check date: 2022/09/18
.. Commits on Jul 2, 2022 22c2d4f57d202aaf8d799ca46ca6d92632e9f2fd
.. -----------------------------------------------------------------------------

.. Frequently asked questions for Mac
.. _desktop-frequently-asked-questions-for-mac:

==================================================
よくある質問と回答 Mac 版
==================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. What is Docker.app?
.. _deksop-mac-what-is-docker-app:

Docker.app とは何ですか？
--------------------------------------------------

.. Docker.app is Docker Desktop on Mac. It bundles the Docker client and Docker Engine. Docker.app uses the macOS Hypervisor.framework to run containers.

``Docker.app`` は Mac 上の Docker Desktop です。Docker クライアントと Docker Engine が同梱されています。 ``Docker.app`` は macOS Hypervisor.framework でコンテナを実行します。


.. What is HyperKit?
.. _desktop-mac-what-is-hyperkit:

HyperKit とは何ですか？
--------------------------------------------------

.. HyperKit is a hypervisor built on top of the Hypervisor.framework in macOS. It runs entirely in userspace and has no other dependencies.

HyperKit はmacOS の Hypervisor.framerowk 上に構築されたハイパーバイザです。これは他の依存関係なく、ユーザ空間全体を実行できます。

.. We use HyperKit to eliminate the need for other VM products, such as Oracle VirtualBox or VMWare Fusion.

私たちが HyperKit を採用するのは、 Oracle VirtualBox や VMWare Fusion のような他の仮想マシンプロダクトの必要性を無くすためです。

.. What is the benefit of HyperKit?
.. _desktop-mac-what-is-the-benefit-of-hyperkit:

HyperKit の利点は何ですか？
--------------------------------------------------

.. HyperKit is thinner than VirtualBox and VMWare fusion, and the version we include is customized for Docker workloads on Mac.

HyperKit は VirtualBox や VMware fusion よりも薄く、Mac 上で Docker ワークロード向けにカスタマイズしたバージョンだからです。

.. Why is com.docker.vmnetd running after I quit the app?
.. _desktop-mac--why-is-com.docker.vmnetd-running-after-i-quit-the-app:

アプリを終了後も、どうして com.docker.vmnetd が動いているのですか？
----------------------------------------------------------------------

.. The privileged helper process com.docker.vmnetd is started by launchd and runs in the background. The process does not consume any resources unless Docker.app connects to it, so it’s safe to ignore.

特権ヘルパー・プロセス :code:`com.docker.vmnetd`  は :code:`launched` によって開始され、バックグラウンドで動作します。このプロセスは Docker.app が接続していなければリソースを消費しないため、無視しても構いません。

.. Where does Docker Desktop store Linux containers and images?
.. _desktop-mac-where-does-docker-desktop-store-linux-containers-and-images:

Docker Desktop は Linux コンテナとイメージをどこに保存しますか？
----------------------------------------------------------------------

.. Docker Desktop stores Linux containers and images in a single, large “disk image” file in the Mac filesystem. This is different from Docker on Linux, which usually stores containers and images in the /var/lib/docker directory.

Docker Desktop は Linux コンテナとイメージを、 Mac ファイルシステム内で、1つの大きな「ディスクイメージ」ファイルに保存します。これは、通常 ``/var/lib/docker`` ディレクトリにコンテナとイメージを保存する Linux 上の Docker とは異なります。

.. Where is the disk image file?
.. _desktop-mac-where-is-the-disk-image-file:

ディスクイメージのファイルはどこですか？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To locate the disk image file, select Preferences from the Docker Dashboard then Advanced from the Resources tab.

ディスクイメージファイルを探すには、 Docker ダッシュボードから **Preferences** を選び、 **Resources** タブから **Advanced** を探します。

.. The Advanced tab displays the location of the disk image. It also displays the maximum size of the disk image and the actual space the disk image is consuming. Note that other tools might display space usage of the file in terms of the maximum file size, and not the actual file size.

**Advanced** タブにはディスクイメージの場所を表示します。また、ディスクイメージの最大容量と、ディスクイメージが使用している実際の容量を表示します。他のツールでは、実際のファイル容量ではなく、最大ファイル容量としてディスク使用量が表示される場合があるので、ご注意ください。

.. What if the file is too big?
.. _desktop-mac-what-if-the-file-is-too-big:

ファイルが大きすぎる場合は、どうしたらいいでしょうか？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. If the disk image file is too big, you can:

ディスクイメージが大きすぎる場合、次のことができます：

..  Move it to a bigger drive
    Delete unnecessary containers and images
    Reduce the maximum allowable size of the file

* より大きなドライブにディスクイメージを移動する
* 不要なコンテナとイメージを削除する
* ファイルに割り当て可能な最大容量を減らす

.. How do I move the file to a bigger drive?
.. _desktop-mac-how-do-i-move-the-file-to-a-bigger-drive:

大きなドライブにファイルを移動する方法は？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To move the disk image file to a different location:

ディスクイメージファイルを別の場所に移動するには、次のように実行します：

..  Select Preferences then Advanced from the Resources tab.
    In the Disk image location section, click Browse and choose a new location for the disk image.
    Click Apply & Restart for the changes to take effect.

1. **Preferences** を選び、 **Resources** タブから **Advanced** を選ぶ
2. **Disk image location** セクション内で、 **Browse** をクリックし、ディスクイメージの新しい場所を選ぶ
3. 変更を反映するには、 **Apply & Restart** をクリック

.. Do not move the file directly in Finder as this can cause Docker Desktop to lose track of the file.

Finder を使ってファイルを直接移動しないでください。移動してしまうと、 Docker Desktop がファイルを追跡できなくなります。

.. How do I delete unnecessary containers and images?
.. _docker-desktop-how-do-i-delete-unnecessary-containers-and-images:

不要なコンテナとイメージをどうやって削除しますか？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Check whether you have any unnecessary containers and images. If your client and daemon API are running version 1.25 or later (use the docker version command on the client to check your client and daemon API versions), you can see the detailed space usage information by running:

不要なコンテナとイメージを持っているかどうかを調べます。クライアントとデーモン API がバージョン 1.25 以上で実行している場合（ ``docker version`` コマンドを使い、クライアントとデーモン API のバージョンを確認できます）、次のように実行して詳細な容量の使用情報を表示できます：

.. code-block:: bash

   $ docker system df -v

.. Alternatively, to list images, run:

または、イメージ一覧を表示するには、次のように実行します：

.. code-block:: bash

   $ docker image ls

.. and then, to list containers, run:

それから、コンテナ一覧を表示するため、次のように実行します：

.. code-block:: bash

   $ docker container ls -a

.. If there are lots of redundant objects, run the command:

不要なオブジェクトがたくさんある場合、次のコマンドを実行します：

.. code-block:: bash

   $ docker system prune

.. This command removes all stopped containers, unused networks, dangling images, and build cache.

このコマンドは、停止中のコンテナ、使われていないネットワーク、宙吊りイメージと構築キャッシュを全て削除します。

.. It might take a few minutes to reclaim space on the host depending on the format of the disk image file:

ホストが依存しているディスクイメージのファイル形式によっては、容量の確保に数分ほど必要な場合があります。

..  If the file is named Docker.raw: space on the host should be reclaimed within a few seconds.
    If the file is named Docker.qcow2: space will be freed by a background process after a few minutes.

* ファイル名が ``Docker.raw`` の場合：ホスト上の空きは数秒以内に確保できる
* ファイル名が ``Docker.qcow2`` の場合：バックグラウンドのプロセスとして容量を確保するため、数分かかる

.. Space is only freed when images are deleted. Space is not freed automatically when files are deleted inside running containers. To trigger a space reclamation at any point, run the command:

イメージが削除された時にのみ、容量が解放されます。実行しているコンテナ内でファイルを削除しても、自動的に空き容量として解放されません。容量確保をいつでも行いたい場合は、次のコマンドを実行します。

.. code-block:: bash

   $ docker run --privileged --pid=host docker/desktop-reclaim-space

.. Note that many tools report the maximum file size, not the actual file size. To query the actual size of the file on the host from a terminal, run:

ツールでは、実際のファイル容量ではなく、最大ファイル容量としてディスク使用量が表示される場合があるので、ご注意ください。ホスト上での実際の容量を確認するには、ターミナルから次のように実行します。

.. code-block:: bash

   $ cd ~/Library/Containers/com.docker.docker/Data/vms/0/data
   $ ls -klsh Docker.raw
   2333548 -rw-r--r--@ 1 username  staff    64G Dec 13 17:42 Docker.raw

.. In this example, the actual size of the disk is 2333548 KB, whereas the maximum size of the disk is 64 GB.

この例では、ディスクの最大容量は ``64`` GB ですが、ディスクの実際の容量は ``2333548``  KB です。

.. How do I reduce the maximum size of the file?
.. _desktop-mac-how-do-i-reduce-the-maximum-size-of-the-file:

ファイルの最大容量を減らすには、どうしたらいいでしょうか？
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To reduce the maximum size of the disk image file:

ディスクイメージファイルの最大容量を減らすには、次のようにします。

..  Select Preferences then Advanced from the Resources tab.
    The Disk image size section contains a slider that allows you to change the maximum size of the disk image. Adjust the slider to set a lower limit.
    Click Apply & Restart.

1. **Preferences** を選び、 **Resources** タブから **Advanced** を選ぶ
2. **Disk image location** セクション内で、 ディスクイメージの最大容量を変更できます。スライダーを下限に調整します。
3. 変更を反映するには、 **Apply & Restart** をクリック

.. When you reduce the maximum size, the current disk image file is deleted, and therefore, all containers and images will be lost.

最大容量を減らす場合は、現在のディスクイメージは削除されます。つまり、全てのコンテナとディレクトリは失われます。

.. How do I add TLS certificates?
.. _desktop-mac-how-do-i-add-tls-certificates:

TLS 証明書をどのようにして追加しますか？
--------------------------------------------------

.. You can add trusted Certificate Authorities (CAs) (used to verify registry server certificates) and client certificates (used to authenticate to registries) to your Docker daemon.

Docker デーモンが、レジストリ・サーバ証明書と **クライアント証明書** の検証用に、信頼できる **認証局(CA; Certificate Authorities)** を追加してレジストリを認証できます。

.. Add custom CA certificates (server side)
.. _desktop-mac-add-custom-ca-certificates-server-side:

カスタム CA 証明書の追加（サーバ側）
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. All trusted CAs (root or intermediate) are supported. Docker Desktop creates a certificate bundle of all user-trusted CAs based on the Mac Keychain, and appends it to Moby trusted certificates. So if an enterprise SSL certificate is trusted by the user on the host, it is trusted by Docker Desktop.

全ての信頼できうる（ルート及び中間）証明局（CA）をサポートしています。Docker Desktop は Mac キーチェーン上にある全ての信頼できうる証明局の情報に基づき、全てのユーザが信頼する CAの証明書バンドルを作成します。また、Moby の信頼できる証明書にも適用します。そのため、エンタープライズ SSL 証明書がホスト上のユーザによって信頼されている場合は、Docker Desktop からも信頼されます。

.. To manually add a custom, self-signed certificate, start by adding the certificate to the macOS keychain, which is picked up by Docker Desktop. Here is an example:

任意の、自己証明した証明書を主導で追加するには、macOS キーチェン上に証明書を追加し、Docker Desktop が扱えるようにします。以下は例です：

.. code-block:: bash

   $ sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain ca.crt

.. Or, if you prefer to add the certificate to your own local keychain only (rather than for all users), run this command instead:

あるいは、（全てのユーザに対してではなく）自身のローカルキーチェーンのみ追加したい場合は、代わりにこちらのコマンドを実行します。

.. code-block:: bash

   $ security add-trusted-cert -d -r trustRoot -k ~/Library/Keychains/login.keychain ca.crt

.. See also, Directory structures for certificates.

また、 :ref:`認証情報のディレクトリ構造 <desktop-mac-directory-structures-for-certificates>` もご覧ください。

..   Note: You need to restart Docker Desktop after making any changes to the keychain or to the ~/.docker/certs.d directory in order for the changes to take effect. For a complete explanation of how to do this, see the blog post Adding Self-signed Registry Certs to Docker & Docker Desktop for Mac.

.. note::

   キーチェーンに対する何らかの変更をするか、 :code:`~/.docker/certs.d` ディレクトリ内の変更を有効にするには、 Docker Desktop の再起動が必要です。この設定方法に関する完全な説明は `Adding Self-signed Registry Certs to Docker & Docker Desktop for Mac <http://container-solutions.com/adding-self-signed-registry-certs-docker-mac/>`_ のブログ投稿をご覧ください。


.. Add client certificates
.. _desktop-mac-add-client-certificates:

クライアント証明書の追加
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You can put your client certificates in ~/.docker/certs.d/<MyRegistry>:<Port>/client.cert and ~/.docker/certs.d/<MyRegistry>:<Port>/client.key.

自分のクライアント証明書を :code:`~/.docker/certs.d/<MyRegistry>:<Port>/client.cert` と :code:`~/.docker/certs.d/<MyRegistry>:<Port>/client.key` に追加できます。

.. When the Docker Desktop application starts, it copies the ~/.docker/certs.d folder on your Mac to the /etc/docker/certs.d directory on Moby (the Docker Desktop xhyve virtual machine).

Docker Desktop ・アプリケーションの開始時に、 Mac システム上の :code:`~/.docker/certs.d` フォルダを Moby 上（Docker Desktop が稼働する :code:`xhyve` 上の仮想マシン）の `/etc/docker/certs.d` ディレクトリにコピーします。

..        You need to restart Docker Desktop after making any changes to the keychain or to the ~/.docker/certs.d directory in order for the changes to take effect.
..        The registry cannot be listed as an insecure registry (see Docker Engine. Docker Desktop ignores certificates listed under insecure registries, and does not send client certificates. Commands like docker run that attempt to pull from the registry produce error messages on the command line, as well as on the registry.

.. hint::

   * キーチェーンに対する何らかの変更をするか、 :code:`~/.docker/certs.d` ディレクトリ内の変更を有効にするには、 Docker Desktop の再起動が必要です。
   * レジストリは *insecure* （安全ではない）レジストリとして表示されません（ :ref:`mac-docker-engine` をご覧ください ）。Docker Desktop は安全ではないレジストリにある証明書を無視します。そして、クライアント証明書も送信しません。 :code:`docker run` のようなレジストリから取得するコマンドは、コマンドライン上でもレジストリでもエラーになるメッセージが出ます。

.. Directory structures for certificates
.. _desktop-mac-directory-structures-for-certificates:

認証情報のディレクトリ構造
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. If you have this directory structure, you do not need to manually add the CA certificate to your Mac OS system login:

次のディレクトリ構造の場合、Mac OS システムログインのため、CA 証明書を手動で追加する必要はありません。

.. code-block:: bash

   /Users/<user>/.docker/certs.d/
   └── <MyRegistry>:<Port>
      ├── ca.crt
      ├── client.cert
      └── client.key

.. The following further illustrates and explains a configuration with custom certificates:

以下は、カスタム証明書を設定例と説明を追加したものです：

.. code-block:: bash

   /etc/docker/certs.d/        <-- Certificate directory
   └── localhost:5000          <-- Hostname:port
      ├── client.cert          <-- Client certificate
      ├── client.key           <-- Client key
      └── ca.crt               <-- Certificate authority that signed
                                   the registry certificate

.. You can also have this directory structure, as long as the CA certificate is also in your keychain.

あるいは、CA 証明書が自分のキーチェンにあれば、次のようなディレクトリ構造にもできます。

.. code-block:: bash

   /Users/<user>/.docker/certs.d/
   └── <MyRegistry>:<Port>
       ├── client.cert
       └── client.key

.. To learn more about how to install a CA root certificate for the registry and how to set the client TLS certificate for verification, see Verify repository client with certificates in the Docker Engine topics.

認証用にクライアント TLS 証明書を設定する方法を学ぶには、Docker エンジンの記事 :doc:`証明書でリポジトリ・クライアントを確認する </engine/security/certificates>`_ を御覧ください。

.. How do I install shell completion?
.. _desktop-mac-how-do-i-install-shell-completion:

どうやってシェル補完をインストールしますか？
--------------------------------------------------

.. Bash has built-in support for completion To activate completion for Docker commands, these files need to be copied or symlinked to your bash_completion.d/ directory. For example, if you installed bash via Homebrew:


Bash
^^^^^^^^^^

Bash は `補完を内部でサポートしています <https://www.debian-administration.org/article/316/An_introduction_to_bash_completion_part_1>`_ 。Docker コマンドで補完できるようにするには、各ファイルを自分の ``bash_completion.d/`` ディレクトリにコピーするかシンボリックリンクを作成します。たとえば、 `Homebrew <https://brew.sh/>`_ を経由して bash をインストールした場合は：

.. code-block:: bash

   etc=/Applications/Docker.app/Contents/Resources/etc
   ln -s $etc/docker.bash-completion $(brew --prefix)/etc/bash_completion.d/docker
   ln -s $etc/docker-compose.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-compose

.. Add the following to your ~/.bash_profile:

以下を自分の :code:`~/.bash_profile` に追加します：

.. code-block:: bash

   [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

.. OR

あるいは

.. code-block:: bash

   if [ -f $(brew --prefix)/etc/bash_completion ]; then
   . $(brew --prefix)/etc/bash_completion
   fi


Zsh
^^^^^^^^^^

.. In Zsh, the completion system takes care of things. To activate completion for Docker commands, these files need to be copied or symlinked to your Zsh site-functions/ directory. For example, if you installed Zsh via Homebrew:

Zsh では、 `補完システム <http://zsh.sourceforge.net/Doc/Release/Completion-System.html>`_ の管理が必要です。Docker コマンドに対する補完を有効化するには、自分の Zsh :code:`site-functions/` ディレクトリに各ファイルをコピーするか symlink する必要があります。以下は `Homebrew <http://brew.sh/>`_  を経由して Zsh をインストールします：

.. code-block:: bash

   etc=/Applications/Docker.app/Contents/Resources/etc
   ln -s $etc/docker.zsh-completion /usr/local/share/zsh/site-functions/_docker
   ln -s $etc/docker-compose.zsh-completion /usr/local/share/zsh/site-functions/_docker-compose


Fish-Shell
^^^^^^^^^^

.. Fish-shell also supports tab completion completion system. To activate completion for Docker commands, these files need to be copied or symlinked to your Fish-shell completions/ directory.

Fish-shell もまた、タブ補完による `補完システム <https://fishshell.com/docs/current/#tab-completion>`_ をサポートしています。Docker コマンドに対する補完を有効化するには、各ファイルを自分の Fish-shell の :code:`completions` ディレクトリにコピーするか symlink する必要があります。

.. Create the completions directory:

:code:`completions`  ディレクトリを作成します：

.. code-block:: bash

   mkdir -p ~/.config/fish/completions

.. Now add fish completions from docker.

次に docker から fish completions を追加します。

.. code-block:: bash

   ln -shi /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion ~/.config/fish/completions/docker.fish
   ln -shi /Applications/Docker.app/Contents/Resources/etc/docker-compose.fish-completion ~/.config/fish/completions/docker-compose.fish

.. seealso:: 

   Frequently asked questions for Mac
      https://docs.docker.com/desktop/faqs/macfaqs/
