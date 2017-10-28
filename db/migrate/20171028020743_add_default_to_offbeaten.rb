class AddDefaultToOffbeaten < ActiveRecord::Migration[5.0]
    def up
      change_column :rythmes, :first, :boolean, default: true
    end
    def down
      change_column :rythmes, :first, :boolean, default: nil
    end
end
