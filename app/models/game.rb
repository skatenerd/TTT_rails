require 'net/http'
class Game
  attr_accessor :game_record

  def initialize(game_record_id=nil)
    if game_record_id
      @game_record=GameRecord.find(game_record_id)
    else
      @game_record||=GameRecord.new()
      @game_record.save
    end
  end

  def move_records
    @game_record.move_records
  end

  def id
    @game_record.id
  end

  def add_move(row,col,player)
    @game_record.move_records.create(:row=>row,:col=>col,:player=>player)
  end

  def board_vector
    board=Board.new()
    move_records.each do |move_record|
      board.update([move_record.row,move_record.col],move_record.player.intern)
    end
    board.board_vector
  end


end
