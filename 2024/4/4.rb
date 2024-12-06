input_file = ARGV[0] || "./input.txt"
data = IO.read(input_file)

MATCH_PHRASE = "MAS"
matrix = data.split("\n").map { |row| row.split("") }
match_count = 0

matrix.each_with_index do |row, row_index|
  row.each_with_index do |element, col_index|
    if row_index - 1 >= 0 && row_index + 1 < matrix.length &&
       col_index - 1 >= 0 && col_index + 1 < row.length
      top_left = matrix[row_index - 1][col_index - 1]
      top_right = matrix[row_index - 1][col_index + 1]
      center = matrix[row_index][col_index]
      bottom_left = matrix[row_index + 1][col_index - 1]
      bottom_right = matrix[row_index + 1][col_index + 1]

      x_shapes = [
        [top_left, center, bottom_right].join,
        [top_right, center, bottom_left].join,
        [bottom_left, center, top_right].join,
        [bottom_right, center, top_left].join,
      ]

      if x_shapes.count(MATCH_PHRASE) == 2
        match_count += 1
      end
    end
  end
end

puts "Match count: #{match_count}"
