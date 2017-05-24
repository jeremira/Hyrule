class Hotel < ApplicationRecord
  belongs_to :trip, required: false
end
