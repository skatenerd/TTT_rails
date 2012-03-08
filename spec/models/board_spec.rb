require 'spec_helper'

describe "basics" do
  it "can create it with no arguments" do
    board=Board.new(nil)
    board.should_not be_nil
    board.board_record.should_not be_nil
  end

  it "can create it with a boardrecord" do
    board_record=BoardRecord.new(:board =>"xx  o    ")
    board=Board.new(board_record)
    board.board_record.should ==board_record

  end

  it "has a board vector accessor" do
    empty_board=Board.new(nil)
    empty_board.board_vector.should_not be_nil
    empty_board.board_vector.should ==[[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]

    board=Board.new(BoardRecord.new(:board =>"xx  o    "))
    board.board_vector.should ==[[:x,:x,nil],[nil,:o,nil],[nil,nil,nil]]
  end 

  it "should add to a board" do
    board=Board.new(nil)
    board.update([0,0],:z)
    board.board_vector[0][0].should ==:z
    board.board_vector.flatten.count.should ==9
  end

  it "gets the cpu move" do
    board_record=BoardRecord.new(:board =>"xx  o    ")
    board=Board.new(board_record)
    assert_equal([0,2],board.get_cpu_move("o"))
  end

  it "gets the winner" do
    won_board_record=BoardRecord.new(:board=>"xoo x   x")
    won_board=Board.new(won_board_record)
    won_board.get_winner().should =="x"

    in_progress_board_record=BoardRecord.new(:board=>"xoo x    ")
    in_progress_board=Board.new(in_progress_board_record)
    in_progress_board.get_winner.should ==nil

    tie_board_record=BoardRecord.new(:board=>"xoooxxxoo")
    tie_board=Board.new(tie_board_record)
    tie_board.get_winner.should =="TIE"

  end

  it "updates for round of human and cpu move" do
    board_record=BoardRecord.new(:board =>"x   o    ")
    board=Board.new(board_record)
    board.update_for_human_cpu_round([0,1])
    board.board_vector.should ==[[:x,:x,:o],[nil,:o,nil],[nil,nil,nil]]
  end

  it "updates when the cpu doesn't want to move" do
    board_record=BoardRecord.new(:board =>"xx oo    ")
    board=Board.new(board_record)
    board.update_for_human_cpu_round([0,2])
    board.board_vector.should ==[[:x,:x,:x],[:o,:o,nil],[nil,nil,nil]]
  end


end
#
    #it "no boards for guaranteed tie" do
      #board_data=[["X","O","O"],["X","O","*"],["X","O","O"]]
      #board=Board.new(board_data)
      #future_boards=board.future_boards("X")
      #assert_equal(0,future_boards.count)
    #end
#
    #it "knows future boards" do
      #board_data=[["X","*","*"],["*","O","*"],["*","*","*"]]
      #result_data=[["X","X","O"],["*","O","*"],["*","*","*"]]
      #board=Board.new(board_data)
      #future_boards=board.future_boards("X")
      #assert_equal(result_data,future_boards[[0,1]])
    #end
#
    #it "builds postdata" do
      #board_data=[["X","*","*"],["*","O","*"],["*","*","*"]]
      #assert_equal("x   o    ",Board.postdata_string(board_data).downcase)
    #end
#
    #it "clones boards" do
#
    #end
#
  #end

