alphabet = ('a'..'z').to_a
vowels = ["a", "e", "i", "o", "u", "y"]
hash = {}

alphabet.each_with_index do |letter, index|
  hash[letter] = index + 1 if vowels.include?(letter)
end

puts hash
