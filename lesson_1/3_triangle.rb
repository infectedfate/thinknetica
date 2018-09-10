puts "Введите стороны треугольника:"
side = []
side << gets.to_f
side << gets.to_f
side << gets.to_f

side.sort!

if side[0]**2 + side[1]**2 == side[2]**2
    puts "Треугольник является прямоугольным" 
    puts " и равнобедренным" if side[0] == side[1] || side[1] == side[2]
else
    puts "Треугольник не является прямоугольным"
end

