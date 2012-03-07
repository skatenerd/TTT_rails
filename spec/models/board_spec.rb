require 'spec_helper'

describe "basics" do
  it "can create it with no arguments" do
    board=Board.new()
    board.should_not be_nil
    board.board_record.should_not be_nil
  end

  it "can create it with a boardrecord" do
    board_record=BoardRecord.new(:board =>"xx  o    ")
    board=Board.new(board_record)
    board.board_record.should ==board_record

  end

  it "has a board vector accessor" do
    empty_board=Board.new()
    empty_board.board_vector.should_not be_nil
    empty_board.board_vector.should ==[[" "," "," "],[" "," "," "],[" "," "," "]]

    board=Board.new(BoardRecord.new(:board =>"xx  o    "))
    board.board_vector.should ==[["x","x"," "],[" ","o"," "],[" "," "," "]]
  end 

  describe "board helper functions" do
    it "should add to a board" do
      board=Board.new()
      board.update([0,0],"z")
      board.board_vector[0][0].should =="z"
    end
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
    #it "gets the cpu move" do
      #board_data=[["X","X","*"],["*","O","*"],["*","*","*"]]
      #board=Board.new(board_data)
      #assert_equal([0,2],board.get_cpu_move("O"))
    #end
  #end

