FactoryBot.define do
  factory :sns_confirmation do
    email       { Faker::Internet.email }
    uid         { Faker::Internet.uuid }
    provider    { %w(facebook google_oauth2).sample }
    association   :user, factory: :user, strategy: :build
    after(:build) do |sns_confirmation|
      sns_confirmation.user&.sns_confirmation
    end
  end
end