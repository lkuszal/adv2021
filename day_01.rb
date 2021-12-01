input = File.open('input1.txt')
input_list = input.readlines.map(&:to_i)
number_of_larger_rows = 0
(input_list.length-1).times do |index|
    if input_list[index+1] > input_list[index] then number_of_larger_rows += 1 end
end
puts number_of_larger_rows
# part two
number_of_larger_sums = 0
(input_list.length-3).times do |index|
    if input_list[index+3] > input_list[index] then number_of_larger_sums += 1 end
end
puts number_of_larger_sums