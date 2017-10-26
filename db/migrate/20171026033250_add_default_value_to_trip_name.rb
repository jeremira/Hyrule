class AddDefaultValueToTripName < ActiveRecord::Migration[5.0]
  def up
    change_column :trips, :name, :string, default: 'Mon séjour à Tokyo'
  end
  def down
    change_column :trips, :name, :string, default: nil
  end

end
