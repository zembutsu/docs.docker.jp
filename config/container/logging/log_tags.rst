.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/logging/log_tags/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/logging/log_tags.md
   doc version: 19.03
.. check date: 2020/07/03
.. Commits on Feb 2, 2018 1b343beca4aaab8b183eefa89867b6bf64505be5
.. -------------------------------------------------------------------

.. Log Tags

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Customize log driver output

.. _customize-log-driver-output:

=======================================
ログドライバの出力をカスタマイズ
=======================================

.. The tag log option specifies how to format a tag that identifies the container’s log messages. By default, the system uses the first 12 characters of the container id. To override this behavior, specify a tag option:

``tag`` ログ・オプションは、コンテナのログ・メッセージを識別するため、どのような形式のタグを使うか指定します。デフォルトでは、システムはコンテナ ID の冒頭12文字を使います。この動作を上書きするには、 ``tag`` オプションを使います。

.. code-block:: bash

   docker run --log-driver=fluentd --log-opt fluentd-address=myhost.local:24224 --log-opt tag="mailer"

.. Docker supports some special template markup you can use when specifying a tag’s value:

Docker はタグの値を指定するために、特別なテンプレート・マークアップをサポートしています。

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

.. For example, specifying a --log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}" value yields syslog log lines like:

例えば、 ``--log-opt tag="{{.ImageName}}/{{.Name}}/{{.ID}}"`` を値に指定したら、 ``syslog`` のログ行は次のようになります。

.. code-block:: bash

   Aug  7 18:33:19 HOSTNAME docker/hello-world/foobar/5790672ab6a0[9103]: Hello from Docker.

.. At startup time, the system sets the container_name field and {{.Name}} in the tags. If you use docker rename to rename a container, the new name is not reflected in the log messages. Instead, these messages continue to use the original container name.

起動時に、システムは ``container_name`` フィールドと ``{{.Name}}`` をタグに設定します。 ``docker rename`` でコンテナ名を変更しても、ログメッセージに新しいコンテナ名は反映されません。そのかわり、これらのメッセージは元々のコンテナ名を使って保存され続けます。

.. seealso:: 

   Customize log driver output
      https://docs.docker.com/config/containers/logging/log_tags/
