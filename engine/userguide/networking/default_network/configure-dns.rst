.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/userguide/networking/default_network/configure-dns/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/userguide/networking/default_network/configure-dns.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/userguide/networking/default_network/configure-dns.md
.. check date: 2016/06/14
.. Commits on Feb 15, 2016 7da5784b10a9f085af98984e6e69e733e55ddbf5
.. ---------------------------------------------------------------------------

.. Configure container DNS

.. _configure-container-dns:

========================================
コンテナの DNS を設定
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. The information in this section explains configuring container DNS within the Docker default bridge. This is a bridge network named bridge created automatically when you install Docker.

このセクションでは Docker のデフォルト・ブリッジ内でコンテナの DNS を設定する方法を紹介します。ここでの ``bridge`` という名称の ``bridge`` ネットワークは、Docker インストール時に自動的に作成されるものです。

.. Note: The Docker networks feature allows you to create user-defined networks in addition to the default bridge network.

.. Note: The Docker networks feature allows you to create user-defined networks in addition to the default bridge network. Please refer to the Docker Embedded DNS section for more information on DNS configurations in user-defined networks.

.. note::

   :doc:`Docker ネットワーク機能 </engine/userguide/networking/dockernetworks>` を使えば、デフォルト・ブリッジ・ネットワークに加え、自分でユーザ定義ネットワークも作成できます。ユーザ定義ネットワーク上で DNS 設定を行う詳細な情報は、 :doc:`Docker 内蔵 DNS </engine/userguide/networking/configure-dns>` をご覧ください。

.. How can Docker supply each container with a hostname and DNS configuration, without having to build a custom image with the hostname written inside? Its trick is to overlay three crucial /etc files inside the container with virtual files where it can write fresh information. You can see this by running mount inside a container:

Docker が各コンテナにホスト名や DNS 設定を渡すため、カスタム・イメージを使わずコンテナ内にホスト名を書くには、どうしたら良いでしょうか。コンテナ内では、 ``/etc`` 以下にある３つの重要なファイルを、仮想ファイルを使って新しい情報に上書きする手法を使います。これは実行中のコンテナ内で ``mount`` コマンドを実行すると分かります。

.. code-block:: bash

   $$ mount
   ...
   /dev/disk/by-uuid/1fec...ebdf on /etc/hostname type ext4 ...
   /dev/disk/by-uuid/1fec...ebdf on /etc/hosts type ext4 ...
   /dev/disk/by-uuid/1fec...ebdf on /etc/resolv.conf type ext4 ...
   ...

.. This arrangement allows Docker to do clever things like keep resolv.conf up to date across all containers when the host machine receives new configuration over DHCP later. The exact details of how Docker maintains these files inside the container can change from one Docker version to the next, so you should leave the files themselves alone and use the following Docker options instead.

この処理により、Docker は ``resolv.conf`` を巧妙に最新版を維持します。この情報はホストマシンが新しい設定を DHCP 経由で受信すると、全てのコンテナに対して反映します。Docker がコンテナの中でこれらのファイルをどう管理するのか正確な情報を持つため、Docker のバージョンを更新しても変わりません。そのため、ファイルの内容に対して変更を加えるのではなく、以下のオプションを使います。

.. Four different options affect container domain name services.

コンテナのドメイン名サービスに影響を与える４つのオプションがあります。

..   -h HOSTNAME or --hostname=HOSTNAME
.. Sets the hostname by which the container knows itself. This is written into /etc/hostname, into /etc/hosts as the name of the container's host-facing IP address, and is the name that /bin/bash inside the container will display inside its prompt. But the hostname is not easy to see from outside the container. It will not appear in docker ps nor in the /etc/hosts file of any other container.

* ``-h ホスト名`` か ``--hostname=ホスト名`` ：コンテナ自身が知るホスト名を設定します。これは ``/etc/hostname`` に書かれます。 ``/etc/hosts`` にはコンテナ内のホスト IP アドレスが書かれ、その名前がコンテナ内の ``/bin/bash`` プロンプトで表示されます。しかし、ホスト名をコンテナの外から確認するのは大変です。 ``docker ps`` でも見えませんし、他のコンテナの ``/etc/hosts`` からも見えません。

.. --link=CONTAINER_NAME or ID:ALIAS
.. Using this option as you run a container gives the new container's /etc/hosts an extra entry named ALIAS that points to the IP address of the container identified by CONTAINER_NAME_or_ID. This lets processes inside the new container connect to the hostname ALIAS without having to know its IP. The --link= option is discussed in more detail below. Because Docker may assign a different IP address to the linked containers on restart, Docker updates the ALIAS entry in the /etc/hosts file of the recipient containers.

* ``--link=コンテナ名`` か ``ID:エイリアス`` ： 実行しているコンテナに対して、新しいコンテナの ``/etc/hosts`` に ``エイリアス`` という別名のエントリを追加します。コンテナを識別する IP アドレスが指し示すのは、 ``コンテナ名か ID``  です。これにより、新しいコンテナ内のプロセスは、IP アドレスを知らなくても、ホスト名の ``エイリアス`` を使って接続できます。 ``--link`` オプションの詳細については、以降で扱います。Docker は異なる IP アドレスが割り当てられる可能性があり、リンクされたコンテナを再起動したら、Docker は対象となるコンテナの ``/etc/hosts`` の ``エイリアス`` エントリを更新します。

.. --dns=IP_ADDRESS...
.. Sets the IP addresses added as server lines to the container's /etc/resolv.conf file. Processes in the container, when confronted with a hostname not in /etc/hosts, will connect to these IP addresses on port 53 looking for name resolution services.

* ``--dns=IPアドレス...`` ：コンテナの ``/etc/resolv.conf``  ファイルの ``server`` 行に IP アドレスを追加します。コンテナ内のプロセスは、 ``/etc/host`` を突き合わせて一致するホスト名が存在しなければ、ここで指定した IP アドレスのポート 53 を名前解決用に使います。

.. --dns-search=DOMAIN...
.. Sets the domain names that are searched when a bare unqualified hostname is used inside of the container, by writing search lines into the container's /etc/resolv.conf. When a container process attempts to access host and the search domain example.com is set, for instance, the DNS logic will not only look up host but also host.example.com.
.. Use --dns-search=. if you don't wish to set the search domain.

* ``--dns-search=ドメイン名...`` ： コンテナ内でホスト名だけが単体で用いられた時、ここで指定したドメイン名に対する名前解決を行います。これはコンテナ内の ``/etc/resolv.conf`` の ``search`` 行で書かれているものです。コンテナのプロセスがホスト名 ``host`` に接続しようとする時、 search ドメインに ``example.com`` が指定されていれば、DNS 機構は ``host`` だけでなく、 ``host.example.com``  に対しても名前解決を行います。検索用ドメインを指定したくない場合は、 ``--dns-search=.``  を使います。

.. --dns-opt=OPTION...
.. Sets the options used by DNS resolvers by writing an options line into the container's /etc/resolv.conf.
.. See documentation for resolv.conf for a list of valid options

* ``--dns-opt=オプション`` ：コンテナ内の ``/etc/resolv.conf`` の ``options`` 行で DNS 解決のオプションを指定します。利用可能なオプションについては、 ``resolv.conf`` のオプションをご覧ください。

.. Regarding DNS settings, in the absence of the --dns=IP_ADDRESS..., --dns-search=DOMAIN..., or --dns-opt=OPTION... options, Docker makes each container’s /etc/resolv.conf look like the /etc/resolv.conf of the host machine (where the docker daemon runs). When creating the container’s /etc/resolv.conf, the daemon filters out all localhost IP address nameserver entries from the host’s original file.

DNS 設定に関して、オプション ``--dns=IPアドレス...`` 、 ``--dns-search=ドメイン名...`` 、 ``--dns-opt=オプション...`` の指定がなければ、Docker は各コンテナの ``/etc/resolv.conf`` をホストマシン上（ ``docker`` デーモンが動作中 ）の ``/etc/resolv.conf`` のように作成します。コンテナの ``/etc/resolv.conf`` の作成時、デーモンはホスト側のオリジナル・ファイルに書かれている ``nameserver``  のエントリを、フィルタリングして書き出します。

.. Filtering is necessary because all localhost addresses on the host are unreachable from the container’s network. After this filtering, if there are no more nameserver entries left in the container’s /etc/resolv.conf file, the daemon adds public Google DNS nameservers (8.8.8.8 and 8.8.4.4) to the container’s DNS configuration. If IPv6 is enabled on the daemon, the public IPv6 Google DNS nameservers will also be added (2001:4860:4860::8888 and 2001:4860:4860::8844).

フィルタリングが必要になるのは、ホスト上の全てのローカルアドレスがコンテナのネットワークから到達できない場合があるからです。フィルタリングにより、コンテナ内の ``/etc/resolv.conf`` ファイルに ``nameserver`` のエントリが残っていなければ、デーモンはパブリック Google DNS ネームサーバ（8.8.8.8 と 8.8.4.4）をコンテナの DNS 設定に用います。もしデーモン上で IPv6 を有効にしているのであれば、パブリック IPv6 Google DNS ネームサーバを割り当てます（2001:4860:4860::8888 と 2001:4860:4860::8844）。

..    Note: If you need access to a host’s localhost resolver, you must modify your DNS service on the host to listen on a non-localhost address that is reachable from within the container.

.. note::

   ホスト側のローカルなリゾルバにアクセスする必要があるなら、コンテナ内から到達可能になるように、ホスト上にある DNS サービスがローカルホスト以外をリッスンするよう設定が必要です。

.. You might wonder what happens when the host machine’s /etc/resolv.conf file changes. The docker daemon has a file change notifier active which will watch for changes to the host DNS configuration.

ホストマシン側の ``/etc/resolv.conf`` を変更すると何が起こるか気になるでしょう。 ``docker`` デーモンはホスト側の DNS 設定に対する変更を監視しているので、ファイルの変更を通知します。

..    Note: The file change notifier relies on the Linux kernel’s inotify feature. Because this feature is currently incompatible with the overlay filesystem driver, a Docker daemon using “overlay” will not be able to take advantage of the /etc/resolv.conf auto-update feature.

.. note::

   ファイル変更の通知は Linux カーネルの inotify 機能に依存しています。現時点では overlay ファイルシステム・ドライバとは互換性がありません。そのため Docker デーモンが「overlay」を使う場合は、 ``/etc/resolv.conf`` の自動更新機能を使えません。

.. When the host file changes, all stopped containers which have a matching resolv.conf to the host will be updated immediately to this newest host configuration. Containers which are running when the host configuration changes will need to stop and start to pick up the host changes due to lack of a facility to ensure atomic writes of the resolv.conf file while the container is running. If the container’s resolv.conf has been edited since it was started with the default configuration, no replacement will be attempted as it would overwrite the changes performed by the container. If the options (--dns, --dns-search, or --dns-opt) have been used to modify the default host configuration, then the replacement with an updated host’s /etc/resolv.conf will not happen as well.

host ファイルの変更時、 ``resolv.conf`` を持っている全てのコンテナ上で、 host ファイルは直ちに最新の host 設定に更新されます。host 設定変更時にコンテナが実行中であれば、コンテナを停止・再起動して反映する必要があります。コンテナ実行中は、 ``resolv.conf``  の内容はそのまま維持されるためです。もし、コンテナがデフォルトの設定で開始される前に ``resolv.conf`` を編集している場合は、ファイルをコンテナ内で編集した内容はそのままで、置き換えられることはありません。もしオプション（ ``--dns`` 、 ``--dns-search`` 、 ``--dns-port`` ）がデフォルトのホスト設定に用いられている場合は、同様にホスト側の ``/etc/resolv.conf`` を更新しません。

..    Note: For containers which were created prior to the implementation of the /etc/resolv.conf update feature in Docker 1.5.0: those containers will not receive updates when the host resolv.conf file changes. Only containers created with Docker 1.5.0 and above will utilize this auto-update feature.

.. note::

   ``/etc/resolv.conf`` の更新機能が実装されているのは、Docker 1.5.0 以降に作られたコンテナです。つまり、以前のコンテナはホスト側の ``resolv.conf``  の変更が発生しても検出できません。Docker 1.5 以降に作成されたコンテナのみ、上記の自動更新機能が使えます。

.. seealso:: 

   Configure container DNS
      https://docs.docker.com/engine/userguide/networking/default_network/configure-dns/
