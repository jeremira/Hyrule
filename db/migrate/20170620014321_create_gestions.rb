class CreateGestions < ActiveRecord::Migration[5.0]
  def change
    create_table :gestions do |t|
      t.references :trip, foreign_key: true
      t.string :status
      t.string :token
      t.text :comment

      t.timestamps
    end
  end
end
