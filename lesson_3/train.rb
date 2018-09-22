class Train
  attr_reader :railway_carriage, :speed, :route, :type, :index

  def initialize(number, type, railway_carriage)
    @number = number
    @type = type
    @railway_carriage = railway_carriage
    @speed = 0
  end

  def accelerate(value)
    @speed += value
  end

  def decrease_speed(value)
    @speed -= value unless @speed.zero?
  end

  def attache
    @railway_carriage += 1 if @speed.zero?
  end

  def unhook
    @railway_carriage -= 1 if @speed.zero? && @railway_carriage != 0
  end

  def take_a_route(route)
    @route = route
    @index = 0
    current_location.take(self)
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

  def last_station?
    current_location == route.stations.last
  end

  def first_station?
    current_location == route.stations.first
  end
end
