class RemoveStatusFromTrips < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :status, :string
  end
end
