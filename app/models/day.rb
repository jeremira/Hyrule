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
  validate :is_after_02_january_2018?

  after_save :update_day_price

  def update_day_price
    #price of the day :
    new_price = 20
    self.update_column(:price, new_price)
    self.trip.setup_trip_price #update his trip price
  end

  #temp check to ensure no additional booking are made before 02nd january 2018, to ensure smooth start
  def is_after_02_january_2018?
    if !date.nil?
      if date < DateTime.new(2018,01,02)
        errors.add(:date, 'de votre réservation est antérieure au 02 janvier 2018. Nous sommes navrés de ne pouvoir accepter de
        réservation pour des séjours avant le 02 Janvier 2018 suite à un nombre important de réservations.')
        return false
      end
    end
    return true
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
