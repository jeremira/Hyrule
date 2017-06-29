class AddAmountPayedToGestion < ActiveRecord::Migration[5.0]
  def change
    add_column :gestions, :amount_payed, :integer
  end
end
