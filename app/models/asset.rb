class Asset < ApplicationRecord
  belongs_to :livret

  has_attached_file :map
                     #styles: { medium: "300x300" },
                     #default_url: "/images/:style/missing.png"
  validates_attachment :map, presence: true,
                     content_type: { content_type: "image/jpeg" }
end
