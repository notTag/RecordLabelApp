class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :bandName
      t.date :sessionDate
      t.time :sessionTime
      t.integer :sessionLength
      t.text :comments

      t.timestamps null: false
    end
  end
end
