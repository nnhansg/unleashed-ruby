module Unleashed
  # Resource for the PaymentTerms API
  # The PaymentTerms resource allows PaymentTerms to be listed.
  #
  # @see https://apidocs.unleashedsoftware.com/PaymentTerms
  class PaymentTermResource < BaseResource
    def model
      Unleashed::PaymentTerm
    end

    # List all payment_terms
    # /PaymentTerms - also returns the first 200 payment_terms because page number 1 is the default.
    #
    # @param options [Hash] Optional options.
    # @option options [Integer] :page_size Can ask for up to 200 payment_terms. default: 10
    # @option options [Integer] :page Page index. default: 1
    #
    # @return [Array<Unleashed::PaymentTerm>] List all payment_terms.
    def all(options = { page: 1, page_size: 10 })
      response = JSON.parse(@client.get('PaymentTerms', options).body)
      payment_terms = response.key?('Items') ? response['Items'] : []
      payment_terms.map { |attributes| Unleashed::PaymentTerm.new(@client, attributes) }
    end

    # Get a first payment_term in all
    #
    # @return [Unleashed::PaymentTerm]
    def first
      all.first
    end

    # Get a last payment_term in all
    #
    # @return [Unleashed::PaymentTerm]
    def last
      all.last
    end

    # Create a new payment_term
    #
    # @param attributes [Hash] PaymentTerm's attributes.
    #
    # @return [Unleashed::PaymentTerm]
    def create(attributes)
      id = attributes[:Guid].present? ? attributes[:Guid] : ''
      response = JSON.parse(@client.post("PaymentTerms/#{id}", attributes).body)
      Unleashed::PaymentTerm.new(@client, response)
    end
  end
end
