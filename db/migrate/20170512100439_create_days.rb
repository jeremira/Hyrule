class CreateDays < ActiveRecord::Migration[5.0]
  def change
    create_table :days do |t|
      t.integer :chronos
      t.references :theme, foreign_key: true
      t.timestamps
    end
  end
end
