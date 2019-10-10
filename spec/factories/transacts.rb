FactoryBot.define do
  factory :transact do
    association         :item, factory: :item, strategy: :build
    association         :seller, factory: :user, strategy: :create
    bearing             { 'seller_side' }
    delivery_method     { Faker::Number.within(range: 0..8) }
    ship_days           { Faker::Number.within(range: 0..2) }
    prefecture_id       { Faker::Number.within(range: 1..47) }
    after(:build) do |transact|
      transact.item&.transact
    end
  end
end