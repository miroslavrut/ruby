class Board
  # def self.draw_board
  #   puts "========================="
  #   puts "-------------------------"
  #   puts "|\t|\t|\t|"
  #   puts "-------------------------"
  #   puts "|\t|\t|\t|"
  #   puts "-------------------------"
  #   puts "|\t|\t|\t|"
  #   puts "-------------------------"
  #   puts "========================="
  # end

  attr_reader :grid

  def initialize(input = {})
    @grid = input.fetch(:grid, default_grid)
  end

  def get_cell(x, y)
    grid[y][x]
  end

  private
  def default_grid
    Array.new(3) {Array.new(3) {" "}}
  end
end

class Cell 
  def initialize(value = "")
    @value = value
  end
end

class Game
  def is_draw?
    @turn == 9
  end
end

class Player
  attr_reader :name
  attr_reader :marker

  def initialize(input)
    @name = input.fetch(:name)
    @marker = inut.fetch(:marker)
  end
end