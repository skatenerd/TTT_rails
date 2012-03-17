class CreateGameRecords < ActiveRecord::Migration
  def change
    create_table :game_records do |t|
      t.integer :max_depth
      t.string :first_player
      t.string :winner

      t.timestamps
    end
  end
end
