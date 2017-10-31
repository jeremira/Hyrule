require 'faker'

FactoryBot.define do
  factory :day do
    theme
    date {(Time.now + 1.month).to_date.to_s}
  end
end
