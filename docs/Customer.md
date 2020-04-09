# Unleashed::Customer

## Create a new Customer

```ruby
customer = client.customers.create_or_update(
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

## Update a Customer

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

## Get all customers

```ruby
# List all customers
# /Customers - also returns the first 200 customers because page number 1 is the default.
#
# @param options [Hash] Optional options.
# @option PageSize: Can ask for up to 200 customers. Default: 200
# @option Page: Page index. Default: 1
# @option CustomerType: Only returns customers that matches the specified customer type.
# @option SellPriceTier: Only returns customers that are assigned to the specified sell price tier.
# @option Currency: Only returns customers with currency code exactly matching the specified value.
# @option Customer: Returns customers whose customer code or customer name contains the specified value. It is case-sensitive.
# @option CustomerCode: Only returns customers that start with the specific customer code.
# @option CustomerName: Only returns customers that start with the specific customer name.
# @option ContactEmail: Only returns customers that have a contact email that starts with the specified email address.
# @option ModifiedSince: Only returns customers modified since a specified date.
# @option IncludeObsolete: Returns all customers, including obsolete, if set to `true`. If set to `false` or if it is not specified then returns only active (ie. non-obsolete) customers.
# @option XeroContactId: Only returns customers that start with the specific Xero Contact Id.
# @option OrderBy: Orders the list by `LastModifiedOn` or `CreatedOn` date. By default the list is ordered by `CustomerCode`.
# @option Sort: Orders the list by `CreatedOn` date sorted in ascending or descending order.
#
# @return [Array<Unleashed::Customer>] List all customers.
client.customers.all
```

## Get a customer

```ruby
client.customers.find('XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX')
```

## Get the first customer

```ruby
client.customers.first
```

## Get the last customer

```ruby
client.customers.last
```
