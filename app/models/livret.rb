class Livret < ApplicationRecord
  belongs_to :trip

  has_attached_file :htmlbook
  validates_attachment :htmlbook, presence: true,
  content_type: { content_type: "text/html" },
  size: { in: 0..250.kilobytes }

  has_many :assets, :dependent => :destroy,  :inverse_of => :livret
  accepts_nested_attributes_for :assets

end
