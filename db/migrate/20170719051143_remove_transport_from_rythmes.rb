class RemoveTransportFromRythmes < ActiveRecord::Migration[5.0]
  def change
    remove_column :rythmes, :transport
  end
end
