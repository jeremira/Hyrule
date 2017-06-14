class AddDateToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :date, :date
  end
end
