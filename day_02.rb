class ShipNavigation
  def initialize(horizontal=0, depth=0)
    @horizontal = horizontal
    @depth = depth
  end
  
  def move(direction, distance)
    case direction
    when 'forward'
      @horizontal += distance.to_i
    when 'up'
      @depth -= distance.to_i
    when 'down'
      @depth += distance.to_i
    end
  end

  def end_journey
    return @horizontal, @depth
  end
end
first_journey = ShipNavigation.new

input = File.open('input2.txt')
input_list = input.readlines.map(&:chomp)
input_list.each do |instruction|
  first_journey.move(*instruction.split)
end
x,y = first_journey.end_journey
puts x*y

class ShipNavigation2
  def initialize(horizontal=0, depth=0, aim=0)
    @horizontal = horizontal
    @depth = depth
    @aim = aim
  end

  def move(direction, distance)
    case direction
    when 'forward'
      @horizontal += distance.to_i
      @depth += distance.to_i * @aim
    when 'up'
      @aim -= distance.to_i
    when 'down'
      @aim += distance.to_i
    end
  end

  def end_journey
    return @horizontal, @depth
  end
end

second_journey = ShipNavigation2.new
input_list.each do |instruction|
  second_journey.move(*instruction.split)
end
x,y = second_journey.end_journey
puts x*y