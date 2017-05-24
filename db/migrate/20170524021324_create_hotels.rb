class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.references :trip, foreign_key: true
      t.boolean :todo?
      t.integer :type
      t.text :comment

      t.timestamps
    end
  end
end
