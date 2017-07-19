class Gestion < ApplicationRecord
  belongs_to :trip
  validate :status, presence: true
  #TODO, validate status to only string prevus
end
