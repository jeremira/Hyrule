class AddDefaultValueToOfftrack < ActiveRecord::Migration[5.0]
  def change
    change_column :rythmes, :offtrack, :boolean, default: false
  end
end
