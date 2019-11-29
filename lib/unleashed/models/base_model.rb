module Unleashed
  # Base model for all the other models to inherit from
  class BaseModel
    attr_reader :attributes

    def initialize(client, attributes = {})
      @client = client
      @attributes = stringify_keys(attributes)
    end

    def method_missing(name, *args, &block)
      if @attributes.key?(name.to_s)
        @attributes[name.to_s]
      else
        super
      end
    end

    private

    def stringify_keys(hash)
      Hash[hash.map { |key, value| [key.to_s, value] }]
    end
  end
end
