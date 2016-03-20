.. -*- coding: utf-8 -*-
.. https://docs.docker.com/machine/drivers/virtualbox/
.. doc version: 1.9
.. check date: 2016/01/25
.. -----------------------------------------------------------------------------

.. Oracle VirtualBox

.. _driver-oracle-virtualbox:

=======================================
Oracle VirtualBox
=======================================

.. Create machines locally using VirtualBox. This driver requires VirtualBox 5+ to be installed on your host. Using VirtualBox 4+ should work but will give you a warning. Older versions will refuse to work.

`VirtualBox <https://www.virtualbox.org/>`_ を使い、ローカルにマシンを作成します。このドライバを使うには、ホスト上に VirtualBox 5 以上のインストールが必要です。VirtualBox 4 の場合は動作するかもしれませんが、警告が出ます。それよりも古いバージョンは実行できません。

.. code-block:: bash

   $ docker-machine create --driver=virtualbox vbox-test

.. You can create an entirely new machine or you can convert a Boot2Docker VM into a machine by importing the VM. To convert a Boot2Docker VM, you’d use the following command:

完全に新しいマシンを作成するか、Boot2Docker 仮想マシンにあるデータを変換して仮想マシンに取り込めます。Boot2Docker 仮想マシンを変換するには、以下のコマンドを実行します。

.. code-block:: bash

   $ docker-machine create -d virtualbox --virtualbox-import-boot2docker-vm boot2docker-vm b2d

.. Options:

オプション：

..    --virtualbox-memory: Size of memory for the host in MB.
    --virtualbox-cpu-count: Number of CPUs to use to create the VM. Defaults to single CPU.
    --virtualbox-disk-size: Size of disk for the host in MB.
    --virtualbox-host-dns-resolver: Use the host DNS resolver. (Boolean value, defaults to false)
    --virtualbox-boot2docker-url: The URL of the boot2docker image. Defaults to the latest available version.
    --virtualbox-import-boot2docker-vm: The name of a Boot2Docker VM to import.
    --virtualbox-hostonly-cidr: The CIDR of the host only adapter.
    --virtualbox-hostonly-nictype: Host Only Network Adapter Type. Possible values are are ‘82540EM’ (Intel PRO/1000), ‘Am79C973’ (PCnet-FAST III) and ‘virtio-net’ Paravirtualized network adapter.
    --virtualbox-hostonly-nicpromisc: Host Only Network Adapter Promiscuous Mode. Possible options are deny , allow-vms, allow-all
    --virtualbox-no-share: Disable the mount of your home directory
    --virtualbox-dns-proxy: Proxy all DNS requests to the host (Boolean value, default to false)

* ``--virtualbox-memory`` : ホストのメモリ容量を MB 単位で指定。
* ``--virtualbox-cpu-count`` : 作成する仮想マシンが使う CPU 数。デフォルトは CPU １つ。
* ``--virtualbox-disk-size`` : ホストのディスク容量を MB 単位で指定。
* ``--virtualbox-host-dns-resolver`` : ホスト DNS レゾルバの使用（ Boolean 値で、デフォルトは false）。
* ``--virtualbox-boot2docker-url`` : boot2docker イメージの URL を指定。デフォルトは利用可能な最新バージョン。
* ``--virtualbox-import-boot2docker-vm`` : 取り込む Boot2Docker 仮想マシンの名前。
* ``--virtualbox-hostonly-cidr`` :  ホストオンリー・アダプタの CIDR 。
* ``--virtualbox-hostonly-nictype`` :  ホストオンリー・ネットワーク・アダプタのタイプを指定。値は ``82540EM`` (Intel PRO/1000)、 ``Am79C973`` (PCnet-FAST III) 、``virtio-net`` 準仮想化ネットワーク・アダプタのいずれか。
* ``--virtualbox-hostonly-nicpromisc`` : ホスト・オンリー・ネットワーク・アダプタのプロミスキャス・モードを指定。オプションは deny、allow-vms、allow-all のいずれか。
* ``--virtualbox-no-share`` : ホーム・ディレクトリのマウントを無効化。
* ``--virtualbox-dns-proxy`` : 全ての DNS リクエストをホスト側にプロキシする（　Boolean 値で、デフォルトは false）。

.. The --virtualbox-boot2docker-url flag takes a few different forms. By default, if no value is specified for this flag, Machine will check locally for a boot2docker ISO. If one is found, that will be used as the ISO for the created machine. If one is not found, the latest ISO release available on boot2docker/boot2docker will be downloaded and stored locally for future use. Note that this means you must run docker-machine upgrade deliberately on a machine if you wish to update the “cached” boot2docker ISO.

``--virtualbox-boot2docker-url`` フラグには、いくつかの異なった使い方があります。デフォルトでは、フラグに値を何も指定しなければ、Docker Machine はローカルの boot2docker ISO を探します。もしローカル上に見つかれば、マシン作成用の ISO として用いられます。もし見つからない場合は、 `boot2docker/boot2docker <https://github.com/boot2docker/boot2docker>`_ にある最新の ISO イメージをダウンロードし、ローカルに保存してから使います。つまり、ローカルに「キャッシュされた」boot2docker ISO を更新したい場合は、 ``docker-machine upgrade`` を実行しなくてはいけません。

.. This is the default behavior (when --virtualbox-boot2docker-url=""), but the option also supports specifying ISOs by the http:// and file:// protocols. file:// will look at the path specified locally to locate the ISO: for instance, you could specify --virtualbox-boot2docker-url file://$HOME/Downloads/rc.iso to test out a release candidate ISO that you have downloaded already. You could also just get an ISO straight from the Internet using the http:// form.

これはデフォルトの挙動（ ``--virtualbox-boot2docker-url=""`` を指定 ）ですが、オプションで ISO を ``http://`` や ``file://`` プロトコルで指定することもサポートされています。 ``file://`` はローカルに置かれている ISO イメージのパスを探します。例えば、 ``--virtualbox-boot2docker-url file://$HOME/Downloads/rc.iso`` を指定すると、リリース候補のダウンロード済み ISO を確認します。あるいは、 ``http://`` 形式を使い、インターネットの ISO を直接指定できます。

.. To customize the host only adapter, you can use the --virtualbox-hostonly-cidr flag. This will specify the host IP and Machine will calculate the VirtualBox DHCP server address (a random IP on the subnet between .1 and .25) so it does not clash with the specified host IP. Machine will also specify the DHCP lower bound to .100 and the upper bound to .254. For example, a specified CIDR of 192.168.24.1/24 would have a DHCP server between 192.168.24.2-25, a lower bound of 192.168.24.100 and upper bound of 192.168.24.254.

ホスト・オンリー・アダプタをカスタマイズするには、 ``--virtualbox-hostonly-cidr`` フラグを使えます。ここでホスト IP を指定すると、Machine は VirtualBox DHCP サーバ・アドレスを計算（ ``.1`` ～ ``.25`` までのサブネット上の、ランダムな IP ）するので、指定したホスト IP と衝突しないようにします。また、Machine は自動的に最小 ``.100`` ～最大 ``.254`` までの間で DHCP を指定します。たとえば、CIDR ``192.168.24.1/24`` を指定すると、DHCP サーバは ``192.168.24.2-25`` になり、IP アドレスの範囲は最小 ``192.168.24.100`` から最大 ``192.168.24.254`` となります。

.. Environment variables and default values:

利用可能な環境変数とデフォルト値は以下の通りです。

.. list-table::
   :header-rows: 1
   
   * - コマンドライン・オプション
     - 環境変数
     - デフォルト値
   * - ``--virtualbox-memory``
     - ``VIRTUALBOX_MEMORY_SIZE``
     - ``1024``
   * - ``--virtualbox-cpu-count``
     - ``VIRTUALBOX_CPU_COUNT``
     - ``1``
   * - ``--virtualbox-disk-size``
     - ``VIRTUALBOX_DISK_SIZE``
     - ``20000``
   * - ``--virtualbox-host-dns-resolver``
     - ``VIRTUALBOX_HOST_DNS_RESOLVER``
     - ``false``
   * - ``--virtualbox-boot2docker-url``
     - ``VIRTUALBOX_BOOT2DOCKER_URL``
     - ``最新の boot2docker url``
   * - ``--virtualbox-import-boot2docker-vm``
     - ``VIRTUALBOX_BOOT2DOCKER_IMPORT_VM``
     - ``boot2docker-vm``
   * - ``--virtualbox-hostonly-cidr``
     - ``VIRTUALBOX_HOSTONLY_CIDR``
     - ``192.168.99.1/24``
   * - ``--virtualbox-hostonly-nictype``
     - ``VIRTUALBOX_HOSTONLY_NIC_TYPE``
     - ``82540EM``
   * - ``--virtualbox-hostonly-nicpromisc``
     - ``VIRTUALBOX_HOSTONLY_NIC_PROMISC``
     - ``deny``
   * - ``--virtualbox-no-share``
     - ``VIRTUALBOX_NO_SHARE``
     - ``false``

.. Known Issues

既知の問題
==========

.. Vboxfs suffers from a longstanding bug causing sendfile(2) to serve cached file contents.

Vboxfs は `longstanding bug <https://www.virtualbox.org/ticket/9069>`_ により、キャッシュされたファイル内容を提供するため `sendfile(2) <http://linux.die.net/man/2/sendfile>`_ を引き起こします。

.. This will often cause problems when using a web server such as nginx to serve static files from a shared volume. For development environments, a good workaround is to disable sendfile in your server configuration.

これにより、nginx のようなウェブ・サーバが共有ボリュームから静的ファイルを読み込むとき、問題を引き起こしがちです。開発環境では、サーバの設定で sendfile を無効化するのが良いでしょう。
