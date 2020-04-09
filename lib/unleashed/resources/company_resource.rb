module Unleashed
  # The Companies resource allows Companies to be listed. An individual Company details can be
  # viewed by appending its identifier (a GUID formatted as XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX)
  # to the URI. Here are some example URIs:
  # /Companies - returns a list of Company related information.
  #
  # @see https://apidocs.unleashedsoftware.com/Companies
  class CompanyResource < BaseResource
    def model
      Unleashed::Company
    end

    # Lists all information for your company
    # /Companies - returns a list of Company related information.
    #
    # @return [Array<Unleashed::Company>] Lists all information for your company.
    def all
      endpoint = 'Companies'
      response = JSON.parse(@client.get(endpoint).body)
      companies = response.key?('Items') ? response['Items'] : []
      companies.map { |attributes| Unleashed::Company.new(@client, attributes) }
    end

    # Get a first company in all
    #
    # @return [Unleashed::Company]
    def first
      all.first
    end

    # Get a last company in all
    #
    # @return [Unleashed::Company]
    def last
      all.last
    end
  end
end
