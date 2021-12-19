require 'json'
class MathHomework
  def initialize(input_list)
    @number = input_list
  end

  def add_new_number(new_number)
    @number = ['['] + @number + new_number + [']']
    until self.check_for_reducing
    end
  end

  def check_for_reducing
    data_for_split = nil
    nesting_depth = 0
    @number.each_with_index do |x, index|
      case x
      when '['
        nesting_depth += 1
      when ']'
        nesting_depth -= 1
      when Integer
        if x >= 10 then data_for_split ||= [index, x] end
        if nesting_depth > 4 and @number[index + 1].class == Integer
          self.explode(index)
          return false
        end
      end
    end
    if data_for_split then
      self.splitting(*data_for_split)
      return false
    end
    true
  end

  def magnitude
    p @number.join(" ")
    computed = false
    until computed
      changed = false
      @number.each_with_index do |x, index|
        if x.class == Integer and @number[index+1].class == Integer
          @number[index-1..index+2] = 3*x + 2*@number[index+1]
          changed = true
          break
        end
      end
      unless changed
        computed = true
      end
    end
    @number
  end

  def explode(index)
    (index-1).downto(0) do |x|
      if @number[x].class == Integer
        @number[x] += @number[index]
        break
      end
    end
    (index+2...@number.length).each do |x|
      if @number[x].class == Integer
        @number[x] += @number[index+1]
        break
      end
    end
    @number[index-1..index+2] = 0
  end

  def splitting(index, value)
    @number.delete_at(index)
    @number.insert(index, '[',value/2,(value/2.to_f).ceil,']')
  end
end

class String
  def numeric?
    Float(self) != nil rescue false
  end
end

input = File.open 'input18.txt'
input_list = []
input.readlines.each do |row|
  row_list = []
  row.rstrip.split("").each do |char|
    unless char == ','
      row_list.push char.numeric? ? char.to_i : char
    end
  end
  input_list.push row_list
end
homework = MathHomework.new(input_list[0])
input_list[1..].each do |row|
  homework.add_new_number(row)
end
p homework.magnitude
results=[]
input_list.length.times do |x|
  ((x+1)...input_list.length).each do |y|
    homework2 = MathHomework.new(input_list[x])
    homework2.add_new_number(input_list[y])
    results.push homework2.magnitude
    homework2 = MathHomework.new(input_list[y])
    homework2.add_new_number(input_list[x])
    results.push homework2.magnitude
  end
end
p results.max
