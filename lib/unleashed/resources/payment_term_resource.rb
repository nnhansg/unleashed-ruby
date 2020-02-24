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
    # @return [Array<Unleashed::PaymentTerm>] List all payment terms.
    # {
    #   "Items": [
    #     {
    #         "Guid": "6223b37e-2ee4-41ed-a215-5f14c53e8f7f",
    #         "Type": "DaysOfTheMonthFollowing",
    #         "Days": 20,
    #         "Obsolete": false,
    #         "PaymentTermDescription": "20th Month following"
    #     },
    #     {
    #         "Guid": "6488bee4-ea4c-4a25-ba1b-a86965120e34",
    #         "Type": "DaysOfTheMonthFollowing",
    #         "Days": 25,
    #         "Obsolete": false,
    #         "PaymentTermDescription": "25th Month following"
    #     }
    #   ]
    # }
    def all
      endpoint = 'PaymentTerms'
      response = JSON.parse(@client.get(endpoint).body)
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
  end
end
