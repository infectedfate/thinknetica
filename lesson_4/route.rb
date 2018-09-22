class Route
  attr_accessor :stations

  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
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
