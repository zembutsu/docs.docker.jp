.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/docker-hub/orgs/
.. SOURCE: -
   doc version: 1.10
.. check date: 2016/03/11
.. -------------------------------------------------------------------

.. title: Organizations and teams in Docker Hub

.. _organizations-and-teams-in-docker-hub

========================================
Docker Hub における組織とチーム
========================================

.. Docker Hub [organizations](https://hub.docker.com/organizations/) let you create
   teams so you can give colleagues access to shared image repositories. A Docker
   Hub organization can contain public and private repositories just like a user
   account. Access to push or pull for these repositories is allocated by defining
   teams of users and then assigning team rights to specific repositories.
   Repository creation is limited to users in the organization owner's group. This
   allows you to distribute limited access Docker images, and to select which
   Docker Hub users can publish new images.

Docker Hub の `組織 <https://hub.docker.com/organizations/>`_ （organizations）は、チームの生成を行い、チームメンバーがイメージリポジトリを共有アクセスできるようにするものです。
ユーザーアカウントと同じように、組織にも公開リポジトリとプライベートリポジトリがあります。
このリポジトリに対してプッシュやプルを行う権限は、ユーザーのチーム定義によって定められ、特定のリポジトリに対するチームの権限として与えます。
リポジトリを生成できるのは、組織の所有者グループに属するユーザーに限定されます。
したがって Docker イメージに対するアクセスを制限した配布が可能となり、新イメージの公開ができるのはどの Docker Hub ユーザーとするかを設定することができます。

.. ### Creating and viewing organizations

.. _creating-and-viewing-organizations

組織の生成と確認
------------------------------

.. You can see which organizations you belong to and add new organizations by
   clicking **Organizations** in the top nav bar.

所属する組織は何かを確認し、または新たな組織を追加するには、最上段にあるナビゲーションバーの **Organizations** をクリックします。

.. ![organizations](images/orgs.png)

.. image:: ./images/orgs.png
   :scale: 60%
   :alt: organizations 画面

.. ### Organization teams

.. _organization-teams:

組織内のチーム
--------------------

.. Users in the "Owners" team of an organization can create and modify the
   membership of all teams.

組織内の「所有者」（Owners）チームに属するユーザであれば、すべてのチームにおけるメンバの追加や削除を行うことができます。

.. Other users can only see teams they belong to.

それ以外のユーザは、自身が属するチームのみを参照することができます。

.. ![teams](images/groups.png)

.. image:: ./images/groups.png
   :scale: 60%
   :alt: チーム

.. Repository team permissions

.. _repository-team-permissions:

リポジトリのチーム権限
------------------------------

.. Use teams to manage who can interact with your repositories.

teams（チーム）はリポジトリを操作できるユーザを管理します。

.. You need to be a member of the organization’s “Owners” team to create a new team, Hub repository, or automated build. As an “Owner”, you then delegate the following repository access rights to a team using the “Collaborators” section of the repository view:

新しいチームの作成、Hub リポジトリの作成、自動構築をするには、organization の「Owners」（所有者）チームのメンバである必要があります。「Owner」であれば、対象のリポジトリに対して権限を与えるため、リポジトリの画面で「Collaborators」セクションを選べます。

..    Read access allows a user to view, search, and pull a private repository in the same way as they can a public repository.
    Write access users are able to push to non-automated repositories on the Docker Hub.
    Admin access allows the user to modify the repositories “Description”, “Collaborators” rights, “Public/Private” visibility and “Delete”.

* ``Read`` （読み込み）権限は、ユーザに対してプライベート・リポジトリをパブリック・リポジトリと同じように表示・検索・取得をできるようにします。
* ``Write`` （書き込み）権限は、Docker Hub のリポジトリに対して、手動で送信（push）できるようにします。
* ``Admin`` （管理）権限は、リポジトリに対するユーザの「Description」「Collaborators」権限設定、「Public/Private」の可視性や、「Delete」を行えます。

..    Note: A User who has not yet verified their email address will only have Read access to the repository, regardless of the rights their team membership has given them.

.. note::

   メールアドレスの確認できないユーザは、チームのメンバに所属し適切な権限を割り与えていたとしても、リポジトリに対しては ``Read`` 権限しか与えられません。

.. Organization repository collaborators

.. image:: ./images/org-repo-collaborators.png
   :scale: 60%
   :alt: Organization リポジトリのコラボレータ


.. seealso:: 

   Organizations and teams
      https://docs.docker.com/docker-hub/orgs/
