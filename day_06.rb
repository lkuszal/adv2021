input = File.open 'input6.txt'
input_text = input.read
initial_fish_list = input_text.split(",").map(&:to_i)
initial_fish_dict_count = {}
9.times do |day_count|
  initial_fish_dict_count[day_count] = initial_fish_list.count(day_count)
end

class FishCounter
  def initialize(count_dict)
    @fish_count = count_dict
  end

  def day_pass
    new_fish_count = {0=>0, 1=>0, 2=>0, 3=>0, 4=>0, 5=>0,  6=>0, 7=>0, 8=>0}
    @fish_count.each_pair do |day_status, fishes|
      if day_status > 0
        new_fish_count[day_status - 1] += fishes
      else
        new_fish_count[8] += fishes
        new_fish_count[6] += fishes
      end
    end
    @fish_count = new_fish_count
  end

  def sum_fishes
    @fish_count.each_value.sum
  end
end

part_1 = FishCounter.new(initial_fish_dict_count)
80.times do part_1.day_pass end
p part_1.sum_fishes

part_2 = FishCounter.new(initial_fish_dict_count)
256.times do part_2.day_pass end
p part_2.sum_fishes