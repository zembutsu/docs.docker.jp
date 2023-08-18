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
   :width: 60%
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
   :width: 60%
   :alt: チーム

.. ### Repository team permissions

.. _repository-team-permissions:

リポジトリのチーム権限
------------------------------

.. Use teams to manage who can interact with your repositories.

チームを使って、どのユーザがリポジトリを操作できるかを管理します。

.. You need to be a member of the organization's "Owners" team to create a new
   team, Hub repository, or automated build. As an "Owner", you then delegate the
   following repository access rights to a team using the "Collaborators" section
   of the repository view.

チーム、Hub リポジトリの新規生成、自動ビルドの設定を行うためには、その組織の「所有者」チームのメンバである必要があります。
「所有者」となって、以下のようなリポジトリアクセスの権限をチームに対して与えます。
これはリポジトリ画面の「Collaborators」セクションから行います。

.. Permissions are cumulative. For example, if you have Write permissions, you
   automatically have Read permissions:

パーミッションは積み上げられるような性質を持っています。
たとえば書き込みパーミッションがあったとすると、それは自動的に読み込みパーミッションも有していることになります。

.. - `Read` access allows users to view, search, and pull a private repository in the same way as they can a public repository.
   - `Write` access allows users to push to non-automated repositories on the Docker Hub.
   - `Admin` access allows users to modify the repositories "Description", "Collaborators" rights, "Public/Private" visibility and "Delete".

- ``Read`` （読み込み）権限は、公開リポジトリに対する操作と同じように、 プライベート・リポジトリの参照、検索、プルを行うことができます。
- ``Write`` （書き込み）権限は、Docker Hub 上の自動ビルドではないリポジトリに対してプッシュすることができます。
- ``Admin`` （管理）権限は、リポジトリに対して "Description"、"Collaborators" の権限、"Public/Private" の別を編集したり、"Delete" を行ったりすることができます。

.. > **Note**: A User who has not yet verified their email address will only have
   > `Read` access to the repository, regardless of the rights their team
   > membership has given them.

.. note::

   メールアドレスの検証が済んでいないユーザは、たとえチームメンバとしての権限が与えられていても、リポジトリに対しては ``Read`` 権限しか与えられません。

.. ![Organization repository collaborators](images/org-repo-collaborators.png)

.. image:: ./images/org-repo-collaborators.png
   :width: 60%
   :alt: Organization リポジトリのコラボレータ


.. seealso:: 

   Organizations and teams in Docker Hub
      https://docs.docker.com/docker-hub/orgs/
