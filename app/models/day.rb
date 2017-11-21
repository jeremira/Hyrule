class Day < ApplicationRecord
  belongs_to :theme
  has_one :planning, :dependent => :destroy
  has_one :trip, through: :planning

  has_one    :lunch,            :dependent => :destroy
  accepts_nested_attributes_for :lunch
  has_one    :dinner,            :dependent => :destroy
  accepts_nested_attributes_for :dinner

  validates :date, presence: true
  validate :is_in_more_than_14_days?

  after_save :update_day_price

  def update_day_price
    #price of the day :
    new_price = 20
    self.update_column(:price, new_price)
    self.trip.setup_trip_price #update his trip price
  end

  def is_in_more_than_14_days?
    if !date.nil?
      if date < Date.today + 14.days
        errors.add(:date, 'de votre journée ne peut être avant 15 jours.')
        return false
      end
    end
    return true
  end

end
