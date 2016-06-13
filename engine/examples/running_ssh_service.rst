.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/extend/examples/running_ssh_service/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/examples/running_ssh_service.md
   doc version: 1.12
      https://github.com/docker/docker/commits/master/docs/examples/running_ssh_service.md
.. check date: 2016/06/13
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. ---------------------------------------------------------------

.. Dockerizing an SSH daemon service

.. _dockerizing-a-ssh-service:

=======================================
SSH デーモン用サービスの Docker 化
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Build an eg_sshd image

.. _build-an-eg-sshd-image:

``eg_sshd`` イメージの構築
==============================

.. The following Dockerfile sets up an SSHd service in a container that you can use to connect to and inspect other container’s volumes, or to get quick access to a test container.

以下の ``Dockerfile`` はコンテナ内に SSHd サービスをセットアップします。これは他のコンテナ用ボリュームの調査や、テスト用コンテナに対する迅速なアクセスを提供します。

.. code-block:: bash

   # sshd
   #
   # VERSION               0.0.2
   
   FROM ubuntu:14.04
   MAINTAINER Sven Dowideit <SvenDowideit@docker.com>
   
   RUN apt-get update && apt-get install -y openssh-server
   RUN mkdir /var/run/sshd
   RUN echo 'root:screencast' | chpasswd
   RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
   
   # SSH login fix. Otherwise user is kicked off after login
   RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
   
   ENV NOTVISIBLE "in users profile"
   RUN echo "export VISIBLE=now" >> /etc/profile
   
   EXPOSE 22
   CMD ["/usr/sbin/sshd", "-D"]

.. Build the image using:

イメージを構築するには：

.. code-block:: bash

   $ docker build -t eg_sshd .

.. Run a test_sshd container

.. _run-a-test-sshd-container:

``test_sshd`` コンテナの実行
==============================

.. Then run it. You can then use docker port to find out what host port the container’s port 22 is mapped to:

次は実行します。 ``docker port`` を使い、コンテナのポート 22 がホスト側のどのポートに割り当て（マップ）されているか確認できます。

.. code-block:: bash

   $ docker run -d -P --name test_sshd eg_sshd
   $ docker port test_sshd 22
   0.0.0.0:49154

.. And now you can ssh as root on the container’s IP address (you can find it with docker inspect) or on port 49154 of the Docker daemon’s host IP address (ip address or ifconfig can tell you that) or localhost if on the Docker daemon host:

それから、コンテナに 対して ``root`` として SSH できます。接続先は、 IP アドレス（これは ``docker inspect`` で確認できます ）か、Docker デーモンの IP アドレス（ ``ip address`` や ``ifconfig`` で確認できます ）上のポート ``49154`` か、Docker デーモンのホスト ``localhost`` です。 

.. code-block:: bash

   $ ssh root@192.168.1.2 -p 49154
   # パスワードは ``screencast`` です。
   $$

.. Environment variables

.. _ssh-environment-variables:

環境変数
==========

.. Using the sshd daemon to spawn shells makes it complicated to pass environment variables to the user’s shell via the normal Docker mechanisms, as sshd scrubs the environment before it starts the shell.

``sshd`` デーモンでシェルを呼び出すのは複雑です。シェルを起動する前に ``sshd`` 環境を調整し、 環境変数をユーザのシェルから通常のDocker のメカニズムに対して渡す必要があるためです。

.. If you’re setting values in the Dockerfile using ENV, you’ll need to push them to a shell initialization file like the /etc/profile example in the Dockerfile above.

値を設定するためには、 ``Dockerfile`` で ``ENV`` を使います。先ほどの ``Dockerfile`` の例では、シェルの初期化のために ``/etc/profile`` を送る必要があるでしょう。

.. If you need to passdocker run -e ENV=value values, you will need to write a short script to do the same before you start sshd -D and then replace the CMD with that script.

``docker run -e ENV=value`` で値を渡す必要がある場合は、同様の処理を行うスクリプトを準備する必要があります。そのためには ``sshd -D`` を ``CMD`` 命令に置き換え、その準備したスクリプトを実行します。

.. Clean up

.. _ssh-clean-up:

クリーンアップ
====================

.. Finally, clean up after your test by stopping and removing the container, and then removing the image.

最後に、テストの後でコンテナの停止と削除をし、そのイメージを削除します。

.. code-block:: bash

   $ docker stop test_sshd
   $ docker rm test_sshd
   $ docker rmi eg_sshd

.. seealso:: 

   Dockerizing an SSH daemon service
      https://docs.docker.com/engine/examples/running_ssh_service/

