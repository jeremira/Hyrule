class Budget < ApplicationRecord
  validates :value, presence: true
  belongs_to :trip, required: false
end
