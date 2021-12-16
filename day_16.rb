input = File.open 'input16.txt'
input_text = input.read.split("")
binary_string = ''
input_text.each do |hex_char|
  binary_string += ('0000' + hex_char.to_i(16).to_s(2))[-4..]
end

$sum_of_versions = 0
def process_package(binary_string)
  p binary_string
  version = binary_string[..2].to_i(2)
  $sum_of_versions += version
  type_id = binary_string[3..5].to_i(2)
  if type_id == 4
    p 4
    binary_value = ''
    last_bit = false
    index = 6
    until last_bit
      if binary_string[index] == "0"
        last_bit = true
      end
      binary_value += binary_string[index+1..index+4]
      index += 5
    end
    return [binary_value.to_i(2), index]
  else
    if binary_string[6] == "0"
      p 0
      total_length_of_subpackets = binary_string[7...7+15].to_i(2)
      processed_length = 0
      while total_length_of_subpackets > processed_length
        result = process_package(binary_string[7+15..][processed_length..])
        processed_length += result[1]
      end
      return result
    else
      p 1
      number_of_contained_subpackets = binary_string[7...7+11].to_i(2)
      processed_subpackets = 0
      processed_length = 0
      while number_of_contained_subpackets > processed_subpackets
        result = process_package(binary_string[7+11..][processed_length..])
        processed_subpackets += 1
        processed_length += result[1]
      end
      return result
    end
  end
end

process_package(binary_string)
p $sum_of_versions
