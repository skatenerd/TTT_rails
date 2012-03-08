class CreateMoveRecords < ActiveRecord::Migration
  def change
    create_table :move_records do |t|
      t.integer :row
      t.integer :col
      t.string :player

      t.timestamps
    end
  end
end
