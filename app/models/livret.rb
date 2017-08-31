class Livret < ApplicationRecord
  belongs_to :trip

  has_attached_file :htmlbook
  has_many :assets, :dependent => :destroy
  accepts_nested_attributes_for :assets

  #has many assets
  #create asset model, just attach file
  validates_attachment :htmlbook, presence: true,
  content_type: { content_type: "text/html" },
  size: { in: 0..250.kilobytes }
end
