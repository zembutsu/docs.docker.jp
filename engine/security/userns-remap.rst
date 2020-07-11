.. -*- coding: utf-8 -*-
.. URL:    https://docs.docker.com/engine/security/userns-remap/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/security/userns-remap.md
   doc version: 19.03
.. check date: 2020/07/05
.. Commits on Jun 4, 2020 12b8e799c7b0e57f79d3f5d8e95a8e6e86fcc3f7
.. -------------------------------------------------------------------

.. Isolate containers with a user namespace

.. _isolate-containers-with-a-user-namespace:

========================================
ユーザ名前空間でコンテナを分離
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3

.. Linux namespaces provide isolation for running processes, limiting their access to system resources without the running process being aware of the limitations. For more information on Linux namespaces, see Linux namespaces.

Linux 名前空間（namespace）は実行中のプロセスに対する隔離（isolate）を提供し、システムリソースに対するアクセスを制限しますが、実行中のプロセスは制限されていることが分かりません。Linux 名前空間に関する情報は、 `Linux namespaces <https://www.linux.com/news/understanding-and-securing-linux-namespaces>`_ をご覧ください。

.. The best way to prevent privilege-escalation attacks from within a container is
   to configure your container's applications to run as unprivileged users. For
   containers whose processes must run as the `root` user within the container, you
   can re-map this user to a less-privileged user on the Docker host. The mapped
   user is assigned a range of UIDs which function within the namespace as normal
   UIDs from 0 to 65536, but have no privileges on the host machine itself.

コンテナ内部からの権限昇格による攻撃を防ぐ最大の方法は、コンテナのアプリケーションを非特権ユーザで実行することです。
コンテナ内において、プロセスを ``root`` ユーザで実行しなければならない場合は、この ``root`` ユーザを、Docker ホスト上のより権限の少ないユーザに再割り当て（re-map）します。
名前空間内では通常 0 から 65536 という範囲の UID が正しく機能しますが、割り当て対象のユーザには、この範囲内で UID を定めます。
ただしこの UID はホストマシン上では何の権限もないものです。

.. ## About remapping and subordinate user and group IDs

.. _about-remapping-and-subordinate-user-and-group-ids:

ユーザ ID、グループ ID の再割り当てとサブ ID
============================================================

.. The remapping itself is handled by two files: /etc/subuid and /etc/subgid. Each file works the same, but one is concerned with the user ID range, and the other with the group ID range. Consider the following entry in /etc/subuid:

再割り当て（remapping）そのものは2つのファイル、 ``/etc/subuid`` と ``/etc/subgid`` で扱います。各ファイルは同じように機能しますが、一方はユーザ ID の範囲を扱い、もう一方はグループ ID の範囲を扱います。以下のような ``/etc/subuid`` のエントリを考えましょう。

::

   testuser:231072:65536

.. This means that `testuser` is assigned a subordinate user ID range of `231072`
   and the next 65536 integers in sequence. UID `231072` is mapped within the
   namespace (within the container, in this case) as UID `0` (`root`). UID `231073`
   is mapped as UID `1`, and so forth. If a process attempts to escalate privilege
   outside of the namespace, the process is running as an unprivileged high-number
   UID on the host, which does not even map to a real user. This means the process
   has no privileges on the host system at all.

上の意味は ``testuser`` のサブ ID を ``231072`` から 65536 個分の連続した整数範囲で割り当てるものです。
UID ``231072`` は、名前空間内（ここではコンテナ内）においては UID ``0`` （``root``）に割り当てられています。
同じく UID ``231073`` は UID ``1`` へ割り当てられています。
以下同様です。
名前空間の外部から権限昇格を試みるようなプロセスがあったとします。
ホスト上では権限を持たない大きな数値の UID によってプロセスが起動しており、その UID は現実のユーザには割り当てられていません。
つまりそのプロセスは、ホストシステム上での権限をまったく持たないということです。


.. > Multiple ranges
   >
   > It is possible to assign multiple subordinate ranges for a given user or group
   > by adding multiple non-overlapping mappings for the same user or group in the
   > `/etc/subuid` or `/etc/subgid` file. In this case, Docker uses only the first
   > five mappings, in accordance with the kernel's limitation of only five entries
   > in `/proc/self/uid_map` and `/proc/self/gid_map`.

.. note::

   **複数の範囲指定**

   1 つのユーザまたはグループに対して、サブ ID の範囲を複数割り当てることができます。
   これを行うには ``/etc/subuid`` または ``/etc/subgid`` において 1 つのユーザあるいはグループに対して、互いに重複しない範囲指定を複数行います。
   これを行った場合、Docker は複数の範囲指定の中から、はじめの 5 つ分のみを利用します。
   カーネルが ``/proc/self/uid_map`` や ``/proc/self/gid_map`` において、5 つ分のエントリーしか取り扱わないという制約に従ったものです。

.. When you configure Docker to use the `userns-remap` feature, you can optionally
   specify an existing user and/or group, or you can specify `default`. If you
   specify `default`, a user and group `dockremap` is created and used for this
   purpose.

Docker において ``userns-remap`` 機能を利用する際には、必要に応じて既存のユーザやグループを指定することができます。
あるいは ``default`` を指定することもできます。
``default`` を指定した場合、``dockremap`` というユーザおよびグループが生成され、この機能のために利用されます。

..    Warning: Some distributions, such as RHEL and CentOS 7.3, do not automatically add the new group to the /etc/subuid and /etc/subgid files. You are responsible for editing these files and assigning non-overlapping ranges, in this case. This step is covered in Prerequisites.

.. warning::

   RHEL と CentOS 7.3 のような複数のディストリビューションでは、新しいグループを ``/etc/subuid`` と ``/etc/subgid`` ファイルに自動的に追加しません。今回の例では、重複しない範囲を割り当てるよう、あなた自身が責任を持ってファイルを編集する必要があります。この手順は :ref:`userns-remap-prerequisites` で扱います。

.. It is very important that the ranges do not overlap, so that a process cannot gain
   access in a different namespace. On most Linux distributions, system utilities
   manage the ranges for you when you add or remove users.

範囲指定は重複していないことがとても重要です。
そうなっていないと、プロセスが別の名前空間内でのアクセスを実現できません。
Linux ディストリビューションの多くでは、ユーザの追加、削除を行う際の ID 範囲指定を制御するシステム・ユーティリティを提供しています。

.. This re-mapping is transparent to the container, but introduces some
   configuration complexity in situations where the container needs access to
   resources on the Docker host, such as bind mounts into areas of the filesystem
   that the system user cannot write to. From a security standpoint, it is best to
   avoid these situations.

この再割り当ての機能は、コンテナにおいてはわかりやすいものです。
ただし設定を行う上では複雑な状況がありえます。
たとえば Docker ホスト上のリソースにコンテナがアクセスする必要がある場合です。
具体的にバインド・マウントでは、システム・ユーザが書き込み不能なファイルシステムの領域にマウントを行います。
セキュリティの観点からは、こういった状況は避けることが一番です。


.. Prerequisites

.. _userns-remap-prerequisites:

事前準備
====================

.. 1.  The subordinate UID and GID ranges must be associated with an existing user,
       even though the association is an implementation detail. The user owns
       the namespaced storage directories under `/var/lib/docker/`. If you don't
       want to use an existing user, Docker can create one for you and use that. If
       you want to use an existing username or user ID, it must already exist.
       Typically, this means that the relevant entries need to be in
       `/etc/passwd` and `/etc/group`, but if you are using a different
       authentication back-end, this requirement may translate differently.

1.  サブ UID とサブ GID の設定範囲は、既存ユーザに対して関連づいていなければなりません。
    ただし関連づけは、実装上の都合によるものです。
    ユーザは ``/var/lib/docker/`` 配下に、名前空間により分けられた保存ディレクトリを所有します。
    既存ユーザを利用したくない場合は、Docker がかわりにユーザを生成して利用してくれます。
    逆に既存ユーザの名前または ID を利用したい場合は、あらかじめ存在していなければなりません。
    通常は ``/etc/passwd`` や ``/etc/group`` 内に、対応するエントリが存在していなければなりませんが、別の認証システムをバックエンドに利用している場合は、そのファイルのエントリは、別の形で取り扱われることになります。

   ..    To verify this, use the id command:

   これを確認するには、 ``id`` コマンドを使います。

   .. code-block:: bash
   
      $ id testuser
      
      uid=1001(testuser) gid=1001(testuser) groups=1001(testuser)

.. 2.  The way the namespace remapping is handled on the host is using two files,
       `/etc/subuid` and `/etc/subgid`. These files are typically managed
       automatically when you add or remove users or groups, but on a few
       distributions such as RHEL and CentOS 7.3, you may need to manage these
       files manually.

2.  名前空間の再割り当てがホスト上において処理される際には、2 つのファイルが利用されます。
    ``/etc/subuid`` と ``/etc/subgid`` です。
    このファイルは通常は、ユーザやグループの追加、削除の際に、自動的に生成管理されます。
    ただし RHEL や CentOS 7.3 のような一部のディストリビューションでは、このファイルの手動での管理を必要とするものがあります。

   ..  Each file contains three fields: the username or ID of the user, followed by
       a beginning UID or GID (which is treated as UID or GID 0 within the namespace)
       and a maximum number of UIDs or GIDs available to the user. For instance,
       given the following entry:

   この 2 つのファイルでは 3 つの項目が記述されます。
   ユーザ名あるいはユーザ ID、続いて UID または GID の開始値（名前空間内では UID または GID がゼロとして扱われるもの）、最後にそのユーザにおいて利用可能な UID または GID の最大数です。
   たとえば以下のようなエントリがあったとします。

   ::
   
      testuser:231072:65536

   ..  This means that user-namespaced processes started by `testuser` are
       owned by host UID `231072` (which looks like UID `0` inside the
       namespace) through 296607 (231072 + 65536 - 1). These ranges should not overlap,
       to ensure that namespaced processes cannot access each other's namespaces.

   上が意味することは以下のとおりです。
   ``testuser`` によって起動されたユーザ名前空間のプロセスは、ホスト上の ``231072`` （名前空間内では UID ``0`` として見えるもの）から ``296607`` (231072 + 65536 - 1) までの間の UID によって所有されます。
   この範囲は他と重複してはなりません。
   これを確実に行うことで、名前空間内のプロセスが別の名前空間へアクセスできないようにします。

   .. After adding your user, check `/etc/subuid` and `/etc/subgid` to see if your
      user has an entry in each. If not, you need to add it, being careful to
      avoid overlap.

   ユーザを追加したら ``/etc/subuid`` と ``/etc/subgid`` のそれぞれにおいて、追加したユーザを表わすエントリが含まれていることを確認してください。
   もしエントリが存在しなければ、追加してください。
   ID の重複には十分に注意してください。

   .. If you want to use the `dockremap` user automatically created by Docker,
      check for the `dockremap` entry in these files **after**
      configuring and restarting Docker.

   Docker によって自動的に生成される ``dockremap`` ユーザーを利用したい場合は、``dockremap`` のエントリーがそのファイル内にあるかどうかを確認しますが、それは設定を行って Docker を再起動した **後に** 行ってください。

.. 3.  If there are any locations on the Docker host where the unprivileged
       user needs to write, adjust the permissions of those locations
       accordingly. This is also true if you want to use the `dockremap` user
       automatically created by Docker, but you can't modify the
       permissions until after configuring and restarting Docker.

3.  Docker ホスト上に、非特権ユーザが書き込みを必要とするディレクトリがあるとします。
    その場合はそのディレクトリのパーミッションを適切に調整してください。
    これは Docker によって自動生成された ``dockremap`` ユーザを利用する場合も同様ですが、このときにはパーミッション変更後に Docker を再起動しない限り、その設定変更は反映されません。

.. 4.  Enabling `userns-remap` effectively masks existing image and container
       layers, as well as other Docker objects within `/var/lib/docker/`. This is
       because Docker needs to adjust the ownership of these resources and actually
       stores them in a subdirectory within `/var/lib/docker/`. It is best to enable
       this feature on a new Docker installation rather than an existing one.

4.  ``userns-remap`` を有効にすることで、既存イメージやコンテナのレイヤは効果的に保護されます。
    これは ``/var/lib/docker/`` 内にある Docker オブジェクトすべてについて言えることです。
    そもそも Docker ではそういったリソース類の所有者を調整する必要があり、そうして ``/var/lib/docker/`` 内のサブディレクトリに情報を保存するからです。
    新たな Docker インストールの際に、この機能を有効にして利用していくことがベストです。

   これらの手順に従い、 ``userns-remap`` を無効化したら、有効化後に作成したリソースには一切できなくなります。（訳者注：userne-remap を有効化時、無効化時、 /var/lib/docker/ 以下の異なるディレクトリに Docker オブジェクトを保存します。そのため、有効化する前にあったコンテナやイメージはは有効化によって見えなくなりますし、無効化によっても有効化時のコンテナやイメージが見えなくなります）

..    Check the limitations on user namespaces to be sure your use case is possible.

5. ユースケースが可能であれば、ユーザ名前空間上の :ref:`制限 <user-namespace-known-limitations>` も確認ください。

.. Enable userns-remap on the daemon

.. _Enable userns-remap on the daemon

デーモン上で userns-remap の有効化
========================================

.. You can start dockerd with the --userns-remap flag or follow this procedure to configure the daemon using the daemon.json configuration file. The daemon.json method is recommended. If you use the flag, use the following command as a model:

``dockerd`` の開始時に ``--userns-remap`` フラグを有効化するか、以下の手順にある、デーモンが使う設定ファイル ``daemon.json`` の設定を変更できます。 ``daemon.json``  を使う方法を推奨しています。フラグを使いたい場合は、次のコマンドを使います。

.. code-block:: bash

   $ dockerd --userns-remap="testuser:testuser"

..    Edit /etc/docker/daemon.json. Assuming the file was previously empty, the following entry enables userns-remap using user and group called testuser. You can address the user and group by ID or name. You only need to specify the group name or ID if it is different from the user name or ID. If you provide both the user and group name or ID, separate them by a colon (:) character. The following formats all work for the value, assuming the UID and GID of testuser are 1001:

1. ``/etc/docker/daemon.json`` を編集します。以下の手順における想定は、ファイルが空っぽであ、 ``userns-remap`` を有効化するために使うユーザとグループは ``testuser`` とします。ユーザとグループは ID あるいは名前で割り当て可能です。グループ名や ID を指定する必要があるのは、ユーザ名または ID と異なる場合のみです。もしも、ユーザとグループ両方の名前または ID を指定する時は、これらをコロン文字（ ``:`` ）で区切ります。以下は全て値として認識できる形式であり、``testuser`` の UID と GID は ``1001`` と仮定します。

   * testuser
   * testuser:testuser
   * 1001
   * 1001:1001
   * testuser:1001
   * 1001:testuser

   .. code-block:: json

      {
        "userns-remap": "testuser"
      }

   .. note::
   
   ``dockremap`` ユーザを使うと、 Docker が自動的に作成しますが、その場合 ``testuser`` ではなく ``default`` になります。

   ファイルを保存し、 Docker を再起動します。

..    If you are using the dockremap user, verify that Docker created it using the id command.

2. もしも ``dockremap`` ユーザを使っている場合は、 ``id`` コマンドを使い Docker によって作成されたものだと確認します。

   .. code-block:: bash

       $ id dockremap
      
      uid=112(dockremap) gid=116(dockremap) groups=116(dockremap)

   ``/etc/subuid`` と ``/etc/subgid`` にエントリが追加されているのを確認します。

   .. code-block:: bash

      $ grep dockremap /etc/subuid
      
      dockremap:231072:65536
      
      $ grep dockremap /etc/subgid
      
      dockremap:231072:65536

   ..    If these entries are not present, edit the files as the root user and assign a starting UID and GID that is the highest-assigned one plus the offset (in this case, 65536). Be careful not to allow any overlap in the ranges.

   これらのエントリは表示されていなければ、 ``root`` ユーザとしてファイルを編集し、開始 UID と GID を割り当てます。UID と GID は最も高く割り当てられたものより 1 つ加えたオフセット（この例では、 ``65536`` ）にします。この範囲は他と重複しないように、気を付けてください。
  
..    Verify that previous images are not available using the docker image ls command. The output should be empty.

3. ``docker image ls`` コマンドを使って、以前のイメージが利用できないことを核にします。出力結果は空っぽになります。

..    Start a container from the hello-world image.

4. ``hello-world`` イメージからコンテナを起動します。

   .. code-block:: bash
   
      $ docker run hello-world

..    Verify that a namespaced directory exists within /var/lib/docker/ named with the UID and GID of the namespaced user, owned by that UID and GID, and not group-or-world-readable. Some of the subdirectories are still owned by root and have different permissions.

5. ``/var/lib/docker`` 内に名前空間化ディレクトリ（namespaced directory）があるのを確認します。ここは、名前空間化ユーザとして UID と GID の名前を持ち、その UID と GID によって所有され、かつ、グループやワールド（その他のユーザ）からは読み込めない権限（パーミッション）になっているのがわかります。また、サブディレクトリのいくつかは依然 ``root`` の所有となっており、パーミッションが異なります。

   .. code-block:: bash
   
      $ sudo ls -ld /var/lib/docker/231072.231072/
      
      drwx------ 11 231072 231072 11 Jun 21 21:19 /var/lib/docker/231072.231072/
      
      $ sudo ls -l /var/lib/docker/231072.231072/
      
      total 14
      drwx------ 5 231072 231072 5 Jun 21 21:19 aufs
      drwx------ 3 231072 231072 3 Jun 21 21:21 containers
      drwx------ 3 root   root   3 Jun 21 21:19 image
      drwxr-x--- 3 root   root   3 Jun 21 21:19 network
      drwx------ 4 root   root   4 Jun 21 21:19 plugins
      drwx------ 2 root   root   2 Jun 21 21:19 swarm
      drwx------ 2 231072 231072 2 Jun 21 21:21 tmp
      drwx------ 2 root   root   2 Jun 21 21:19 trust
      drwx------ 2 231072 231072 3 Jun 21 21:19 volumes

   .. Your directory listing may have some differences, especially if you use a different container storage driver than aufs.

   この出力結果は、異なる場合があります。特に、コンテナのストレージ・ドライバに ``aufs`` 以外を使っている場合です。

   ..  The directories which are owned by the remapped user are used instead of the same directories directly beneath /var/lib/docker/ and the unused versions (such as /var/lib/docker/tmp/ in the example here) can be removed. Docker does not use them while userns-remap is enabled.

   ``/var/lib/docker`` の直下に、再割り当てされたユーザが所有するディレクトリがあります。また、使わないバージョンになったディレクトリは削除可能です（今回の例では、  ``/var/lib/docker/tmp/`` です ）。以前のディレクトリは ``userns-remap`` を有効化しない限り、 Docker からは使われません。

.. Disable namespace remapping for a container

.. _disable-namespace-remapping-for-a-container:

コンテナに対する名前空間の再割り当てを無効化
==================================================

.. If you enable user namespaces on the daemon, all containers are started with user namespaces enabled by default. In some situations, such as privileged containers, you may need to disable user namespaces for a specific container. See user namespace known limitations for some of these limitations.

デーモン上でユーザ名前空間を有効化すると、デフォルトで全てのコンテナがユーザ名前空間を有効化して起動します。同様に、特権コンテナ（privileged container）の実行時は、特定のコンテナに対するユーザ名前空間を無効化する必要があるでしょう。これらの制限に関しては :ref:`user-namespace-known-limitations` をご覧ください。

.. To disable user namespaces for a specific container, add the --userns=host flag to the docker container create, docker container run, or docker container exec command.

特定のコンテナに対してユーザ名前空間を無効化するには、 ``docker container create`` 、 ``docker container run`` 、 ``docker container exec`` コマンドで ``--userne=host`` を使います。

.. There is a side effect when using this flag: user remapping will not be enabled for that container but, because the read-only (image) layers are shared between containers, ownership of the containers filesystem will still be remapped.

フラグを使うと思わぬ副作用が発生する場合があります。つまり、ユーザの再割り当てはコンテナに対しては有効化されないものの、読み込み専用の（イメージ）レイヤはコンテナ間でも共有されているため、コンテナのファイルシステムの所有者は再割り当てされたままです。

.. What this means is that the whole container filesystem will belong to the user specified in the --userns-remap daemon config (231072 in the example above). This can lead to unexpected behavior of programs inside the container. For instance sudo (which checks that its binaries belong to user 0) or binaries with a setuid flag.

これはどういう事か説明しますと、コンテナのファイルシステム全体は、 ``--userns-remap`` デーモン設定（先ほどの例では ``231072`` ）で指定したユーザが所有します。これにより、コンテナ内のプログラムが予期しない挙動を引き起こす場合があります。たとえば、 ``sudo`` （これはバイナリがユーザ ``0``  に所属しているかどうかを調べるため）やバイナリに ``setuid`` フラグが付いている場合です。

.. User namespace known limitations

.. _user-namespace-known-limitations:

ユーザ名前空間における既知の制限
========================================

.. The following standard Docker features are incompatible with running a Docker daemon with user namespaces enabled:

ユーザ名前空間を有効化する Docker デーモンの実行は、以下の標準的 Docker 機能と互換性がありません。

..  sharing PID or NET namespaces with the host (--pid=host or --network=host).
    external (volume or storage) drivers which are unaware or incapable of using daemon user mappings.
    Using the --privileged mode flag on docker run without also specifying --userns=host.

* ホストとの PID あるいは NET 名前空間の共有（ ``--pid=host`` や ``--network=host`` ）
* 外部（ボリュームやストレージ）ドライバは、デーモンによるユーザ割り当てについて、考慮されていないか互換性がありません。
* ``docker run`` で ``--privileged`` モードのフラグを使うとき、 ``--userns=host`` も指定

.. User namespaces are an advanced feature and require coordination with other capabilities. For example, if volumes are mounted from the host, file ownership must be pre-arranged need read or write access to the volume contents.

ユーザ名前空間は高度な機能であり、他のケーパビリティとの調整も必要になります。たとえば、ボリュームをホストからマウントする場合、ファイルの所有権はボリュームとして使うコンテナから読み込みまたは書き込み可能なように、あらかじめ調整が必要です。

.. While the root user inside a user-namespaced container process has many of the expected privileges of the superuser within the container, the Linux kernel imposes restrictions based on internal knowledge that this is a user-namespaced process. One notable restriction is the inability to use the mknod command. Permission is denied for device creation within the container when run by the root user.

ユーザ名前空間化したコンテナのプロセス内の root ユーザは、コンテナ内では例外的なスーパーユーザとしての特権を持ちますが、Linux カーネルは内部のナレッジに基づいた制限を課します。つまり、これがユーザ名前空間化したプロセスです。有名な制限の１つは、 ``mknod``  コマンドの使用を不可能にします。 ``root`` ユーザとして実行する時は、コンテナ内でデバイスの作成権限は拒否されます。

.. seealso:: 

   Isolate containers with a user namespace
      https://docs.docker.com/engine/security/userns-remap/
