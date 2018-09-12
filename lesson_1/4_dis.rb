puts "Введите 3 коэффициента квадратного уравнения:"

a = gets.to_f
b = gets.to_f
c = gets.to_f

dis = b**2 - 4 * a * c

puts "Дискриминант равен #{dis}"

if dis > 0
  c = Math.sqrt(dis)
  x1 = (-b + c) / (2 * a)
  x2 = (-b - c) / (2 * a)
  puts "Первый корень равен #{x1}"
  puts "Второй корень равен #{x2}"
elsif dis.zero?
  x = -b / (2 * a)
  puts "Корень уравнения равен #{x}"
else
  puts 'Корней нет'
end
