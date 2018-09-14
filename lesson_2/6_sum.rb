goods = {}

loop do
  puts 'Введите название продукта: (что бы закончить, введите слово "стоп")'
  name_of_product = gets.chomp
  break if name_of_product.casecmp('стоп').zero?

  puts 'Введите цену за единицу продукта:'
  price_of_product = gets.to_f
  puts 'Введите количество приобретаемого продукта:'
  quantity_of_product = gets.to_f

  goods[name_of_product] = {
    price_of_product: price_of_product,
    quantity_of_product: quantity_of_product
  }
end

total = 0

goods.each do |name_of_product, value|
  sum = value[:price_of_product] * value[:quantity_of_product]
  total += value[:price_of_product] * value[:quantity_of_product]

  puts "Товар #{name_of_product}:"
  puts "Цена за единицу товара: #{value[:price_of_product]},"
  puts "Количество продуктов: #{value[:quantity_of_product]}"
  puts "Сумма: #{sum}"
end

puts "Общая цена за товары составила: #{total}"
