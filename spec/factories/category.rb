FactoryBot.define do
  factory :category do
    ancestry      { 1/2 }

    name          { Faker::Lorem.characters(number: 10) }
    price         { Faker::Number.within(range: 300..9999999) }
    description   { Faker::Lorem.characters(number: 100) }
    condition     { Faker::Number.within(range: 0..5) }
    category_id   { 3 }
    sizing_id     { 1 }
    after(:build) do |item|
      build(:transact, item: item) unless item.transact
    end
  end
end