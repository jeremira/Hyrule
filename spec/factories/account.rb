require 'faker'

FactoryBot.define do
  factory :account do
    user
    name  'John doe'
    image 'test001.jpg'
    about 'Have a wooden leg'
    age   25
    info  'Dont like riavoli'
  end
end
