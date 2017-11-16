require 'faker'

FactoryBot.define do
  factory :livret do
    trip
    htmlbook { File.new("#{Rails.root}/spec/support/fixtures/book.html") }
  end
end
