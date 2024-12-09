require "pry"

GUARD_TILE_UP = "^"
GUARD_TILE_DOWN = "v"
GUARD_TILE_RIGHT = ">"
GUARD_TILE_LEFT = "<"

@loc_history = []

def move_right
  next_pos = [g_pos[0], g_pos[1] + 1]
  return false unless check_boundry(next_pos)

  @g_pos = next_pos
end

def move_left
  next_pos = [g_pos[0], g_pos[1] - 1]
  return false unless check_boundry(next_pos)

  @g_pos = next_pos
end

def move_down
  next_pos = [g_pos[0] + 1, g_pos[1]]
  return false unless check_boundry(next_pos)

  @g_pos = next_pos
end

def move_up
  next_pos = [g_pos[0] - 1, g_pos[1]]
  return false unless check_boundry(next_pos)

  @g_pos = next_pos
end

def check_boundry(pos)
  return @continue = false if pos[0] < 0
  return @continue = false if pos[1] < 0
  return @continue = false if pos[1] >= matrix[0].size
  return @continue = false if pos[0] >= matrix.size
  return @continue = false if pos[0] >= matrix.size
  return false if obstructed?(pos)
  return true
end

def current_tile
  row, col = g_pos
  value = matrix[row][col]
end

def get_tile_at_pos(pos)
  row, col = pos
  matrix[row][col]
end

def get_pos_of_tile(tile)
  matrix.each_with_index do |row, row_index|
    row.each_with_index do |value, col_index|
      return [row_index, col_index] if value == tile
    end
  end
  nil
end

def g_pos
  @g_pos
end

def matrix
  @matrix
end

def obstructed?(pos)
  case get_tile_at_pos(pos)
  when "."
    false
  when "#"
    true
  end
end

def curr_direction
  @curr_direction
end

def turn
  case curr_direction
  when :up
    set_direction(:right)
  when :down
    set_direction(:left)
  when :left
    set_direction(:up)
  when :right
    set_direction(:down)
  end
end

def visited?(pos)
  @loc_history.include?(pos)
end

def move
  @loc_history << g_pos
  r = (case curr_direction
  when :up
    move_up
  when :down
    move_down
  when :left
    move_left
  when :right
    move_right
  end)
  if r == false
    puts "Guard is turning"
    turn
    move
  end

  puts "The Guard is at: #{g_pos} and is heading #{curr_direction}"
  if visited?(g_pos)
    puts "I've been here before"
  end
end

def set_intial_position
  @g_pos = get_pos_of_tile(GUARD_TILE_UP) ||
           get_pos_of_tile(GUARD_TILE_DOWN) ||
           get_pos_of_tile(GUARD_TILE_RIGHT) ||
           get_pos_of_tile(GUARD_TILE_LEFT)
end

def set_inital_direction
  @curr_direction = case current_tile
    when GUARD_TILE_UP
      :up
    when GUARD_TILE_DOWN
      :down
    when GUARD_TILE_LEFT
      :left
    when GUARD_TILE_RIGHT
      :right
    end
  # change tile to a dot
  matrix[g_pos[0]][g_pos[1]] = "."
end

def set_direction(direction)
  @curr_direction = direction
end

input_file = ARGV[0] || "./input.txt"
data = IO.read(input_file)
@matrix = data.split("\n").map { |row| row.split("") }

@exit_pos = [matrix.size - 1, matrix[-1].index("#")]
@continue = true

set_intial_position
set_inital_direction

puts "The Guard is at: #{g_pos} and is heading #{curr_direction}"

continue = true
while (@continue)
  move
end

puts "Unique locations: #{@loc_history.uniq.size}"
