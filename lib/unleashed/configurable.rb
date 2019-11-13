module Unleashed
  # Configuration options for {Client}, defaulting to values in {Default}.
  module Configurable
    attr_accessor :api_domain, :api_id, :api_key, :client_type_header, :errors_format

    # Class Configurable
    class << self
      # List of configurable keys for {Unleashed::Client}.
      #
      # @return [Array] of option keys
      def keys
        @keys ||= [
          :api_domain,
          :api_id,
          :api_key,
          :client_type_header,
          :errors_format
        ]
      end
    end

    # Reset configuration options to default values.
    def reset!
      Unleashed::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Unleashed::Default.options[key])
      end

      self
    end

    alias setup reset!

    # API endpoint to be used by {Unleashed::Client}.
    # Built from {#api_domain}
    #
    # @return [String]
    def api_endpoint
      "https://#{@api_domain}/"
    end
  end
end
