.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/compose/gpu-support/
.. SOURCE: 
   doc version: v20.10
      https://github.com/docker/docker.github.io/blob/master/compose/gpu-support.md
.. check date: 2022/07/17
.. Commits on Sep 7, 2021 03ee3ec67275e65ea0b1c626d0b819ab78211df1
.. ----------------------------------------------------------------------------

.. Enabling GPU access with Compose
.. _enabling-gpu-access-with-compose:

=====================================================
Compose で GPU アクセスの有効化
=====================================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Compose services can define GPU device reservations if the Docker host contains such devices and the Docker Daemon is set accordingly. For this, make sure to install the prerequisites if you have not already done so.

Docker ホストに GPU デバイスが入っており、かつ、 Docker デーモンで適切な設定がある場合、 Compose サービスで GPU デバイス予約を定義できます。このために、 :ref:`必要条件 <resource_constraints_gpu>` のインストールがまだであれば、終えておく必要があります。

.. The examples in the following sections focus specifically on providing service containers access to GPU devices with Docker Compose. You can use either docker-compose or docker compose commands.

以下のセクションにある例では、 サービス用コンテナが GPU デバイスにアクセスするため、Docker Compose での設定方法に焦点を絞ります。 ``docker-compose`` と ``docker compose`` 、どちらのコマンドも使えます。

.. Use of service runtime property from Compose v2.3 format (legacy)
.. _use-of-service-runtime-property-from-compose-v23-format:

Compose v2.3 形式から サービス ``runtime`` プロパティを使う（古い方法）
================================================================================

.. Docker Compose v1.27.0+ switched to using the Compose Specification schema which is a combination of all properties from 2.x and 3.x versions. This re-enabled the use of service properties as runtime to provide GPU access to service containers. However, this does not allow to have control over specific properties of the GPU devices.

Docker Compose v1.27.0 以上では、2.x と 3.x バージョンの全てのプロパティを統合した Compose Specification スキームを使うように切り替わりました。これにより、サービス用コンテナが GPU にアクセスできるようにするための、 :ref:`runtime <compose-file-runtime>` サービス プロパティを再び使えるようになります。しかし、こちらを使うと、 GPU デバイスにある特定のプロパティを制御できません。

.. code-block:: yaml

   services:
     test:
       image: nvidia/cuda:10.2-base
       command: nvidia-smi
       runtime: nvidia

.. Enabling GPU access to service containers
.. _enabling-gpu-access-to-service-containers:

サービス用コンテナで GPU アクセスの有効化
==================================================

.. Docker Compose v1.28.0+ allows to define GPU reservations using the device structure defined in the Compose Specification. This provides more granular control over a GPU reservation as custom values can be set for the following device properties:

Docker Compose v1.28.0 以上では、Compose Specification の `device <https://github.com/compose-spec/compose-spec/blob/master/deploy.md#devices>`_ 構造の定義を使い、 GPU 指定の定義が可能です。これにより、以下のデバイス プロパティに任意の値を指定できるため、 GPU 指定を細かく制御できるようになります。

..  capabilities - value specifies as a list of strings (eg. capabilities: [gpu]). You must set this field in the Compose file. Otherwise, it returns an error on service deployment.
    count - value specified as an int or the value all representing the number of GPU devices that should be reserved ( providing the host holds that number of GPUs).
    device_ids - value specified as a list of strings representing GPU device IDs from the host. You can find the device ID in the output of nvidia-smi on the host.
    driver - value specified as a string (eg. driver: 'nvidia')
    options - key-value pairs representing driver specific options.

* `capabilities <https://github.com/compose-spec/compose-spec/blob/master/deploy.md#capabilities>`_ - 文字列のリストとして値を指定（例： ``capabilities: [gpu]`` ）。このフィールドを Compose ファイル内で指定する必要がある。そうしなければ、サービスのデプロイ時、エラーが返る。
* `count <https://github.com/compose-spec/compose-spec/blob/master/deploy.md#count>`_ - 予約すべき GPU デバイス（ホストが保持している GPU 数）を整数値として指定するか ``all`` 値で指定。
* `device_ids <https://github.com/compose-spec/compose-spec/blob/master/deploy.md#device_ids>`_ - ホスト上で予約する GPU デバイスの ID を表す文字列を値として指定。デバイス ID はホスト上で ``nvidia-smi`` の出力で確認できる。
* `driver <https://github.com/compose-spec/compose-spec/blob/master/deploy.md#driver>`_ - 文字列の値として指定（例： ``driver: 'nvidia'`` ）
* `options <https://github.com/compose-spec/compose-spec/blob/master/deploy.md#options>`_ - ドライバ固有のオプションを表す :ruby:`キーバリューの組み合わせ <key-value pairs>` 

..  Note
    You must set the capabilities field. Otherwise, it returns an error on service deployment.
    count and device_ids are mutually exclusive. You must only define one field at a time.

.. note::

   ``capabilities`` フィールドの指定が必須です。そうしなければ、サービスのデプロイ時にエラーが返ります。
   ``count`` と ``device_ids`` は互いに矛盾します。フィールドでは、一度に一方しか指定できません。

.. For more information on these properties, see the deploy section in the Compose Specification.

各プロパティに関する情報は、 `Compose Specification <https://github.com/compose-spec/compose-spec/blob/master/deploy.md#devices>`_ の ``deploy`` セクションをご覧ください。

.. Example of a Compose file for running a service with access to 1 GPU device:

この Compose ファイル例は、1 GPU デバイスにアクセスするサービスを実行：

.. code-block:: yaml

   services:
     test:
       image: nvidia/cuda:10.2-base
       command: nvidia-smi
       deploy:
         resources:
           reservations:
             devices:
               - driver: nvidia
                 count: 1
                 capabilities: [gpu]

.. Run with Docker Compose:

Docker Compose で実行：

.. code-block:: bash

   $ docker-compose up
   Creating network "gpu_default" with the default driver
   Creating gpu_test_1 ... done
   Attaching to gpu_test_1    
   test_1  | +-----------------------------------------------------------------------------+
   test_1  | | NVIDIA-SMI 450.80.02    Driver Version: 450.80.02    CUDA Version: 11.1     |
   test_1  | |-------------------------------+----------------------+----------------------+
   test_1  | | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
   test_1  | | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
   test_1  | |                               |                      |               MIG M. |
   test_1  | |===============================+======================+======================|
   test_1  | |   0  Tesla T4            On   | 00000000:00:1E.0 Off |                    0 |
   test_1  | | N/A   23C    P8     9W /  70W |      0MiB / 15109MiB |      0%      Default |
   test_1  | |                               |                      |                  N/A |
   test_1  | +-------------------------------+----------------------+----------------------+
   test_1  |                                                                                
   test_1  | +-----------------------------------------------------------------------------+
   test_1  | | Processes:                                                                  |
   test_1  | |  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
   test_1  | |        ID   ID                                                   Usage      |
   test_1  | |=============================================================================|
   test_1  | |  No running processes found                                                 |
   test_1  | +-----------------------------------------------------------------------------+
   gpu_test_1 exited with code 0

.. If no count or device_ids are set, all GPUs available on the host are going to be used by default.

``count`` か ``device_ids`` が設定されていなければ、デフォルトではホスト上で利用可能な GPU すべてを使います。

.. code-block:: yaml

   services:
     test:
       image: tensorflow/tensorflow:latest-gpu
       command: python -c "import tensorflow as tf;tf.test.gpu_device_name()"
       deploy:
         resources:
           reservations:
             devices:
               - capabilities: [gpu]

.. code-block:: bash

   $ docker-compose up
   Creating network "gpu_default" with the default driver
   Creating gpu_test_1 ... done
   Attaching to gpu_test_1
   test_1  | I tensorflow/stream_executor/platform/default/dso_loader.cc:48] Successfully opened dynamic library libcudart.so.10.1

.. On machines hosting multiple GPUs, device_ids field can be set to target specific GPU devices and count can be used to limit the number of GPU devices assigned to a service container. If count exceeds the number of available GPUs on the host, the deployment will error out.

マシン上に複数の GPU を取り付けている場合、 ``device_ids`` フィールドによって対象となる GPU デバイスの指定ができ、 ``count`` によってサービス用コンテナに割り当てる GPU デバイス数の上限も指定できます。 ``count`` がホスト上で利用可能な GPU 数よりも超えた場合、デプロイはエラーが出て失敗します。

.. code-block:: bash

   $ nvidia-smi   
   +-----------------------------------------------------------------------------+
   | NVIDIA-SMI 450.80.02    Driver Version: 450.80.02    CUDA Version: 11.0     |
   |-------------------------------+----------------------+----------------------+
   | GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
   | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
   |                               |                      |               MIG M. |
   |===============================+======================+======================|
   |   0  Tesla T4            On   | 00000000:00:1B.0 Off |                    0 |
   | N/A   72C    P8    12W /  70W |      0MiB / 15109MiB |      0%      Default |
   |                               |                      |                  N/A |
   +-------------------------------+----------------------+----------------------+
   |   1  Tesla T4            On   | 00000000:00:1C.0 Off |                    0 |
   | N/A   67C    P8    11W /  70W |      0MiB / 15109MiB |      0%      Default |
   |                               |                      |                  N/A |
   +-------------------------------+----------------------+----------------------+
   |   2  Tesla T4            On   | 00000000:00:1D.0 Off |                    0 |
   | N/A   74C    P8    12W /  70W |      0MiB / 15109MiB |      0%      Default |
   |                               |                      |                  N/A |
   +-------------------------------+----------------------+----------------------+
   |   3  Tesla T4            On   | 00000000:00:1E.0 Off |                    0 |
   | N/A   62C    P8    11W /  70W |      0MiB / 15109MiB |      0%      Default |
   |                               |                      |                  N/A |
   +-------------------------------+----------------------+----------------------+

.. To enable access only to GPU-0 and GPU-3 devices:

GPU-0 と GPU-3 デバイスのみアクセスできるようにする：

.. code-block:: yaml

   services:
     test:
       image: tensorflow/tensorflow:latest-gpu
       command: python -c "import tensorflow as tf;tf.test.gpu_device_name()"
       deploy:
         resources:
           reservations:
             devices:
             - driver: nvidia
               device_ids: ['0', '3']
               capabilities: [gpu]

.. code-block:: bash

   $ docker-compose up
   ...
   Created TensorFlow device (/device:GPU:0 with 13970 MB memory -> physical GPU (device: 0, name: Tesla T4, pci bus id: 0000:00:1b.0, compute capability: 7.5)
   ...
   Created TensorFlow device (/device:GPU:1 with 13970 MB memory) -> physical GPU (device: 1, name: Tesla T4, pci bus id: 0000:00:1e.0, compute capability: 7.5)
   ...
   gpu_test_1 exited with code 0


.. seealso:: 

   Enabling GPU access with Compose | Docker Documentation
      https://docs.docker.com/compose/gpu-support/

