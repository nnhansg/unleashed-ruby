# Unleashed

[![Join the chat at https://gitter.im/unleashed-ruby/community](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/unleashed-ruby/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[![Gem Version](https://badge.fury.io/rb/unleashed.svg)](https://badge.fury.io/rb/unleashed)
[![Build Status](https://travis-ci.org/nnhansg/unleashed-ruby.svg?branch=master)](https://travis-ci.org/nnhansg/unleashed-ruby)
[![Coverage Status](https://coveralls.io/repos/github/nnhansg/unleashed-ruby/badge.svg)](https://coveralls.io/github/nnhansg/unleashed-ruby)
[![Code Climate](https://codeclimate.com/github/nnhansg/unleashed-ruby/badges/gpa.svg)](https://codeclimate.com/github/nnhansg/unleashed-ruby)
[![Maintainability](https://api.codeclimate.com/v1/badges/e41f32cc2a422dcecbf7/maintainability)](https://codeclimate.com/github/nnhansg/unleashed-ruby/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/e41f32cc2a422dcecbf7/test_coverage)](https://codeclimate.com/github/nnhansg/unleashed-ruby/test_coverage)

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

### Setup environment variables

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

### Setup default Unleashed client from environment variables

Add file `unleashed.rb` to `config/initializers`

```ruby
Unleashed.setup
```

## 3. Usage

### Instantiate the Unleashed client manually

```ruby
options = { api_id: ENV['UNLEASHED_API_ID'], api_key: ENV['UNLEASHED_API_KEY'] }
client = Unleashed::Client.new(options)
```

### Customers

#### Create a new Customer

```ruby
customer = client.customers.create(
  Guid: '59f21e05-07fe-4d9d-b460-a09db4c3caa9',
  Addresses: [
    {
      AddressType: 'Shipping',
      AddressName: 'Example Address',
      StreetAddress: 'Example Address',
      StreetAddress2: 'Example Address 2',
      Suburb: 'Example Suburb',
      City: 'Auckland',
      Region: 'Auckland',
      Country: 'New Zealand',
      PostalCode: '1061',
      IsDefault: false,
      DeliveryInstruction: 'Have a good day'
    }
  ],
  TaxCode: '',
  TaxRate: nil,
  CustomerCode: 'UnleashedCustomer',
  CustomerName: 'Unleashed Customer',
  GSTVATNumber: nil,
  BankName: nil,
  BankBranch: nil,
  BankAccount: nil,
  Website: nil,
  PhoneNumber: nil,
  FaxNumber: nil,
  MobileNumber: nil,
  DDINumber: nil,
  TollFreeNumber: nil,
  Email: nil,
  EmailCC: nil,
  Currency: {
    CurrencyCode: 'NZD',
    Description: 'New Zealand, Dollars',
    Guid: 'c33e4f50-e42b-40cd-9147-4d0e4657cd4d'
  },
  Notes: nil,
  Taxable: true,
  SalesPerson: nil,
  DiscountRate: 0.0000,
  PrintPackingSlipInsteadOfInvoice: false,
  PrintInvoice: false,
  StopCredit: false,
  Obsolete: false,
  XeroSalesAccount: nil,
  XeroCostOfGoodsAccount: nil,
  SellPriceTier: '',
  SellPriceTierReference: nil,
  CustomerType: 'Cash',
  PaymentTerm: '20th Month following',
  ContactFirstName: nil,
  ContactLastName: nil
)
```

#### Update a Customer

```ruby
customer = client.customers.update(
  Guid: '59f21e05-07fe-4d9d-b460-a09db4c3caa9',
  Addresses: [
    {
      AddressType: 'Shipping',
      AddressName: 'Example Address',
      StreetAddress: 'Example Address',
      StreetAddress2: 'Example Address 2',
      Suburb: 'Example Suburb',
      City: 'Auckland',
      Region: 'Auckland',
      Country: 'New Zealand',
      PostalCode: '1061',
      IsDefault: false,
      DeliveryInstruction: 'Have a good day'
    }
  ],
  TaxCode: '',
  TaxRate: nil,
  CustomerCode: 'UnleashedCustomer',
  CustomerName: 'Unleashed Customer',
  GSTVATNumber: nil,
  BankName: nil,
  BankBranch: nil,
  BankAccount: nil,
  Website: nil,
  PhoneNumber: nil,
  FaxNumber: nil,
  MobileNumber: nil,
  DDINumber: nil,
  TollFreeNumber: nil,
  Email: nil,
  EmailCC: nil,
  Currency: {
    CurrencyCode: 'NZD',
    Description: 'New Zealand, Dollars',
    Guid: '6cb5d67a-1c96-4fa8-bf59-b23c2d69f22a'
  },
  Notes: nil,
  Taxable: true,
  SalesPerson: nil,
  DiscountRate: 0.0000,
  PrintPackingSlipInsteadOfInvoice: false,
  PrintInvoice: false,
  StopCredit: false,
  Obsolete: false,
  XeroSalesAccount: nil,
  XeroCostOfGoodsAccount: nil,
  SellPriceTier: '',
  SellPriceTierReference: nil,
  CustomerType: 'Cash',
  PaymentTerm: '20th Month following',
  ContactFirstName: nil,
  ContactLastName: nil
)
```

#### Get all customers

```ruby
client.customers.all
```

#### Get a customer

```ruby
client.customers.find('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX')
```

#### Get the first customer

```ruby
client.customers.first
```

#### Get the last customer

```ruby
client.customers.last
```

### Invoices

#### Get all invoices

```ruby
client.invoices.all
```

#### Get an invoice

```ruby
client.invoices.find('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX')
```

#### Get the first invoice

```ruby
client.invoices.first
```

#### Get the last invoice

```ruby
client.invoices.last
```

### Currencies

#### Get all currencies

```ruby
client.currencies.all
```

#### Get the first currency

```ruby
client.currencies.first
```

#### Get the last currency

```ruby
client.currencies.last
```

### Payment Terms

#### Get all payment terms

```ruby
client.payment_terms.all
```

#### Get the first payment term

```ruby
client.payment_terms.first
```

#### Get the last payment term

```ruby
client.payment_terms.last
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
