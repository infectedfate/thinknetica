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

  MENU = {
    1 => create_a_station,
    2 => create_a_train,
    3 => create_a_route,
    4 => add_station_in_route,
    5 => delete_station_from_route,
    6 => assign_a_route,
    7 => add_the_car,
    8 => delete_the_car,
    9 => move_train_forward,
    10 => move_train_backward,
    11 => show_stations,
    12 => load_car
  }
  def initialize
    @trains = []
    @routes = []
    @stations = []
  end

  def menu
    loop do
      info
      puts 'Введите пункт меню:'
      MENU[point] = gets.to_i
    end
  end

  def create_a_station
    puts 'Введите название станции: '
    @stations << Station.new(gets.chomp)
    puts 'Станция создана!'
  end

  def create_a_train
    puts 'Введите номер поезда'
    number = gets.chomp!

    puts 'Укажите тип поезда:'
    puts '0 - пассажирский'
    puts '1 - грузовой'

    type = gets.to_i.zero? ? 'passenger' : 'cargo'
    create_a_train!(number, type)
    puts "#{type.eql?('cargo') ? 'грузовой' : 'пассажирский'} поезд с номером #{number} успешно создан"
  rescue StandardError => e
    puts "Ошибка - #{e}"
    retry
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
      puts 'Создайте хотя бы две станции'
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
    if !@trains.empty? && !@routes.empty?
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
      if @trains[train].passenger?
        puts 'Укажите количество мест:'
        capacity = gets.to_i
        passenger_car = PassengerCar.new(capacity)
        @trains[train].attach_the_car(passenger_car)
        puts 'Пассажирский вагон успешно создан!'
      elsif @trains[train].cargo?
        puts 'Укажите объем вагона'
        capacity = gets.to_i
        cargo_car = CargoCar.new(capacity)
        @trains[train].attach_the_car(cargo_car)
        puts 'Грузовой вагон успешно создан!'
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
      @trains[train].unhook_the_car if @trains[train].stopped?
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

  def show_trains_on_station
    @stations.each do |station|
      puts station.name
      station.trains.each do |train|
        puts train.number.to_s
      end
    end
  end

  def show_cars(train)
    puts "#{train.type} поезд c номером #{train.number}, кол-во вагонов #{train.cars.size}"
    train.each_car do |car, i|
      if car.cargo?
        puts "#{car.type} вагон №#{i} Свободный объем: #{car.free_capacity}"
        puts "Занято: #{car.occupied_capacity}"
      else
        puts "#{car.type} вагон №#{i}"
        puts "Свободного места: #{car.free_capacity}Занято: #{car.occupied_capacity}"
      end
    end
  end

  def show_stations
    block = proc { |train| show_cars train }

    @stations.each do |station|
      puts "Станция: #{station.name.capitalize}"
      station.each_train block
    end
  end

  def load_car
    puts 'Список поездов:'
    trains.each_with_index do |train, index|
      puts "#{index} - #{train.number}"
    end
    puts 'Введите номер поезда:'
    train = gets.to_i
    @trains[train].cars.each_with_index do |car, index|
      puts 'Список вагонов поезда:'
      puts "#{index} - #{car.type}"
    end
    puts 'Введите номер вагона:'
    car = gets.to_i
    if @trains[train].cars[car].cargo?
      puts 'объем: '
      @trains[train].cars[car].occupy(gets.to_i)
      puts 'вагон успешно загружен'
    else
      @trains[train].cars[car].occupy
      puts 'место успешно занято'
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
    puts '11. Вывести список поездов на станции и вагонов у поезда'
    puts '12. Загрузить или заполнить вагон'
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
