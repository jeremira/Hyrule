class AddgoodPickupPlaceToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :pickup_place, :string
  end
end
