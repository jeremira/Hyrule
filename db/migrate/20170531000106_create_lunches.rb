class CreateLunches < ActiveRecord::Migration[5.0]
  def change
    create_table :lunches do |t|
      t.references :day, foreign_key: true
      t.boolean :todo
      t.integer :style
      t.text :comment

      t.timestamps
    end
  end
end
