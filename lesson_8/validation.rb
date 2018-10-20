module Validation
  def self.validate(name, val, *args)
    @validations = []
    @validations << { name: name, val: val, args: args }
  end

  def validate!
    self.class.validations.each do |validation|
      validation = instance_variable_get("#{validation[:name]}")
      validation[:val].to_sym, val, validation[:args]
    end
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def prescence(value)
    raise 'Значение не может быть пустым' unless value.nil? || value.empty?
  end

  def format(value, format)
    raise 'Значение неверного формата' if value != format
  end

  def type(value, class_of)
    class_of = value.class
    raise 'Значение неверного типа' unless value.is_a?(class_of)
  end

end
