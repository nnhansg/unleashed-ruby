require_relative 'configurable'
require_relative 'error'
require_relative 'models/base_model'
require_relative 'models/customer'
require_relative 'resources/base_resource'
require_relative 'resources/customer_resource'
require 'json'
require 'faraday'

module Unleashed
  # Client for the Unleashed API
  #
  # @see https://apidocs.unleashedsoftware.com
  class Client
    include Unleashed::Configurable

    def initialize(options = {})
      # Use options passed in, but fall back to module defaults
      Unleashed::Configurable.keys.each do |key|
        instance_variable_set(
          :"@#{key}", options[key] || Unleashed.instance_variable_get(:"@#{key}")
        )
      end
    end

    # Create a new Faraday connection
    #
    # @return [Faraday::Connection]
    def connection
      Faraday.new(url: @api_endpoint) do |faraday|
        faraday.adapter :net_http
      end
    end

    # Create a signature for request
    def signature(params = '')
      hash = OpenSSL::HMAC.digest('sha256', @api_key, params)
      Base64.strict_encode64(hash)
    end

    def init_default_headers(request)
      request.headers['client-type'] = @client_type_header
      request.headers['Accept'] = 'application/json'
      request.headers['Content-Type'] = 'application/json'
      request.headers['api-auth-id'] = @api_id
      request.headers['api-auth-signature'] = signature(request.params.to_query)
    end

    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {api_endpoint}
    # @param parameters [Hash] Query params for request
    # @return [Faraday::Response]
    def get(url, parameters = {}, headers = {}, skip_status_check = false)
      response = connection.get do |request|
        request.url "#{api_endpoint}#{url}"
        request.params = parameters

        # Set headers
        init_default_headers(request)

        # Assign more custom headers
        headers.each do |key, value|
          request.headers[key] = value
        end
      end

      on_complete(response) unless skip_status_check
      response
    end

    # # Make a HTTP POST request
    # #
    # # @param url [String] The path, relative to {#api_endpoint}
    # # @param parameters [Hash] Query params for request
    # # @return [Faraday::Response]
    # def post(url, parameters = {})
    #   response = connection.post do |req|
    #     req.url "#{api_endpoint}#{url}"
    #     req.headers['Content-Type'] = 'application/json'
    #     req.body = parameters.to_json
    #   end
    #   on_complete(response)
    #   response
    # end

    # # Make a HTTP PATCH request
    # #
    # # @param url [String] The path, relative to {#api_endpoint}
    # # @param parameters [Hash] Query params for request
    # # @return [Faraday::Response]
    # def patch(url, parameters = {})
    #   response = connection.patch do |req|
    #     req.url "#{api_endpoint}#{url}"
    #     req.headers['Content-Type'] = 'application/json'
    #     req.body = parameters.to_json
    #   end
    #   on_complete(response)
    #   response
    # end

    # # Make a HTTP DELETE request
    # #
    # # @param url [String] The path, relative to {#api_endpoint}
    # # @param parameters [Hash] Query params for request
    # # @return [Faraday::Response]
    # def delete(url, parameters = {})
    #   response = connection.delete do |req|
    #     req.url "#{api_endpoint}#{url}"
    #     req.headers['Content-Type'] = 'application/json'
    #     req.body = parameters.to_json
    #   end
    #   on_complete(response)
    #   response
    # end

    # Show details of your Platform.
    #
    # @see https://reference.Unleashed.com/#show-marketplace
    #
    # @return [Hash]
    def marketplace
      JSON.parse(get('marketplace').body)['marketplaces']
    end

    # Available resources for {Client}
    #
    # @return [Hash]
    def self.resources
      {
        customers: CustomerResource
      }
    end

    # Catch calls for resources
    #
    def method_missing(name, *args, &block)
      if self.class.resources.keys.include?(name)
        resources[name] ||= self.class.resources[name].new(self)
        resources[name]
      else
        super
      end
    end

    # Resources being currently used
    #
    # @return [Hash]
    def resources
      @resources ||= {}
    end

    private

    def on_complete(response)
      fail Unleashed::Error.from_response(response, @errors_format) unless response.success?
    end
  end
end
