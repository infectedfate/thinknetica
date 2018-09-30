require_relative 'vendor'
require_relative 'instance_counter'

class Train
  include Vendor
  include InstanceCounter

  attr_reader :speed, :route, :type, :index, :cars, :number

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
    @cars.delete(car) if stopped? && @cars.empty? == true
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

  protected

  # вынесено в протектед для защиты кода
  # от вмешательства "клиента" и прямого
  # изменения переменных

  def stopped?
    @speed.zero?
  end

  def cargo?
    @type == 'cargo'
  end

  def passenger?
    @type == 'passenger'
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
