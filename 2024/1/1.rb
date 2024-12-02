col1 = []
col2 = []

input_file = ARGV[0] || "./input.txt"

IO.read(input_file).split("\n").each do |line|
  col1.push(line.split(" ")[0].to_i)
  col2.push(line.split(" ")[1].to_i)
end

col1.sort!
col2.sort!

dist = 0

while (col1.length != 0)
  dist += (col1.shift - col2.shift).abs
end

puts "Distance: #{dist}"
