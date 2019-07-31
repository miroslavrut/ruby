class Board
  attr_accessor :cells
  def initialize 
    @cells = default_grid
    display
  end
  
  def get_cell(x,y)
    cells[x][y]
  end

  def set_cell(x,y,value)
    cells[x][y] = value
  end

  def cell_taken(x,y)
    get_cell(x, y) != " "
  end

  def display
    puts 
    puts " #{@cells[0][0]} | #{@cells[0][1]} | #{@cells[0][2]} "
    puts "--- --- ---"
    puts " #{@cells[1][0]} | #{@cells[1][1]} | #{@cells[1][2]} "
    puts "--- --- ---"
    puts " #{@cells[2][0]} | #{@cells[2][1]} | #{@cells[2][2]} "
    puts 
  end

  def game_end?
    draw? || winner?
  end

  def game_over
    return :winner if winner?
    return :draw if draw?
    false
  end

  # private 

  def default_grid
    Array.new(3) { Array.new(3) {" "}}
  end

  def winner?
    winning_positions.each do |arr|
      return true if arr.all? {|cell| cell == "x" } ||
        arr.all? {|cell| cell == "o" }
    end
    false
  end

  def draw?
    cells.flatten.none? {|el| el==" "}
  end

  def winning_positions 
    cells +
    cells.transpose +
    diagonals
  end

  def diagonals
    [
      [get_cell(0, 0), get_cell(1, 1), get_cell(2, 2)],
      [get_cell(0, 2), get_cell(1, 1), get_cell(2, 0)]
    ]
  end
end
