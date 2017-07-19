class AddGalleryToThemes < ActiveRecord::Migration[5.0]
  def change
    add_column :themes, :gallery, :text
  end
end
