class Hangman
  def initialize
    menu

  end
end

class Game

  def game_mode
    input = nil
    loop do
      input = gets.chomp.to_i
      break if input == 1 || input == 2
      puts "Please select game mode, "
      puts "1 for new game, 2 for load"
    end
    input == 1 ? new_game : load_game
  end

  def play

    until game_end?
      play_round
      display
    end
  end

  def play_round

  end

  def game_end?

  end

  def display

  end

  def save_game

  end

  def load_game

  end
end

class Player

end