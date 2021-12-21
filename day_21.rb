=begin
class DeterministicDice
  attr_reader :dice_rolls
  def initialize
    @dice_values = (1..100).to_a
    @dice_rolls = 0
  end

  def roll_three
    result = 0
    3.times do
      result += self.roll
    end
    result
  end

  def roll
    @dice_rolls += 1
    @dice_values.rotate![-1]
  end
end

class Game
  def initialize(initial_positions, dice)
    @players_positions = initial_positions
    @number_of_players = @players_positions.length
    @players_scores = [0] * @number_of_players
    @dice = dice
    @player_turn = 0
  end

  def play_game
    until self.win?
      landed_position = (@players_positions[@player_turn] + @dice.roll_three) % 10
      if landed_position == 0 then landed_position = 10 end
      @players_positions[@player_turn] = landed_position
      @players_scores[@player_turn] += landed_position
      @player_turn = (@player_turn + 1) % @number_of_players
    end
    p @dice.dice_rolls
    p @players_scores
    @dice.dice_rolls * @players_scores.min
  end

  def win?
    @players_scores.any? {|x| x>=1000}
  end
end

part_1_dice = DeterministicDice.new()
part_1_game = Game.new([5,10], part_1_dice)
p part_1_game.play_game
=end

class QuantumRolls
  def initialize(position)
    @starting_position = position
    @possible_rolls = []
    @ended_rolls = {}
    21.times do |x|
      @ended_rolls[x] = 0
    end
  end

  def first_roll
    (1..3).each do |x|
      score = (@starting_position + x) % 10
      if score == 0 then score = 10 end
      @possible_rolls.push([score, score, 1])
    end
  end

  def roll
    new_possible_rolls = []
    @possible_rolls.each do |option|
      (1..3).each do |x|
        score = (option[1] + x) % 10
        if score == 0 then score = 10 end
        new_score = option[0] + score
        if new_score >= 21
          @ended_rolls[option[2]+1] += 1
        else
          new_possible_rolls.push [new_score, score, option[2]+1]
        end
      end
    end
    @possible_rolls = new_possible_rolls
  end

  def play
    self.first_roll
    until @possible_rolls.length == 0
      self.roll
    end
    @ended_rolls
  end
end



player_1_games = QuantumRolls.new(4)
player_2_games = QuantumRolls.new(8)
player_1_options = player_1_games.play
player_2_options = player_2_games.play
player_1_wins = 0
player_2_wins = 0
player_1_options.each do |key_1, value_1|
  player_2_options.each do |key_2, value_2|
    sum_of_loses = 0
    if key_1 <= key_2
      player_2_options.map { |key, value| if key<key_1 then sum_of_loses += (value * 3 * (key_1-key_2).abs) end }
      player_1_wins += 3**key_1 - sum_of_loses
    else
      player_1_options.map { |key, value| if key<key_2 then sum_of_loses += (value * 3 * (key_1-key_2).abs) end }
      player_2_wins += 3**key_2 - sum_of_loses
    end
  end
end

p player_1_wins
p player_2_wins
p [player_1_wins,player_2_wins].max
