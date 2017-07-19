class AddDefaultValueToFirst < ActiveRecord::Migration[5.0]
  def change
    change_column :rythmes, :first, :boolean, default: false
  end
end
