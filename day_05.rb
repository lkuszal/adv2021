input = File.open('input5.txt')
input_list = input.readlines.map(&:chomp)
ocean_map = Array.new(1000) {Array.new(1000, 0)}
input_list.each do |row|
  coordinates = row.sub(" -> ",",").split(",").map(&:to_i)
  if coordinates[0] == coordinates[2]
    ([coordinates[1], coordinates[3]].min .. [coordinates[1], coordinates[3]].max).each do |y_value|
      ocean_map[y_value][coordinates[0]] += 1
    end
  elsif coordinates[1] == coordinates[3]
    ([coordinates[0], coordinates[2]].min .. [coordinates[0], coordinates[2]].max).each do |x_value|
      ocean_map[coordinates[1]][x_value] += 1
    end
  end
end
intercourses = 0
ocean_map.each do |list|
  intercourses += list.length - list.count(1) - list.count(0)
end
puts intercourses
# part 2
ocean_map = Array.new(1000) {Array.new(1000, 0)}
input_list.each do |row|
  coordinates = row.sub(" -> ",",").split(",").map(&:to_i)
  if coordinates[0] == coordinates[2]
    ([coordinates[1], coordinates[3]].min .. [coordinates[1], coordinates[3]].max).each do |y_value|
      ocean_map[y_value][coordinates[0]] += 1
    end
  elsif coordinates[1] == coordinates[3]
    ([coordinates[0], coordinates[2]].min .. [coordinates[0], coordinates[2]].max).each do |x_value|
      ocean_map[coordinates[1]][x_value] += 1
    end
  elsif (coordinates[1] - coordinates[3]).abs == (coordinates[0] - coordinates[2]).abs
    if (coordinates[1] > coordinates[3] and coordinates[0] > coordinates[2]) or (coordinates[1] < coordinates[3] and coordinates[0] < coordinates[2])
      x_pos = [coordinates[0], coordinates[2]].min
      y_pos = [coordinates[1], coordinates[3]].min
      line_length = ((coordinates[1] - coordinates[3]).abs) +1
      line_length.times do |move|
        ocean_map[y_pos+move][x_pos+move] += 1
      end
    else
      x_pos = [coordinates[0], coordinates[2]].max
      y_pos = [coordinates[1], coordinates[3]].min
      line_length = ((coordinates[1] - coordinates[3]).abs) +1
      line_length.times do |move|
        ocean_map[y_pos+move][x_pos-move] += 1
      end
    end
  end
end
intercourses = 0
ocean_map.each do |list|
  intercourses += list.length - list.count(1) - list.count(0)
end

puts intercourses