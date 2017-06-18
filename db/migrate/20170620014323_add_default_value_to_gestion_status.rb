class AddDefaultValueToGestionStatus < ActiveRecord::Migration[5.0]
  def change
    change_column :gestions, :status, :string, default: :new
  end
end
