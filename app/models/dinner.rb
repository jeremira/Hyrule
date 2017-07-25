class Dinner < ApplicationRecord
  belongs_to :day, required: false
  #TODO validate style if todo true, voir avec scope
end
