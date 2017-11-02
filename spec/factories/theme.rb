require 'faker'

FactoryBot.define do
  factory :theme do
    name 'ThemeBot'
    descr 'Theme bot from Factory bot'
    image { Faker::File.file_name }
    style 'Rspec'
    gallery '001.jpg 002.jpg 003.jpg'
  end
end
