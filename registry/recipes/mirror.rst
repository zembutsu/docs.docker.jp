.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/registry/recipes/mirror/
.. SOURCE: -
   doc version: 1.10
.. check date: 2016/03/12
.. -------------------------------------------------------------------

.. Registry as a pull through cache

.. _registry-as-a-pull-through-cache:

========================================
Docker Hub のミラーリング
========================================

.. Use-case

使用例
==========

.. If you have multiple instances of Docker running in your environment (e.g., multiple physical or virtual machines, all running the Docker daemon), each time one of them requires an image that it doesn’t have it will go out to the internet and fetch it from the public Docker registry. By running a local registry mirror, you can keep most of the redundant image fetch traffic on your local network.

皆さんの環境に、複数の Docker を動かすインスタンスがあると仮定します（例：Docker デーモンが複数の物理マシンあるいは仮想マシン上で動作）。イメージを使おうにも、どちらも毎回パブリックな Docker レジストリ（Docker Hub）から取得しなくてはいけません。ローカルにレジストリのミラーを設置することで、ローカルネットワーク上でイメージ取得により発生するトラフィックを抑制できるでしょう。

.. Alternatives

あるいは
----------

.. Alternatively, if the set of images you are using is well delimited, you can simply pull them manually and push them to a simple, local, private registry.

あるいは、頻繁に使うイメージ群がありませんでしょうか。単純にそれをローカル上のプライベートなレジストリから取得することも可能です。

.. Furthermore, if your images are all built in-house, not using the Hub at all and relying entirely on your local registry is the simplest scenario.

それ以外にも、イメージは Docker Hub にあるものではなく、全てが自家製の場合もあるでしょう。そのような場合、単純にローカルにあるレジストリでイメージを管理したいと思いませんか。これが最も簡単なシナリオです。

.. Gotcha

捕捉
----------

.. It’s currently not possible to mirror another private registry. Only the central Hub can be mirrored.

現時点では、特定のプライベート・レジストリをミラーする機能がありません。Docker Hub のみミラー可能です。

.. Solution

解決策
----------

.. The Registry can be configured as a pull through cache. In this mode a Registry responds to all normal docker pull requests but stores all content locally.

レジストリは pull （イメージの取得）時、キャッシュするように設定可能です。このモードでは Registry は通常の全ての docker pull に応答し、全てのイメージをローカルに保管します。

.. How does it work?

どうしますか？
====================

.. The first time you request an image from your local registry mirror, it pulls the image from the public Docker registry and stores it locally before handing it back to you. On subsequent requests, the local registry mirror is able to serve the image from its own storage.

ローカルのレジストリ・ミラーに対して初めてイメージのリクエストがあると、Registry はパブリック Docker レジストリ（Docker Hub）からイメージを取得し、ローカルに保管した後、そのイメージを返します。引き続きリクエストがあれば、ローカルのレジストリ・ミラーは自分自身の保存領域からイメージのデータを提供します。

.. What if the content changes on the Hub?

Docker Hub のイメージ内容が変わったら？
----------------------------------------

.. When a pull is attempted with a tag, the Registry will check the remote to ensure if it has the latest version of the requested content. If it doesn’t it will fetch the latest content and cache it.

イメージの pull 時にタグを付けると、Registry はリモートの Docker Hub 上の最新版と内容が一致するかどうか確認します。もし一致しなければ、最新版の内容を取得し、ローカルにキャッシュします。

.. What about my disk?

ディスクはどうですか？
------------------------------

.. In environments with high churn rates, stale data can build up in the cache. When running as a pull through cache the Registry will periodically remove old content to save disk space. Subsequent requests for removed content will cause a remote fetch and local re-caching.

利用頻度が高い環境では、古いデータがキャッシュとして残り続けるかもしれません。Registry にキャッシュしているデータを取得して利用している場合、ディスク容量を節約するため、定期的に古いデータを削除したほうが良いでしょう。キャッシュしているデータを消したとしても、またリクエストがあればリモートから取得し、再度キャッシュ化します。

.. To ensure best performance and guarantee correctness the Registry cache should be configured to use the filesystem driver for storage.

Registry のベストなパフォーマンスやキャッシュの正常性を確保するには、ストレージに ``filesystem`` ドライバを使うべきでしょう。

.. Running a Registry as a pull through cache

Registry のキャッシュを通して実行する
========================================

.. The easiest way to run a registry as a pull through cache is to run the official Registry image.

Registry を通してキャッシュしたイメージを取得できるようにするには、公式 Registry イメージを実行する方法が最も簡単です。

.. Multiple registry caches can be deployed over the same back-end. A single registry cache will ensure that concurrent requests do not pull duplicate data, but this property will not hold true for a registry cache cluster.

おなじバックエンド上に複数の Registry キャッシュをデプロイ可能です。１つめの Registry はリクエストを処理するだけでデータを取得しません。他の Registry のキャッシュ・クラスタが適切にデータを取り扱います。

.. Configuring the cache

キャッシュの設定
--------------------

.. To configure a Registry to run as a pull through cache, the addition of a proxy section is required to the config file.

Registry が取得（pull）する時、キャッシュを通すように設定します。設定ファイルに ``proxy`` セクションを追加する必要があります。

.. In order to access private images on the Docker Hub, a username and password can be supplied.

Docker Hub のプライベート・イメージにアクセスが必要であれば、ユーザ名とパスワードも指定できます。

::

   proxy:
     remoteurl: https://registry-1.docker.io
     username: [username]
     password: [password]

..    :warn: if you specify a username and password, it’s very important to understand that private resources that this user has access to on the Hub will be made available on your mirror. It’s thus paramount that you secure your mirror by implementing authentication if you expect these resources to stay private!

.. warning::

   ユーザ名とパスワードを指定するときは、プライベート・リソースに対する理解が非常に重要です。ユーザはあなたのミラーを通して Docker Hub のイメージにアクセス可能になります。そのため、リソースの非公開を保つために、ミラーに認証を取り入れるなど、安全を保つことが非常に重要です。

.. Configuring the Docker daemon

Docker デーモン・オプションの設定
----------------------------------------

.. You will need to pass the --registry-mirror option to your Docker daemon on startup:

Docker デーモンの起動時に ``--registry-mirror`` オプションを指定する必要があります。

.. code-block:: bash

   docker --registry-mirror=https://<my-docker-mirror-host> daemon

.. For example, if your mirror is serving on http://10.0.0.2:5000, you would run:

例えば、 http://10.0.0.2:5000 をミラーとして使いたい場合は、次のように実行します。

.. code-block:: bash

   docker --registry-mirror=https://10.0.0.2:5000 daemon

.. NOTE: Depending on your local host setup, you may be able to add the --registry-mirror option to the DOCKER_OPTS variable in /etc/default/docker.

.. note::

   どのようにセットアップするかは、ローカルホスト上の設定に依存します。環境によっては ``/etc/default/docker`` の ``DOCKER_OPTS`` 環境変数に ``--registry-mirror`` を追加します。

.. seealso:: 

   Registry as a pull through
      https://docs.docker.com/registry/nginx/
