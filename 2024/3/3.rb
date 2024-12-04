require "pry"

input_file = ARGV[0] || "./input.txt"
data = IO.read(input_file)

# The do() instruction enables future mul instructions.
# The don't() instruction disables future mul instructions.

pointer = 0
sum = 0
processing_enabled = false

processing_enabled = true

while (pointer < data.length)
  next_do = data[pointer..-1].index("do()")
  next_dont = data[pointer..-1].index("don't()")
  next_instruction = [next_do, next_dont].compact.min

  end_idx = next_instruction.nil? ? data.length : pointer + next_instruction
  segment = data[pointer...end_idx]

  if processing_enabled
    matches = segment.scan(/mul\((\d{1,3}),(\d{1,3})\)/)
    sum += matches.map { |m| m[0].to_i * m[1].to_i }.sum
  end

  pointer = end_idx

  if next_instruction
    if data[pointer..].start_with?("do()")
      processing_enabled = true
      pointer += 4
    elsif data[pointer..].start_with?("don't()")
      processing_enabled = false
      pointer += 7
    end
  end
end

puts "Sum: #{sum}"
