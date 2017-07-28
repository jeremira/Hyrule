class AddGuideToDays < ActiveRecord::Migration[5.0]
  def change
    add_column :days, :guide, :boolean, default: false
  end
end
