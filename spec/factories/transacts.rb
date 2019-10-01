FactoryBot.define do
  factory :transact do
    association :item, factory: :item, strategy: :build
    bearing             { 'seller_side' }
    delivery_method     { Faker::Number.within(range: 0..8) }
    ship_days           { Faker::Number.within(range: 0..2) }
    prefecture_id       { Faker::Number.within(range: 1..47) }
    association         :seller, factory: :user
    after(:build) do |transact|
      transact.item&.transact
    end
  end
end