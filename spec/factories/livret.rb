FactoryBot.define do
  factory :livret do
    trip
    htmlbook { File.new("#{Rails.root}/spec/support/fixtures/book.html") }
    #htmlbook { fixture_file_upload("#{Rails.root}/spec/support/fixtures/book.html", 'text/html') }
    trait :with_maps do
      after(:create) do |livret|
        create(:asset, livret: livret)
        create(:asset, livret: livret)
      end
    end
  end
end
