class Theme < ApplicationRecord

  #has any activities through themes_activities
  has_many :day

end
