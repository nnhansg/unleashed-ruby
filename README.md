# Unleashed

Ruby gem for invoking Unleashedsoftware RESTful API [https://apidocs.unleashedsoftware.com](https://apidocs.unleashedsoftware.com)

## 1. Installation

Add this line to your application's Gemfile:

```ruby
gem 'unleashed'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install unleashed

## 2. Configuration

Before interacting with Unleashed API you need to sign up an account.

See [Unleashed API Documentation](https://apidocs.unleashedsoftware.com/) for more information.

### Create a Unleashed client

The client can be configured through environment variables.

```ruby
# In your environment file
# Default
UNLEASHED_API_DOMAIN = api.unleashedsoftware.com
UNLEASHED_CLIENT_TYPE_HEADER = API-Sandbox

UNLEASHED_API_ID = yourapiid
UNLEASHED_API_KEY = yourapikey
```

The following parameters are configurable through the client:

* `:api_domain` / `ENV['UNLEASHED_API_DOMAIN']`: API domain name to use (default: 'api.unleashedsoftware.com')
* `:api_id` / `ENV['UNLEASHED_API_ID']`: API ID
* `:api_key` / `ENV['UNLEASHED_API_KEY']`: API KEY
* `:client_type_header` / `ENV['UNLEASHED_CLIENT_TYPE_HEADER']`: Client Type Header to use (default: 'API-Sandbox')

## 3. Usage

### Instantiate the Unleashed client

```ruby
options = { api_id: ENV['UNLEASHED_API_ID'], api_key: ENV['UNLEASHED_API_KEY'] }
client = Unleashed::Client.new(options)
```

### Customers

#### Get all customers

```ruby
client.customers.all
```

#### Get a customer

```ruby
client.customers.find('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX')
```

## 4. Contributing

  1. Fork it [https://github.com/nnhansg/unleashed-ruby](https://github.com/nnhansg/unleashed-ruby)
  2. Create your feature branch (`git checkout -b my-new-feature`)
  3. Commit your changes (`git commit -am 'Add some feature'`)
  4. Push to the branch (`git push origin my-new-feature`)
  5. Create a new Pull Request

## 5. License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## 6. Code of Conduct

Everyone interacting in the Unleashed project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/nnhansg/unleashed-ruby/blob/master/CODE_OF_CONDUCT.md).
