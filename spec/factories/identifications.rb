FactoryBot.define do
  factory :identification do
    first_name        {"優香"}
    last_name         {"高橋"}
    first_name_kana   {"ユウカ"}
    last_name_kana    {"タカハシ"}
    birthday          { Date.today }
    association :user, factory: :user, strategy: :build
    after(:build) do |identification|
      identification.user&.identification
    end
  end
end
