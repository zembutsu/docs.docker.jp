.. -*- coding: utf-8 -*-
.. https://docs.docker.com/docker-hub/official_repos/
.. doc version: 1.9
.. check date: 2016/01/08

.. Official Repositories on Docker Hub

.. _official-repositories-on-docker-hub:

========================================
Docker Hub 上の公式レポジトリ
========================================

.. The Docker Official Repositories are a curated set of Docker repositories that are promoted on Docker Hub. They are designed to:

`公式レポジトリ（Official Repositories） <http://registry.hub.docker.com/official>`_ とは、Docker Hub 上でプロモートされている Docker レポジトリの集まりです。これらは次のように設計されています。

..    Provide essential base OS repositories (for example, ubuntu, centos) that serve as the starting point for the majority of users.

* 必要不可欠なベース OS レポジトリ（例： `ubuntu <https://hub.docker.com/_/ubuntu/>`_ 、 `centos <https://hub.docker.com/_/centos/>`_ ）を提供し、多くのユーザにとっての開始点となるものです。

..    Provide drop-in solutions for popular programming language runtimes, data stores, and other services, similar to what a Platform-as-a-Service (PAAS) would offer.

* 有名なプログラミング言語、データ・ストア、他のサービス、プラットフォーム・アス・ア・サービス（PaaS）のような、各種ソリューションの集まりを提供します。

..    Exemplify Dockerfile best practices and provide clear documentation to serve as a reference for other Dockerfile authors.

* ``Dockerfile`` の :doc:`ベスト・プラクティス </engine/articles/dockerfile_best-practice>` を提示し、他の ``Dockerfile`` 著者のリファレンスを提供します。

..    Ensure that security updates are applied in a timely manner. This is particularly important as many Official Repositories are some of the most popular on Docker Hub.

* 適時セキュリティ・アップデートを確実に提供します。特に、Docker Hub 上の多く有名な公式レポジトリにとって重要です。

..    Provide a channel for software vendors to redistribute up-to-date and supported versions of their products. Organization accounts on Docker Hub can also serve this purpose, without the careful review or restrictions on what can be published.

* ソフトウェア・ベンダにとって、更新やプロダクトのサポート・バージョンを配布するチャンネルを提供します。Docker Hub 上の Organization アカウントも同様の役割を提供できますが、こちらは何が公開されるかの注意深いレビューや規約がありません。

.. Docker, Inc. sponsors a dedicated team that is responsible for reviewing and publishing all Official Repositories content. This team works in collaboration with upstream software maintainers, security experts, and the broader Docker community.

Docker 社は、全ての公式レポジトリの内容に関し、レビューと公開に責任を持つ専用チームを提供しています。このチームは、上流のソフトウェア・メンテナ、セキュリティ専門家、幅広い Docker コミュニティと協調しています。

.. While it is preferrable to have upstream software authors maintaining their corresponding Official Repositories, this is not a strict requirement. Creating and maintaining images for Official Repositories is a public process. It takes place openly on GitHub where participation is encouraged. Anyone can provide feedback, contribute code, suggest process changes, or even propose a new Official Repository.

上流のソフトウェア作者が対応する公式レポジトリのメンテナンスにあたり、その優先度を厳密に要求していません。公式レポジトリのイメージ作成・管理は公開されたプロセスです。これらは GitHub 上で展開されています。誰でもフィードバック、コードの貢献、プロセス変更の提案、あるいは新しい公式レポジトリの提案も可能です。

.. Should I use Official Repositories?

.. _should-i-use-official-repositories:

公式レポジトリを使うべきですか？
==================================

.. New Docker users are encouraged to use the Official Repositories in their projects. These repositories have clear documentation, promote best practices, and are designed for the most common use cases. Advanced users are encouraged to review the Official Repositories as part of their Dockerfile learning process.

新しい Docker ユーザにとって、各プロジェクトの公式レポジトリは励みになります。これらのレポジトリには、明確なドキュメントがあり、ベスト・プラクティスを提供し、そして、一般的な利用例のために設計されています。高度なユーザにとっては公式レポジトリにある ``Dockerfile`` が学習プロセスにおいて役立つでしょう。

.. A common rationale for diverging from Official Repositories is to optimize for image size. For instance, many of the programming language stack images contain a complete build toolchain to support installation of modules that depend on optimized code. An advanced user could build a custom image with just the necessary pre-compiled libraries to save space.

公式レポジトリからの分岐は、一般的にイメージ容量の最適化が求められます。例えば、多くのプログラミング言語か重ねられたイメージで、モジュールのインストールをサポートしているツールチェーンを構築するのは、コードの最適化に依存します。高度なユーザであれば、コンパイル済みの必要なライブラリのみのイメージを構築することで、容量を節約できます。

.. A number of language stacks such as python and ruby have -slim tag variants designed to fill the need for optimization. Even when these “slim” variants are insufficient, it is still recommended to inherit from an Official Repository base OS image to leverage the ongoing maintenance work, rather than duplicating these efforts.

`python <https://hub.docker.com/_/python/>`_ と `ruby <https://hub.docker.com/_/ruby/>`_ のように、いくつかの言語スタックは ``-slim`` タグを持っており、これら最適化のために異なった形で設計されています。「slim」派生だけでは不十分なため、公式レポジトリをベースとした OS イメージからの継承を推奨します。これはメンテナンスの継続を重複して行うよりも効果的だからです。

.. How can I get involved?

.. _how-can-i-get-involved:

私が改良できますか？
====================

.. All Official Repositories contain a User Feedback section in their documentation which covers the details for that specific repository. In most cases, the GitHub repository which contains the Dockerfiles for an Official Repository also has an active issue tracker. General feedback and support questions should be directed to #docker-library on Freenode IRC.

公式レポジトリには、ドキュメントには **User Feedback** （ユーザ・フィードバック）セクションがあり、対象のレポジトリに関する詳細を扱います。多くの場合、GitHub レポジトリには公式レポジトリの Dockerfile が含まれています。また、issue トラッカーも利用できます。一般的なフィードバックとサポートの質問は、Freenode IRC 上の ``#docker-library`` で直接行うべきです。

.. How do I create a new Official Repository?

.. how-do-i-create-a-new-official-repository:

私が新しい公式レポジトリを作成できますか？
==================================================

.. From a high level, an Official Repository starts out as a proposal in the form of a set of GitHub pull requests. You’ll find detailed and objective proposal requirements in the following GitHub repositories:

上位の手法としては、GitHub におけるプルリクエストの提案によって、公式レポジトリが動き出します。以下の GitHub レポジトリで詳細や提案に必要なものが確認できます。

..    docker-library/official-images
..    docker-library/docs

* `docker-library/official-images <https://github.com/docker-library/official-images>`_

* `docker-library/docs <https://github.com/docker-library/docs>`_

.. The Official Repositories team, with help from community contributors, formally review each proposal and provide feedback to the author. This initial review process may require a bit of back and forth before the proposal is accepted.

公式レポジトリ・チームは、コミュニティのコントリビュータの助けにより、作者に対して提案やフィードバックを公式に提供します。この初期レビュー・プロセスには、提案が承認されるまでに行ったり来たりすることがあります。

.. There are also subjective considerations during the review process. These subjective concerns boil down to the basic question: “is this image generally useful?” For example, the python Official Repository is “generally useful” to the large Python developer community, whereas an obscure text adventure game written in Python last week is not.

また、レビューのプロセス中では主観的な判断も含まれます。主観的な事項は、基本的な質問で煮詰めます「このイメージは一般的に使いやすいだろうか？」　たとえば `python <https://hub.docker.com/_/python/>`_ 公式レポジトリでは、大きな Python 開発コミュニティにとって「一般的に使いやすいか」です。これが先週 Python で書かれた無名のアドベンチャー・ゲームだとしてもです。

.. When a new proposal is accepted, the author becomes responsibile for keeping their images up-to-date and responding to user feedback. The Official Repositories team becomes responsibile for publishing the images and documentation on Docker Hub. Updates to the Official Repository follow the same pull request process, though with less review. The Official Repositories team ultimately acts as a gatekeeper for all changes, which helps mitigate the risk of quality and security issues from being introduced.

新しい提案が承認されると、作者はイメージの更新やユーザのフィードバック対応の継続に対する責任があります。公式レポジトリ・チームはイメージの配布と Docker Hub 上のドキュメントに対する責任があります。公式レポジトリの更新にあたり、複数のプルリクエストはレビューの少ないプロセスを辿ることもあるでしょう。公式レポジトリチームは、全ての変更に対して最終的に対応する門番です。公式レポジトリチームが、品質に対するリスクやセキュリティ問題が発生しないよう助力します。

..    Note: If you are interested in proposing an Official Repository, but would like to discuss it with Docker, Inc. privately first, please send your inquiries to partners@docker.com. There is no fast-track or pay-for-status option.

.. note::

   もし公式レポジトリの提案に興味があるとき、まず Docker 社とプライベートに議論したい場合は、リクエストを partners@docker.com にお送りください。ただし、迅速ではありませんし、支払いオプションもありません。
