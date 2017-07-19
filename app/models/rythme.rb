class Rythme < ApplicationRecord
  validates :value,     presence: true
s
  belongs_to :trip, required: false
end
