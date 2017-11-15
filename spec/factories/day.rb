require 'faker'

FactoryBot.define do
  factory :day do
    trip
    theme { Theme.first || association(:theme) }
    date Date.today + 1.year
  end
end
