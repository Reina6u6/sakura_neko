# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

alice = User.find_or_create_by!(email: "alice@example.com") do |user|
  user.name = "Alice"
  user.password = "password"
end

alice.post_images.find_or_create_by!(title: "test") do |post_image|
  post_image.caption = "testtest"
end

bob = User.find_or_create_by!(email: "bob@example.com") do |user|
  user.name = "Bob"
  user.password = "password"
end

carol = User.find_or_create_by!(email: "carol@example.com") do |user|
  user.name = "Carol"
  user.password = "password"
end