require 'faker'

FactoryBot.define do
  factory :account do
    user
    name  { Faker::Name.name }
    image { Faker::File.file_name }
    about {Faker::Company.bs}
    age   {25}
    info  {Faker::Company.bs}
  end
end
