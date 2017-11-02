require 'faker'

FactoryBot.define do
  factory :user do
    email {'machin@truc.com'}
    password {'password1234'}
  end
end
