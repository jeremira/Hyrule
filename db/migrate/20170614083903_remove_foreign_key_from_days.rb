class RemoveForeignKeyFromDays < ActiveRecord::Migration[5.0]
  def change
    remove_foreign_key :days, :activities
  end
end
