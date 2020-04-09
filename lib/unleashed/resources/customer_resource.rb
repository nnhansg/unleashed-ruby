module Unleashed
  # Resource for the Customers API
  # The Customers resource allows Customers to be listed, viewed, created, and updated.
  # An individual Customer's details can be viewed, or updated by appending its identifier
  # (a GUID formatted as XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX) to the URI
  #
  # @see https://apidocs.unleashedsoftware.com/Customers
  class CustomerResource < BaseResource
    def model
      Unleashed::Customer
    end

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
    def all(options = { Page: 1, PageSize: 200 })
      endpoint = 'Customers'
      params = options.dup

      # Handle Page option
      endpoint << "/#{params[:Page]}" if params[:Page].present?
      response = JSON.parse(@client.get(endpoint, params).body)
      customers = response.key?('Items') ? response['Items'] : []
      customers.map { |attributes| Unleashed::Customer.new(@client, attributes) }
    end

    # Get a single customer
    # /Customers/E6E8163F-6911-40e9-B740-90E5A0A3A996 - returns details of a particular customer.
    #
    # @param guid [String] customer ID.
    #
    # @return [Unleashed::Customer]
    def find(guid)
      endpoint = "Customers/#{guid}"
      response = JSON.parse(@client.get(endpoint).body)
      Unleashed::Customer.new(@client, response)
    end

    # Get a first customer in all
    #
    # @return [Unleashed::Customer]
    def first
      all.first
    end

    # Get a last customer in all
    #
    # @return [Unleashed::Customer]
    def last
      all.last
    end

    # Create a new customer
    #
    # @param attributes [Hash] Customer's attributes.
    # attributes = { Guid: "59f21e05-07fe-4d9d-b460-a09db4c3caa9", Addresses: [ { AddressType: "Shipping",
    #   AddressName: "Example Address", StreetAddress: "Example Address",
    #   StreetAddress2: "Example Address 2", Suburb: "Example Suburb", City: "Auckland",
    #   Region: "Auckland", Country: "New Zealand", PostalCode: "1061", IsDefault: false,
    #   DeliveryInstruction: "Have a good day" } ], TaxCode: "", TaxRate: nil,
    #   CustomerCode: "UnleashedCustomer", CustomerName: "Unleashed Customer", GSTVATNumber: nil,
    #   BankName: nil, BankBranch: nil, BankAccount: nil, Website: nil, PhoneNumber: nil, FaxNumber: nil,
    #   MobileNumber: nil, DDINumber: nil, TollFreeNumber: nil, Email: nil, EmailCC: nil,
    #   Currency: { CurrencyCode: "NZD", Description: "New Zealand, Dollars",
    #     Guid: "6cb5d67a-1c96-4fa8-bf59-b23c2d69f22a" }, Notes: nil, Taxable: true, SalesPerson: nil,
    #     DiscountRate: 0, PrintPackingSlipInsteadOfInvoice: false, PrintInvoice: false,
    #     StopCredit: false, Obsolete: false, XeroSalesAccount: nil, XeroCostOfGoodsAccount: nil,
    #     SellPriceTier: "", SellPriceTierReference: nil, CustomerType: "Cash",
    #     PaymentTerm: "20th Month following", ContactFirstName: nil, ContactLastName: nil }
    #
    # @return [Unleashed::Customer]
    def create_or_update(attributes)
      id = attributes[:Guid].present? ? attributes[:Guid] : ''
      endpoint = 'Customers'
      endpoint << "/#{id}" if id.present?
      response = JSON.parse(@client.post(endpoint, attributes).body)
      Unleashed::Customer.new(@client, response)
    end
  end
end
