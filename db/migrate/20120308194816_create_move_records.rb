class CreateMoveRecords < ActiveRecord::Migration
  def change
    create_table :move_records do |t|
      t.integer :row
      t.integer :col
      t.string :player
      t.integer :game_record_id
      t.integer :move_index

      t.timestamps
    end
  end
end
