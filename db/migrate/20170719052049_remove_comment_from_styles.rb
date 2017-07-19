class RemoveCommentFromStyles < ActiveRecord::Migration[5.0]
  def change
    remove_column :styles, :comment
  end
end
