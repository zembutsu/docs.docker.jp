.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/push/
.. SOURCE:
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/push.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_push.yaml
.. check date: 2022/03/21
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker push

=======================================
docker push
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_push-description:

説明
==========

.. Push an image or a repository to a registry

レジストリにイメージやリポジトリを :ruby:`送信 <pushl>` します。

.. _docker_push-usage:

使い方
==========

.. code-block:: bash

   $ docker push [OPTIONS] NAME[:TAG]

.. Extended description
.. _docker_push-extended-description:

補足説明
==========

.. Use docker image push to share your images to the Docker Hub registry or to a self-hosted one.

``docker push`` を使うと、イメージを `Docker Hub <https://hub.docker.com/>`_ レジストリや、自分で作成したレジストリで共有できるようになります。

.. Refer to the docker image tag reference for more information about valid image and tag names.

有効なイメージ名とタグ名についての詳しい情報は、 :doc:`docker image tag <tag>` リファレンスを参照してください。

.. Killing the docker image push process, for example by pressing CTRL-c while it is running in a terminal, terminates the push operation.

``docker image push`` プロセスを停止するには、ターミナルで実行中に ``CTRL-c`` を押すと、push 処理を中断します。

.. Progress bars are shown during docker push, which show the uncompressed size. The actual amount of data that’s pushed will be compressed before sending, so the uploaded size will not be reflected by the progress bar.

docker push 中に表示する :ruby:`プログレス・バー <progress bar>` （進捗状況を表示）は、非圧縮の容量を示します。実際のデータは、送信前に圧縮しますので、アップロード済み容量がプレグレス・バーに反映しない場合があります。

.. Registry credentials are managed by docker login.

レジストリの認証情報は :doc:`docker login <login>` で管理します。

.. Concurrent uploads

.. _docker_push-concurrent-upload:
並列アップロード
--------------------

.. By default the Docker daemon will push five layers of an image at a time. If you are on a low bandwidth connection this may cause timeout issues and you may want to lower this via the --max-concurrent-uploads daemon option. See the daemon documentation for more details.

デフォルトの Docker デーモンは、同時に5つのイメージレイヤを送信します。ネットワーク帯域幅が狭くてタイムアウトを引き起こす場合は、デーモンのオプション ``--max-concurrent-uploads`` によって、この数を減らせます。詳細は :doc:`デーモンのドキュメント <dockerd>` をご覧ください。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_push-examples>` をご覧ください。

.. _docker_push-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--all-tags`` , ``-a``
     - 
     - レポジトリにあるタグ付きイメージを全て送信
   * - ``--disable-content-trust``
     - ``true``
     - イメージ検証を省略
   * - ``--quiet`` , ``-q``
     - 
     - 冗長な出力をしない

.. Examples
.. _docker_push-examples:

使用例
==========

.. Push a new image to a registry
.. _docker_push-push-a-new-image-to-a-registry:
新しいイメージをレジストリに :ruby:`送信 <push>`
--------------------------------------------------

.. First save the new image by finding the container ID (using docker container ls) and then committing it to a new image name. Note that only a-z0-9-_. are allowed when naming images:

始めに新しいイメージに保存するため、コンテナ ID を探して（ ``docker container ls`` を使います）、それから、このコンテナを新しいイメージ名にコミットします。イメージ名に使えるのは ``a-z0-9-Z.`` のみなので、気を付けます。

.. code-block:: bash

   $ docker container commit c16378f943fe rhel-httpd:latest

.. Now, push the image to the registry using the image ID. In this example the registry is on host named registry-host and listening on port 5000. To do this, tag the image with the host name or IP address, and the port of the registry:

それから、イメージ ID を使ってレジストリにイメージを送信します。この例では、レジストリのホスト名は ``registry-host`` で、ポート ``5000`` をリッスンしています。ここに送信するためには、イメージのタグに対し、ホスト名や IP アドレス、レジストリのポート番号を追加します。

.. code-block:: bash

   $ docker image tag rhel-httpd:latest registry-host:5000/myadmin/rhel-httpd:latest
   
   $ docker image push registry-host:5000/myadmin/rhel-httpd:latest

.. Check that this worked by running:

これが正しく動作しているかどうかを確認しましょう。

.. code-block:: bash

   $ docker image ls

.. You should see both rhel-httpd and registry-host:5000/myadmin/rhel-httpd listed.

一覧に ``rhel-httpd`` と ``registry-host:5000/myadmin/rhel-httpd`` の両方が見えるでしょう。

.. Push all tags of an image
.. _docker_push-push-all-tags-of-an-image:
イメージのタグ全てを送信
------------------------------

.. Use the -a (or --all-tags) option to push all tags of a local image.

``-a`` （または ``--all-tags`` ）オプションを使うと、ローカル・イメージのタグ全てを送信します。

.. The following example creates multiple tags for an image, and pushes all those tags to Docker Hub.

以下の例は、イメージに対して複数のタグを作成し、それから、タグ全てを Docker Hub に送信します。

.. code-block:: bash

   $ docker image tag myimage registry-host:5000/myname/myimage:latest
   $ docker image tag myimage registry-host:5000/myname/myimage:v1.0.1
   $ docker image tag myimage registry-host:5000/myname/myimage:v1.0
   $ docker image tag myimage registry-host:5000/myname/myimage:v1

.. The image is now tagged under multiple names:

これで、先ほどのイメージは、今は複数の名前の下に新しいタグが付いています。

.. code-block:: bash

   $ docker image ls
   REPOSITORY                          TAG        IMAGE ID       CREATED      SIZE
   myimage                             latest     6d5fcfe5ff17   2 hours ago  1.22MB
   registry-host:5000/myname/myimage   latest     6d5fcfe5ff17   2 hours ago  1.22MB
   registry-host:5000/myname/myimage   v1         6d5fcfe5ff17   2 hours ago  1.22MB
   registry-host:5000/myname/myimage   v1.0       6d5fcfe5ff17   2 hours ago  1.22MB
   registry-host:5000/myname/myimage   v1.0.1     6d5fcfe5ff17   2 hours ago  1.22MB

.. When pushing with the --all-tags option, all tags of the registry-host:5000/myname/myimage image are pushed:

次の例では、送信時に ``--all-tags`` オプションを付けると、 ``registry-host:5000/myname/myimage`` イメージの全てのタグが送信されます。

.. code-block:: bash

  $ docker image push --all-tags registry-host:5000/myname/myimage
  
  The push refers to repository [registry-host:5000/myname/myimage]
  195be5f8be1d: Pushed
  latest: digest: sha256:edafc0a0fb057813850d1ba44014914ca02d671ae247107ca70c94db686e7de6 size: 4527
  195be5f8be1d: Layer already exists
  v1: digest: sha256:edafc0a0fb057813850d1ba44014914ca02d671ae247107ca70c94db686e7de6 size: 4527
  195be5f8be1d: Layer already exists
  v1.0: digest: sha256:edafc0a0fb057813850d1ba44014914ca02d671ae247107ca70c94db686e7de6 size: 4527
  195be5f8be1d: Layer already exists
  v1.0.1: digest: sha256:edafc0a0fb057813850d1ba44014914ca02d671ae247107ca70c94db686e7de6 size: 4527


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド

.. seealso:: 

   docker push
      https://docs.docker.com/engine/reference/commandline/push/
