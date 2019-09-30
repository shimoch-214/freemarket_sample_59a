FactoryBot.define do
  factory :transact do
    association :item, factory: :item, strategy: :build
    

    after(:build) do |instance|
      instance.item&.transact
    end
  end
end