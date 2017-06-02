require 'faker'

FactoryGirl.define do
  factory :budget do
    value 1
    comment {Faker::Company.bs}
    trip
  end
end
