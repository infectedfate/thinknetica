load 'route.rb'
load 'station.rb'

class Train
  attr_accessor :speed, :route, :location
  attr_reader :railway_carriage

  def initialize(number, type, railway_carriage)
    @number = number
    @type = type
    @railway_carriage = railway_carriage
    @speed = 0
    @route = []
  end

  def accelerate(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def attache
    @railway_carriage += 1 if @speed > 0
  end

  def take_a_route(route)
    @route << route.itself
    @location
  end

  def current_location
    route.
  end

end
