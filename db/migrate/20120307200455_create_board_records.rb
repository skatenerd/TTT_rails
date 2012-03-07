class CreateBoardRecords < ActiveRecord::Migration
  def change
    create_table :board_records do |t|
      t.string :board

      t.timestamps
    end
  end
end
