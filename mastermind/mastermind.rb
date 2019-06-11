module Messages

  def welcome_screen
    puts `clear`
    puts "*********************************"
    puts "*********************************"
    puts "**        MASTERMIND           **"
    puts "*********************************"
    puts "*********************************"
    sleep(3)
    puts `clear`
  end

  def clear
    puts `clear`
  end

  def menu
    puts "Main Menu: \n"
    puts "==========="
    puts "Press: 1- play as Code breaker"
    puts "       2- play as Code maker"
    puts "\n\n"
  end

  def code_breaker_welcome
    puts `clear`
    print "You selected to be Code Breaker"
    sleep(0.3)
    print "."
    sleep(0.3)
    print "."
    sleep(0.3)
    print ".\n\n"
  end

  def code_maker_welcome
    clear 
    print "You selected to be Code Maker"
    sleep(0.3)
    print "."
    sleep(0.3)
    print "."
    sleep(0.3)
    print "."
    puts "Enter your secret code that this dumbass ai will try to break: "
    puts ""
  end
end

class Player
  include Messages

  def initialize
    
    
  end

  def random_code
    Array.new(4) {rand(1..6)}
  end

  def get_code
    code = nil
    loop do
      code = gets.chomp.split("").map {|x| x.to_i}
      break if valid_input?(code)
      puts "Invalid input, enter 4 numbers"
    end
    code
  end

  def valid_input?(guess)
    guess.length == 4 && guess.all? {|num| num.between?(1,6)}
  end
end


class Ai < Player
  attr_accessor :guess, :correct_guess
  def initialize 
    @guess = Array.new(4)
    @correct_guess = Array.new(4)
  end

  def make_guess
    first_guess = random_code
    

  end 

 


end

class Game
  include Messages

  attr_accessor :turns, :guess, :secret_code, :player

  def initialize
    @player = nil
    @turns = 5
    welcome_screen
    game_mode
    play
  end

  def game_mode
    menu
    input = gets.chomp.to_i
    until input == 1 || input == 2
      puts "Wrong input, please select 1 or 2"
      input = gets.chomp.to_i
    end
    self.player = input == 1 ? Player.new : Ai.new
  end

  def play
    @player.class == Player ? play_codebreaker : play_codemaker
  end

  def play_codebreaker
    @secret_code = player.random_code
    code_breaker_welcome
    loop do
      puts "#{self.turns} guesses remamining."
      puts "Enter your guess: "
      @guess = player.get_code
      generate_feedback(self.guess)
      break if game_over?
    end
    play_codebreaker if play_again?
    game_mode
    play
  end

  def play_codemaker
    code_maker_welcome
    @secret_code = player.get_code

    correct_guess = Array.new(4)
    guess = player.random_code
    generate_feedback
  end

  def generate_feedback(guess)
    feedback = Array.new(4)
    guess.each_with_index do |val,index|
      if val == self.secret_code[index]
        feedback[index] = "O"
      elsif self.secret_code.include?(val)
        feedback[index] = "*" 
      else feedback[index] = "X"
      end
    end
    puts "\n"
    puts "#{guess[0]}|#{guess[1]}|#{guess[2]}|#{guess[3]}"
    puts "----------------------------------------------"
    puts "#{feedback[0]}|#{feedback[1]}|#{feedback[2]}|#{feedback[3]}"
    puts "\n"
  end
  
  def game_over?
    won? || out_of_turns?
  end

  def out_of_turns?
    self.turns -= 1
    if self.turns == 0
      puts "You are out of turns dumbass.."
      return true
    end
    false
  end

  def won?
    if (guess == secret_code)
      puts "You won"
      return true
    end
    false
  end

  def play_again?
    puts "Wonna play again? (y/n)"
    input = gets.chomp.upcase
    until input == "Y" || input == "N"
      puts "Wrong input, please enter Y or N"
      input = gets.chomp.upcase
    end
    if input == "Y"
      reset
      true
    else
      puts "Tnx for playing"
      sleep(1)
      reset
      clear
      false
    end
  end

  def reset
    self.turns = 5
    

  end

end




Game.new