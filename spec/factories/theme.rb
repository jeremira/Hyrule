require 'faker'

FactoryBot.define do
  factory :theme do
    sequence(:name) { |n| "default_test#{n}" }
    descr 'Theme bot from Factory bot'
    image 'test001.jpg'
    style 'Rspec'
    gallery 'main001.jpg main002.jpg'
  end
end
