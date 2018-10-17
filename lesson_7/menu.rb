module Menu

  MENU = {
    1 => 'create_a_station',
    2 => 'create_a_train',
    3 => 'create_a_route',
    4 => 'add_station_in_route',
    5 => 'delete_station_from_route',
    6 => 'assign_a_route',
    7 => 'add_the_car',
    8 => 'delete_the_car',
    9 => 'move_train_forward',
    10 => 'move_train_backward',
    11 => 'full_information',
    12 => 'load_car'
  }.freeze

  def run
    loop do
      info
      puts 'Введите пункт меню:'
      choice = gets.to_i
      send(command(choice))
    end
  end

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

  def command(cmd)
    MENU[cmd].to_s
  end
end
