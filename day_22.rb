class Area
  def initialize(input)
    @mode = input[0]
    @x1,@x2,@y1,@y2,@z1,@z2 = *input[1..]
    @volume = (@x2 - @x1) * (@y2 - @y1) * (@z2 - @z1)
  end

  def compare(new_input)
    if new_input[1] > @x2 or new_input[2] < @x1
      false
    else
      if new_input[3] > @y2 or new_input[4] < @y1
        false
      else
        if new_input[5] > @z2 or new_input[6] < @z1
          false
        else
          x_field = overflowing_field(new_input[1,2],[@x1,@x2])
          y_field = overflowing_field(new_input[3,4],[@y1,@y2])
          z_field = overflowing_field(new_input[5,6],[@z1,@z2])
          return [x_field, y_field, z_field]
        end
      end
    end
  end

  def separate(cut_area)
    all_lines = []
    cut_area.zip([[@x1,@x2],[@y1,@y2],[@z1,@z2]]).each do |cut, current|
      lines = [current[0]]
      if cut[0] > current[0] then lines.push cut[0] end
      if cut[1] < current[1] then lines.push cut[1] end
      lines.push [current[1]]
      all_lines.push lines
    end
    (all_lines[0].length - 1).times do |a|
      (all_lines[1].length - 1).times do |b|
        (all_lines[2].length - 1).times do |c|
          new_area = [all_lines[0][a],all_lines[0][a+1],all_lines[1][b],all_lines[1][b+1],all_lines[2][c],all_lines[2][c+1]]
          unless new_area == cut_area
            Area.new([@mode,*new_area])
          end
        end
      end
    end
  end

  def overflowing_field(new_input, input)
    [new_input[0] < input[0] ? input[0] : new_input[0], new_input[1] > input[1] ? input[1] : new_input[1]]
  end
end

input = File.open('input22.txt')
input_list = []
input_list.push input.readlines.map {|row| [row[..2].rstrip] + row[3..].lstrip.gsub(/[^-|^\d]/, " ").split.map(&:to_i) }
p input_list[0]
areas = []
input_list[0].each do |new_area|
  changed = false
  areas.each_with_index do |existing_area, index|
    comparison = existing_area.compare(new_area)
    unless comparison
      existing_area.separate(comparison)
      changed = true
      areas.delete_at(index)
    end
  end
  unless changed == false and new_area[0] == 'off'
    areas.push Area.new(new_area)
  end
end
