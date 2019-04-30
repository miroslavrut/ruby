class Board
  def draw_board
    puts "========================="
    puts "-------------------------"
    puts "|\t|\t|\t|"
    puts "-------------------------"
    puts "|\t|\t|\t|"
    puts "-------------------------"
    puts "|\t|\t|\t|"
    puts "-------------------------"
    puts "========================="
  end

end

class Cell 
  attr_accessor :options
  options = {x: "X", o: "O", empty: ""}

end