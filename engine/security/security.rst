.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/security/security/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/security/security.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/security/security.md
.. check date: 2016/06/14
.. Commits on May 12, 2016 73d96a6b17b1fb8af71dc68d78e50f88b89f4167
.. -------------------------------------------------------------------

.. Docker Security

.. _security-docker-security:

=======================================
Docker のセキュリティ
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. There are four major areas to consider when reviewing Docker security:

Docker のセキュリティを考えてみる上では、主要な観点が 4 つあります。

.. - the intrinsic security of the kernel and its support for
     namespaces and cgroups;
   - the attack surface of the Docker daemon itself;
   - loopholes in the container configuration profile, either by default,
     or when customized by users.
   - the "hardening" security features of the kernel and how they
     interact with containers.

* カーネルに元からあるセキュリティと名前空間や cgroup のサポート。
* Docker デーモンそのものの攻撃領域。
* コンテナ設定プロファイルにおける抜け穴。デフォルトの場合だけでなくユーザーによるカスタマイズ時も含む。
* セキュリティ強化されたカーネル機能とそれがコンテナとやり取りする方法。

.. Kernel namespaces

.. _security-kernel-namespaces:

カーネルの名前空間
====================

.. Docker containers are very similar to LXC containers, and they have
   similar security features. When you start a container with
   `docker run`, behind the scenes Docker creates a set of namespaces and control
   groups for the container.

Docker コンテナは LXC コンテナによく似ています。
どちらも同じようなセキュリティ機能を持っています。
``docker run`` によってコンテナを起動させると Docker の内部処理では、コンテナが利用する名前空間やコントロールグループが生成されます。

.. **Namespaces provide the first and most straightforward form of
   isolation**: processes running within a container cannot see, and even
   less affect, processes running in another container, or in the host
   system.

**名前空間とは、初めて提供された最もストレートな形の分離技術のことです**。
コンテナ内部にて起動されるプロセスからは、他のコンテナ内部やホストシステム内のプロセスを参照することはできず、また影響もほぼ及ぼしません。

.. **Each container also gets its own network stack**, meaning that a
   container doesn't get privileged access to the sockets or interfaces
   of another container. Of course, if the host system is setup
   accordingly, containers can interact with each other through their
   respective network interfaces — just like they can interact with
   external hosts. When you specify public ports for your containers or use
   [*links*](../../network/links.md)
   then IP traffic is allowed between containers. They can ping each other,
   send/receive UDP packets, and establish TCP connections, but that can be
   restricted if necessary. From a network architecture point of view, all
   containers on a given Docker host are sitting on bridge interfaces. This
   means that they are just like physical machines connected through a
   common Ethernet switch; no more, no less.

**各コンテナでは独自のネットワークスタックを用います**。
これはつまり、別のコンテナのソケットやインターフェースへアクセスする際に、特権的なアクセス権限を有していないということです。
もちろんホストシステムが適切に設定されていれば、コンテナ間はそれぞれのネットワークインターフェースを介して通信を行うことができます。
外部にあるホストとの間で通信しているようなものです。
コンテナに対して公開ポートを指定するか、あるいは :doc:`リンク機能 </engine/userguide/networking/default_network/dockerlinks>` を利用すれば、コンテナ間での IP トラフィックが許可されます。
その場合コンテナ間にて互いに ping を行い、UDP パケットの送受信することで TCP コネクションが確立されます。
ただし状況に応じて制限がかけられることもあります。
ネットワークアーキテクチャの点でいうと、特定の Docker ホスト上にあるコンテナはすべて、ブリッジインターフェース上に置かれます。
これは各コンテナがあたかも実際に存在する物理的なマシンのようであり、共有するイーサネットスイッチにより通信を行っているようなものです。
これ以上でもなく、これ以下でもありません。

.. How mature is the code providing kernel namespaces and private
   networking? Kernel namespaces were introduced [between kernel version
   2.6.15 and
   2.6.26](http://man7.org/linux/man-pages/man7/namespaces.7.html).
   This means that since July 2008 (date of the 2.6.26 release
   ), namespace code has been exercised and scrutinized on a large
   number of production systems. And there is more: the design and
   inspiration for the namespaces code are even older. Namespaces are
   actually an effort to reimplement the features of [OpenVZ](
   http://en.wikipedia.org/wiki/OpenVZ) in such a way that they could be
   merged within the mainstream kernel. And OpenVZ was initially released
   in 2005, so both the design and the implementation are pretty mature.

ではカーネルの名前空間やプライベートネットワーク機能のソースコードは、成熟したものになっているでしょうか。
カーネルの名前空間が導入されたのは `カーネル 2.6.15 から 2.6.26 の間 <http://lxc.sourceforge.net/index.php/about/kernel-namespaces/>`_  です。
つまり 2008 年 6 月（2.6.26 のリリース日）以降、名前空間のソースコードは、数多くの本番環境システムを通じて検証が続いている状態です。
それだけではありません。
名前空間のソースコードの設計と発想は、もはや古いものになっています。
そもそも名前空間は `OpenVZ <http://ja.wikipedia.org/wiki/OpenVZ>`_ の機能を再実装するという努力から生まれたものであり、カーネルのメインストリームにマージされることを目指したものです。
ちなみに OpenVZ が初めてリリースされたのは 2005 年であり、その設計と実装はともに十分成熟しています。

.. Control groups

.. _security-control-groups:

コントロール・グループ
==============================

.. Control Groups are another key component of Linux Containers. They
   implement resource accounting and limiting. They provide many
   useful metrics, but they also help ensure that each container gets
   its fair share of memory, CPU, disk I/O; and, more importantly, that a
   single container cannot bring the system down by exhausting one of those
   resources.

コントロール・グループは、Linux コンテナ技術のもう一つの重要コンポーネントです。
これはリソース管理と利用制限を実装します。
これにより有用なメトリクスが数多く提供されます。
そしてこの機能はメモリ、CPU、ディスク I/O を各コンテナが共有して利用できるようにします。
さらに重要なのは、たった 1 つのコンテナがリソースを大量消費し、それがシステムダウンにつながるようなことはありません。

.. So while they do not play a role in preventing one container from
   accessing or affecting the data and processes of another container, they
   are essential to fend off some denial-of-service attacks. They are
   particularly important on multi-tenant platforms, like public and
   private PaaS, to guarantee a consistent uptime (and performance) even
   when some applications start to misbehave.

この機能の役割は、あるコンテナから別コンテナのデータやプロセスに対して、アクセスや変更を防ぐというものではありません。
これはサービス妨害攻撃を防ぐという重要な役割を持っています。
特に重要となるのが、公開あるいはプライベート PaaS のようなマルチテナント型プラットフォームにおいてです。
いずれかのアプリケーションが誤動作をし始めたとしても、安定した稼動（とパフォーマンス）を保証するものです。

.. Control Groups have been around for a while as well: the code was
   started in 2006, and initially merged in kernel 2.6.24.

コントロール・グループも同じく、登場してからさほど経過していません。
その開発は 2006 年に始まり、カーネルに初めてマージされたのは 2.6.24 のときです。

.. Docker daemon attack surface

.. _docker-daemon-attack-surface:

Docker デーモンの攻撃領域
==============================

.. Running containers (and applications) with Docker implies running the
   Docker daemon. This daemon requires `root` privileges unless you opt-in
   to [Rootless mode](rootless.md) (experimental), and you should therefore
   be aware of some important details.

コンテナ（およびアプリケーション）を Docker とともに動作させるということは、暗に Docker デーモンを動作させるということです。
デーモンの起動には :doc:`rootless モード </engine/security/rootless>` (試験的機能) を用いるのでない限りは ``root`` 権限を必要とします。
したがって重要な点をいくつか意識しておく必要があります。

.. First of all, **only trusted users should be allowed to control your
   Docker daemon**. This is a direct consequence of some powerful Docker
   features. Specifically, Docker allows you to share a directory between
   the Docker host and a guest container; and it allows you to do so
   without limiting the access rights of the container. This means that you
   can start a container where the `/host` directory is the `/` directory
   on your host; and the container can alter your host filesystem
   without any restriction. This is similar to how virtualization systems
   allow filesystem resource sharing. Nothing prevents you from sharing your
   root filesystem (or even your root block device) with a virtual machine.

まず第一に、**Docker デーモンを制御できるのは信頼できるユーザーのみとすべき** ということです。
Docker の強力な機能の中には、この問題が直接関係するものがあります。
特に Docker においては Docker ホストとゲストコンテナの間でのディレクトリ共有が可能であり、つまりコンテナのアクセス権拡大を許しているわけです。
ということは、コンテナの ``/host`` ディレクトリをホスト上の ``/`` ディレクトリに割り当ててコンテナを起動できることを意味し、それはコンテナが何ら制限なくホストのファイルシステムを変更できてしまうことになります。
ちょうど仮想化システムがファイルシステムというリソースをどのように共有するかという問題と同じです。
仮想マシンを使ってルートファイルシステムを（あるいはルートブロックデバイスでさえ）共有化できてしまうことは、防ぎようがありません。

.. This has a strong security implication: for example, if you instrument Docker
   from a web server to provision containers through an API, you should be
   even more careful than usual with parameter checking, to make sure that
   a malicious user cannot pass crafted parameters causing Docker to create
   arbitrary containers.

これはセキュリティに重大な影響を及ぼします。
たとえば Docker の API を通じて、ウェブ・サーバをコンテナにプロビジョニングするとします。
このときには、通常以上に十分なパラメータ・チェックを行う必要があります。
そして悪意のあるユーザーがパラメータに細工をしたとしても、Docker から任意のコンテナが生成されないようにすることが重要です。

.. For this reason, the REST API endpoint (used by the Docker CLI to
   communicate with the Docker daemon) changed in Docker 0.5.2, and now
   uses a UNIX socket instead of a TCP socket bound on 127.0.0.1 (the
   latter being prone to cross-site request forgery attacks if you happen to run
   Docker directly on your local machine, outside of a VM). You can then
   use traditional UNIX permission checks to limit access to the control
   socket.

このことから REST API のエンドポイント（Docker デーモンとやり取りするために Docker CLI により用いられるもの）が Docker 0.5.2 において変更され、127.0.0.1 にバインドされる TCP ソケットではなく UNIX ソケットを用いるようになりました。
（TCP ソケットは、VM の外にあるローカルマシン上に直接 Docker を起動したときに、CSRF (cross-site request forgery) 攻撃を受けやすくなります。）
そこで従来からある Unix パーミッションチェックを利用して、制御ソケットへのアクセスを制限する必要があります。

.. You can also expose the REST API over HTTP if you explicitly decide to do so. However, if you do that, being aware of the above mentioned security implication, you should ensure that it will be reachable only from a trusted network or VPN; or protected with e.g., stunnel and client SSL certificates. You can also secure them with HTTPS and certificates.

明示的に HTTP 上で REST API を晒すことも可能です。しかし、そのように設定すべきではありません。上記で言及したセキュリティ実装のため、信頼できるネットワークや VPN 、 ``stunnel`` やクライアント SSL 証明が利用できる所でのみ使うべきです。より安全にするためには :doc:`HTTPS と証明書 <https>` を利用できます。

.. The daemon is also potentially vulnerable to other inputs, such as image loading from either disk with ‘docker load’, or from the network with ‘docker pull’. This has been a focus of improvement in the community, especially for ‘pull’ security. While these overlap, it should be noted that ‘docker load’ is a mechanism for backup and restore and is not currently considered a secure mechanism for loading images. As of Docker 1.3.2, images are now extracted in a chrooted subprocess on Linux/Unix platforms, being the first-step in a wider effort toward privilege separation.

また、デーモンは入力に関する脆弱性を潜在的に持っています。これはディスク上で ``docker load`` 、あるいはネットワーク上で ``docker pull`` を使いイメージを読み込む時です。これはコミュニティにおける改良に焦点がおかれており、特に安全に ``pull`` するためです。これまでの部分と重複しますが、 ``docker load`` はバックアップや修復のための仕組みです。しかし、イメージの読み込みにあたっては、現時点で安全な仕組みではないと考えられていることに注意してください。Docker 1.3.2 からは、イメージは Linux/Unix プラットフォームの chroot サブ・プロセスとして展開されるようになりました。これは広範囲にわたる特権分離問題に対する第一歩です。

.. Eventually, it is expected that the Docker daemon will run restricted privileges, delegating operations well-audited sub-processes, each with its own (very limited) scope of Linux capabilities, virtual network setup, filesystem management, etc. That is, most likely, pieces of the Docker engine itself will run inside of containers.

最終的には、Docker デーモンは制限された権限下で動作するようになるでしょう。それぞれが自身の（あるいは限定された） Linux ケーパビリティ（capability；「能力」や「機能」の意味）、仮想ネットワークのセットアップ、ファイルシステム管理といった、サブプロセスごとに委任したオペレーションを監査できるようになることを期待しています。

.. Finally, if you run Docker on a server, it is recommended to run exclusively Docker in the server, and move all other services within containers controlled by Docker. Of course, it is fine to keep your favorite admin tools (probably at least an SSH server), as well as existing monitoring/supervision processes (e.g., NRPE, collectd, etc).

なお、Docker をサーバで動かす場合は、サーバ上で Docker 以外を動かさないことを推奨します。そして、他のサービスは Docker によって管理されるコンテナに移動しましょう。もちろん、好きな管理ツール（おそらく SSH サーバでしょう）や既存の監視・管理プロセス（例： NRPE、collectd、等）はそのままで構いません。

.. Linux kernel capabilities

.. _security-linux-kernel-capabilities:

Linux カーネルのケーパビリティ
==============================

.. By default, Docker starts containers with a restricted set of capabilities. What does that mean?

デフォルトでは Docker はケーパビリティ（capability；「能力」や「機能」の意味）を抑えた状態でコンテナを起動します。つまり、これはどのような意味でしょうか。

.. Capabilities turn the binary “root/non-root” dichotomy into a fine-grained access control system. Processes (like web servers) that just need to bind on a port below 1024 do not have to run as root: they can just be granted the net_bind_service capability instead. And there are many other capabilities, for almost all the specific areas where root privileges are usually needed.

ケーパビリティとは、「root」か「root以外か」といったバイナリの二分法によって分類する、きめ細かなアクセス制御システムです。（ウェブサーバのような）プロセスがポート 1024 以下でポートをバインドする必要がある時、root 権限でなければ実行できません。そこで ``net_bind_service`` ケーパビリティを使い、権限を与えます。他にも多くのケーパビリティがあります。大部分は特定の条件下で root 特権を利用できるようにするものです。

.. This means a lot for container security; let’s see why!

つまり、コンテナのセキュリティを高めます。理由を見ていきましょう！

.. Your average server (bare metal or virtual machine) needs to run a bunch of processes as root. Those typically include SSH, cron, syslogd; hardware management tools (e.g., load modules), network configuration tools (e.g., to handle DHCP, WPA, or VPNs), and much more. A container is very different, because almost all of those tasks are handled by the infrastructure around the container:

あなたの平均的なサーバ（ベアメタルでも、仮想マシンでも）が必要とするのは、root として実行される一連のプロセスです。典型的なものに SSH、cron、syslogd が含まれるでしょう。あるいは、ハードウェア管理ツール（例：load  モジュール）、ネットワーク設定ツール（例：DHCP、WPA、VPN を取り扱うもの）、等々があります。ですが、コンテナは非常に異なります。なぜなら、これらのタスクのほぼ全てが、コンテナの中という基盤上で処理されるからです。

..    SSH access will typically be managed by a single server running on the Docker host;

* SSH 接続は、 Docker ホストのサーバ上を管理する典型的な手法です。

..     cron, when necessary, should run as a user process, dedicated and tailored for the app that needs its scheduling service, rather than as a platform-wide facility;

* ``cron`` は、必要があればユーザ・プロセスとして実行可能です。プラットフォーム上のファシリティを広範囲に使うのではなく、専用、もしくはアプリケーションが個別に必要なサービスをスケジュールします。

..    log management will also typically be handed to Docker, or by third-party services like Loggly or Splunk;

* ログ管理もまた Docker の典型的な処理であり、あるいはサードパーティー製の Loggly や Splunk を使うでしょう。

..    hardware management is irrelevant, meaning that you never need to run udevd or equivalent daemons within containers;

* ハードウェア管理には適していません。これはコンテナ内で ``udevd`` や同等のデーモンを実行できないためです。

..    network management happens outside of the containers, enforcing separation of concerns as much as possible, meaning that a container should never need to perform ifconfig, route, or ip commands (except when a container is specifically engineered to behave like a router or firewall, of course).

* ネットワーク管理はコンテナの外で行われので、懸念されうる事項を分離します。つまり、コンテナでは ``ifconfig`` 、 ``route`` 、 ``ip`` コマンドを実行する必要がありません（ただし、コンテナでルータやファイアウォール等の振る舞いを処理させる場合は、もちろん除きます）。

.. This means that in most cases, containers will not need “real” root privileges at all. And therefore, containers can run with a reduced capability set; meaning that “root” within a container has much less privileges than the real “root”. For instance, it is possible to:

これらが意味するのは、大部分のケースにおいて、コンテナを「本当の」 root 特権で動かす必要は *全く無い* ということです。それゆえ、コンテナはケーパビリティの組み合わせを減らして実行できるのです。つまり、コンテナ内の「root」は、実際の「root」よりも権限が少ないことを意味します。例えば、次のような使い方があります。

..    deny all “mount” operations;
    deny access to raw sockets (to prevent packet spoofing);
    deny access to some filesystem operations, like creating new device nodes, changing the owner of files, or altering attributes (including the immutable flag);
    deny module loading;
    and many others.

* 全ての「mount」操作を拒否
* raw ソケットへのアクセスを拒否（パケット・スプーフィングを阻止）
* ファイルシステムに関するいくつかの操作を拒否（新しいデバイス・ノードの作成、ファイル所有者の変更、immutable フラグを含む属性の変更）
* モジュールの読み込みを禁止
* などなど

.. This means that even if an intruder manages to escalate to root within a container, it will be much harder to do serious damage, or to escalate to the host.

これが意味するのは、侵入者がコンテナ内で root に昇格しようとしても、深刻なダメージを与えるのが困難であり、ホストにも影響を与えられません。

.. This won’t affect regular web apps; but malicious users will find that the arsenal at their disposal has shrunk considerably! By default Docker drops all capabilities except those needed, a whitelist instead of a blacklist approach. You can see a full list of available capabilities in Linux manpages.

通常のウェブ・アプリケーションには影響を与えません。しかし、悪意のあるユーザであれば、自分たちが自由に使える武器が減ったと分かるでしょう！ Docker は `必要に応じて <https://github.com/docker/docker/blob/master/daemon/execdriver/native/template/default_template.go>`_ 全てのケーパビリティを除外し、ブラックリストからホワイトリストに除外する方法も使えます。利用可能なケーパビリティについては、 `Linux の man ページ <http://man7.org/linux/man-pages/man7/capabilities.7.html>`_ をご覧ください。

.. One primary risk with running Docker containers is that the default set of capabilities and mounts given to a container may provide incomplete isolation, either independently, or when used in combination with kernel vulnerabilities.

Docker コンテナ実行にあたり、最も重要なリスクというのは、デフォルトのケーパビリティのセットとコンテナに対するマウントにより、不完全な分離（独立性、あるいは、カーネルの脆弱性と組み合わせ）をもたらすかもしれない点です

.. Docker supports the addition and removal of capabilities, allowing use of a non-default profile. This may make Docker more secure through capability removal, or less secure through the addition of capabilities. The best practice for users would be to remove all capabilities except those explicitly required for their processes.

Docker はケーパビリティの追加と削除をサポートしますので、デフォルトで何も無いプロファイルも扱えます。これにより、ケーパビリティが削除されても Docker は安全ですが、ケーパビリティを追加する時はセキュリティが低下します。利用にあたってのベストプラクティスは、各プロセスが明らかに必要なケーパビリティを除き、全て削除することです。

.. Other kernel security features

.. _security-other_kernel_security_features:

その他のカーネル・セキュリティ機能
========================================

.. Capabilities are just one of the many security features provided by modern Linux kernels. It is also possible to leverage existing, well-known systems like TOMOYO, AppArmor, SELinux, GRSEC, etc. with Docker.

ケーパビリティは、最近の Linux カーネルで提供されている、様々なセキュリティ機能の１つです。他にも既存のよく知られている TOMOYO、AppArmor、SELinux、GRSEC のようなシステムが Docker で使えます。

.. While Docker currently only enables capabilities, it doesn’t interfere with the other systems. This means that there are many different ways to harden a Docker host. Here are a few examples.

現時点の Docker はケーパビリティの有効化しかできず、他のシステムには干渉できません。つまり、Docker ホストを堅牢にするには様々な異なった方法があります。以下は複数の例です。

..     You can run a kernel with GRSEC and PAX. This will add many safety checks, both at compile-time and run-time; it will also defeat many exploits, thanks to techniques like address randomization. It doesn’t require Docker-specific configuration, since those security features apply system-wide, independent of containers.

* カーネルで GRSEC と PAX を実行できます。これにより、コンパイル時と実行時の安全チェック機能をもたらします。アドレスランダム化のような技術に頼る、多くの exploit を無効化します。Docker 固有の設定は不要です。コンテナとは独立して、システムの広範囲にわたるセキュリティ機能を提供します。

..    If your distribution comes with security model templates for Docker containers, you can use them out of the box. For instance, we ship a template that works with AppArmor and Red Hat comes with SELinux policies for Docker. These templates provide an extra safety net (even though it overlaps greatly with capabilities).

* ディストリビューションに Docker コンテナに対応したセキュリティ・モデル・テンプレートがあれば、それを利用可能です。例えば、私たちは AppArmor で動作するテンプレートを提供しています。また、Red hat は Docker 対応の SELinux ポリシーを提供しています。これらのテンプレートは外部のセーフティーネットを提供します（ケーパビリティと大いに重複する部分もありますが）。

..    You can define your own policies using your favorite access control mechanism.

* 好みのアクセス管理メカニズムを使って、自分自身でポリシーを制限できます。

.. Just like there are many third-party tools to augment Docker containers with e.g., special network topologies or shared filesystems, you can expect to see tools to harden existing Docker containers without affecting Docker’s core.

Docker コンテナと連携する多くのサードパーティー製ツールが提供されています。例えば、特別なネットワーク・トポロジーや共有ファイルシステムです。これらは Docker のコアの影響を受けずに、既存の Docker コンテナを堅牢にするものです。

.. （1.11で削除）
.. Recent improvements in Linux namespaces will soon allow to run full-featured containers without root privileges, thanks to the new user namespace. This is covered in detail here. Moreover, this will solve the problem caused by sharing filesystems between host and guest, since the user namespace allows users within containers (including the root user) to be mapped to other users in the host system.

.. 直近の Linux 名前空間に対する改良によって、新しいユーザ名前空間の力を使い、まもなく root 特権無しに全てのコンテナ機能が使えるようになるでしょう。詳細は `こちら <http://s3hh.wordpress.com/2013/07/19/creating-and-using-containers-without-privilege/>`_ で扱っています。更に、これはホストとゲストに関する共用ファイルシステムによって引き起こされる問題も解決できるかもしれません。これはユーザ名前空間がコンテナ内のユーザをホスト上のユーザ（rootも含まれます）に割り当て（マッピング）できるようにするためです。

.. （1.11で削除）
.. Today, Docker does not directly support user namespaces, but they may still be utilized by Docker containers on supported kernels, by directly using the clone syscall, or utilizing the ‘unshare’ utility. Using this, some users may find it possible to drop more capabilities from their process as user namespaces provide an artificial capabilities set. Likewise, however, this artificial capabilities set may require use of ‘capsh’ to restrict the user-namespace capabilities set when using ‘unshare’.

.. 今日、Docker はユーザ名前空間を直接サポートしていません。しかし、Docker コンテナの実行をサポートしているカーネルでは利用可能なものです。直接使うには syscall をクローンするか、 'unshare' ユーティリティを使います。これらを使い、ユーザ名前空間が提供するアーティフィカル・ケーパビリティ・セット（artificial capabilities set）から、特定のユーザに対するケーパビリティを無効化できることが分かるでしょう。しかしながら、このアーティフィカル・ケーパビリティ・セットを `unshare` で使う時は、ユーザ名前空間で制限するために 'capsh' が必要になるかもしれません。

.. （1.11で削除）
.. Eventually, it is expected that Docker will have direct, native support for user-namespaces, simplifying the process of hardening containers.

.. 最終的には、Docker が直接ユーザ名前空間をサポートし、コンテナ上のプロセス堅牢化を簡単に行えるようになるでしょう。

.. （1.11 で追加）
.. As of Docker 1.10 User Namespaces are supported directly by the docker daemon. This feature allows for the root user in a container to be mapped to a non uid-0 user outside the container, which can help to mitigate the risks of container breakout. This facility is available but not enabled by default.

Docker 1.10 以降は Docker デーモンがユーザ名前空間（User Namespaces）を直接サポートしました。この機能により、コンテナ内の root ユーザをコンテナ外の uid 0 以外のユーザに割り当て（マッピング）できるようになります。コンテナからブレイクアウト（脱獄）する危険性を軽減する手助けとなるでしょう。この実装は利用可能ですが、デフォルトでは有効ではありません。

.. （1.11 で追加）
.. Refer to the daemon command in the command line reference for more information on this feature. Additional information on the implementation of User Namespaces in Docker can be found in this blog post.

こちらの機能に関するより詳しい情報は :ref:`daemon コマンド <daemon-user-namespace-options>` のリファレンスをご覧ください。Docker におけるユーザ名前空間の実装に関する詳細情報は `こちらのブログ投稿 <https://integratedcode.us/2015/10/13/user-namespaces-have-arrived-in-docker/>`_  をご覧ください。

.. Conclusions

.. _security-conclusions:

まとめ
==========

.. Docker containers are, by default, quite secure; especially if you take care of running your processes inside the containers as non-privileged users (i.e., non-root).

デフォルトの Docker コンテナは安全です。それには、コンテナ内のプロセスを、特権の無いユーザ（例： root 以外のユーザ）で実行するように管理します。

.. You can add an extra layer of safety by enabling AppArmor, SELinux, GRSEC, or your favorite hardening solution.

AppArmor、SELinux、GRSEC など任意の堅牢化ソリューションを有効化することで、更に安全なレイヤを追加できます。

.. Last but not least, if you see interesting security features in other containerization systems, these are simply kernels features that may be implemented in Docker as well. We welcome users to submit issues, pull requests, and communicate via the mailing list.

最後ですが疎かにできないのは、他のコンテナ化システムのセキュリティ機能に興味があれば、それらは Docker と同じようにシンプルにカーネルの機能を実装しているのが分かるでしょう。私たちは皆さんからの問題報告、プルリクエスト、メーリングリストにおける議論を歓迎します。

関連情報
==========

* :doc:`trust/index`
* :doc:`seccomp`
* :doc:`apparmor`
* `On the Security of Containers (2014) <https://medium.com/@ewindisch/on-the-security-of-containers-2c60ffe25a9e>`_ 

.. References:
.. リファレンス
.. ====================

..    Docker Containers: How Secure Are They? (2013).
    On the Security of Containers (2014).
.. * `Docker Containers: How Secure Are They? (2013). <http://blog.docker.com/2013/08/containers-docker-how-secure-are-they/>`_ 
.. * `On the Security of Containers (2014) <https://medium.com/@ewindisch/on-the-security-of-containers-2c60ffe25a9e>`_ 

.. seealso:: 

   Docker security
      https://docs.docker.com/engine/security/security/

