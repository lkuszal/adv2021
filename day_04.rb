class BingoBoard
  def initialize(list)
    @values = list
    @size = Integer.sqrt(@values.length)
  end

  def bingo?
    nils_in_columns = Array.new(@size, 0)
    @values.each_slice(@size).each do |row|
      row.each_with_index do |value, index|
        unless value then nils_in_columns[index] += 1 end
      if row.count(nil) == @size then return true end
      end
    end
    if nils_in_columns.include? @size then return true end
    false
  end

  def mark_value(value)
    @values.map! { |x| x == value ? nil : x }
    if bingo?
      puts score(value)
      exit
    end
  end

  def mark_value2(value)
    @values.map! { |x| x == value ? nil : x }
    if bingo?
      score(value)
    else
      false
    end
  end

  def score(last_value)
    score = 0
    @values.each do |value|
      score += value.to_i
    end
    score * last_value.to_i
  end
end

input = File.open 'input4.txt'
input_text = input.read
input_text_split = input_text.split("\n\n")
numbers_list = input_text_split[0].split(",")
boards_list = []
input_text_split[1..].each do |text_board|
  board = []
  text_board.split("\n").each do |text_row|
    board.push *text_row.split
  end
  boards_list.push(BingoBoard.new(board))
end
boards_list1 = boards_list.map(&:clone)
boards_list2 = boards_list.map(&:clone)
# part 1
'''
numbers_list.each do |value|
  boards_list1.map {|board| board.mark_value(value)}
end
'''
# part 2
numbers_list.each do |value|
  boards_list2.each_with_index do |board, index|
    score = board.mark_value2(value)
    if score
      if boards_list2.count(nil) + 1 == boards_list2.count
        puts score
        exit
      else
        boards_list2[index] = nil
      end
    end
  end
  boards_list2 = boards_list2.compact
end
