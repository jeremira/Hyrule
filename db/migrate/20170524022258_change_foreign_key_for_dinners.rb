class ChangeForeignKeyForDinners < ActiveRecord::Migration[5.0]
  def change
    rename_column :dinners, :trip_id, :day_id
  end
end
