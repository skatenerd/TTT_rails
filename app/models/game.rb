class Game
  attr_accessor :game_record

  def self.create_from_id(game_record_id)
    game=Game.new()
    game.game_record=GameRecord.find(game_record_id)
    game
  end

  def self.create_new(difficulty)
    maxdepth=Game.get_maxdepth difficulty
    
    game=Game.new()
    game.game_record=GameRecord.new(:max_depth=>maxdepth)
    game.game_record.save
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

  def add_move(row,col,player)
    @game_record.move_records.create(:row=>row,:col=>col,:player=>player)
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

  def self.player_win_count(difficulty,player)
    maxdepth=get_maxdepth(difficulty)
    wins=GameRecord.all.find_all{|r|
      game=Game.create_from_id(r.id)
      r.max_depth==maxdepth and game.winner==player}
    wins.count
  end

  def self.stats()
    stats=Hash.new()
    stats[:easy]=stats_for_difficulty(:easy)
    stats[:unbeatable]=stats_for_difficulty(:unbeatable)
    stats[:medium]=stats_for_difficulty(:medium)
    stats
  end

  def self.stats_for_difficulty(difficulty)
    stats=Hash.new
    stats[:cpu_wins]=player_win_count(difficulty,:o)
    stats[:human_wins]=player_win_count(difficulty,:x)
    stats[:tie_count]=player_win_count(difficulty,nil)
    stats
  end
  

  def update_for_human_cpu_round(coordinates,player)
    if coordinates and coordinates.length==2
      row=coordinates[0]
      col=coordinates[1]
      add_move(row,col,player.to_s)
      other_player=Game.other_player(player)
      cpu_move=board_object.get_cpu_move(other_player,maxdepth)
      if cpu_move
        add_move(cpu_move[0],cpu_move[1],other_player.to_s)
      end
    end
  end

end
