FactoryBot.define do
  factory :item do
    name          { Faker::Lorem.characters(number: 10) }
    price         { Faker::Number.within(range: 300..9999999) }
    description   { Faker::Lorem.characters(number: 100) }
    condition     { Faker::Number.within(range: 0..5) }
    category_id   { 3 }
    sizing_id     { 2 }
    created_at    { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
    after(:build) do |item|
      build(:transact, item: item) unless item.transact
      item.images << FactoryBot.build(:image)
    end
  end
end