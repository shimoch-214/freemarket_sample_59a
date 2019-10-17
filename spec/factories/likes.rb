FactoryBot.define do
  factory :like do
    association         :item, factory: :item
    association         :user, factory: :user
  end
end