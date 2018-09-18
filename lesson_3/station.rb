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
    @trains.select { |train| train.type == type }
  end
end

class Route
  attr_accessor :stations

  def initialize(starting_station, ending_station)
    @stations = [starting_station, ending_station]
  end

  def add_stopping(stopping)
    @stations.insert(-2, stopping)
  end

  def delete_stopping(stopping)
    @stations.delete(stopping) if [@stations.first, @stations.last].none?(stopping)
  end

  def stations
    @stations.each { |station| puts station }
  end
end

class Train
  attr_reader :railway_carriage, :index, :speed, :stations, :location

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
    @speed -= value
  end

  def attache
    @railway_carriage += 1 if @speed.zero?
  end

  def unhook
    @railway_carriage -= 1 if @speed.zero? && @railway_carriage != 0
  end

  def take_a_route=(stations)
    @stations = stations
    @index = 0
    current_location.take(self)
  end

  def current_location
    stations.stations[@index]
  end

  def next_location
    stations.stations[@index + 1] unless last_station?
  end

  def previous_location
    stations.stations[@index - 1] unless first_station?
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
    current_location == station.stations.last
  end

  def first_station?
    current_location == station.stations.first
  end
end
