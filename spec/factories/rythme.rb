require 'faker'

FactoryGirl.define do
  factory :rythme do
    value 1
    comment {Faker::Company.bs}
    trip
  end
end
