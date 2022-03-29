.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/manifest/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/manifest.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_manifest.yaml
.. check date: 2022/03/28
.. Commits on Aug 21, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker manifest

=======================================
docker manifest
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _manifest-description:

説明
==========

.. Manage Docker image manifests and manifest lists

Docker イメージ・マニフェストとマニフェスト一覧を管理します。

..    This command is experimental on the Docker client.
    It should not be used in production environments.
    To enable experimental features in the Docker CLI, edit the config.json and set experimental to enabled. You can go here for more information.

.. important::

   **これは Docker クライアントの実験的なコマンドです。**
   
   **プロダクション環境では使うべきではありません。**
   Docker CLI で実験的機能を有効かするには、 :ref:`config.json <configuration-files>` を編集し、 ``experimental`` を ``enabled`` にします。

.. _manifest-usage:

使い方
==========

.. code-block:: bash

   $ docker manifest COMMAND COMMAND

.. Extended description
.. _manifest-extended-description:

補足説明
==========

.. The docker manifest command by itself performs no action. In order to operate on a manifest or manifest list, one of the subcommands must be used.

``docker manifest`` コマンドは、これ自身は何ら処理を行いません。マニフェストやマニフェストリストを操作するため、何らかのサブコマンドの指定が必要です。

.. A single manifest is information about an image, such as layers, size, and digest. The docker manifest command also gives users additional information such as the os and architecture an image was built for.

マニフェストとは、レイヤ、容量、ダイジェスト値といったイメージに関する情報です。docker manifest コマンドでは、イメージが構築された OS とアーキテクチャのような追加情報も与えられます。

.. A manifest list is a list of image layers that is created by specifying one or more (ideally more than one) image names. It can then be used in the same way as an image name in docker pull and docker run commands, for example.

マニフェストリストとは、指定した1つまたは複数の（理想は2つ以上の）イメージ名によって作成されたイメージのリストです。これらは、たとえば ``docker pull`` と ``docker run`` コマンドでのイメージ名と同様に扱えます。

.. Ideally a manifest list is created from images that are identical in function for different os/arch combinations. For this reason, manifest lists are often referred to as “multi-arch images”. However, a user could create a manifest list that points to two images -- one for windows on amd64, and one for darwin on amd64.

理想としては、異なる os とアーキテクチャの組み合わせごとに独立したイメージを作成し、そこからマニフェストリストを作成します。そのため、マニフェストリストは「 :ruby:`複数アーキテクチャ対応イメージ <multi-arch image>` 」として言及されます。一方で、ユーザはマニフェストリストを2つのイメージを指すのに使うでしょう。1つは amd64 上の Windows で、もう1つは arm64 上の darwin です。

..  _manifest-inspect:
manifest inspect
-------------------

.. code-block:: bash

   $ docker manifest inspect --help
   
   Usage:  docker manifest inspect [OPTIONS] [MANIFEST_LIST] MANIFEST
   
   Display an image manifest, or manifest list
   
   Options:
         --help       Print usage
         --insecure   Allow communication with an insecure registry
     -v, --verbose    Output additional info including layers and platform

.. _manifest-create:
manifest create
--------------------

.. code-block:: bash

   Usage:  docker manifest create MANIFEST_LIST MANIFEST [MANIFEST...]
   
   Create a local manifest list for annotating and pushing to a registry
   
   Options:
     -a, --amend      Amend an existing manifest list
         --insecure   Allow communication with an insecure registry
         --help       Print usage

.. _manifest-annotate:
manifest annotate
--------------------

.. code-block:: bash

   Usage:  docker manifest annotate [OPTIONS] MANIFEST_LIST MANIFEST
   
   Add additional information to a local image manifest
   
   Options:
         --arch string               Set architecture
         --help                      Print usage
         --os string                 Set operating system
         --os-version string         Set operating system version
         --os-features stringSlice   Set operating system feature
         --variant string            Set architecture variant

.. _manifest-push:
manifest push
--------------------

.. code-block:: bash

   Usage:  docker manifest push [OPTIONS] MANIFEST_LIST
   
   Push a manifest list to a repository
   
   Options:
         --help       Print usage
         --insecure   Allow push to an insecure registry
     -p, --purge      Remove the local manifest list after push

.. Working with insecure registries
.. _manifest-working-with-insecure-registries:
安全ではないレジストリで使う
------------------------------

.. The manifest command interacts solely with a Docker registry. Because of this, it has no way to query the engine for the list of allowed insecure registries. To allow the CLI to interact with an insecure registry, some docker manifest commands have an --insecure flag. For each transaction, such as a create, which queries a registry, the --insecure flag must be specified. This flag tells the CLI that this registry call may ignore security concerns like missing or self-signed certificates. Likewise, on a manifest push to an insecure registry, the --insecure flag must be specified. If this is not used with an insecure registry, the manifest command fails to find a registry that meets the default requirements.

manifest コマンドは Docker レジストリのみ通信します。そのため、engine の許可された安全ではないレジストリに一覧を確認する方法がありません。CLI が安全ではないレジストリとやりとり可能にするには、 ``docker manifest`` コマンドに ``--insecure`` フラグを付けます。 ``create`` のような処理ごとに、レジストリに問い合わせるには、 ``--insecure`` フラグが必須です。このフラグを CLI に伝えると、証明書が無かったり自己署名する場合でも、セキュリティの警告を無視します。同様に、安全ではないレジストリに ``manifest push`` する場合も ``--insecure`` フラグが必須です。安全ではないレジストリに対して指定しなければ、manifest コマンドはデフォルトで接続を必要とするレジストリが見つけられません。

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <manifest-examples>` をご覧ください。

.. Examples
.. _manifest-examples:

使用例
==========

.. Inspect an image's manifest object
.. manifest-inspect-an-images-manifest-object:
イメージのマニフェスト・オブジェクトを調査
--------------------------------------------------

.. code-block:: bash

   $ docker manifest inspect hello-world
   {
           "schemaVersion": 2,
           "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
           "config": {
                   "mediaType": "application/vnd.docker.container.image.v1+json",
                   "size": 1520,
                   "digest": "sha256:1815c82652c03bfd8644afda26fb184f2ed891d921b20a0703b46768f9755c57"
           },
           "layers": [
                   {
                           "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
                           "size": 972,
                           "digest": "sha256:b04784fba78d739b526e27edc02a5a8cd07b1052e9283f5fc155828f4b614c28"
                   }
           ]
   }

.. Inspect an image’s manifest and get the os/arch info
.. _manifest-inspect-an-images-manifest-and-get-the-os-arch-info:
イメージのマニフェストを調査し、os とアーキテクチャ情報を取得
----------------------------------------------------------------------

.. The docker manifest inspect command takes an optional --verbose flag that gives you the image’s name (Ref), and architecture and os (Platform).

``docker manifest inspect`` コマンドは、オプションで ``--verbose`` フラグを指定でき、イメージ名（参照）、アーキテクチャと OS （プラットフォーム）の情報を表示します。

.. Just as with other docker commands that take image names, you can refer to an image with or without a tag, or by digest (e.g. hello-world@sha256:f3b3b28a45160805bb16542c9531888519430e9e6d6ffc09d72261b0d26ff74f).

他の docker コマンドでイメージを扱うのと同様に、参照はイメージ名や、タグが不要であったり、あるいはダイジェスト値（例： ``hello-world@sha256:f3b3b28a45160805bb16542c9531888519430e9e6d6ffc09d72261b0d26ff74f`` ）が使えます。

.. Here is an example of inspecting an image’s manifest with the --verbose flag:

こちらはイメージのマニフェストを ``--verbose`` フラグを付けて調査する例です。

.. code-block:: bash

   $ docker manifest inspect --verbose hello-world
   {
           "Ref": "docker.io/library/hello-world:latest",
           "Digest": "sha256:f3b3b28a45160805bb16542c9531888519430e9e6d6ffc09d72261b0d26ff74f",
           "SchemaV2Manifest": {
                   "schemaVersion": 2,
                   "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
                   "config": {
                           "mediaType": "application/vnd.docker.container.image.v1+json",
                           "size": 1520,
                           "digest": "sha256:1815c82652c03bfd8644afda26fb184f2ed891d921b20a0703b46768f9755c57"
                   },
                   "layers": [
                           {
                                   "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
                                   "size": 972,
                                   "digest": "sha256:b04784fba78d739b526e27edc02a5a8cd07b1052e9283f5fc155828f4b614c28"
                           }
                   ]
           },
           "Platform": {
                   "architecture": "amd64",
                   "os": "linux"
           }
   }

.. Create and push a manifest list
.. _manifest-create-and-push-a-manifest-list:
マニフェストリストの作成と送信
------------------------------

.. To create a manifest list, you first create the manifest list locally by specifying the constituent images you would like to have included in your manifest list. Keep in mind that this is pushed to a registry, so if you want to push to a registry other than the docker registry, you need to create your manifest list with the registry name or IP and port. This is similar to tagging an image and pushing it to a foreign registry.

マニフェストリストを作成するには、まず、マニフェストリストの構成に含めようとしているイメージを、ローカルのマニフェストリストとして作成します。これはレジストリに送信しますので、 docker レジストリ以外のレジストリに送信したい場合は、自身のレジストリ名と IP アドレスとポートを持つマニフェストリストの作成が必要です。これあ、外部レジストリに対してイメージを送信する時、タグを付けるのと同じようなものです。

.. After you have created your local copy of the manifest list, you may optionally annotate it. Annotations allowed are the architecture and operating system (overriding the image’s current values), os features, and an architecture variant.

マニフェストリストのローカルコピーを作成後、オプションで ``annotate`` （注釈の追加）できます。注釈では、アーキテクチャ、オペレーティングシステム（現在のイメージの値を上書き）、OS 機能、派生アーキテクチャを追記できます。

.. Finally, you need to push your manifest list to the desired registry. Below are descriptions of these three commands, and an example putting them all together.

最後に、希望するレジストリに対してマニフェストリストを ``push`` します。以下に記述する3つのコマンドは、一連のの処理例です。

.. code-block:: bash
 
   $ docker manifest create 45.55.81.106:5000/coolapp:v1 \
       45.55.81.106:5000/coolapp-ppc64le-linux:v1 \
       45.55.81.106:5000/coolapp-arm-linux:v1 \
       45.55.81.106:5000/coolapp-amd64-linux:v1 \
       45.55.81.106:5000/coolapp-amd64-windows:v1
   
   Created manifest list 45.55.81.106:5000/coolapp:v1

.. code-block:: bash

   $ docker manifest annotate 45.55.81.106:5000/coolapp:v1 45.55.81.106:5000/coolapp-arm-linux --arch arm

.. code-block:: bash

   $ docker manifest push 45.55.81.106:5000/coolapp:v1
   Pushed manifest 45.55.81.106:5000/coolapp@sha256:9701edc932223a66e49dd6c894a11db8c2cf4eccd1414f1ec105a623bf16b426 with digest: sha256:f67dcc5fc786f04f0743abfe0ee5dae9bd8caf8efa6c8144f7f2a43889dc513b
   Pushed manifest 45.55.81.106:5000/coolapp@sha256:f3b3b28a45160805bb16542c9531888519430e9e6d6ffc09d72261b0d26ff74f with digest: sha256:b64ca0b60356a30971f098c92200b1271257f100a55b351e6bbe985638352f3a
   Pushed manifest 45.55.81.106:5000/coolapp@sha256:39dc41c658cf25f33681a41310372f02728925a54aac3598310bfb1770615fc9 with digest: sha256:df436846483aff62bad830b730a0d3b77731bcf98ba5e470a8bbb8e9e346e4e8
   Pushed manifest 45.55.81.106:5000/coolapp@sha256:f91b1145cd4ac800b28122313ae9e88ac340bb3f1e3a4cd3e59a3648650f3275 with digest: sha256:5bb8e50aa2edd408bdf3ddf61efb7338ff34a07b762992c9432f1c02fc0e5e62
   sha256:050b213d49d7673ba35014f21454c573dcbec75254a08f4a7c34f66a47c06aba

.. Inspect a manifest list
.. _manifest-inspect-a-manifest-list:
マニフェストリストの調査
------------------------------

.. code-block:: bash

   $ docker manifest inspect coolapp:v1
   {
      "schemaVersion": 2,
      "mediaType": "application/vnd.docker.distribution.manifest.list.v2+json",
      "manifests": [
         {
            "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
            "size": 424,
            "digest": "sha256:f67dcc5fc786f04f0743abfe0ee5dae9bd8caf8efa6c8144f7f2a43889dc513b",
            "platform": {
               "architecture": "arm",
               "os": "linux"
            }
         },
         {
            "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
            "size": 424,
            "digest": "sha256:b64ca0b60356a30971f098c92200b1271257f100a55b351e6bbe985638352f3a",
            "platform": {
               "architecture": "amd64",
               "os": "linux"
            }
         },
         {
            "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
            "size": 425,
            "digest": "sha256:df436846483aff62bad830b730a0d3b77731bcf98ba5e470a8bbb8e9e346e4e8",
            "platform": {
               "architecture": "ppc64le",
               "os": "linux"
            }
         },
         {
            "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
            "size": 425,
            "digest": "sha256:5bb8e50aa2edd408bdf3ddf61efb7338ff34a07b762992c9432f1c02fc0e5e62",
            "platform": {
               "architecture": "s390x",
               "os": "linux"
            }
         }
      ]
   }

.. Push to an insecure registry
.. _manifest-push-to-an-insecure-registy:
安全ではないレジストリに送信
------------------------------

.. Here is an example of creating and pushing a manifest list using a known insecure registry.

以下の例は、マニフェストリストを作成、知っている安全ではないレジストリに対して送信します。

.. code-block:: bash

   $ docker manifest create --insecure myprivateregistry.mycompany.com/repo/image:1.0 \
       myprivateregistry.mycompany.com/repo/image-linux-ppc64le:1.0 \
       myprivateregistry.mycompany.com/repo/image-linux-s390x:1.0 \
       myprivateregistry.mycompany.com/repo/image-linux-arm:1.0 \
       myprivateregistry.mycompany.com/repo/image-linux-armhf:1.0 \
       myprivateregistry.mycompany.com/repo/image-windows-amd64:1.0 \
       myprivateregistry.mycompany.com/repo/image-linux-amd64:1.0
   
   $ docker manifest push --insecure myprivateregistry.mycompany.com/repo/image:tag

..    Note
    The --insecure flag is not required to annotate a manifest list, since annotations are to a locally-stored copy of a manifest list. You may also skip the --insecure flag if you are performing a docker manifest inspect on a locally-stored manifest list. Be sure to keep in mind that locally-stored manifest lists are never used by the engine on a docker pull.

.. note::

   ``--insecure`` フラグは、マニフェストリストへの注釈（annotate）には不要です。注釈とは、マニフェストリストのローカル範囲でのコピーだからです。 ``docker manifest inspect`` をローカルに保管しているマニフェストリストに対して処理する時は、 ``--insecure`` フラグを省略できます。ローカルに保管したマニフェストリストは、 engine が  ``docker pull`` する時には使われないので注意してください。



.. Parent command

親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI のベースコマンド。


.. Child commands

子コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker manifest annotate <manifest_annotate>`
     - ローカルイメージマニフェストに追加情報を追加
   * - :doc:`docker manifest crate <manifest_create>`
     - ローカルマニフェスト用の注記（annotating）を作成し、レジストリに送信
   * - :doc:`docker manifest inspect <manifest_inspect>`
     - イメージのマニフェストか、マニフェストリストを表示
   * - :doc:`docker manifest push <manifest_push>`
     - マニフェストリストをリポジトリに送信
   * - :doc:`docker manifest rm <manifest_rm>`
     - ローカルストレージから1つまたは複数のマニフェストリストを削除


.. seealso:: 

   docker manifest
      https://docs.docker.com/engine/reference/commandline/manifest/
