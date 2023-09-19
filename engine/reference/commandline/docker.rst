.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/commandline/docker/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/commandline/docker.md
.. check date: 2022/02/12
.. -------------------------------------------------------------------

.. docker

=======================================
docker
=======================================

.. Description

説明
==========

.. The base command for the Docker CLI.

Docker CLI のベース（基本）コマンドです。

.. Child commands

子コマンド
==========

.. list-table::
   :header-rows: 1

   * - コマンド
     - 説明
   * - :doc:`docker attach <attach>`
     - 実行中のコンテナに :ruby:`アタッチ <attach>` し、ローカルの標準入力、出力、エラーをストリーム
   * - :doc:`docker build <build>`
     - Dockerfile からイメージを :ruby:`構築 <build>`
   * - :doc:`docker builder <builder>`
     - 構築を管理
   * - :doc:`docker checkpoint <checkpoint>`
     - チェックポイントを管理
   * - :doc:`docker commit <commit>`
     - コンテナの変更から新しいイメージを作成
   * - :doc:`docker config <config>`
     - Docker configs を管理
   * - :doc:`docker container <container>`
     - コンテナを管理
   * - :doc:`docker context <context>`
     - コンテクストを管理
   * - :doc:`docker cp <cp>`
     - コンテナとローカルファイルシステム間でファイルやフォルダをコピー
   * - :doc:`docker create <create>`
     - 新しいコンテナを作成
   * - :doc:`docker diff <diff>`
     - コンテナのファイルシステム上で、ファイルやディレクトリの変更を調査
   * - :doc:`docker events <events>`
     - サーバからリアルタイムにイベントを取得
   * - :doc:`docker exec <exec>`
     - 実行中のコンテナ内でコマンドを実行
   * - :doc:`docker export <export>`
     - コンテナのファイルシステムを tar アーカイブとして :ruby:`出力 <export>`
   * - :doc:`docker history <history>`
     - イメージの履歴を表示
   * - :doc:`docker image <image>`
     - イメージの管理
   * - :doc:`docker images <images>`
     - イメージ一覧表示
   * - :doc:`docker import <import>`
     - tar ボールから内容を読み込み、システムイメージを作成
   * - :doc:`docker info <info>`
     - システム情報の表示
   * - :doc:`docker inspect <inspect>`
     - Docker オブジェクトの :ruby:`下位情報 <low-level>` を返す
   * - :doc:`docker kill <kill>`
     - 1つまたは複数の実行中コンテナを :ruby:`強制停止 <kill>`
   * - :doc:`docker load <load>`
     - tar アーカイブか STDIN（標準入力）からイメージを読み込む
   * - :doc:`docker login <login>`
     - Docker レジストリにログイン
   * - :doc:`docker logout <logout>`
     - Docker レジストリからログアウト
   * - :doc:`docker logs <logs>`
     - コンテナのログを取得
   * - :doc:`docker manifest <manifest>`
     - Docker イメージマニフェストの管理と、マニフェスト一覧表示
   * - :doc:`docker network <network>`
     - ネットワークの管理
   * - :doc:`docker node <node>`
     - Swarm ノードの管理
   * - :doc:`docker pause <pause>`
     - 1つまたは複数のコンテナ内の全プロセスを一次停止
   * - :doc:`docker plugin <plugin>`
     - プラグインの管理
   * - :doc:`docker port <port>`
     - ポート割り当て一覧か、特定のコンテナに対する割り当てを表示
   * - :doc:`docker ps <ps>`
     - コンテナ一覧表示
   * - :doc:`docker pull <pull>`
     - レジストリからイメージやリポジトリを取得
   * - :doc:`docker push <push>`
     - レジストリにイメージやリポジトリを送信
   * - :doc:`docker rename <rename>`
     - コンテナの名前を変更
   * - :doc:`docker restart <restart>`
     - 1つまたは複数のコンテナを再起動
   * - :doc:`docker rm <rm>`
     - 1つまたは複数のコンテナを削除
   * - :doc:`docker rmi <rmi>`
     - 1つまたは複数のイメージを削除
   * - :doc:`docker run <run>`
     - 新しいコンテナを実行するコマンド
   * - :doc:`docker save <save>`
     - 1つまたは複数のイメージを tar アーカイブに保存（デフォルトは STDOUT に流す）
   * - :doc:`docker search <search>`
     - Docker Hub でイメージを検索
   * - :doc:`docker secret <secret>`
     - Docker シークレットの管理
   * - :doc:`docker service <service>`
     - サービスの管理
   * - :doc:`docker stack <stack>`
     - Docker スタックの管理
   * - :doc:`docker start <start>`
     - 1つまたは複数の停止済みコンテナを起動
   * - :doc:`docker stat <stat>`
     - コンテナのリソース利用統計情報を、常時画面に表示し続ける
   * - :doc:`docker stop <stop>`
     - 1つまたは複数のコンテナを停止
   * - :doc:`docker swarm <swarm>`
     - Swarm の管理
   * - :doc:`docker system <system>`
     - Docker の管理
   * - :doc:`docker tag <tag>`
     - 対象のイメージに対し、元イメージを参照するタグを作成
   * - :doc:`docker top <top>`
     - コンテナで実行中のプロセスを表示
   * - :doc:`docker trust <trust>`
     - Docker イメージの信頼性を管理
   * - :doc:`docker unpause <unpause>`
     - 1つまたは複数のコンテナ内で、プロセスの一次停止を全て解除
   * - :doc:`docker update <update>`
     - 1つまたは複数のコンテナの設定情報を更新
   * - :doc:`docker version <version>`
     - Docker バージョン情報を表示
   * - :doc:`docker volume <volume>`
     - ボリュームの管理
   * - :doc:`docker wait <wait>`
     - 1つまたは複数のコンテナを停止するまでブロックし、その後、それらの終了コードを表示


.. seealso:: 

   docker
      https://docs.docker.com/engine/reference/commandline/docker/

