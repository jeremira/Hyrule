class Budget < ApplicationRecord
  belongs_to :trip, required: false
end
