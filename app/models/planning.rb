class Planning < ApplicationRecord
  belongs_to :day, dependent: :destroy
  belongs_to :trip
end
