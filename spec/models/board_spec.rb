require 'spec_helper'

  describe "board update" do
    it "should add to a board" do
      board_data=[[1,2,3],[1,2,3],[1,2,3]]
      board=Board.new(board_data)
      updated=board.updated([0,0],99)
      assert_equal(99,updated[0][0])
    end
  end
