class RemoveCommentFromRythmes < ActiveRecord::Migration[5.0]
  def change
    remove_column :rythmes, :comment
  end
end
