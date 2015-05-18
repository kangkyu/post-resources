class Category < ActiveRecord::Base
  has_many :posts, through: :posts_categories
  has_many :posts_categories

  validates :name, presence: true, uniqueness: true
end
