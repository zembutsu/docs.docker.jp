.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/pruning/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/pruning.md
   doc version: 19.03
.. check date: 2020/06/21
.. Commits on Apr 13, 2020 7f66d7783f886cf4aa50c81b9f85869b7ebf6874
.. ---------------------------------------------------------------------------

.. Prune unused Docker objects

.. _prune-unused-docker-objects:

============================================================
使用していない Docker オブジェクトの削除（prune）
============================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Docker takes a conservative approach to cleaning up unused objects (often referred to as “garbage collection”), such as images, containers, volumes, and networks: these objects are generally not removed unless you explicitly ask Docker to do so. This can cause Docker to use extra disk space. For each type of object, Docker provides a prune command. In addition, you can use docker system prune to clean up multiple types of objects at once. This topic shows how to use these prune commands.

Docker は使用していないオブジェクト、たとえばイメージ、コンテナ、ボリューム、ネットワークに対するクリーンアップには、慎重なアプローチをとっています。すなわち、各オブジェクトは Docker に対して明示的に削除を命令しない限り、削除されることはありません。その結果、Docker は巨大なディスク容量を使う事になりました。オブジェクトのタイプごとに、 Docker は ``prune`` （削除）コマンドを提供しています。さらに、 ``docker system prune`` を使えば、複数のオブジェクト・タイプを一度にクリーンアップできます。このトピックは各 ``prune`` コマンドをどのようにして使うか紹介します。

.. Prune images

イメージの prune
====================

.. The docker image prune command allows you to clean up unused images. By default, docker image prune only cleans up dangling images. A dangling image is one that is not tagged and is not referenced by any container. To remove dangling images:

``docker image prune`` コマンドは、使っていないイメージをクリーンアップできます。デフォルトの ``docker image prune`` は、宙ぶらりんイメージ（dangling image）のみ削除します。宙ぶらりんイメージとは、タグを持たず、他のコンテナからも参照されないイメージです。宙ぶらりんイメージを削除するには、次のようにします。

.. code-block:: bash

   $ docker image prune
   
   WARNING! This will remove all dangling images.
   Are you sure you want to continue? [y/N] y

.. To remove all images which are not used by existing containers, use the -a flag:

既存のコンテナ～使われていないイメージすべてを削除するには、 ``-a`` フラグを使います。

.. code-block:: bash

   $ docker image prune -a
   
   WARNING! This will remove all images without at least one container associated to them.
   Are you sure you want to continue? [y/N] y

.. By default, you are prompted to continue. To bypass the prompt, use the -f or --force flag.

デフォルトでは、作業を続行するかどうか尋ねます。この確認を飛ばすには、 ``-f`` か ``--force`` フラグを使います。

.. You can limit which images are pruned using filtering expressions with the --filter flag. For example, to only consider images created more than 24 hours ago:

``--filter`` フラグでフィルタリング表現を使えば、削除するイメージに制限を設けられます。

.. code-block:: bash

   $ docker image prune -a --filter "until=24h"

.. Other filtering expressions are available. See the docker image prune reference for more examples.

他のフィルタリング表現も利用できます。その他の例は :doc:`docker image prune リファレンス </engine/reference/commandline/image_prune>` をご覧ください。

.. Prune containers

コンテナの prune
====================

.. When you stop a container, it is not automatically removed unless you started it with the --rm flag. To see all containers on the Docker host, including stopped containers, use docker ps -a. You may be surprised how many containers exist, especially on a development system! A stopped container’s writable layers still take up disk space. To clean this up, you can use the docker container prune command.

コンテナを停止しても、 ``--rm`` フラグを付けて起動していなければ、コンテナは自動的に削除されません。Docker ホスト上で、停止しているコンテナも含めて全てを表示するには、 ``docker ps -a`` を使います。そうすると、こんなにも沢山のコンテナがあるのかと驚くでしょう。特に開発システム上ではなおさらです！ 停止しているコンテナの書き込み可能なレイヤは、ディスク容量を消費し続けます。これらを綺麗に片付けるには、 ``docker container prune`` コマンドを使います。

.. code-block:: bash

   $ docker container prune
   
   WARNING! This will remove all stopped containers.
   Are you sure you want to continue? [y/N] y

.. By default, you are prompted to continue. To bypass the prompt, use the -f or --force flag.

デフォルトでは、確認プロンプトを表示します。このプロンプトを使わない場合は、 ``-f`` もしくは ``--force`` フラグを使います。

.. By default, all stopped containers are removed. You can limit the scope using the --filter flag. For instance, the following command only removes stopped containers older than 24 hours:

デフォルトでは、停止している全てのコンテナを削除します。 ``--filter`` フラグを使うと、範囲を制限できます。たとえば、以下のコマンドは24時間より以前に停止したコンテナのみを削除します。

.. code-block:: bash

   $ docker container prune --filter "until=24h"

.. Other filtering expressions are available. See the docker container prune reference for more examples.

他にもフィルタリング表現が利用できます。その他の例は :doc:`docker container prune リファレンス </engine/reference/commandline/container_prune>` をご覧ください。

.. Prune volumes

ボリュームの prune
====================

.. Volumes can be used by one or more containers, and take up space on the Docker host. Volumes are never removed automatically, because to do so could destroy data.

ボリュームは１つもしくは複数のコンテナによって利用されるもので、Docker ホスト上で容量を使います。ボリュームの削除はデータの破棄にあたるため、決して自動的に削除されません。

.. code-block:: bash

   $ docker volume prune
   
   WARNING! This will remove all volumes not used by at least one container.
   Are you sure you want to continue? [y/N] y

.. By default, you are prompted to continue. To bypass the prompt, use the -f or --force flag.

デフォルトでは、確認プロンプトを表示します。このプロンプトを使わない場合は、 ``-f`` もしくは ``--force`` フラグを使います。

.. By default, all unused volumes are removed. You can limit the scope using the --filter flag. For instance, the following command only removes volumes which are not labelled with the keep label:

デフォルトでは、未使用のボリュームを全て削除します。 ``--filter`` フラグを使うと、範囲を制限できます。たとえば、以下のコマンドは ``keep`` ラベルがないボリュームのみを削除します。

.. code-block:: bash

   $ docker volume prune --filter "label!=keep"

.. Other filtering expressions are available. See the docker volume prune reference for more examples.

他にもフィルタリング表現が利用できます。その他の例は :doc:`docker volume prune リファレンス </engine/reference/commandline/volume_prune>` をご覧ください。


.. Prune networks

ネットワークの prune
====================

.. Docker networks don’t take up much disk space, but they do create iptables rules, bridge network devices, and routing table entries. To clean these things up, you can use docker network prune to clean up networks which aren’t used by any containers.

Docker ネットワークはディスクスペースを消費しませんが、 ``iptables`` ルールを作成し、ブリッジ・ネットワークのデバイスや、ルーティング・テーブルのエントリも作成します。これらを綺麗に片付けるには、 ``docker network prune`` を使い、コンテナから使用されていないネットワークを片付けます。

.. code-block:: bash

   $ docker network prune
   
   WARNING! This will remove all networks not used by at least one container.
   Are you sure you want to continue? [y/N] y

.. By default, you are prompted to continue. To bypass the prompt, use the -f or --force flag.

デフォルトでは、確認プロンプトを表示します。このプロンプトを使わない場合は、 ``-f`` もしくは ``--force`` フラグを使います。

.. By default, all unused networks are removed. You can limit the scope using the --filter flag. For instance, the following command only removes networks older than 24 hours:

デフォルトでは、未使用ネットワークをすべて削除します。 ``--filter`` フラグを使うと、範囲を制限できます。たとえば、以下のコマンドは24時間より以前のネットワークのみを削除します。

.. code-block:: bash

   $ docker network prune --filter "until=24h"

.. Other filtering expressions are available. See the docker network prune reference for more examples.

他にもフィルタリング表現が利用できます。その他の例は :doc:`docker network prune リファレンス </engine/reference/commandline/network_prune>` をご覧ください。


.. Prune everything

全てを prune
====================

.. The docker system prune command is a shortcut that prunes images, containers, and networks. In Docker 17.06.0 and earlier, volumes are also pruned. In Docker 17.06.1 and higher, you must specify the --volumes flag for docker system prune to prune volumes.

``docker system prune`` コマンドは、イメージ、コンテナ、ネットワークを削除（prune）するショートカットです。 Docker 17.06.0 以下のバージョンでは、ボリュームも prune されました。Docker 17.06.1 以降では、 ``docker system prune`` でボリュームも削除するには ``--volumes`` フラグが必要になりました。

.. code-block:: bash

   $ docker system prune
   
   WARNING! This will remove:
           - all stopped containers
           - all networks not used by at least one container
           - all dangling images
           - all build cache
   Are you sure you want to continue? [y/N] y

.. If you are on Docker 17.06.1 or higher and want to also prune volumes, add the --volumes flag:

Docker 17.06.1 以上でボリュームも削除したい場合は、 ``--volumes`` フラグを使います。

.. code-block:: bash

   $ docker system prune --volumes
   
   WARNING! This will remove:
           - all stopped containers
           - all networks not used by at least one container
           - all volumes not used by at least one container
           - all dangling images
           - all build cache
   Are you sure you want to continue? [y/N] y

.. By default, you are prompted to continue. To bypass the prompt, use the -f or --force flag.

デフォルトでは、確認プロンプトを表示します。このプロンプトを使わない場合は、 ``-f`` もしくは ``--force`` フラグを使います。

.. seealso:: 
   Prune unused Docker objects
      https://docs.docker.com/config/pruning/
