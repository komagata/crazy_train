*This gem is still unstable and should be used with extreme caution in a production environment.*

# CrazyTrain
Provides a RESTful API for database tables for your rails apps.

## Usage
CrazyTrain is provided as an Engine.
Add the following to routes.rb and mount it at any URL you like.

```ruby
Rails.application.routes.draw do
  mount CrazyTrain::Engine, at: '/api'
end
```

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

## Installation
Add this line to your application's Gemfile:

```ruby
gem "crazy_train"
```

And then execute:
```bash
$ bundle
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
