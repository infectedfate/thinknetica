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

  def list_stations
    @stations.each { |station| puts station }
  end
end
