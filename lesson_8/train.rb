require_relative 'vendor'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'

class Train
  NUMBER_FORMAT = /^[a-z0-9]{3}\-?[a-z0-9]{2}$/i

  include Vendor
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :speed, :route, :type, :index, :cars, :number

  strong_attr_accessor :number, Integer
  strong_attr_accessor :speed, Integer
  strong_attr_accessor :route, Route

  validate :type, :prescense
  validate :number, :format, NUMBER_FORMAT

  @@number = {}

  def self.find(number)
    @@number[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @speed = init_speed
    @cars = []
    @@number[number] = self
    validate!
    register_instance
  end

  def accelerate(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed -= value unless @speed.zero?
  end

  def attach_the_car(car)
    @cars << car if stopped?
  end

  def unhook_the_car(car)
    @cars.delete(car) if stopped? && !@cars.empty?
  end

  def take_a_route(route)
    @route = route
    @index = 0
    current_location.take_the_train(self)
  end

  def current_location
    route.stations[@index]
  end

  def next_location
    route.stations[@index + 1] unless last_station?
  end

  def previous_location
    route.stations[@index - 1] unless first_station?
  end

  def go_forward
    current_location.send_a_train(self)
    next_location.take_the_train(self)
    @index += 1
  end

  def go_backward
    current_location.send_a_train(self)
    previous_location.take_the_train(self)
    @index -= 1
  end

  def each_car(block)
    @cars.each { |car| block.call car }
  end

  def cargo?
    @type == 'cargo'
  end

  def passenger?
    @type == 'passenger'
  end

  protected

  def stopped?
    @speed.zero?
  end

  def init_speed
    0
  end

  def last_station?
    current_location == route.stations.last
  end

  def first_station?
    current_location == route.stations.first
  end
end
