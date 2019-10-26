FactoryBot.define do
  factory :user do
    id { 2 }
    name { "Shiba" }
    email { "shiba@dic.com" }
    password { "shibaa" }
    admin { false }
  end

  factory :other_user, class: User do
    id { 3 }
    name { "Chiitan" }
    email { "chiitan@dic.com" }
    password { "chiitan" }
    admin { true }
  end
end