require 'faker'

FactoryBot.define do
  factory :day do
    trip
    theme
    date Date.today + 1.month
  end
end
