class Style < ApplicationRecord
  belongs_to :trip, required: false
end
