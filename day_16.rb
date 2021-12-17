input = File.open 'input16.txt'
input_text = input.read.split("")
$binary_string = []
input_text.each do |hex_char|
  $binary_string.push(*('0000' + hex_char.to_i(16).to_s(2))[-4..].split(""))
end
$sum_of_versions = 0
def process_package
  version = $binary_string.shift(3).join.to_i(2)
  $sum_of_versions += version
  type_id = $binary_string.shift(3).join.to_i(2)
  if type_id == 4
    binary_value = ''
    last_bit = false
    until last_bit
      if $binary_string.shift == "0"
        last_bit = true
      end
      binary_value += $binary_string.shift(4).join
    end
    p binary_value.to_i(2)
  else
    if $binary_string.shift == "0"
      total_length_of_subpackets = $binary_string.shift(15).join.to_i(2)
      prime_length = $binary_string.length
      while prime_length - $binary_string.length < total_length_of_subpackets
        process_package
      end
    else
      number_of_contained_subpackets = $binary_string.shift(11).join.to_i(2)
      processed_subpackets = 0
      while number_of_contained_subpackets > processed_subpackets
        process_package
        processed_subpackets += 1
      end
    end
  end
end

process_package
p $sum_of_versions
