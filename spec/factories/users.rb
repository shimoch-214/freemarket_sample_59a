FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.name}
    email                 {Faker::Internet.email}
    password              {"yuka1234"}
    password_confirmation {"yuka1234"}
    phone_number          {"080#{rand(10000000..99999999)}"}
    
  end
end
