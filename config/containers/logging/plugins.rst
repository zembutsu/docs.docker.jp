.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/logging/plugins/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/logging/plugins.md
   doc version: 20.10
.. check date: 2022/04/28
.. Commits on Apr 8, 2020 b0f90615659ac1319e8d8a57bb914e49d174242e
.. ---------------------------------------------------------------------------

.. Use a logging driver plugin

.. _use-a-logging-driver-plugin:

=======================================
ロギング・ドライバプラグインを使う
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:


.. Docker logging plugins allow you to extend and customize Docker’s logging capabilities beyond those of the built-in logging drivers. A logging service provider can implement their own plugins and make them available on Docker Hub, or a private registry. This topic shows how a user of that logging service can configure Docker to use the plugin.

Docker ロギング・プラグインは、 :doc:`内蔵のロギング・ドライバ <configure>` よりも  Docker のログ記録機能を拡張およびカスタマイズできるようにします。ロギングのサービスプロバイダは、 :doc:`自身でプラグインを実装 </engine/extend/plugins_logging>` 可能であり、それらを Docker Hub 上やプライベート・レジストリで利用可能にできます。このトピックでは、ロギング・サービスの利用者が、 Docker でプラグインを使うための設定について扱います。

.. Install the logging driver plugin

.. _install-the-logging-driver-plugin:

ロギング・ドライバ・プラグインのインストール
==================================================

.. To install a logging driver plugin, use docker plugin install <org/image>, using the information provided by the plugin developer.

ロギング・ドライバ・プラグインをインストールするには、 ``docker plugin install <組織/イメージ>`` を使います。ここにはプラグイン開発者が提供している情報を入れます。

.. You can list all installed plugins using docker plugin ls, and you can inspect a specific plugin using docker inspect.

全てのインストール済みプラグインの確認は ``docker plugin ls`` を使い、特定のプラグインの調査には ``docker inspect`` を使います。

.. Configure the plugin as the default logging driver

.. _configure-the-plugin-as-the-default-logging-driver:

プラグインをデフォルトのロギング・ドライバとして設定
============================================================

.. After the plugin is installed, you can configure the Docker daemon to use it as the default by setting the plugin’s name as the value of the log-driver key in the daemon.json, as detailed in the logging overview. If the logging driver supports additional options, you can set those as the values of the log-opts array in the same file.

プラグインをインストール後、Docker デーモンに対してデフォルトで使うように指定するには、 :ref:`ロギング概要 <configure-the-default-logging-driver>` で詳細を扱ったように、 ``daemon.json`` 内の ``log-driver`` キーの値にプラグインの名前を指定します。もしもロギング・ドライバが追加オプションをサポートしている場合、同じファイル内の ``log-opts`` アレイ内で値を設定できます。

.. Configure a container to use the plugin as the logging driver

.. _configure-a-container-to-use-the-plugin-as-the-logging-driver:

コンテナが使うロギング・ドライバを、プラグインとして指定
============================================================

.. After the plugin is installed, you can configure a container to use the plugin as its logging driver by specifying the --log-driver flag to docker run, as detailed in the logging overview. If the logging driver supports additional options, you can specify them using one or more --log-opt flags with the option name as the key and the option value as the value.

プラグインのインストール後、コンテナでプラグインをロギング・ドライバとして使うには、 ``docker run`` 時に ``--log-driver`` フラグを付けます。詳細は :ref:`ロギング概要 <configure-the-logging-driver-for-a-container>` をご覧ください。もしもロギング・ドライバが追加オプションをサポートしている場合、同じファイル内の ``log-opts`` アレイ内で値を設定できます。

.. seealso:: 

   Use a logging driver plugin
      https://docs.docker.com/config/containers/logging/plugins/
