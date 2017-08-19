class DeletePickupPlaceFromTrips < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :Pickup_place, :string
  end
end
