class Trip < ApplicationRecord

  validates :name,          presence: true,
                            length: { maximum: 30 }
  validates :pickup_place,  presence: true, length: { maximum: 40 }
  validates :adults,        presence: true
  belongs_to :user

  after_save :setup_trip_price

  has_one    :budget,           :dependent => :destroy
  accepts_nested_attributes_for :budget

  has_one    :rythme,           :dependent => :destroy
  accepts_nested_attributes_for :rythme

  has_one    :style,            :dependent => :destroy
  accepts_nested_attributes_for :style

  has_one    :gestion,          :dependent=>  :destroy
  has_one    :livret,           :dependent=>  :destroy

  has_many   :plannings,                      :dependent => :destroy
  has_many   :days,      through: :plannings

  def setup_trip_price
    #to change price depending of number of people, no change until 4 people
    people_weight = (self.adults + self.kids/2) - 4
    people_weight = 1 if people_weight < 1
    new_price = 9 + (people_weight + 5)
    self.days.each do |day|
      new_price = new_price + day.price
    end
    self.update_column(:price, new_price)
  end

end
