.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/faq/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/faq.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/faq.md
.. check date: 2016/06/13
.. Commits on Feb 3, 2016 c49b6ce4e16d570432941fc686c05939dc888fc9
.. -----------------------------------------------------------------------------

.. Frequently Asked Questions (FAQ)

.. faq:

=======================================
よくある質問と回答(FAQ)
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. If you don’t see your question here, feel free to submit new ones to docs@docker.com. Or, you can fork the repo and contribute them yourself by editing the documentation sources.

あなたの質問がここになければ、 docs@docker.com まで遠慮なくお送りください。あるいは、 `リポジトリをフォークし <https://github.com/docker/docker>`_ 、ドキュメントのソースを自分自身で編集し、それらで貢献することもできます。

.. How much does Docker cost?

.. _how-much-does-docker-cost:

Docker を使うには、どれだけの費用がかかりますか？
==================================================

.. Docker is 100% free. It is open source, so you can use it without paying.

Docker は 100% 自由に使えます。オープンソースであり、何も支払わなくても利用できます。

.. What open source license are you using?

.. _what-open-source-license-are-you-using:

オープンソースのライセンスは何を使っていますか？
==================================================

.. We are using the Apache License Version 2.0, see it here: https://github.com/docker/docker/blob/master/LICENSE

Apache License Version 2.0 を使っています。こちらをご覧ください：https://github.com/docker/docker/blob/master/LICENSE

.. Does Docker run on Mac OS X or Windows?

.. _does-docker-run-on-mac-os-x-or-windows:

Mac OS X や Windows で Docker は動きますか？
==================================================

.. Docker currently runs only on Linux, but you can use VirtualBox to run Docker in a virtual machine on your box, and get the best of both worlds. Check out the Mac OS X and Microsoft Windows installation guides. The small Linux distribution Docker Machine can be run inside virtual machines on these two operating systems.

現時点の Docker は Linux 上でしか動きません。しかし VirtualBox を使えば、仮想マシン上で Docker を動かせるため、どちらの環境でも便利に扱えるでしょう。具体的な方法は :doc:`Mac OS X </engine/installation/mac>` と :doc:`Microsoft Windows </engine/installation/windows>` のインストールガイドをご覧ください。どちらの場合でも、 OS 上に仮想マシン内で Docker Machine を実行するための、小さな Linux ディストリビューションをインストールします。

..    Note: if you are using a remote Docker daemon on a VM through Docker Machine, then do not type the sudo before the docker commands shown in the documentation’s examples.

.. note::

   Docker Machine を通して仮想マシン上の Docker デーモンをリモート操作する場合は、ドキュメントのサンプルで ``docker`` コマンドの前にある ``sudo`` を **入力しないでください** 。

.. How do containers compare to virtual machines?

.. _how-do-containers-compare-to-virtual-machines:

コンテナと仮想マシンの違いは何ですか？
========================================

.. They are complementary. VMs are best used to allocate chunks of hardware resources. Containers operate at the process level, which makes them very lightweight and perfect as a unit of software delivery.

相互補完します。仮想マシンはハードウェア・リソースの塊を割り当てるのに一番便利です。コンテナの操作はプロセス・レベルであり、ソフトウェアのデリバリをまとめることができるため、軽量かつパーフェクトです。

.. What does Docker add to just plain LXC?

.. _what-does-docker-add-to-just-plain-lxc:

なぜ Docker は LXC に技術を追加しようとしたのですか？
=====================================================

.. Docker is not a replacement for LXC. “LXC” refers to capabilities of the Linux kernel (specifically namespaces and control groups) which allow sandboxing processes from one another, and controlling their resource allocations. On top of this low-level foundation of kernel features, Docker offers a high-level tool with several powerful functionalities:

Docker 技術は LXC の置き換えではありません。 「LXC」は Linux カーネルの機能を参照しており（特に名前空間とコントロール・グループ）、あるプロセスから別のプロセスに対するサンドボックスを可能とし、リソースの割り当てを制御するものです。これらはカーネル機能のローレベルを基礎としています。一方、Docker は複数の強力な機能を持つハイレベルなツールです。

.. Portable deployment across machines. Docker defines a format for bundling an application and all its dependencies into a single object which can be transferred to any Docker-enabled machine, and executed there with the guarantee that the execution environment exposed to the application will be the same. LXC implements process sandboxing, which is an important pre-requisite for portable deployment, but that alone is not enough for portable deployment. If you sent me a copy of your application installed in a custom LXC configuration, it would almost certainly not run on my machine the way it does on yours, because it is tied to your machine’s specific configuration: networking, storage, logging, distro, etc. Docker defines an abstraction for these machine-specific settings, so that the exact same Docker container can run - unchanged - on many different machines, with many different configurations.

* **マシンをまたがるポータブルなデプロイ** 。Docker はアプリケーションを構築するためのフォーマットを定義し、その全ての依存関係を１つのオブジェクトにすることで、 Docker が利用可能なあらゆるマシン上に移動できるようにします。そして、アプリケーションが同じような環境で動作できるようにするのを保証します。LXC によって実装されるプロセスはサンドボックス（砂場）であり、ポータブルなデプロイの準備としては、重要な環境です。しかしながら、ポータブルなデプロイには十分とは言えません。もしあなたが私にカスタム LXC 設定を施したアプリケーションを送ってきたとしても、おそらく私のマシン上では動作しないでしょう。なぜなら、マシン固有の情報が紐付いているからです。例えばネットワーク、ストレージ、ログ保存、ディストリビューション等です。Docker は、これらマシン固有の情報を抽象化しますので、同じ Docker コンテナであれば間違いなく実行できます。マシンが異なり、環境が変わっていたとしても、コンテナに対して変更を加える必要がありません。

.. Application-centric. Docker is optimized for the deployment of applications, as opposed to machines. This is reflected in its API, user interface, design philosophy and documentation. By contrast, the lxc helper scripts focus on containers as lightweight machines - basically servers that boot faster and need less RAM. We think there’s more to containers than just that.

* **アプリケーション中心型** 。Docker が最適化されているのはマシンに対してというよりも、アプリケーションのデプロイに対してです。これは API やユーザ・インターフェース、設計哲学やドキュメントにも反映されています。対照的に ``lxc`` の場合は、コンテナを軽量なマシンとして扱うための補助スクリプトに注力しています。ここで言うマシンというのは、基本的なサーバのことであり、より速く起動し、メモリを必要としない環境です。私たちは LXC よりもコンテナのほうが、より多くの利点があると考えています。
 
.. Automatic build. Docker includes a tool for developers to automatically assemble a container from their source code, with full control over application dependencies, build tools, packaging etc. They are free to use make, maven, chef, puppet, salt, Debian packages, RPMs, source tarballs, or any combination of the above, regardless of the configuration of the machines.
 
* **自動構築（ Automatic Build ）** 。Docker には、 :doc:`開発者向けにソース・コードからコンテナを自動的に構築する機能 </engine/reference/builder>` があります。これは構築ツールやパッケージングにあたるアプリケーションの依存性を完全に管理します。マシンの設定に関係無く、 ``make`` 、 ``maven`` 、 ``chef`` 、 ``puppet`` 、 ``salt`` 、 Debian パッケージ、 RPM 、ソースの tar ボール等を自由に扱えます。
 
.. Versioning. Docker includes git-like capabilities for tracking successive versions of a container, inspecting the diff between versions, committing new versions, rolling back etc. The history also includes how a container was assembled and by whom, so you get full traceability from the production server all the way back to the upstream developer. Docker also implements incremental uploads and downloads, similar to git pull, so new versions of a container can be transferred by only sending diffs.
 
* **バージョン管理** 。Docker には Git のようにコンテナのバージョン推移を追跡する機能があり、バージョン間の差分を調べ、新しいバージョンをコミットしたり、ロールバックしたり等ができます。また履歴を辿ることで、誰によって何が組み込まれたかを把握できます。そのため、開発元からプロダクションのサーバに至るまでの流れを完全に追跡できます。また Docker には ``git pull`` のようにアップロード回数とダウンロード回数を記録する機能があるため、コンテナの新しいバージョンを送信するとは、単に差分を送信するだけです。
 
.. Component re-use. Any container can be used as a “base image” to create more specialized components. This can be done manually or as part of an automated build. For example you can prepare the ideal Python environment, and use it as a base for 10 different applications. Your ideal PostgreSQL setup can be re-used for all your future projects. And so on.
 
* **再利用可能なコンポーネント** 。コンテナは特別なコンポーネントを「 :ref:`ベース・イメージ <image>` 」として利用できます。これは手動もしくは自動構築の一部で使えます。例えば、望ましい Python 環境を用意しておけば、10以上もの異なるアプリケーションの基盤になります。あるいは、望ましい PostgreSQL をセットアップしておけば、自分の将来のプロジェクトで再利用可能になるでしょう。このような使い方ができます。

.. Sharing. Docker has access to a public registry on Docker Hub where thousands of people have uploaded useful images: anything from Redis, CouchDB, PostgreSQL to IRC bouncers to Rails app servers to Hadoop to base images for various Linux distros. The registry also includes an official “standard library” of useful containers maintained by the Docker team. The registry itself is open-source, so anyone can deploy their own registry to store and transfer private containers, for internal server deployments for example.

* **共有** 。Docker は `Docker Hub <https://hub.docker.com/>`_ というパブリック・レジストリにアクセスします。そこでは数千人もの人たちが便利なイメージをアップロードしています。Redis 、 CouchDB 、PostgreSQL といったイメージから、IRC バウンサーや Rails アプリケーション・サーバや、Hadoop 向けや、様々なディストリビューション向けのベース・イメージがあります。また、公式の「標準ライブラリ（standard library）」には  :doc:`レジストリ </registry/index>` という名前の、Docker チームによって管理されている便利なコンテナがあります。レジストリ自身はオープンソースでアリ、誰もが自分自身でレジストリに対して、プライベートなコンテナの保管や転送が可能になります。例えば内部のサーバへデプロイすることも可能です。

.. Tool ecosystem. Docker defines an API for automating and customizing the creation and deployment of containers. There are a huge number of tools integrating with Docker to extend its capabilities. PaaS-like deployment (Dokku, Deis, Flynn), multi-node orchestration (Maestro, Salt, Mesos, Openstack Nova), management dashboards (docker-ui, Openstack Horizon, Shipyard), configuration management (Chef, Puppet), continuous integration (Jenkins, Strider, Travis), etc. Docker is rapidly establishing itself as the standard for container-based tooling.

* **ツールのエコシステム** 。Docker はコンテナの作成と開発のために、自動化・カスタマイズ化の API を定義しています。Docker を互換性のある非常に多くのツールと連携できます。PaaS 風のデプロイ（ Dokku、Deis、Flynn）、複数ノードのオーケストレーション（Maestro、Salt、Mesos、OpenStack Nova）、ダッシュボード管理（docker-ui、Openstack Horizon、Shipyard）、設定管理（Chef、Puppet）、継続的インテグレーション（Jenkins、Strider、travis）等です。コンテナを基盤としたツール標準として、Docker は自身を迅速に起動できます。

.. What is different between a Docker container and a VM?

.. _waht-is-different-between-a-docker-container-and-a-vm:

Docker コンテナと仮想マシンの違いは何ですか？
==================================================

.. There’s a great StackOverflow answer showing the differences.

StackOverflow の回答に、素晴らしい `違いについての説明 <http://stackoverflow.com/questions/16047306/how-is-docker-io-different-from-a-normal-virtual-machine>`_ があります。

.. Do I lose my data when the container exits?

コンテナを終了するとデータが失われますか？
==================================================

.. Not at all! Any data that your application writes to disk gets preserved in its container until you explicitly delete the container. The file system for the container persists even after the container halts.

コンテナのアプリケーションがディスクに書き込んだあらゆるデータは、コンテナを削除しない限りデータも削除されることはありません。コンテナを停止したとしても、コンテナのファイルシステムは一貫性を保ちます。

.. How far do Docker containers scale?

Docker コンテナは、どれだけスケールできますか？
==================================================

.. Some of the largest server farms in the world today are based on containers. Large web deployments like Google and Twitter, and platform providers such as Heroku and dotCloud all run on container technology, at a scale of hundreds of thousands or even millions of containers running in parallel

今日に世界中で大きなサーバ・ファームのいくつかは、コンテナを基盤としています。Google や Twitter のように大きなウェブのデプロイ環境や、Heroku や dotCloud のように全てをコンテナ技術上で実行します。これら数百から数千、もしくは数百万ものコンテナを並列で実行します。

.. How do I connect Docker containers?

Docker コンテナにどうやって接続しますか？
==================================================

.. Currently the recommended way to connect containers is via the Docker network feature. You can see details of how to work with Docker networks here.

現時点で推奨する方法は、Docker ネットワーク機能を通してコンテナに接続する方法です。詳細については :doc:`Docker ネットワークの働き </engine/userguide/networking/work-with-networks>` をご覧ください。

.. Also useful for more flexible service portability is the Ambassador linking pattern.

またサービスのポータビリティをフレキシブルにするには、 :doc:`アンバサダ・リンク・パターン </engine/admin/ambassador_pattern_linking>` も便利です。

.. How do I run more than one process in a Docker container?

Docker コンテナで複数のプロセスを実行するには？
==================================================

.. Any capable process supervisor such as http://supervisord.org/, runit, s6, or daemontools can do the trick. Docker will start up the process management daemon which will then fork to run additional processes. As long as the processor manager daemon continues to run, the container will continue to as well. You can see a more substantial example that uses supervisord here.

http://supervisord.org/ のようなスーパーバイザや、 runit 、 s6 、daemontools によって実現できます。Docker はプロセス管理用デーモンを起動し、その後、追加プロセスをフォークして実行します。プロセス管理デーモンが動く限り、コンテナも同様に動き続けます。具体的な例については、 :doc:`supervisord の使い方 </engine/admin/using_supervisord>` をご覧ください。

.. What platforms does Docker run on?

どのプラットフォーム上で Docker は動きますか？
==================================================

Linux:

* Ubuntu 12.04, 14.04 等
* Fedora 19/20+
* RHEL 6.5+
* CentOS 6+
* Gentoo
* ArchLinux
* openSUSE 12.3+
* CRUX 3.0+
* 等

Cloud:

* Amazon EC2
* Google Compute Engine
* Microsoft Azure
* Rackspace
* 等

.. How do I report a security issue with Docker?

Docker のセキュリティ問題はどこに報告したらよいですか？
============================================================

.. You can learn about the project’s security policy here and report security issues to this mailbox.

プロジェクトのセキュリティ・ポリシーについては `こちら <https://www.docker.com/security/>`_ から確認できます。セキュリティ問題については、こちらの `メールボックス <security@docker.com>`_ までお知らせください。

.. Why do I need to sign my commits to Docker with the DCO?

なぜ Docker の DCO で署名してからコミットする必要があるのでか？
======================================================================

.. Please read our blog post on the introduction of the DCO.

DCO (Developer's Certificate of Origin) については、 `こちらのブログ投稿 <http://blog.docker.com/2014/01/docker-code-contributions-require-developer-certificate-of-origin/>`_ をご覧ください。

.. When building an image, should I prefer system libraries or bundled ones?

イメージの構築時、望ましいシステムライブラリや同梱物はありますか？
======================================================================

.. This is a summary of a discussion on the docker-dev mailing list.

このディスカッションの詳細については `docker-dev メーリングリストの議論 <https://groups.google.com/forum/#!topic/docker-dev/L2RBSPDu1L0>`_ をご覧ください。

.. Virtually all programs depend on third-party libraries. Most frequently, they will use dynamic linking and some kind of package dependency, so that when multiple programs need the same library, it is installed only once.

全てのプログラムは擬似的に第三者のライブラリに依存しています。よくあるのは、動的なリンクや、ある種のパッケージ依存性です。そのため、複数のプログラムが同じライブラリを必要とするなら、インストールは一度で済みます。

.. Some programs, however, will bundle their third-party libraries, because they rely on very specific versions of those libraries. For instance, Node.js bundles OpenSSL; MongoDB bundles V8 and Boost (among others).

しかしながら、いくつかのプログラムは、特定バージョンのライブラリに依存するため、自分自身でサード・パーティー製のライブラリを同梱しています。例えば、Node.js は OpenSSL を同梱していますし、MongoDB は V8 と Boost （他にも）を同梱しています。

.. When creating a Docker image, is it better to use the bundled libraries, or should you build those programs so that they use the default system libraries instead?

Docker イメージの作成にあたり、ライブラリの同梱は使い易いものです。しかし、システム・ライブラリに含まれるデフォルトのものを使わず、自分自身でプログラムを構築すべきでしょうか？

.. The key point about system libraries is not about saving disk or memory space. It is about security. All major distributions handle security seriously, by having dedicated security teams, following up closely with published vulnerabilities, and disclosing advisories themselves. (Look at the Debian Security Information for an example of those procedures.) Upstream developers, however, do not always implement similar practices.

システム・ライブラリに関する重要なポイントは、ディスクやメモリ使用量の節約のためではありません。セキュリティのためなのです。全ての主要なディストリビューションは深刻なセキュリティを抱えています。そのため、専用のセキュリティ・チームを持ち、脆弱性が発見されれば対処を行い、一般に情報を開示します（これら手順の具体例は `Debian Security Information <https://www.debian.org/security/>`_ をご覧ください）。しかし、上流の開発者によっては、常に同じ手順が踏まれるわけではありません。

.. Before setting up a Docker image to compile a program from source, if you want to use bundled libraries, you should check if the upstream authors provide a convenient way to announce security vulnerabilities, and if they update their bundled libraries in a timely manner. If they don’t, you are exposing yourself (and the users of your image) to security vulnerabilities.

Docker イメージの構築時、ソースからプログラムを構築する前に、同梱したいライブラリがあるのであれば、上流の開発者がセキュリティの脆弱性に関する便利な情報を提供しているかどうか、彼らが適時ライブラリを更新するかどうか確認すべきです。彼らが対処しないならば、あなたが自分自身（そして、あなたのイメージの利用者）でセキュリティ脆弱性を対処することになります。

.. Likewise, before using packages built by others, you should check if the channels providing those packages implement similar security best practices. Downloading and installing an “all-in-one” .deb or .rpm sounds great at first, except if you have no way to figure out that it contains a copy of the OpenSSL library vulnerable to the Heartbleed bug.

他人によって作成されたパッケージを使う場合も同様です。パッケージに関するセキュリティのベスト・プラクティスと同様に、チャンネルが情報を提供しているか確認すべきでしょう。「全てが中に入っている」（all-in-one） .deb や .rpm のダウンロードとインストールをする場合、OpenSSLライブラリの脆弱性である `Heartbleed <http://heartbleed.com/>`_ バグを抱えているものをコピーされていないかどうか、それを確認する方法はありません。

.. Why is DEBIAN_FRONTEND=noninteractive discouraged in Dockerfiles?

なぜ Dockerfile で ``DEBIAN_FRONTEND=noninteractive`` なのですか？
======================================================================

.. When building Docker images on Debian and Ubuntu you may have seen errors like:

Docker イメージを Debian と Ubuntu 上で構築する時、次のようなエラーがでることがあります。

.. code-block:: bash

   unable to initialize frontend: Dialog

.. These errors don’t stop the image from being built but inform you that the installation process tried to open a dialog box, but was unable to. Generally, these errors are safe to ignore.

イメージの構築時、これらのエラーが出ても処理を中断しませんが、インストール時のプロセスでダイアログ・ボックスを表示しようとしても、実行できなかったという情報を表示しています。通常、これらのエラーは安全であり、無視して構いません。

.. Some people circumvent these errors by changing the DEBIAN_FRONTEND environment variable inside the Dockerfile using:

Dockerfile の中で環境変数 ``DEBIAN_FRONTEND`` を変更して使い、これらエラーの回避のために使っている方がいます。

.. code-block:: bash

   ENV DEBIAN_FRONTEND=noninteractive

.. This prevents the installer from opening dialog boxes during installation which stops the errors.

これはインストール時にダイアログ・ボックスを開こうとして、エラーがあっても停止しないようにします。

.. While this may sound like a good idea, it may have side effects. The DEBIAN_FRONTEND environment variable will be inherited by all images and containers built from your image, effectively changing their behavior. People using those images will run into problems when installing software interactively, because installers will not show any dialog boxes.

これは良い考えかもしれませんが、一方で影響がある *かも* しれません。 ``DEBIAN_FRONTEND`` 環境変数はイメージからコンテナを構築するにあたり、全てのイメージに対し変更設定が継承されます。対象のイメージを使おうとする人たちが、ソフトウェアをインタラクティブに設定する時に、インストーラは何らダイアログ・ボックスを表示しないため、問題が起こりうる場合があります。

.. Because of this, and because setting DEBIAN_FRONTEND to noninteractive is mainly a ‘cosmetic’ change, we discourage changing it.

このような状況のため、 ``DEBIAN_FRONTEND`` を ``noninteractive`` に指定するのは「お飾り」の変更であるため、私たちはこのような変更を *推奨しません* 。

.. If you really need to change its setting, make sure to change it back to its default value afterwards.

本等にこの値を変更する必要がある場合は、あとで `デフォルト値 <https://www.debian.org/releases/stable/i386/ch05s03.html.en>`_ に差し戻してください。

.. Why do I get Connection reset by peer when making a request to a service running in a container?

実行中のコンテナ上のサービスにリクエストを送ると ``Connection reset by peer`` が出るのはなぜ？
====================================================================================================

.. Typically, this message is returned if the service is already bound to your localhost. As a result, requests coming to the container from outside are dropped. To correct this problem, change the service’s configuration on your localhost so that the service accepts requests from all IPs. If you aren’t sure how to do this, check the documentation for your OS.

このメッセージが表示される主な理由は、サービスは既にローカルホスト上に結びついているからです。その結果、コンテナの外から届いたリクエストは破棄されます。この問題を解決するには、ローカルホスト上のサービスの設定を変更し、サービスが全ての IP アドレスからのリクエストを受け付けるようにします。この設定の仕方が分からなければ、各 OS のドキュメントをご覧ください。

.. Why do I get Cannot connect to the Docker daemon. Is the docker daemon running on this host? when using docker-machine?

docker-machine 利用時に ``Cannot connect to ....`` というエラーが出ます
================================================================================

.. This error points out that the docker client cannot connect to the virtual machine. This means that either the virtual machine that works underneath docker-machine is not running or that the client doesn’t correctly point at it.

エラー「Cannot connect to the Docker daemon. Is the docker daemon running on this host」が表示されるのは、Docker クライアントが仮想マシンに接続できない時です。つまり、 ``docker-machine`` 配下で動く仮想マシンが動作していないか、クライアントが操作時点でマシンを適切に参照できない場合を表します。

.. To verify that the docker machine is running you can use the docker-machine ls command and start it with docker-machine start if needed.

``docker-machine ls`` コマンドを使って docker マシンが動作しているかどうかを各西、必要があれば ``docker-machine start`` コマンドで起動します。

.. code-block:: bash

   $ docker-machine ls
   NAME             ACTIVE   DRIVER       STATE     URL   SWARM                   DOCKER    ERRORS
   default          -        virtualbox   Stopped                                 Unknown
   
   $ docker-machine start default

.. You have to tell Docker to talk to that machine. You can do this with the docker-machine env command. For example,

Docker クライアントはマシンと通信する必要があります。これには ``docker-machine env`` コマンドを使います。実行例：

.. code-block:: bash

   $ eval "$(docker-machine env default)"
   $ docker ps

他にも答えを探せますか？
==============================

.. You can find more answers on:

以下からも答えを探せます。

* `Docker user mailinglist <https://groups.google.com/d/forum/docker-user>`_
* `Docker developer mailinglist <https://groups.google.com/d/forum/docker-dev>`_
* `IRC, docker on freenode <irc://chat.freenode.net#docker>`_
* `GitHub <https://github.com/docker/docker>`_
* `Ask questions on Stackoverflow <http://stackoverflow.com/search?q=docker>`_
* `Join the conversation on Twitter <http://twitter.com/docker>`_

.. Looking for something else to read? Checkout the User Guide.

他にもお探しですか？ :doc:`ユーザ・ガイド </engine/userguide/index>` をご覧ください。


.. seealso:: 
   Frequently Asked Questions (FAQ)
      https://docs.docker.com/engine/faq/

