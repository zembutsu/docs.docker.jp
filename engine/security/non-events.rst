.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/security/non-events/
.. SOURCE: https://github.com/docker/docker.github.io/blob/master/engine/security/non-events.md
   doc version: 19.03
.. check date: 2020/07/04
.. Commits on Nov 12, 2016 a5e01e1844a6eb57e18fb3599e0e21f5dbc03da4
.. -------------------------------------------------------------------

.. Docker security non-events

.. _docker-security-non-events:

========================================
その他の Docker セキュリティ
========================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3

.. This page lists security vulnerabilities which Docker mitigated, such that
   processes run in Docker containers were never vulnerable to the bug—even before
   it was fixed. This assumes containers are run without adding extra capabilities
   or not run as `--privileged`.

このページではセキュリティぜい弱性一覧を示します。
Docker においては、バグに対する軽減対応がなされています。
もっとも Docker コンテナにおいて起動するプロセスでは、たとえバグ修正されなくても、元からぜい弱性があるとは言えません。
ここではコンテナの起動にあたって、ケーパビリティは追加せず、あるいは ``--privileged`` としては起動していないことを前提とします。

.. The list below is not even remotely complete. Rather, it is a sample of the few bugs we’ve actually noticed to have attracted security review and publicly disclosed vulnerabilities. In all likelihood, the bugs that haven’t been reported far outnumber those that have. Luckily, since Docker’s approach to secure by default through apparmor, seccomp, and dropping capabilities, it likely mitigates unknown bugs just as well as it does known ones.

以下のリストは完全なものには至っていません。むしろ、いくつかのバグはサンプルであり、私たちが実際にセキュリティ・レビューに対応し、公開された脆弱性に対し、警告を発したものです。すべての可能性やバグは、この一覧にあるよりも遙かに多くの報告があります。幸いにも、Docker のアプローチはデフォルトでセキュア（安全）であるべきというもので、apparmor、seccomp を通したり、ケーパビリティを落とすのもあります。これにより、既に知られているバグだけでなく、未知のバグに対する問題も緩和するでしょう。

.. Bugs mitigated:

バグへの対処済み（Bugs mitigated）：

..    CVE-2013-1956, 1957, 1958, 1959, 1979, CVE-2014-4014, 5206, 5207, 7970, 7975, CVE-2015-2925, 8543, CVE-2016-3134, 3135, etc.: The introduction of unprivileged user namespaces lead to a huge increase in the attack surface available to unprivileged users by giving such users legitimate access to previously root-only system calls like mount(). All of these CVEs are examples of security vulnerabilities due to introduction of user namespaces. Docker can use user namespaces to set up containers, but then disallows the process inside the container from creating its own nested namespaces through the default seccomp profile, rendering these vulnerabilities unexploitable.

* `CVE-2013-1956 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-1956>`_ 、 `1957 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-1957>`_ 、 `1958 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-1958>`_ 、 `1959 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-1959>`_ 、 `1979 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-1979>`_ 、 `CVE-2014-4014 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-4014>`_ 、 `5206 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-5206>`_ 、 `5207 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-5207>`_ 、 `7970 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-7970>`_ 、 `7975 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-7975>`_ 、 `CVE-2015-2925 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-2925>`_ 、 `8543 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-8543>`_ 、 `CVE-2016-3134  <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-3134>`_ 、 `3135 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-3135>`_ 、  等 ： 特権のないユーザ名前区間（unprivileged user namespaces）の導入は、特権のないユーザからの攻撃機会を大いに増加させました。たとえば、 ``mount()`` のように、以前は root のみのシステムコールに対し、権限のないユーザの利用を正当化するものです。これら全てのセキュリティ脆弱性例は、ユーザ名前空間（user namespaces）の導入に起因しています。Docker はユーザ名前空間を使ってコンテナをセットアップしますが、デフォルトの seccomp プロファイルでは、コンテナ内のプロセスに対しては、自身からネストする名前空間の作成を許可しませんので、これら脆弱性は利用されていないと解釈しています。

..     CVE-2014-0181, CVE-2015-3339: These are bugs that require the presence of a setuid binary. Docker disables setuid binaries inside containers via the NO_NEW_PRIVS process flag and other mechanisms.

* `CVE-2014-0181 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-0181>`_  、 `CVE-2015-3339 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-3339>`_ ：これらのバグには、 setuid バイナリの存在が必要です。Docker は ``NO_NEW_PRIVS`` プロセス・フラグと他の仕組みにより、 コンテナ内での setuid バイナリを無効化します。

..     CVE-2014-4699: A bug in ptrace() could allow privilege escalation. Docker disables ptrace() inside the container using apparmor, seccomp and by dropping CAP_PTRACE. Three times the layers of protection there!

* `CVE-2014-4699 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-4699>`_ ： ``ptrace()`` によるバグにより、権限のエスカレーションを引き起こす可能性があります。Docker は apparmor、seccomp を使い、 ``CAP_PTRACE`` で権限を落とすので、コンテナ内での ``ptrace()`` を無効化します。

..     CVE-2014-9529: A series of crafted keyctl() calls could cause kernel DoS / memory corruption. Docker disables keyctl() inside containers using seccomp.

* `CVE-2014-9529 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2014-9529>`_ ： 連続する ``keyctl()`` コールの作成により、カーネルの DoS やメモリ不正を引き起こす可能性があります。Docker は seccomp を使い、コンテナ内での ``keyctl()`` を無効化します。

..     CVE-2015-3214, 4036: These are bugs in common virtualization drivers which could allow a guest OS user to execute code on the host OS. Exploiting them requires access to virtualization devices in the guest. Docker hides direct access to these devices when run without --privileged. Interestingly, these seem to be cases where containers are “more secure” than a VM, going against common wisdom that VMs are “more secure” than containers.

* `CVE-2015-3214 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-3214>`_  、 `4036 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-4036>`_ ： これらのバグは共通の仮想化ドライバによるもので、ゲスト OS のユーザがホスト上のコードを実行できる可能性があります。これら不正な攻撃のためには、ゲスト内の仮想化デバイスにアクセスできる必要があります。Docker は、 ``--privileged`` を使って実行しなければ 、これらデバイスへの直接アクセスを隠すようにします。興味深いことに、場合によってはコンテナが仮想マシンよりも「より安全」になるのですが、これは、共通の優れた認識とは相反します。仮想マシンがコンテナよりも「より安全」です。

..     CVE-2016-0728: Use-after-free caused by crafted keyctl() calls could lead to privilege escalation. Docker disables keyctl() inside containers using the default seccomp profile.

* `CVE-2016-0728 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-0728>`_ ： ``keyctl()`` コールによって作成される use-after-free（使ったあとに解放）により、権限の昇格を引き起こす可能性があります。Docker はデフォルトの seccomp プロファイルを使い、コンテナ内での ``keyctl()`` を無効化します。

..     CVE-2016-2383: A bug in eBPF -- the special in-kernel DSL used to express things like seccomp filters -- allowed arbitrary reads of kernel memory. The bpf() system call is blocked inside Docker containers using (ironically) seccomp.

* `CVE-2016-2383 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-2383>`_ ： eBPF のバグです。特別なカーネル内の DSL が、seccomp ファイルかのように装うことで、カーネルメモリを任意に読み込み可能にします。コンテナ内で（皮肉にも） seccomp を使ってブロックされます。

..     CVE-2016-3134, 4997, 4998: A bug in setsockopt with IPT_SO_SET_REPLACE, ARPT_SO_SET_REPLACE, and ARPT_SO_SET_REPLACE causing memory corruption / local privilege escalation. These arguments are blocked by CAP_NET_ADMIN, which Docker does not allow by default.

* `CVE-2016-3134 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-3134>`_ 、 `4997 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-4997>`_ 、 `4998 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-4998>`_  ： setsockopt の ``IPT_SO_SET_REPLACE`` 、 ``ARPT_SO_SET_REPLACE`` 、 ``ARPT_SO_SET_REPLACE`` にあるバグで、メモリ不正やローカル権限の昇格を引き起こす可能性があります。デフォルトの Docker は、これらの引数を ``CAP_NET_ADMIN`` によってブロックします。

.. Bugs not mitigated:

バグがあるものの、未対処（bugs not mitigated）：

..     CVE-2015-3290, 5157: Bugs in the kernel’s non-maskable interrupt handling allowed privilege escalation. Can be exploited in Docker containers because the modify_ldt() system call is not currently blocked using seccomp.

* `CVE-2015-3290 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-3290>`_  、 `5157 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2015-5157>`_ ：カーネルの non-masking interrupt handling のバグによるもので、権限の昇格を引き起こします。Docker コンテナでは、現在、 seccomp を使って ``modify_ldt()`` システムコールはブロックしますが、不正な攻撃を受ける可能性があります。

..     CVE-2016-5195: A race condition was found in the way the Linux kernel’s memory subsystem handled the copy-on-write (COW) breakage of private read-only memory mappings, which allowed unprivileged local users to gain write access to read-only memory. Also known as “dirty COW.” Partial mitigations: on some operating systems this vulnerability is mitigated by the combination of seccomp filtering of ptrace and the fact that /proc/self/mem is read-only.

* `CVE-2016-5195 <https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2016-5195>`_ ： 非常に稀なケースが発見されました。Linux カーネルのメモリ・サブシステムが扱うコピーオンライト（COW）が、プライベートな読み込み専用のメモリ・マッピングを破損します。これにより、権限のないローカルユーザが、読み込み専用のメモリに対する書き込みの権限を得られるというものです。これはまた「dirty COW」とも知られています。部分的な対処：いくつかのオペレーティングシステムでは、この脆弱性を ``ptrace`` の seccomp フィルタリングと、実際には ``/proc/self/mem`` を読み込み専用にすることを組み合わせ対処しています。

.. seealso:: 

   Docker security non-events
      https://docs.docker.com/engine/security/non-events/
