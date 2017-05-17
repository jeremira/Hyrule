class AddThemeToActivities < ActiveRecord::Migration[5.0]
  def change
    add_reference :activities, :theme, foreign_key: true
  end
end
