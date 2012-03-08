describe "basics" do

  it "can create it with no arguments" do
    game=Game.new(nil)
    game.should_not be_nil
    game.game_record.should_not be_nil
  end

  it "can create it with a gamerecord" do
    game_record=GameRecord.new()
    game=Game.new(game_record)
    game.game_record.should equal game_record
  end

  it "can view associated moves" do
    game_record=GameRecord.new()
    game_record.save
    game_record.move_records.create(:row=>0,:col=>0,:player=>"x")
    game=Game.new(game_record)
    game.move_records.count.should ==1
    game.move_records[0].row.should ==0
  end

  it "can add a move to a game" do
    game_record=GameRecord.new()
    game=Game.new(game_record)
    game.add_move(0,0,:x)
    game.move_records.count.should ==1
    game.move_records.all[0].player.should =="x"
  end

  it "has a board vector accessor" do
    empty_game=Game.new(nil)
    empty_game.board_vector.should ==[[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]

  end 

  it "can access board vector based on moves made" do

    game=Game.new(nil)
    game.add_move(0,0,:x)
    game.add_move(0,1,:x)
    game.add_move(1,1,:o)
    board.board_vector.should ==[[:x,:x,nil],[nil,:o,nil],[nil,nil,nil]]
  end

end
