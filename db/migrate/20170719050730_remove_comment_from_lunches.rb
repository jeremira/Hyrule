class RemoveCommentFromLunches < ActiveRecord::Migration[5.0]
  def change
    remove_column :lunches, :comment
  end
end
