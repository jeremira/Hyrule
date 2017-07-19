class AddDefaultValueToStyleOptions < ActiveRecord::Migration[5.0]
  def change
    change_column :styles, :culture,  :boolean, default: false
    change_column :styles, :nature,   :boolean, default: false
    change_column :styles, :sport,    :boolean, default: false
    change_column :styles, :food,     :boolean, default: false
    change_column :styles, :shopping, :boolean, default: false
    change_column :styles, :kid,      :boolean, default: false
  end
end
