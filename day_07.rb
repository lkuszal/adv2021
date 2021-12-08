input = File.open 'input7.txt'
input_text = input.read
position_list = input_text.split(",").map(&:to_i)

def summing_fuels(selected_point, list)
  fuel_usage = 0
  list.each do |x|
    fuel_usage += (x-selected_point).abs
  end
  fuel_usage
end

def summing_fuels2(selected_point,list, fuel_cost)
  fuel_usage = 0
  list.each do |x|
    fuel_usage += fuel_cost[(selected_point-x).abs]
  end
  fuel_usage
end

fuel_cost = [0]
(1..position_list.max).each do |x|
  fuel_cost.push(fuel_cost[x-1] + x)
end

a = Float::INFINITY
c = Float::INFINITY
position_list.max.times do |position|
  b = summing_fuels(position, position_list)
  if b < a then a = b end
  d = summing_fuels2(position, position_list, fuel_cost)
  if d < c then c = d end
end
puts a
puts c