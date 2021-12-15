$ballast = 10**8
def check_around(current_y, current_x)
  current_weight = $distances_table["value"][current_y*$y_length+current_x]
  $moves.each do |y_addition, x_addition|
    checked_y = current_y + y_addition
    checked_x = current_x + x_addition
    if (0...$y_length).include?(checked_y) and (0...$x_length).include?(checked_x)
      if $distances_table["value"][checked_y*$y_length+checked_x] > current_weight + $height_map[checked_y][checked_x]
        $distances_table["value"][checked_y*$y_length+checked_x] = current_weight + $height_map[checked_y][checked_x]
        $distances_table["ancestor"][checked_y*$y_length+checked_x] = [current_y,current_x]
      end
    end
  end
  $distances_table["value"][current_y*$y_length+current_x] += $ballast
end

input = File.open 'input15.txt'
input_list = []
input.readlines.each do |x|
  input_list.push x.rstrip.split("").map(&:to_i)
end
$y_length = input_list.length
$x_length = input_list[0].length
$height_map = input_list
$distances_table ={"value"=>Array.new($x_length*$y_length, Float::INFINITY),
                   "ancestor"=>Array.new($x_length*$y_length, [])}
$moves = [[0,-1],[0,1],[1,0],[-1,0]]
current_y, current_x = 0, 0
$distances_table["value"][current_y*$y_length+current_x] = 0

while true
  array_position = $distances_table["value"].each_with_index.min[1]
  current_y = array_position/$y_length
  current_x = array_position%$y_length
  if current_y == $y_length-1 and current_x == $x_length-1
    p $distances_table["value"][current_y*$y_length+current_x]
    exit
  else
    check_around(current_y, current_x)
    p current_y, current_x
  end
end