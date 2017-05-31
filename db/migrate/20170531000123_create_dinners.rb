class CreateDinners < ActiveRecord::Migration[5.0]
  def change
    create_table :dinners do |t|
      t.references :day, foreign_key: true
      t.boolean :todo
      t.integer :style
      t.text :comment

      t.timestamps
    end
  end
end
