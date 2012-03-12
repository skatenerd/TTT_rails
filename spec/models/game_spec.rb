describe "basics" do

  it "can create it with no arguments" do
    game=Game.new(nil,nil)
    game.should_not be_nil
    game.game_record.should_not be_nil
  end

  it "can create it with a gamerecord id" do
    game_record=GameRecord.new()
    game_record.save()
    game=Game.new(game_record.id,nil)
    game.game_record.should == game_record
  end

  it "can view associated moves" do
    game_record=GameRecord.new()
    game_record.save
    game_record.move_records.create(:row=>0,:col=>0,:player=>"x")
    game=Game.new(game_record,nil)
    game.move_records.count.should ==1
    game.move_records[0].row.should ==0
  end

  it "can add a move to a game" do
    game_record=GameRecord.new()
    game_record.save()
    game=Game.new(game_record,nil)
    game.add_move(0,0,:x)
    game.move_records.count.should ==1
    game.move_records.all[0].player.should =="x"
  end

  it "has a board vector accessor" do
    empty_game=Game.new(nil,nil)
    empty_game.board_vector.should ==[[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]

  end 

  it "can access board vector based on moves made" do
    game=Game.new(nil,nil)
    game.add_move(0,0,:x)
    game.add_move(0,1,:x)
    game.add_move(1,1,:o)
    game.board_vector.should ==[[:x,:x,nil],[nil,:o,nil],[nil,nil,nil]]
  end

  it "updates for round of human and cpu move" do
    game=Game.new(nil,nil)
    game.add_move(0,0,:x)
    game.add_move(1,1,:o)
    game.update_for_human_cpu_round([0,1],:x)
    game.board_vector.should ==[[:x,:x,:o],[nil,:o,nil],[nil,nil,nil]]
  end

  it "computes max depth based on difficulty" do
    Game.get_maxdepth(:easy).should ==2
    Game.get_maxdepth(:medium).should ==3
    Game.get_maxdepth(:unbeatable).should_not
  end

  it "knows the computer's win-loss record" do 
    in_progress_game=Game.new(nil,:easy)

    
    human_win_easy_game=Game.new(nil,:easy)
    human_win_easy_game.add_move(0,0,:x)
    human_win_easy_game.add_move(0,1,:x)
    human_win_easy_game.add_move(0,2,:x)
    
    human_win_medium_game=Game.new(nil,:medium)
    human_win_medium_game.add_move(0,0,:x)
    human_win_medium_game.add_move(0,1,:x)
    human_win_medium_game.add_move(0,2,:x)

    cpu_win_unbeatable_game=Game.new(nil,:unbeatable)
    cpu_win_unbeatable_game.add_move(0,0,:o)
    cpu_win_unbeatable_game.add_move(0,1,:o)
    cpu_win_unbeatable_game.add_move(0,2,:o)

    Game.stats[:easy][:tie_count].should ==1
    Game.stats[:easy][:human_wins].should ==1
    Game.stats[:easy][:cpu_wins].should ==0

    Game.stats[:medium][:tie_count].should ==0
    Game.stats[:medium][:human_wins].should ==1
    Game.stats[:medium][:cpu_wins].should ==0

    Game.stats[:unbeatable][:tie_count].should ==0
    Game.stats[:unbeatable][:human_wins].should ==0
    Game.stats[:unbeatable][:cpu_wins].should ==1
  end
  


end
