class Dinner < ApplicationRecord
  belongs_to :day, required: false
end
