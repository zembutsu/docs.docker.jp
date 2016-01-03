.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/installation/rackspace/
.. doc version: 1.9
.. check date: 2015/12/18
.. -----------------------------------------------------------------------------

.. Rackspace Cloud

==============================
Rackspace Cloud
==============================

.. Installing Docker on Ubuntu provided by Rackspace is pretty straightforward, and you should mostly be able to follow the Ubuntu installation guide.

Rackspace が提供する Ubuntu に Docker をインストールするのは、かなり単純です。ほとんどの場合、:doc:`Ubuntu </engine/installation/ubuntulinux>` インストール・ガイドの後に読むべきでしょう。

.. However, there is one caveat:

**ですが、警告が１つあります。**

.. If you are using any Linux not already shipping with the 3.8 kernel you will need to install it. And this is a little more difficult on Rackspace.

これまで 3.8 カーネルの Linux 使っていなければ、インストールが必要になります。Rackspace 上では少々難しいものです。

.. Rackspace boots their servers using grub’s menu.lst and does not like non virtual packages (e.g., Xen compatible) kernels there, although they do work. This results in update-grub not having the expected result, and you will need to set the kernel manually.

Rackspace はサーバを grub の ``menu.lst`` からブートします。しかし ``virtual`` のような kernel パッケージではないため（例：Xen 互換）、別の作業を行います。``update-grup`` は期待通りの動作をしないため、カーネルを手動で設定する必要があります。

.. Do not attempt this on a production machine!

**プロダクション用のマシンで作業しないでください！**

.. code-block:: bash

   # apt を更新
   $ apt-get update
   
   # 新しいカーネルをインストール
   $ apt-get install linux-generic-lts-raring

.. Great, now you have the kernel installed in /boot/, next you need to make it boot next time.

これで ``/boot/`` にカーネルがインストールされました。それから、次回ブート時に読み込むようにします。

.. code-block:: bash

   # 正確な名前を把握
   $ find /boot/ -name '*3.8*'
   
   # ここに何らかの結果が表示されます

.. Now you need to manually edit /boot/grub/menu.lst, you will find a section at the bottom with the existing options. Copy the top one and substitute the new kernel into that. Make sure the new kernel is on top, and double check the kernel and initrd lines point to the right files.

次は ``/boot/grub/menu.lst`` を手動で編集すると、既存のオプションの下にセクションが追加されているのが分かります。新しいカーネルの情報を上のほうにコピーして置き換えます。新しいカーネルが上にきているのを確認し、kernel と initrd が正しいファイルを指し示しているかダブルチェックします。

.. Take special care to double check the kernel and initrd entries.

特に kernel と initrd のエントリが正しいかどうか、気をつけてダブルチェックします。

.. code-block:: bash

   # /boot/grub/menu.lst を編集します。
   $ vi /boot/grub/menu.lst

.. It will probably look something like this:

ファイルの内容は、おおよそ次の通りです。

.. code-block:: bash

   ## ## End Default Options ##
   
   title              Ubuntu 12.04.2 LTS, kernel 3.8.x generic
   root               (hd0)
   kernel             /boot/vmlinuz-3.8.0-19-generic root=/dev/xvda1 ro quiet splash console=hvc0
   initrd             /boot/initrd.img-3.8.0-19-generic
   
   title              Ubuntu 12.04.2 LTS, kernel 3.2.0-38-virtual
   root               (hd0)
   kernel             /boot/vmlinuz-3.2.0-38-virtual root=/dev/xvda1 ro quiet splash console=hvc0
   initrd             /boot/initrd.img-3.2.0-38-virtual
   
   title              Ubuntu 12.04.2 LTS, kernel 3.2.0-38-virtual (recovery mode)
   root               (hd0)
   kernel             /boot/vmlinuz-3.2.0-38-virtual root=/dev/xvda1 ro quiet splash  single
   initrd             /boot/initrd.img-3.2.0-38-virtual

.. Reboot the server (either via command line or console)

サーバを再起動します（コマンドラインかコンソールを使います）。

.. code-block:: bash

   # reboot

.. Verify the kernel was updated

カーネルのアップデートを確認します。

.. code-block:: bash

   $ uname -a
   # Linux docker-12-04 3.8.0-19-generic #30~precise1-Ubuntu SMP Wed May 1 22:26:36 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
   
   # 大丈夫です！ 3.8 ですね。

.. Now you can finish with the Ubuntu instructions.

終わったら :doc:`Ubuntu </engine/installation/ubuntulinux>` の手順に進みます。
