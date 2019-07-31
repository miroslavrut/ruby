require './lib/game'

describe Game do
  # subject(:game) { Game.new}

  game = Game.new

  describe "#create_players" do
    it "Takes names and create 2 players" do
      expect(game.player1.name).not_to be_nil
      expect(game.player2.name).not_to be_nil
    end

    it "sets tokes to nil before allocation" do
      expect(game.player1.token).to be_nil
      expect(game.player2.token).to be_nil
    end
  end

  describe "#first_to_play" do
    it "randomly decides first player" do
      game.first_to_play
      expect(game.current_player).not_to eql(game.other_player)
    end
  end

  describe "#alocate_tokens" do
    it "sets current player to x, and other to o" do
      game.alocate_tokens
      expect(game.current_player.token).to eql("x")
      expect(game.other_player.token).to eql("o")
    end
  end

  describe "#valid_input?" do
    it "returns true if input converted to integer is 1-9" do
      expect(game.valid_input?("4")).to be true
    end
  end


  describe "#game_over" do
    it "test first row" do
      grid = game.grid
      grid.set_cell(0,0,"x")
      grid.set_cell(0,1,"x")
      grid.set_cell(0,2,"x")
      expect(grid.winner?).to be true
    end

    it "test second row" do
      grid = game.grid
      grid.set_cell(1,0,"x")
      grid.set_cell(1,1,"x")
      grid.set_cell(1,2,"x")
      expect(grid.winner?).to be true
    end

    it "test third row" do
      grid = game.grid
      grid.set_cell(2,0,"x")
      grid.set_cell(2,1,"x")
      grid.set_cell(2,2,"x")
      expect(grid.winner?).to be true
    end

    it "test first column" do
      grid = game.grid
      grid.set_cell(0,0,"x")
      grid.set_cell(0,0,"x")
      grid.set_cell(0,0,"x")
      expect(grid.winner?).to be true
    end

    it "test second column" do
      grid = game.grid
      grid.set_cell(0,0,"x")
      grid.set_cell(1,0,"x")
      grid.set_cell(2,0,"x")
      expect(grid.winner?).to be true
    end

    it "test third column" do
      grid = game.grid
      grid.set_cell(0,1,"x")
      grid.set_cell(1,1,"x")
      grid.set_cell(2,1,"x")
      expect(grid.winner?).to be true
    end
  end
end

  



