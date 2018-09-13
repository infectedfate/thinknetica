fib_arr = [0, 1]
fib_num = 1

while fib_num < 100
  fib_arr << fib_num
  fib_num = fib_arr[-1] + fib_arr[-2]
end

puts fib_arr
