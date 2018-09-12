puts 'Введите стороны треугольника:'
side = []
side << gets.to_f
side << gets.to_f
side << gets.to_f

side.sort!

if side[0]**2 + side[1]**2 == side[2]**2 && side[0] == side[1]
  puts 'Треугольник является прямоугольным и равнобедренным'
elsif side[0]**2 + side[1]**2 == side[2]**2
  puts 'Треугольник прямоугольный'
elsif side[0] == side[1] && side [0] == side[2]
  puts 'Треугольник равносторонний, но не прямоугольный'
else
  puts 'Треугольник не является прямоугольным'
end
