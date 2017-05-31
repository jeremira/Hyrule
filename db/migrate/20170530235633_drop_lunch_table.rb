class DropLunchTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :lunches
  end
end
