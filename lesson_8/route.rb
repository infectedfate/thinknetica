require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'


class Route
  include InstanceCounter
  include Validation
  extend Accessors

  attr_accessor :stations
  attr_reader :name

  validate :first_station, :type, Station
  validate :last_station, :type, Station

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = "#{first_station.name} - #{last_station.name}"
    @first_station = first_station
    @last_station = last_station
    validate!
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
