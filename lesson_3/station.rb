class Station
  attr_reader :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_the_train(train)
    @trains << train
  end

  def send_a_train(train)
    @trains.delete(train)
  end

  def sort_by_type(type)
    @trains.map { |train| train.type == type }
  end
end

class Route
  attr_reader :stations

  def initialize(starting_station, ending_station)
    @stations = [starting_station, ending_station]
  end

  def add_stopping(stopping)
    @stations.insert(-2, stopping)
  end

  def delete_stopping(stopping)
    @stations.delete(stopping)
  end

  def route
    @stations.each { |station| puts station }
  end
end

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
    @railway_carriage += 1 if @speed.zero?
  end

  def unhook
    @railway_carriage -= 1 if @speed.zero? && @railway_carriage != 0
  end

  def take_a_route(route)
    @route << route
    @index = 0
    current_location.take(self)
  end

  def current_location
    stations[@index]
  end

  def next_location
    route.stations[@index + 1] unless route.stations[-1]
  end

  def previous_location
    route.stations[@index - 1] unless route.stations[0]
  end

  def go_forward
    @index += 1
  end

  def go_backward
    @index -= 1
  end
end
