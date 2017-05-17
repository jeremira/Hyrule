class Trip < ApplicationRecord
  belongs_to :user
  has_many   :plannings, :dependent => :destroy
  has_many   :days, through: :plannings
end
