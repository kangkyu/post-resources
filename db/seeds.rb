# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([
  { username: "username string" },
  { username: "username string" },
  { username: "username string" }
])
posts = Post.create([
  { user: users.first,
    url: "www.example.com",
    title: "title string",
    description: "description text" },
  { user: users.first,
    url: "www.example.com",
    title: "title string",
    description: "description text" }
])
Comment.create([
  { user: users.first,
    post: posts.first,
    body: "comment body text" },
  { user: users.first,
    post: posts.first,
    body: "comment body text" }
])