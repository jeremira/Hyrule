require 'faker'

FactoryGirl.define do
  factory :trip do
    name {Faker::Company.catch_phrase}
    price 999
    description {Faker::Company.bs}
    user
    status 0
    date Time.now
    comment {Faker::Company.catch_phrase}
    adults 2
    kids 0
  end
end
