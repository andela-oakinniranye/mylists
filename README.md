[![Coverage Status](https://coveralls.io/repos/andela-oakinniranye/mylyst/badge.svg?branch=master&service=github)](https://coveralls.io/github/andela-oakinniranye/mylyst?branch=master)

# Bucketlist

Everyday, there's this list of things you dream of doing before you pass on.

- Dreams you wish to fulfil
- Ideas you wish to implement
- Friends you wish to make
- Cars you wish to drive
- Places you wish to go

> What a life of wishes, really

The bucketlist service may not be a genie to do "pooof" and all your wishes will
appear, but a service that enables you to create this list of things you want to
do, categorize them under a bucketlist and mark it's status.
* * *
> As a bit of helper, there's an additional endpoint that allows you to create an account to access bucketlists

> POST /users {name: NAME, email: EMAIL, password: PASSWORD}

or

> curl -X POST -d 'name=name&password=PASSWORD&email=EMAIL' https://mylyst.herokuapp.com/v1/users

then, to obtain a token

> POST /auth/login {email: email, password: password}

or

> curl -X POST -d 'password=PASSWORD&email=EMAIL' https://mylyst.herokuapp.com/v1/auth/login

You can then make a request to any of the endpoints listed by using the provided token

Sample request using curl:

> curl -H 'Authorization: Token token=TOKEN' https://mylyst.herokuapp.com/v1/bucketlists/1

* * *

API endpoints exposed includes:

<table>
  <thead>
    <tr>
      <td>
        EndPoint
      </td>
      <td>
        Public Access
      </td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        POST /auth/login
      </td>
      <td>
        TRUE
      </td>
    </tr>
    <tr>
      <td>
        GET /auth/logout
      </td>
      <td>
        FALSE
      </td>
    </tr>
    <tr>
      <td>
        POST /bucketlists/
      </td>
      <td>
        FALSE
      </td>
    </tr>
    <tr>
      <td>
        GET /bucketlists/
      </td>
      <td>
        TRUE
      </td>
    </tr>
    <tr>
      <td>
        GET /bucketlists/<id>
      </td>
      <td>
        FALSE
      </td>
    </tr>
    <tr>
      <td>
        POST /bucketlists/<id>
      </td>
      <td>
        FALSE
      </td>
    </tr>
    <tr>
      <td>
        PUT /bucketlists/<id>
      </td>
      <td>
        FALSE
      </td>
    </tr>
    <tr>
      <td>
        DELETE /bucketlists/<id>
      </td>
      <td>
        FALSE
      </td>
    </tr>
  </tbody>
</table>

* * *

## Requirements

##### Problem Description
> In this exercise you will be required to create a Rails API for a bucket list
service. Specification for the API is shown below. You may use any database you
prefer for this assignment.

<table>
  <thead>
    <tr>
      <td>
        EndPoint
      </td>
      <td>
        Functionality
      </td>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>
        POST /auth/login
      </td>
      <td>
        Logs a user in
      </td>
    </tr>
    <tr>
      <td>
        GET /auth/logout
      </td>
      <td>
        Logs a user out
      </td>
    </tr>
    <tr>
      <td>
        POST /bucketlists/
      </td>
      <td>
        Create a new bucket list
      </td>
    </tr>
    <tr>
      <td>
        GET /bucketlists/
      </td>
      <td>
        List all the created bucket lists
      </td>
    </tr>
    <tr>
      <td>
        GET /bucketlists/<id>
      </td>
      <td>
        Get single bucket list
      </td>
    </tr>
    <tr>
      <td>
        POST /bucketlists/<id>
      </td>
      <td>
        Add a new item to this bucket list
      </td>
    </tr>
    <tr>
      <td>
        PUT /bucketlists/<id>
      </td>
      <td>
        Update this bucket list
      </td>
    </tr>
    <tr>
      <td>
        DELETE /bucketlists/<id>
      </td>
      <td>
        Delete this single bucket list
      </td>
    </tr>
  </tbody>
</table>


### Task 0 - Create API
> In this task you are required to create the API described above using Rails API.
> The JSON data model for a bucket list and a bucket list item is shown below.

>  {
>   id: 1,
>   name: “BucketList1”,
>   items: [
>    {
>  id: 1,
>  name: “I need to do X”,
>  date_created: “2015-08-12 11:57:23”,
>  date_modified: “2015-08-12 11:57:23”,
>  done: False
>  }
>  ],
>   date_created: “2015-08-12 11:57:23”,
>   date_modified: “2015-08-12 11:57:23”,
>   created_by: “1113456”
>  }


### Task 1 - Implement Token Based Authentication
> For this task, you are required to implement Token Based Authentication for
> the API such that some methods are not accessible via unauthenticated users.

> **Note: GET /bucketlists/ should return an array of bucketlist containing name and id only.**

### Task 2 - Version your API
