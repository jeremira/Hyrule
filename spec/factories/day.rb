require 'faker'

FactoryBot.define do
  factory :day do
    trip
    theme
    date Date.today + 1.year
  end
end
