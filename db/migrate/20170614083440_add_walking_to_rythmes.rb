class AddWalkingToRythmes < ActiveRecord::Migration[5.0]
  def change
    add_column :rythmes, :walking, :integer
  end
end
