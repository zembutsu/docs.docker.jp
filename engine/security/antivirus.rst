.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/security/antivirus/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/security/antivirus.md
   doc version: 19.03
.. check date: 2020/07/04
.. Commits on Jan 16, 1029 e515aa26d2cadd4468db7c75992e0c1f5ae7eee7
.. -------------------------------------------------------------------

.. Antivirus software and Docker

.. _antivirus-software-and-docker:

========================================
アンチウイルス・ソフトウェアと Docker
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3

.. When antivirus software scans files used by Docker, these files may be locked in a way that causes Docker commands to hang.

アンチウイルス・ソフトウェアが Docker が使っているファイルをスキャンするとき、これらのファイルがロックされることにより、 Docker コマンドのハングを引き起こす可能性があります。

.. One way to reduce these problems is to add the Docker data directory (/var/lib/docker on Linux, %ProgramData%\docker on Windows Server, or $HOME/Library/Containers/com.docker.docker/ on Mac) to the antivirus’s exclusion list. However, this comes with the trade-off that viruses or malware in Docker images, writable layers of containers, or volumes are not detected. If you do choose to exclude Docker’s data directory from background virus scanning, you may want to schedule a recurring task that stops Docker, scans the data directory, and restarts Docker.

これらの問題を減らすための1つの方法は、 Docker データディレクトリ（ Linux 上は ``/var/lib/docker`` 、 Windows Server は ``%ProgramData%\docker`` 、 Mac は ``$HOME/Library/Containers/com.docker.docker/``  ）をアンチウイルスの例外に指定することです。しかしながら、これはトレードオフです。Docker イメージ内にウイルスやマルウェアがあれば、コンテナ内の書き込み可能なレイヤや、ボリュームにあったとしても、それらが検知出来ません。Docker のデータ・ディレクトリをバックグラウンドでのウイルス・スキャンから除外するのを選ぶ場合は、定期的なタスクを予定し、Docker を停止、データ・ディレクトリのスキャン、Docker 再起動の実施を検討したほうがよいでしょう。

.. seealso:: 

   Antivirus software and Docker
      https://docs.docker.com/engine/security/antivirus/
