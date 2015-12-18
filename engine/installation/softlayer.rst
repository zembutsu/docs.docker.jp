.. -*- coding: utf-8 -*-
.. https://docs.docker.com/engine/installation/softlayer/
.. doc version: 1.9
.. check date: 2015/12/18
.. -----------------------------------------------------------------------------

.. IBM SoftLayer

==============================
IBM SoftLayer
==============================

..    Create an IBM SoftLayer account.

1. `IBM SoftLayer アカウント <https://www.softlayer.com/cloud-servers/>`_ を作成します。

..    Log in to the SoftLayer Customer Portal.

2. `SoftLayer カスタマー・ポータル <https://control.softlayer.com/>`_ にログインします。

..    From the Devices menu select Device List

3. `Device List <https://control.softlayer.com/devices>`_ メニューから *Devices* を選びます。

..    Click Order Devices on the top right of the window below the menu bar.

4. メニューバーの下、ウインドウの右上にある *Order Devices* をクリックします。

..    Under Virtual Server click Hourly

5. *Virtual Server* の下にある `Hourly <https://manage.softlayer.com/Sales/orderHourlyComputingInstance>`_ をクリックします。

..    Create a new SoftLayer Virtual Server Instance (VSI) using the default values for all the fields and choose:

6. 新しい SoftLayer 仮想サーバ・インスタンス(VSI)を作成します。全てデフォルトの項目ですが、以下の部分を変更します。

..        The desired location for Datacenter
..        Ubuntu Linux 12.04 LTS Precise Pangolin - Minimal Install (64 bit) for Operating System.

* *Datacenter* は任意の場所
* *Operating System* は *Ubuntu Linux 14.04 LTS - Minimal Install (64bit)*

..    Click the Continue Your Order button at the bottom right.

7. 右下にある*Continue Your Order* ボタンをクリックします。

..    Fill out VSI hostname and domain.

8. VSI *hostname* と *domain* を入力します。

..    Insert the required User Metadata and place the order.

9. 必要な *User Metadata* を入力し、 注文します。

..    Then continue with the Ubuntu instructions.

10. 以降は :doc:`Ubuntu </engine/installation/ubuntulinux>` の手順に従います。

