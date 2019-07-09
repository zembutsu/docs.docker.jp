.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-hub/official_repos/
.. SOURCE: -
   doc version: 1.10
.. check date: 2016/03/11
.. -------------------------------------------------------------------

.. Official Repositories on Docker Hub

.. _official-repositories-on-docker-hub:

========================================
Docker Hub 上の公式リポジトリ
========================================

.. The Docker [Official Repositories](https://hub.docker.com/official/) are a
   curated set of Docker repositories that are promoted on Docker Hub. They are
   designed to:

Docker の `公式イメージ <https://hub.docker.com/search?q=&type=image&image_filter=official>`_ は Docker Hub 上において提供される、厳選された Docker リポジトリです。
これは以下のことを意識して提供されています。

.. * Provide essential base OS repositories (for example,
     [ubuntu](https://hub.docker.com/_/ubuntu/),
     [centos](https://hub.docker.com/_/centos/)) that serve as the
     starting point for the majority of users.

* 基本的なベース OS となるリポジトリを提供します。
  （たとえば `ubuntu <https://hub.docker.com/_/ubuntu/>`_ , `centos <https://hub.docker.com/_/centos/>`_ などのように）数多くのユーザにとってスタート地点となるものです。

.. * Provide drop-in solutions for popular programming language runtimes, data
     stores, and other services, similar to what a Platform-as-a-Service (PAAS)
     would offer.

* 代表的なプログラミング言語環境、データストア、各種サービスといった、PAAS（Platform-as-a-Service）が提供するものにも似た、一時的な実現環境を提供します。

.. * Exemplify [`Dockerfile` best practices](/engine/userguide/eng-image/dockerfile_best-practices/)
     and provide clear documentation to serve as a reference for other `Dockerfile`
     authors.

* ``Dockerfile`` の :doc:`ベスト・プラクティス </engine/userguide/eng-image/dockerfile_best-practices/>`  の例として示し、わかりやすいドキュメントを提供します。
  これによって ``Dockerfile`` を作成する際のリファレンスとなるようにします。

.. * Ensure that security updates are applied in a timely manner. This is
     particularly important as many Official Repositories are some of the most
     popular on Docker Hub.

* 適切なタイミングでセキュリティ・アップデートを適用するようにします。
  これは特に重要なことです。
  Docker Hub 上における公式イメージは、人気を得ているものが数多くあるからです。

.. * Provide a channel for software vendors to redistribute up-to-date and
     supported versions of their products. Organization accounts on Docker Hub can
     also serve this purpose, without the careful review or restrictions on what
     can be published.

* ソフトウェア・ベンダに対して、製品の最新版や正規版を配布するチャネルとして提供します。
  Docker Hub における組織（organization）アカウントもこの目的で利用することができます。
  このアカウントを用いるのであれば、公開しようとするものに対して十分な検証がなくても、また制約を設けなくても、気楽に提供できます。

.. Docker, Inc. sponsors a dedicated team that is responsible for reviewing and
   publishing all Official Repositories content. This team works in collaboration
   with upstream software maintainers, security experts, and the broader Docker
   community.

Docker 社としては、公式イメージに関わるさまざまな内容に関して、レビューと公開を担当する専門チームを支援しています。
このチームは、ソフトウェア開発元の保守担当、セキュリティ専門家、Docker コミュニティの幅広い方々と共同して作業を進めています。

.. While it is preferable to have upstream software authors maintaining their
   corresponding Official Repositories, this is not a strict requirement. Creating
   and maintaining images for Official Repositories is a public process. It takes
   place openly on GitHub where participation is encouraged. Anyone can provide
   feedback, contribute code, suggest process changes, or even propose a new
   Official Repository.

ソフトウェア開発者が、担当している公式イメージを保守することが好ましいのは言うまでもありません。
しかしこれを厳密に要求することはしていません。
そもそも公式イメージを生成して保守していくことは、公開で行われている作業です。
GitHub 上にて公開で行われているため、そこに参加することが大いに推奨されています。
どなたであっても、フィードバック、コード提供、プロセス変更の提案、さらには新たな公式イメージの提案までもが提供できるわけです。


.. ## Should I use Official Repositories?

.. _should-i-use-official-repositories:

公式リポジトリを使うべきですか？
==================================

.. New Docker users are encouraged to use the Official Repositories in their
   projects. These repositories have clear documentation, promote best practices,
   and are designed for the most common use cases. Advanced users are encouraged to
   review the Official Repositories as part of their `Dockerfile` learning process.

Docker を初めて利用するユーザは、公式イメージを用いてプロジェクトを構築することをお勧めしています。
このイメージには分かり易いドキュメントがあって、ベストプラクティスを示しています。
そして一般的な利用を前提にして設計されています。
上級者の方は ``Dockerfile`` を勉強する一環として、公式イメージをレビューしていただくことをお願いします。

.. A common rationale for diverging from Official Repositories is to optimize for image size. For instance, many of the programming language stack images contain a complete build toolchain to support installation of modules that depend on optimized code. An advanced user could build a custom image with just the necessary pre-compiled libraries to save space.

公式リポジトリからの分岐は、一般的にイメージ容量の最適化が求められます。例えば、多くのプログラミング言語か重ねられたイメージで、モジュールのインストールをサポートしているツールチェーンを構築するのは、コードの最適化に依存します。高度なユーザであれば、コンパイル済みの必要なライブラリのみのイメージを構築することで、容量を節約できます。

.. A number of language stacks such as python and ruby have -slim tag variants designed to fill the need for optimization. Even when these “slim” variants are insufficient, it is still recommended to inherit from an Official Repository base OS image to leverage the ongoing maintenance work, rather than duplicating these efforts.

`python <https://hub.docker.com/_/python/>`_ と `ruby <https://hub.docker.com/_/ruby/>`_ のように、いくつかの言語スタックは ``-slim`` タグを持っており、これら最適化のために異なった形で設計されています。「slim」派生だけでは不十分なため、公式リポジトリをベースとした OS イメージからの継承を推奨します。これはメンテナンスの継続を重複して行うよりも効果的だからです。

.. How can I get involved?

.. _how-can-i-get-involved:

私が改良できますか？
====================

.. All Official Repositories contain a User Feedback section in their documentation which covers the details for that specific repository. In most cases, the GitHub repository which contains the Dockerfiles for an Official Repository also has an active issue tracker. General feedback and support questions should be directed to #docker-library on Freenode IRC.

公式リポジトリには、ドキュメントには **User Feedback** （ユーザ・フィードバック）セクションがあり、対象のリポジトリに関する詳細を扱います。多くの場合、GitHub リポジトリには公式リポジトリの Dockerfile が含まれています。また、issue トラッカーも利用できます。一般的なフィードバックとサポートの質問は、Freenode IRC 上の ``#docker-library`` で直接行うべきです。

.. How do I create a new Official Repository?

.. how-do-i-create-a-new-official-repository:

私が新しい公式リポジトリを作成できますか？
==================================================

.. From a high level, an Official Repository starts out as a proposal in the form of a set of GitHub pull requests. You’ll find detailed and objective proposal requirements in the following GitHub repositories:

上位の手法としては、GitHub におけるプルリクエストの提案によって、公式リポジトリが動き出します。以下の GitHub リポジトリで詳細や提案に必要なものが確認できます。

..    docker-library/official-images
..    docker-library/docs

* `docker-library/official-images <https://github.com/docker-library/official-images>`_

* `docker-library/docs <https://github.com/docker-library/docs>`_

.. The Official Repositories team, with help from community contributors, formally review each proposal and provide feedback to the author. This initial review process may require a bit of back and forth before the proposal is accepted.

公式リポジトリ・チームは、コミュニティのコントリビュータの助けにより、作者に対して提案やフィードバックを公式に提供します。この初期レビュー・プロセスには、提案が承認されるまでに行ったり来たりすることがあります。

.. There are also subjective considerations during the review process. These subjective concerns boil down to the basic question: “is this image generally useful?” For example, the python Official Repository is “generally useful” to the large Python developer community, whereas an obscure text adventure game written in Python last week is not.

また、レビューのプロセス中では主観的な判断も含まれます。主観的な事項は、基本的な質問で煮詰めます「このイメージは一般的に使いやすいだろうか？」　たとえば `python <https://hub.docker.com/_/python/>`_ 公式リポジトリでは、大きな Python 開発コミュニティにとって「一般的に使いやすいか」です。これが先週 Python で書かれた無名のアドベンチャー・ゲームだとしてもです。

.. When a new proposal is accepted, the author becomes responsibile for keeping their images up-to-date and responding to user feedback. The Official Repositories team becomes responsibile for publishing the images and documentation on Docker Hub. Updates to the Official Repository follow the same pull request process, though with less review. The Official Repositories team ultimately acts as a gatekeeper for all changes, which helps mitigate the risk of quality and security issues from being introduced.

新しい提案が承認されると、作者はイメージの更新やユーザのフィードバック対応の継続に対する責任があります。公式リポジトリ・チームはイメージの配布と Docker Hub 上のドキュメントに対する責任があります。公式リポジトリの更新にあたり、複数のプルリクエストはレビューの少ないプロセスを辿ることもあるでしょう。公式リポジトリチームは、全ての変更に対して最終的に対応する門番です。公式リポジトリチームが、品質に対するリスクやセキュリティ問題が発生しないよう助力します。

..    Note: If you are interested in proposing an Official Repository, but would like to discuss it with Docker, Inc. privately first, please send your inquiries to partners@docker.com. There is no fast-track or pay-for-status option.

.. note::

   もし公式リポジトリの提案に興味があるとき、まず Docker 社とプライベートに議論したい場合は、リクエストを partners@docker.com にお送りください。ただし、迅速ではありませんし、支払いオプションもありません。


.. seealso:: 

   Official Repositories on Docker Hub
      https://docs.docker.com/docker-hub/official_repos/
