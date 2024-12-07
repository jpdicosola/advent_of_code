def valid_order?(update, rules)
  positions = update.each_with_index.to_h

  rules.all? do |x, y|
    (!positions.key?(x) || !positions.key?(y)) || positions[x] < positions[y]
  end
end

input_file = ARGV[0] || "./input.txt"
data = IO.read(input_file)
parts = data.split("\n\n")
ordering_rules = parts[0].split("\n").map { |line| line.split("|").map(&:to_i) }
updates = parts[1].split("\n").map { |line| line.split(",").map(&:to_i) }

middle_pages = updates.filter_map do |update|
  if valid_order?(update, ordering_rules)
    update[update.size / 2]
  end
end

result = middle_pages.sum

puts "Sum of middle pages: #{result}"
