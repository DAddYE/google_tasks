module GoogleTasks

  class Response < Hash
    def initialize(hash)
      self.update(hash || {})
      self.keys.each do |k|
        new_key = (k.to_sym rescue k) || k
        self[new_key] = format_value(delete(k))
        self.class.send(:define_method, new_key) { self[new_key] }
      end
      super
    end

    private
      def format_value(value)
        case value
          when Hash  then Response.new(value)
          when Array then value.map { |v| format_value(v) }
          else value
        end
      end
  end # Response
end # GoogleTasks