class AddAttachmentHtmlbookToLivrets < ActiveRecord::Migration
  def self.up
    change_table :livrets do |t|
      t.attachment :htmlbook
    end
  end

  def self.down
    remove_attachment :livrets, :htmlbook
  end
end
