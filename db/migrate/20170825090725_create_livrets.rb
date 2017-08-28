class CreateLivrets < ActiveRecord::Migration[5.0]
  def change
    create_table :livrets do |t|
      t.string :url
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
