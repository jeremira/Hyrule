require 'faker'

FactoryBot.define do
  factory :theme do
    name 'default'
    descr 'Theme bot from Factory bot'
    image { Faker::File.file_name }
    style 'Rspec'
    gallery 'main001.jpg main002.jpg'
  end
end
