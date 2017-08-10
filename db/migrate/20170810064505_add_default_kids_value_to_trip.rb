class AddDefaultKidsValueToTrip < ActiveRecord::Migration[5.0]
    def change
      change_column :trips, :kids, :integer, default: 0
    end
end
