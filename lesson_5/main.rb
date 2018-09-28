require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train/cargo_train'
require_relative 'train/passenger_train'
require_relative 'car'
require_relative 'car/cargo_car'
require_relative 'car/passenger_car'

class Main
  attr_reader :trains, :routes, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def menu
    loop do
      info
      puts 'Введите пункт меню:'
      choice = gets.to_i

      case choice
      when 1 then create_a_station
      when 2 then create_a_train
      when 3 then create_a_route
      when 4 then add_station_in_route
      when 5 then delete_station_from_route
      when 6 then assign_a_route
      when 7 then add_the_car
      when 8 then delete_the_car
      when 9 then move_train_forward
      when 10 then move_train_backward
      when 11 then show
      when 0 then break
      end
    end
  end

  def create_a_station
    puts 'Введите название станции: '
    @stations << Station.new(gets.chomp)
    puts 'Станция создана!'
  end

  def create_a_train
    puts 'Введите номер поезда'
    number = gets.to_i

    puts 'Укажите тип поезда:'
    puts '0 - пассажирский'
    puts '1 - грузовой'

    type = gets.to_i.zero? ? 'passenger' : 'cargo'
    create_a_train!(number, type)
  end

  def create_a_route
    if @stations.size >= 2
      @stations.each_with_index do |station, index|
        puts "#{index} - #{station.name}"
      end
      print 'Введите начальную станцию:'
      first_station = gets.to_i
      print 'Введите конечную станцию:'
      last_station = gets.to_i
      @routes << Route.new(@stations[first_station], @stations[last_station])
      puts 'Маршрут создан!'
    else
      'Создайте хотя бы две станции'
    end
  end

  def add_station_in_route
    if !@routes.empty?
      @routes.each_with_index do |route, index|
        puts "#{index} - #{route.name}"
      end
      puts 'Введите номер маршрута:'
      route = gets.to_i
      @stations.each_with_index do |station, index|
        puts "#{index} - #{station.name}"
      end
      puts 'Введите номер станции:'
      station = gets.to_i

      @routes[route].add_station(@stations[station])

    else
      puts 'Маршрутов не существует'
    end
  end

  def delete_station_from_route
    if !@routes.empty?
      @routes.each_with_index do |route, index|
        puts "#{index} - #{route.name}"
      end
      puts 'Введите номер маршрута:'
      route = gets.to_i
      @stations.each_with_index do |station, index|
        puts "#{index} - #{station.name}"
      end
      puts 'Введите номер станции:'
      station = gets.to_i

      @routes[route].delete_station(@stations[station])

    else
      puts 'Маршрутов не существует'
    end
  end

  def assign_a_route
    if !@trains.empty? || !@routes.empty?
      @trains.each_with_index do |train, index|
        puts 'Список поездов:'
        puts "#{index} - #{train.number}"
      end
      @routes.each_with_index do |route, index|
        puts 'Список маршрутов:'
        puts "#{index} - #{route.name}"
      end
      puts 'Введите номер маршрута:'
      route = gets.to_i
      puts 'Введите номер поезда:'
      train = gets.to_i

      @trains[train].take_a_route(@routes[route])
    else
      puts 'Сначала создайте поезд и маршрут'
    end
  end

  def add_the_car
    if !@trains.empty? 
      puts 'Список поездов:'
      @trains.each_with_index do |train, index|
        puts "#{index} - #{train.number}"
      end
      puts 'Выберите поезд:'
      train = gets.to_i
      if @trains[train.type] == train.passenger? && train.stopped?
        passenger_car = PassengerCar.new
        @trains[train.attach_the_car(passenger_car)]
      elsif @trains[train.type] == train.cargo? && train.stopped?
        cargo_car = CargoCar.new
        @trains[train.attach_the_car(cargo_car)]
      else
        puts 'Неизвестный тип вагона'
      end
    else
      puts 'Поезда пока не созданы'
    end
  end

  def delete_the_car
    if !@trains.empty?
      puts 'Список поездов:'
      @trains.each_with_index do |train, index|
        puts "#{index} - #{train.number}"
      end
      puts 'Выберите поезд:'
      train = gets.to_i
      @trains[train].unhook_the_car if train.stopped?
    else
      puts 'Поезда пока не созданы'
    end
  end

  def move_train_forward
    if !@trains.empty?
      puts 'Список поездов:'
      @trains.each_with_index do |train, index|
        puts "#{index} - #{train.number}"
      end
      puts 'Выберите поезд:'
      train = gets.to_i
      @trains[train].go_forward
    else
      puts 'Поезда пока не созданы'
    end
  end

  def move_train_backward
    if !@trains.empty?
      puts 'Список поездов:'
      @trains.each_with_index do |train, index|
        puts "#{index} - #{train.number}"
      end
      puts 'Выберите поезд:'
      train = gets.to_i
      @trains[train].go_backward
    else
      puts 'Поезда пока не созданы'
    end
  end

  def show
    @stations.each do |station|
      puts station.name
      station.trains.each do |train|
        puts train.number.to_s
      end
    end
  end

  private

  def info
    puts 'Меню'
    puts '----------'
    puts '1. Создать станцию'
    puts '2. Создать поезд'
    puts '3. Создать маршрут'
    puts '4. Добавить станцию в маршрут'
    puts '5. Удалить станцию из маршрута'
    puts '6. Назначить маршрут поезду'
    puts '7. Добавить вагон к поезду'
    puts '8. Отцепить вагон от поезда'
    puts '9. Переместить поезд вперед по маршруту'
    puts '10. Переместить поезд назад по маршруту'
    puts '11. Показать станции и поезда'
    puts '0. Выход'
  end

  def create_a_train!(number, type)
    case type
    when 'passenger'
      @trains << PassengerTrain.new(number)
    when 'cargo'
      @trains << CargoTrain.new(number)
    end
  end
end

Main.new.menu
