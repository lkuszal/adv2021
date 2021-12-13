input = File.open 'input13.txt'
dots = []
folds = []
input.readlines.each do |x|
  if x.include?(",") then dots.push(x.split(",").map(&:to_i))
  elsif x.include?("=") then folds.push(x.split[-1].split("="))
  end
end
first_time = true
folds.each do |axis, fold_height|
  new_dots = []
  axis == "x" ?  compared_index = 0 : compared_index = 1
  dots.each do |position|
    if position[compared_index] > fold_height.to_i
      position[compared_index] -= (fold_height.to_i - position[compared_index]).abs * 2
    end
    new_dots.push(position)
  end
  dots = new_dots
  if first_time then p dots.uniq.length, first_time = false end
end
display = Array.new(10) { Array.new(100) {0} }
dots.uniq.each do |x,y|
  p x, y, "\n"
  display[y][x] = 8
end

display.each do |row|
  p row
end