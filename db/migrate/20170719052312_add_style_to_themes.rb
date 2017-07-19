class AddStyleToThemes < ActiveRecord::Migration[5.0]
  def change
    add_column :themes, :style, :string
  end
end
