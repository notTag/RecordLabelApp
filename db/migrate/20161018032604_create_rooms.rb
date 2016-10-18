class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.string :openHour
      t.string :closeHour

      t.timestamps null: false
    end
  end
end
