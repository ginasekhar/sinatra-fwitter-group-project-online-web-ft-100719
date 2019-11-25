5.times do 
    user = User.create(username: Faker::FunnyName.name, email: Faker::Internet.email)
end

