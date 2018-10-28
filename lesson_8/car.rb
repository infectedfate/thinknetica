require_relative 'vendor'
require_relative 'validation'
require_relative 'accessors'

class Car
  include Vendor
  include Validation

  attr_reader :car_type, :occupied_capacity, :capacity

  validate :car_type, :presence
  validate :capacity, :presence

  def initialize(type, capacity)
    @car_type = type
    @capacity = capacity
    validate!
    @occupied_capacity = 0
  end

  def free_capacity
    @occupied_capacity - @capacity
  end

  def occupy(value = 1)
    @occupied_capacity += value
    raise 'Кончилось место' if @occupied_capacity > @capacity
  end

  def cargo?
    @car_type == 'cargo'
  end

  def passenger?
    @car_type == 'passenger'
  end
end
