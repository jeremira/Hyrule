require 'faker'

FactoryGirl.define do
  factory :day do
    date     Time.now.to_date
    comment {Faker::Company.bs}
    theme
  end
end
