class OctopusSquare
  attr_reader :flashes, :square
  def initialize(nested_list)
    @square = nested_list
    @flashes = 0
    @size = [@square.length, @square[0].length]
  end

  def gain_energy
    @size[0].times do |y|
      @size[1].times do |x|
        @square[y][x] += 1
      end
    end
  end
  def flash
    current_flash_count = @flashes + 1
    while current_flash_count != @flashes do
      current_flash_count = @flashes
      @size[0].times do |y|
        @size[1].times do |x|
          if @square[y][x] > 9 and @square[y][x] != Float::INFINITY
            @flashes += 1
            @square[y][x] = Float::INFINITY
            (y-1..y+1).each do |new_y|
              if new_y  < @size[0] and new_y >= 0
                (x-1..x+1).each do |new_x|
                  if new_x  < @size[1] and new_x >= 0
                    @square[new_y][new_x] += 1
                  end
                end
              end
            end
          end
        end
      end
    end
    @size[0].times do |y|
      @size[1].times do |x|
        if @square[y][x] > 9 then @square[y][x] = 0 end
      end
    end
    if @square.uniq.length == 1 then
      if square.uniq[0].uniq == [0]
        p $x
        exit
      end
    end
  end
end

input = File.open 'input11.txt'
input_list = []
input.readlines.each do |x|
  input_list.push x.rstrip.split("").map(&:to_i)
end
=begin
square = OctopusSquare.new(input_list)
100.times do |i|
  square.gain_energy
  square.flash
end
p square.flashes
=end
$x = 0
while true do
  $x += 1
  square2 = OctopusSquare.new(input_list)
  square2.gain_energy
  square2.flash
end