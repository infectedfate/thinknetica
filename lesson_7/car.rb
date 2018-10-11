require_relative 'vendor'
require_relative 'valid'

class Car
  include Vendor
  include Validate

  attr_reader :type, :occupied_capacity, :capacity

  def initialize(type, capacity)
    @type = type
    @capacity = capacity
    @occupied_capacity = 0
    validate!
  end

  def free_capacity
    @occupied_capacity - @capacity
  end

  def occupy(value = 1)
    @occupied_capacity += value
    raise 'Кончилось место' if @occupied_capacity >= @capacity
  end

  def cargo?
    @type == 'cargo'
  end

  def passenger?
    @type == 'passenger'
  end

  protected

  def validate!
    raise 'Указан тип невалидного формата' unless type.eql?('cargo') || type.eql?('passenger')
  end
end
