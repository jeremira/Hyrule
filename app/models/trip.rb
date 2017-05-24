class Trip < ApplicationRecord
  belongs_to :user

  has_one    :budget,           :dependent => :destroy
  accepts_nested_attributes_for :budget
  has_one    :rythme,           :dependent => :destroy
  accepts_nested_attributes_for :rythme
  has_one    :style,            :dependent => :destroy
  accepts_nested_attributes_for :style
  has_one    :hotel,            :dependent => :destroy
  accepts_nested_attributes_for :hotel
  has_one    :resto,            :dependent => :destroy
  accepts_nested_attributes_for :resto

  has_many   :plannings, :dependent => :destroy
  has_many   :days,      through: :plannings


end
