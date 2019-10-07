FactoryBot.define do
  password = Faker::Internet.password(min_length: 8, max_length: 128)
  factory :user do
    nickname              { Faker::Lorem.characters(number: 10) }
    email                 { Faker::Internet.email }
    password              { password }
    password_confirmation { password }
    phone_number          { "090#{Faker::Number.number(digits: 8)}" }
    after(:build) do |user|
      build(:identification, user: user) unless user.identification
      build(:address, user: user) unless user.address
    end
    trait :with_sns do
      after(:build) do |user|
        build(:sns_confirmation, user: user) unless user.sns_confirmation
      end
    end
  end
end
