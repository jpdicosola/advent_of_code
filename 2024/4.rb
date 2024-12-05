require "pry"

input_file = ARGV[0] || "./input.txt"
data = IO.read(input_file)

MATCH_PHRASES = ["XMAS"]

matrix = data.split("\n").map { |row| row.split("") }
match_count = 0
word_length = MATCH_PHRASES[0].length

matrix.each_with_index do |row, row_index|
  row.each_with_index do |element, col_index|
    if col_index + word_length - 1 < row.length
      horizontal_right = row[col_index, word_length].join
      match_count += 1 if MATCH_PHRASES.include?(horizontal_right)
    end

    if col_index - word_length + 1 >= 0
      horizontal_left = row[col_index - word_length + 1, word_length].reverse.join
      match_count += 1 if MATCH_PHRASES.include?(horizontal_left)
    end

    if row_index + word_length - 1 < matrix.length
      vertical_down = (0...word_length).map { |i| matrix[row_index + i][col_index] }.join
      match_count += 1 if MATCH_PHRASES.include?(vertical_down)
    end

    if row_index - word_length + 1 >= 0
      vertical_up = (0...word_length).map { |i| matrix[row_index - i][col_index] }.join
      match_count += 1 if MATCH_PHRASES.include?(vertical_up)
    end

    if row_index + word_length - 1 < matrix.length && col_index + word_length - 1 < row.length
      diagonal_down_right = (0...word_length).map { |i| matrix[row_index + i][col_index + i] }.join
      match_count += 1 if MATCH_PHRASES.include?(diagonal_down_right)
    end

    if row_index - word_length + 1 >= 0 && col_index - word_length + 1 >= 0
      diagonal_up_left = (0...word_length).map { |i| matrix[row_index - i][col_index - i] }.join
      match_count += 1 if MATCH_PHRASES.include?(diagonal_up_left)
    end

    if row_index + word_length - 1 < matrix.length && col_index - word_length + 1 >= 0
      diagonal_down_left = (0...word_length).map { |i| matrix[row_index + i][col_index - i] }.join
      match_count += 1 if MATCH_PHRASES.include?(diagonal_down_left)
    end

    if row_index - word_length + 1 >= 0 && col_index + word_length - 1 < row.length
      diagonal_up_right = (0...word_length).map { |i| matrix[row_index - i][col_index + i] }.join
      match_count += 1 if MATCH_PHRASES.include?(diagonal_up_right)
    end
  end
end

puts "Match count: #{match_count}"
