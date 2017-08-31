class AddAttachmentMapToAssets < ActiveRecord::Migration
  def self.up
    change_table :assets do |t|
      t.attachment :map
    end
  end

  def self.down
    remove_attachment :assets, :map
  end
end
