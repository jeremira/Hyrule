class RemoveDateFromTrips < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :date
  end
end
