
def leap?(year)
  (year % 400).zero? || ((year % 4).zero? && (year % 100).nonzero?)
end

def yday(day, month, months)
  month == 1 ? day : day + months.take(month - 1).sum
end

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts 'Введите день, месяц, год:'

day = gets.to_i
month = gets.to_i
year = gets.to_i

months[1] = 29 if leap?(year)
index = yday(day, month, months)

puts "Порядковый номер: #{index}."
