require_relative 'vendor'
require_relative 'validation'
require_relative 'accessors'

class Car
  include Vendor
  include Validation

  attr_reader :type, :occupied_capacity, :capacity

  validate :type, :presence

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
    raise 'Кончилось место' if @occupied_capacity > @capacity
  end

  def cargo?
    @type == 'cargo'
  end

  def passenger?
    @type == 'passenger'
  end
end
