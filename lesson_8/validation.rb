module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= []
    end

    def validate(name, type, options = nil)
      validations << { name: name, type: type, args: options }
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each do |validation|
        argument_value = instance_variable_get("@#{validation[:name]}")
        method_name = "validate_#{validation[:type]}"
        send(method_name, argument_value, validation[:args])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def validate_presence(value, _args)
      raise 'Значение не может быть пустым' if value.nil? || value.to_s.empty?
    end

    def validate_format(value, format)
      raise 'Значение неверного формата' if value !~ format
    end

    def validate_type(value, class_of)
      raise 'Значение неверного типа' unless value.is_a?(class_of)
    end
  end
end
