$number_scores = {'1110111'=>'0', '10010'=>'1', '1011101'=>'2', '1011011'=>'3', '111010'=>'4', '1101011'=>'5', '1101111'=>'6', '1010010'=>'7', '1111111'=>'8', '1111011'=>'9'}
$ordered_segments_value = [64,32,16,8,4,2,1]
class DisplayWires
  def initialize(letters_in_order_az, numbers_to_decode)
    @segments_value = Hash[letters_in_order_az.zip($ordered_segments_value)]
    @numbers_to_decode = numbers_to_decode
  end
  def decode
    result = ''
    @numbers_to_decode.each do |number_as_segments|
      score = 0
      number_as_segments.split("").each do |segment|
        score += @segments_value[[segment]]
      end
      result += $number_scores[score.to_s(2)]
    end
    result.to_i
  end
end

class Decipher
  def initialize(input_numbers)
    @numbers = input_numbers.sort_by(&:length)
  end
  def solve
    numbers = @numbers
    solution_dict = {}
    solution_dict['a'] = numbers[1] - numbers[0]
    numbers[3..5].each do |number|
      x = number - numbers[2] - solution_dict['a']
        if x.length == 1
          solution_dict['g'] = x
          break
        end
    end
    solution_dict['e'] = numbers[9] - numbers[2] - solution_dict['a'] - solution_dict['g']
    x = (numbers[3] + numbers[4] + numbers[5])
    x.each do |segment|
      if x.one?(segment) and [segment] != solution_dict['e']
        solution_dict['b'] = [segment]
        break
      end
    end
    solution_dict['d'] = numbers[2] - numbers[0] - solution_dict['b']
    x = (numbers[6] + numbers[7] + numbers[8])
    x.each do |segment|
      if x.count(segment) == 2 and [segment] != solution_dict['e'] and [segment] != solution_dict['d']
        solution_dict['c'] = [segment]
        break
      end
    end
    solution_dict['f'] = numbers[0] - solution_dict['c']
    response = []
    solution_dict.sort.each do |key, letter|
      response.push letter
    end
    response
  end
end

input = File.open('input8.txt')
input_list = input.readlines.map(&:chomp)
counter = 0
final_result = 0
input_list.each do |row|
  randoms, output = row.split(" | ")
  output.split.each do |word|
    if [2,3,4,7].include?(word.length) then counter += 1 end
  end
  splitted_randoms = []
  randoms.split.each do |word|
    splitted_randoms.push(word.split'')
  end

  riddle = Decipher.new(splitted_randoms)
  solution = DisplayWires.new(riddle.solve,output.split)
  final_result += solution.decode
end
puts counter
puts final_result

