class Game
  attr_accessor :game_record

  def self.create_from_id(game_record_id)
    game=Game.new()
    game.game_record=GameRecord.find(game_record_id)
    game
  end

  def self.create_new(difficulty,first_player)
    maxdepth=Game.get_maxdepth difficulty
    
    game=Game.new()
    game.game_record=GameRecord.new(:max_depth=>maxdepth,:first_player=>first_player.to_s)
    game.game_record.save
    
    if first_player == :cpu
      game.add_cpu_move
    end  
  
    game
  end

  def self.get_maxdepth(difficulty)
    if difficulty==:easy
      2
    elsif difficulty==:medium
      3
    end
  end

  def move_records
    @game_record.move_records
  end

  def id
    @game_record.id
  end

  def maxdepth
    @game_record.max_depth
  end

  def first_player
    @game_record.first_player.intern
  end

  def add_move(row,col,player=current_player)
    move_count=move_records.count
    @game_record.move_records.create(:row=>row,:col=>col,:player=>player.to_s,:move_index=> move_count)
  end


  def current_player()
    last_move=move_records.find(:all,:order=>"move_index ASC").last
    if last_move
      Game.other_player(last_move.player.intern)
    else
      :x
    end
  end

  def self.other_player(player)
    if player==:x
      :o
    elsif player==:o
      :x
    end
  end

  def board_object
    board=Board.new()
    move_records.each do |move_record|
      board.update([move_record.row,move_record.col],move_record.player.intern)
    end
    board
  end

  def board_vector
    board_object.board_vector
  end

  def winner()
    winner=board_object.get_winner
    if winner
      winner.intern
    end
  end

  def player_code(player)
    if first_player==player
      :x
    else
      :o
    end
  end


  def winning_player()
    if winner==player_code(:human)
      :human
    elsif winner==player_code(:cpu)
      :cpu
    end
  end

  def self.player_win_count(difficulty,player)
    wins=Game.player_wins(difficulty,player)
    wins.count
  end

  def self.player_wins(difficulty,player)
    maxdepth=get_maxdepth(difficulty)
    GameRecord.all.find_all{|r|
      game=Game.create_from_id(r.id)
      r.max_depth==maxdepth and game.winning_player==player}
  end

  def self.stats()
    stats=Hash.new()
    stats[:easy]=stats_for_difficulty(:easy)
    stats[:unbeatable]=stats_for_difficulty(:unbeatable)
    stats[:medium]=stats_for_difficulty(:medium)
    stats
  end

  def self.detailed_stats()
    stats=Hash.new()
    stats[:easy]=detailed_stats_for_difficulty(:easy)
    stats[:medium]=detailed_stats_for_difficulty(:medium)
    stats[:unbeatable]=detailed_stats_for_difficulty(:unbeatable)
    stats
  end

  def self.stats_for_difficulty(difficulty)
    stats=Hash.new
    stats[:cpu_wins]=player_win_count(difficulty,:cpu)
    stats[:human_wins]=player_win_count(difficulty,:human)
    stats[:tie_count]=player_win_count(difficulty,nil)
    stats
  end

  def self.detailed_stats_for_difficulty(difficulty)
    stats=Hash.new
    stats[:cpu_wins]=get_winning_boards(difficulty,:cpu)
    stats[:human_wins]=get_winning_boards(difficulty,:human)
    stats
  end

  def self.get_winning_boards(difficulty,player)
    player_wins(difficulty,player).map{|record| Game.create_from_id(record.id).board_object.printable_string}
  end
  

  def update_for_human_cpu_round(coordinates)
    if coordinates and coordinates.length==2
      row=coordinates[0]
      col=coordinates[1]
      add_move(row,col)
      add_cpu_move
    end
  end

  def add_cpu_move
    cpu_move=board_object.get_cpu_move(current_player,maxdepth)
    if cpu_move
      add_move(cpu_move[0],cpu_move[1])
    end
  end

end
