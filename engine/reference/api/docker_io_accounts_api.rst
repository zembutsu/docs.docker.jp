.. -*- coding: utf-8 -*-
.. URL: https://docs.docker.com/engine/reference/api/docker_io_accounts_api/
.. SOURCE: https://github.com/docker/docker/blob/master/docs/reference/api/docker_io_accounts_api.md
   doc version: 1.11
      https://github.com/docker/docker/commits/master/docs/reference/api/docker_io_accounts_api.md
.. check date: 2016/02/25
.. Commits on Jan 27, 2016 e310d070f498a2ac494c6d3fde0ec5d6e4479e14
.. -------------------------------------------------------------------

.. docker.io accounts API

.. _docker-io-accounts-api:

=======================================
docker.io アカウント API
=======================================

.. sidebar:: 目次

   .. contents:: 
       :depth: 3
       :local:

.. Get a single user

.. _get-a-single-user:

ユーザ情報を取得
====================

.. code-block:: bash

   GET /api/v1.1/users/:username/

.. Get profile info for the specified user.

特定のユーザに関するプロフィールを取得します。

.. Parameters:

パラメータ：

..    username -- username of the user whose profile info is being requested.

* **username** … リクエスト対象のユーザのユーザ名

.. Request Headers:

リクエスト・ヘッダ：

..    Authorization -- required authentication credentials of either type HTTP Basic or OAuth Bearer Token.

* **Authorization** … 認証のために必要となる HTTP Basic 認証の情報か OAuth Bearer トークン

.. Status Codes:

ステータス・コード：

..    200 -- success, user data returned.
    401 -- authentication error.
    403 -- permission error, authenticated user must be the user whose data is being requested, OAuth access tokens must have profile_read scope.
    404 -- the specified username does not exist.

* **200** … 成功。ユーザのデータを返す
* **401** … 認証エラー
* **403** … 権限エラー。リクエストのためには適切な認証データが必要。Oauth アクセス・トークンの場合は ``profile_read`` スコープが必要
* **404** … 指定したユーザ名が存在しない

.. Example request:

**リクエスト例** ：

.. code-block:: bash

   GET /api/v1.1/users/janedoe/ HTTP/1.1
   Host: www.docker.io
   Accept: application/json
   Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=

.. Example response:

**応答例** ：

.. code-block:: bash

   HTTP/1.1 200 OK
   Content-Type: application/json
   
   {
       "id": 2,
       "username": "janedoe",
       "url": "https://www.docker.io/api/v1.1/users/janedoe/",
       "date_joined": "2014-02-12T17:58:01.431312Z",
       "type": "User",
       "full_name": "Jane Doe",
       "location": "San Francisco, CA",
       "company": "Success, Inc.",
       "profile_url": "https://docker.io/",
       "gravatar_url": "https://secure.gravatar.com/avatar/0212b397124be4acd4e7dea9aa357.jpg?s=80&r=g&d=mm"
       "email": "jane.doe@example.com",
       "is_active": true
   }

.. Update a single user

.. _update-a-single-user:

.. code-block:: bash

   PATCH /api/v1.1/users/:username/

.. Update profile info for the specified user.

特定のユーザのプロフィール情報を更新します。

.. Parameters:

パラメータ：

..    username -- username of the user whose profile info is being updated.

* **username** … プロフィールを更新するユーザのユーザ名

.. Json Parameters:

JSON パラメータ：

..    full_name (string) -- (optional) the new name of the user.
    location (string) -- (optional) the new location.
    company (string) -- (optional) the new company of the user.
    profile_url (string) -- (optional) the new profile url.
    gravatar_email (string) -- (optional) the new Gravatar email address.

* **full_name** (文字列) … （オプション）ユーザの新しい名前
* **location** (文字列) … （オプション）新しい場所
* **company** (文字列) … （オプション）ユーザの新しい会社
* **profile_url** (文字列) … （オプション）新しいプロフィール URL
* **gravatar_email** (文字列) … （オプション）新しい Gravatar メールアドレス

.. Request Headers:

リクエスト・ヘッダ：

..    Authorization -- required authentication credentials of either type HTTP Basic or OAuth Bearer Token.
..    Content-Type -- MIME Type of post data. JSON, url-encoded form data, etc.

* **Authorization** … 認証のために必要となる HTTP Basic 認証の情報か OAuth Bearer トークン
* **Content-Type** … JSON、 url エンコード形式のデータ等、ポストする MIME タイプ

.. Status Codes:

ステータス・コード：

..     200 -- success, user data updated.
    400 -- post data validation error.
    401 -- authentication error.
    403 -- permission error, authenticated user must be the user whose data is being updated, OAuth access tokens must have profile_write scope.
    404 -- the specified username does not exist.

* **200** … 成功。ユーザのデータを返す
* **400** … POST するデータ形式が無効
* **401** … 認証エラー
* **403** … 権限エラー。リクエストのためには適切な認証データが必要。Oauth アクセス・トークンの場合は ``profile_read`` スコープが必要
* **404** … 指定したユーザ名が存在しない

.. Example request:

**リクエスト例** ：

.. code-block:: bash

   PATCH /api/v1.1/users/janedoe/ HTTP/1.1
   Host: www.docker.io
   Accept: application/json
   Authorization: Basic dXNlcm5hbWU6cGFzc3dvcmQ=
   
   {
       "location": "Private Island",
       "profile_url": "http://janedoe.com/",
       "company": "Retired",
   }

.. Example response:

**応答例** ：

.. code-block:: bash

   HTTP/1.1 200 OK
   Content-Type: application/json
   
   {
       "id": 2,
       "username": "janedoe",
       "url": "https://www.docker.io/api/v1.1/users/janedoe/",
       "date_joined": "2014-02-12T17:58:01.431312Z",
       "type": "User",
       "full_name": "Jane Doe",
       "location": "Private Island",
       "company": "Retired",
       "profile_url": "http://janedoe.com/",
       "gravatar_url": "https://secure.gravatar.com/avatar/0212b397124be4acd4e7dea9aa357.jpg?s=80&r=g&d=mm"
       "email": "jane.doe@example.com",
       "is_active": true
   }

.. List email addresses for a user

.. _list-email-addresses-for-a-user:

ユーザのメールアドレス一覧
==============================

.. code-block:: bash

   GET /api/v1.1/users/:username/emails/

.. List email info for the specified user.

特定のユーザのメール情報一覧を表示。

.. Parameters:

..    username -- username of the user whose profile info is being updated.

* **username** … メール情報を表示したいユーザのユーザ名

.. Request Headers:

リクエスト・ヘッダ：

..    Authorization -- required authentication credentials of either type HTTP Basic or OAuth Bearer Token

* **Authorization** … 認証のために必要となる HTTP Basic 認証の情報か OAuth Bearer トークン

.. Status Codes:

ステータス・コード：

..    200 -- success, user data updated.
    401 -- authentication error.
    403 -- permission error, authenticated user must be the user whose data is being requested, OAuth access tokens must have email_read scope.
    404 -- the specified username does not exist.

* **200** … 成功。ユーザのデータを返す
* **401** … 認証エラー
* **403** … 権限エラー。リクエストのためには適切な認証データが必要。Oauth アクセス・トークンの場合は ``profile_read`` スコープが必要
* **404** … 指定したユーザ名が存在しない

.. Example request:

**リクエスト例** ：

.. code-block:: bash

   GET /api/v1.1/users/janedoe/emails/ HTTP/1.1
   Host: www.docker.io
   Accept: application/json
   Authorization: Bearer zAy0BxC1wDv2EuF3tGs4HrI6qJp6KoL7nM

.. Example response:

**応答例** ：

.. code-block:: bash

   HTTP/1.1 200 OK
   Content-Type: application/json
   
   [
       {
           "email": "jane.doe@example.com",
           "verified": true,
           "primary": true
       }
   ]

.. Add email address for a user

.. _add-email-address-for-a-user:

ユーザにメールアドレスを追加
==============================

.. code-block:: bash

   POST /api/v1.1/users/:username/emails/

.. Add a new email address to the specified user’s account. The email address must be verified separately, a confirmation email is not automatically sent.

特定のユーザ・アカウントに対して新しいメールアドレスを追加します。メールアドレスは個々に確認されたものであるとし、確認用のメールは自動的に送信されません。

.. Json Parameters:

JSON パラメータ：

..    email (string) -- email address to be added.

* **email** (文字列) … メールアドレスが追加されます。

.. Request Headers:

リクエスト・ヘッダ：

..     Authorization -- required authentication credentials of either type HTTP Basic or OAuth Bearer Token.
..     Content-Type -- MIME Type of post data. JSON, url-encoded form data, etc.

* **Authorization** … 認証のために必要となる HTTP Basic 認証の情報か OAuth Bearer トークン
* **Content-Type** … JSON、 url エンコード形式のデータ等、ポストする MIME タイプ

.. Status Codes:

ステータス・コード：

..    201 -- success, new email added.
    400 -- data validation error.
    401 -- authentication error.
    403 -- permission error, authenticated user must be the user whose data is being requested, OAuth access tokens must have email_write scope.
    404 -- the specified username does not exist.

* **200** … 成功。ユーザのデータを返す
* **400** … POST するデータ形式が無効
* **401** … 認証エラー
* **403** … 権限エラー。リクエストのためには適切な認証データが必要。Oauth アクセス・トークンの場合は ``profile_read`` スコープが必要
* **404** … 指定したユーザ名が存在しない。

.. Example request:

**リクエスト例** ：

.. code-block:: bash

   POST /api/v1.1/users/janedoe/emails/ HTTP/1.1
   Host: www.docker.io
   Accept: application/json
   Content-Type: application/json
   Authorization: Bearer zAy0BxC1wDv2EuF3tGs4HrI6qJp6KoL7nM
   
   {
       "email": "jane.doe+other@example.com"
   }

.. Example response:

**応答例** ：

.. code-block:: bash

   HTTP/1.1 201 Created
   Content-Type: application/json
   
   {
       "email": "jane.doe+other@example.com",
       "verified": false,
       "primary": false
   }

.. Delete email address for a user

.. _delete-email-address-for-auser:

ユーザのメールアドレスを削除
==============================

.. code-block:: bash

   DELETE /api/v1.1/users/:username/emails/

.. Delete an email address from the specified user’s account. You cannot delete a user’s primary email address.

特定のユーザ・アカウントに登録されているメールアドレスを削除します。ユーザのプライマリ・メールアドレスは削除できません。

.. Json Parameters:

JSON パラメータ：

..    email (string) -- email address to be added.

* **email** (文字列) … メールアドレスが追加されます。

.. Request Headers:

リクエスト・ヘッダ：

..    Authorization -- required authentication credentials of either type HTTP Basic or OAuth Bearer Token.
..    Content-Type -- MIME Type of post data. JSON, url-encoded form data, etc.


* **Authorization** … 認証のために必要となる HTTP Basic 認証の情報か OAuth Bearer トークン
* **Content-Type** … JSON、 url エンコード形式のデータ等、ポストする MIME タイプ

.. Status Codes:

ステータス・コード：

..    201 -- success, new email added.
    400 -- data validation error.
    401 -- authentication error.
    403 -- permission error, authenticated user must be the user whose data is being requested, OAuth access tokens must have email_write scope.
    404 -- the specified username does not exist.

* **200** … 成功。ユーザのデータを返す
* **400** … POST するデータ形式が無効
* **401** … 認証エラー
* **403** … 権限エラー。リクエストのためには適切な認証データが必要。Oauth アクセス・トークンの場合は ``profile_read`` スコープが必要
* **404** … 指定したユーザ名が存在しない。

.. Example request:

**リクエスト例** ：

.. code-block:: bash

   DELETE /api/v1.1/users/janedoe/emails/ HTTP/1.1
   Host: www.docker.io
   Accept: application/json
   Content-Type: application/json
   Authorization: Bearer zAy0BxC1wDv2EuF3tGs4HrI6qJp6KoL7nM
   
   {
       "email": "jane.doe+other@example.com"
   }

.. Example response:

**応答例** ：

.. code-block:: bash

    HTTP/1.1 204 NO CONTENT
    Content-Length: 0

.. seealso:: 

   docker.io accounts API
      https://docs.docker.com/engine/reference/api/docker_io_accounts_api/
