input = File.open 'input14.txt'
input_text = input.read.split("\n\n")
polymer_template = input_text[0].rstrip
inserting_dict = {}
input_text[1].split("\n").each do |row|
  inserting_dict[row[..1]] = row[..1][0] + row[-1].downcase + row[..1][1]
end
=begin
class PolymerCoating
  def initialize(initial_polymer_template, replacement_dict)
    @polymer_template = initial_polymer_template
    @replacement_pattern = replacement_dict
  end
  def add_new_layer
    @replacement_pattern.each do |key, value|
      current_length = 0
      while current_length != @polymer_template.length
        current_length = @polymer_template.length
        @polymer_template.gsub!(key, value)
      end
    end
    @polymer_template.upcase!
  end
  def count_elements
    occurances = @polymer_template.split("").tally.values
    p occurances.max - occurances.min
  end
end
coat = PolymerCoating.new(polymer_template, inserting_dict)
10.times do |x|
  coat.add_new_layer
end
coat.count_elements
=end
# part two

pairs_dict = {}

input_text[1].split("\n").each do |row|
  pairs_dict[row[..1]] = [row[..1][0] + row[-1], row[-1] + row[..1][1]]
end
basic_template = polymer_template.split("")
original_template = {}
pairs_dict.each do |key, value|
  original_template[key] = 0
  original_template[value[0]] = 0
  original_template[value[1]] = 0
end

(basic_template.length-1).times do |i|
  original_template[basic_template[i] + basic_template[i+1]] += 1
end

new_template = original_template.clone

40.times do |x|
  original_template.each do |existing_pair, pair_count|
    new_pairs = pairs_dict[existing_pair]
    if new_pairs
      new_template[new_pairs[0]] += pair_count
      new_template[new_pairs[1]] += pair_count
      new_template[existing_pair] -= pair_count
    end
  end
  original_template = new_template.clone
end

letter_dict = {}
original_template.each do |key, value|
  if letter_dict[key[0]] then letter_dict[key[0]] += value else letter_dict[key[0]] = value end
  if letter_dict[key[1]] then letter_dict[key[1]] += value else letter_dict[key[1]] = value end
end
letter_dict.each do |key, value|
  letter_dict[key] /= 2
end
letter_dict[polymer_template[0]] += 1
letter_dict[polymer_template[-1]] += 1
p letter_dict.values.max - letter_dict.values.min