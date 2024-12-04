input_file = ARGV[0] || "./input.txt"
data = IO.read(input_file)
matches = data.scan(/mul\((\d{1,3})\,(\d{1,3})\)/)

sum = 0

matches.each do |m|
  sum += m[0].to_i * m[1].to_i
end

puts "Sum: #{sum}"
