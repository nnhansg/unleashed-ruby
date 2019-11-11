module Unleashed
  # Default configuration options for {Client}
  module Default
    # Default API domain
    API_DOMAIN = 'api.unleashedsoftware.com'.freeze
    # Default client_type_header
    CLIENT_TYPE_HEADER = 'API-Sandbox'.freeze

    class << self
      # Configuration options.
      #
      # @return [Hash]
      def options
        Hash[Unleashed::Configurable.keys.map { |key| [key, send(key)] }]
      end

      # Default API domain from ENV or {API_DOMAIN}.
      #
      # @return [String]
      def api_domain
        ENV['UNLEASHED_API_DOMAIN'] || API_DOMAIN
      end

      # Default api_id from ENV.
      #
      # @return [String]
      def api_id
        ENV['UNLEASHED_API_ID']
      end

      # Default api_key from ENV.
      #
      # @return [String]
      def api_key
        ENV['UNLEASHED_API_KEY']
      end

      # Default client_type_header from ENV.
      #
      # @return [String]
      def client_type_header
        ENV['UNLEASHED_CLIENT_TYPE_HEADER'] || CLIENT_TYPE_HEADER
      end

      # Default errors_format from ENV.
      #
      # @return [String]
      def errors_format
        ENV['UNLEASHED_ERRORS_FORMAT'] || 'processed'
      end
    end
  end
end
