class Trip < ApplicationRecord

  validates :name, presence: true

  belongs_to :user

  has_one    :budget,           :dependent => :destroy
  accepts_nested_attributes_for :budget
  has_one    :rythme,           :dependent => :destroy
  accepts_nested_attributes_for :rythme
  has_one    :style,            :dependent => :destroy
  accepts_nested_attributes_for :style

  has_many   :plannings, :dependent => :destroy
  has_many   :days,      through: :plannings


end
