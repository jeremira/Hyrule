class Lunch < ApplicationRecord
  belongs_to :day, required: false

  validates :style, presence: true
end
