require 'faker'

FactoryGirl.define do
  factory :style do
    culture  false
    sport    false
    food     false
    nature   false
    kid      false
    shopping false
    comment {Faker::Company.bs}
    trip
  end
end
