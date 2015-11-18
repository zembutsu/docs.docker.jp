.. http://docs.docker.com/compose/networking/
.. doc version: 1.9
.. check date: 2015/11/18

.. Networking in Compose

==============================
Compose のネットワーク機能
==============================

.. Note: Compose’s networking support is experimental, and must be explicitly enabled with the docker-compose --x-networking flag.

.. note::

   Compose のネットワーク機能のサポートは実験的であり、利用するためには ``docker-compose --x-networking`` フラグで明示する必要があります。

.. Compose sets up a single default network for your app. Each container for a service joins the default network and is both reachable by other containers on that network, and discoverable by them at a hostname identical to the container name.

Compose はアプリケーションに対して、デフォルト・ :doc:`ネットワーク </engine/reference/commandline/network_create>` を１つ設定します。各コンテナ上のサービスはデオフォルト・ネットワークに参加し、そのネットワーク上の他のコンテナとは *通信可能* です。しかしコンテナ名はホスト名とは独立しているため、*名前では発見できません* 。

..     Note: Your app’s network is given the same name as the “project name”, which is based on the name of the directory it lives in. See the Command line overview for how to override it.

.. note::

   アプリケーション用のネットワークには、"プロジェクト名" と同じ名前が割り当てられます。プロジェクト李名とは、作業している基準の（ベースとなる）ディレクトリ名です。変更方法は :doc:`コマンドラインの概要 </compose/reference/docker-compose>` をご覧ください。

.. For example, suppose your app is in a directory called myapp, and your docker-compose.yml looks like this:

例として、アプリケーションを置いたディレクトリ名を ``myapp`` とし、``docker-compose.yml`` は次のような内容とします。

.. code-block:: yaml

   web:
     build: .
     ports:
       - "8000:8000"
   db:
     image: postgres

.. When you run docker-compose --x-networking up, the following happens:

``docker-compose --x-networking up`` を実行すると、次の動作します。

..     A network called myapp is created.
    A container is created using web’s configuration. It joins the network myapp under the name myapp_web_1.
    A container is created using db’s configuration. It joins the network myapp under the name myapp_db_1.

1. ``myapp`` という名称のネットワークを作成します。
2. ``web`` 設定を使ったコンテナを作成します。これをネットワーク ``myapp`` に対して、``myapp_web_1`` という名称で追加します。
3. ``db`` 設定を使ったコンテナを作成します。これをネットワーク ``myapp`` に対して ``myapp_db_1`` という名称で追加します。

.. Each container can now look up the hostname myapp_web_1 or myapp_db_1 and get back the appropriate container’s IP address. For example, web’s application code could connect to the URL postgres://myapp_db_1:5432 and start using the Postgres database.

各コンテナは、これでホスト名を ``myapp_web_1`` あるいは ``myapp_db_1`` で名前解決することにより、コンテナに割り当てられた IP アドレスが分かります。例えば、``web`` アプリケーションのコードが URL  ``postgres://myapp_db_1:5432`` にアクセスできるようになり、PostgreSQL データベースを利用開始します。

.. Because web explicitly maps a port, it’s also accessible from the outside world via port 8000 on your Docker host’s network interface.

``web`` はポートの割り当てを明示しているため、Docker ホスト側のネットワーク・インターフェース上からも、ポート 8000 を通して外からアクセス可能です。

.. Note: in the next release there will be additional aliases for the container, including a short name without the project name and container index. The full container name will remain as one of the alias for backwards compatibility.


[TBD]
