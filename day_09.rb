input = File.open 'input9.txt'
input_list = []
input.readlines.each do |x|
  input_list.push x.rstrip.split("").map(&:to_i)
end
y_length = input_list.length
x_length = input_list[0].length
risk_sum = 0

y_length.times do |y|
  x_length.times do |x|
    if y == 0 then top = Float::INFINITY else top = input_list[y-1][x] end
    if x == (x_length - 1) then right = Float::INFINITY else right = input_list[y][x+1] end
    if y == (y_length - 1) then bottom = Float::INFINITY else bottom = input_list[y+1][x] end
    if x == 0 then left = Float::INFINITY else left = input_list[y][x-1] end
    if input_list[y][x] < [top, right, bottom, left].min then risk_sum += (1 + input_list[y][x]) end
  end
end
p risk_sum
basins = []
basin_number = -1
y_length.times do |y|
  x_length.times do |x|
    if input_list[y][x] != 9 and input_list[y][x] != '#'
      basin_number += 1
      basins[basin_number] = [[y, x]]
      basins[basin_number].each do |field_coordinates|
        input_list[field_coordinates[0]][field_coordinates[1]] = '#'
        if field_coordinates[0] == 0 then top = "#" else top = [field_coordinates[0]-1, field_coordinates[1]] end
        if field_coordinates[1] == (x_length - 1) then right = "#" else right = [field_coordinates[0], field_coordinates[1]+1] end
        if field_coordinates[0] == (y_length - 1) then bottom = "#" else bottom = [field_coordinates[0]+1, field_coordinates[1]] end
        if field_coordinates[1] == 0 then left = "#" else left = [field_coordinates[0], field_coordinates[1]-1] end
        [top, right, bottom, left].each do |new_field_coordinates|
          if new_field_coordinates != '#'
            new_field = input_list[new_field_coordinates[0]][new_field_coordinates[1]]
            if new_field != '#' and new_field != 9
              unless basins[basin_number].include? new_field_coordinates
                basins[basin_number].push new_field_coordinates
              end
            end
          end
        end
      end
    end
  end
end


ads = basins.sort_by(&:length)[-3].length * basins.sort_by(&:length)[-2].length * basins.sort_by(&:length)[-1].length
p ads