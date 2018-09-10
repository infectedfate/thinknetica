puts "Введите 3 коэффициента:"
a = gets.to_i 
b = gets.to_i
c = gets.to_i

dis = b**2 - (4*a*c)

if dis > 0
     puts "Дискриминант равен #{dis}, корень X1 равен #{(-b) + Math.sqrt(dis) / (a*2)}, корень X2 равен #{(-b) - Math.sqrt(dis) / (a*2)}"
elsif dis == 0
    puts "Дискриминант равен #{dis}, корни равны #{(-b) + Math.sqrt(dis) / (a*2)}"
else 
    puts "Дискриминант равен #{dis}, корней нет"
end