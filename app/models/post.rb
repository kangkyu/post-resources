class Post < ActiveRecord::Base
  has_many :comments
  has_many :posts_categories
  has_many :categories, through: :posts_categories
  belongs_to :user
end