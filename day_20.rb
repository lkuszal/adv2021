class ImageEnhancer
  def initialize(current_map, enhancing_pattern)
    @current_map = current_map.clone
    @enhancing_pattern = enhancing_pattern
    @even_enhancement = false
  end

  def add_empty_layers(n, char)
    x_length = @current_map[0].length
    @current_map.each do |row|
      row.unshift(*[char]*n)
      row.push(*[char]*n)
    end
    @current_map.unshift(*[[char]*(x_length+n*2)]*n)
    @current_map.push(*[[char]*(x_length+n*2)]*n)
  end

  def enhance_pixel(y,x)
    pixel_square = [@current_map[y-1][x-1..x+1],@current_map[y][x-1..x+1],@current_map[y+1][x-1..x+1]]
    pixel_binary = pixel_square.map! {|x| x.join}.join.gsub("#","1").gsub(".","0")
    @enhancing_pattern[pixel_binary.to_i(2)]
  end

  def enhance_image
    @even_enhancement ? self.add_empty_layers(2,"#") : self.add_empty_layers(2,".")
    new_map = []
    (1...@current_map.length-1).each do |y|
      new_map.push []
      (1...@current_map[0].length-1).each do |x|
        new_map[y-1].push self.enhance_pixel(y,x)
      end
    end
    @current_map = new_map
    @even_enhancement = !@even_enhancement
  end

  def count_lights
    @current_map.map {|x| x.count("#")}.sum
  end
end

input = File.open('input20.txt').read
enhancing_pattern, input_map = input.split("\n\n")
input_map = input_map.split("\n").map! {|x| x.split("")}
part1 = ImageEnhancer.new(input_map, enhancing_pattern)
part1.enhance_image
part1.enhance_image
p part1.count_lights
part2 = ImageEnhancer.new(input_map, enhancing_pattern)
50.times do
  part2.enhance_image
end
p part2.count_lights
