class RemoveCommentFromDinners < ActiveRecord::Migration[5.0]
  def change
    remove_column :dinners, :comment
  end
end
