module Accsessors
  def attr_accessors_with_history(*names)
    names.each { |name| define(name) }
  end

  def define(name)
    symbol = "@#{name}".to_sym
    history = "@#{name}_history".to_sym

    define_method(name) { instance_variable_get(name) }
    define_method("#{name}=".to_sym) do |value|
      if instance_variable_get(symbol).nil?
        instance_variable_set(hystory, [])
      else
        instance_variable_get(history) << instance_variable_get(symbol)
      end
      instance_variable_set(symbol, value)
    end
    define_method(history) { instance_variable_get(hystory) }
  end

  def strong_attr_accessor(name, class_of)
    symbol = "@#{name}".to_sym
    class_of = name.class

    define_method(name) { instance_variable_get(symbol) }
    define_method("#{symbol}=".to_sym) { instance_variable_set(symbol, class_of) }
    raise 'Неверный тип' if name.is_a?(class_of)
  end
end
