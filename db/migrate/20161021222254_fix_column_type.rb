class FixColumnType < ActiveRecord::Migration
  def change
    change_column :sessions, :sessionLength, :integer
  end
end
