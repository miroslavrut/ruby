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
    display
    puts self.game[:secret_word]
    until game_end
      play_round
      display
    end
    game_end_type
    play_again
  end

  def play_round
    puts "Enter 1 to solve whole word, 2 to save, or choose letter to guess"
    player_input = gets.chomp
    case player_input
    when "1"
      compare_word
    when "2"
      #save
    else 
      play_round if !valid_letter(player_input)
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
    self.game[:misses] = game[:missed_letters].length + game[:missed_words].length
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
    elsif game[:missed_letters].include?(input) ||
          game[:display].include?(input)
      puts "You already guessed that letter"
      return false
    end
    true
  end

  def game_end
    return :won if won?
    return :hanged if hanged?
    return false
  end

  def won?
    self.game[:display] == self.game[:secret_word_chars]
  end

  def hanged?
    self.game[:misses] == 7
  end

  def game_end_type
    case game_end
    when :won
      puts "You won\n"
    when :hanged
      puts "Game ovarrr\n"
    else 
      puts "idk"
    end
  end

  def display
    puts `clear`
    puts IMAGES[self.game[:misses]]
    puts self.game[:display].join(" ")
    print "\nmissed letters: ["
    puts "#{self.game[:missed_letters].join(" ")}]\n"
    puts "missed words: [#{game[:missed_words].join(" ")}]"
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