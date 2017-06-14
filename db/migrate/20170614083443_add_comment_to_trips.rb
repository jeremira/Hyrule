class AddCommentToTrips < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :comment, :text
  end
end
