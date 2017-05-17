class Activity < ApplicationRecord
  has_one :day,     :dependent => :destroy
  belongs_to :theme
end
