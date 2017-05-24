class Resto < ApplicationRecord
  belongs_to :trip, required: false
end
