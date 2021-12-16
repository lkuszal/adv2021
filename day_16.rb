input = File.open 'input16.txt'
input_text = input.read.split("")
binary_string = []
input_text.each do |hex_char|
  binary_string.push(*('0000' + hex_char.to_i(16).to_s(2))[-4..].split(""))
end
$sum_of_versions = 0
def process_package(binary_string)
  p binary_string.join
  version = binary_string[..2].join.to_i(2)
  $sum_of_versions += version
  type_id = binary_string[3..5].join.to_i(2)
  binary_string.shift(6)
  if type_id == 4
    p 4
    binary_value = ''
    last_bit = false
    until last_bit
      if binary_string[0] == "0"
        last_bit = true
      end
      binary_string.shift
      binary_value += binary_string[...4].join
      binary_string.shift(4)
    end

  else
    if binary_string[0] == "0"
      binary_string.shift
      p 0
      total_length_of_subpackets = binary_string[...15].join.to_i(2)
      binary_string.shift(15)
      prime_length = binary_string.length
      while prime_length - total_length_of_subpackets > binary_string.length
        process_package(binary_string)
      end
    else
      binary_string.shift
      p 1
      number_of_contained_subpackets = binary_string[...11].join.to_i(2)
      binary_string.shift(11)
      processed_subpackets = 0
      while number_of_contained_subpackets > processed_subpackets
        process_package(binary_string)
        processed_subpackets += 1
      end
    end
  end
end

process_package(binary_string)
p $sum_of_versions
