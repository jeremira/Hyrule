class CreateRestos < ActiveRecord::Migration[5.0]
  def change
    create_table :restos do |t|
      t.references :trip, foreign_key: true
      t.boolean :lunch_todo?
      t.integer :lunch_type
      t.boolean :dinner_todo?
      t.integer :dinner_type
      t.text :comment

      t.timestamps
    end
  end
end
