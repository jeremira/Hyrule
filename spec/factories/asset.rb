require 'faker'

FactoryBot.define do
  factory :asset do
    livret
    map { File.new("#{Rails.root}/spec/support/fixtures/map.jpg") }
  end
end
