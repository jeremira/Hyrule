require 'faker'

FactoryGirl.define do
  factory :theme do
    name   { Faker::Name.name + 'mega trip' }
    descr  { Faker::Company.bs }
    image  { Faker::File.file_name }
  end
end
