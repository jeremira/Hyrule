class AddCommentToDays < ActiveRecord::Migration[5.0]
  def change
    add_column :days, :comment, :text
  end
end
