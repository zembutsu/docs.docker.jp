.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/config/containers/resource_constraints/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/config/containers/resource_constraints.md
   doc version: 20.04
.. check date: 2022/04/27
.. Commits on Nov 19, 2021 0b0b7050e51d391013e87783361f9bdc9ce0099e
.. ---------------------------------------------------------------------------

.. title: "Runtime options with Memory, CPUs, and GPUs"

.. _runtime-options-with-memory,-cpus,-and-gpus:

==========================================
メモリ、CPU、GPU に対する実行時オプション
==========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. By default, a container has no resource constraints and can use as much of a
   given resource as the host's kernel scheduler allows. Docker provides ways
   to control how much memory, or CPU a container can use, setting runtime
   configuration flags of the `docker run` command. This section provides details
   on when you should set such limits and the possible implications of setting them.

デフォルトにおいてコンテナには、リソースの利用に関して制限がありません。
したがってホスト・カーネルのスケジューラが割り振るリソースを、その分だけ利用できます。
Docker には、コンテナーが利用するメモリや CPU をどれくらいにするかを制御する方法があります。
``docker run`` コマンドにおいて実行時フラグを設定する方法です。
この節では、どのようなときにそういった制約を行うのか、そして制約によってどのような影響があるのかを説明します。

.. Many of these features require your kernel to support Linux capabilities. To
   check for support, you can use the
   [`docker info`](../../engine/reference/commandline/info.md) command. If a capability
   is disabled in your kernel, you may see a warning at the end of the output like
   the following:

制約に関する機能を利用するには、カーネルがケーパビリティをサポートしている必要があります。
サポートしているかどうかは、:doc:`docker info <../../engine/reference/commandline/info>` コマンドを実行すればわかります。
利用しているカーネルにおいてケーパビリティが無効になっていると、このコマンドの出力の最後に、以下のような出力が行われます。

.. ```console
   WARNING: No swap limit support

.. code-block:: console

   WARNING: No swap limit support

.. Consult your operating system's documentation for enabling them.
   [Learn more](../../engine/install/linux-postinstall.md#your-kernel-does-not-support-cgroup-swap-limit-capabilities).

これを有効にする方法は、各オペレーティング・システムのドキュメントを参照してください。
:ref:`さらに詳しくはここで説明しています <your-kernel-does-not-support-cgroup-swap-limit-capabilities>` 。

.. ## Memory

.. _resource_constraints_memory:

メモリ
==============================

.. ### Understand the risks of running out of memory

.. _understand-the-risks-of-running-out-of-memory:

メモリ不足時のリスクへの理解
------------------------------

.. It is important not to allow a running container to consume too much of the
   host machine's memory. On Linux hosts, if the kernel detects that there is not
   enough memory to perform important system functions, it throws an `OOME`, or
   `Out Of Memory Exception`, and starts killing processes to free up
   memory. Any process is subject to killing, including Docker and other important
   applications. This can effectively bring the entire system down if the wrong
   process is killed.

コンテナがホストマシンのメモリを必要以上に消費することは避けなければなりません。
Linux ホストにおいて、重要なシステム関数を実行するだけの十分なメモリがないことをカーネルが検出した場合、``OOME`` 例外、つまり ``Out Of Memory Exception`` がスローされます。
そしてプロセスの停止を行いメモリを開放します。
Docker であろうが重要なアプリケーションであろうが、あらゆるプロセスが強制的に停止させられます。
停止させてはならないプロセスが停止してしまうと、システム全体を停止させる事態にもなりかねません。

.. Docker attempts to mitigate these risks by adjusting the OOM priority on the
   Docker daemon so that it is less likely to be killed than other processes
   on the system. The OOM priority on containers is not adjusted. This makes it more
   likely for an individual container to be killed than for the Docker daemon
   or other system processes to be killed. You should not try to circumvent
   these safeguards by manually setting `--oom-score-adj` to an extreme negative
   number on the daemon or a container, or by setting `--oom-kill-disable` on a
   container.

Docker においては、デーモンに対しての OOM プライオリティ調整機能があります。
これによりメモリ不足のリスクを軽減し Docker デーモンが他のプロセスに比べて停止しにくいようにしています。
この OOM プライオリティの調整機能は、コンテナにはありません。
したがって Docker デーモンや他のシステム・プロセスが停止することよりも、単一のコンテナが停止する可能性の方が高いことになります。
これは Docker が採用する安全策なので、無理に回避する方法を取らないでください。
Docker デーモンに対して、手動で ``--oom-score-adj`` に極端な負数を指定したり、コンテナに対して ``--oom-kill-disable`` を指定したりするようなことはやめてください。

.. For more information about the Linux kernel's OOM management, see
   [Out of Memory Management](https://www.kernel.org/doc/gorman/html/understand/understand016.html){: target="_blank" class="_" }.

Linux カーネルの OOM 管理については `Out of Memory Management <https://www.kernel.org/doc/gorman/html/understand/understand016.html>`_  を参照してください。

.. You can mitigate the risk of system instability due to OOME by:

OOME に起因する不安定リスクを回避するには、以下の対応があります。

.. - Perform tests to understand the memory requirements of your application before
     placing it into production.
   - Ensure that your application runs only on hosts with adequate resources.
   - Limit the amount of memory your container can use, as described below.
   - Be mindful when configuring swap on your Docker hosts. Swap is slower and
     less performant than memory but can provide a buffer against running out of
     system memory.
   - Consider converting your container to a [service](../../engine/swarm/services.md),
     and using service-level constraints and node labels to ensure that the
     application runs only on hosts with enough memory

* アプリケーションの本番環境への移行前に、アプリケーションがどのようにメモリを必要とするかをテストして理解すること。
* アプリケーションが、一定のリソースがあればホスト上だけで動作することを確認すること。
* これ以降に示すような、コンテナのメモリ使用量を制限すること。
* Docker ホスト上のスワップの設定に十分注意すること。
  スワップはメモリに比べて、処理速度が遅く性能が劣ります。
  ただしシステム・メモリの不足を補うためのバッファを利用します。
* コンテナを :doc:`サービス <../../engine/swarm/services>` に変更する検討をすること。
  そしてサービス・レベルでの制約やノード・ラベルを利用することで、十分なメモリを有するホスト上でのみアプリケーションが動作するように検討すること。

.. ### Limit a container's access to memory

.. _limit-a-containers-access-to-memory:

コンテナーに対するメモリアクセスの制限
---------------------------------------

.. Docker can enforce hard memory limits, which allow the container to use no more
   than a given amount of user or system memory, or soft limits, which allow the
   container to use as much memory as it needs unless certain conditions are met,
   such as when the kernel detects low memory or contention on the host machine.
   Some of these options have different effects when used alone or when more than
   one option is set.

Docker では、ハード・リミット（hard limit）により厳しくメモリを制限することができます。
コンテナが利用するユーザー・メモリ、あるいはシステム・メモリを指定量以下に抑えます。
また緩い制限であるソフト・リミット（soft limit）もあり、所定の条件下でない限りは、コンテナが求めるメモリ使用を認めることができます。
所定の条件とはたとえば、ホスト上のメモリ不足やリソース・コンフリクト発生をカーネルが検出したような場合です。
制限を指定するオプションを利用する場合には、単独で利用するか複数組み合わせて利用するかによって、その効果はさまざまです。

.. Most of these options take a positive integer, followed by a suffix of `b`, `k`,
   `m`, `g`, to indicate bytes, kilobytes, megabytes, or gigabytes.

この制約オプションのほとんどは、正の整数を指定して、バイト、キロバイト、メガバイト、ギガバイトを表わす ``b`` 、``k`` 、``m`` 、``g`` を後ろにつけます。

.. | Option                 | Description                                                                                                                                                                                                                                                                                                                                                                                      |
   |:-----------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
   | `-m` or `--memory=`    | The maximum amount of memory the container can use. If you set this option, the minimum allowed value is `4m` (4 megabyte).                                                                                                                                                                                                                                                                      |
   | `--memory-swap`*       | The amount of memory this container is allowed to swap to disk. See [`--memory-swap` details](#--memory-swap-details).                                                                                                                                                                                                                                                    |
   | `--memory-swappiness`  | By default, the host kernel can swap out a percentage of anonymous pages used by a container. You can set `--memory-swappiness` to a value between 0 and 100, to tune this percentage. See [`--memory-swappiness` details](#--memory-swappiness-details).                                                                                                                 |
   | `--memory-reservation` | Allows you to specify a soft limit smaller than `--memory` which is activated when Docker detects contention or low memory on the host machine. If you use `--memory-reservation`, it must be set lower than `--memory` for it to take precedence. Because it is a soft limit, it does not guarantee that the container doesn't exceed the limit.                                      |
   | `--kernel-memory`      | The maximum amount of kernel memory the container can use. The minimum allowed value is `4m`. Because kernel memory cannot be swapped out, a container which is starved of kernel memory may block host machine resources, which can have side effects on the host machine and on other containers. See [`--kernel-memory` details](#--kernel-memory-details).            |
   | `--oom-kill-disable`   | By default, if an out-of-memory (OOM) error occurs, the kernel kills processes in a container. To change this behavior, use the `--oom-kill-disable` option. Only disable the OOM killer on containers where you have also set the `-m/--memory` option. If the `-m` flag is not set, the host can run out of memory and the kernel may need to kill the host system's processes to free memory. |

.. table::

   =========================== ==========
   オプション                  内容説明
   =========================== ==========
   ``-m`` または ``--memory=`` | コンテナに割り当てるメモリ最大使用量。このオプションを
                               | 利用する場合、指定できる最小値は ``6m`` (6 メガバイト) です。つまり、最小 6 メガバイトの値を指定しなくてはいけません。
   ``--memory-swap`` *         | コンテナにおいてディスクへのスワップを許容するメモリ容量。
                               | :ref:`--memory-swap の詳細 <--memory-swap-details>` を参照してください。
   ``--memory-swappiness``     | デフォルトにおいては、コンテナによって利用されている匿名
                               | ページを一定の割合でスワップ・アウトすることができます。
                               | ``--memory-swappiness`` の設定では 0 から 100 までの設定
                               | を行って、その割合を調整します。
                               | :ref:`--memory-swappiness の詳細 <--memory-swappiness-details>` を参照してください。
   ``--memory-reservation``    | ``--memory`` に比べてソフト・リミットとして小さな値を設定
                               | します。Docker がホスト・マシン上のコンフリクトやメモリ不足
                               | を検出したときに採用されます。この ``--memory-reservation``
                               | を指定する際には、これが優先的に採用されるように
                               | ``--memory`` よりも小さな値を設定します。
                               | これはソフト・リミットであり、この設定値を越えない保証は
                               | ないからです。
   ``--kernel-memory``         | コンテナに割り当てるカーネル・メモリの最大使用量。
                               | 指定できる最小値は ``4m`` です。カーネル・メモリはスワップ
                               | されるものではないため、カーネル・メモリ不足となった
                               | コンテナは、ホスト・マシンのリソースに影響を及ぼすことに
                               | なります。これはホスト・マシンにとっても、また他のコンテナ
                               | にとっても副作用を引き起こします。
                               | :ref:`--kernel-memory の詳細 <--kernel-memory-details>` を参照してください。
   ``--oom-kill-disable``      | out-of-memory (OOM) エラーが発生すると、デフォルトでカーネル
                               | はコンテナ内のプロセスを停止させます。この動作を変更するには
                               | ``--oom-kill-disable`` オプションを指定します。これによって
                               | コンテナ上での OOM キラープロセスが無効になりますが、それは
                               | ``-m/--memory`` オプションを同時に指定しているコンテナに
                               | 限定されます。``-m`` フラグを設定していなかった場合は、
                               | ホストがメモリ不足となり、ホスト・システムの他のプロセス
                               | を停止させてメモリ確保を行うことになります。
   =========================== ==========

.. For more information about cgroups and memory in general, see the documentation
   for [Memory Resource Controller](https://www.kernel.org/doc/Documentation/cgroup-v1/memory.txt).

cgroups とメモリに関する全般的な情報は、`メモリ・リソース・コントローラ <https://www.kernel.org/doc/Documentation/cgroup-v1/memory.txt>`_ に関するドキュメントを参照してください。

.. ### `--memory-swap` details

.. _--memory-swap-details:

``--memory-swap`` の詳細
---------------------------------------

.. `--memory-swap` is a modifier flag that only has meaning if `--memory` is also
   set. Using swap allows the container to write excess memory requirements to disk
   when the container has exhausted all the RAM that is available to it. There is a
   performance penalty for applications that swap memory to disk often.

``--memory-swap`` は、``--memory`` が同時に設定されている場合のみ、その意味をなす修正フラグです。
スワップを利用すれば、コンテナにおいて要求されたメモリが超過して、利用可能な RAM を使い果たしたとしても、それをディスクに書き出すことになります。
ただしメモリのスワップが頻発すると、アプリケーションの性能は劣化します。

.. Its setting can have complicated effects:

これを設定したときの結果は複雑です。

.. - If `--memory-swap` is set to a positive integer, then both `--memory` and
     `--memory-swap` must be set. `--memory-swap` represents the total amount of
     memory and swap that can be used, and `--memory` controls the amount used by
     non-swap memory. So if `--memory="300m"` and `--memory-swap="1g"`, the
     container can use 300m of memory and 700m (`1g - 300m`) swap.

* ``--memory-swap`` に正の整数が指定する場合は、``--memory`` と ``--memory-swap`` を同時に指定する必要があります。
  ``--memory-swap`` は、利用可能なメモリとスワップの総量を表わします。
  また ``--memory`` はスワップを含めず、利用されるメモリの総量を制御します。
  したがってたとえば ``--memory="300m"`` と ``--memory-swap="1g"`` を指定した場合、そのコンテナが利用できるのは 300m のメモリと 700m (``1g - 300m`` ) のスワップとなります。

.. - If `--memory-swap` is set to `0`, the setting is ignored, and the value is
     treated as unset.

* ``--memory-swap`` を ``0`` にすると、この設定は無視され、設定されていないものとして扱われます。

.. - If `--memory-swap` is set to the same value as `--memory`, and `--memory` is
     set to a positive integer, **the container does not have access to swap**.
     See
     [Prevent a container from using swap](#prevent-a-container-from-using-swap).

* ``--memory-swap`` に設定された値が ``--memory`` と同じ値である場合で、かつ ``--memory`` に正の整数が設定されている場合、**コンテナはスワップへアクセスしません**。
  :ref:`コンテナにおけるスワップ利用の防止 <prevent-a-container-from-using-swap>` を参照してください。

.. - If `--memory-swap` is unset, and `--memory` is set, the container can use
     as much swap as the `--memory` setting, if the host container has swap
     memory configured. For instance, if `--memory="300m"` and `--memory-swap` is
     not set, the container can use 600m in total of memory and swap.

* ``--memory-swap`` が設定されていない場合で、かつ ``--memory`` が設定されている場合、コンテナは ``--memory`` に設定されている値をスワップ容量とします。
  当然このときは、ホスト・コンテナがスワップ・メモリを持つものとして設定されている場合に限ります。
  たとえば ``--memory="300m"`` と設定され、``--memory-swap`` が設定されていない場合、そのコンテナはメモリとスワップの総量として 600m を利用することになります。

.. - If `--memory-swap` is explicitly set to `-1`, the container is allowed to use
     unlimited swap, up to the amount available on the host system.

* ``--memory-swap`` を明示的に ``-1`` とした場合、コンテナが利用できるスワップは、ホスト・システムでの利用可能なスワップ範囲内で無制限となります。

.. - Inside the container, tools like `free` report the host's available swap, not what's available inside the container. Don't rely on the output of `free` or similar tools to determine whether swap is present.

* コンテナの内部から ``free`` などのツールを実行すると、ホスト上で利用可能なスワップ容量が表示されます。
  コンテナ内において利用可能な量を示すわけではありません。
  ``free`` や同等のツールを利用する際には、出力結果からスワップ容量を判断できないことに注意してください。

.. #### Prevent a container from using swap

.. _prevent-a-container-from-using-swap:

コンテナにおけるスワップ利用の防止
---------------------------------------

.. If `--memory` and `--memory-swap` are set to the same value, this prevents
   containers from using any swap. This is because `--memory-swap` is the amount of
   combined memory and swap that can be used, while `--memory` is only the amount
   of physical memory that can be used.

``--memory`` と ``--memory-swap`` に同じ値を設定した場合、コンテナがスワップを利用しないようになります。
``--memory-swap`` は、利用可能なメモリとスワップを合わせた総量を表わすものであり、``--memory`` は利用可能なメモリ使用量を意味するからです。

.. ### `--memory-swappiness` details

.. _--memory-swappiness-details:

``--memory-swappiness`` の詳細
---------------------------------------

.. - A value of 0 turns off anonymous page swapping.
   - A value of 100 sets all anonymous pages as swappable.
   - By default, if you do not set `--memory-swappiness`, the value is
     inherited from the host machine.

* 0 を指定すると、匿名ページのスワップを無効にします。
* 100 を指定すると、匿名ページのすべてをスワップ可能とします。
* ``--memory-swappiness`` を設定しなかった場合、デフォルトでは、ホスト・マシンからその値を受け継ぎます。

.. ### `--kernel-memory` details

.. _--kernel-memory-details:

``--kernel-memory`` の詳細
---------------------------------------

.. Kernel memory limits are expressed in terms of the overall memory allocated to
   a container. Consider the following scenarios:

カーネル・メモリに対する制約は、コンテナに割り当てられるメモリ全体に関わります。
以下の状況が考えられます。

.. - **Unlimited memory, unlimited kernel memory**: This is the default
     behavior.
   - **Unlimited memory, limited kernel memory**: This is appropriate when the
     amount of memory needed by all cgroups is greater than the amount of
     memory that actually exists on the host machine. You can configure the
     kernel memory to never go over what is available on the host machine,
     and containers which need more memory need to wait for it.
   - **Limited memory, unlimited kernel memory**: The overall memory is
     limited, but the kernel memory is not.
   - **Limited memory, limited kernel memory**: Limiting both user and kernel
     memory can be useful for debugging memory-related problems. If a container
     is using an unexpected amount of either type of memory, it runs out
     of memory without affecting other containers or the host machine. Within
     this setting, if the kernel memory limit is lower than the user memory
     limit, running out of kernel memory causes the container to experience
     an OOM error. If the kernel memory limit is higher than the user memory
     limit, the kernel limit does not cause the container to experience an OOM.

* **メモリ制限なし、カーネルメモリ制限なし**: 
  これがデフォルトの動作です。
* **メモリ制限なし、カーネルメモリ制限あり**:
  この設定が適当な状況とは、ホスト・マシン上の実際のメモリ容量よりも、cgroup が必要とするメモリの総量が上回っている場合です。
  カーネル・メモリは、ホスト・マシン上での利用可能量を越えないように、またそれ以上に必要としているコンテナは、利用可能になるまで待つような設定とすることができます。
* **メモリ制限あり、カーネルメモリ制限なし**:
  メモリ全体が制限されますが、カーネル・メモリは制限されません。
* **メモリ制限あり、カーネルメモリ制限あり**:
  ユーザー・メモリとカーネル・メモリをともに制限するのは、メモリに関する障害をデバッグする際に利用できます。
  コンテナがこのいずれかのメモリを予想以上に消費している場合、メモリ不足となっても、他のコンテナやホストには影響を及ぼしません。
  この設定において、カーネル・メモリの制限値がユーザー・メモリの制限値より小さい場合は、メモリ不足によってコンテナ内に OOM エラーが発生することになります。
  カーネル・メモリの制限値の方が大きい場合は、コンテナ内に OOM エラーが発生することはありません。

.. When you turn on any kernel memory limits, the host machine tracks "high water
   mark" statistics on a per-process basis, so you can track which processes (in
   this case, containers) are using excess memory. This can be seen per process
   by viewing `/proc/<PID>/status` on the host machine.

カーネル・メモリに制限を設けた場合、ホスト・マシンはプロセスごとに「最高水位標」（high water mark）の統計をとります。
そこからどのプロセスが（今の場合、どのコンテナが）過剰にメモリを消費しているかを知ることができます。
具体的にはホスト・マシン内の ``/proc/<PID>/status`` を見ることで、プロセスごとの状況がわかります。

.. ## CPU

.. _resource_constraints_cpu:

CPU
==============================

.. By default, each container's access to the host machine's CPU cycles is unlimited.
   You can set various constraints to limit a given container's access to the host
   machine's CPU cycles. Most users use and configure the
   [default CFS scheduler](#configure-the-default-cfs-scheduler). In Docker 1.13
   and higher, you can also configure the
   [realtime scheduler](#configure-the-realtime-scheduler).

各コンテナがホスト・マシンの CPU サイクルにアクセスすることは、デフォルトでは制限がありません。
ホスト・マシンの CPU サイクルにアクセスするコンテナに制限を加える方法はいろいろとあります。
よく利用されるのは :ref:`デフォルト CFS スケジューラ <configure-the-default-cfs-scheduler>` です。
また :ref:`リアルタイム・スケジューラ <configure-the-realtime-scheduler>` も利用できます。

.. ### Configure the default CFS scheduler

.. _configure-the-default-cfs-scheduler:

デフォルト CFS スケジューラの設定
---------------------------------------

.. The CFS is the Linux kernel CPU scheduler for normal Linux processes. Several
   runtime flags allow you to configure the amount of access to CPU resources your
   container has. When you use these settings, Docker modifies the settings for
   the container's cgroup on the host machine.

CFS は Linux 上の普通のプロセスに対して用いられる Linux カーネル CPU スケジューラです。
コンテナが利用する CPU リソースのアクセス量を設定するために、いくつかの実行時フラグが用意されています。
この設定を行うと、Docker はホスト・マシン上にあるコンテナの cgroup 設定を修正します。

.. | Option                 | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
   |:-----------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
   | `--cpus=<value>`       | Specify how much of the available CPU resources a container can use. For instance, if the host machine has two CPUs and you set `--cpus="1.5"`, the container is guaranteed at most one and a half of the CPUs. This is the equivalent of setting `--cpu-period="100000"` and `--cpu-quota="150000"`. Available in Docker 1.13 and higher.                                                                                                                                                                                                                                                           |
   | `--cpu-period=<value>` | Specify the CPU CFS scheduler period, which is used alongside  `--cpu-quota`. Defaults to 100000  microseconds (100 milliseconds). Most users do not change this from the default. If you use Docker 1.13 or higher, use `--cpus` instead.                                                                                                                                                                                                                                                                                                                                                                                 |
   | `--cpu-quota=<value>`  | Impose a CPU CFS quota on the container. The number of microseconds per `--cpu-period` that the container is limited to before throttled. As such acting as the effective ceiling. If you use Docker 1.13 or higher, use `--cpus` instead.                                                                                                                                                                                                                                                                                                                                                           |
   | `--cpuset-cpus`        | Limit the specific CPUs or cores a container can use. A comma-separated list or hyphen-separated range of CPUs a container can use, if you have more than one CPU. The first CPU is numbered 0. A valid value might be `0-3` (to use the first, second, third, and fourth CPU) or `1,3` (to use the second and fourth CPU).                                                                                                                                                                                                                                                                          |
   | `--cpu-shares`         | Set this flag to a value greater or less than the default of 1024 to increase or reduce the container's weight, and give it access to a greater or lesser proportion of the host machine's CPU cycles. This is only enforced when CPU cycles are constrained. When plenty of CPU cycles are available, all containers use as much CPU as they need. In that way, this is a soft limit. `--cpu-shares` does not prevent containers from being scheduled in swarm mode. It prioritizes container CPU resources for the available CPU cycles. It does not guarantee or reserve any specific CPU access. |

.. table::

   =========================== ==========
   オプション                  内容説明
   =========================== ==========
   ``--cpus=<値>``             | コンテナが CPU リソースをどれだけ利用可能かを指定
                               | します。たとえばホスト・マシンに CPU が 2 つあり
                               | ``--cpus="1.5"`` という設定を行った場合、コンテナ
                               | に対して CPU 最大 1.5 個分が保証されます。これは
                               | ``--cpu-period="100000"`` と ``--cpu-quota="150000"``
                               | を設定することと同じです。
   ``--cpu-period=<値>``       | CFS スケジューラ間隔を指定します。
                               | これは ``--cpu-quota`` とともに指定されます。
                               | デフォルトは 100000  マイクロ秒（100 ミリ秒）です。たいていの場合、
                               | このデフォルト値を変更することはしません。
                               | たいていの場合は、これではなく
                               | ``--cpus`` を使ってください。
   ``--cpu-quota=<値>``        | コンテナに対して CFS クォータを設定します。
                               | ``--cpu-period`` ごとのマイクロ秒単位の時間であり、
                               | スロットリングされる前にこの時間に制限されます。
                               | 有効しきい値として動作します。
                               | たいていの場合は、これではなく ``--cpus`` を使って
                               | ください。
   ``--cpuset-cpus``           | コンテナが利用する CPU またはコアを特定します。
                               | CPU が複数あれば、カンマ区切りあるいはハイフン
                               | 区切りのリストで CPU の利用範囲を指定します。
                               | 1 つめの CPU を 0 とします。指定例としては以下
                               | です。``0-3`` （1 つめから 4 つめまでの CPU を利用
                               | する場合）、``1,3`` （2 つめと 4 つめの CPU を利用
                               | する場合）
   ``--cpu-shares``            | コンテナへの配分を定めるもので、デフォルト値は
                               | 1024 です。本フラグを利用する場合は、デフォルト値
                               | より大きければ配分を増やし、小さければ減らします。
                               | そしてホスト・マシンの CPU サイクルへのアクセスを
                               | 高比率、低比率で行います。これは CPU サイクルが
                               | 制限されている場合に限って動作します。CPU サイクル
                               | が豊富に利用可能であるとき、すべてのコンテナは必要
                               | な分だけ CPU を利用します。こういうことから、これ
                               | はソフト・リミットと言えます。``--cpu-shares`` は
                               | Swarm モード内においてコンテナがスケジュールされる
                               | ことを妨げません。コンテナの CPU リソースは、これ
                               | によって利用可能な CPU サイクルが優先的に割り当て
                               | られます。ただし CPU アクセスを保証したり予約する
                               | ものではありません。
   =========================== ==========

.. If you have 1 CPU, each of the following commands guarantees the container at
   most 50% of the CPU every second.

CPU が 1 つである場合に、以下のコマンドはコンテナに対し、毎秒 CPU の最大 50 % を保証します。

.. ```bash
   docker run -it --cpus=".5" ubuntu /bin/bash
   ```

.. code-block:: bash

   $ docker run -it --cpus=".5" ubuntu /bin/bash

.. Which is the equivalent to manually specifying `--cpu-period` and `--cpu-quota`;

これは手動で ``--cpu-period`` と ``--cpu-quota`` を指定するのと同じです。

.. ```bash
   $ docker run -it --cpu-period=100000 --cpu-quota=50000 ubuntu /bin/bash
   ```

.. code-block:: bash

   $ docker run -it --cpu-period=100000 --cpu-quota=50000 ubuntu /bin/bash

.. ### Configure the realtime scheduler

.. _configure-the-realtime-scheduler:

リアルタイム・スケジューラの設定
---------------------------------------

.. In Docker 1.13 and higher, you can configure your container to use the
   realtime scheduler, for tasks which cannot use the CFS scheduler. You need to
   [make sure the host machine's kernel is configured correctly](#configure-the-host-machines-kernel)
   before you can [configure the Docker daemon](#configure-the-docker-daemon) or
   [configure individual containers](#configure-individual-containers).

コンテナにおいてリアルタイム・スケジューラを利用するように設定することができます。
CFS スケジューラが利用できないタスクに対して用います。
初めに :ref:`ホスト・マシンのカーネルが正しく設定されていること <configure-the-host-machines-kernel>` を確認した上で、:ref:`Docker デーモンの設定 <configure-the-docker-daemon>` を行うか、:ref:`各コンテナの個別設定 <configure-individual-containers>` を行ってください。

.. > **Warning**
   >
   > CPU scheduling and prioritization are advanced kernel-level features. Most
   > users do not need to change these values from their defaults. Setting these
   > values incorrectly can cause your host system to become unstable or unusable.
   {:.warning}

.. warning::

   CPU スケジュールや優先処理は、高度なカーネルレベルの機能です。
   たいていの場合、その機能設定をデフォルトから変更する必要はありません。
   設定を誤ると、ホスト・システムが不安定または利用不能になることがあります。

.. #### Configure the host machine's kernel

.. _configure-the-host-machines-kernel:

ホスト・マシン・カーネルの設定
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Verify that `CONFIG_RT_GROUP_SCHED` is enabled in the Linux kernel by running
   `zcat /proc/config.gz | grep CONFIG_RT_GROUP_SCHED` or by checking for the
   existence of the file `/sys/fs/cgroup/cpu.rt_runtime_us`. For guidance on
   configuring the kernel realtime scheduler, consult the documentation for your
   operating system.

Linux カーネルにおいて ``CONFIG_RT_GROUP_SCHED`` が有効になっていることを確認します。
これには ``zcat /proc/config.gz | grep CONFIG_RT_GROUP_SCHED`` を実行するか、あるいはファイル ``/sys/fs/cgroup/cpu.rt_runtime_us`` が存在するかどうかで確認します。
カーネルのリアルタイム・スケジューラの設定方法については、各オペレーティング・システムのドキュメントを参照してください。

.. #### Configure the Docker daemon

.. _configure-the-docker-daemon:

Docker デーモンの設定
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. To run containers using the realtime scheduler, run the Docker daemon with
   the `--cpu-rt-runtime` flag set to the maximum number of microseconds reserved
   for realtime tasks per runtime period. For instance, with the default period of
   1000000 microseconds (1 second), setting `--cpu-rt-runtime=950000` ensures that
   containers using the realtime scheduler can run for 950000 microseconds for every
   1000000-microsecond period, leaving at least 50000 microseconds available for
   non-realtime tasks. To make this configuration permanent on systems which use
   `systemd`, see [Control and configure Docker with systemd](../daemon/systemd.md).

リアルタイム・スケジューラを利用するコンテナを起動するには、Docker デーモンに ``--cpu-rt-runtime`` フラグをつけて起動します。
設定値には、リアルタイム・タスクに対して、実行時間ごとに割り当てられる最大の時間をマイクロ秒単位で指定します。
たとえばデフォルトの実行時間である 1000000 マイクロ秒に対して、``--cpu-rt-runtime=950000`` と設定すると、このリアルタイム・スケジューラを利用するコンテナは、各 1000000 マイクロ秒ごとに 950000 マイクロ秒ずつ稼動するようになります。
残りの 50000 マイクロ秒は、リアルタイム・スレッド以外のタスクに利用されます。
``systemd`` を利用するシステム上で、これを恒常的な設定とするには :doc:`systemd を用いた Docker の管理と設定 <../daemon/systemd>` を参照してください。

.. #### Configure individual containers

.. _configure-individual-containers:

個々のコンテナに対する設定
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You can pass several flags to control a container's CPU priority when you
   start the container using `docker run`. Consult your operating system's
   documentation or the `ulimit` command for information on appropriate values.

コンテナの CPU 優先順位づけ（priority）を制御するフラグがいくつかあります。
``docker run`` を実行する際に、これを指定します。
適切な値設定に関しては、オペレーティング・システムのドキュメントや ``ulimit`` コマンドを参照してください。

.. | Option                     | Description                                                                                                                                                                               |
   |:---------------------------|:------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
   | `--cap-add=sys_nice`       | Grants the container the `CAP_SYS_NICE` capability, which allows the container to raise process `nice` values, set real-time scheduling policies, set CPU affinity, and other operations. |
   | `--cpu-rt-runtime=<value>` | The maximum number of microseconds the container can run at realtime priority within the Docker daemon's realtime scheduler period. You also need the `--cap-add=sys_nice` flag.          |
   | `--ulimit rtprio=<value>`  | The maximum realtime priority allowed for the container. You also need the `--cap-add=sys_nice` flag.                                                                                     |

.. table::

   =========================== ==========
   オプション                  内容説明
   =========================== ==========
   ``--cap-add=sys_nice``      | コンテナが ``CAP_SYS_NICE`` ケーパビリティを利用できるよう
                               | にします。これによってコンテナーにおけるプロセスの ``nice``
                               | 値の加算、リアルタイム・スケジューラ・ポリシの設定、CPU
                               | アフィニティの設定、その他が行えるようになります。
   ``--cpu-rt-runtime=<値>``   | Docker デーモンにおいて、リアルタイム・スケジューラ実行時間
                               | 内のリアルタイム優先順位づけによる最大実行時間をマイクロ秒
                               | で指定します。同時に ``--cap-add=sys_nice`` フラグの指定
                               | も必要です。
   ``--ulimit rtprio=<値>``    | コンテナに対して許容するリアルタイム優先順位づけの最大数。
                               | 同時に ``--cap-add=sys_nice`` フラグの指定も必要です。
   =========================== ==========

.. The following example command sets each of these three flags on a `debian:jessie`
   container.

以下に示すコマンドは、``debian:jessie`` コンテナに対して 3 つのフラグを設定する例です。

.. ```bash
   $ docker run -it \
       --cpu-rt-runtime=950000 \
       --ulimit rtprio=99 \
       --cap-add=sys_nice \
       debian:jessie
   ```

.. code-block:: bash

      $ docker run -it \
          --cpu-rt-runtime=950000 \
          --ulimit rtprio=99 \
          --cap-add=sys_nice \
          debian:jessie

.. If the kernel or Docker daemon is not configured correctly, an error occurs.

カーネルまたは Docker デーモンが正しく設定できていない場合には、エラーが発生します。

.. ## GPU

.. _resource_constraints_gpu:

GPU
==============================

.. ### Access an NVIDIA GPU

.. _access-an-nvidia-gpu:

NVIDIA GPU へのアクセス
---------------------------------------

.. #### Prerequisites

.. ..resource_constraints_prerequisites:

前提条件
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Visit the official [NVIDIA drivers page](https://www.nvidia.com/Download/index.aspx)
   to download and install the proper drivers. Reboot your system once you have
   done so.

`NVIDIA ドライバ・ページ <https://www.nvidia.com/Download/index.aspx>`_ にアクセスして、適切なドライバをダウンロード、インストールしてください。
これを行ったらシステムを再起動してください。

.. Verify that your GPU is running and accessible.

GPU が起動中でありアクセス可能であることを確認してください。

.. #### Install nvidia-container-runtime

.. _install-nvidia-container-runtime:

nvidia-container-runtime のインストール
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Follow the instructions at (https://nvidia.github.io/nvidia-container-runtime/)
   and then run this command:

(https://nvidia.github.io/nvidia-container-runtime/) にある手順に従い、次に以下のコマンドを実行してください。

.. ```bash
   $ apt-get install nvidia-container-runtime
   ```

.. code-block:: bash

   $ apt-get install nvidia-container-runtime

.. Ensure the `nvidia-container-runtime-hook` is accessible from `$PATH`.

``$PATH`` 上から ``nvidia-container-runtime-hook`` がアクセスできることを確認します。

.. ```bash
   $ which nvidia-container-runtime-hook
   ```

.. code-block:: bash

   $ which nvidia-container-runtime-hook

.. Restart the Docker daemon.

Docker デーモンを再起動します。

.. #### Expose GPUs for use

.. _expose-gpus-for-use:

GPU の有効化
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. Include the `--gpus` flag when you start a container to access GPU resources.
   Specify how many GPUs to use. For example:

コンテナの起動時に ``--gpus`` フラグをつけると、GPU リソースにアクセスすることができます。
このとき GPU をどれだけ利用するかを指定します。
たとえば以下のとおりです。

.. ```bash
   $ docker run -it --rm --gpus all ubuntu nvidia-smi
   ```

.. code-block:: bash

   $ docker run -it --rm --gpus all ubuntu nvidia-smi

.. Exposes all available GPUs and returns a result akin to the following:

利用可能な GPU をすべて有効にした場合、以下のような出力結果となります。

.. ```bash
   +-----------------------------------------------------------------------------+
   | NVIDIA-SMI 384.130            	Driver Version: 384.130               	|
   |-------------------------------+----------------------+----------------------+
   | GPU  Name 	   Persistence-M| Bus-Id    	Disp.A | Volatile Uncorr. ECC |
   | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
   |===============================+======================+======================|
   |   0  GRID K520       	Off  | 00000000:00:03.0 Off |                  N/A |
   | N/A   36C	P0    39W / 125W |  	0MiB /  4036MiB |      0%  	Default |
   +-------------------------------+----------------------+----------------------+
   +-----------------------------------------------------------------------------+
   | Processes:                                                       GPU Memory |
   |  GPU   	PID   Type   Process name                         	Usage  	|
   |=============================================================================|
   |  No running processes found                                                 |
   +-----------------------------------------------------------------------------+
   ```

.. code-block:: bash

   +-----------------------------------------------------------------------------+
   | NVIDIA-SMI 384.130            	Driver Version: 384.130               	|
   |-------------------------------+----------------------+----------------------+
   | GPU  Name 	   Persistence-M| Bus-Id    	Disp.A | Volatile Uncorr. ECC |
   | Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
   |===============================+======================+======================|
   |   0  GRID K520       	Off  | 00000000:00:03.0 Off |                  N/A |
   | N/A   36C	P0    39W / 125W |  	0MiB /  4036MiB |      0%  	Default |
   +-------------------------------+----------------------+----------------------+
   +-----------------------------------------------------------------------------+
   | Processes:                                                       GPU Memory |
   |  GPU   	PID   Type   Process name                         	Usage  	|
   |=============================================================================|
   |  No running processes found                                                 |
   +-----------------------------------------------------------------------------+

.. Use the `device` option to specify GPUs. For example:

``device`` オプションを使って GPU を指定します。
たとえば以下です。

.. ```bash
   $ docker run -it --rm --gpus device=GPU-3a23c669-1f69-c64e-cf85-44e9b07e7a2a ubuntu nvidia-smi
   ```

.. code-block:: bash

   $ docker run -it --rm --gpus device=GPU-3a23c669-1f69-c64e-cf85-44e9b07e7a2a ubuntu nvidia-smi

.. Exposes that specific GPU.

これにより指定した GPU が有効になります。

.. ```bash
   $ docker run -it --rm --gpus device=0,2 nvidia-smi
   ```

.. code-block:: bash

   $ docker run -it --rm --gpus '"device=0,2"' ubuntu nvidia-smi

.. Exposes the first and third GPUs.

これは 1 つめと 3 つめの GPU が有効になります。

.. > **Note**
   >
   > NVIDIA GPUs can only be accessed by systems running a single engine.

.. note::

   NVIDIA GPU は、単一の Engine が起動するシステムからのみアクセスすることができます。

.. #### Set NVIDIA capabilities

.. _set-nvidia-capabilities:

NVIDIA ケーパビリティの設定
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. You can set capabilities manually. For example, on Ubuntu you can run the
   following:

ケーパビリティは手動で設定します。
たとえば Ubuntu では以下のコマンドを実行します。

.. ```bash
   $ docker run --gpus 'all,capabilities=utility' --rm ubuntu nvidia-smi
   ```

.. code-block:: bash

   $ docker run --gpus 'all,capabilities=utility' --rm ubuntu nvidia-smi

.. This enables the `utility` driver capability which adds the `nvidia-smi` tool to
   the container.

上を行うと ``utility`` ドライバ・ケーパビリティによって ``nvidia-smi`` ツールが追加され、コンテナにより利用可能となります。

.. Capabilities as well as other configurations can be set in images via
   environment variables. More information on valid variables can be found at the
   [nvidia-container-runtime](https://github.com/NVIDIA/nvidia-container-runtime)
   GitHub page. These variables can be set in a Dockerfile.

ケーパビリティも他の設定も、環境変数を利用してイメージに設定することができます。
利用可能な環境変数の詳細は `nvidia-container-runtime <https://github.com/NVIDIA/nvidia-container-runtime>`_ GitHub ページを参照してください。
この環境変数は Dockerfile 内に指定することもできます。

.. You can also utitize CUDA images which sets these variables automatically. See
   the [CUDA images](https://github.com/NVIDIA/nvidia-docker/wiki/CUDA) GitHub page
   for more information.

その環境変数を自動的に設定する CUDA イメージを利用することもできます。
詳細は `CUDA イメージ <https://github.com/NVIDIA/nvidia-docker/wiki/CUDA>`_ GitHub ページを参照してください。

.. seealso:: 

   Runtime options with Memory, CPUs, and GPUs
      https://docs.docker.com/config/containers/resource_constraints/
