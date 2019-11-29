module Unleashed
  # Resource for the Invoices API
  # The Invoices resource allows sales invoices to be listed and viewed.
  # An individual sales invoice details can be viewed by appending its identifier
  # (a GUID formatted as XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX) to the URI.
  #
  # @see https://apidocs.unleashedsoftware.com/Invoices
  class InvoiceResource < BaseResource
    def model
      Unleashed::Invoice
    end

    # List all invoices
    # /Invoices - also returns the first 200 invoices because page number 1 is the default.
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :page_size Can ask for up to 200 invoices. default: 10
    # @option options [Integer] :page Page index. default: 1
    #
    # @return [Array<Unleashed::Invoice>] List all invoices.
    def all(options = { page: 1, page_size: 10 })
      response = JSON.parse(@client.get('Invoices', options).body)
      invoices = response.key?('Items') ? response['Items'] : []
      invoices.map { |attributes| Unleashed::Invoice.new(@client, attributes) }
    end

    # Get a single invoice
    # /Invoices/E6E8163F-6911-40e9-B740-90E5A0A3A996 - returns details of a particular invoice.
    #
    # @param id [String] invoice ID.
    #
    # @return [Unleashed::Invoice]
    def find(id)
      response = JSON.parse(@client.get("Invoices/#{id}").body)
      Unleashed::Invoice.new(@client, response)
    end

    # Get a first invoice in all
    #
    # @return [Unleashed::Invoice]
    def first
      all.first
    end

    # Get a last invoice in all
    #
    # @return [Unleashed::Invoice]
    def last
      all.last
    end
  end
end
