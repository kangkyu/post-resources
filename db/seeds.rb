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

[ "magazine",
  "tutorial",
  "news",
  "Ruby",
  "Rails",
  "free",
  "social" ].each do |name|
    Category.find_or_create_by!(name: name)
  end

Post.delete_all
posts = Post.create!([
  { user: users.first,
    url: "www.economist.com",
    title: "Economist",
    description: "World politics, Business & finance, Economics ...",
    category_ids: [1,3] },
  { user: users.first,
    url: "thedistance.com",
    title: "The Distance",
    description: "The Distance is a magazine that spotlights longevity in business.",
    category_ids: [1] },
  { user_id: 2, url: "http://railscasts.com/", title: "Railscasts", description: "Ruby on Rails screencasts", category_ids: [4,5] },
  { user_id: 2, url: "https://www.railstutorial.org/book", title: "Rails Tutorial", description: "\"Hartl Tutorial\"\r\n\r\nThe Ruby on Rails Tutorial book...", category_ids: [2,4,5] },
  { user_id: 2, url: "gotealeaf.com", title: "Tealeaf Academy", description: "Your Last Stop Before Becoming a Confident Develope...", category_ids: [2,4] },
  { user_id: 2, url: "http://rubyweekly.com/", title: "Ruby Weekly", description: "A free, once–weekly e-mail round-up of Ruby news an..." }
])
comments = Comment.create!([
  { user: users.first,
    post: posts.first,
    body: "I used to like this magazine." },
  { user: users.first,
    post: posts.first,
    body: "I read it online." },
  { user_id: 2, post_id: 4, body: "I posted it." }
])
