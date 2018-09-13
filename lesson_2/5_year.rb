
def leap?(year)
  (year % 400).zero? || ((year % 4).zero? && (year % 100).nonzero?)
end

# Этот метод пришлось подсмотреть, до сих пор не совсем понимаю его значение.

def yday(day, month, months)
  (month - 1).times { |i| day += months[i] }
  day
end

months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

day = 1
month = 1

puts 'Введите день, месяц, год:'

day = gets.to_i
month = gets.to_i
year = gets.to_i

months[1] = 29 if leap?(year)
index = yday(day, month, months)

puts "Порядковый номер: #{index}."
