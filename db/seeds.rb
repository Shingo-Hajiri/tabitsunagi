# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
User.create!(name: 'しんご',
            email: 's.h.920.49@gmail.com',
            password: 'test1234',
            password_confirmation: 'test1234')

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@sample.com"
  password = "password#{n+1}"
  User.create!(name: name,
              email: email,
              password: password,
              password_confirmation: password)
  User.all.each do |user|
    title = "sumple#{user.id}"
    body = "本文#{user.id}"
    user_id = "#{user.id}"
    Plan.create!(title: title,
                body: body,
                user_id: user_id
    )
  end
  Plan.all.each do |plan|
    store_name = "お店#{plan.id}"
    introduction = "紹介文#{plan.id}"
    plan_id = "#{plan.id}"
    Spot.create!(store_name: store_name,
                introduction: introduction,
                plan_id: plan_id
    )
  end
end