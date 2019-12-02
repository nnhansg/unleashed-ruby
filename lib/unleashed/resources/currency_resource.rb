module Unleashed
  # Resource for the Currencies API
  # The Currencies resource allows Currencies to be listed, viewed.
  # @see https://apidocs.unleashedsoftware.com/Sandbox
  class CurrencyResource < BaseResource
    def model
      Unleashed::Currency
    end

    # List all currencies
    # /Currencies - also returns the first 200 currencies because page number 1 is the default.
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :page_size Can ask for up to 200 currencies. default: 10
    # @option options [Integer] :page Page index. default: 1
    #
    # @return [Array<Unleashed::Currency>] List all currencies.
    def all(options = { page: 1, page_size: 10 })
      response = JSON.parse(@client.get('Currencies', options).body)
      currencies = response.key?('Items') ? response['Items'] : []
      currencies.map { |attributes| Unleashed::Currency.new(@client, attributes) }
    end

    # Get a first currency in all
    #
    # @return [Unleashed::Currency]
    def first
      all.first
    end

    # Get a last currency in all
    #
    # @return [Unleashed::Currency]
    def last
      all.last
    end
  end
end
