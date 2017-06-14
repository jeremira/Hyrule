require 'faker'

FactoryGirl.define do
  factory :lunch do
    todo true
    style 1
    comment {Faker::Company.bs}
    day
  end
end
