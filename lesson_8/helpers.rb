module Helpers
  def trains_list
    puts 'Список поездов:'
    @trains.each_with_index do |train, index|
      puts "#{index} - #{train.number}"
    end
  end

  def routes_list
    puts 'Список маршрутов:'
    @routes.each_with_index do |route, index|
      puts "#{index} - #{route.name}"
    end
  end

  def stations_list
    puts 'Список станций'
    @stations.each_with_index do |station, index|
      puts "#{index} - #{station.name}"
    end
  end

  def cars_list
    @trains[train].cars.each_with_index do |car, index|
      puts 'Список вагонов поезда:'
      puts "#{index} - #{car.type}"
    end
  end
end
