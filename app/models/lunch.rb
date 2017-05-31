class Lunch < ApplicationRecord
  belongs_to :day, required: false
end
