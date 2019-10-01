FactoryBot.define do
  factory :item do
    price {rand(100..99999)}
    name {Faker::Games::Pokemon.name}
    category_id {grandchild_category.sample}
    sizing_id {rand(2..11)}
    brand {brand_name.sample}
    description {Faker::Creature::Animal.name}
    condition {rand(0..5)}
    created_at { Faker::Time.between(from: DateTime.now - 2, to: DateTime.now) }
  end
end