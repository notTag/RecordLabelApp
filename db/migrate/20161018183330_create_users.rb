class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :userType
      t.string :name
      t.string :contactNumber

      t.timestamps null: false
    end
  end

end
