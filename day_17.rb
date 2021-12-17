input = File.open('input17.txt').read
$field = input.gsub(/[^-|^\d]/, " ").split.map(&:to_i)
 $field

def shot(x_velocity1, y_velocity1)
  x_velocity = x_velocity1
  y_velocity = y_velocity1
  x_position = 0
  y_position = 0
  max_y_position =  0
  while x_position <= $field[1] and y_position >= $field[2]
    if x_position >= $field[0] and y_position <= $field[3]
      return [true, max_y_position,x_velocity1,y_velocity1]
    end
    x_position += x_velocity
    y_position += y_velocity
    if y_position > max_y_position then max_y_position = y_position end
    unless x_velocity == 0 then x_velocity += (x_velocity < 0) ? 1 : -1 end
    y_velocity -= 1
  end
  [false]
end

top_y = 0
hits = []
1000.times do |x|
  1000.times do |y|
    result = shot(x,y)
    if result[0] then hits.push result[2,3] end
    if result[0] then if result[1] > top_y then top_y = result[1] end end
    result = shot(x,-y)
    if result[0] then hits.push result[2,3] end
  end
end
p top_y
p hits.uniq.length
