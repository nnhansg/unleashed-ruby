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
    # @option options [Integer] :page_size Can ask for up to 200 customers. default: 10
    # @option options [Integer] :page Page index. default: 1
    #
    # @return [Array<Unleashed::Customer>] List all customers.
    def all(options = { page: 1, page_size: 10 })
      response = JSON.parse(@client.get('Customers', options).body)
      customers = response.key?('Items') ? response['Items'] : []
      customers.map { |attributes| Unleashed::Customer.new(@client, attributes) }
    end

    # Get a single customer
    # /Customers/E6E8163F-6911-40e9-B740-90E5A0A3A996 - returns details of a particular customer.
    #
    # @param id [String] customer ID.
    #
    # @return [Unleashed::Customer]
    def find(id)
      response = JSON.parse(@client.get("Customers/#{id}").body)
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
    #
    # @return [Unleashed::Customer]
    def create(attributes)
      id = attributes[:Guid].present? ? attributes[:Guid] : ''
      response = JSON.parse(@client.post("Customers/#{id}", attributes).body)
      Unleashed::Customer.new(@client, response)
    end
  end
end
