FactoryBot.define do
  factory :adress do
    first_name       {"優香"}
    last_name        {"高橋"}
    first_name_kana   {"ユウカ"}
    last_name_kana    {"タカハシ"}
    zip_code          {"123-4567"}
    city              {"仙台市青葉区"}
    street            {"123"}
    building          {"ハイツブラウン"}
    phone_number_sub  {"09012345678"}
    prefecture_id     {11}
    association :user, factory: :user
  end
end
