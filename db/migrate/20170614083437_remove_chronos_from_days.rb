class RemoveChronosFromDays < ActiveRecord::Migration[5.0]
  def change
    remove_column :days, :chronos, :integer
  end
end
