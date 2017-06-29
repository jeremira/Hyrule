class AddPaymentDateToGestion < ActiveRecord::Migration[5.0]
  def change
      add_column :gestions, :payment_date, :date
  end
end
