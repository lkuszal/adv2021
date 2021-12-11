$char_end_to_beginning = {
  ')' => '(',
  ']' => '[',
  '>' => '<',
  '}' => '{'
}
$char_err = {
  ')' => 3,
  ']' => 57,
  '}' => 1197,
  '>' => 25137
}
$char_comp = {
  '(' => 1,
  '[' => 2,
  '{' => 3,
  '<' => 4
}
class LineValidator
  def initialize(line)
    @line = line
  end

  def validate
    sequence = []
    @line.each do |character|
      if ! $char_end_to_beginning.keys.include? character
        sequence.push character
      else
        if sequence[-1] == $char_end_to_beginning[character]
          sequence.pop
        else
          return $char_err[character]
        end
      end
    end
    0
  end

  def autocomplete
    sequence = []
    sequence_value = 0
    @line.each do |character|
      if ! $char_end_to_beginning.keys.include? character
        sequence.push character
      else
        sequence.pop
      end
    end
    sequence.reverse.each do |leftover_opening|
      sequence_value *= 5
      sequence_value += $char_comp[leftover_opening]
    end
    sequence_value
  end
end
input = File.open 'input10.txt'
input_list = []
input.readlines.each do |x|
  input_list.push x.rstrip.split("")
end
sum_of_errors = 0
sum_of_completion = []
input_list.each do |row|
  row_object = LineValidator.new(row)
  validate_result = row_object.validate
  if validate_result != 0
    sum_of_errors += validate_result
  else
    sum_of_completion.push row_object.autocomplete
  end
end
p sum_of_errors
p sum_of_completion.sort[sum_of_completion.length/2]