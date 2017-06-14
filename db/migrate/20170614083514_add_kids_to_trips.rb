class AddKidsToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :kids, :integer
  end
end
