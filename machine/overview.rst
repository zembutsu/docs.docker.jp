.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/machine/overview/
.. SOURCE: https://github.com/docker/machine/blob/master/docs/overview.md
   doc version: 1.10
      https://github.com/docker/machine/commits/master/docs/overview.md
.. check date: 2016/02/16
.. -------------------------------------------------------------------

.. _machine:

.. Docker Machine Overview

=======================================
Docker Machine 概要
=======================================

.. You can use Docker Machine to:

Docker Machine を使い、以下の操作ができます。

..    Install and run Docker on Mac or Windows
    Provision and manage multiple remote Docker hosts
    Provision Swarm clusters

* Mac や Windows 上に Docker をインストール・実行
* 複数のリモート Docker ホストを構築・管理
* Swarm クラスタの構築（プロビジョン）

.. What is Docker Machine?

.. _what-is-docker-machine:

Docker Machine とは何ですか？
==============================

.. Docker Machine is a tool that lets you install Docker Engine on virtual hosts, and manage the hosts with docker-machine commands. You can use Machine to create Docker hosts on your local Mac or Windows box, on your company network, in your data center, or on cloud providers like AWS or Digital Ocean.

Docker Machine は

.. Using docker-machine commands, you can start, inspect, stop, and restart a managed host, upgrade the Docker client and daemon, and configure a Docker client to talk to your host.

.. Point the Machine CLI at a running, managed host, and you can run docker commands directly on that host. For example, run docker-machine env default to point to a host called default, follow on-screen instructions to complete env setup, and run docker ps, docker run hello-world, and so forth.


.. Why should I use it?

.. _why-shoud-i-use-it:

なぜ使うべきですか？
=====================



Machine is currently the only way to run Docker on Mac or Windows, and the best way to provision multiple remote Docker hosts on various flavors of Linux.

Docker Machine has these two broad use cases.

    I want to run Docker on Mac or Windows

Docker Machine on Mac and Windows

If you work primarily on a Mac or Windows laptop or desktop, you need Docker Machine in order to “run Docker” (that is, Docker Engine) locally. Installing Docker Machine on a Mac or Windows box provisions a local virtual machine with Docker Engine, gives you the ability to connect it, and run docker commands.

    I want to provision Docker hosts on remote systems

Docker Machine for provisioning multiple systems

Docker Engine runs natively on Linux systems. If you have a Linux box as your primary system, and want to run docker commands, all you need to do is download and install Docker Engine. However, if you want an efficient way to provision multiple Docker hosts on a network, in the cloud or even locally, you need Docker Machine.

Whether your primary system is Mac, Windows, or Linux, you can install Docker Machine on it and use docker-machine commands to provision and manage large numbers of Docker hosts. It automatically creates hosts, installs Docker Engine on them, then configures the docker clients. Each managed host (”machine”) is the combination of a Docker host and a configured client.
What’s the difference between Docker Engine and Docker Machine?

When people say “Docker” they typically mean Docker Engine, the client-server application made up of the Docker daemon, a REST API that specifies interfaces for interacting with the daemon, and a command line interface (CLI) client that talks to the daemon (through the REST API wrapper). Docker Engine accepts docker commands from the CLI, such as docker run <image>, docker ps to list running containers, docker images to list images, and so on.

Docker Engine

Docker Machine is a tool for provisioning and managing your Dockerized hosts (hosts with Docker Engine on them). Typically, you install Docker Machine on your local system. Docker Machine has its own command line client docker-machine and the Docker Engine client, docker. You can use Machine to install Docker Engine on one or more virtual systems. These virtual systems can be local (as when you use Machine to install and run Docker Engine in VirtualBox on Mac or Windows) or remote (as when you use Machine to provision Dockerized hosts on cloud providers). The Dockerized hosts themselves can be thought of, and are sometimes referred to as, managed “machines”.



.. Where to go next

次はどこへ行きますか？
==============================

..    Install a machine on your local system using VirtualBox.
    Install multiple machines on your cloud provider.
    Docker Machine driver reference
    Docker Machine subcommand reference

* machine を :doc:`ローカルの VirtualBox を使ったシステム </machine/get-started>` にインストール
* 複数の machine を :doc:`クラウド・プロバイダ </machine/get-started-cloud/>` にインストール
* :doc:`Docker Machine ドライバ・リファレンス </machine/drivers>`
* :doc:`Docker Machine サブコマンド・リファレンス </machine/reference>`

