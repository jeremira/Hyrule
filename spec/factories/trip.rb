require 'faker'

FactoryGirl.define do
  factory :trip do
    name {Faker::Company.catch_phrase}
    price 999
    description {Faker::Company.bs}
    user
  end
end
