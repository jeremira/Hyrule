class RemoveWalkingFromRythmes < ActiveRecord::Migration[5.0]
  def change
    remove_column :rythmes, :walking
  end
end
