User.create!
  (name: 'taro',
   email: 'taro@taro.com',
   password: 'taropass',
   password_confirmation: 'taropass',
   admin: 'true'
     )

10.times do |n|
  name = Faker::Creature::Animal.name
  email = Faker::Internet.email
  password = "password"
  User.create!
  (name: name,
   email: email,
   password: password,
   admin: 'false'
               )
end

10.times do |n|
  Label.create!(name: "Label#{n+1}")
end

10.times do |n|
  User.all.each do |user|
    user.tasks.create!(
      name: "task#{n+1}",
      detail: "detail#{n+1}",
      dead_line: DateTime.now,
      status: rand(0..2),
      priority: rand(0..2),
      user_id: user.id.rand(1..11)
                       )
  end
end
