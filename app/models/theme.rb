class Theme < ApplicationRecord

  validates :name,   presence: true,   uniqueness: true
  validates :descr,  presence: true
  validates :image,  presence: true

  has_many :day,        :dependent => :destroy

end
