# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create!([
  { username: "username one",
    password: "password",
    password_confirmation: "password" },
  { username: "username two",
    password: "password",
    password_confirmation: "password" }
])
categories = Category.create!([
  { name: "magazine" },
  { name: "tutorial" },
  { name: "news" }
])
posts = Post.create!([
  { user: users.first,
    categories: [categories.first, categories.last],
    url: "www.economist.com",
    title: "Economist",
    description: "World politics, Business & finance, Economics ..." },
  { user: users.first,
    categories: [categories.first],
    url: "thedistance.com",
    title: "The Distance",
    description: "The Distance is a magazine that spotlights longevity in business." }
])
comments = Comment.create!([
  { user: users.first,
    post: posts.first,
    body: "I used to like this magazine." },
  { user: users.first,
    post: posts.first,
    body: "I read it online." }
])
