module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  def self.validate(name, type, *args)
    @validations = []
    @validations << { name: name, type: type, args: args }
  end

  def validate!
    self.class.validations.each do |validation|
      attribute_value = instance_variable_get("#{validation[:name]}")
      send(validation[:val].to_sym, type, validation[:args])
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  protected

  def prescence(value)
    raise 'Значение не может быть пустым' unless value.nil? || value.empty?
  end

  def format(value, format)
    raise 'Значение неверного формата' if value != format
  end

  def type(value, class_of)
    raise 'Значение неверного типа' unless value.is_a?(class_of)
  end

end
