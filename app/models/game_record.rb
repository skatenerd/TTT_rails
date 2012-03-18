class GameRecord < ActiveRecord::Base
  has_many :move_records


  def add_move(row,col,player)
    move_count=self.move_records.count
    self.move_records.create(:row=>row,:col=>col,:player=>player.to_s,:move_index=> move_count)
  end

  def set_outcome(outcome)
    update_attribute(:winner,outcome.to_s)
  end

  def sorted_move_records
    move_records.find(:all,:order=>"move_index ASC")
  end


end
