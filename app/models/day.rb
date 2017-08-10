class Day < ApplicationRecord
  belongs_to :theme
  has_one :planning, :dependent => :destroy
  has_one :trip, through: :planning

  has_one    :lunch,            :dependent => :destroy
  accepts_nested_attributes_for :lunch
  has_one    :dinner,            :dependent => :destroy
  accepts_nested_attributes_for :dinner

  validates :date, presence: true

  after_save :update_trip_price

  def update_trip_price
    if self.guide
      new_price = 225
    else
      new_price = 20
    end
    self.update_column(:price, new_price) #update day.price
    self.trip.setup_trip_price #update his trip price
  end

end
