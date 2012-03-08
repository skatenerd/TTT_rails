class GameRecord < ActiveRecord::Base
  has_many :move_records
end
