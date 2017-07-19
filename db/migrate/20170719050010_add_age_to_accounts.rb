class AddAgeToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :age, :integer
  end
end
