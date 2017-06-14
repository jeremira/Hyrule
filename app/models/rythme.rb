class Rythme < ApplicationRecord

  validates :value,     presence: true
  validates :walking,   presence: true
  validates :transport, presence: true

  belongs_to :trip, required: false
end
