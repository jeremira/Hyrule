class AddTransportToRythmes < ActiveRecord::Migration[5.0]
  def change
    add_column :rythmes, :transport, :integer
  end
end
