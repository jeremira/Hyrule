class Gestion < ApplicationRecord
  belongs_to :trip
  validates :status, presence: true
  #TODO, validate status to only string prevus
end
