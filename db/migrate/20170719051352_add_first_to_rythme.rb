class AddFirstToRythme < ActiveRecord::Migration[5.0]
  def change
    add_column :rythmes, :first, :boolean
  end
end
