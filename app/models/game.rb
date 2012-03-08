require 'net/http'
class Game
  attr_accessor :game_record

  def initialize(game_record)
    @game_record=game_record
    @game_record||=GameRecord.new()
    @game_record.save
  end

  def move_records
    @game_record.move_records
  end

  def add_move(row,col,player)
    @game_record.move_records.create(:row=>row,:col=>col,:player=>player)
  end


end
