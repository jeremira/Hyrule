class Trip < ApplicationRecord
  belongs_to :user
  has_many   :plannings
  has_many   :days, through: :plannings
end
