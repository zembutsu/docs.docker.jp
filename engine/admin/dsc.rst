.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/admin/dsc/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/admin/dsc.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/admin/dsc.md
.. check date: 2016/06/13
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------------------

.. Using PowerShell DSC

=======================================
PowerShell DSC で使う
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Windows PowerShell Desired State Configuration (DSC) is a configuration management tool that extends the existing functionality of Windows PowerShell. DSC uses a declarative syntax to define the state in which a target should be configured. More information about PowerShell DSC can be found at http://technet.microsoft.com/en-us/library/dn249912.aspx.

Windows PowerShell DSC (Desired State Configuration) は設定管理ツールです。これは Windows PowerShell の機能を拡張します。DSC は宣言型の構文を使いターゲットがどのような状態になるかを設定します。PowerShell DSC に関する詳しい情報は、 `Microsoft 社のサイト <https://technet.microsoft.com/ja-jp/library/dn249912.aspx?f=255&mspperror=-2147217396>`_ をご覧ください。

.. Requirements

動作条件
==========

.. To use this guide you’ll need a Windows host with PowerShell v4.0 or newer.

このガイドの利用にあたり、Windows ホストは PowerShell v4.0 以上の必要があります。

.. The included DSC configuration script also uses the official PPA so only an Ubuntu target is supported. The Ubuntu target must already have the required OMI Server and PowerShell DSC for Linux providers installed. More information can be found at https://github.com/MSFTOSSMgmt/WPSDSCLinux. The source repository listed below also includes PowerShell DSC for Linux installation and init scripts along with more detailed installation information.

DSC 設定に含まれるスクリプトは、公式では Ubuntu ターゲットのみサポートされています。 Ubuntu ターゲットは OMI サーバと PowerShell DSC for Linux providers のインストールが必要です。詳しい情報は https://github.com/MSFTOSSMgmt/WPSDSCLinux をご覧ください。ソース・リポジトリの一覧に、PowerShell DSC for Linux のインストール方法や、初期化スクリプトに関するより詳しい情報があります。

.. Installation

インストール
====================

.. The DSC configuration example source is available in the following repository: https://github.com/anweiss/DockerClientDSC. It can be cloned with:

DSC 設定例のソースは次のリポジトリ https://github.com/anweiss/DockerClientDSC から利用可能です。クローンも可能です。

.. code-block:: bash

   $ git clone https://github.com/anweiss/DockerClientDSC.git

.. Usage

使い方
==========

.. The DSC configuration utilizes a set of shell scripts to determine whether or not the specified Docker components are configured on the target node(s). The source repository also includes a script (RunDockerClientConfig.ps1) that can be used to establish the required CIM session(s) and execute the Set-DscConfiguration cmdlet.

DSC 設定はシェルスクリプトのセットを使い、どこに Docker の構成物を置くかや、ターゲット・ノードの設定を行います。ソース・リポジトリはスクリプト（ ``RunDockerClientConfig.ps1`` があり）、CIM セッションに必要な接続と、 ``Set-DscConfiguration`` cmdlet の実行に使います。

.. More detailed usage information can be found at https://github.com/anweiss/DockerClientDSC.

より詳細な情報は次の URL をご覧ください。https://github.com/anweiss/DockerClientDSC

.. Install Docker

Docker インストール
--------------------

.. The Docker installation configuration is equivalent to running:

.. code-block:: bash

   apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys\
   36A1D7869245C8950F966E92D8576A8BA88D21E9
   sh -c "echo deb https://apt.dockerproject.org/repo ubuntu-trusty main\
   > /etc/apt/sources.list.d/docker.list"
   apt-get update
   apt-get install docker-engine

.. Ensure that your current working directory is set to the DockerClientDSC source and load the DockerClient configuration into the current PowerShell session

現在の作業ディレクトリが ``DockerClientDSC`` ソースに設定されていることを確認し、Docker クライアント設定を現在の PowerShell セッションに反映します。

.. code-block:: bash

   . .\DockerClient.ps1

.. Generate the required DSC configuration .mof file for the targeted node

ターゲット・ノード用の DSC 設定に必要な .mof ファイルを生成します。

.. code-block:: bash

   DockerClient -Hostname "myhost"

.. A sample DSC configuration data file has also been included and can be modified and used in conjunction with or in place of the Hostname parameter:

サンプルの DSC 設定データ・ファイルは、 ``Hostname`` パラメータの情報を元に連結されます。

.. code-block:: bash

   DockerClient -ConfigurationData .\DockerConfigData.psd1

.. Start the configuration application process on the targeted node

ターゲット・ノードでアプリケーション設定プロセスを開始します。

.. code-block:: bash

    .\RunDockerClientConfig.ps1 -Hostname "myhost"

.. The RunDockerClientConfig.ps1 script can also parse a DSC configuration data file and execute configurations against multiple nodes as such:

``RunDockerClientConfig.ps1`` スクリプトは DSC 設定データファイルもパースして、次のように複数のノードに対して設定を反映します。

.. code-block:: bash

   .\RunDockerClientConfig.ps1 -ConfigurationData .\DockerConfigData.psd1

.. Images

イメージ
==========

.. Image configuration is equivalent to running: docker pull [image] or docker rmi -f [IMAGE].

イメージ設定とは  ``docker pull [image]`` あるいは ``docker rmi -f [IMAGE]`` 処理と同等です。

.. Using the same steps defined above, execute DockerClient with the Image parameter and apply the configuration:

先ほどのステップで定義したファイルを使い、 ``DockerClient`` の ``Image`` パラメータで設定を追加します。

.. code-block:: bash

   DockerClient -Hostname "myhost" -Image "node"
   .\RunDockerClientConfig.ps1 -Hostname "myhost"

.. You can also configure the host to pull multiple images:

ホストに対して複数のイメージを取得する設定も可能です。

.. code-block:: bash

   DockerClient -Hostname "myhost" -Image "node","mongo"
   .\RunDockerClientConfig.ps1 -Hostname "myhost"

.. To remove images, use a hashtable as follows:

イメージを削除するには、次のようにハッシュ・テーブルを使います。

.. code-block:: bash

   DockerClient -Hostname "myhost" -Image @{Name="node"; Remove=$true}
   .\RunDockerClientConfig.ps1 -Hostname $hostname

.. Containers

コンテナ
==========

.. Container configuration is equivalent to running:

コンテナの設定は次のように行います。

.. code-block:: bash

   docker run -d --name="[containername]" -p '[port]' -e '[env]' --link '[link]'\
   '[image]' '[command]'

.. or

あるいは

.. code-block:: bash

   docker rm -f [containername]

.. To create or remove containers, you can use the Container parameter with one or more hashtables. The hashtable(s) passed to this parameter can have the following properties:

コンテナを作成・削除するには、１つまたは複数の ``コンテナ`` をハッシュ・テーブルで指定します。ハッシュ・テーブルは次のプロパティのパラメータを指定します。

..    Name (required)
    Image (required unless Remove property is set to $true)
    Port
    Env
    Link
    Command
    Remove

* Name（必須）
* Image（Remove プロパティが ``$true`` の以外は必要）
* Port
* Env
* Link
* Command
* Remove

.. For example, create a hashtable with the settings for your container:

例えば、ハッシュテーブルの設定でコンテナを作成するには、次のようにします。

.. code-block:: bash

   $webContainer = @{Name="web"; Image="anweiss/docker-platynem"; Port="80:80"}

.. Then, using the same steps defined above, execute DockerClient with the -Image and -Container parameters:

それから、先補との定義と同じ手順で ``DockerClient`` に ``-Image``  と ``-Container`` パラメータを使います。

.. code-block:: bash

   DockerClient -Hostname "myhost" -Image node -Container $webContainer
   .\RunDockerClientConfig.ps1 -Hostname "myhost"

.. Existing containers can also be removed as follows:

既存のコンテナは次のように削除できます。

.. code-block:: bash

   $containerToRemove = @{Name="web"; Remove=$true}
   DockerClient -Hostname "myhost" -Container $containerToRemove
   .\RunDockerClientConfig.ps1 -Hostname "myhost"

.. Here is a hashtable with all of the properties that can be used to create a container:

このハッシュテーブルは全てのパラメータを使い、コンテナを作成しています。

.. code-block:: bash

   $containerProps = @{Name="web"; Image="node:latest"; Port="80:80"; `
   Env="PORT=80"; Link="db:db"; Command="grunt"}

.. seealso:: 

   Using PowerShell DSC
      https://docs.docker.com/engine/admin/dsc/
