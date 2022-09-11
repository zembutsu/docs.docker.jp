.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/history/
.. SOURCE: 
   doc version: 20.10
      https://github.com/docker/docker.github.io/blob/master/engine/reference/commandline/history.md
      https://github.com/docker/docker.github.io/blob/master/_data/engine-cli/docker_history.yaml
.. check date: 2022/03/20
.. Commits on Aug 22, 2021 304f64ccec26ef1810e90d385d5bae5fab3ce6f4
.. -------------------------------------------------------------------

.. docker history

=======================================
docker history
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. _docker_history-description:

説明
==========

.. Show the history of an image

イメージの :ruby:`履歴 <history>` を表示します。

.. _docker_history-usage:

使い方
==========

.. code-block:: bash

   $ docker history [OPTIONS] IMAGE

.. For example uses of this command, refer to the examples section below.

コマンドの使用例は、以下の :ref:`使用例のセクション <docker_history-examples>` をご覧ください。

.. _docker_history-options:

オプション
==========

.. list-table::
   :header-rows: 1

   * - 名前, 省略形
     - デフォルト
     - 説明
   * - ``--format``
     - 
     - Go テンプレートを使い、イメージを整えて表示
   * - ``--human`` , ``-H``
     - ``true``
     - 人間が読みやすい形式で容量と日付を表示
   * - ``--no-trunc``
     - 
     - :ruby:`出力を省略 <truncate>` しない
   * - ``--quiet`` , ``-q``
     - 
     - イメージ ID のみ表示


.. Examples
.. _docker_history-examples:

使用例
==========

.. To see how the docker:latest image was built:

``docker:latest`` イメージが、どのように構築されたか表示します。

.. code-block:: bash

   $ docker history docker
   IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
   3e23a5875458        8 days ago          /bin/sh -c #(nop) ENV LC_ALL=C.UTF-8            0 B
   8578938dd170        8 days ago          /bin/sh -c dpkg-reconfigure locales &&    loc   1.245 MB
   be51b77efb42        8 days ago          /bin/sh -c apt-get update && apt-get install    338.3 MB
   4b137612be55        6 weeks ago         /bin/sh -c #(nop) ADD jessie.tar.xz in /        121 MB
   750d58736b4b        6 weeks ago         /bin/sh -c #(nop) MAINTAINER Tianon Gravi <ad   0 B
   511136ea3c5a        9 months ago                                                        0 B                 Imported from -

.. To see how the docker:apache image was added to a container’s base image:

``docker:apache`` イメージが、コンテナのベース・イメージにどのように追加されたかを表示します。

.. code-block:: bash

   $ docker history docker:scm
   IMAGE               CREATED             CREATED BY                                      SIZE                COMMENT
   2ac9d1098bf1        3 months ago        /bin/bash                                       241.4 MB            Added Apache to Fedora base image
   88b42ffd1f7c        5 months ago        /bin/sh -c #(nop) ADD file:1fd8d7f9f6557cafc7   373.7 MB
   c69cab00d6ef        5 months ago        /bin/sh -c #(nop) MAINTAINER Lokesh Mandvekar   0 B
   511136ea3c5a        19 months ago                                                       0 B                 Imported from -

.. Format the output
.. _docker_history-format-the-output:
表示形式
----------

.. list-table::
   :header-rows: 1

   * - Placeholder, 説明
     - 説明
   * - ``.ID``
     - イメージ ID
   * - ``.CreatedSince``
     - ``--human=true`` の場合、イメージ作成後の経過時間。そうでなければ、イメージが作成された時点のタイムスタンプ
   * - ``.CreatedAt``
     - イメージが作成されたタイムスタンプ
   * - ``.CreatedBy``
     - イメージ作成に使われたコマンド
   * - ``.Size``
     - イメージのディスク容量
   * - ``.Comment``
     - イメージに対するコメント

.. When using the --format option, the history command will either output the data exactly as the template declares or, when using the table directive, will include column headers as well.

 ``history`` コマンドに ``--format`` オプションを使用する場合、テンプレートで指定した通りにデータを出力するか、 ``table`` 命令を使うと同様に列ヘッダを含めて表示するかのどちらかです。

.. The following example uses a template without headers and outputs the ID and CreatedSince entries separated by a colon (:) for the busybox image:

以下の例はテンプレートを使いますが、ヘッダを表示せず、 ``ID`` と ``CreatedSince`` エントリをコロン（ ``:`` ）で区切り、 ``busybox`` イメージを表示します。

.. code-block:: bash

   $ docker history --format "{{.ID}}: {{.CreatedSince}}" busybox
   f6e427c148a7: 4 weeks ago
   <missing>: 4 weeks ago


親コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker <docker>`
     - Docker CLI の基本コマンド


.. seealso:: 

   docker history
      https://docs.docker.com/engine/reference/commandline/history/


