require 'spec_helper'

describe "basics" do

  it "can create it with no arguments" do
    board=Board.new()
    board.should_not be_nil
    board.board_vector.should_not be_nil
  end

  it "has a board vector accessor" do
    empty_board=Board.new()
    empty_board.board_vector.should_not be_nil
    empty_board.board_vector.should ==[[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
  end 

  it "should add to a board" do
    board=Board.new()
    board.update([0,0],:z)
    board.board_vector[0][0].should ==:z
    board.board_vector.flatten.count.should ==9
  end

  it "gets the cpu move" do
    board=Board.new()
    board.board_vector=[[:x,:x,nil],[nil,:o,nil],[nil,nil,nil]]
    assert_equal([0,2],board.get_cpu_move("o"))
  end
end

#
  #it "gets the winner" do
    #won_board_record=BoardRecord.new(:board=>"xoo x   x")
    #won_board=Board.new(won_board_record)
    #won_board.get_winner().should =="x"
#
    #in_progress_board_record=BoardRecord.new(:board=>"xoo x    ")
    #in_progress_board=Board.new(in_progress_board_record)
    #in_progress_board.get_winner.should ==nil
#
    #tie_board_record=BoardRecord.new(:board=>"xoooxxxoo")
    #tie_board=Board.new(tie_board_record)
    #tie_board.get_winner.should =="TIE"
#
  #end
#
#
  #it "updates when the cpu doesn't want to move" do
    #board_record=BoardRecord.new(:board =>"xx oo    ")
    #board=Board.new(board_record)
    #board.update_for_human_cpu_round([0,2])
    #board.board_vector.should ==[[:x,:x,:x],[:o,:o,nil],[nil,nil,nil]]
  #end
