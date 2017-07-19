class RemoveDescriptionFromTrips < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :description
  end
end
