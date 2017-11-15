require 'faker'

FactoryBot.define do
  factory :theme do
    name 'default'
    descr 'Theme bot from Factory bot'
    image 'test001.jpg'
    style 'Rspec'
    gallery 'main001.jpg main002.jpg'
  end
end
