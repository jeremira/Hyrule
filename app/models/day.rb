class Day < ApplicationRecord
  belongs_to :theme
  has_one :planning, :dependent => :destroy
  has_one :trip, through: :planning

  has_one    :lunch,            :dependent => :destroy
  accepts_nested_attributes_for :lunch
  has_one    :dinner,            :dependent => :destroy
  accepts_nested_attributes_for :dinner

  validates :date, presence: true

end
