class ChangeColumnNameNoQuestion < ActiveRecord::Migration[5.0]
  def change
    rename_column :hotels , :todo?,        :todo
    rename_column :restos,  :lunch_todo?,  :lunch_todo
    rename_column :restos,  :dinner_todo?, :dinner_todo
  end
end
