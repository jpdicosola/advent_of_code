def load_data(file_name)
  col1 = []
  col2 = []
  IO.read(file_name).split("\n").each do |line|
    col1.push(line.split(" ")[0].to_i)
    col2.push(line.split(" ")[1].to_i)
  end
  return col1, col2
end

input_file = ARGV[0] || "./input.txt"

data = load_data(input_file)
col1 = data[0].sort
col2 = data[1].sort

# Part 1

dist = 0

while (col1.length != 0)
  dist += (col1.shift - col2.shift).abs
end

puts "Distance: #{dist}"

# Part 2

similarity = 0

col1 = data[0]
col2 = data[1]

for i in 0..(col1.length - 1)
  similarity += (col2.count { |x| x == col1[i] }) * col1[i]
end

puts "Similarity Score: #{similarity}"
