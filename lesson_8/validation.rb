module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(name, type, options = nil)
      @validations ||= []
      @validations << { name: name, type: type, args: options }
    end
  end

  module InstanceMethods

    def validate!
      self.class.validations.each do |validation|
        argument_value = instance_variable_get("@#{validation[:name]}")
        send(validation[:type].to_sym, argument_value, validation[:args])
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def presence(value, _args)
      raise 'Значение не может быть пустым' unless value.nil? || value.empty?
    end

    def format(value, format)
      raise 'Значение неверного формата' if value !~ format
    end

    def type(value, class_of)
      raise 'Значение неверного типа' unless value.is_a?(class_of)
    end
  end
end
