class Rythme < ApplicationRecord
  validates :value,     presence: true

  belongs_to :trip, required: false
end
