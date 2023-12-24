![CrazyTrain Logo](./crazy_train.png)

*I'm going off the rails on a crazy train.*

# CrazyTrain

 *This gem is still unstable.*

Provides a RESTful API for database tables into your rails apps.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "crazy_train"
```

And then execute:

```console
$ bundle install
```

Execute the below to generate a configuration file. 

```console
$ rails generate crazy_train:install
```

```ruby
# config/initializers/crazy_train.rb:
CrazyTrain.setup do |config|
  config.secret = 'xxxxxxxxxxxxxxxx'
  config.unauthorized_role = 'anonymous'
  config.authorized_role = 'authenticated'
end
```

Then add a line to routes.rb to mount the API.

```ruby
# routes.rb:
Rails.application.routes.draw do
  mount CrazyTrain::Engine, at: '/api'
end
```

## Usage

crazy_train uses RLS for access control.

If accessed without authentication, it is accessed with `anonymous` ROLE.
If accessed with authentication, it is accessed with `authenticated` ROLE.

Set the authorization and RLS POLICY so that posts can `SELECT` even when unauthorized.

(Assume that you have a `posts` table in an existing rails project.)

```sql
GRANT SELECT ON posts TO anonymous;
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
CREATE POLICY posts_policy ON posts TO anonymous USING (TRUE);
```

Then you can use the REST API as follows.

```console
$ curl http://localhost:3000/api/posts
[
  {
    "id": 1,
    "content": "crazy"
  },
  {
    "id": 2,
    "content": "train"
  }
]
```

You can use the API in the same way if you also set up permissions and POLICY settings for other tables and other ROLEs.

Access to the DB in rails is done by `default` ROLE, so it is not affected.

For complex items, create a Web API manually as usual, and use this for items that require a simple CRUD.

## Authentication

crazy_train provides a mechanism for authentication in JWT.

You can generate a token using the `crazy_train:generate_token` task.
(secret uses the value of `CrazyTrain.config.secret`)

```console
$ rails crazy_train:generate_token
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
```

The token allows you to access the API in an authenticated state.

```console
$ curl curl http://localhost:3000/api/posts/1234 \
  -H "Authorization: Bearer aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
{
  "id": 1234,
  "content": "crazy"
}
```

### JWT-Based User Impersonation

What if I want to create another ROLE (e.g. `admin` ROLE) for authentication?

In crazy_train, if there is a `role` item in the JWT payload, it will be used as the ROLE name.

To create a token to authenticate with admin ROLE, do the following

```console
$ rails crazy_train:generate_token PAYLOAD='{"role": "admin"}'
bbbbbbbbbbbbbbbbbbbbbbbbbbb
```

When the API is accessed using this token, the DB is accessed as an `admin` ROLE.

```console
$ curl curl http://localhost:3000/api/posts/1234 \
  -H "Authorization: Bearer bbbbbbbbbbbbbbbbbbbbbbbbbbb
{
  "id": 1234,
  "content": "crazy"
}
```

### Individual user identification

What if I need to identify individual users to create a POLICY, such as "I can only view the `posts` I have posted"?

In crazy_train, the JWT payload can be retrieved via a user-defined configuration parameter in postgresql.

If you want to use the following as a PAYLOAD,

```json
{ "user_id": 1234 }
```

In the DB, you can use `current_setting` to get it from `request.jwt.claims`.

```sql
SELECT current_setting('request.jwt.claims', true)::json->>'user_id';
# => 1234
```

The POLICY "Only your `posts`` can be viewed" can be written as follows.

```sql
CREATE POLICY posts_policy ON posts
  USING (user_id = current_setting('request.jwt.claims', true)::json->>'user_id');
```

## API

Allows CRUD to be performed on tables that exist in the DB.

| HTTP Verb | URL | Description |
| --------- | --- | ----------- |
| GET | `/api/posts` | List |
| GET | `/api/posts/1234` | Read |
| POST | `/api/posts` | Create |
| PUT | `/api/posts/1234` | Update |
| Delete | `/api/posts/1234` | Delete |

```sh
$ curl localhost:3000/api/posts
[{"id":1,"body":"text 1"},{"id":2,"body":"text 2"},{"id":3,"body":"text 3"}]
```

```sh
$ curl localhost:3000/api/posts/1
{"id":1,"body":"text 1"}
```

### Ordering

Sorting can be performed using the `order` parameter. Column names and sort order are separated by `. `, and multiple rules are separated by `,`.

```console
$ curl http://localhost:3000/api/posts?order=content.asc,id.desc
[
  {
    "id": 2,
    "content": "train"
  },
  {
    "id": 1,
    "content": "crazy"
  }
]
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
