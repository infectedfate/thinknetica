require_relative 'instance_counter'
require_relative 'validation'
require_relative 'accessors'


class Route
  include InstanceCounter
  include Validation
  include Accessors

  attr_accessor :stations
  attr_reader :name

  strong_attr_accessor :first_station, Station
  strong_attr_accessor :last_station, Station

  validate :first_station, :presence
  validate :last_station, :presence

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

  protected

  def validate!
    raise 'Недопустимая станция' unless @stations.first.is_a?(Station) && @stations.last.is_a?(Station)
    raise 'Начальная и конечные станции совпадают!' if @stations.first.eql?(@stations.last)
  end
end
