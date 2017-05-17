class Theme < ApplicationRecord

  has_many :activities, :dependent => :destroy
  has_many :day,        :dependent => :destroy

end
