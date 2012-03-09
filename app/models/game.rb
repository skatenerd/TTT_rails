require 'net/http'
class Game
  attr_accessor :game_record

  def initialize(game_record_id,difficulty)
    maxdepth=get_maxdepth difficulty
    if game_record_id
      @game_record=GameRecord.find(game_record_id)
    else
      @game_record||=GameRecord.new(:max_depth=>maxdepth)
      @game_record.save
    end
  end

  def get_maxdepth(difficulty)
    if difficulty==:easy
      2
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
