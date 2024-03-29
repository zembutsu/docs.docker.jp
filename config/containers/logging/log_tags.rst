.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/logging/log_tags/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/logging/log_tags.md
   doc version: 20.10
.. check date: 2022/04/28
.. Commits on Aug 7, 2021 859923171ced723ab40203ad1f388aa3771955e0
.. -------------------------------------------------------------------

.. title: Customize log driver output

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Customize log driver output

.. _customize-log-driver-output:

=======================================
ログ・ドライバー出力のカスタマイズ
=======================================

.. The `tag` log option specifies how to format a tag that identifies the
   container's log messages. By default, the system uses the first 12 characters of
   the container ID. To override this behavior, specify a `tag` option:

ログ・オプションの ``tag`` は、コンテナのログ出力を識別するためのタグを、どのような書式で出力するかを指定します。
デフォルトでは、コンテナ ID の先頭 12 文字を用います。
この動作を上書きするには ``tag`` オプションを使います。

.. code-block:: bash

   $ docker run --log-driver=fluentd --log-opt fluentd-address=myhost.local:24224 --log-opt tag="mailer"

.. Docker supports some special template markup you can use when specifying a tag's value:

タグの値を指定する際には、特別なテンプレート・マークアップの利用がサポートされています。

.. Markup 	Description
.. {{.ID}} 	The first 12 characters of the container id.
.. {{.FullID}} 	The full container id.
.. {{.Name}} 	The container name.
.. {{.ImageID}} 	The first 12 characters of the container’s image id.
.. {{.ImageFullID}} 	The container’s full image identifier.
.. {{.ImageName}} 	The name of the image used by the container.

.. list-table::
   :header-rows: 1
   
   * - マークアップ
     - 説明
   * - ``{{.ID}}``
     - コンテナ ID の冒頭 12 文字
   * - ``{{.FullID}}``
     - コンテナの完全 ID
   * - ``{{.Name}}``
     - コンテナ名
   * - ``{{.ImageID}}``
     - イメージ ID の冒頭 12 文字
   * - ``{{.ImageFullId}}``
     - コンテナの完全 ID
   * - ``{{.ImageName}}``
     - コンテナが使っているイメージ名
   * - ``{{.DaemonName}}``
     - docker プログラムの名前 ( ``docker`` )

.. For example, specifying a {% raw %}`--log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}"`{% endraw %} value yields `syslog` log lines like:

たとえば ``--log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}"`` と指定すると、``syslog`` のようなログ出力になります。

.. code-block:: bash

   Aug  7 18:33:19 HOSTNAME hello-world/foobar/5790672ab6a0[9103]: Hello from Docker.

.. At startup time, the system sets the `container_name` field and {% raw %}`{{.Name}}`{% endraw %} in
   the tags. If you use `docker rename` to rename a container, the new name is not
   reflected in the log messages. Instead, these messages continue to use the
   original container name.

システム起動時にタグ内の ``container_name`` と ``{{.Name}}`` が設定されます。
``docker rename`` によってコンテナ名を変更した場合、ログ出力に新たな名前は反映されません。
ログでは、元々のコンテナ名を用いた出力が行われます。

.. seealso:: 

   Customize log driver output
      https://docs.docker.com/config/containers/logging/log_tags/
