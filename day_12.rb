input = File.open 'input12.txt'
input_list = []
input.readlines.each do |x|
  input_list.push x.rstrip.split("-")
end
$connection_dict = {}
input_list.each do |connection|
  $connection_dict[connection[0]] ? $connection_dict[connection[0]].push(connection[1]) : $connection_dict[connection[0]] = [connection[1]]
  $connection_dict[connection[1]] ? $connection_dict[connection[1]].push(connection[0]) : $connection_dict[connection[1]] = [connection[0]]
end
$roads =[]
def generate_all_roads(current_travel)
  possible_targets = $connection_dict[current_travel[-1]]
  possible_targets.each do |target|
    if target.downcase == target and current_travel.include?(target)
    else
      if target == 'end'
        unless $roads.include?(current_travel + [target])
          $roads.push(current_travel+[target])
        end
      else
        generate_all_roads(current_travel+[target])
      end
    end
  end
end

generate_all_roads(["start"])
p $roads.length

$roads2 = []
def generate_all_roads2(current_travel, visited_twice)
  possible_targets = $connection_dict[current_travel[-1]]
  possible_targets.each do |target|
    if target.downcase == target and current_travel.include?(target)
      if !visited_twice and target != 'start' and target != 'end'
        generate_all_roads2(current_travel+[target], true)
      end
    else
      if target == 'end'
        unless $roads2.include?(current_travel + [target])
          $roads2.push(current_travel+[target])
        end
      else
        generate_all_roads2(current_travel+[target], visited_twice)
      end
    end
  end
end

generate_all_roads2(["start"], false)
p $roads2.length