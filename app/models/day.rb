class Day < ApplicationRecord
  belongs_to :theme
  has_one :planning
  has_one :trip, through: :planning
end
