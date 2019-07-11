require './text_and_images.rb'
require 'yaml'

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
    play_game
  end

  def play_game
    play_round until game_end
    display
    game_end_type
    play_again
  end

  def play_round
    display
    puts "Enter 1 to solve whole word, 2 to save, or choose letter to guess"
    player_input = gets.chomp
    case player_input
    when "1"
      compare_word
    when "2"
      save_game
    else 
      until (valid_letter(player_input))
        player_input = gets.chomp
      end
      if self.game[:secret_word].include?(player_input)
        self.game[:secret_word_chars].each_with_index do |char, i|
          if char == player_input
            self.game[:display][i] = char
          end
        end
      else
        self.game[:missed_letters] << player_input
      end 
    end
    display
  end

  def compare_word
    puts "Enter your word guess"
    player_input = gets.chomp.downcase
    until valid_word(player_input)
      player_input = gets.chomp.downcase
    end
    if game[:secret_word] == player_input
      self.game[:display] = player_input.split("")
      game_end
      menu
    else 
      puts "Nope, thats not the word"
      self.game[:missed_words] << player_input
    end
  end

  def valid_word(input)
    if input.length != game[:secret_word].length
      puts "Care, wanted word have #{game[:secret_word].length} letters"
      return false
    elsif !input.match?(/[a-z]/)
      puts "Just letters plz"
      return false
    end
    true
  end

  def valid_letter(input)
    if input.length > 1 || !input.downcase.match?(/[a-z]/)
      puts "Enter one letter"
      return false
    elsif game[:missed_letters].include?(input) || game[:display].include?(input)   
      puts "You already guessed that letter"
      $stdout.flush 
      return false
    else
      return true
    end
  end

  def game_end
    return :hanged if hanged?
    return :won if won?
    return false
  end

  def won?
    self.game[:display] == self.game[:secret_word_chars]
  end

  def hanged?
    game[:misses] = game[:missed_letters].length + game[:missed_words].length
    self.game[:misses] == 7
  end

  def game_end_type
    case game_end
    when :won
      puts "You won!!\n"
    when :hanged
      puts "Game Over :(\n"
      puts "Secret word was #{game[:secret_word]}\n"
    else 
      puts "idk"
    end
  end

  def display
    puts `clear`
    puts IMAGES[self.game[:misses]]
    puts self.game[:display].join(" ")
    print "\nmissed letters: ["
    puts "#{self.game[:missed_letters].join(" ")}]\n\n"
    puts "missed words: [#{game[:missed_words].join(" ")}]\n\n"
  end

  def save_game
    Dir.mkdir 'save' unless Dir.exist?('save')
    puts 'Game save name?'
    save_name = "save/#{gets.chomp}.yml"
    File.open(save_name, 'w') { |file| file.write(self.game.to_yaml) }
    puts 'Game has been saved'
  end

  def load_game
    unless Dir.exist?('save')
      puts "No save file"
      sleep(0.6)
      game_mode
    end
    save_files = Dir.entries('save').join("\n")
    puts "Save files:"
    puts save_files
    puts "Which one you want to load? "
    file_name = "save/#{gets.chomp}.yml"
    unless File.exist?(file_name)
      puts "That save does not exist, pick another:" 
      file_name = "save/#{gets.chomp}.yml"
    end
    game_state = File.read(file_name)
    self.game = YAML::load(game_state)
    play_game
  end

  # game params
  def fill_info
    secret_word = read_from_file.sample
    secret_word_chars = secret_word.split("")
    display = secret_word_chars.map {|x| x = "_"}
    missed_letters = Array.new
    missed_words = Array.new
    misses = missed_letters.length + missed_words.length

    self.game = {
      secret_word: secret_word,
      secret_word_chars: secret_word_chars,
      display: display,
      missed_letters: missed_letters,
      missed_words: missed_words,
      misses: misses
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
    puts "\nWonna play again? (Y/N)"
    input = gets.chomp
    until input.match?(/[yYnN]/)
    input = gets.chomp
    end
    new_game if input.downcase == "y"
    game_mode if input.downcase == "n"
  end
end
Game.new