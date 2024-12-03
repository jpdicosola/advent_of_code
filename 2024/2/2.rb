input_file = ARGV[0] || "./input.txt"
data = IO.read(input_file).split("\n").map do |x|
  x.split(" ").map(&:to_i)
end

safe_count = 0

def row_safe?(row)
  direction = nil
  row.each_cons(2) do |a, b|
    diff = b - a
    curr_direction = diff > 0 ? :increasing : :decreasing

    return false unless diff.abs.between?(1, 3)

    if direction && direction != curr_direction
      return false
    end
    direction = curr_direction
  end
  true
end

row = data.first
row_safe?(row)

safe_count = 0
data.each do |row|
  safe_count += 1 if row_safe?(row)
end

puts "Safe Rows: #{safe_count}"