class AddActivityToDays < ActiveRecord::Migration[5.0]
  def change
    add_reference :days, :activity, foreign_key: true
  end
end
