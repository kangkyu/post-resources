class Post < ActiveRecord::Base
  has_many :comments
  has_many :posts_categories
  has_many :categories, through: :posts_categories
  belongs_to :user

  validates :title, presence: true

  has_many :votes, as: :votable
end
