require 'spec_helper'

  describe "board helper functions" do
    it "should add to a board" do
      board_data=[[1,2,3],[1,2,3],[1,2,3]]
      board=Board.new(board_data)
      updated=board.updated([0,0],99)
      assert_equal(99,updated[0][0])
    end

    it "knows future boards" do
      board_data=[["X","O","O"],["X","O",nil],["X","O","O"]]
      board=Board.new(board_data)
      future_boards=board.future_boards("O")
      assert_equal(1,future_boards.count)
      assert_equal([["X","O","O"],["X","O","O"],["X","O","O"]],future_boards[[1,2]])
    end

    #it "stringifies boards" do
      #board_data=[["X","O","O"],["X","O",nil],["X","O","O"]]
      #board=Board.new(board_data)
      #assertEqual(
    #end
  end

