module Unleashed
  # Custom error class for rescuing from all Unleashed errors
  class Error < StandardError
    # Returns the appropriate Unleashed::Error subclass based on status
    #
    # @param [Faraday::Response] response Faraday HTTP response
    # @return [Unleashed::Error]
    def self.from_response(response, errors_format = nil)
      klass = case response.status
              when 400      then Unleashed::BadRequest
              when 401      then Unleashed::Unauthorized
              when 403      then Unleashed::Forbidden
              when 404      then Unleashed::NotFound
              when 405      then Unleashed::MethodNotAllowed
              when 406      then Unleashed::NotAcceptable
              when 409      then Unleashed::Conflict
              when 422      then Unleashed::UnprocessableEntity
              when 400..499 then Unleashed::ClientError
              when 500      then Unleashed::InternalServerError
              when 501      then Unleashed::NotImplemented
              when 502      then Unleashed::BadGateway
              when 503      then Unleashed::ServiceUnavailable
              when 500..599 then Unleashed::ServerError
              end
      klass ? klass.new(response, errors_format) : new(response, errors_format)
    end

    def initialize(response = nil, errors_format = nil)
      @response = response
      @errors_format = errors_format
      super(build_error_message)
    end

    private

    def build_error_message
      return nil if @response.nil? || @response.body.nil?

      case @errors_format
      when 'raw'
        @response.body
      else
        json_response = JSON.parse(@response.body)
        message = "[StatusCode=#{@response.status}] - "
        message << json_response['description'] if json_response.key?('description')
        message << json_response['Description'] if json_response.key?('Description')

        if json_response.key?('Items') && json_response['Items'].is_a?(Array)
          message << json_response['Items'].map { |attribute, content| "#{attribute}: #{content}" }.join(', ')
        end

        message
      end
    end
  end

  # Raised on errors in the 400-499 range
  class ClientError < Error; end

  # Raised when Unleashed returns a 400 HTTP status code
  class BadRequest < ClientError; end

  # Raised when Unleashed returns a 401 HTTP status code
  class Unauthorized < ClientError; end

  # Raised when Unleashed returns a 403 HTTP status code
  class Forbidden < ClientError; end

  # Raised when Unleashed returns a 404 HTTP status code
  class NotFound < ClientError; end

  # Raised when Unleashed returns a 405 HTTP status code
  class MethodNotAllowed < ClientError; end

  # Raised when Unleashed returns a 406 HTTP status code
  class NotAcceptable < ClientError; end

  # Raised when Unleashed returns a 409 HTTP status code
  class Conflict < ClientError; end

  # Raised when Unleashed returns a 422 HTTP status code
  class UnprocessableEntity < ClientError; end

  # Raised on errors in the 500-599 range
  class ServerError < Error; end

  # Raised when Unleashed returns a 500 HTTP status code
  class InternalServerError < ServerError; end

  # Raised when Unleashed returns a 501 HTTP status code
  class NotImplemented < ServerError; end

  # Raised when Unleashed returns a 502 HTTP status code
  class BadGateway < ServerError; end

  # Raised when Unleashed returns a 503 HTTP status code
  class ServiceUnavailable < ServerError; end
end
