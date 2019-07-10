module TextAndImages
  IMAGES = [
    '
      *---*
      |   
      |    
      |    
      | 
      |      
    =============', '
      *---*
      |   |
      |   
      |  
      |
      |
    ==============', '
      *---*
      |   |
      |   O
      |
      |
      |
    ==============', '
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
    =============',]  

  def menu
    system('clear')
    puts "***************"
    puts "    Hangman"
    puts "***************"
    sleep(0.4)
    puts "Menu: \n"
    sleep(0.15)
    puts "    1- new game"
    sleep(0.15)
    puts "    2- load"
    sleep(0.15)
    puts "    3- exit\n"
  end
  
end 

class Game
  include TextAndImages
  attr_accessor :game

  def initialize
    game_mode
  end

  def game_mode
    menu
    input = nil
    loop do
      input = gets.chomp
      break if input.match?(/[123]/)
      puts "Please select game mode, "
      puts "1 for new game, 2 for load, 3 for exit"
    end
    case input
    when "1" 
      new_game
    when "2"
      load_game
    else
      puts "Byeee"
      sleep(0.2)
      exit
    end
  end

  def new_game
    puts `clear`
    fill_info
    display
    play
  end

  def play
    until game_end
      play_round
      display
    end
    game_end_type
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
      end 
    end

  end

  

  def valid_letter(input)
      
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

  def game_end_type
    case game_end
    when :won
      puts "You won"
    when :hanged
      puts "Game ovarrr"
    when "turns"
      puts "Out of turns :("
    else 
      puts "idk"
    end
    puts "\n" 
  end

  def display
    puts `clear`
    puts IMAGES[self.game[:uncorrect_guesses].length]
    puts self.game[:display].join(" ")
    print "\nuncorrect letters: ["
    puts "#{self.game[:uncorrect_guesses].join(" ")}]\n"
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
    input = nil
    puts "Wonna play again? (Y/N)"
    input = gets.chomp
    until input.match?(/[yYnN]/)
    input = gets.chomp
    end
    new_game if input.downcase == "y"
    game_mode if input.downcase == "n"
  end




end

Game.new