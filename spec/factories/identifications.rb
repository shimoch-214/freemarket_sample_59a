FactoryBot.define do
  factory :identification do
    first_name       {"優香"}
    last_name        {"高橋"}
    first_name_kana   {"ユウカ"}
    last_name_kana    {"タカハシ"}
    birthday          {2000-05-01}
    association :user, factory: :user
  end
end
