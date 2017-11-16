class Asset < ApplicationRecord
  belongs_to :livret

  has_attached_file :map,
                     styles: { medium: "300x300" },
                     default_url: "/images/:style/missing.png"
  validates_attachment_content_type :map, content_type: /\Aimage\/.*\z/
end
