class CreatePlannings < ActiveRecord::Migration[5.0]
  def change
    create_table :plannings do |t|
      t.references :day, foreign_key: true
      t.references :trip, foreign_key: true

      t.timestamps
    end
  end
end
