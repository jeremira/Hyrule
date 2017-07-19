class AddOfftrackToRythme < ActiveRecord::Migration[5.0]
  def change
    add_column :rythmes, :offtrack, :boolean
  end
end
