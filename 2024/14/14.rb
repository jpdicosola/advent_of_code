require "pry"

def draw_grid(robots)
  grid = ["*" * GRID_WIDTH]
  for y in 0..GRID_HEIGHT - 1
    row = ""
    for x in 0..GRID_WIDTH - 1
      robot_count = robots.count { |r| r.position == [x, y] }
      if robot_count > 0
        row += robot_count.to_s
      else
        row += "."
      end
    end
    grid << row
  end
  grid << "*" * GRID_WIDTH
  grid.join("\n")
end

def move_grid(robots)
  robots.map do |r|
    x = (r.position[0] + r.velocity[0]) % GRID_WIDTH
    y = (r.position[1] + r.velocity[1]) % GRID_HEIGHT
    x += GRID_WIDTH if x < 0
    y += GRID_HEIGHT if y < 0
    OpenStruct.new(position: [x, y], velocity: r.velocity)
  end
end

def get_robots_in_quadrant(grid, quadrant)
  quad_height = (GRID_HEIGHT - 1) / 2
  quad_width = (GRID_WIDTH - 1) / 2

  x_start = 0
  y_start = 0
  x_end = quad_width
  y_end = quad_height

  case quadrant
  when 1
  when 2
    x_start = quad_width + 1
    x_end = GRID_WIDTH
  when 3
    y_start = quad_height + 1
    y_end = GRID_HEIGHT
  when 4
    x_start = quad_width + 1
    x_end = GRID_WIDTH
    y_start = quad_height + 1
    y_end = GRID_HEIGHT
  end
  grid.count do |r|
    r.position[0].between?(x_start, x_end - 1) &&
      r.position[1].between?(y_start, y_end - 1)
  end
end

input_file = ARGV[0] || "./input.txt"
data = IO.read(input_file)

inital_grid = []

data.split("\n").each do |row|
  puts row
  m = row.match(/p\=(?<pos>-?\d+\,-?\d+)\sv\=(?<vel>-?\d+\,-?\d+)/)
  inital_grid << OpenStruct.new(
    position: m[:pos].split(",").map(&:to_i),
    velocity: m[:vel].split(",").map(&:to_i),
  )
end

current_grid = inital_grid
GRID_HEIGHT = current_grid.max_by { |r| r.position[1] }.position[1] + 1
GRID_WIDTH = current_grid.max_by { |r| r.position[0] }.position[0] + 1

100.times do
  current_grid = move_grid(current_grid)
end
puts draw_grid(current_grid)

saftey_factor = get_robots_in_quadrant(current_grid, 1) *
                get_robots_in_quadrant(current_grid, 2) *
                get_robots_in_quadrant(current_grid, 3) *
                get_robots_in_quadrant(current_grid, 4)

puts "The saftey factor is: #{saftey_factor}"
