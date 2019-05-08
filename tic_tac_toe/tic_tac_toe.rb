class Game
  attr_accessor :grid
  
  def initialize
    @player1 = nil
    @player2 = nil
    @current_player = nil
    @other_player = nil
    @grid = Board.new
    
    create_players
    play
  end

  def valid_move(move)
    valid_input(move) && free_space(move)
  end

  def valid_input(input)
    input.to_i.between?(1,9)
  end

  def free_space(input)
    x, y = move_to_coordinate(input)
    !grid.cell_taken(x, y)
  end



  private

  def play
    first_to_play
    alocate_tokens
    play_turn until grid.game_over
    puts "#{@current_player.name} won!" if grid.game_over == :winner
    puts "draw!" if grid.game_over == :draw
    puts "\n Play again? (Y/N)"
    play if play_again
  end

  def play_turn
    puts "\n#{@current_player.name} turn!"
    place_token
    update_board
    switch_players if !grid.game_over
  end

  def play_again
    input = gets.chomp.upcase
    if input == "Y"
      @grid = Board.new
      return true
    elsif input == "N"
      return false
    end
  end

  def place_token
    puts "Where you want to put #{@current_player.token}: "
    move = gets.chomp
    if valid_move(move)
    x, y = move_to_coordinate(move)
    grid.set_cell(x,y,@current_player.token)
    else place_token
    end

  end

  def create_players
    puts "Player 1 name: "
    @player1 = Player.new(gets.chomp)
    puts "Player 2 name: "
    @player2 = Player.new(gets.chomp)
  end

  def first_to_play
    if rand(0..1) == 1
      @current_player = @player1
      @other_player = @player2
    else
      @current_player = @player2
      @other_player = @player1
    end
  end     

  def alocate_tokens
    @current_player.token = "x"
    @other_player.token = "o"
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end


  def update_board
    grid.display
  end

  def move_to_coordinate(move)
    mapping = {
      "1" => [0,0],
      "2" => [0,1],
      "3" => [0,2],
      "4" => [1,0],
      "5" => [1,1],
      "6" => [1,2],
      "7" => [2,0],
      "8" => [2,1],
      "9" => [2,2]
    }
    mapping[move]
  end
end

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

  private 

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

class Player
  attr_reader :name
  attr_accessor :token
  def initialize(name)
    @name = name
    @token = nil
  end
end

Game.new
