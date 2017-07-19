class AddInfoToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :info, :text
  end
end
