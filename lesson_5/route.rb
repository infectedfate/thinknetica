require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_accessor :stations
  attr_reader :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = "#{first_station.name} - #{last_station.name}"
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station) if [@stations.first, @stations.last].none?(station)
  end

  def list_stations
    @stations.each { |station| puts station }
  end
end
