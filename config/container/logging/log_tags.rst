.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/logging/log_tags/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/logging/log_tags.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/admin/logging/log_tags.md
.. check date: 2016/04/21
.. Commits on Apr 9, 2016 f67b7112775fd9957cc156cc4483e11b8c0c981a
.. -------------------------------------------------------------------

.. Log Tags

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

=======================================
ログ用のタグ
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

.. For advanced usage, the generated tag’s use go templates and the container’s logging context.

高度な使い方は、 `go テンプレート <http://golang.org/pkg/text/template/>`_ のタグ生成や、コンテナの `ログ内容 <https://github.com/docker/docker/blob/master/daemon/logger/context.go>`_ をご覧ください。

.. As an example of what is possible with the syslog logger:

以下は syslog ロガーを使う例です：

.. code-block:: bash

   $ docker run -it --rm \
       --log-driver syslog \
       --log-opt tag="{{ (.ExtraAttributes nil).SOME_ENV_VAR }}" \
       --log-opt env=SOME_ENV_VAR \
       -e SOME_ENV_VAR=logtester.1234 \
       flyinprogrammer/logtester

.. Results in logs like this:

ログの結果は次のようになります。

.. code-block:: bash

   Apr  1 15:22:17 ip-10-27-39-73 docker/logtester.1234[45499]: + exec app
   Apr  1 15:22:17 ip-10-27-39-73 docker/logtester.1234[45499]: 2016-04-01 15:22:17.075416751 +0000 UTC stderr msg: 1


..    Note:The driver specific log options syslog-tag, fluentd-tag and gelf-tag still work for backwards compatibility. However, going forward you should standardize on using the generic tag log option instead.

.. note::

   ドライバがログのオプション ``syslog-tag`` 、 ``fluentd-tag`` 、 ``gelf-tag`` を指定しても後方互換性があります。ですが、これらの代わりに、標準化のため一般的な ``tag`` ログ・オプションを使うべきです。

.. seealso:: 

   Log tags for logging driver
      https://docs.docker.com/engine/admin/logging/log_tags/
