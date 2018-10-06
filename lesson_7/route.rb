require_relative 'instance_counter'
require_relative 'valid'

class Route
  include InstanceCounter
  include validate

  attr_accessor :stations
  attr_reader :name

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    @name = "#{first_station.name} - #{last_station.name}"
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

  protected

  def validate!
    raise 'Недопустимая станция' unless @stations.first.is_a?(Station) && @stations.last.is_a?(Station)
    raise 'Начальная и конечные станции совпадают!' if @stations.first.eql?(@stations.last)
  end
end
