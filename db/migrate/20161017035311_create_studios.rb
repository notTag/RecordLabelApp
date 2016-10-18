class CreateStudios < ActiveRecord::Migration
  def change
    create_table :studios do |t|
      t.string :studioName
      t.primary_key :studioId
      t.time :lunchHours
      t.integer :numberRooms

      t.timestamps null: false
    end
  end
end
