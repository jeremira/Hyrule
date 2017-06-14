class AddAdultsToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :adults, :integer
  end
end
