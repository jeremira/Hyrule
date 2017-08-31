class AddLivretToAssets < ActiveRecord::Migration[5.0]
  def change
    add_reference :assets, :livret, foreign_key: true
  end
end
