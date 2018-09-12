puts 'Ваше имя?'
name = gets.chomp.capitalize

puts 'Ваш рост?'
growth = gets.to_i

ideal_weight = growth - 110

if ideal_weight <= 0
  puts "#{name}, Ваш вес уже оптимальный"
else
  puts "#{name}, Ваш идеальный вес #{ideal_weight}"
end
