require 'faker'

FactoryGirl.define do
  factory :gestion do
    comment {Faker::Company.bs}
    trip
  end
end
