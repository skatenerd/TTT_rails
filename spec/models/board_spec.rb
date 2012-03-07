require 'spec_helper'

  describe "board helper functions" do
    it "should add to a board" do
      board_data=[[1,2,3],[1,2,3],[1,2,3]]
      board=Board.new(board_data)
      updated=board.updated([0,0],99)
      assert_equal(99,updated[0][0])
    end

    it "no boards for guaranteed tie" do
      board_data=[["X","O","O"],["X","O","*"],["X","O","O"]]
      board=Board.new(board_data)
      future_boards=board.future_boards("X")
      assert_equal(0,future_boards.count)
    end

    it "knows future boards" do
      board_data=[["X","*","*"],["*","O","*"],["*","*","*"]]
      result_data=[["X","X","O"],["*","O","*"],["*","*","*"]]
      board=Board.new(board_data)
      future_boards=board.future_boards("X")
      assert_equal(result_data,future_boards[[0,1]])
    end

    it "builds postdata" do
      board_data=[["X","*","*"],["*","O","*"],["*","*","*"]]
      assert_equal("x   o    ",Board.postdata_string(board_data).downcase)
    end

    it "clones boards" do

    end

    it "gets the cpu move" do
      board_data=[["X","X","*"],["*","O","*"],["*","*","*"]]
      board=Board.new(board_data)
      assert_equal([0,2],board.get_cpu_move("O"))
    end

  end

