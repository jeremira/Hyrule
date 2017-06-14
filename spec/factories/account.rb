require 'faker'

FactoryGirl.define do
  factory :account do
    user
    name  { Faker::Name.name }
    image { Faker::File.file_name }
    about {Faker::Company.bs}
  end
end
