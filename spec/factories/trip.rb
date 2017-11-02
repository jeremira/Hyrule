require 'faker'

FactoryBot.define do
  factory :trip do
    user
    name  'Mon voyage à Tokyo'
    adults 3
    pickup_place 'Tokyo Inn'
  end
end
