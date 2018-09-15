class Route
  attr_accessor :route

  def initialize(starting_station, ending_station)
    @route = [starting_station, ending_station]
  end

  def add_stopping(stopping)
    @route.insert(-2, stopping)
  end

  def delete_stopping(stopping)
    @route.delete(stopping)
  end
end
