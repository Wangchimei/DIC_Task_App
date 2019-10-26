FactoryBot.define do
  factory :user do
    id {1}
    name { "Bob" }
    email { "bobsburger@gmail.com" }
    password { "burger" }
    admin {false}
  end
end