require_relative 'menu'
require_relative 'helpers'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'train/cargo_train'
require_relative 'train/passenger_train'
require_relative 'car'
require_relative 'car/cargo_car'
require_relative 'car/passenger_car'

class Main
  include Menu
  include Helpers

  attr_reader :trains, :routes, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
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
      stations_list
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
      routes_list
      puts 'Введите номер маршрута:'
      route = gets.to_i
      stations_list
      puts 'Введите номер станции:'
      station = gets.to_i

      @routes[route].add_station(@stations[station])
    else
      puts 'Маршрутов не существует'
    end
  end

  def delete_station_from_route
    if !@routes.empty?
      routes_list
      puts 'Введите номер маршрута:'
      route = gets.to_i

      puts 'Введите номер станции:'
      station = gets.to_i
      @routes[route].delete_station(@stations[station])
    else
      puts 'Маршрутов не существует'
    end
  end

  def assign_a_route
    if !@trains.empty? && !@routes.empty?
      trains_list
      routes_list
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
      trains_list
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
      trains_list
      puts 'Выберите поезд:'
      train = gets.to_i
      @trains[train].unhook_the_car
    else
      puts 'Поезда пока не созданы'
    end
  end

  def move_train_forward
    if !@trains.empty?
      trains_list
      puts 'Выберите поезд:'
      train = gets.to_i
      @trains[train].go_forward
    else
      puts 'Поезда пока не созданы'
    end
  end

  def move_train_backward
    if !@trains.empty?
      trains_list
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

  def full_information
    block = proc { |train| show_cars train }

    @stations.each do |station|
      puts "Станция: #{station.name.capitalize}"
      station.each_train block
    end
  end

  def load_car
    trains_list
    puts 'Введите номер поезда:'
    train = gets.to_i
    cars_list
    puts 'Введите номер вагона:'
    car = gets.to_i
    if @trains[train].cars[car].cargo?
      puts 'Объем: '
      @trains[train].cars[car].occupy(gets.to_i)
      puts 'Вагон успешно загружен'
    else
      @trains[train].cars[car].occupy
      puts 'Место успешно занято'
    end
  end

  private

  def create_a_train!(number, type)
    case type
    when 'passenger'
      @trains << PassengerTrain.new(number)
    when 'cargo'
      @trains << CargoTrain.new(number)
    end
  end
end
