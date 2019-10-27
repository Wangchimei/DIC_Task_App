User.create!(
  name: "example",
  email: "example@dic.com",
  password: "password",
  password_confirmation: "password",
  admin: true
)

49.times do |user|
  User.create!(
    name: Faker::Name.name,
    email: "eg-#{user+1}@dic.com",
    password: "password",
    password_confirmation: "password"
  )
end

80.times do |task|
  Task.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.sentence(word_count: 5),
    deadline: Faker::Time.forward(days: 30, period: :morning),
    status: Faker::Number.within(range: 0..2),
    priority: Faker::Number.within(range: 0..2),
    user_id: rand(1..50)
  )
end