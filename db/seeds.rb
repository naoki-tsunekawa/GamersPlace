# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者ユーザ作成
User.create!(name:  "Example User",
	email: "example@railstutorial.org",
	password:              "foobar",
	password_confirmation: "foobar",
	admin: true)

#サンプルユーザの作成
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
		email: email,
		password:              password,
		password_confirmation: password)
end

# # サンプルゲーム掲示板の作成
# Game.create!(title: "Sample Game Board",
# 	description: "Sample description",
# 	game_image: File.open("./public/images/600×400.png"))

# # サンプル投稿の作成
# user = User.first
# game = Game.first
# 5.times do |i|
# 	content = "sample content"
# 	Post.create!(content: "sample content", user_id: user.id, game_id: game.id)
# end

# フォロー、フォロワーのサンプルデータ作成
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
