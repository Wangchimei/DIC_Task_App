FactoryBot.define do
  factory :user do
    name { "Shiba" }
    email { "shiba@dic.com" }
    password { "shibaa" }
    admin {false}
  end

  factory :other_user, class: User do
    name { "Chiitan" }
    email { "chiitan@dic.com" }
    password { "chiitan" }
    admin {true}
  end
end