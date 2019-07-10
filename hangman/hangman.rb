module TextAndImages
  IMAGES = [
    '
      *---*
      |   |
      |    
      |    
      |    
      |   
    =============', '
      *---*
      |   |
      |   O
      |
      |
      |
    ==============','
      *---*
      |   |
      |   O 
      |   | 
      |    
      |   
    =============', '
      *---*
      |   |
      |   O 
      |  /| 
      |    
      |   
    =============', '
      *---*
      |   | 
      |   O 
      |  /|\ 
      |     
      |      
    =============', '
      *---* 
      |   | 
      |   O 
      |  /|\ 
      |  /  
      |      
    =============', '
      *---* 
      |   | 
      |   O  
      |  /|\ 
      |  / \ 
      |   
    =============']  

  
end 

class Hangman
  def initialize
    menu
    game_mode
  end
end

class Game
  include TextAndImages
  attr_accessor :game

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

  def new_game

    fill_info
    play
  end

  def play
    until game_end
      play_round
      display
    end
    puts "You won" if game_end == :won
    puts "out of turns" if game_end == :turns
    play_again
  end

  def play_round
    puts self.game[:secret_word]
    puts "Enter 1 to solve whole word, 2 to save, or choose letter to guess"
    player_input = gets.chomp
    case player_input
    when "1"
      puts "Enter your word guess"
      player_input = gets.chomp.downcase
      until player_input.match?(/[a-z]/)
        puts "use just letters plz"
        player_input = gets.chomp.downcase
      end
      if game[:secret_word] == player_input
        self.game[:display] = player_input.split("")
        puts "You won!!!"
        menu
      else 
        puts "Nope, thats not the word"
      end
    when "2"
      #save
    else 
      if player_input.length > 1 || ! (/[a-z]/ === player_input)
        puts "just one letter: "
        player_input = gets.chomp.downcase
      end
      if self.game[:secret_word].include?(player_input)
        self.game[:secret_word_chars].each_with_index do |char, i|
          if char == player_input
            self.game[:display][i] = char
          end
        end
      else
        self.game[:uncorrect_guesses] << player_input
      end 
    end

  end

  def game_end
    return :won if won?
    return :hanged if hanged?
    return :turns if out_of_turns?
    return false
  end

  def out_of_turns?
    return true if self.game[:turns] == 0
    self.game[:turns] -= 1
    false
  end

  def won?
    self.game[:display] == self.game[:secret_word_chars]
  end

  def hanged?
    self.game[:uncorrect_guesses].length == 7
  end

  def display
    puts IMAGES[self.game[:uncorrect_guesses].length]

    puts self.game[:display].join(" ")
    puts "uncorrect letters"
    puts self.game[:uncorrect_guesses].join(" ")
  end

  def save_game

  end

  def load_game

  end

  # game params
  def fill_info
    secret_word = read_from_file.sample
    secret_word_chars = secret_word.split("")
    display = secret_word_chars.map {|x| x = "_"}
    uncorrect_guesses = Array.new
    turns = 12

    self.game = {
      secret_word: secret_word,
      secret_word_chars: secret_word_chars,
      display: display,
      uncorrect_guesses: uncorrect_guesses,
      turns: turns
    }
  end


  def read_from_file
    words = Array.new
    File.open('5desk.txt', 'r') do |f|
      f.each_line do |line|
        line.gsub!(/[^a-zA-Z]/,"")
        if line.length >= 5 && line.length <= 12
          words << line.downcase
        end
      end
    end
    words
  end

  def play_again

  end


  def menu
    puts "***************"
    puts "    Hangman"
    puts "***************"
    sleep(0.2)
    puts "Menu: \n"
    puts "    1- new game"
    puts "    2- load\n"
    game_mode
  end

end

