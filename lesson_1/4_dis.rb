puts "Введите 3 коэффициента квадратного уравнения:"

a = gets.to_f
b = gets.to_f
c = gets.to_f

dis = b**2 - (4 * a * c)

if dis > 0
  x1 = (-b) + Math.sqrt(dis) / (a * 2)
  x2 = (-b) - Math.sqrt(dis) / (a * 2)
  puts "Дискриминант равен #{dis}, корень X1 равен #{x1}, корень X2 равен #{x2}"
elsif dis.zero?
  x = -b / (2 * a)
  puts "Дискриминант равен 0, корень равен #{x}"
else
  puts "Дискриминант равен #{dis}, корней нет"
end
