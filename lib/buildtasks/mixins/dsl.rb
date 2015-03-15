module BuildTasks
  module Mixins
    module DSL
      def _validate(symbol, arg, validation)
        kinds = Array(validation.fetch(:kind_of))
        unless kinds.any? { |k| arg.is_a?(k) }
          fail ArgumentError, "#{symbol} must be of kind #{kinds}"
        end
      end

      def set_or_return(symbol, arg, validation = nil)
        iv_symbol = "@#{symbol}".to_sym
        if arg.nil? && instance_variable_defined?(iv_symbol)
          instance_variable_get(iv_symbol)
        else
          _validate(symbol, arg, validation) if validation
          instance_variable_set(iv_symbol, arg)
        end
      end

      def codename(name = nil)
        @codename ||= `lsb_release -cs`.strip.to_sym
        return @codename if name.nil?
        yield if name == @codename
      end
    end
  end
end
