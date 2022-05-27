 User.create!(
   name: '管理人さん',
   email: 'kanrininsan@dayo.com',
   password: 'password',
   admin: 'true'
 )

10.times do |n|
  Label.create!(name: Faker::Color.color_name)
  User.create!(
    name: Faker::Creature::Animal.name,
    email: Faker::Internet.email,
    password: "password"
               )
end

10.times do |n|
  Task.create!(
    name: "task#{n+1}",
    detail: "detail#{n+1}",
    dead_line: DateTime.now,
    status: rand(1..3),
    priority: rand(1..3),
    user_id: rand(1..10)
               )
end
