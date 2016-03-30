.. -*- coding: utf-8 -*-
.. https://docs.docker.com/registry/introduction/
.. doc version: 1.9
.. check date: 2016/01/08

.. Understanding the Registry

.. _understanding-the-registry:

========================================
Docker レジストリ の理解
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. A registry is a storage and content delivery system, holding named Docker images, available in different tagged versions.

レジストリ（registry）とは、ストレージとコンテント配送システムであり、Docker イメージの名前を異なったタグを付けられたバージョンで保持します。

..    Example: the image distribution/registry, with tags 2.0 and 2.1.

.. note::

   イメージ ``distribution/registry`` には ``2.0`` と ``2.1`` のタグがあります。

.. Users interact with a registry by using docker push and pull commands.

ユーザは docker push と pull コマンドを使い、レジストリを通信できます。

..    Example: docker pull registry-1.docker.io/distribution/registry:2.1.

.. note::

   例： ``docker pull registry-1.docker.io/distribution/registry:2.1.``

.. Storage itself is delegated to drivers. The default storage driver is the local posix filesystem, which is suitable for development or small deployments. Additional cloud-based storage drivers like S3, Microsoft Azure, Ceph Rados, OpenStack Swift and Aliyun OSS are also supported. People looking into using other storage backends may do so by writing their own driver implementing the Storage API.

ストレージは自身のドライバに依存します。デフォルトのストレージ・ドライバはローカル posix ファイルシステムであり、開発や小さな環境で扱い易いです。S3、Microsoft Azure、Ceph Rados、OpenStack Swift、Aliyun OSS のようなクラウド・ベースのストレージをサポートしています。他のストレージ用のバックエンドを探しているのであれば、自分自身でドライバを実装するための :doc:`ストレージ API <storagedrivers>` をご覧ください。

.. Since securing access to your hosted images is paramount, the Registry natively supports TLS and basic authentication.

保管されているイメージに対するアクセスのセキュリティを最高にするため、レジストリは TLS と基本認証をネイティブにサポートしています。

.. The Registry GitHub repository includes additional information about advanced authentication and authorization methods. Only very large or public deployments are expected to extend the Registry in this way.

レジストリの GitHub レポジトリには、高度な認証や認証手法に関する情報があります。そこでの手法を使えば、とても大きな、あるいはパブリックへのデプロイといった拡張が期待ｄけいるでしょう。

.. Finally, the Registry ships with a robust notification system, calling webhooks in response to activity, and both extensive logging and reporting, mostly useful for large installations that want to collect metrics.

あとは、レジストリには堅牢な :doc:`notifications` 通知システムを提供しており、何らかの動作に対応してウェブフックの呼び出しや、ログ記録やレポートの拡張、大規模な環境からのメトリックを収集を簡単にします。

.. Understanding image naming

.. _understanding-image-naming:

イメージの名前付けを理解
==============================

.. Image names as used in typical docker commands reflect their origin:

典型的な docker コマンドで用いられるイメージ名には、起点（origin）を反映します。

..    docker pull ubuntu instructs docker to pull an image named ubuntu from the official Docker Hub. This is simply a shortcut for the longer docker pull docker.io/library/ubuntu command
..    docker pull myregistrydomain:port/foo/bar instructs docker to contact the registry located at myregistrydomain:port to find the image foo/bar

* ``docker pull ubuntu`` 命令は、公式の Docker Hub から ``ubuntu`` という名称のイメージを取得します。これは、長い ``docker pull docker.io/library/ubuntu`` コマンドを短くしたものです。
* ``docker pull myregistrydomain:port/foo/bar`` は、docker に対して ``myregistrydomain:port`` にあるレジストリで ``foo/bar`` というイメージを探すための命令です。

.. You can find out more about the various Docker commands dealing with images in the official Docker engine documentation.

Docker がイメージをやりとりするコマンドの詳細については、 :doc:`公式の Docker engine ドキュメント </reference/commandline/cli>` をご覧ください。

.. Use cases

.. _registry-use-cases:

使用例
==========

.. Running your own Registry is a great solution to integrate with and complement your CI/CD system. In a typical workflow, a commit to your source revision control system would trigger a build on your CI system, which would then push a new image to your Registry if the build is successful. A notification from the Registry would then trigger a deployment on a staging environment, or notify other systems that a new image is available.

自分自身のレジストリを CI/CD システムと統合・補完することは良い使い方です。典型的なワークフローは、ソースのリビジョン管理システムにコミットすると、それをトリガとして CI システムで構築を開始し、構築が成功するとレジストリに対して新しいイメージを送信します。レジストリからの通知によって、ステージング環境へのデプロイや、他のシステムに対して新しいイメージが利用できるようになったと伝えることも可能です。

.. It’s also an essential component if you want to quickly deploy a new image over a large cluster of machines.

あるいは、新しいイメージを大規模なクラスタ上のマシンに迅速に展開するだけのコンポーネントとしても使えます。

.. Finally, it’s the best way to distribute images inside an isolated network.

他には、隔離されたネットワークにおいて、イメージを配布するのにも良い方法でしょう。

.. Requirements

.. _registry-requirements:

動作条件
==========

.. You absolutely need to be familiar with Docker, specifically with regard to pushing and pulling images. You must understand the difference between the daemon and the cli, and at least grasp basic concepts about networking.

Docker に完全に慣れ親しんでいる必要があります。特にイメージの送信と取得に関してです。そして、デーモンと CLI の違いについての理解も必要ですし、少なくとも基本的なネットワーク機能については掴んでおく必要があります。

.. Also, while just starting a registry is fairly easy, operating it in a production environment requires operational skills, just like any other service. You are expected to be familiar with systems availability and scalability, logging and log processing, systems monitoring, and security 101. Strong understanding of http and overall network communications, plus familiarity with golang are certainly useful as well for advanced operations or hacking.

また、レポジトリの作成をかなり簡単に行えるようにしていますが、プロダクション環境においては他のサービスと同じように運用スキルが必要です。システムの可用性、スケーラビリティ、ログ記録とログ設定、システム群のモニタリング、セキュリティなどにも慣れている必要があります。高度な運用やハッキングには、http に対する高い理解と、ネットワーク通信全般の理解に加え、Go 言語に慣れているのが望ましいでしょう。

.. Next

次へ
==========

.. Dive into deploying your registry

:doc:`レジストリのデプロイ <deploying>` に進みましょう。

