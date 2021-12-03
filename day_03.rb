class PowerCounter
  def initialize(power_list)
    @power_list = power_list
    @number_of_rows = power_list.length
    @length_of_row = power_list[0].length
  end

  def count_letter_rates
    number_of_ones_on_index = Array.new(@length_of_row, 0)
    @power_list.each do |row|
      row.split("").each_with_index do |bit, index|
        if bit == '1' then number_of_ones_on_index[index] += 1 end
      end
    end
    gamma_rate = ''
    epsilon_rate = ''
    number_of_ones_on_index.each do |ones_count|
      if ones_count > @number_of_rows/2
        gamma_rate = gamma_rate.to_s + '1'
        epsilon_rate = epsilon_rate.to_s + '0'
      else
        gamma_rate = gamma_rate.to_s + '0'
        epsilon_rate = epsilon_rate.to_s + '1'
      end
    end
    gamma_rate = gamma_rate.to_i(2)
    epsilon_rate = epsilon_rate.to_i(2)
    return gamma_rate, epsilon_rate
  end
end

def count_other_rates(power_list, most_common=true, bit_index=0)
  list_of_rows_having_one_on_index = []
  list_of_rows_having_zero_on_index = []
  power_list.each do |row|
    if row[bit_index] == '1'
      list_of_rows_having_one_on_index.push(row)
    else
      list_of_rows_having_zero_on_index.push(row)
    end
  end
  if most_common
    if list_of_rows_having_one_on_index.length == list_of_rows_having_zero_on_index.length
      selected_list = list_of_rows_having_one_on_index
      else
    selected_list = [list_of_rows_having_one_on_index, list_of_rows_having_zero_on_index].max_by(&:length)
    end
  else
    if list_of_rows_having_one_on_index.length == list_of_rows_having_zero_on_index.length
      selected_list = list_of_rows_having_zero_on_index
    else
      selected_list = [list_of_rows_having_one_on_index, list_of_rows_having_zero_on_index].min_by(&:length)
    end
  end
  if selected_list.length == 1
    return selected_list[0]
  else
    return count_other_rates(selected_list, most_common=most_common, bit_index+1)
  end
end

input = File.open('input3.txt')
input_list = input.readlines.map(&:chomp)
first_task =  PowerCounter.new(input_list)
gamma, epsilon = first_task.count_letter_rates
puts gamma*epsilon
puts count_other_rates(input_list).to_i(2) * count_other_rates(input_list, most_common=false).to_i(2)