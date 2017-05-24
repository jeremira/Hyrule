class CreateStyles < ActiveRecord::Migration[5.0]
  def change
    create_table :styles do |t|
      t.references :trip, foreign_key: true
      t.boolean :culture
      t.boolean :nature
      t.boolean :sport
      t.boolean :food
      t.boolean :shopping
      t.boolean :kid
      t.text :comment

      t.timestamps
    end
  end
end
